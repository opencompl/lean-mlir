
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2006h02h13hDemandedMiscompile_proof
theorem test_thm (x : BitVec 8) : (signExtend 32 x).sshiftRight 8 = signExtend 32 (x.sshiftRight 7) := by bv_compare'

