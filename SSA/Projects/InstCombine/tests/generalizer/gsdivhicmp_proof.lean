
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsdivhicmp_proof
theorem sdiv_exact_eq_0_proof.sdiv_exact_eq_0_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.sdiv e e_1 { «exact» := true }) (const? 8 0) ⊑ icmp IntPred.eq e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_exact_ne_0_proof.udiv_exact_ne_0_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ne (LLVM.udiv e e_1 { «exact» := true }) (const? 8 0) ⊑ icmp IntPred.ne e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv_exact_ne_1_proof.sdiv_exact_ne_1_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.sdiv e e_1 { «exact» := true }) (const? 8 0) ⊑ icmp IntPred.eq e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_exact_eq_1_proof.udiv_exact_eq_1_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ne (LLVM.udiv e e_1 { «exact» := true }) (const? 8 1) ⊑ icmp IntPred.ne e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sdiv_exact_eq_9_no_of_proof.sdiv_exact_eq_9_no_of_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq (LLVM.sdiv e (LLVM.and e_1 (const? 8 7)) { «exact» := true }) (const? 8 9) ⊑
    icmp IntPred.eq (mul (LLVM.and e_1 (const? 8 7)) (const? 8 9) { «nsw» := true, «nuw» := true }) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_exact_ne_30_no_of_proof.udiv_exact_ne_30_no_of_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ne (LLVM.udiv e (LLVM.and e_1 (const? 8 7)) { «exact» := true }) (const? 8 30) ⊑
    icmp IntPred.ne (mul (LLVM.and e_1 (const? 8 7)) (const? 8 30) { «nuw» := true }) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
