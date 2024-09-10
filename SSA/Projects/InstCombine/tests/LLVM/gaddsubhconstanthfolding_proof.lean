
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gaddsubhconstanthfolding_proof
theorem add_const_add_const_thm (x : BitVec 32) : x + 8#32 + 2#32 = x + 10#32 := sorry

theorem add_const_sub_const_thm (x : BitVec 32) : x + 8#32 - 2#32 = x + 6#32 := sorry

theorem add_const_const_sub_thm (x : BitVec 32) : 2#32 - (x + 8#32) = 4294967290#32 - x := sorry

theorem add_nsw_const_const_sub_nsw_thm (x : BitVec 8) : 129#8 - (x + 1#8) = 128#8 - x := sorry

theorem add_nsw_const_const_sub_thm (x : BitVec 8) : 129#8 - (x + 1#8) = 128#8 - x := sorry

theorem add_const_const_sub_nsw_thm (x : BitVec 8) : 129#8 - (x + 1#8) = 128#8 - x := sorry

theorem add_nsw_const_const_sub_nsw_ov_thm (x : BitVec 8) : 129#8 - (x + 2#8) = 127#8 - x := sorry

theorem add_nuw_const_const_sub_nuw_thm (x : BitVec 8) : 129#8 - (x + 1#8) = 128#8 - x := sorry

theorem add_nuw_const_const_sub_thm (x : BitVec 8) : 129#8 - (x + 1#8) = 128#8 - x := sorry

theorem add_const_const_sub_nuw_thm (x : BitVec 8) : 129#8 - (x + 1#8) = 128#8 - x := sorry

theorem sub_const_add_const_thm (x : BitVec 32) : x - 8#32 + 2#32 = x + 4294967290#32 := sorry

theorem sub_const_sub_const_thm (x : BitVec 32) : x - 8#32 - 2#32 = x + 4294967286#32 := sorry

theorem sub_const_const_sub_thm (x : BitVec 32) : 2#32 - (x - 8#32) = 10#32 - x := sorry

theorem const_sub_add_const_thm (x : BitVec 32) : 8#32 - x + 2#32 = 10#32 - x := sorry

theorem const_sub_sub_const_thm (x : BitVec 32) : 8#32 - x - 2#32 = 6#32 - x := sorry

theorem const_sub_const_sub_thm (x : BitVec 32) : 2#32 - (8#32 - x) = x + 4294967290#32 := sorry

theorem addsub_combine_constants_thm (x x_1 : BitVec 7) : x_1 + 42#7 + (10#7 - x) = x_1 - x + 52#7 := sorry

theorem sub_from_constant_thm (x x_1 : BitVec 5) : 10#5 - x_1 + x = x - x_1 + 10#5 := sorry

theorem sub_from_constant_commute_thm (x x_1 : BitVec 5) : x_1 * x_1 + (10#5 - x) = x_1 * x_1 - x + 10#5 := sorry

