
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section ghighhbithsignmask_proof
theorem t0_thm (x : BitVec 64) : -x >>> 63 = x.sshiftRight 63 := sorry

theorem t0_exact_thm (x : BitVec 64) : -x >>> 63 = x.sshiftRight 63 := sorry

theorem t2_thm (x : BitVec 64) : -x.sshiftRight 63 = x >>> 63 := sorry

theorem t3_exact_thm (x : BitVec 64) : -x.sshiftRight 63 = x >>> 63 := sorry

