  correct := by
    unfold rem_llvm rem_riscv
    simp_peephole
    simp_alive_undef
    simp_alive_ops
    simp_riscv
    simp_alive_case_bash
    intro x x'
    simp_alive_split
    simp

