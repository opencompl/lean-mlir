
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gselecthfactorize_proof
theorem logic_and_logic_or_1_proof.logic_and_logic_or_1_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e e_1 (const? 1 0)) (const? 1 1) (select e e_2 (const? 1 0)) ⊑
    select e (select e_1 (const? 1 1) e_2) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logic_and_logic_or_2_proof.logic_and_logic_or_2_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e_1 e (const? 1 0)) (const? 1 1) (select e e_2 (const? 1 0)) ⊑
    select e (select e_1 (const? 1 1) e_2) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logic_and_logic_or_3_proof.logic_and_logic_or_3_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e_1 e (const? 1 0)) (const? 1 1) (select e_2 e (const? 1 0)) ⊑
    select (select e_1 (const? 1 1) e_2) e (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logic_and_logic_or_4_proof.logic_and_logic_or_4_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e e_1 (const? 1 0)) (const? 1 1) (select e_2 e (const? 1 0)) ⊑
    select e (select e_1 (const? 1 1) e_2) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logic_and_logic_or_5_proof.logic_and_logic_or_5_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e e_2 (const? 1 0)) (const? 1 1) (select e e_1 (const? 1 0)) ⊑
    select e (select e_2 (const? 1 1) e_1) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logic_and_logic_or_6_proof.logic_and_logic_or_6_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e e_2 (const? 1 0)) (const? 1 1) (select e_1 e (const? 1 0)) ⊑
    select e (select e_2 (const? 1 1) e_1) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logic_and_logic_or_7_proof.logic_and_logic_or_7_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e_2 e (const? 1 0)) (const? 1 1) (select e_1 e (const? 1 0)) ⊑
    select (select e_2 (const? 1 1) e_1) e (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logic_and_logic_or_8_proof.logic_and_logic_or_8_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e_2 e (const? 1 0)) (const? 1 1) (select e e_1 (const? 1 0)) ⊑
    select e (select e_2 (const? 1 1) e_1) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_logic_and_logic_or_1_proof.and_logic_and_logic_or_1_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.and e e_1) (const? 1 1) (select e e_2 (const? 1 0)) ⊑
    select e (select e_1 (const? 1 1) e_2) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_logic_and_logic_or_2_proof.and_logic_and_logic_or_2_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.and e e_1) (const? 1 1) (select e_2 e (const? 1 0)) ⊑
    select e (select e_1 (const? 1 1) e_2) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_logic_and_logic_or_3_proof.and_logic_and_logic_or_3_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.and e_1 e) (const? 1 1) (select e e_2 (const? 1 0)) ⊑
    select e (select e_1 (const? 1 1) e_2) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_logic_and_logic_or_4_proof.and_logic_and_logic_or_4_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.and e_1 e) (const? 1 1) (select e_2 e (const? 1 0)) ⊑
    select e (select e_1 (const? 1 1) e_2) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_logic_and_logic_or_5_proof.and_logic_and_logic_or_5_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e e_2 (const? 1 0)) (const? 1 1) (LLVM.and e e_1) ⊑
    select e (select e_2 (const? 1 1) e_1) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_logic_and_logic_or_6_proof.and_logic_and_logic_or_6_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e_2 e (const? 1 0)) (const? 1 1) (LLVM.and e e_1) ⊑ LLVM.and e (select e_2 (const? 1 1) e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_logic_and_logic_or_7_proof.and_logic_and_logic_or_7_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e e_2 (const? 1 0)) (const? 1 1) (LLVM.and e_1 e) ⊑
    select e (select e_2 (const? 1 1) e_1) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_logic_and_logic_or_8_proof.and_logic_and_logic_or_8_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e_2 e (const? 1 0)) (const? 1 1) (LLVM.and e_1 e) ⊑ LLVM.and e (select e_2 (const? 1 1) e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_and_logic_or_1_proof.and_and_logic_or_1_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.and e e_1) (const? 1 1) (LLVM.and e e_2) ⊑ LLVM.and e (select e_1 (const? 1 1) e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_and_logic_or_2_proof.and_and_logic_or_2_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.and e e_2) (const? 1 1) (LLVM.and e_1 e) ⊑ LLVM.and e (select e_2 (const? 1 1) e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logic_or_logic_and_1_proof.logic_or_logic_and_1_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e (const? 1 1) e_1) (select e (const? 1 1) e_2) (const? 1 0) ⊑
    select e (const? 1 1) (select e_1 e_2 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logic_or_logic_and_2_proof.logic_or_logic_and_2_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e_1 (const? 1 1) e) (select e (const? 1 1) e_2) (const? 1 0) ⊑
    select e (const? 1 1) (select e_1 e_2 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logic_or_logic_and_3_proof.logic_or_logic_and_3_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e_1 (const? 1 1) e) (select e_2 (const? 1 1) e) (const? 1 0) ⊑
    select (select e_1 e_2 (const? 1 0)) (const? 1 1) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logic_or_logic_and_4_proof.logic_or_logic_and_4_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e (const? 1 1) e_1) (select e_2 (const? 1 1) e) (const? 1 0) ⊑
    select e (const? 1 1) (select e_1 e_2 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logic_or_logic_and_5_proof.logic_or_logic_and_5_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e (const? 1 1) e_2) (select e (const? 1 1) e_1) (const? 1 0) ⊑
    select e (const? 1 1) (select e_2 e_1 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logic_or_logic_and_6_proof.logic_or_logic_and_6_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e (const? 1 1) e_2) (select e_1 (const? 1 1) e) (const? 1 0) ⊑
    select e (const? 1 1) (select e_2 e_1 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logic_or_logic_and_7_proof.logic_or_logic_and_7_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e_2 (const? 1 1) e) (select e_1 (const? 1 1) e) (const? 1 0) ⊑
    select (select e_2 e_1 (const? 1 0)) (const? 1 1) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem logic_or_logic_and_8_proof.logic_or_logic_and_8_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e_2 (const? 1 1) e) (select e (const? 1 1) e_1) (const? 1 0) ⊑
    select e (const? 1 1) (select e_2 e_1 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_logic_or_logic_and_1_proof.or_logic_or_logic_and_1_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.or e e_1) (select e (const? 1 1) e_2) (const? 1 0) ⊑
    select e (const? 1 1) (select e_1 e_2 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_logic_or_logic_and_2_proof.or_logic_or_logic_and_2_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.or e e_1) (select e_2 (const? 1 1) e) (const? 1 0) ⊑
    select e (const? 1 1) (select e_1 e_2 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_logic_or_logic_and_3_proof.or_logic_or_logic_and_3_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e (const? 1 1) e_2) (LLVM.or e e_1) (const? 1 0) ⊑
    select e (const? 1 1) (select e_2 e_1 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_logic_or_logic_and_4_proof.or_logic_or_logic_and_4_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e_2 (const? 1 1) e) (LLVM.or e e_1) (const? 1 0) ⊑ LLVM.or e (select e_2 e_1 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_logic_or_logic_and_5_proof.or_logic_or_logic_and_5_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.or e_1 e) (select e (const? 1 1) e_2) (const? 1 0) ⊑
    select e (const? 1 1) (select e_1 e_2 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_logic_or_logic_and_6_proof.or_logic_or_logic_and_6_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.or e_1 e) (select e_2 (const? 1 1) e) (const? 1 0) ⊑
    select e (const? 1 1) (select e_1 e_2 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_logic_or_logic_and_7_proof.or_logic_or_logic_and_7_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e (const? 1 1) e_2) (LLVM.or e_1 e) (const? 1 0) ⊑
    select e (const? 1 1) (select e_2 e_1 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_logic_or_logic_and_8_proof.or_logic_or_logic_and_8_thm_1 (e e_1 e_2 : IntW 1) :
  select (select e_2 (const? 1 1) e) (LLVM.or e_1 e) (const? 1 0) ⊑ LLVM.or e (select e_2 e_1 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_or_logic_and_1_proof.or_or_logic_and_1_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.or e e_1) (LLVM.or e_2 e) (const? 1 0) ⊑ LLVM.or e (select e_1 e_2 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_or_logic_and_2_proof.or_or_logic_and_2_thm_1 (e e_1 e_2 : IntW 1) :
  select (LLVM.or e_2 e) (LLVM.or e e_1) (const? 1 0) ⊑ LLVM.or e (select e_2 e_1 (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
