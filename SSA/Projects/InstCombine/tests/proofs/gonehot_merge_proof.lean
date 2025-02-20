
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gonehot_merge_proof
theorem and_consts_thm (e : IntW 32) :
  LLVM.or (icmp IntPredicate.eq (LLVM.and (const? 32 4) e) (const? 32 0))
      (icmp IntPredicate.eq (LLVM.and (const? 32 8) e) (const? 32 0)) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 32 12)) (const? 32 12) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_consts_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and (const? 32 4) e) (const? 32 0)) (const? 1 1)
      (icmp IntPredicate.eq (LLVM.and (const? 32 8) e) (const? 32 0)) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 32 12)) (const? 32 12) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo1_and_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (icmp IntPredicate.eq (LLVM.and (shl (const? 32 1) e_2) e_1) (const? 32 0))
      (icmp IntPredicate.eq (LLVM.and (shl (const? 32 1) e) e_1) (const? 32 0)) ⊑
    icmp IntPredicate.ne
      (LLVM.and e_1
        (LLVM.or (shl (const? 32 1) e_2 { «nsw» := false, «nuw» := true })
          (shl (const? 32 1) e { «nsw» := false, «nuw» := true })))
      (LLVM.or (shl (const? 32 1) e_2 { «nsw» := false, «nuw» := true })
        (shl (const? 32 1) e { «nsw» := false, «nuw» := true })) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo1_and_commuted_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (icmp IntPredicate.eq (LLVM.and (mul e_2 e_2) (shl (const? 32 1) e_1)) (const? 32 0))
      (icmp IntPredicate.eq (LLVM.and (shl (const? 32 1) e) (mul e_2 e_2)) (const? 32 0)) ⊑
    icmp IntPredicate.ne
      (LLVM.and (mul e_2 e_2)
        (LLVM.or (shl (const? 32 1) e_1 { «nsw» := false, «nuw» := true })
          (shl (const? 32 1) e { «nsw» := false, «nuw» := true })))
      (LLVM.or (shl (const? 32 1) e_1 { «nsw» := false, «nuw» := true })
        (shl (const? 32 1) e { «nsw» := false, «nuw» := true })) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_consts_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and (const? 32 4) e) (const? 32 0))
      (icmp IntPredicate.ne (LLVM.and (const? 32 8) e) (const? 32 0)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 12)) (const? 32 12) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_consts_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and (const? 32 4) e) (const? 32 0))
      (icmp IntPredicate.ne (LLVM.and (const? 32 8) e) (const? 32 0)) (const? 1 0) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 12)) (const? 32 12) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo1_or_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and (shl (const? 32 1) e_2) e_1) (const? 32 0))
      (icmp IntPredicate.ne (LLVM.and (shl (const? 32 1) e) e_1) (const? 32 0)) ⊑
    icmp IntPredicate.eq
      (LLVM.and e_1
        (LLVM.or (shl (const? 32 1) e_2 { «nsw» := false, «nuw» := true })
          (shl (const? 32 1) e { «nsw» := false, «nuw» := true })))
      (LLVM.or (shl (const? 32 1) e_2 { «nsw» := false, «nuw» := true })
        (shl (const? 32 1) e { «nsw» := false, «nuw» := true })) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo1_or_commuted_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and (mul e_2 e_2) (shl (const? 32 1) e_1)) (const? 32 0))
      (icmp IntPredicate.ne (LLVM.and (shl (const? 32 1) e) (mul e_2 e_2)) (const? 32 0)) ⊑
    icmp IntPredicate.eq
      (LLVM.and (mul e_2 e_2)
        (LLVM.or (shl (const? 32 1) e_1 { «nsw» := false, «nuw» := true })
          (shl (const? 32 1) e { «nsw» := false, «nuw» := true })))
      (LLVM.or (shl (const? 32 1) e_1 { «nsw» := false, «nuw» := true })
        (shl (const? 32 1) e { «nsw» := false, «nuw» := true })) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo1_and_signbit_lshr_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (icmp IntPredicate.eq (LLVM.and (shl (const? 32 1) e_2) e_1) (const? 32 0))
      (icmp IntPredicate.eq (LLVM.and (lshr (const? 32 (-2147483648)) e) e_1) (const? 32 0)) ⊑
    icmp IntPredicate.ne
      (LLVM.and e_1
        (LLVM.or (shl (const? 32 1) e_2 { «nsw» := false, «nuw» := true })
          (lshr (const? 32 (-2147483648)) e { «exact» := true })))
      (LLVM.or (shl (const? 32 1) e_2 { «nsw» := false, «nuw» := true })
        (lshr (const? 32 (-2147483648)) e { «exact» := true })) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo1_or_signbit_lshr_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and (shl (const? 32 1) e_2) e_1) (const? 32 0))
      (icmp IntPredicate.ne (LLVM.and (lshr (const? 32 (-2147483648)) e) e_1) (const? 32 0)) ⊑
    icmp IntPredicate.eq
      (LLVM.and e_1
        (LLVM.or (shl (const? 32 1) e_2 { «nsw» := false, «nuw» := true })
          (lshr (const? 32 (-2147483648)) e { «exact» := true })))
      (LLVM.or (shl (const? 32 1) e_2 { «nsw» := false, «nuw» := true })
        (lshr (const? 32 (-2147483648)) e { «exact» := true })) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo1_and_signbit_lshr_without_shifting_signbit_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (icmp IntPredicate.eq (LLVM.and (shl (const? 32 1) e_2) e_1) (const? 32 0))
      (icmp IntPredicate.sgt (shl e_1 e) (const? 32 (-1))) ⊑
    LLVM.or
      (icmp IntPredicate.eq (LLVM.and (shl (const? 32 1) e_2 { «nsw» := false, «nuw» := true }) e_1) (const? 32 0))
      (icmp IntPredicate.sgt (shl e_1 e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo1_and_signbit_lshr_without_shifting_signbit_logical_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and (shl (const? 32 1) e_2) e_1) (const? 32 0)) (const? 1 1)
      (icmp IntPredicate.sgt (shl e_1 e) (const? 32 (-1))) ⊑
    select (icmp IntPredicate.eq (LLVM.and (shl (const? 32 1) e_2 { «nsw» := false, «nuw» := true }) e_1) (const? 32 0))
      (const? 1 1) (icmp IntPredicate.sgt (shl e_1 e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo1_or_signbit_lshr_without_shifting_signbit_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (icmp IntPredicate.ne (LLVM.and (shl (const? 32 1) e_2) e_1) (const? 32 0))
      (icmp IntPredicate.slt (shl e_1 e) (const? 32 0)) ⊑
    LLVM.and
      (icmp IntPredicate.ne (LLVM.and (shl (const? 32 1) e_2 { «nsw» := false, «nuw» := true }) e_1) (const? 32 0))
      (icmp IntPredicate.slt (shl e_1 e) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo1_or_signbit_lshr_without_shifting_signbit_logical_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and (shl (const? 32 1) e_2) e_1) (const? 32 0))
      (icmp IntPredicate.slt (shl e_1 e) (const? 32 0)) (const? 1 0) ⊑
    select (icmp IntPredicate.ne (LLVM.and (shl (const? 32 1) e_2 { «nsw» := false, «nuw» := true }) e_1) (const? 32 0))
      (icmp IntPredicate.slt (shl e_1 e) (const? 32 0)) (const? 1 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo1_and_signbit_lshr_without_shifting_signbit_both_sides_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (icmp IntPredicate.sgt (shl e_2 e_1) (const? 32 (-1))) (icmp IntPredicate.sgt (shl e_2 e) (const? 32 (-1))) ⊑
    icmp IntPredicate.sgt (LLVM.and (shl e_2 e_1) (shl e_2 e)) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo1_or_signbit_lshr_without_shifting_signbit_both_sides_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (icmp IntPredicate.slt (shl e_2 e_1) (const? 32 0)) (icmp IntPredicate.slt (shl e_2 e) (const? 32 0)) ⊑
    icmp IntPredicate.slt (LLVM.and (shl e_2 e_1) (shl e_2 e)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
