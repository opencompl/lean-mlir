   correct := by
    unfold trunc_llvm_i32_to_i8_nsw_nuw  trunc_riscv_i32_to_i8_nsw_nuw
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    all_goals
    simp only [BitVec.truncate_eq_setWidth, PoisonOr.toOption_getSome]
    bv_decide
  }

