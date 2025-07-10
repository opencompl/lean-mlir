
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsubhashrhandhtohicmphselect_proof
theorem sub_ashr_and_i8_proof.sub_ashr_and_i8_thm_1 (e e_1 : IntW 8) :
  LLVM.and (ashr (sub e_1 e { «nsw» := true }) (const? 8 7)) e ⊑ select (icmp IntPred.slt e_1 e) e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_ashr_and_i16_proof.sub_ashr_and_i16_thm_1 (e e_1 : IntW 16) :
  LLVM.and (ashr (sub e_1 e { «nsw» := true }) (const? 16 15)) e ⊑
    select (icmp IntPred.slt e_1 e) e (const? 16 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_ashr_and_i32_proof.sub_ashr_and_i32_thm_1 (e e_1 : IntW 32) :
  LLVM.and (ashr (sub e_1 e { «nsw» := true }) (const? 32 31)) e ⊑
    select (icmp IntPred.slt e_1 e) e (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_ashr_and_i64_proof.sub_ashr_and_i64_thm_1 (e e_1 : IntW 64) :
  LLVM.and (ashr (sub e_1 e { «nsw» := true }) (const? 64 63)) e ⊑
    select (icmp IntPred.slt e_1 e) e (const? 64 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_ashr_and_i32_nuw_nsw_proof.sub_ashr_and_i32_nuw_nsw_thm_1 (e e_1 : IntW 32) :
  LLVM.and (ashr (sub e_1 e { «nsw» := true, «nuw» := true }) (const? 32 31)) e ⊑
    select (icmp IntPred.slt e_1 e) e (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_ashr_and_i32_commute_proof.sub_ashr_and_i32_commute_thm_1 (e e_1 : IntW 32) :
  LLVM.and e (ashr (sub e_1 e { «nsw» := true }) (const? 32 31)) ⊑
    select (icmp IntPred.slt e_1 e) e (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
