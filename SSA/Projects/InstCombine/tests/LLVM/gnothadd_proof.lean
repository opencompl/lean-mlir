
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gnothadd_proof
theorem basic_thm (x x_1 : BitVec 8) : (x_1 ^^^ 255#8) + x ^^^ 255#8 = x_1 - x := sorry

theorem basic_com_add_thm (x x_1 : BitVec 8) : x_1 + (x ^^^ 255#8) ^^^ 255#8 = x - x_1 := sorry

theorem basic_preserve_nsw_thm (x x_1 : BitVec 8) : (x_1 ^^^ 255#8) + x ^^^ 255#8 = x_1 - x := sorry

theorem basic_preserve_nuw_thm (x x_1 : BitVec 8) : (x_1 ^^^ 255#8) + x ^^^ 255#8 = x_1 - x := sorry

theorem basic_preserve_nuw_nsw_thm (x x_1 : BitVec 8) : (x_1 ^^^ 255#8) + x ^^^ 255#8 = x_1 - x := sorry

