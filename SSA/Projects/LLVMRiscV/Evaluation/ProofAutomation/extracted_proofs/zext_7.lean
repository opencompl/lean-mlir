   correct := by
    unfold zext_llvm_i8_to_i32 zext_riscv_i8_to_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    simp only [LLVM.zext?, BitVec.truncate_eq_setWidth, PoisonOr.toOption_getSome,
      BitVec.reduceSignExtend, BitVec.and_eq, BitVec.signExtend_and,
      PoisonOr.value_isRefinedBy_value, InstCombine.bv_isRefinedBy_iff]
    bv_decide
  }

