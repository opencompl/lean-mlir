  correct := by
    unfold sdiv_llvm_no_exact sdiv_riscv
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp_alive_ops
    simp_alive_case_bash
    intro x x'
    by_cases onX2 : x' = 0#64
    <;> simp [onX2]

