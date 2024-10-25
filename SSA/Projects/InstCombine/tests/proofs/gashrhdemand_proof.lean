
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gashrhdemand_proof
theorem srem2_ashr_mask_thm (x : BitVec 32) :
  (x - x.sdiv 2#32 * 2#32).sshiftRight 31 &&& 2#32 = x - x.sdiv 2#32 * 2#32 &&& 2#32 := by bv_compare'

theorem ashr_can_be_lshr_thm (x : BitVec 32) : setWidth 16 (x.sshiftRight 16) = setWidth 16 (x >>> 16) := sorry

theorem ashr_can_be_lshr_2_thm (x : BitVec 32) :
  setWidth 32 (((setWidth 64 x ||| 4278190080#64) <<< 34).sshiftRight 32) = x <<< 2 ||| 4227858432#32 := sorry

