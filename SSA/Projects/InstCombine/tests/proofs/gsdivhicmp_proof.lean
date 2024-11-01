
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsdivhicmp_proof
theorem sdiv_exact_eq_0_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.sdiv e_1 e) (const? 0) ⊑ icmp IntPredicate.eq e_1 (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_exact_ne_0_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (LLVM.udiv e_1 e) (const? 0) ⊑ icmp IntPredicate.ne e_1 (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_exact_ne_1_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.sdiv e_1 e) (const? 0) ⊑ icmp IntPredicate.eq e_1 (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_exact_eq_1_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (LLVM.udiv e_1 e) (const? 1) ⊑ icmp IntPredicate.ne e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_exact_eq_9_no_of_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.sdiv e_1 (LLVM.and e (const? 7))) (const? 9) ⊑
    icmp IntPredicate.eq (mul (LLVM.and e (const? 7)) (const? 9) { «nsw» := true, «nuw» := true }) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_exact_ne_30_no_of_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (LLVM.udiv e_1 (LLVM.and e (const? 7))) (const? 30) ⊑
    icmp IntPredicate.ne (mul (LLVM.and e (const? 7)) (const? 30) { «nsw» := false, «nuw» := true }) e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


