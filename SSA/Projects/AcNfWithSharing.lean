import Lean

open Lean Meta

/-! ### Types -/

abbrev VarIndex := Nat

structure VarState where
  varIndices : Std.HashMap Expr VarIndex := {}
  varExprs : Array Expr := #[]

/-!
We don't verify the state manipulations, but if we would, these are the invariants:
```
structure LegalVarState extends VarState where
  h_size  : varExprs.size = varIndices.size := by omega
  h_elems : ∀ h_lt : i < varExprs.size, varIndices[varExprs[i]]? = some i
```
-/

abbrev CoefficientsMap := Std.HashMap VarIndex Nat

/-! ### VarState monadic boilerplate  -/

abbrev VarStateM  := StateT VarState MetaM

def VarStateM.run' (x : VarStateM α) (s : VarState := {}) : MetaM α :=
  StateT.run' x s

/-! ### Implementation -/

/-- Return a list with all variable indices that have a mapping.

Note that this is always a complete sequence `0, 1, ..., (n-1)`, without skipping
numbers. -/
def getAllVarIndices : VarStateM (List VarIndex) := do
  pure <| List.range (← get).varIndices.size

/-- Return the unique variable index for an expression.

Modifies the monadic state to add a new mapping and increment the index,
if needed. -/
def VarStateM.exprToVar (e : Expr) : VarStateM VarIndex := fun state =>
  -- TODO: we should consider normalizing `e` here using `AC.rewriteUnnormalized`, so that distinct
  --   atomic expressions which are equal up-to associativity and commutativity of another operator
  --   get mapped to the same variable id
  return match state.varIndices[e]? with
  | some idx => (idx, state)
  | none =>
    let { varIndices, varExprs } := state
    let nextIndex := varIndices.size
    let varIndices := varIndices.insert e nextIndex
    let varExprs := varExprs.push e
    (nextIndex, { varIndices, varExprs })

/-- Return the expression that is represented by a specific variable index. -/
def VarStateM.varToExpr (idx : VarIndex) : VarStateM Expr := do
  let { varExprs, .. } ← get
  if h : idx < varExprs.size then
    pure varExprs[idx]
  else
    throwError "internal error (this is a bug!): index {idx} out of range, \
      the current state only has {varExprs.size} variables:\n\n{varExprs}"

/-- Given a binary, associative and commutative operation `op`,
decompose expression `e` into its variable coefficients.

For example `a ⬝ b ⬝ (a ⋅ c)` will give the coefficients:
```
a => 2
b => 1
c => 1
```

Any compound expression which is not an application of the given `op`
-/
def VarStateM.computeCoefficients (op : Expr) (e : Expr) : VarStateM CoefficientsMap :=
  go {} e
where
  incrVar (coe : CoefficientsMap) (e : Expr) : VarStateM CoefficientsMap := do
    let idx ← exprToVar e
    return coe.alter idx (fun c => some <| (c.getD 0) + 1)
  go (coe : CoefficientsMap) : Expr → VarStateM CoefficientsMap
  | e@(AC.bin op' x y) => do
      if ← isDefEq op op' then
        let coe ← go coe x
        let coe ← go coe y
        return coe
      else
        incrVar coe e
  | e => incrVar coe e

structure SharedCoefficients where
  common : CoefficientsMap := {}
  x : CoefficientsMap
  y : CoefficientsMap

/-- Given two sets of coefficients `x` and `y` (computed with the same variable
mapping), extract the shared coefficients, such that `x` (resp. `y`) is the sum of
coefficients in `common` and `x` (resp `y`) of the result. -/
def SharedCoefficients.compute (x y : CoefficientsMap) : VarStateM SharedCoefficients := do
  let mut res : SharedCoefficients := { x, y }

  for idx in ← getAllVarIndices do
    match x[idx]?, y[idx]? with
    | some xCnt, some yCnt =>
        let com := min xCnt yCnt
        res := {
          common := res.common.insert idx com
          x := res.x.insert idx (xCnt - com)
          y := res.y.insert idx (yCnt - com)
        }
    | _, _ => pure ()

  return res

/-- Compute the canonical expression for a given set of coefficients. -/
def CoefficientsMap.toExpr (coe : CoefficientsMap) (op : Expr) : VarStateM (Option Expr) := do
  let exprs := (← get).varExprs.toList
  return (
    exprs.enum
    |>.flatMap (fun (idx, expr) =>
      let cnt := coe[idx]?.getD 0
      List.replicate cnt expr
    )
    |>.foldl (init := none) fun acc (expr : Expr) => match acc with
        | none => expr
        | some acc => some <| mkApp2 op acc expr)

open VarStateM Lean.Meta Lean.Elab Term

/-- Given two expressions `x, y : $ty`, where `ty : Sort $u`, which are equal
up to associativity and commutativity, construct and return a proof of `x = y`.

Uses `ac_nf` internally to contruct said proof. -/
def proveEqualityByAC (u : Level) (ty : Expr) (x y : Expr) : MetaM Expr := do
  let expectedType := mkApp3 (mkConst ``Eq [u]) ty x y
  let goal ← mkFreshMVarId
  let proof ← mkFreshExprMVarWithId goal expectedType
  -- FIXME: this will likely fail to close the goal when the operation is not
  --   actually associative and commutative. We likely want some `try`/`catch`
  --   behaviour here, with a silently ignoring `Simp.Step.continue`
  AC.rewriteUnnormalizedRefl goal -- invoke `ac_rfl`
  instantiateMVars proof

/--
Given an expression `lhs = rhs`, canonicalize top-level applications of some
associative and commutative operation  on both the `lhs` and the `rhs` such that
the final expression is:
  `$common ⋅ $lhs' = $common ⋅ $rhs'`
That is, in a way that exposes terms that are shared between the lhs and rhs.

Note that if both lhs and rhs are applications of a *different* operation, we
canonicalize according to the *left* operation, meaning we treat the entire rhs
as an atom. This is still useful, as it will pull out an occurence of the rhs
in the lhs (if present) to the front (such an occurence would be the common
expression).
-/
def canonicalizeWithSharing : Simp.Simproc := fun eq => do
  let_expr Eq _ lhs rhs := eq | return .continue
  withTraceNode  `Meta.AC (fun _ => pure m!"canonicalizeWithSharing: {eq}") <| do

  let ty ← inferType lhs
  let u ← match ← inferType ty with
    | Expr.sort u => pure u
    | tyOfTy => do
      let u ← mkFreshLevelMVar
      throwError "{ty} {← mkHasTypeButIsExpectedMsg tyOfTy (.sort u)}"

  let op ← match lhs with
    | AC.bin op _ _ => pure op
    | _             => let AC.bin op .. := rhs | return .continue
                       pure op

  -- Check that `op` is associative and commutative, so that we don't get
  -- inscrutable errors later
  let some _ ← AC.getInstance ``Std.Associative #[op] | return .continue
  let some _ ← AC.getInstance ``Std.Commutative #[op] | return .continue

  VarStateM.run' <| do
    let lCoe ← computeCoefficients op lhs
    let rCoe ← computeCoefficients op rhs
    -- FIXME: we should identify any neutral/identity elements of the operation
    --        (e.g., 0 for addition, or 1 for multiplication), and remove the
    --        corresponding coefficient

    let ⟨commonCoe, xCoe, yCoe⟩ ← SharedCoefficients.compute lCoe rCoe
    let mergeExpr : Option Expr → Option Expr → Option Expr
      | some a, some b  => some <| mkApp2 op a b
      | some e, none
      | none,   some e  => some <| e
      | none,   none    => none

    let commonExpr? : Option Expr ← commonCoe.toExpr op
    let lNew? : Option Expr ← xCoe.toExpr op
    -- It is not possible for both `commonExpr?` and `lNew?` to be none
    let some lNew := mergeExpr commonExpr? lNew? | failure

    let rNew? : Option Expr ← yCoe.toExpr op
    -- Idem; it is not possible for both `commonExpr?` and `rNew?` to be none
    let some rNew := mergeExpr commonExpr? rNew? | failure

    let lEq : Expr /- of type `$lhs = $lNew` -/ ← proveEqualityByAC 1 ty lhs lNew
    let rEq : Expr /- of type `$rhs = $rNew` -/ ← proveEqualityByAC 1 ty rhs rNew

    let expr : Expr /- `$xNew = $yNew` -/ := -- @Eq (BitVec ?w) _ _
      mkApp3 (.const ``Eq [u]) ty lNew rNew

    let proof : Expr /- of type `($x = $y) = ($xNew = $yNew)` -/ :=
      mkAppN (mkConst ``Grind.eq_congr [u])
        #[ty, lhs, rhs, lNew, rNew, lEq, rEq]

    trace[Meta.AC] "rewrote to:\n\t{expr}"
    return Simp.Step.continue <| some {
      expr := expr
      proof? := some proof
    }

def rewriteUnnormalizedWithSharing (mvarId : MVarId) : MetaM MVarId := do
  let simpCtx ← Simp.mkContext
      (simpTheorems  := {})
      (congrTheorems := (← getSimpCongrTheorems))
      (config        := Simp.neutralConfig)
  let tgt ← instantiateMVars (← mvarId.getType)
  let (res, _) ← Simp.main tgt simpCtx (methods := { post := canonicalizeWithSharing })
  applySimpResultToTarget mvarId tgt res



/-! ## Tactic Boilerplate -/

open Tactic

def acNfHypMeta (goal : MVarId) (fvarId : FVarId) : MetaM (Option MVarId) := do
  goal.withContext do
    let simpCtx ← Simp.mkContext
      (simpTheorems  := {})
      (congrTheorems := (← getSimpCongrTheorems))
      (config        := Simp.neutralConfig)
    let tgt ← instantiateMVars (← fvarId.getType)
    let (res, _) ← Simp.main tgt simpCtx (methods := { post := canonicalizeWithSharing })
    return (← applySimpResultToLocalDecl goal fvarId res false).map (·.snd)

/-- Implementation of the `ac_nf!` tactic when operating on the main goal. -/
def acNfTargetTactic : TacticM Unit :=
  liftMetaTactic1 fun goal => rewriteUnnormalizedWithSharing goal

/-- Implementation of the `ac_nf!` tactic when operating on a hypothesis. -/
def acNfHypTactic (fvarId : FVarId) : TacticM Unit :=
  liftMetaTactic1 fun goal => acNfHypMeta goal fvarId

open Lean.Parser.Tactic (location) in
elab "ac_nf!" loc?:(location)? : tactic => do
  let loc := match loc? with
  | some loc => expandLocation loc
  | none => Location.targets #[] true
  withMainContext do
    match loc with
    | Location.targets hyps target =>
      if target then acNfTargetTactic
      (← getFVarIds hyps).forM acNfHypTactic
    | Location.wildcard =>
      acNfTargetTactic
      (← (← getMainGoal).getNondepPropHyps).forM acNfHypTactic


example {x y z v : BitVec w} : x + y + z = x + y + v := by
  ac_nf!
