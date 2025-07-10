
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gandhcompare_proof
theorem test1_proof.test1_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (LLVM.and e (const? 32 65280)) (LLVM.and e_1 (const? 32 65280)) ⊑
    icmp IntPred.ne (LLVM.and (LLVM.xor e e_1) (const? 32 65280)) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_eq_0_and_15_add_1_proof.test_eq_0_and_15_add_1_thm_1 (e : IntW 8) :
  icmp IntPred.eq (LLVM.and (add e (const? 8 1)) (const? 8 15)) (const? 8 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 8 15)) (const? 8 15) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_ne_0_and_15_add_1_proof.test_ne_0_and_15_add_1_thm_1 (e : IntW 8) :
  icmp IntPred.ne (LLVM.and (add e (const? 8 1)) (const? 8 15)) (const? 8 0) ⊑
    icmp IntPred.ne (LLVM.and e (const? 8 15)) (const? 8 15) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_eq_0_and_15_add_3_proof.test_eq_0_and_15_add_3_thm_1 (e : IntW 8) :
  icmp IntPred.eq (LLVM.and (add e (const? 8 3)) (const? 8 15)) (const? 8 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 8 15)) (const? 8 13) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_ne_0_and_15_add_3_proof.test_ne_0_and_15_add_3_thm_1 (e : IntW 8) :
  icmp IntPred.ne (LLVM.and (add e (const? 8 3)) (const? 8 15)) (const? 8 0) ⊑
    icmp IntPred.ne (LLVM.and e (const? 8 15)) (const? 8 13) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_eq_11_and_15_add_10_proof.test_eq_11_and_15_add_10_thm_1 (e : IntW 8) :
  icmp IntPred.eq (LLVM.and (add e (const? 8 10)) (const? 8 15)) (const? 8 11) ⊑
    icmp IntPred.eq (LLVM.and e (const? 8 15)) (const? 8 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_ne_11_and_15_add_10_proof.test_ne_11_and_15_add_10_thm_1 (e : IntW 8) :
  icmp IntPred.ne (LLVM.and (add e (const? 8 10)) (const? 8 15)) (const? 8 11) ⊑
    icmp IntPred.ne (LLVM.and e (const? 8 15)) (const? 8 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
