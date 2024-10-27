
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gfoldhinchofhaddhofhnothxhandhyhtohsubhxhfromhy_proof
theorem t0_thm (x x_1 : BitVec 32) : (x_1 ^^^ 4294967295#32) + x + 1#32 = x - x_1 := by bv_compare'

theorem n12_thm (x x_1 : BitVec 32) : (x_1 ^^^ 4294967295#32) + x = x + (x_1 ^^^ 4294967295#32) := by bv_compare'

