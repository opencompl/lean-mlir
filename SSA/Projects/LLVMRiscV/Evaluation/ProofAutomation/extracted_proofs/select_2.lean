  correct := by
    unfold select_llvm_32 select_riscv_32
    simp_peephole
    simp_riscv
    simp [LLVM.select]
    simp_alive_case_bash
    case value.poison.poison =>
      intro x
      split
      · simp
      · simp
    case value.poison.value =>
      intro x x'
      split
      · simp
      · simp only [PoisonOr.toOption_getSome, PoisonOr.toOption_getNone, BitVec.reduceSignExtend,
        BitVec.and_zero, BitVec.or_zero, PoisonOr.value_isRefinedBy_value,
        InstCombine.bv_isRefinedBy_iff]
        bv_decide
    case value.value.poison =>
      intro x x'
      split
      · simp only [PoisonOr.toOption_getNone, BitVec.reduceSignExtend, PoisonOr.toOption_getSome,
        BitVec.zero_and, BitVec.zero_or, PoisonOr.value_isRefinedBy_value,
        InstCombine.bv_isRefinedBy_iff]
        bv_decide
      · simp
    case value.value.value =>
      intro x x' x''
      split
      · simp only [PoisonOr.toOption_getSome, PoisonOr.value_isRefinedBy_value,
        InstCombine.bv_isRefinedBy_iff]
        bv_decide
      · simp only [PoisonOr.toOption_getSome, PoisonOr.value_isRefinedBy_value,
        InstCombine.bv_isRefinedBy_iff]
        bv_decide

