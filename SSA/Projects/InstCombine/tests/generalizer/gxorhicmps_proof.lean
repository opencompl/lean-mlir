
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gxorhicmps_proof
theorem slt_zero_proof.slt_zero_thm_1 (e e_1 : IntW 4) :
  LLVM.xor (icmp IntPred.slt e (const? 4 0)) (icmp IntPred.slt e_1 (const? 4 0)) ⊑
    icmp IntPred.slt (LLVM.xor e e_1) (const? 4 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sgt_minus1_proof.sgt_minus1_thm_1 (e e_1 : IntW 4) :
  LLVM.xor (icmp IntPred.sgt e (const? 4 (-1))) (icmp IntPred.sgt e_1 (const? 4 (-1))) ⊑
    icmp IntPred.slt (LLVM.xor e e_1) (const? 4 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem slt_zero_sgt_minus1_proof.slt_zero_sgt_minus1_thm_1 (e e_1 : IntW 4) :
  LLVM.xor (icmp IntPred.slt e (const? 4 0)) (icmp IntPred.sgt e_1 (const? 4 (-1))) ⊑
    icmp IntPred.sgt (LLVM.xor e e_1) (const? 4 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test13_proof.test13_thm_1 (e e_1 : IntW 8) :
  LLVM.xor (icmp IntPred.ult e e_1) (icmp IntPred.ugt e e_1) ⊑ icmp IntPred.ne e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test14_proof.test14_thm_1 (e e_1 : IntW 8) :
  LLVM.xor (icmp IntPred.eq e e_1) (icmp IntPred.ne e_1 e) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_icmp_true_signed_proof.xor_icmp_true_signed_thm_1 (e : IntW 32) :
  LLVM.xor (icmp IntPred.sgt e (const? 32 5)) (icmp IntPred.slt e (const? 32 6)) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_icmp_true_signed_commuted_proof.xor_icmp_true_signed_commuted_thm_1 (e : IntW 32) :
  LLVM.xor (icmp IntPred.slt e (const? 32 6)) (icmp IntPred.sgt e (const? 32 5)) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_icmp_true_unsigned_proof.xor_icmp_true_unsigned_thm_1 (e : IntW 32) :
  LLVM.xor (icmp IntPred.ugt e (const? 32 5)) (icmp IntPred.ult e (const? 32 6)) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_icmp_to_ne_proof.xor_icmp_to_ne_thm_1 (e : IntW 32) :
  LLVM.xor (icmp IntPred.sgt e (const? 32 4)) (icmp IntPred.slt e (const? 32 6)) ⊑
    icmp IntPred.ne e (const? 32 5) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_icmp_to_icmp_add_proof.xor_icmp_to_icmp_add_thm_1 (e : IntW 32) :
  LLVM.xor (icmp IntPred.sgt e (const? 32 3)) (icmp IntPred.slt e (const? 32 6)) ⊑
    icmp IntPred.ult (add e (const? 32 (-6))) (const? 32 (-2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_icmp_invalid_range_proof.xor_icmp_invalid_range_thm_1 (e : IntW 8) :
  LLVM.xor (icmp IntPred.eq e (const? 8 0)) (icmp IntPred.ne e (const? 8 4)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 8 (-5))) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
