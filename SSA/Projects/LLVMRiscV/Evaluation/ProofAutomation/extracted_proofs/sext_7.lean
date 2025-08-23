   correct := by
    unfold sext_llvm_i8_to_i32 sext_riscv_i8_to_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [LLVM.sext?, PoisonOr.toOption_getSome, BitVec.shiftLeft_eq', BitVec.toNat_ofNat,
      Nat.reducePow, Nat.reduceMod, BitVec.sshiftRight_eq', PoisonOr.value_isRefinedBy_value,
      InstCombine.bv_isRefinedBy_iff]
    bv_decide
  }

