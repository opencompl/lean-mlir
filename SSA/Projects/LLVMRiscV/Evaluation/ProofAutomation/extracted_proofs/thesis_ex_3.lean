  correct := by
    unfold llvm_sub_self_ex sub_riscv_self_ex
    simp_peephole
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_riscv
    simp_peephole
    sorry


