
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gexact_proof
theorem sdiv2_thm (e : IntW 32) : LLVM.sdiv e (const? 8) ⊑ ashr e (const? 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv4_thm (e : IntW 32) : mul (LLVM.sdiv e (const? 3)) (const? 3) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv6_thm (e : IntW 32) : mul (LLVM.sdiv e (const? 3)) (const? (-3)) ⊑ sub (const? 0) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv1_thm (e e_1 : IntW 32) : mul (LLVM.udiv e_1 e) e ⊑ e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv2_thm (e e_1 : IntW 32) : LLVM.udiv e_1 (shl (const? 1) e) ⊑ lshr e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_icmp1_thm (e : IntW 64) :
  icmp IntPredicate.eq (ashr e (const? 2)) (const? 0) ⊑ icmp IntPredicate.eq e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ashr_icmp2_thm (e : IntW 64) :
  icmp IntPredicate.slt (ashr e (const? 2)) (const? 4) ⊑ icmp IntPredicate.slt e (const? 16) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem pr9998_thm (e : IntW 32) :
  icmp IntPredicate.ugt (sext 64 (ashr (shl e (const? 31)) (const? 31))) (const? 7297771788697658747) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 1)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_icmp1_thm (e : IntW 64) :
  icmp IntPredicate.ne (LLVM.udiv e (const? 5)) (const? 0) ⊑ icmp IntPredicate.ne e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem udiv_icmp2_thm (e : IntW 64) :
  icmp IntPredicate.eq (LLVM.udiv e (const? 5)) (const? 0) ⊑ icmp IntPredicate.eq e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_icmp1_thm (e : IntW 64) :
  icmp IntPredicate.eq (LLVM.sdiv e (const? 5)) (const? 0) ⊑ icmp IntPredicate.eq e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_icmp2_thm (e : IntW 64) :
  icmp IntPredicate.eq (LLVM.sdiv e (const? 5)) (const? 1) ⊑ icmp IntPredicate.eq e (const? 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_icmp3_thm (e : IntW 64) :
  icmp IntPredicate.eq (LLVM.sdiv e (const? 5)) (const? (-1)) ⊑ icmp IntPredicate.eq e (const? (-5)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_icmp4_thm (e : IntW 64) :
  icmp IntPredicate.eq (LLVM.sdiv e (const? (-5))) (const? 0) ⊑ icmp IntPredicate.eq e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_icmp5_thm (e : IntW 64) :
  icmp IntPredicate.eq (LLVM.sdiv e (const? (-5))) (const? 1) ⊑ icmp IntPredicate.eq e (const? (-5)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem sdiv_icmp6_thm (e : IntW 64) :
  icmp IntPredicate.eq (LLVM.sdiv e (const? (-5))) (const? (-1)) ⊑ icmp IntPredicate.eq e (const? 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_of_udiv_thm (e : IntW 8) : mul (LLVM.udiv e (const? 12)) (const? 6) ⊑ lshr e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_of_sdiv_thm (e : IntW 8) :
  mul (LLVM.sdiv e (const? 12)) (const? (-6)) ⊑
    sub (const? 0) (ashr e (const? 1)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_of_udiv_fail_bad_remainder_thm (e : IntW 8) :
  mul (LLVM.udiv e (const? 11)) (const? 6) ⊑
    mul (LLVM.udiv e (const? 11)) (const? 6) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul_of_sdiv_fail_ub_thm (e : IntW 8) : mul (LLVM.sdiv e (const? 6)) (const? (-6)) ⊑ sub (const? 0) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


