
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gcasthset_proof
theorem test5_thm (x : BitVec 16) : setWidth 16 (signExtend 32 x) &&& 15#16 = x &&& 15#16 := by bv_compare'

