import Blase
open BitVec

theorem width1 {v w : Nat} (x : BitVec v) :
    x.zeroExtend (min v (max v w)) = x.signExtend (min v (max v w)) := by
  bv_multi_width

theorem width2 {v w : Nat} (x : BitVec v) :
    x.signExtend (max v (min v w)) = x.zeroExtend (max v (min v w)) := by
  bv_multi_width

