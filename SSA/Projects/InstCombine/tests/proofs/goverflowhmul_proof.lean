
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section goverflowhmul_proof
theorem pr4917_3_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ugt (mul (zext 64 e_1) (zext 64 e)) (const? 64 4294967295)) (mul (zext 64 e_1) (zext 64 e))
      (const? 64 111) ⊑
    select
      (icmp IntPredicate.ugt (mul (zext 64 e_1) (zext 64 e) { «nsw» := false, «nuw» := true }) (const? 64 4294967295))
      (mul (zext 64 e_1) (zext 64 e) { «nsw» := false, «nuw» := true }) (const? 64 111) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_may_overflow_thm (e e_1 : IntW 32) :
  zext 32 (icmp IntPredicate.ule (mul (zext 34 e_1) (zext 34 e)) (const? 34 4294967295)) ⊑
    zext 32 (icmp IntPredicate.ult (mul (zext 34 e_1) (zext 34 e)) (const? 34 4294967296)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


