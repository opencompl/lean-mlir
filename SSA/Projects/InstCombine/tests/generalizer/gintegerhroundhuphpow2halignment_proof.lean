
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gintegerhroundhuphpow2halignment_proof
theorem t0_proof.t0_thm_1 (e : IntW 8) :
  select (icmp IntPred.eq (LLVM.and e (const? 8 15)) (const? 8 0)) e (LLVM.and (add e (const? 8 16)) (const? 8 (-16))) ⊑
    LLVM.and (add e (const? 8 15)) (const? 8 (-16)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_proof.t1_thm_1 (e : IntW 8) :
  select (icmp IntPred.eq (LLVM.and e (const? 8 31)) (const? 8 0)) e (LLVM.and (add e (const? 8 32)) (const? 8 (-32))) ⊑
    LLVM.and (add e (const? 8 31)) (const? 8 (-32)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t2_proof.t2_thm_1 (e : IntW 8) :
  select (icmp IntPred.eq (LLVM.and e (const? 8 15)) (const? 8 0)) e (LLVM.and (add e (const? 8 15)) (const? 8 (-16))) ⊑
    LLVM.and (add e (const? 8 15)) (const? 8 (-16)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n9_wrong_x0_proof.n9_wrong_x0_thm_1 (e e_1 : IntW 8) :
  select (icmp IntPred.eq (LLVM.and e (const? 8 15)) (const? 8 0)) e_1
      (LLVM.and (add e (const? 8 16)) (const? 8 (-16))) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 8 15)) (const? 8 0)) e_1
      (add (LLVM.and e (const? 8 (-16))) (const? 8 16)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n9_wrong_x1_proof.n9_wrong_x1_thm_1 (e e_1 : IntW 8) :
  select (icmp IntPred.eq (LLVM.and e (const? 8 15)) (const? 8 0)) e
      (LLVM.and (add e_1 (const? 8 16)) (const? 8 (-16))) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 8 15)) (const? 8 0)) e
      (add (LLVM.and e_1 (const? 8 (-16))) (const? 8 16)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n9_wrong_x2_proof.n9_wrong_x2_thm_1 (e e_1 : IntW 8) :
  select (icmp IntPred.eq (LLVM.and e_1 (const? 8 15)) (const? 8 0)) e
      (LLVM.and (add e (const? 8 16)) (const? 8 (-16))) ⊑
    select (icmp IntPred.eq (LLVM.and e_1 (const? 8 15)) (const? 8 0)) e
      (add (LLVM.and e (const? 8 (-16))) (const? 8 16)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n10_wrong_low_bit_mask_proof.n10_wrong_low_bit_mask_thm_1 (e : IntW 8) :
  select (icmp IntPred.eq (LLVM.and e (const? 8 31)) (const? 8 0)) e (LLVM.and (add e (const? 8 16)) (const? 8 (-16))) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 8 31)) (const? 8 0)) e
      (add (LLVM.and e (const? 8 (-16))) (const? 8 16)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n12_wrong_bias_proof.n12_wrong_bias_thm_1 (e : IntW 8) :
  select (icmp IntPred.eq (LLVM.and e (const? 8 15)) (const? 8 0)) e (LLVM.and (add e (const? 8 32)) (const? 8 (-16))) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 8 15)) (const? 8 0)) e
      (add (LLVM.and e (const? 8 (-16))) (const? 8 32)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n14_wrong_comparison_constant_proof.n14_wrong_comparison_constant_thm_1 (e : IntW 8) :
  select (icmp IntPred.eq (LLVM.and e (const? 8 15)) (const? 8 1)) e (LLVM.and (add e (const? 8 16)) (const? 8 (-16))) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 8 15)) (const? 8 1)) e
      (add (LLVM.and e (const? 8 (-16))) (const? 8 16)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n15_wrong_comparison_predicate_and_constant_proof.n15_wrong_comparison_predicate_and_constant_thm_1 (e : IntW 8) :
  select (icmp IntPred.ult (LLVM.and e (const? 8 15)) (const? 8 2)) e
      (LLVM.and (add e (const? 8 16)) (const? 8 (-16))) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 8 14)) (const? 8 0)) e
      (add (LLVM.and e (const? 8 (-16))) (const? 8 16)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
