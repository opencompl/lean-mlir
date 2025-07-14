import SSA.Experimental.Bits.MultiWidth.Tactic


theorem eg1 (w : Nat) (x : BitVec w) : x = x := by
  bv_multi_width
  sorry

