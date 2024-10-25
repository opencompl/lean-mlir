
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2008h05h31hAddBool_proof
theorem test_thm (x x_1 : BitVec 1) : x_1 + x = x_1 ^^^ x := by bv_compare'

