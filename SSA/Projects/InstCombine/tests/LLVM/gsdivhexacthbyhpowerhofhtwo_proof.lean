
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsdivhexacthbyhpowerhofhtwo_proof
theorem t0_thm (x : BitVec 8) : x.sdiv 32#8 = x.sshiftRight 5 := sorry

theorem shl1_nsw_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (1#8 <<< x.toNat)) fun a =>
      if a = 0#8 ∨ x_1 = intMin 8 ∧ a = 255#8 then none else some (x_1.sdiv a)) ⊑
    if 8 ≤ x.toNat then none else some (x_1.sshiftRight x.toNat) := sorry

theorem prove_exact_with_high_mask_thm (x : BitVec 8) : (x &&& 248#8).sdiv 4#8 = x.sshiftRight 2 &&& 254#8 := sorry

theorem prove_exact_with_high_mask_limit_thm (x : BitVec 8) : (x &&& 248#8).sdiv 8#8 = x.sshiftRight 3 := sorry

