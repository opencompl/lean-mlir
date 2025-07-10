
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gand2_proof
theorem test2_proof.test2_thm_1 (e e_1 : IntW 1) : LLVM.and (LLVM.and e e_1) e ⊑ LLVM.and e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_logical_proof.test2_logical_thm_1 (e e_1 : IntW 1) :
  select (select e e_1 (const? 1 0)) e (const? 1 0) ⊑ select e e_1 (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_proof.test3_thm_1 (e e_1 : IntW 32) : LLVM.and e_1 (LLVM.and e e_1) ⊑ LLVM.and e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test7_proof.test7_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  LLVM.and (LLVM.and (icmp IntPred.slt e (const? 32 1)) e_1) (icmp IntPred.sgt e (const? 32 (-1))) ⊑
    LLVM.and (icmp IntPred.eq e (const? 32 0)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test7_logical_proof.test7_logical_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  select (select (icmp IntPred.slt e (const? 32 1)) e_1 (const? 1 0)) (icmp IntPred.sgt e (const? 32 (-1)))
      (const? 1 0) ⊑
    select (icmp IntPred.eq e (const? 32 0)) e_1 (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test8_proof.test8_thm_1 (e : IntW 32) :
  LLVM.and (icmp IntPred.ne e (const? 32 0)) (icmp IntPred.ult e (const? 32 14)) ⊑
    icmp IntPred.ult (add e (const? 32 (-1))) (const? 32 13) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test8_logical_proof.test8_logical_thm_1 (e : IntW 32) :
  select (icmp IntPred.ne e (const? 32 0)) (icmp IntPred.ult e (const? 32 14)) (const? 1 0) ⊑
    icmp IntPred.ult (add e (const? 32 (-1))) (const? 32 13) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test9_proof.test9_thm_1 (e : IntW 64) :
  LLVM.and (sub (const? 64 0) e { «nsw» := true }) (const? 64 1) ⊑ LLVM.and e (const? 64 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test10_proof.test10_thm_1 (e : IntW 64) :
  add (sub (const? 64 0) e { «nsw» := true }) (LLVM.and (sub (const? 64 0) e { «nsw» := true }) (const? 64 1)) ⊑
    sub (const? 64 0) (LLVM.and e (const? 64 (-2))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and1_shl1_is_cmp_eq_0_proof.and1_shl1_is_cmp_eq_0_thm_1 (e : IntW 8) :
  LLVM.and (shl (const? 8 1) e) (const? 8 1) ⊑ zext 8 (icmp IntPred.eq e (const? 8 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and1_shl1_is_cmp_eq_0_multiuse_proof.and1_shl1_is_cmp_eq_0_multiuse_thm_1 (e : IntW 8) :
  add (shl (const? 8 1) e) (LLVM.and (shl (const? 8 1) e) (const? 8 1)) ⊑
    add (shl (const? 8 1) e { «nuw» := true }) (LLVM.and (shl (const? 8 1) e { «nuw» := true }) (const? 8 1))
      { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and1_lshr1_is_cmp_eq_0_proof.and1_lshr1_is_cmp_eq_0_thm_1 (e : IntW 8) :
  LLVM.and (lshr (const? 8 1) e) (const? 8 1) ⊑ lshr (const? 8 1) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and1_lshr1_is_cmp_eq_0_multiuse_proof.and1_lshr1_is_cmp_eq_0_multiuse_thm_1 (e : IntW 8) :
  add (lshr (const? 8 1) e) (LLVM.and (lshr (const? 8 1) e) (const? 8 1)) ⊑
    shl (lshr (const? 8 1) e) (const? 8 1) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test11_proof.test11_thm_1 (e e_1 : IntW 32) :
  mul (LLVM.and (add (shl e (const? 32 8)) e_1) (const? 32 128)) (shl e (const? 32 8)) ⊑
    mul (LLVM.and e_1 (const? 32 128)) (shl e (const? 32 8)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test12_proof.test12_thm_1 (e e_1 : IntW 32) :
  mul (LLVM.and (add e_1 (shl e (const? 32 8))) (const? 32 128)) (shl e (const? 32 8)) ⊑
    mul (LLVM.and e_1 (const? 32 128)) (shl e (const? 32 8)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test13_proof.test13_thm_1 (e e_1 : IntW 32) :
  mul (LLVM.and (sub e_1 (shl e (const? 32 8))) (const? 32 128)) (shl e (const? 32 8)) ⊑
    mul (LLVM.and e_1 (const? 32 128)) (shl e (const? 32 8)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test14_proof.test14_thm_1 (e e_1 : IntW 32) :
  mul (LLVM.and (sub (shl e (const? 32 8)) e_1) (const? 32 128)) (shl e (const? 32 8)) ⊑
    mul (LLVM.and (sub (const? 32 0) e_1) (const? 32 128)) (shl e (const? 32 8)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
