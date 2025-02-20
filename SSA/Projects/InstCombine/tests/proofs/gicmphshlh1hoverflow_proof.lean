
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gicmphshlh1hoverflow_proof
theorem icmp_shl_ugt_1_thm (e : IntW 8) :
  icmp IntPredicate.ugt (shl e (const? 8 1)) e ⊑ icmp IntPredicate.sgt e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_shl_uge_2_thm (e : IntW 5) :
  icmp IntPredicate.uge (add (const? 5 10) e) (shl (add (const? 5 10) e) (const? 5 1)) ⊑
    icmp IntPredicate.slt (add e (const? 5 10)) (const? 5 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_shl_ule_2_thm (e : IntW 8) :
  icmp IntPredicate.ule (add (const? 8 42) e) (shl (add (const? 8 42) e) (const? 8 1)) ⊑
    icmp IntPredicate.sgt (add e (const? 8 42)) (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_shl_eq_1_thm (e : IntW 8) :
  icmp IntPredicate.eq (shl e (const? 8 1)) e ⊑ icmp IntPredicate.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_shl_ne_2_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.sdiv (const? 8 42) e) (shl (LLVM.sdiv (const? 8 42) e) (const? 8 1)) ⊑
    icmp IntPredicate.ne (LLVM.sdiv (const? 8 42) e) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
