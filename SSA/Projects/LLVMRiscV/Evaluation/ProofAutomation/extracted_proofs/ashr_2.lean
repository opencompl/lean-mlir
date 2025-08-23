  correct := by
    unfold ashr_llvm_exact_flag ashr_riscv
    simp_peephole
    simp_riscv
    simp_alive_undef
    simp only [BitVec.ushiftRight_eq', BitVec.shiftLeft_eq', BitVec.shiftLeft_ushiftRight,
      BitVec.reduceAllOnes, ne_eq, true_and, LLVM.ashr?, Nat.cast_ofNat, BitVec.ofNat_eq_ofNat,
      ge_iff_le, BitVec.sshiftRight_eq', ite_not, Nat.sub_zero, Nat.reduceAdd, BitVec.setWidth_eq,
      BitVec.extractLsb_toNat, Nat.shiftRight_zero, tsub_zero, Nat.reducePow, BitVec.signExtend_eq]
    simp_alive_case_bash
    intro x x'
    simp_alive_split
    simp only [PoisonOr.toOption_getSome]
    rw [Nat.mod_eq_of_lt (a:= x'.toNat) (b:= 64)]
    bv_omega

