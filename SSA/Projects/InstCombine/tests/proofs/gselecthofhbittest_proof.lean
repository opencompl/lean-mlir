
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gselecthofhbittest_proof
theorem and_lshr_and_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 1)) (const? 32 0)) (LLVM.and (lshr e (const? 32 1)) (const? 32 1))
      (const? 32 1) ⊑
    zext 32 (icmp IntPredicate.ne (LLVM.and e (const? 32 3)) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_and_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 2)) (const? 32 0)) (LLVM.and e (const? 32 1)) (const? 32 1) ⊑
    zext 32 (icmp IntPredicate.ne (LLVM.and e (const? 32 3)) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem f_var0_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 e) (const? 32 0)) (LLVM.and (lshr e_1 (const? 32 1)) (const? 32 1))
      (const? 32 1) ⊑
    zext 32 (icmp IntPredicate.ne (LLVM.and e_1 (LLVM.or e (const? 32 2))) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem f_var0_commutative_and_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 e) (const? 32 0)) (LLVM.and (lshr e (const? 32 1)) (const? 32 1))
      (const? 32 1) ⊑
    zext 32 (icmp IntPredicate.ne (LLVM.and e (LLVM.or e_1 (const? 32 2))) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem f_var1_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 e) (const? 32 0)) (LLVM.and e_1 (const? 32 1)) (const? 32 1) ⊑
    zext 32 (icmp IntPredicate.ne (LLVM.and e_1 (LLVM.or e (const? 32 1))) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem f_var1_commutative_and_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 e) (const? 32 0)) (LLVM.and e (const? 32 1)) (const? 32 1) ⊑
    zext 32 (icmp IntPredicate.ne (LLVM.and e (LLVM.or e_1 (const? 32 1))) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n5_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 2)) (const? 32 0)) (LLVM.and e (const? 32 2)) (const? 32 1) ⊑
    LLVM.and (lshr e (const? 32 1)) (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n6_thm (e : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 32 1)) (const? 32 0)) (LLVM.and (lshr e (const? 32 2)) (const? 32 1))
      (const? 32 1) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 32 1)) (const? 32 0)) (const? 32 1)
      (LLVM.and (lshr e (const? 32 2)) (const? 32 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n7_thm (e : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 32 2)) (const? 32 0)) (LLVM.and e (const? 32 1)) (const? 32 1) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 32 2)) (const? 32 0)) (const? 32 1)
      (LLVM.and e (const? 32 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n8_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 1)) (const? 32 1)) (LLVM.and (lshr e (const? 32 2)) (const? 32 1))
      (const? 32 1) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 32 1)) (const? 32 0)) (const? 32 1)
      (LLVM.and (lshr e (const? 32 2)) (const? 32 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
