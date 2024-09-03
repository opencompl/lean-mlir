
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gashrhdemand_proof
theorem srem2_ashr_mask_thm (x : BitVec 32) :
  (x - x.sdiv 2#32 * 2#32).sshiftRight 31 &&& 2#32 = x - x.sdiv 2#32 * 2#32 &&& 2#32 := sorry

