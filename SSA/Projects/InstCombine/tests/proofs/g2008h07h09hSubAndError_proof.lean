
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2008h07h09hSubAndError_proof
theorem foo_thm (x : BitVec 32) : 5#32 - x &&& 2#32 = 1#32 - x &&& 2#32 := sorry

