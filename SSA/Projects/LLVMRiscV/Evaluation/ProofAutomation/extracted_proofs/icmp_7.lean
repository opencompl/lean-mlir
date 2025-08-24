   correct := by
    unfold icmp_uge_llvm_i64 icmp_uge_riscv_i64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp only [PoisonOr.toOption_getSome, BitVec.signExtend_eq, BitVec.reduceSignExtend,
      BitVec.xor_eq, BitVec.signExtend_xor]
    bv_decide
  }

