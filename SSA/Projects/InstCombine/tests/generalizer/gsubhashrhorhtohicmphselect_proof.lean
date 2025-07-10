
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsubhashrhorhtohicmphselect_proof
theorem sub_ashr_or_i8_proof.sub_ashr_or_i8_thm_1 (e e_1 : IntW 8) :
  LLVM.or (ashr (sub e_1 e { «nsw» := true }) (const? 8 7)) e ⊑
    select (icmp IntPred.slt e_1 e) (const? 8 (-1)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_ashr_or_i16_proof.sub_ashr_or_i16_thm_1 (e e_1 : IntW 16) :
  LLVM.or (ashr (sub e_1 e { «nsw» := true }) (const? 16 15)) e ⊑
    select (icmp IntPred.slt e_1 e) (const? 16 (-1)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_ashr_or_i32_proof.sub_ashr_or_i32_thm_1 (e e_1 : IntW 32) :
  LLVM.or (ashr (sub e_1 e { «nsw» := true }) (const? 32 31)) e ⊑
    select (icmp IntPred.slt e_1 e) (const? 32 (-1)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_ashr_or_i64_proof.sub_ashr_or_i64_thm_1 (e e_1 : IntW 64) :
  LLVM.or (ashr (sub e_1 e { «nsw» := true }) (const? 64 63)) e ⊑
    select (icmp IntPred.slt e_1 e) (const? 64 (-1)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem neg_or_ashr_i32_proof.neg_or_ashr_i32_thm_1 (e : IntW 32) :
  ashr (LLVM.or (sub (const? 32 0) e) e) (const? 32 31) ⊑ sext 32 (icmp IntPred.ne e (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_ashr_or_i32_nuw_nsw_proof.sub_ashr_or_i32_nuw_nsw_thm_1 (e e_1 : IntW 32) :
  LLVM.or (ashr (sub e_1 e { «nsw» := true, «nuw» := true }) (const? 32 31)) e ⊑
    select (icmp IntPred.slt e_1 e) (const? 32 (-1)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_ashr_or_i32_commute_proof.sub_ashr_or_i32_commute_thm_1 (e e_1 : IntW 32) :
  LLVM.or e (ashr (sub e_1 e { «nsw» := true }) (const? 32 31)) ⊑
    select (icmp IntPred.slt e_1 e) (const? 32 (-1)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem neg_or_ashr_i32_commute_proof.neg_or_ashr_i32_commute_thm_1 (e : IntW 32) :
  ashr (LLVM.or (LLVM.sdiv (const? 32 42) e) (sub (const? 32 0) (LLVM.sdiv (const? 32 42) e))) (const? 32 31) ⊑
    sext 32 (icmp IntPred.ne (LLVM.sdiv (const? 32 42) e) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
