  {lhs := udiv_llvm_no_exact, rhs := udiv_riscv, correct := by
    unfold udiv_llvm_no_exact udiv_riscv
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp_alive_ops
    simp_alive_case_bash
    intro x x'
    split
    case value.value.isTrue ht =>
      simp
    case value.value.isFalse hf =>
      simp only [PoisonOr.toOption_getSome, BitVec.signExtend_eq, BitVec.ofNat_eq_ofNat,
        BitVec.reduceNeg, BitVec.udiv_eq, PoisonOr.value_isRefinedBy_value,
        InstCombine.bv_isRefinedBy_iff, right_eq_ite_iff]
      bv_omega
  }

