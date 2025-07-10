
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gselecthbitext_proof
theorem sel_sext_constants_proof.sel_sext_constants_thm_1 (e : IntW 1) :
  sext 16 (select e (const? 8 (-1)) (const? 8 42)) ⊑ select e (const? 16 (-1)) (const? 16 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sel_zext_constants_proof.sel_zext_constants_thm_1 (e : IntW 1) :
  zext 16 (select e (const? 8 (-1)) (const? 8 42)) ⊑ select e (const? 16 255) (const? 16 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sel_sext_proof.sel_sext_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  sext 64 (select e_1 e (const? 32 42)) ⊑ select e_1 (sext 64 e) (const? 64 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sel_zext_proof.sel_zext_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  zext 64 (select e_1 e (const? 32 42)) ⊑ select e_1 (zext 64 e) (const? 64 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_sel_larger_sext_proof.trunc_sel_larger_sext_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  sext 64 (select e_1 (trunc 16 e) (const? 16 42)) ⊑ select e_1 (sext 64 (trunc 16 e)) (const? 64 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_sel_smaller_sext_proof.trunc_sel_smaller_sext_thm_1 (e : IntW 64) (e_1 : IntW 1) :
  sext 32 (select e_1 (trunc 16 e) (const? 16 42)) ⊑ select e_1 (sext 32 (trunc 16 e)) (const? 32 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_sel_equal_sext_proof.trunc_sel_equal_sext_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  sext 32 (select e_1 (trunc 16 e) (const? 16 42)) ⊑
    select e_1 (ashr (shl e (const? 32 16)) (const? 32 16) { «exact» := true }) (const? 32 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_sel_larger_zext_proof.trunc_sel_larger_zext_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  zext 64 (select e_1 (trunc 16 e) (const? 16 42)) ⊑
    select e_1 (zext 64 (LLVM.and e (const? 32 65535)) { «nneg» := true }) (const? 64 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_sel_smaller_zext_proof.trunc_sel_smaller_zext_thm_1 (e : IntW 64) (e_1 : IntW 1) :
  zext 32 (select e_1 (trunc 16 e) (const? 16 42)) ⊑
    select e_1 (LLVM.and (trunc 32 e) (const? 32 65535)) (const? 32 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_sel_equal_zext_proof.trunc_sel_equal_zext_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  zext 32 (select e_1 (trunc 16 e) (const? 16 42)) ⊑ select e_1 (LLVM.and e (const? 32 65535)) (const? 32 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_sext1_proof.test_sext1_thm_1 (e e_1 : IntW 1) :
  select e_1 (sext 32 e) (const? 32 0) ⊑ sext 32 (select e_1 e (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_sext2_proof.test_sext2_thm_1 (e e_1 : IntW 1) :
  select e_1 (const? 32 (-1)) (sext 32 e) ⊑ sext 32 (select e_1 (const? 1 1) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_sext3_proof.test_sext3_thm_1 (e e_1 : IntW 1) :
  select e_1 (const? 32 0) (sext 32 e) ⊑ sext 32 (select (LLVM.xor e_1 (const? 1 1)) e (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_sext4_proof.test_sext4_thm_1 (e e_1 : IntW 1) :
  select e_1 (sext 32 e) (const? 32 (-1)) ⊑ sext 32 (select (LLVM.xor e_1 (const? 1 1)) (const? 1 1) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_zext1_proof.test_zext1_thm_1 (e e_1 : IntW 1) :
  select e_1 (zext 32 e) (const? 32 0) ⊑ zext 32 (select e_1 e (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_zext2_proof.test_zext2_thm_1 (e e_1 : IntW 1) :
  select e_1 (const? 32 1) (zext 32 e) ⊑ zext 32 (select e_1 (const? 1 1) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_zext3_proof.test_zext3_thm_1 (e e_1 : IntW 1) :
  select e_1 (const? 32 0) (zext 32 e) ⊑ zext 32 (select (LLVM.xor e_1 (const? 1 1)) e (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_zext4_proof.test_zext4_thm_1 (e e_1 : IntW 1) :
  select e_1 (zext 32 e) (const? 32 1) ⊑ zext 32 (select (LLVM.xor e_1 (const? 1 1)) (const? 1 1) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_op_op_proof.test_op_op_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.sgt e_2 (const? 32 0)) (sext 32 (icmp IntPred.sgt e (const? 32 0)))
      (sext 32 (icmp IntPred.sgt e_1 (const? 32 0))) ⊑
    sext 32 (icmp IntPred.sgt (select (icmp IntPred.sgt e_2 (const? 32 0)) e e_1) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_true_val_must_be_all_ones_proof.sext_true_val_must_be_all_ones_thm_1 (e : IntW 1) :
  select e (sext 32 e) (const? 32 42) ⊑ select e (const? 32 (-1)) (const? 32 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem zext_true_val_must_be_one_proof.zext_true_val_must_be_one_thm_1 (e : IntW 1) :
  select e (zext 32 e) (const? 32 42) ⊑ select e (const? 32 1) (const? 32 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_false_val_must_be_zero_proof.sext_false_val_must_be_zero_thm_1 (e : IntW 1) :
  select e (const? 32 42) (sext 32 e) ⊑ select e (const? 32 42) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem zext_false_val_must_be_zero_proof.zext_false_val_must_be_zero_thm_1 (e : IntW 1) :
  select e (const? 32 42) (zext 32 e) ⊑ select e (const? 32 42) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
