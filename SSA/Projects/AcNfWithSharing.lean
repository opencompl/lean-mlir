import Lean

open Lean Meta

/-! ### Types -/

abbrev VarIndex := Nat

structure VarState where
  varIndices : Std.HashMap Expr VarIndex := {}
  nextIndex : VarIndex := 0

abbrev Coefficients := Std.HashMap VarIndex Nat

/-! ### VarState Monad -/

abbrev VarStateT  := StateT VarState
abbrev VarReaderT := ReaderT VarState

def VarStateT.run' {m} [Functor m] (x : VarStateT m α) (s : VarState := {}) : m α :=
  StateT.run' x s

instance [Monad m] : MonadLift (VarReaderT m) (VarStateT m) where
  monadLift x s := x s >>= (pure ⟨·, s⟩)

/-! ### Implementation -/

/-- Return the unique variable index for an expression.

Modifies the monadic state to add a new mapping and increment the index,
if needed. -/
def VarStateT.exprToVar [Monad m] (e : Expr) : VarStateT m VarIndex := fun state =>
  return match state.varIndices[e]? with
  | some idx => (idx, state)
  | none =>
    let { varIndices, nextIndex } := state
    let state := {
      varIndices := varIndices.insert e nextIndex
      nextIndex := nextIndex + 1
    }
    (nextIndex, state)

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
def VarStateT.computeCoefficients [Monad m] (op : Expr) (e : Expr) : VarStateT m Coefficients := do
  sorry
  /-
  if `e` is application of `op` then
    recursively call with operands
  else
    increment variable index of `e`

  See AC.toACExpr.toPreExpr for inspiration
  -/

structure SharedCoefficients where
  common : Coefficients
  x : Coefficients
  y : Coefficients

/-- Given two sets of coefficients `x` and `y` (computed with the same variable
mapping), extract the shared coefficients, such that `x` (resp. `y`) is the sum of
coefficients in `common` and `x` (resp `y`) of the result. -/
def SharedCoefficients.compute (x y : Coefficients) : SharedCoefficients :=
  sorry

/-- Compute the canonical expression for a given set of coefficients. -/
def Coefficients.toExpr : Coefficients → VarReaderT m Expr :=
  sorry

open VarStateT Lean.Meta Lean.Elab Term

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
  VarStateT.run' <| do
    let lCoe ← computeCoefficients op lhs
    let rCoe ← computeCoefficients op rhs
    -- FIXME: we should identify any neutral/identity elements of the operation
    --        (e.g., 0 for addition, or 1 for multiplication), and remove the
    --        corresponding coefficient

    let ⟨commonCoe, xCoe, yCoe⟩ := SharedCoefficients.compute lCoe rCoe

    let commonExpr : Expr ← commonCoe.toExpr
    let lNew : Expr ← xCoe.toExpr
    let lNew := mkApp2 op commonExpr lNew
    let rNew : Expr ← yCoe.toExpr
    let rNew := mkApp2 op commonExpr rNew

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
