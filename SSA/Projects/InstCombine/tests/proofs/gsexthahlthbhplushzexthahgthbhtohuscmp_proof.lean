
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gsexthahlthbhplushzexthahgthbhtohuscmp_proof
theorem signed_add_thm (e e_1 : IntW 32) :
  add (sext 8 (icmp IntPredicate.slt e_1 e)) (zext 8 (icmp IntPredicate.sgt e_1 e)) ⊑
    add (sext 8 (icmp IntPredicate.slt e_1 e)) (zext 8 (icmp IntPredicate.sgt e_1 e))
      { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem unsigned_add_thm (e e_1 : IntW 32) :
  add (sext 8 (icmp IntPredicate.ult e_1 e)) (zext 8 (icmp IntPredicate.ugt e_1 e)) ⊑
    add (sext 8 (icmp IntPredicate.ult e_1 e)) (zext 8 (icmp IntPredicate.ugt e_1 e))
      { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem signed_add_commuted1_thm (e e_1 : IntW 32) :
  add (zext 8 (icmp IntPredicate.slt e_1 e)) (sext 8 (icmp IntPredicate.sgt e_1 e)) ⊑
    add (zext 8 (icmp IntPredicate.slt e_1 e)) (sext 8 (icmp IntPredicate.sgt e_1 e))
      { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem signed_add_commuted2_thm (e e_1 : IntW 32) :
  add (sext 8 (icmp IntPredicate.sgt e_1 e)) (zext 8 (icmp IntPredicate.sgt e e_1)) ⊑
    add (sext 8 (icmp IntPredicate.sgt e_1 e)) (zext 8 (icmp IntPredicate.sgt e e_1))
      { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem signed_sub_thm (e e_1 : IntW 32) :
  sub (zext 8 (icmp IntPredicate.sgt e_1 e)) (zext 8 (icmp IntPredicate.slt e_1 e)) ⊑
    add (sext 8 (icmp IntPredicate.slt e_1 e)) (zext 8 (icmp IntPredicate.sgt e_1 e))
      { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem unsigned_sub_thm (e e_1 : IntW 32) :
  sub (zext 8 (icmp IntPredicate.ugt e_1 e)) (zext 8 (icmp IntPredicate.ult e_1 e)) ⊑
    add (sext 8 (icmp IntPredicate.ult e_1 e)) (zext 8 (icmp IntPredicate.ugt e_1 e))
      { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem signed_add_neg1_thm (e e_1 : IntW 32) :
  add (sext 8 (icmp IntPredicate.sgt e_1 e)) (zext 8 (icmp IntPredicate.sgt e_1 e)) ⊑
    add (sext 8 (icmp IntPredicate.sgt e_1 e)) (zext 8 (icmp IntPredicate.sgt e_1 e))
      { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem signed_add_neg2_thm (e e_1 : IntW 32) :
  add (sext 8 (icmp IntPredicate.slt e_1 e)) (zext 8 (icmp IntPredicate.ne e_1 e)) ⊑
    add (sext 8 (icmp IntPredicate.slt e_1 e)) (zext 8 (icmp IntPredicate.ne e_1 e))
      { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem signed_add_neg3_thm (e e_1 : IntW 32) :
  add (sext 8 (icmp IntPredicate.slt e_1 e)) (zext 8 (icmp IntPredicate.ugt e_1 e)) ⊑
    add (sext 8 (icmp IntPredicate.slt e_1 e)) (zext 8 (icmp IntPredicate.ugt e_1 e))
      { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem signed_add_neg4_thm (e e_1 : IntW 32) :
  add (sext 8 (icmp IntPredicate.slt e_1 e)) (sext 8 (icmp IntPredicate.sgt e_1 e)) ⊑
    add (sext 8 (icmp IntPredicate.slt e_1 e)) (sext 8 (icmp IntPredicate.sgt e_1 e))
      { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem signed_add_neg5_thm (e e_1 : IntW 32) :
  add (zext 8 (icmp IntPredicate.slt e_1 e)) (zext 8 (icmp IntPredicate.sgt e_1 e)) ⊑
    add (zext 8 (icmp IntPredicate.slt e_1 e)) (zext 8 (icmp IntPredicate.sgt e_1 e))
      { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


