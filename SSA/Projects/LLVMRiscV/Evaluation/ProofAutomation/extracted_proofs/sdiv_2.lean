  correct := by
    unfold sdiv_llvm_exact sdiv_riscv
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp_alive_ops
    simp_alive_case_bash
    intro x x'
    by_cases onX2 : x' = 0#64 <;> simp [onX2]
    by_cases hx : x.smod x' = 0#64
    simp only [hx, ↓reduceIte, Nat.ofNat_pos, PoisonOr.if_then_poison_isRefinedBy_iff, not_and,
      PoisonOr.isRefinedBy_self, implies_true]
    split
    <;> simp

