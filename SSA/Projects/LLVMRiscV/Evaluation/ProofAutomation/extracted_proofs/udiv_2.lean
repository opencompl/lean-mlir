  {lhs := udiv_llvm_exact, rhs := udiv_riscv, correct := by
    unfold udiv_llvm_exact udiv_riscv
    simp_peephole
    simp_alive_undef
    simp_riscv
    simp_alive_ops
    simp_alive_case_bash
    intro x x'
    split
    case value.value.isTrue ht =>
      split
      case isTrue ht =>
        simp
      case isFalse hf =>
        simp
    case value.value.isFalse hf =>
        simp only [BitVec.ofNat_eq_ofNat, PoisonOr.toOption_getSome, BitVec.signExtend_eq,
          BitVec.reduceNeg, BitVec.udiv_eq, PoisonOr.if_then_poison_isRefinedBy_iff,
          PoisonOr.value_isRefinedBy_value, InstCombine.bv_isRefinedBy_iff, right_eq_ite_iff]
        bv_omega
    }

