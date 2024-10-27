
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gfoldhsubhofhnothtohinchofhadd_proof
theorem p0_scalar_thm (x x_1 : BitVec 32) : x_1 - (x ^^^ 4294967295#32) = x + 1#32 + x_1 := by bv_compare'

