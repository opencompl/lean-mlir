  correct := by
    unfold add_llvm_nsw_nuw_flags add_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals simp

