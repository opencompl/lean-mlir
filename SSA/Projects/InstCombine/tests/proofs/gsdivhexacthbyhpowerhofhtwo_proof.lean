
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsdivhexacthbyhpowerhofhtwo_proof
theorem t0_thm (x : BitVec 8) : x.sdiv 32#8 = x.sshiftRight 5 := sorry

theorem shl1_nsw_thm (x x_1 : BitVec 8) :
  ((if (1#8 <<< x.toNat).sshiftRight x.toNat = 1#8 then none else if 8#8 ≤ x then none else some (1#8 <<< x.toNat)).bind
      fun a => if a = 0#8 ∨ x_1 = intMin 8 ∧ a = 255#8 then none else some (x_1.sdiv a)) ⊑
    if 8#8 ≤ x then none else some (x_1.sshiftRight x.toNat) := sorry

theorem shl1_nsw_not_exact_thm (x x_1 : BitVec 8) :
  ((if (1#8 <<< x.toNat).sshiftRight x.toNat = 1#8 then none else if 8#8 ≤ x then none else some (1#8 <<< x.toNat)).bind
      fun a => if a = 0#8 ∨ x_1 = intMin 8 ∧ a = 255#8 then none else some (x_1.sdiv a)) ⊑
    (if (1#8 <<< x.toNat).sshiftRight x.toNat = 1#8 then none
        else if 1#8 <<< x.toNat >>> x.toNat = 1#8 then none else if 8#8 ≤ x then none else some (1#8 <<< x.toNat)).bind
      fun a => if a = 0#8 ∨ x_1 = intMin 8 ∧ a = 255#8 then none else some (x_1.sdiv a) := sorry

theorem prove_exact_with_high_mask_thm (x : BitVec 8) : (x &&& 248#8).sdiv 4#8 = x.sshiftRight 2 &&& 254#8 := sorry

theorem prove_exact_with_high_mask_limit_thm (x : BitVec 8) : (x &&& 248#8).sdiv 8#8 = x.sshiftRight 3 := sorry

