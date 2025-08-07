   correct := by
    unfold icmp_sgt_llvm_i32 icmp_sgt_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp only [PoisonOr.toOption_getSome]
    bv_decide
  }

