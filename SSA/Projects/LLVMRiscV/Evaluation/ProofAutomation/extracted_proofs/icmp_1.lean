   correct := by
    unfold icmp_ugt_llvm_i64 icmp_ugt_riscv_i64
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    bv_decide
  }

