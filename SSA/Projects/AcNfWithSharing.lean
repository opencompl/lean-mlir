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
abbrev VarReaderM := ReaderT VarState MetaM

def VarStateM.run' (x : VarStateM α) (s : VarState := {}) : MetaM α :=
  StateT.run' x s

instance : MonadLift VarReaderM VarStateM where
  monadLift x s := x s >>= (pure ⟨·, s⟩)

/-! ### Implementation -/

/-- Return a list with all variable indices that have a mapping.

Note that this is always a complete sequence `0, 1, ..., (n-1)`, without skipping
numbers. -/
def getAllVarIndices : VarReaderM (List VarIndex) := fun state =>
  pure <| List.range state.varIndices.size

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
def VarStateM.varToExpr (idx : VarIndex) : VarReaderM Expr := fun { varExprs, .. } =>
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

  /-
  if `e` is application of `op` then
    recursively call with operands
  else
    increment variable index of `e`

  See AC.toACExpr.toPreExpr for inspiration
  -/

structure SharedCoefficients where
  common : CoefficientsMap := {}
  x : CoefficientsMap
  y : CoefficientsMap

/-- Given two sets of coefficients `x` and `y` (computed with the same variable
mapping), extract the shared coefficients, such that `x` (resp. `y`) is the sum of
coefficients in `common` and `x` (resp `y`) of the result. -/
def SharedCoefficients.compute (x y : CoefficientsMap) : VarReaderM SharedCoefficients := do
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
def CoefficientsMap.toExpr (coe : CoefficientsMap) (op : Expr) : VarReaderM (Option Expr) := do
  let exprs := (← readThe VarState).varExprs.toList
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
  AC.rewriteUnnormalizedRefl goal -- invoke `ac_rfl`
  instantiateMVars proof

/--
Given expressions `lhs, rhs : $ty` and `op : $ty → $ty → $ty`, where `ty : Sort $u`,
canonicalize any top-level applications of the given associative and commutative operation `op` on
both the `lhs` and the `rhs` in a way that pro
-/
def canonicalizeWithSharing (u : Level) (ty op lhs rhs : Expr) : SimpM Simp.Step := do
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

    return Simp.Step.continue <| some {
      expr := expr
      proof? := some proof
    }

simproc acNormalizeEqWithSharing (@Eq (BitVec _) (_ + _) (_ + _)) := fun e => do
  let_expr Eq _ lhs rhs := e          | return .continue

  let w ← mkFreshExprMVar (mkConst ``Nat [])          -- `w` is a metavar
  let instAdd := mkApp (mkConst ``BitVec.instAdd) w   -- instAdd is `@BitVec.instAdd ?w`
  let bv := mkApp (mkConst ``BitVec) w                -- bv is `BitVec ?w`
  let instHAdd := mkApp2 (mkConst ``instHAdd [0]) bv instAdd -- instHAdd is `instHAdd.{0} $bv $instAdd`
  let op := mkApp4 (mkConst ``HAdd.hAdd) bv bv bv instHAdd

  canonicalizeWithSharing 1 bv op lhs rhs
