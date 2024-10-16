
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gmulhpow2_proof
theorem shl_add_log_may_cause_poison_pr62175_with_nuw_thm (x x_1 : BitVec 8) :
  ((if 4#8 <<< x.toNat >>> x.toNat = 4#8 then none else if 8#8 ≤ x then none else some (4#8 <<< x.toNat)).bind fun a =>
      some (x_1 * a)) ⊑
    if 8#8 ≤ x + 2#8 then none else some (x_1 <<< ((x.toNat + 2) % 256)) := sorry

theorem shl_add_log_may_cause_poison_pr62175_with_nsw_thm (x x_1 : BitVec 8) :
  ((if (4#8 <<< x.toNat).sshiftRight x.toNat = 4#8 then none else if 8#8 ≤ x then none else some (4#8 <<< x.toNat)).bind
      fun a => some (x_1 * a)) ⊑
    if 8#8 ≤ x + 2#8 then none else some (x_1 <<< ((x.toNat + 2) % 256)) := sorry

