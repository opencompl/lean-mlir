   correct := by
    unfold icmp_neq_llvm_i32 icmp_neq_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp only [PoisonOr.toOption_getSome, BitVec.xor_eq, BitVec.reduceSignExtend,
      InstCombine.bv_isRefinedBy_iff]
    bv_decide
  }

