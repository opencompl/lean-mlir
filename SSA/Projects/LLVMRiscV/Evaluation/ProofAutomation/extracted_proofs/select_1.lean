  correct := by
    unfold select_riscv select_llvm_64
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_case_bash
    case value.poison.poison =>
      intro x
      split <;> simp
    case value.poison.value =>
      simp [PoisonOr.toOption_getSome, PoisonOr.toOption_getNone, BitVec.and_zero,
        BitVec.or_zero, PoisonOr.if_then_poison_isRefinedBy_iff, PoisonOr.value_isRefinedBy_value,
        InstCombine.bv_isRefinedBy_iff]
      bv_decide
    case value.value.poison =>
      simp
      intro x x'
      split
      · simp only [PoisonOr.value_isRefinedBy_value, InstCombine.bv_isRefinedBy_iff]
        bv_decide
      · simp
    case value.value.value =>
      intro x x' x''
      simp only [PoisonOr.ite_value_value, PoisonOr.toOption_getSome,
        PoisonOr.value_isRefinedBy_value, InstCombine.bv_isRefinedBy_iff]
      split
      · bv_decide
      · bv_decide

