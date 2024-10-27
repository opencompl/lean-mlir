
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section ghighhbithsignmaskhwithhtrunc_proof
theorem t0_thm (x : BitVec 64) : -setWidth 32 (x >>> 63) = setWidth 32 (x.sshiftRight 63) := by bv_compare'

theorem t1_exact_thm (x : BitVec 64) : -setWidth 32 (x >>> 63) = setWidth 32 (x.sshiftRight 63) := by bv_compare'

theorem t2_thm (x : BitVec 64) : -setWidth 32 (x.sshiftRight 63) = setWidth 32 (x >>> 63) := by bv_compare'

theorem t3_exact_thm (x : BitVec 64) : -setWidth 32 (x.sshiftRight 63) = setWidth 32 (x >>> 63) := by bv_compare'

theorem n9_thm (x : BitVec 64) :
  some (-setWidth 32 (x >>> 62)) ⊑
    if (-signExtend 33 (setWidth 32 (x >>> 62))).msb = (-signExtend 33 (setWidth 32 (x >>> 62))).getMsbD 1 then
      some (-setWidth 32 (x >>> 62))
    else none := by bv_compare'

theorem n10_thm (x : BitVec 64) :
  some (1#32 - setWidth 32 (x >>> 63)) ⊑
    if
        (setWidth 32 (x.sshiftRight 63)).msb = false ∧
          ¬(setWidth 32 (x.sshiftRight 63) + 1#32).msb = (setWidth 32 (x.sshiftRight 63)).msb then
      none
    else some (setWidth 32 (x.sshiftRight 63) + 1#32) := by bv_compare'

