
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gicmphofhxorhx_proof
theorem test_xor_ne_proof.test_xor_ne_thm_1 (e e_1 e_2 : IntW 8) :
  icmp IntPred.ne (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor (LLVM.xor e_1 (const? 8 (-1))) e) ⊑
    icmp IntPred.ne e_2 (LLVM.xor e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_xor_eq_proof.test_xor_eq_thm_1 (e e_1 e_2 : IntW 8) :
  icmp IntPred.eq (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor (LLVM.xor e_1 (const? 8 (-1))) e) ⊑
    icmp IntPred.eq e_2 (LLVM.xor e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_slt_xor_proof.test_slt_xor_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.slt (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) (LLVM.xor e (const? 32 (-1))) ⊑
    icmp IntPred.sgt (LLVM.xor e_1 e) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_sle_xor_proof.test_sle_xor_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.sle (LLVM.xor (LLVM.xor e_1 (const? 32 (-1))) e) (LLVM.xor e_1 (const? 32 (-1))) ⊑
    icmp IntPred.sge (LLVM.xor e e_1) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_sgt_xor_proof.test_sgt_xor_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.sgt (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) (LLVM.xor e (const? 32 (-1))) ⊑
    icmp IntPred.slt (LLVM.xor e_1 e) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_sge_xor_proof.test_sge_xor_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.sge (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) (LLVM.xor e (const? 32 (-1))) ⊑
    icmp IntPred.sle (LLVM.xor e_1 e) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_ult_xor_proof.test_ult_xor_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ult (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) (LLVM.xor e (const? 32 (-1))) ⊑
    icmp IntPred.ugt (LLVM.xor e_1 e) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_ule_xor_proof.test_ule_xor_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ule (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) (LLVM.xor e (const? 32 (-1))) ⊑
    icmp IntPred.uge (LLVM.xor e_1 e) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_ugt_xor_proof.test_ugt_xor_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ugt (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) (LLVM.xor e (const? 32 (-1))) ⊑
    icmp IntPred.ult (LLVM.xor e_1 e) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_uge_xor_proof.test_uge_xor_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.uge (LLVM.xor (LLVM.xor e (const? 32 (-1))) e_1) (LLVM.xor e (const? 32 (-1))) ⊑
    icmp IntPred.ule (LLVM.xor e_1 e) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_sge_proof.xor_sge_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.sge (mul e e) (LLVM.xor (LLVM.or e_1 (const? 8 (-128))) (mul e e)) ⊑
    icmp IntPred.slt (LLVM.xor (LLVM.or e_1 (const? 8 (-128))) (mul e e)) (mul e e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_ugt_2_proof.xor_ugt_2_thm_1 (e e_1 e_2 : IntW 8) :
  icmp IntPred.ugt (add e e_2) (LLVM.xor (add e e_2) (LLVM.or (LLVM.and e_1 (const? 8 63)) (const? 8 64))) ⊑
    icmp IntPred.ugt (add e e_2)
      (LLVM.xor (add e e_2) (LLVM.or (LLVM.and e_1 (const? 8 63)) (const? 8 64) { «disjoint» := true })) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
