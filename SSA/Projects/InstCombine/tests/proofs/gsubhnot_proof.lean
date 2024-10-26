
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsubhnot_proof
theorem sub_not_thm (x x_1 : BitVec 8) : x_1 - x ^^^ 255#8 = x + (x_1 ^^^ 255#8) := sorry

theorem dec_sub_thm (x x_1 : BitVec 8) : x_1 - x + 255#8 = x_1 + (x ^^^ 255#8) := sorry

theorem sub_inc_thm (x x_1 : BitVec 8) : x_1 - (x + 1#8) = x_1 + (x ^^^ 255#8) := sorry

theorem sub_dec_thm (x x_1 : BitVec 8) : x_1 + 255#8 - x = x_1 + (x ^^^ 255#8) := sorry

