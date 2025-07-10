
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsexthand_proof
theorem fold_sext_to_and_proof.fold_sext_to_and_thm_1 (e : IntW 8) :
  icmp IntPred.eq (LLVM.and (sext 32 e) (const? 32 (-2147483647))) (const? 32 1) ⊑
    icmp IntPred.eq (LLVM.and e (const? 8 (-127))) (const? 8 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_sext_to_and1_proof.fold_sext_to_and1_thm_1 (e : IntW 8) :
  icmp IntPred.ne (LLVM.and (sext 32 e) (const? 32 (-2147483647))) (const? 32 1) ⊑
    icmp IntPred.ne (LLVM.and e (const? 8 (-127))) (const? 8 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_sext_to_and2_proof.fold_sext_to_and2_thm_1 (e : IntW 8) :
  icmp IntPred.eq (LLVM.and (sext 32 e) (const? 32 1073741826)) (const? 32 2) ⊑
    icmp IntPred.eq (LLVM.and e (const? 8 (-126))) (const? 8 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_sext_to_and3_proof.fold_sext_to_and3_thm_1 (e : IntW 8) :
  icmp IntPred.ne (LLVM.and (sext 32 e) (const? 32 1073741826)) (const? 32 2) ⊑
    icmp IntPred.ne (LLVM.and e (const? 8 (-126))) (const? 8 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_sext_to_and_wrong_proof.fold_sext_to_and_wrong_thm_1 (e : IntW 8) :
  icmp IntPred.eq (LLVM.and (sext 32 e) (const? 32 (-2147483647))) (const? 32 (-1)) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_sext_to_and_wrong2_proof.fold_sext_to_and_wrong2_thm_1 (e : IntW 8) :
  icmp IntPred.eq (LLVM.and (sext 32 e) (const? 32 (-2147483647))) (const? 32 128) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_sext_to_and_wrong3_proof.fold_sext_to_and_wrong3_thm_1 (e : IntW 8) :
  icmp IntPred.eq (LLVM.and (sext 32 e) (const? 32 128)) (const? 32 (-2147483648)) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_sext_to_and_wrong4_proof.fold_sext_to_and_wrong4_thm_1 (e : IntW 8) :
  icmp IntPred.eq (LLVM.and (sext 32 e) (const? 32 128)) (const? 32 1) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_sext_to_and_wrong5_proof.fold_sext_to_and_wrong5_thm_1 (e : IntW 8) :
  icmp IntPred.eq (LLVM.and (sext 32 e) (const? 32 (-256))) (const? 32 1) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_sext_to_and_wrong6_proof.fold_sext_to_and_wrong6_thm_1 (e : IntW 8) :
  icmp IntPred.ne (LLVM.and (sext 32 e) (const? 32 (-2147483647))) (const? 32 (-1)) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_sext_to_and_wrong7_proof.fold_sext_to_and_wrong7_thm_1 (e : IntW 8) :
  icmp IntPred.ne (LLVM.and (sext 32 e) (const? 32 (-2147483647))) (const? 32 128) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_sext_to_and_wrong8_proof.fold_sext_to_and_wrong8_thm_1 (e : IntW 8) :
  icmp IntPred.ne (LLVM.and (sext 32 e) (const? 32 128)) (const? 32 (-2147483648)) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_sext_to_and_wrong9_proof.fold_sext_to_and_wrong9_thm_1 (e : IntW 8) :
  icmp IntPred.ne (LLVM.and (sext 32 e) (const? 32 128)) (const? 32 1) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_sext_to_and_wrong10_proof.fold_sext_to_and_wrong10_thm_1 (e : IntW 8) :
  icmp IntPred.ne (LLVM.and (sext 32 e) (const? 32 (-256))) (const? 32 1) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
