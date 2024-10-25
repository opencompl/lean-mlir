
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gzeroexthandhreduce_proof
theorem test1_thm (x : BitVec 8) : setWidth 32 x &&& 65544#32 = setWidth 32 x &&& 8#32 := sorry

