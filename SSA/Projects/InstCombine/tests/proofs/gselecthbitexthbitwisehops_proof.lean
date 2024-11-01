
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthbitexthbitwisehops_proof
theorem sel_false_val_is_a_masked_shl_of_true_val1_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 15)) (const? 0)) e
      (ashr e (zext 64 (shl (LLVM.and e_1 (const? 15)) (const? 2) { «nsw» := true, «nuw» := true }))) ⊑
    ashr e (zext 64 (LLVM.and (shl e_1 (const? 2)) (const? 60))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sel_false_val_is_a_masked_shl_of_true_val2_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (shl (LLVM.and e_1 (const? 15)) (const? 2) { «nsw» := true, «nuw» := true }) (const? 0))
      e (ashr e (zext 64 (shl (LLVM.and e_1 (const? 15)) (const? 2) { «nsw» := true, «nuw» := true }))) ⊑
    ashr e (zext 64 (LLVM.and (shl e_1 (const? 2)) (const? 60))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sel_false_val_is_a_masked_lshr_of_true_val1_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 60)) (const? 0)) e
      (ashr e (zext 64 (lshr (LLVM.and e_1 (const? 60)) (const? 2)))) ⊑
    ashr e (zext 64 (LLVM.and (lshr e_1 (const? 2)) (const? 15))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sel_false_val_is_a_masked_lshr_of_true_val2_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (lshr (LLVM.and e_1 (const? 60)) (const? 2)) (const? 0)) e
      (ashr e (zext 64 (lshr (LLVM.and e_1 (const? 60)) (const? 2)))) ⊑
    ashr e (zext 64 (LLVM.and (lshr e_1 (const? 2)) (const? 15))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sel_false_val_is_a_masked_ashr_of_true_val1_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? (-2147483588))) (const? 0)) e
      (ashr e (zext 64 (ashr (LLVM.and e_1 (const? (-2147483588))) (const? 2)))) ⊑
    ashr e (zext 64 (LLVM.and (ashr e_1 (const? 2)) (const? (-536870897)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sel_false_val_is_a_masked_ashr_of_true_val2_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (ashr (LLVM.and e_1 (const? (-2147483588))) (const? 2)) (const? 0)) e
      (ashr e (zext 64 (ashr (LLVM.and e_1 (const? (-2147483588))) (const? 2)))) ⊑
    ashr e (zext 64 (LLVM.and (ashr e_1 (const? 2)) (const? (-536870897)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


