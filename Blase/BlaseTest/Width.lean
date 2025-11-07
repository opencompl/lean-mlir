import Blase
open BitVec
set_option warn.sorry false

theorem width1 {v w : Nat} (x : BitVec v) :
    x.zeroExtend (min v (max v w)) = x.signExtend (min v (max v w)) := by
  bv_multi_width

theorem width2 {v w : Nat} (x : BitVec v) :
    x.signExtend (max v (min v w)) = x.zeroExtend (max v (min v w)) := by
  bv_multi_width

theorem add_incr_right (x : BitVec v) :
    x.zeroExtend (v + 2) = (x.zeroExtend (v + 1)).zeroExtend (v + 2) := by
  bv_multi_width

theorem add_incr_left (x : BitVec v) :
    x.zeroExtend (2 + v) = (x.zeroExtend (1 + v)).zeroExtend (2 + v) := by
  bv_multi_width

/-
  {
    "name": "add_assoc_1",
    "preconditions": ["(>= q t)", "(>= u t)"],
    "lhs": "(bw t ( + (bw u (+ (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( + (bw p a) (bw q (+ (bw r b) (bw s c)))))"
  },
-/
def bw (w : Nat) (x : BitVec v) : BitVec w := x.zeroExtend w

def addMax (a : BitVec v) (b : BitVec w) : BitVec (max v w) :=
   a.zeroExtend _ + b.zeroExtend _



variable (w p q r s t : Nat)
variable (a : BitVec p) (b : BitVec r) (c : BitVec s)
-- end preamble

theorem add_assoc_1 (hq : q >= t) (hu : u >= t) :
  (bw t (addMax (bw u (addMax (bw p a) (bw r b))) (bw s c)))  =
  (bw t (addMax (bw p a) (bw q (addMax (bw r b) (bw s c))))) := by
  simp only [bw, addMax]
  fail_if_success bv_multi_width
  sorry
