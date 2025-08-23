   correct := by
    unfold icmp_sge_llvm_i32 icmp_sge_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp only [PoisonOr.toOption_getSome, BitVec.reduceSignExtend, BitVec.xor_eq,
      BitVec.signExtend_xor]
    bv_decide
  }

