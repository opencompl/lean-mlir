import Lean

open Lean Meta

abbrev VarIndex := Nat

structure VarState where
  varIndices : Std.HashMap Expr VarIndex := {}
  nextIndex : VarIndex := 0

/-
  StateM S : Type → Type
  StateM S α := S -> S × α
-/

abbrev VarStateT  := StateT VarState
abbrev VarReaderT := ReaderT VarState /- VarReaderT m α = VarState → m α -/

def VarStateT.run' {m} [Functor m] (x : VarStateT m α) (s : VarState := {}) : m α :=
  /-
  let x : VarState → (α × VarState) := x
  (x s).1
  -/
  StateT.run' x s

instance [Monad m] : MonadLift (VarReaderT m) (VarStateT m) where
  monadLift x s := x s >>= (pure ⟨·, s⟩)

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

/-
The monadic version is just an abstracted version of the following signature

def VarStateT.exprToVar (state : VarState) (e : Expr) : VarState ×  VarIndex := ...
-/

abbrev Coefficients := Std.HashMap VarIndex Nat

#check AC.toACExpr.toPreExpr

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

#check BitVec.instAdd
#check @HAdd.hAdd (BitVec ?w) (BitVec ?w) (BitVec ?w) _
#check synthInstance

#synth HAdd (BitVec ?w) (BitVec ?w) (BitVec ?w)
#check instHAdd
#check @instHAdd.{0}

theorem eq_of_eq_of_eq (x y x' y' : BitVec w) (hx : x = x') (hy : y = y') :
    (x = y) = (x' = y') := by
  exact Grind.eq_congr hx hy

#check Grind.eq_congr
#print eq_of_eq_of_eq

-- example : Prop = Sort 0 := rfl
-- example : Type = Type 0 := rfl
-- example : Type = Sort 1 := rfl

-- #check (Sort 0 : Sort 1)
-- #check (Sort 0 : Type 0)
-- #check (Sort 0 : Type)

-- #check Sort

-- universe u
-- #check Sort u

-- #check List (1 = 1)

-- #check (BitVec ?w : Type 0)
-- #check (BitVec ?w : Sort 1)

-- theorem foo.{u} : Type u = Sort (u+1) := by
--   rfl

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

#check (Type : Type 1)
#check ()

#check Grind.eq_congr
#check Eq

simproc acNormalizeEqWithSharing (@Eq (BitVec _) (_ + _) (_ + _)) := fun e => do
  let_expr Eq _ x y := e          | return .continue

  let w ← mkFreshExprMVar (mkConst ``Nat [])          -- `w` is a metavar
  let instAdd := mkApp (mkConst ``BitVec.instAdd) w   -- instAdd is `@BitVec.instAdd ?w`
  let bv := mkApp (mkConst ``BitVec) w                -- bv is `BitVec ?w`
  let instHAdd := mkApp2 (mkConst ``instHAdd [0]) bv instAdd -- instHAdd is `instHAdd.{0} $bv $instAdd`

  let hAdd := mkApp4 (mkConst ``HAdd.hAdd) bv bv bv instHAdd

  VarStateT.run' <| do
    /- Now we have access to the `VarState` state, and can modify it!
        Note that VarStateT.run' gives an initial state as the empty hashmap -/
    let xCoe ← computeCoefficients hAdd x
    -- `let x ← mx` for some `mx : VarStateT`, means:
    -- `let (x, newState) := mx (currentState)`

    let yCoe ← computeCoefficients hAdd y

    let ⟨commonCoe, xCoe, yCoe⟩ := SharedCoefficients.compute xCoe yCoe

    let commonExpr : Expr ← commonCoe.toExpr
    let xNew : Expr ← xCoe.toExpr
    let xNew := mkApp2 hAdd commonExpr xNew
    let yNew : Expr ← yCoe.toExpr
    let yNew := mkApp2 hAdd commonExpr yNew

    let xEq : Expr /- of type `$x = $xNew` -/ ← proveEqualityByAC 1 bv x y
    let yEq : Expr /- of type `$y = $yNew` -/ ← proveEqualityByAC 1 bv x y

    let expr : Expr /- `$xNew = $yNew` -/ :=
      -- @Eq (BitVec ?w) _ _
      mkApp3 (.const ``Eq [1]) bv xNew yNew

    let proof : Expr /- of type `($x = $y) = ($xNew = $yNew)` -/ :=
      mkAppN (mkConst ``Grind.eq_congr [1])
        #[bv, x, y, xNew, yNew, xEq, yEq]

    return Simp.Step.continue <| some {
      expr := expr
      proof? := some proof
    }
