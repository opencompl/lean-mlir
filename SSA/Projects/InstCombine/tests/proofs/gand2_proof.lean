
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gand2_proof
theorem test2_thm (e e_1 : IntW 1) : LLVM.and (LLVM.and e_1 e) e_1 ⊑ LLVM.and e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_logical_thm (e e_1 : IntW 1) :
  select (select e_1 e (const? 1 0)) e_1 (const? 1 0) ⊑ select e_1 e (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e e_1 : IntW 32) : LLVM.and e_1 (LLVM.and e e_1) ⊑ LLVM.and e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test7_thm (e : IntW 1) (e_1 : IntW 32) :
  LLVM.and (LLVM.and (icmp IntPredicate.slt e_1 (const? 32 1)) e) (icmp IntPredicate.sgt e_1 (const? 32 (-1))) ⊑
    LLVM.and (icmp IntPredicate.eq e_1 (const? 32 0)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test7_logical_thm (e : IntW 1) (e_1 : IntW 32) :
  select (select (icmp IntPredicate.slt e_1 (const? 32 1)) e (const? 1 0)) (icmp IntPredicate.sgt e_1 (const? 32 (-1)))
      (const? 1 0) ⊑
    select (icmp IntPredicate.eq e_1 (const? 32 0)) e (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test8_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ne e (const? 32 0)) (icmp IntPredicate.ult e (const? 32 14)) ⊑
    icmp IntPredicate.ult (add e (const? 32 (-1))) (const? 32 13) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test8_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ne e (const? 32 0)) (icmp IntPredicate.ult e (const? 32 14)) (const? 1 0) ⊑
    icmp IntPredicate.ult (add e (const? 32 (-1))) (const? 32 13) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test9_thm (e : IntW 64) :
  LLVM.and (sub (const? 64 0) e { «nsw» := true, «nuw» := false }) (const? 64 1) ⊑ LLVM.and e (const? 64 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test10_thm (e : IntW 64) :
  add (sub (const? 64 0) e { «nsw» := true, «nuw» := false })
      (LLVM.and (sub (const? 64 0) e { «nsw» := true, «nuw» := false }) (const? 64 1)) ⊑
    sub (const? 64 0) (LLVM.and e (const? 64 (-2))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and1_shl1_is_cmp_eq_0_thm (e : IntW 8) :
  LLVM.and (shl (const? 8 1) e) (const? 8 1) ⊑ zext 8 (icmp IntPredicate.eq e (const? 8 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and1_shl1_is_cmp_eq_0_multiuse_thm (e : IntW 8) :
  add (shl (const? 8 1) e) (LLVM.and (shl (const? 8 1) e) (const? 8 1)) ⊑
    add (shl (const? 8 1) e { «nsw» := false, «nuw» := true })
      (LLVM.and (shl (const? 8 1) e { «nsw» := false, «nuw» := true }) (const? 8 1))
      { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and1_lshr1_is_cmp_eq_0_thm (e : IntW 8) : LLVM.and (lshr (const? 8 1) e) (const? 8 1) ⊑ lshr (const? 8 1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and1_lshr1_is_cmp_eq_0_multiuse_thm (e : IntW 8) :
  add (lshr (const? 8 1) e) (LLVM.and (lshr (const? 8 1) e) (const? 8 1)) ⊑
    shl (lshr (const? 8 1) e) (const? 8 1) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test11_thm (e e_1 : IntW 32) :
  mul (LLVM.and (add (shl e_1 (const? 32 8)) e) (const? 32 128)) (shl e_1 (const? 32 8)) ⊑
    mul (LLVM.and e (const? 32 128)) (shl e_1 (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test12_thm (e e_1 : IntW 32) :
  mul (LLVM.and (add e_1 (shl e (const? 32 8))) (const? 32 128)) (shl e (const? 32 8)) ⊑
    mul (LLVM.and e_1 (const? 32 128)) (shl e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test13_thm (e e_1 : IntW 32) :
  mul (LLVM.and (sub e_1 (shl e (const? 32 8))) (const? 32 128)) (shl e (const? 32 8)) ⊑
    mul (LLVM.and e_1 (const? 32 128)) (shl e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test14_thm (e e_1 : IntW 32) :
  mul (LLVM.and (sub (shl e_1 (const? 32 8)) e) (const? 32 128)) (shl e_1 (const? 32 8)) ⊑
    mul (LLVM.and (sub (const? 32 0) e) (const? 32 128)) (shl e_1 (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


