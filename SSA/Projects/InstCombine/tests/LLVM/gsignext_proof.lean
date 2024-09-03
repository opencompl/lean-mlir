
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsignext_proof
theorem sextinreg_thm (x : BitVec 32) : (x &&& 65535#32 ^^^ 4294934528#32) + 32768#32 = (x <<< 16).sshiftRight 16 := sorry

theorem sextinreg_alt_thm (x : BitVec 32) : (x &&& 65535#32 ^^^ 32768#32) + 4294934528#32 = (x <<< 16).sshiftRight 16 := sorry

theorem sextinreg2_thm (x : BitVec 32) : (x &&& 255#32 ^^^ 128#32) + 4294967168#32 = (x <<< 24).sshiftRight 24 := sorry

theorem ashr_thm (x : BitVec 32) : (x >>> 5 ^^^ 67108864#32) + 4227858432#32 = x.sshiftRight 5 := sorry

