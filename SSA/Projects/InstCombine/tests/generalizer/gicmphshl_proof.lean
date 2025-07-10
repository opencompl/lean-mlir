
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gicmphshl_proof
theorem shl_nuw_eq_0_proof.shl_nuw_eq_0_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq (shl e e_1 { «nuw» := true }) (const? 8 0) ⊑ icmp IntPred.eq e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nsw_slt_1_proof.shl_nsw_slt_1_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.slt (shl e e_1 { «nsw» := true }) (const? 8 1) ⊑ icmp IntPred.slt e (const? 8 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nsw_sgt_n1_proof.shl_nsw_sgt_n1_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.sgt (shl e e_1 { «nsw» := true }) (const? 8 (-1)) ⊑ icmp IntPred.sgt e (const? 8 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nsw_nuw_ult_Csle0_proof.shl_nsw_nuw_ult_Csle0_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ult (shl e e_1 { «nsw» := true, «nuw» := true }) (const? 8 (-19)) ⊑
    icmp IntPred.ult e (const? 8 (-19)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nsw_ule_Csle0_fail_missing_flag_proof.shl_nsw_ule_Csle0_fail_missing_flag_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ule (shl e e_1 { «nsw» := true }) (const? 8 (-19)) ⊑
    icmp IntPred.ult (shl e e_1 { «nsw» := true }) (const? 8 (-18)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nsw_nuw_uge_Csle0_proof.shl_nsw_nuw_uge_Csle0_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.uge (shl e e_1 { «nsw» := true, «nuw» := true }) (const? 8 (-120)) ⊑
    icmp IntPred.ugt e (const? 8 (-121)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
