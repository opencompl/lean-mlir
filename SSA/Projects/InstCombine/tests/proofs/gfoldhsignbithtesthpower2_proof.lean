
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gfoldhsignbithtesthpower2_proof
theorem pow2_or_zero_is_negative_commute_thm (e : IntW 8) :
  icmp IntPredicate.slt (LLVM.and (sub (const? 8 0) (mul (const? 8 42) e)) (mul (const? 8 42) e)) (const? 8 0) ⊑
    icmp IntPredicate.eq (mul e (const? 8 42)) (const? 8 (-128)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem pow2_or_zero_is_not_negative_commute_thm (e : IntW 8) :
  icmp IntPredicate.sgt (LLVM.and (sub (const? 8 0) (mul (const? 8 42) e)) (mul (const? 8 42) e)) (const? 8 (-1)) ⊑
    icmp IntPredicate.ne (mul e (const? 8 42)) (const? 8 (-128)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


