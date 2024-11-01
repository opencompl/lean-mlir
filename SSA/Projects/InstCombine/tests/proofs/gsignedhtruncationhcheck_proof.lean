
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsignedhtruncationhcheck_proof
theorem positive_with_signbit_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt e (const? (-1))) (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) ⊑
    icmp IntPredicate.ult e (const? 128) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_with_signbit_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.sgt e (const? (-1))) (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) (const? 0) ⊑
    icmp IntPredicate.ult e (const? 128) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_with_mask_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.eq (LLVM.and e (const? 1107296256)) (const? 0))
      (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) ⊑
    icmp IntPredicate.ult e (const? 128) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_with_mask_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 1107296256)) (const? 0))
      (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) (const? 0) ⊑
    icmp IntPredicate.ult e (const? 128) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_with_icmp_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ult e (const? 512)) (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) ⊑
    icmp IntPredicate.ult e (const? 128) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_with_icmp_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ult e (const? 512)) (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) (const? 0) ⊑
    icmp IntPredicate.ult e (const? 128) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_with_aggressive_icmp_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ult e (const? 128)) (icmp IntPredicate.ult (add e (const? 256)) (const? 512)) ⊑
    icmp IntPredicate.ult e (const? 128) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_with_aggressive_icmp_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ult e (const? 128)) (icmp IntPredicate.ult (add e (const? 256)) (const? 512)) (const? 0) ⊑
    icmp IntPredicate.ult e (const? 128) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_with_extra_and_thm (e : IntW 1) (e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.ult (add e_1 (const? 128)) (const? 256))
      (LLVM.and (icmp IntPredicate.sgt e_1 (const? (-1))) e) ⊑
    LLVM.and (icmp IntPredicate.ult e_1 (const? 128)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_with_extra_and_logical_thm (e : IntW 1) (e_1 : IntW 32) :
  select (icmp IntPredicate.ult (add e_1 (const? 128)) (const? 256))
      (select (icmp IntPredicate.sgt e_1 (const? (-1))) e (const? 0)) (const? 0) ⊑
    select (icmp IntPredicate.ult e_1 (const? 128)) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_trunc_signbit_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt (trunc 8 e) (const? (-1))) (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) ⊑
    icmp IntPredicate.ult e (const? 128) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_trunc_signbit_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.sgt (trunc 8 e) (const? (-1))) (icmp IntPredicate.ult (add e (const? 128)) (const? 256))
      (const? 0) ⊑
    icmp IntPredicate.ult e (const? 128) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_trunc_base_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt (trunc 16 e) (const? (-1)))
      (icmp IntPredicate.ult (add (trunc 16 e) (const? 128)) (const? 256)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 65408)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_trunc_base_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.sgt (trunc 16 e) (const? (-1)))
      (icmp IntPredicate.ult (add (trunc 16 e) (const? 128)) (const? 256)) (const? 0) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 65408)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_different_trunc_both_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt (trunc 15 e) (const? (-1)))
      (icmp IntPredicate.ult (add (trunc 16 e) (const? 128)) (const? 256)) ⊑
    LLVM.and (icmp IntPredicate.eq (LLVM.and e (const? 16384)) (const? 0))
      (icmp IntPredicate.ult (add (trunc 16 e) (const? 128)) (const? 256)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem positive_different_trunc_both_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.sgt (trunc 15 e) (const? (-1)))
      (icmp IntPredicate.ult (add (trunc 16 e) (const? 128)) (const? 256)) (const? 0) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 16384)) (const? 0))
      (icmp IntPredicate.ult (add (trunc 16 e) (const? 128)) (const? 256)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negative_trunc_not_arg_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt (trunc 8 e_1) (const? (-1)))
      (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) ⊑
    LLVM.and (icmp IntPredicate.eq (LLVM.and e_1 (const? 128)) (const? 0))
      (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negative_trunc_not_arg_logical_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.sgt (trunc 8 e_1) (const? (-1))) (icmp IntPredicate.ult (add e (const? 128)) (const? 256))
      (const? 0) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 128)) (const? 0))
      (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negative_with_nonuniform_bad_mask_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 1711276033)) (const? 0))
      (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) (const? 0) ⊑
    LLVM.and (icmp IntPredicate.eq (LLVM.and e (const? 1711276033)) (const? 0))
      (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negative_with_uniform_bad_mask_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? (-16777152))) (const? 0))
      (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) (const? 0) ⊑
    LLVM.and (icmp IntPredicate.eq (LLVM.and e (const? (-16777152))) (const? 0))
      (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negative_with_wrong_mask_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 1)) (const? 0))
      (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) (const? 0) ⊑
    LLVM.and (icmp IntPredicate.eq (LLVM.and e (const? 1)) (const? 0))
      (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negative_not_less_than_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt e (const? (-1))) (icmp IntPredicate.ult (add e (const? 256)) (const? 256)) ⊑
    const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negative_not_less_than_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.sgt e (const? (-1))) (icmp IntPredicate.ult (add e (const? 256)) (const? 256)) (const? 0) ⊑
    const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negative_not_power_of_two_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt e (const? (-1))) (icmp IntPredicate.ult (add e (const? 255)) (const? 256)) ⊑
    icmp IntPredicate.eq e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negative_not_power_of_two_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.sgt e (const? (-1))) (icmp IntPredicate.ult (add e (const? 255)) (const? 256)) (const? 0) ⊑
    icmp IntPredicate.eq e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negative_not_next_power_of_two_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.sgt e (const? (-1))) (icmp IntPredicate.ult (add e (const? 64)) (const? 256)) ⊑
    icmp IntPredicate.ult e (const? 192) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem negative_not_next_power_of_two_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.sgt e (const? (-1))) (icmp IntPredicate.ult (add e (const? 64)) (const? 256)) (const? 0) ⊑
    icmp IntPredicate.ult e (const? 192) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem two_signed_truncation_checks_thm (e : IntW 32) :
  LLVM.and (icmp IntPredicate.ult (add e (const? 512)) (const? 1024))
      (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) ⊑
    icmp IntPredicate.ult (add e (const? 128)) (const? 256) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem two_signed_truncation_checks_logical_thm (e : IntW 32) :
  select (icmp IntPredicate.ult (add e (const? 512)) (const? 1024))
      (icmp IntPredicate.ult (add e (const? 128)) (const? 256)) (const? 0) ⊑
    icmp IntPredicate.ult (add e (const? 128)) (const? 256) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


