
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gselecthbitexthbitwisehops_proof
theorem sel_false_val_is_a_masked_shl_of_true_val1_proof.sel_false_val_is_a_masked_shl_of_true_val1_thm_1 (e : IntW 32) (e_1 : IntW 64) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 15)) (const? 32 0)) e_1
      (ashr e_1 (zext 64 (shl (LLVM.and e (const? 32 15)) (const? 32 2) { «nsw» := true, «nuw» := true }))) ⊑
    ashr e_1 (zext 64 (LLVM.and (shl e (const? 32 2)) (const? 32 60)) { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sel_false_val_is_a_masked_shl_of_true_val2_proof.sel_false_val_is_a_masked_shl_of_true_val2_thm_1 (e : IntW 32) (e_1 : IntW 64) :
  select
      (icmp IntPred.eq (shl (LLVM.and e (const? 32 15)) (const? 32 2) { «nsw» := true, «nuw» := true }) (const? 32 0))
      e_1 (ashr e_1 (zext 64 (shl (LLVM.and e (const? 32 15)) (const? 32 2) { «nsw» := true, «nuw» := true }))) ⊑
    ashr e_1 (zext 64 (LLVM.and (shl e (const? 32 2)) (const? 32 60)) { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sel_false_val_is_a_masked_lshr_of_true_val1_proof.sel_false_val_is_a_masked_lshr_of_true_val1_thm_1 (e : IntW 32) (e_1 : IntW 64) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 60)) (const? 32 0)) e_1
      (ashr e_1 (zext 64 (lshr (LLVM.and e (const? 32 60)) (const? 32 2)))) ⊑
    ashr e_1 (zext 64 (LLVM.and (lshr e (const? 32 2)) (const? 32 15)) { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sel_false_val_is_a_masked_lshr_of_true_val2_proof.sel_false_val_is_a_masked_lshr_of_true_val2_thm_1 (e : IntW 32) (e_1 : IntW 64) :
  select (icmp IntPred.eq (lshr (LLVM.and e (const? 32 60)) (const? 32 2)) (const? 32 0)) e_1
      (ashr e_1 (zext 64 (lshr (LLVM.and e (const? 32 60)) (const? 32 2)))) ⊑
    ashr e_1 (zext 64 (LLVM.and (lshr e (const? 32 2)) (const? 32 15)) { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sel_false_val_is_a_masked_ashr_of_true_val1_proof.sel_false_val_is_a_masked_ashr_of_true_val1_thm_1 (e : IntW 32) (e_1 : IntW 64) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 (-2147483588))) (const? 32 0)) e_1
      (ashr e_1 (zext 64 (ashr (LLVM.and e (const? 32 (-2147483588))) (const? 32 2)))) ⊑
    ashr e_1 (zext 64 (LLVM.and (ashr e (const? 32 2)) (const? 32 (-536870897))) { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sel_false_val_is_a_masked_ashr_of_true_val2_proof.sel_false_val_is_a_masked_ashr_of_true_val2_thm_1 (e : IntW 32) (e_1 : IntW 64) :
  select (icmp IntPred.eq (ashr (LLVM.and e (const? 32 (-2147483588))) (const? 32 2)) (const? 32 0)) e_1
      (ashr e_1 (zext 64 (ashr (LLVM.and e (const? 32 (-2147483588))) (const? 32 2)))) ⊑
    ashr e_1 (zext 64 (LLVM.and (ashr e (const? 32 2)) (const? 32 (-536870897))) { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
