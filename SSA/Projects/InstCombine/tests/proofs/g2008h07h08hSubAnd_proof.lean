
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2008h07h08hSubAnd_proof
theorem a_thm (x : BitVec 32) : 8#32 - x &&& 7#32 = -x &&& 7#32 := by bv_compare'

