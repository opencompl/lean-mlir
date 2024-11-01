
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsubhlshrhorhtohicmphselect_proof
theorem neg_or_lshr_i32_thm (e : IntW 32) :
  lshr (LLVM.or (sub (const? 0) e) e) (const? 31) ⊑ zext 32 (icmp IntPredicate.ne e (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem neg_or_lshr_i32_commute_thm (e : IntW 32) :
  lshr (LLVM.or (LLVM.sdiv (const? 42) e) (sub (const? 0) (LLVM.sdiv (const? 42) e))) (const? 31) ⊑
    zext 32 (icmp IntPredicate.ne (LLVM.sdiv (const? 42) e) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


