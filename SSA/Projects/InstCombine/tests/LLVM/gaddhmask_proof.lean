
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gaddhmask_proof
theorem add_mask_ashr28_i32_thm (x : BitVec 32) : (x.sshiftRight 28 &&& 8#32) + x.sshiftRight 28 = x >>> 28 &&& 7#32 := sorry

