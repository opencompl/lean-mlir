
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gaddnegneg_proof
theorem l_thm (x x_1 x_2 : BitVec 32) : -x_2 + -x_1 + x = x - (x_2 + x_1) := sorry

