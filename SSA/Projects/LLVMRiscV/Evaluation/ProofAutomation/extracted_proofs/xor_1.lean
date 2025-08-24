  {lhs := llvm_xor, rhs := xor_riscv, correct := by
    unfold llvm_xor xor_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp only [PoisonOr.toOption_getSome, BitVec.signExtend_eq, BitVec.xor_eq]
  }

