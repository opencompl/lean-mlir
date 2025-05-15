
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gselecthbitexthbitwisehops_proof
theorem sel_false_val_is_a_masked_shl_of_true_val1_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e_1 (const? 32 15)) (const? 32 0)) e
      (ashr e (zext 64 (shl (LLVM.and e_1 (const? 32 15)) (const? 32 2) { «nsw» := true, «nuw» := true }))) ⊑
    ashr e (zext 64 (LLVM.and (shl e_1 (const? 32 2)) (const? 32 60)) { «nneg» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sel_false_val_is_a_masked_shl_of_true_val2_thm (e : IntW 64) (e_1 : IntW 32) :
  select
      (icmp IntPred.eq (shl (LLVM.and e_1 (const? 32 15)) (const? 32 2) { «nsw» := true, «nuw» := true })
        (const? 32 0))
      e (ashr e (zext 64 (shl (LLVM.and e_1 (const? 32 15)) (const? 32 2) { «nsw» := true, «nuw» := true }))) ⊑
    ashr e (zext 64 (LLVM.and (shl e_1 (const? 32 2)) (const? 32 60)) { «nneg» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sel_false_val_is_a_masked_lshr_of_true_val1_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e_1 (const? 32 60)) (const? 32 0)) e
      (ashr e (zext 64 (lshr (LLVM.and e_1 (const? 32 60)) (const? 32 2)))) ⊑
    ashr e (zext 64 (LLVM.and (lshr e_1 (const? 32 2)) (const? 32 15)) { «nneg» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sel_false_val_is_a_masked_lshr_of_true_val2_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPred.eq (lshr (LLVM.and e_1 (const? 32 60)) (const? 32 2)) (const? 32 0)) e
      (ashr e (zext 64 (lshr (LLVM.and e_1 (const? 32 60)) (const? 32 2)))) ⊑
    ashr e (zext 64 (LLVM.and (lshr e_1 (const? 32 2)) (const? 32 15)) { «nneg» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sel_false_val_is_a_masked_ashr_of_true_val1_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e_1 (const? 32 (-2147483588))) (const? 32 0)) e
      (ashr e (zext 64 (ashr (LLVM.and e_1 (const? 32 (-2147483588))) (const? 32 2)))) ⊑
    ashr e (zext 64 (LLVM.and (ashr e_1 (const? 32 2)) (const? 32 (-536870897))) { «nneg» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sel_false_val_is_a_masked_ashr_of_true_val2_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPred.eq (ashr (LLVM.and e_1 (const? 32 (-2147483588))) (const? 32 2)) (const? 32 0)) e
      (ashr e (zext 64 (ashr (LLVM.and e_1 (const? 32 (-2147483588))) (const? 32 2)))) ⊑
    ashr e (zext 64 (LLVM.and (ashr e_1 (const? 32 2)) (const? 32 (-536870897))) { «nneg» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
