
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2008h07h11hRemAnd_proof
theorem a_thm (x : BitVec 32) : x - x.sdiv 8#32 * 8#32 &&& 1#32 = x &&& 1#32 := by bv_compare'

