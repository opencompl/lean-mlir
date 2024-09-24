
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsdivhexacthbyhnegativehpowerhofhtwo_proof
theorem t0_thm (x : BitVec 8) : x.sdiv 224#8 = -x.sshiftRight 5 := sorry

theorem prove_exact_with_high_mask_thm (x : BitVec 8) : (x &&& 224#8).sdiv 252#8 = -(x.sshiftRight 2 &&& 248#8) := sorry

theorem prove_exact_with_high_mask_limit_thm (x : BitVec 8) : (x &&& 224#8).sdiv 224#8 = -x.sshiftRight 5 := sorry

