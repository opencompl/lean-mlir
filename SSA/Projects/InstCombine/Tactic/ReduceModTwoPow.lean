import Lean
import Std.Tactic.BVDecide

open Lean Meta

namespace Nat

/-- Auxiliary lemma for `Nat.reduceModTwoPow` simproc. -/
theorem lt_two_pow_succ_of_lt (x y : Nat) :
    (x / 2) < 2 ^ y → x < 2 ^ (y + 1) := by
  omega

def mkLtTwoPowProof (x y : Nat) : Option Expr :=
  match y with
  | 0   => none
  | y'+1 => do
    if x = 0 then
      return mkApp (mkConst ``Nat.two_pow_pos) (toExpr y)
    else
      let h ← mkLtTwoPowProof (x / 2) y'
      return mkApp3 (mkConst ``Nat.lt_two_pow_succ_of_lt) (toExpr x) (toExpr y') h

simproc ↓ reduceModTwoPow ((_ : Nat) % 2 ^ (_ : Nat)) := fun e => do
  let_expr HMod.hMod _α _β _γ _self x rhs := e | return .continue
  let_expr HPow.hPow _α _β _γ _self _ y := rhs | return .continue
  let some xVal := x.nat? | return .continue
  let some yVal := y.nat? | return .continue

  let some ltProof := mkLtTwoPowProof xVal yVal
    | return .continue

  return .done {
    expr := x
    proof? := mkApp3 (mkConst ``Nat.mod_eq_of_lt) x rhs ltProof
  }

attribute [bv_normalize] reduceModTwoPow
