   correct := by
    unfold zext_llvm_i16_to_i32 zext_riscv_i16_to_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    simp only [LLVM.zext?, BitVec.truncate_eq_setWidth, PoisonOr.toOption_getSome,
      BitVec.shiftLeft_eq', BitVec.toNat_ofNat, Nat.reducePow, Nat.reduceMod,
      BitVec.ushiftRight_eq', PoisonOr.value_isRefinedBy_value, InstCombine.bv_isRefinedBy_iff]
    bv_decide
  }

