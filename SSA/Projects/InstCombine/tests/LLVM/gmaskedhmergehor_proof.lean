
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gmaskedhmergehor_proof
theorem n3_constmask_samemask_thm (x x_1 : BitVec 32) : x_1 &&& 65280#32 ||| x &&& 65280#32 = (x_1 ||| x) &&& 65280#32 := sorry

