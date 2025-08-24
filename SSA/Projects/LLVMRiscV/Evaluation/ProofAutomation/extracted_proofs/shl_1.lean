  correct := by
      unfold shl_llvm shl_riscv
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
        simp only [Nat.cast_ofNat, BitVec.ofNat_eq_ofNat, ge_iff_le, BitVec.not_le] at hff
        simp only [BitVec.shiftLeft_eq', Nat.sub_zero, Nat.reduceAdd, PoisonOr.toOption_getSome,
          BitVec.setWidth_eq, BitVec.extractLsb_toNat, Nat.shiftRight_zero, tsub_zero,
          Nat.reducePow, BitVec.signExtend_eq, PoisonOr.value_isRefinedBy_value,
          InstCombine.bv_isRefinedBy_iff]
        rw [Nat.mod_eq_of_lt (a:= x'.toNat) (b:= 64)]
        bv_omega

