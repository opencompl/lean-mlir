/-
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Siddharth Bhat

A simproc to simplify terms of the form `BitVec.ofNat (2^k) w` into `twoPow k w`.
-/
import Lean
-- import Lean.Meta.Tactic.Simp.BuitinSimprocs.BitVec
open Lean Elab Meta Simp

theorem BitVec.ofNat_eq_twoPow (w : Nat) (n : Nat) (k : Nat) (h : 2 ^ k = n) : BitVec.ofNat w n = BitVec.twoPow w k := by
  apply BitVec.eq_of_toNat_eq
  simp [h]

def canonicalizeTwoPow : Simproc := fun e => do
  let .some ⟨w, bv⟩ ← getBitVecValue? e | return .continue
  let val := bv.toNat
  if val == 0 then return .continue
  let k := val.log2
  if Nat.pow 2 k == val then
    let r : Result := { 
      expr :=  mkAppN (mkConst ``BitVec.twoPow) #[mkNatLit w, mkNatLit k],
      proof? := mkAppN (mkConst ``BitVec.ofNat_eq_twoPow) #[mkNatLit w, mkNatLit val, mkNatLit k, ← mkEqRefl (mkNatLit val)]
    }
    return .done r
  return .continue
  

-- simproc ↑ [bv_normalize] twoPowOfOfNat ((BitVec.ofNat _ _ : BitVec _)) :=
simproc ↑ twoPowOfOfNat ((BitVec.ofNat _ _ : BitVec _)) :=
  canonicalizeTwoPow

theorem eg1 : (BitVec.ofNat 8 4) = BitVec.twoPow 8 2 := by
  simp only [twoPowOfOfNat]


namespace BitVec

set_option pp.all true in
/--
We need the `hk: k < w`, since otherwise the `twoPow` function will wrap around and become a smaller division
while the shift will stay a large shift.

I tried rephrasing this as `(x >>> BitVec.ofNat w k)`, but this doesn't have the right effect either:
See that `twoPow w k` wraps around when `k ≥ w`, while `BitVec.ofNat w k` wraps around when `k ≥ 2^w`.
I think we can make these match by setting `(BitVec.ofNat w (k % w))`, but that seems even crazier
than adding a side condition. Will discuss and see what we want.
-/
theorem div_twoPow_eq {w : Nat} (x : BitVec w) (k : Nat) (hk : k < w) : x / (twoPow w k) = x >>> k := by 
  apply BitVec.eq_of_toNat_eq
  have : 2^k < 2^w := Nat.pow_lt_pow_of_lt (by decide) hk
  simp [Nat.shiftRight_eq_div_pow, Nat.mod_eq_of_lt this]
end BitVec

#check HDiv.hDiv
#check BitVec.Literal

/-- Pattern match on 'x / y' or BitVec.udiv x y -/
def getBitVecUdiv? (e : Expr) : SimpM (Option (Expr × Expr)) :=
  match_expr e with 
  | HDiv.hDiv _α _β _γ _self x y => 
     return some (x, y)
  | BitVec.udiv x y => 
     return some (x, y)
  | _ => return none

def canonicalizeDivOfTwoPow : Simproc := fun e => do
  let .some (x, y) ← getBitVecUdiv? e | return .continue
  let (w, pow) ←
    match_expr y with
    | BitVec.twoPow w pow => pure (w, pow)
    | _ => return .continue
  let .some w ← Nat.fromExpr? w | return .continue
  let .some pow ← Nat.fromExpr? pow | return .continue
  if pow ≥ w then return .continue
  -- we know w < pow (by decide)
  let rhs ← mkAppM ``HShiftRight.hShiftRight #[x, mkNatLit pow]
  let wLtPow ← mkDecideProof (← mkLt (mkNatLit pow) (mkNatLit w))
  return .done {
      expr :=  rhs
      proof? := mkAppN (mkConst ``BitVec.div_twoPow_eq) #[mkNatLit w, x, mkNatLit pow, wLtPow ]
  }

simproc ↑ udivOfTwoPow (((_ : BitVec _) / (BitVec.twoPow _ _) : BitVec _)) :=
  canonicalizeDivOfTwoPow

/-- info: 'eg1' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in #print axioms eg1
  

theorem eg2 (x : BitVec 8) : x / (BitVec.ofNat 8 4) = x >>> 2 := by
  simp only [twoPowOfOfNat, udivOfTwoPow]
