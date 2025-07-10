
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gicmphwithhselects_proof
theorem both_sides_fold_slt_proof.both_sides_fold_slt_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPred.slt (select e_1 (const? 32 9) e) (select e_1 (const? 32 1) e) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem both_sides_fold_eq_proof.both_sides_fold_eq_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPred.eq (select e_1 (const? 32 9) e) (select e_1 (const? 32 1) e) ⊑ LLVM.xor e_1 (const? 1 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem one_side_fold_slt_proof.one_side_fold_slt_thm_1 (e e_1 e_2 : IntW 32) (e_3 : IntW 1) :
  icmp IntPred.slt (select e_3 e_1 e_2) (select e_3 e e_2) ⊑ select e_3 (icmp IntPred.slt e_1 e) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem one_side_fold_sgt_proof.one_side_fold_sgt_thm_1 (e e_1 e_2 : IntW 32) (e_3 : IntW 1) :
  icmp IntPred.sgt (select e_3 e_2 e_1) (select e_3 e_2 e) ⊑
    select (LLVM.xor e_3 (const? 1 1)) (icmp IntPred.sgt e_1 e) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem one_side_fold_eq_proof.one_side_fold_eq_thm_1 (e e_1 e_2 : IntW 32) (e_3 : IntW 1) :
  icmp IntPred.eq (select e_3 e_1 e_2) (select e_3 e e_2) ⊑
    select (LLVM.xor e_3 (const? 1 1)) (const? 1 1) (icmp IntPred.eq e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
