
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gfoldhsignbithtesthpower2_proof
theorem pow2_or_zero_is_negative_commute_thm (e : IntW 8) :
  icmp IntPred.slt (LLVM.and (sub (const? 8 0) (mul (const? 8 42) e)) (mul (const? 8 42) e)) (const? 8 0) ⊑
    icmp IntPred.eq (mul e (const? 8 42)) (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem pow2_or_zero_is_not_negative_commute_thm (e : IntW 8) :
  icmp IntPred.sgt (LLVM.and (sub (const? 8 0) (mul (const? 8 42) e)) (mul (const? 8 42) e)) (const? 8 (-1)) ⊑
    icmp IntPred.ne (mul e (const? 8 42)) (const? 8 (-128)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
