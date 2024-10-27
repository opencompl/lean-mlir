
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsignext_proof
theorem sextinreg_thm (x : BitVec 32) : (x &&& 65535#32 ^^^ 4294934528#32) + 32768#32 = (x <<< 16).sshiftRight 16 := by bv_compare'

theorem sextinreg_alt_thm (x : BitVec 32) : (x &&& 65535#32 ^^^ 32768#32) + 4294934528#32 = (x <<< 16).sshiftRight 16 := by bv_compare'

theorem sext_thm (x : BitVec 16) : (setWidth 32 x ^^^ 32768#32) + 4294934528#32 = signExtend 32 x := by bv_compare'

theorem sextinreg2_thm (x : BitVec 32) : (x &&& 255#32 ^^^ 128#32) + 4294967168#32 = (x <<< 24).sshiftRight 24 := by bv_compare'

theorem test6_thm (x : BitVec 16) : (setWidth 32 x <<< 16).sshiftRight 16 = signExtend 32 x := by bv_compare'

theorem ashr_thm (x : BitVec 32) : (x >>> 5 ^^^ 67108864#32) + 4227858432#32 = x.sshiftRight 5 := by bv_compare'

