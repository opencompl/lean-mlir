  correct := by
    unfold or_llvm_noflag or_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    simp only [PoisonOr.toOption_getSome, BitVec.setWidth_eq, BitVec.or_eq, BitVec.signExtend_eq]


