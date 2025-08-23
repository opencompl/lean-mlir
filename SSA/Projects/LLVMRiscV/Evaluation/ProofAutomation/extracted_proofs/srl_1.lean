  correct := by
    unfold lshr_llvm_exact srl_riscv
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp_alive_ops
    simp_alive_case_bash
    intro x x'
    split
    case value.value.isTrue htt =>
        simp
    case value.value.isFalse hff =>
      split
      case isTrue ht =>
        simp
      case isFalse hf =>
        simp only [Nat.sub_zero, Nat.reduceAdd, PoisonOr.toOption_getSome, BitVec.signExtend_eq,
          PoisonOr.value_isRefinedBy_value, InstCombine.bv_isRefinedBy_iff]
        bv_decide

