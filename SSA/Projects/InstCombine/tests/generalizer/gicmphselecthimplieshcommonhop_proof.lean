
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gicmphselecthimplieshcommonhop_proof
theorem sgt_3_impliesF_eq_2_proof.sgt_3_impliesF_eq_2_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq (select (icmp IntPred.sgt e (const? 8 3)) (const? 8 2) e_1) e ⊑
    select (icmp IntPred.slt e (const? 8 4)) (icmp IntPred.eq e_1 e) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sgt_3_impliesT_sgt_2_proof.sgt_3_impliesT_sgt_2_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.sgt (select (icmp IntPred.sgt e (const? 8 3)) (const? 8 2) e_1) e ⊑
    select (icmp IntPred.slt e (const? 8 4)) (icmp IntPred.sgt e_1 e) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sgt_x_impliesF_eq_smin_todo_proof.sgt_x_impliesF_eq_smin_todo_thm_1 (e e_1 e_2 : IntW 8) :
  icmp IntPred.eq (select (icmp IntPred.sgt e e_2) (const? 8 (-128)) e_1) e ⊑
    select (icmp IntPred.sle e e_2) (icmp IntPred.eq e_1 e) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem slt_x_impliesT_ne_smin_todo_proof.slt_x_impliesT_ne_smin_todo_thm_1 (e e_1 e_2 : IntW 8) :
  icmp IntPred.ne e (select (icmp IntPred.slt e e_2) (const? 8 127) e_1) ⊑
    select (icmp IntPred.slt e e_2) (const? 1 1) (icmp IntPred.ne e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ult_x_impliesT_eq_umax_todo_proof.ult_x_impliesT_eq_umax_todo_thm_1 (e e_1 e_2 : IntW 8) :
  icmp IntPred.ne (select (icmp IntPred.ugt e_2 e) (const? 8 (-1)) e_1) e ⊑
    select (icmp IntPred.ugt e_2 e) (const? 1 1) (icmp IntPred.ne e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ult_1_impliesF_eq_1_proof.ult_1_impliesF_eq_1_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq e (select (icmp IntPred.ult e (const? 8 1)) (const? 8 1) e_1) ⊑
    select (icmp IntPred.ne e (const? 8 0)) (icmp IntPred.eq e_1 e) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
