   correct := by
    unfold icmp_ugt_llvm_i32 icmp_ugt_riscv_i32
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    intro x x'
    simp only [PoisonOr.toOption_getSome, BitVec.truncate_eq_setWidth, Nat.one_le_ofNat,
      BitVec.setWidth_setWidth_of_le, BitVec.setWidth_eq, InstCombine.bv_isRefinedBy_iff,
      BitVec.ofBool_eq_iff_eq]
    have hx := BitVec.isLt x
    have hx' := BitVec.isLt x'
    bv_decide
  }

