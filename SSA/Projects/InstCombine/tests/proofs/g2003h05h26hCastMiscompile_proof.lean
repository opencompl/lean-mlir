
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2003h05h26hCastMiscompile_proof
theorem test_thm (x : BitVec 64) : setWidth 64 (setWidth 32 x) = x &&& 4294967295#64 := sorry
