
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gselect_meta_proof
theorem foo_proof.foo_thm_1 (e : IntW 32) :
  select (icmp IntPred.sgt e (const? 32 2)) (add e (const? 32 20) { «nsw» := true }) (add e (const? 32 (-20))) ⊑
    add e (select (icmp IntPred.sgt e (const? 32 2)) (const? 32 20) (const? 32 (-20))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shrink_select_proof.shrink_select_thm_1 (e : IntW 1) (e_1 : IntW 32) :
  trunc 8 (select e e_1 (const? 32 42)) ⊑ select e (trunc 8 e_1) (const? 8 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo2_proof.foo2_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.sgt e (const? 32 2)) (add e e_1 { «nsw» := true }) (sub e e_1 { «nsw» := true }) ⊑
    add e (select (icmp IntPred.sgt e (const? 32 2)) e_1 (sub (const? 32 0) e_1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_cond_proof.not_cond_thm_1 (e : IntW 1) (e_1 e_2 : IntW 32) :
  select (LLVM.xor e (const? 1 1)) e_1 e_2 ⊑ select e e_2 e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_add_proof.select_add_thm_1 (e : IntW 1) (e_1 e_2 : IntW 64) :
  select e (add e_1 e_2) e_1 ⊑ add e_1 (select e e_2 (const? 64 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_sub_proof.select_sub_thm_1 (e : IntW 1) (e_1 e_2 : IntW 17) :
  select e (sub e_1 e_2) e_1 ⊑ sub e_1 (select e e_2 (const? 17 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_ashr_proof.select_ashr_thm_1 (e : IntW 1) (e_1 e_2 : IntW 128) :
  select e (ashr e_1 e_2) e_1 ⊑ ashr e_1 (select e e_2 (const? 128 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
