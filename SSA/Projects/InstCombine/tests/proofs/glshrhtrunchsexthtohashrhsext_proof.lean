
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section glshrhtrunchsexthtohashrhsext_proof
theorem t0_thm (x : BitVec 8) : signExtend 16 (setWidth 4 (x >>> 4)) = signExtend 16 (x.sshiftRight 4) := sorry

theorem t1_thm (x : BitVec 8) : signExtend 16 (setWidth 3 (x >>> 5)) = signExtend 16 (x.sshiftRight 5) := sorry

theorem t2_thm (x : BitVec 7) : signExtend 16 (setWidth 4 (x >>> 3)) = signExtend 16 (x.sshiftRight 3) := sorry

theorem same_source_shifted_signbit_thm (x : BitVec 32) : signExtend 32 (setWidth 8 (x >>> 24)) = x.sshiftRight 24 := sorry

