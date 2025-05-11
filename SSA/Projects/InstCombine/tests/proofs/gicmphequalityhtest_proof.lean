
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphequalityhtest_proof
theorem icmp_equality_test_thm (e e_1 e_2 : IntW 64) :
  select (icmp IntPredicate.eq e_2 e_1) (icmp IntPredicate.eq e e_1)
      (select (LLVM.xor (icmp IntPredicate.eq e e_1) (const? 1 1)) (icmp IntPredicate.eq e_2 e) (const? 1 0)) ⊑
    icmp IntPredicate.eq e_2 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_equality_test_constant_thm (e e_1 : IntW 42) :
  select (icmp IntPredicate.eq e_1 (const? 42 (-42))) (icmp IntPredicate.eq e (const? 42 (-42)))
      (select (LLVM.xor (icmp IntPredicate.eq e (const? 42 (-42))) (const? 1 1)) (icmp IntPredicate.eq e_1 e)
        (const? 1 0)) ⊑
    icmp IntPredicate.eq e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_equality_test_constant_samesign_thm (e e_1 : IntW 42) :
  select (icmp IntPredicate.eq e_1 (const? 42 (-42))) (icmp IntPredicate.eq e (const? 42 (-42)))
      (select (LLVM.xor (icmp IntPredicate.eq e (const? 42 (-42))) (const? 1 1)) (icmp IntPredicate.eq e_1 e)
        (const? 1 0)) ⊑
    icmp IntPredicate.eq e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_equality_test_swift_optional_pointers_thm (e e_1 : IntW 64) :
  select (select (icmp IntPredicate.eq e_1 (const? 64 0)) (const? 1 1) (icmp IntPredicate.eq e (const? 64 0)))
      (select (icmp IntPredicate.eq e_1 (const? 64 0)) (icmp IntPredicate.eq e (const? 64 0)) (const? 1 0))
      (icmp IntPredicate.eq e_1 e) ⊑
    icmp IntPredicate.eq e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_equality_test_commute_icmp1_thm (e e_1 e_2 : IntW 64) :
  select (icmp IntPredicate.eq e_2 e_1) (icmp IntPredicate.eq e_2 e)
      (select (LLVM.xor (icmp IntPredicate.eq e_2 e) (const? 1 1)) (icmp IntPredicate.eq e e_1) (const? 1 0)) ⊑
    icmp IntPredicate.eq e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_equality_test_commute_icmp2_thm (e e_1 e_2 : IntW 64) :
  select (icmp IntPredicate.eq e_2 e_1) (icmp IntPredicate.eq e e_2)
      (select (LLVM.xor (icmp IntPredicate.eq e e_2) (const? 1 1)) (icmp IntPredicate.eq e e_1) (const? 1 0)) ⊑
    icmp IntPredicate.eq e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_equality_test_commute_select1_thm (e e_1 e_2 : IntW 64) :
  select (icmp IntPredicate.eq e_2 e_1) (icmp IntPredicate.eq e e_1)
      (select (icmp IntPredicate.eq e e_1) (const? 1 0) (icmp IntPredicate.eq e_2 e)) ⊑
    icmp IntPredicate.eq e_2 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_equality_test_commute_select2_thm (e e_1 e_2 : IntW 64) :
  select (LLVM.xor (icmp IntPredicate.eq e_2 e_1) (const? 1 1))
      (select (icmp IntPredicate.eq e e_1) (const? 1 0) (icmp IntPredicate.eq e_2 e)) (icmp IntPredicate.eq e e_1) ⊑
    icmp IntPredicate.eq e_2 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_equality_test_wrong_and_thm (e e_1 e_2 : IntW 64) :
  select (icmp IntPredicate.eq e_2 e_1) (icmp IntPredicate.eq e e_1)
      (select (LLVM.xor (icmp IntPredicate.eq e e_1) (const? 1 1)) (const? 1 0) (icmp IntPredicate.eq e_2 e)) ⊑
    select (icmp IntPredicate.eq e_2 e_1) (icmp IntPredicate.eq e e_1)
      (select (icmp IntPredicate.eq e e_1) (icmp IntPredicate.eq e_2 e) (const? 1 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
