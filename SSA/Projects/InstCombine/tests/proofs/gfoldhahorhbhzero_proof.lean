
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gfoldhahorhbhzero_proof
theorem a_or_b_thm (e e_1 : IntW 32) :
  LLVM.or (LLVM.and (icmp IntPredicate.eq e_1 (const? 32 0)) (icmp IntPredicate.ne e (const? 32 0)))
      (LLVM.and (icmp IntPredicate.ne e_1 (const? 32 0)) (icmp IntPredicate.eq e (const? 32 0))) ⊑
    LLVM.xor (icmp IntPredicate.eq e_1 (const? 32 0)) (icmp IntPredicate.eq e (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_or_b_const_thm (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and (icmp IntPredicate.eq e_2 e_1) (icmp IntPredicate.ne e e_1))
      (LLVM.and (icmp IntPredicate.ne e_2 e_1) (icmp IntPredicate.eq e e_1)) ⊑
    LLVM.xor (icmp IntPredicate.eq e_2 e_1) (icmp IntPredicate.eq e e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem a_or_b_const2_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (LLVM.and (icmp IntPredicate.eq e_3 e_2) (icmp IntPredicate.ne e_1 e))
      (LLVM.and (icmp IntPredicate.ne e_3 e_2) (icmp IntPredicate.eq e_1 e)) ⊑
    LLVM.xor (icmp IntPredicate.eq e_3 e_2) (icmp IntPredicate.eq e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


