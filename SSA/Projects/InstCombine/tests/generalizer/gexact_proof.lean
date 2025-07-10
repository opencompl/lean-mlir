
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gexact_proof
theorem sdiv2_proof.sdiv2_thm_1 (e : IntW 32) :
  LLVM.sdiv e (const? 32 8) { «exact» := true } ⊑ ashr e (const? 32 3) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv4_proof.sdiv4_thm_1 (e : IntW 32) :
  mul (LLVM.sdiv e (const? 32 3) { «exact» := true }) (const? 32 3) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv6_proof.sdiv6_thm_1 (e : IntW 32) :
  mul (LLVM.sdiv e (const? 32 3) { «exact» := true }) (const? 32 (-3)) ⊑ sub (const? 32 0) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv1_proof.udiv1_thm_1 (e e_1 : IntW 32) : mul (LLVM.udiv e e_1 { «exact» := true }) e_1 ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv2_proof.udiv2_thm_1 (e e_1 : IntW 32) :
  LLVM.udiv e (shl (const? 32 1) e_1) { «exact» := true } ⊑ lshr e e_1 { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr1_proof.ashr1_thm_1 (e : IntW 64) :
  ashr (shl e (const? 64 8)) (const? 64 2) ⊑ ashr (shl e (const? 64 8)) (const? 64 2) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_icmp1_proof.ashr_icmp1_thm_1 (e : IntW 64) :
  icmp IntPred.eq (ashr e (const? 64 2) { «exact» := true }) (const? 64 0) ⊑ icmp IntPred.eq e (const? 64 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_icmp2_proof.ashr_icmp2_thm_1 (e : IntW 64) :
  icmp IntPred.slt (ashr e (const? 64 2) { «exact» := true }) (const? 64 4) ⊑ icmp IntPred.slt e (const? 64 16) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem pr9998_proof.pr9998_thm_1 (e : IntW 32) :
  icmp IntPred.ugt (sext 64 (ashr (shl e (const? 32 31)) (const? 32 31) { «exact» := true }))
      (const? 64 7297771788697658747) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 1)) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_icmp1_proof.udiv_icmp1_thm_1 (e : IntW 64) :
  icmp IntPred.ne (LLVM.udiv e (const? 64 5) { «exact» := true }) (const? 64 0) ⊑
    icmp IntPred.ne e (const? 64 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_icmp2_proof.udiv_icmp2_thm_1 (e : IntW 64) :
  icmp IntPred.eq (LLVM.udiv e (const? 64 5) { «exact» := true }) (const? 64 0) ⊑
    icmp IntPred.eq e (const? 64 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv_icmp1_proof.sdiv_icmp1_thm_1 (e : IntW 64) :
  icmp IntPred.eq (LLVM.sdiv e (const? 64 5) { «exact» := true }) (const? 64 0) ⊑
    icmp IntPred.eq e (const? 64 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv_icmp2_proof.sdiv_icmp2_thm_1 (e : IntW 64) :
  icmp IntPred.eq (LLVM.sdiv e (const? 64 5) { «exact» := true }) (const? 64 1) ⊑
    icmp IntPred.eq e (const? 64 5) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv_icmp3_proof.sdiv_icmp3_thm_1 (e : IntW 64) :
  icmp IntPred.eq (LLVM.sdiv e (const? 64 5) { «exact» := true }) (const? 64 (-1)) ⊑
    icmp IntPred.eq e (const? 64 (-5)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv_icmp4_proof.sdiv_icmp4_thm_1 (e : IntW 64) :
  icmp IntPred.eq (LLVM.sdiv e (const? 64 (-5)) { «exact» := true }) (const? 64 0) ⊑
    icmp IntPred.eq e (const? 64 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv_icmp5_proof.sdiv_icmp5_thm_1 (e : IntW 64) :
  icmp IntPred.eq (LLVM.sdiv e (const? 64 (-5)) { «exact» := true }) (const? 64 1) ⊑
    icmp IntPred.eq e (const? 64 (-5)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv_icmp6_proof.sdiv_icmp6_thm_1 (e : IntW 64) :
  icmp IntPred.eq (LLVM.sdiv e (const? 64 (-5)) { «exact» := true }) (const? 64 (-1)) ⊑
    icmp IntPred.eq e (const? 64 5) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem mul_of_udiv_proof.mul_of_udiv_thm_1 (e : IntW 8) :
  mul (LLVM.udiv e (const? 8 12) { «exact» := true }) (const? 8 6) ⊑ lshr e (const? 8 1) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem mul_of_sdiv_proof.mul_of_sdiv_thm_1 (e : IntW 8) :
  mul (LLVM.sdiv e (const? 8 12) { «exact» := true }) (const? 8 (-6)) ⊑
    sub (const? 8 0) (ashr e (const? 8 1) { «exact» := true }) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem mul_of_udiv_fail_bad_remainder_proof.mul_of_udiv_fail_bad_remainder_thm_1 (e : IntW 8) :
  mul (LLVM.udiv e (const? 8 11) { «exact» := true }) (const? 8 6) ⊑
    mul (LLVM.udiv e (const? 8 11) { «exact» := true }) (const? 8 6) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem mul_of_sdiv_fail_ub_proof.mul_of_sdiv_fail_ub_thm_1 (e : IntW 8) :
  mul (LLVM.sdiv e (const? 8 6) { «exact» := true }) (const? 8 (-6)) ⊑ sub (const? 8 0) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
