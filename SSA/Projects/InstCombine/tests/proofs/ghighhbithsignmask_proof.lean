
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section ghighhbithsignmask_proof
theorem t0_thm (x : BitVec 64) : -x >>> 63 = x.sshiftRight 63 := by bv_compare'

theorem t0_exact_thm (x : BitVec 64) : -x >>> 63 = x.sshiftRight 63 := by bv_compare'

theorem t2_thm (x : BitVec 64) : -x.sshiftRight 63 = x >>> 63 := by bv_compare'

theorem t3_exact_thm (x : BitVec 64) : -x.sshiftRight 63 = x >>> 63 := by bv_compare'

theorem n9_thm (x : BitVec 64) :
  some (-x >>> 62) ⊑
    if (-signExtend 65 (x >>> 62)).msb = (-signExtend 65 (x >>> 62)).getMsbD 1 then some (-x >>> 62) else none := by bv_compare'

