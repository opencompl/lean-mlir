  correct := by
    unfold llvm_sub_nuw sub_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    simp

