
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsubhfromhsub_proof
theorem t0_thm (x x_1 x_2 : BitVec 8) : x_2 - x_1 - x = x_2 - (x_1 + x) := sorry

theorem t1_flags_thm (x x_1 x_2 : BitVec 8) : x_2 - x_1 - x = x_2 - (x_1 + x) := sorry

theorem t1_flags_nuw_only_thm (x x_1 x_2 : BitVec 8) : x_2 - x_1 - x = x_2 - (x_1 + x) := sorry

theorem t1_flags_sub_nsw_sub_thm (x x_1 x_2 : BitVec 8) : x_2 - x_1 - x = x_2 - (x_1 + x) := sorry

theorem t1_flags_nuw_first_thm (x x_1 x_2 : BitVec 8) : x_2 - x_1 - x = x_2 - (x_1 + x) := sorry

theorem t1_flags_nuw_second_thm (x x_1 x_2 : BitVec 8) : x_2 - x_1 - x = x_2 - (x_1 + x) := sorry

theorem t1_flags_nuw_nsw_first_thm (x x_1 x_2 : BitVec 8) : x_2 - x_1 - x = x_2 - (x_1 + x) := sorry

theorem t1_flags_nuw_nsw_second_thm (x x_1 x_2 : BitVec 8) : x_2 - x_1 - x = x_2 - (x_1 + x) := sorry

theorem t3_c0_thm (x x_1 : BitVec 8) : 42#8 - x_1 - x = 42#8 - (x_1 + x) := sorry

theorem t4_c1_thm (x : BitVec 8) : x - 42#8 = x + 214#8 := sorry

theorem t5_c2_thm (x x_1 : BitVec 8) : x_1 - x - 42#8 = x_1 - x + 214#8 := sorry

theorem t9_c0_c2_thm (x : BitVec 8) : 42#8 - x - 24#8 = 18#8 - x := sorry

theorem t10_c1_c2_thm (x : BitVec 8) : x - 42#8 - 24#8 = x + 190#8 := sorry

