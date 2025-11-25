import Blase
open BitVec

-- Qualitative examples for testing generalization capabilities.

namespace one

theorem fixed : ∀ (x : BitVec 4) (y : BitVec 7),
  (signExtend 25 y = signExtend 25 x) ↔ (y = signExtend 7 x) := by
    intros; bv_decide

theorem generic (p q r : Nat) (hpq : p ≤ q) (hpr : p ≤ r) (hqr : q ≤ r) : 
    ∀ (x : BitVec p) (y : BitVec q),
  (signExtend r y = signExtend r x) ↔ (y = signExtend q x) := by
    sorry -- intros; bv_multi_width
end one


namespace two
theorem fixed (x : BitVec 32) : 
    BitVec.signExtend 34 (BitVec.zeroExtend 33 x) = BitVec.zeroExtend 34 x := by
  bv_decide

theorem generic (x : BitVec w) (w2 w3 : Nat) (h1 : w  < w2) (h2 : w2 ≤ w3) :
   BitVec.signExtend w3 (BitVec.zeroExtend w2 x) = BitVec.zeroExtend w3 x  := by 
  bv_multi_width
end two

namespace three
theorem fixed (x : BitVec 4) (y : BitVec 7) : 
    (BitVec.signExtend 32 x < BitVec.signExtend 32 y) ↔ (BitVec.signExtend 7 x < y) := by
  bv_decide

theorem generic (p q r : Nat)  (hpq : p ≤ q) (hpr : p ≤ r) (hqr : q ≤ r) 
    (x : BitVec p) (y : BitVec q):
   (BitVec.signExtend r x < BitVec.signExtend r y) ↔ BitVec.signExtend q x < y := by
  sorry --bv_multi_width
end three

namespace four
theorem fixed (x : BitVec 8) :
    BitVec.sle (1024#32) (x.signExtend 32) = false := by
  bv_decide

theorem generic {p q r : Nat}
    (x : BitVec p) (hpq : p < q) (hqr : q < r) :
    BitVec.sle (twoPow r q) (x.signExtend r) = false := by
  -- | We claim to find a counter-example, but this is weird?
  sorry -- bv_multi_width
end four

namespace five
theorem fixed : ∀ (x : BitVec 5) (x_1 : BitVec 17),
    x_1 - zeroExtend 17 x &&& 31#17 = zeroExtend 17 (truncate 5 x_1 - x) := by
  intros; bv_decide

theorem generic : ∀ (x : BitVec w5) (x_1 : BitVec w17),
    x_1 - zeroExtend w17 x &&& twoPow w17 w5 = zeroExtend w17 (truncate w5 x_1 - x) := by
  intros;
  /-
  CEX: Found exact counter-example at iteration 0 for predicate 'x_1✝ + (~~~setWidth w17 x✝ + 1#w17) &&&
      setWidth w17 (~~~1#w5 + 1#w5) + 1#w17 =
    setWidth w17 (setWidth w5 x_1✝ + (~~~x✝ + 1#w5))'
  -/
  sorry
  -- bv_multi_width
end five

