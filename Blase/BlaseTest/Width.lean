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
  fail_if_success bv_multi_width
  sorry

theorem add_incr_left (x : BitVec v) : 
    x.zeroExtend (2 + v) = (x.zeroExtend (1 + v)).zeroExtend (2 + v) := by
  fail_if_success bv_multi_width
  sorry

