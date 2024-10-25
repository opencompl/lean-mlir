
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gtrunchshifthtrunc_proof
theorem trunc_lshr_trunc_thm (x : BitVec 64) : setWidth 8 (setWidth 32 x >>> 8) = setWidth 8 (x >>> 8) := sorry

theorem trunc_ashr_trunc_thm (x : BitVec 64) : setWidth 8 ((setWidth 32 x).sshiftRight 8) = setWidth 8 (x >>> 8) := sorry

theorem trunc_ashr_trunc_exact_thm (x : BitVec 64) : setWidth 8 ((setWidth 32 x).sshiftRight 8) = setWidth 8 (x >>> 8) := sorry

