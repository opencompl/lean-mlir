
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthobohpeohops_proof
theorem test_shl_nuw_nsw__all_are_safe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 15)) (const? 0)) e
      (ashr e (zext 64 (shl (LLVM.and e_1 (const? 15)) (const? 2) { «nsw» := true, «nuw» := true }))) ⊑
    ashr e (zext 64 (LLVM.and (shl e_1 (const? 2)) (const? 60))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shl_nuw__all_are_safe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 15)) (const? 0)) e
      (ashr e (zext 64 (shl (LLVM.and e_1 (const? 15)) (const? 2) { «nsw» := false, «nuw» := true }))) ⊑
    ashr e (zext 64 (LLVM.and (shl e_1 (const? 2)) (const? 60))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shl_nsw__all_are_safe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 15)) (const? 0)) e
      (ashr e (zext 64 (shl (LLVM.and e_1 (const? 15)) (const? 2) { «nsw» := true, «nuw» := false }))) ⊑
    ashr e (zext 64 (LLVM.and (shl e_1 (const? 2)) (const? 60))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shl__all_are_safe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 15)) (const? 0)) e
      (ashr e (zext 64 (shl (LLVM.and e_1 (const? 15)) (const? 2)))) ⊑
    ashr e (zext 64 (LLVM.and (shl e_1 (const? 2)) (const? 60))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shl_nuw_nsw__nuw_is_safe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 1073741822)) (const? 0)) e
      (ashr e (zext 64 (shl (LLVM.and e_1 (const? 1073741822)) (const? 2) { «nsw» := true, «nuw» := true }))) ⊑
    ashr e (zext 64 (LLVM.and (shl e_1 (const? 2)) (const? (-8)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shl_nuw__nuw_is_safe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 1073741822)) (const? 0)) e
      (ashr e (zext 64 (shl (LLVM.and e_1 (const? 1073741822)) (const? 2) { «nsw» := false, «nuw» := true }))) ⊑
    ashr e (zext 64 (LLVM.and (shl e_1 (const? 2)) (const? (-8)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shl_nsw__nuw_is_safe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 1073741822)) (const? 0)) e
      (ashr e (zext 64 (shl (LLVM.and e_1 (const? 1073741822)) (const? 2) { «nsw» := true, «nuw» := false }))) ⊑
    ashr e (zext 64 (LLVM.and (shl e_1 (const? 2)) (const? (-8)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shl__nuw_is_safe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 1073741822)) (const? 0)) e
      (ashr e (zext 64 (shl (LLVM.and e_1 (const? 1073741822)) (const? 2)))) ⊑
    ashr e (zext 64 (LLVM.and (shl e_1 (const? 2)) (const? (-8)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shl_nuw_nsw__nsw_is_safe_thm (e : IntW 32) :
  mul
      (mul
        (select (icmp IntPredicate.eq (LLVM.or e (const? (-83886080))) (const? (-83886079))) (const? (-335544316))
          (shl (LLVM.or e (const? (-83886080))) (const? 2) { «nsw» := true, «nuw» := true }))
        (LLVM.or e (const? (-83886080))))
      (shl (LLVM.or e (const? (-83886080))) (const? 2) { «nsw» := true, «nuw» := true }) ⊑
    const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shl_nuw__nsw_is_safe_thm (e : IntW 32) :
  mul
      (mul
        (select (icmp IntPredicate.eq (LLVM.or e (const? (-83886080))) (const? (-83886079))) (const? (-335544316))
          (shl (LLVM.or e (const? (-83886080))) (const? 2) { «nsw» := false, «nuw» := true }))
        (LLVM.or e (const? (-83886080))))
      (shl (LLVM.or e (const? (-83886080))) (const? 2) { «nsw» := false, «nuw» := true }) ⊑
    const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shl_nsw__nsw_is_safe_thm (e : IntW 32) :
  mul
      (mul
        (select (icmp IntPredicate.eq (LLVM.or e (const? (-83886080))) (const? (-83886079))) (const? (-335544316))
          (shl (LLVM.or e (const? (-83886080))) (const? 2) { «nsw» := true, «nuw» := false }))
        (LLVM.or e (const? (-83886080))))
      (shl (LLVM.or e (const? (-83886080))) (const? 2) { «nsw» := true, «nuw» := false }) ⊑
    mul
      (mul (shl (LLVM.or e (const? (-83886080))) (const? 2) { «nsw» := true, «nuw» := false })
        (LLVM.or e (const? (-83886080))))
      (shl (LLVM.or e (const? (-83886080))) (const? 2) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shl__nsw_is_safe_thm (e : IntW 32) :
  mul
      (mul
        (select (icmp IntPredicate.eq (LLVM.or e (const? (-83886080))) (const? (-83886079))) (const? (-335544316))
          (shl (LLVM.or e (const? (-83886080))) (const? 2)))
        (LLVM.or e (const? (-83886080))))
      (shl (LLVM.or e (const? (-83886080))) (const? 2)) ⊑
    mul
      (mul (shl (LLVM.or e (const? (-83886080))) (const? 2) { «nsw» := true, «nuw» := false })
        (LLVM.or e (const? (-83886080))))
      (shl (LLVM.or e (const? (-83886080))) (const? 2) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shl_nuw_nsw__none_are_safe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? (-2))) (const? 0)) e
      (ashr e (zext 64 (shl (LLVM.and e_1 (const? (-2))) (const? 2) { «nsw» := true, «nuw» := true }))) ⊑
    ashr e (zext 64 (LLVM.and (shl e_1 (const? 2)) (const? (-8)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shl_nuw__none_are_safe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? (-2))) (const? 0)) e
      (ashr e (zext 64 (shl (LLVM.and e_1 (const? (-2))) (const? 2) { «nsw» := false, «nuw» := true }))) ⊑
    ashr e (zext 64 (LLVM.and (shl e_1 (const? 2)) (const? (-8)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shl_nsw__none_are_safe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? (-2))) (const? 0)) e
      (ashr e (zext 64 (shl (LLVM.and e_1 (const? (-2))) (const? 2) { «nsw» := true, «nuw» := false }))) ⊑
    ashr e (zext 64 (LLVM.and (shl e_1 (const? 2)) (const? (-8)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_shl__none_are_safe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? (-2))) (const? 0)) e
      (ashr e (zext 64 (shl (LLVM.and e_1 (const? (-2))) (const? 2)))) ⊑
    ashr e (zext 64 (LLVM.and (shl e_1 (const? 2)) (const? (-8)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_lshr_exact__exact_is_safe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 60)) (const? 0)) e
      (ashr e (zext 64 (lshr (LLVM.and e_1 (const? 60)) (const? 2)))) ⊑
    ashr e (zext 64 (LLVM.and (lshr e_1 (const? 2)) (const? 15))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_lshr__exact_is_safe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 60)) (const? 0)) e
      (ashr e (zext 64 (lshr (LLVM.and e_1 (const? 60)) (const? 2)))) ⊑
    ashr e (zext 64 (LLVM.and (lshr e_1 (const? 2)) (const? 15))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_lshr_exact__exact_is_unsafe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 63)) (const? 0)) e
      (ashr e (zext 64 (lshr (LLVM.and e_1 (const? 63)) (const? 2)))) ⊑
    ashr e (zext 64 (LLVM.and (lshr e_1 (const? 2)) (const? 15))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_lshr__exact_is_unsafe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 63)) (const? 0)) e
      (ashr e (zext 64 (lshr (LLVM.and e_1 (const? 63)) (const? 2)))) ⊑
    ashr e (zext 64 (LLVM.and (lshr e_1 (const? 2)) (const? 15))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_ashr_exact__exact_is_safe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? (-2147483588))) (const? 0)) e
      (ashr e (zext 64 (ashr (LLVM.and e_1 (const? (-2147483588))) (const? 2)))) ⊑
    ashr e (zext 64 (LLVM.and (ashr e_1 (const? 2)) (const? (-536870897)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_ashr__exact_is_safe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? (-2147483588))) (const? 0)) e
      (ashr e (zext 64 (ashr (LLVM.and e_1 (const? (-2147483588))) (const? 2)))) ⊑
    ashr e (zext 64 (LLVM.and (ashr e_1 (const? 2)) (const? (-536870897)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_ashr_exact__exact_is_unsafe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? (-2147483585))) (const? 0)) e
      (ashr e (zext 64 (ashr (LLVM.and e_1 (const? (-2147483585))) (const? 2)))) ⊑
    ashr e (zext 64 (LLVM.and (ashr e_1 (const? 2)) (const? (-536870897)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_ashr__exact_is_unsafe_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? (-2147483585))) (const? 0)) e
      (ashr e (zext 64 (ashr (LLVM.and e_1 (const? (-2147483585))) (const? 2)))) ⊑
    ashr e (zext 64 (LLVM.and (ashr e_1 (const? 2)) (const? (-536870897)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_add_nuw_nsw__all_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 1073741823)) (const? 3)) (const? 4)
      (add (LLVM.and e (const? 1073741823)) (const? 1) { «nsw» := true, «nuw» := true }) ⊑
    add (LLVM.and e (const? 1073741823)) (const? 1) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_add_nuw__all_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 1073741823)) (const? 3)) (const? 4)
      (add (LLVM.and e (const? 1073741823)) (const? 1) { «nsw» := false, «nuw» := true }) ⊑
    add (LLVM.and e (const? 1073741823)) (const? 1) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_add_nsw__all_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 1073741823)) (const? 3)) (const? 4)
      (add (LLVM.and e (const? 1073741823)) (const? 1) { «nsw» := true, «nuw» := false }) ⊑
    add (LLVM.and e (const? 1073741823)) (const? 1) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_add__all_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 1073741823)) (const? 3)) (const? 4)
      (add (LLVM.and e (const? 1073741823)) (const? 1)) ⊑
    add (LLVM.and e (const? 1073741823)) (const? 1) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_add_nuw_nsw__nuw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 2147483647)) (const? 2147483647)) (const? (-2147483648))
      (add (LLVM.and e (const? 2147483647)) (const? 1) { «nsw» := true, «nuw» := true }) ⊑
    add (LLVM.and e (const? 2147483647)) (const? 1) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_add_nuw__nuw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 2147483647)) (const? 2147483647)) (const? (-2147483648))
      (add (LLVM.and e (const? 2147483647)) (const? 1) { «nsw» := false, «nuw» := true }) ⊑
    add (LLVM.and e (const? 2147483647)) (const? 1) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_add_nsw__nuw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 2147483647)) (const? 2147483647)) (const? (-2147483648))
      (add (LLVM.and e (const? 2147483647)) (const? 1) { «nsw» := true, «nuw» := false }) ⊑
    add (LLVM.and e (const? 2147483647)) (const? 1) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_add__nuw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 2147483647)) (const? 2147483647)) (const? (-2147483648))
      (add (LLVM.and e (const? 2147483647)) (const? 1)) ⊑
    add (LLVM.and e (const? 2147483647)) (const? 1) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_add_nuw_nsw__nsw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.or e (const? (-2147483648))) (const? (-1))) (const? 0)
      (add (LLVM.or e (const? (-2147483648))) (const? 1) { «nsw» := true, «nuw» := true }) ⊑
    add (LLVM.or e (const? (-2147483648))) (const? 1) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_add_nuw__nsw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.or e (const? (-2147483648))) (const? (-1))) (const? 0)
      (add (LLVM.or e (const? (-2147483648))) (const? 1) { «nsw» := false, «nuw» := true }) ⊑
    add (LLVM.or e (const? (-2147483648))) (const? 1) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_add_nsw__nsw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.or e (const? (-2147483648))) (const? (-1))) (const? 0)
      (add (LLVM.or e (const? (-2147483648))) (const? 1) { «nsw» := true, «nuw» := false }) ⊑
    add (LLVM.or e (const? (-2147483648))) (const? 1) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_add__nsw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.or e (const? (-2147483648))) (const? (-1))) (const? 0)
      (add (LLVM.or e (const? (-2147483648))) (const? 1)) ⊑
    add (LLVM.or e (const? (-2147483648))) (const? 1) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_add_nuw_nsw__none_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 3)) (const? 4) (add e (const? 1) { «nsw» := true, «nuw» := true }) ⊑
    add e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_add_nuw__none_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 3)) (const? 4) (add e (const? 1) { «nsw» := false, «nuw» := true }) ⊑
    add e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_add_nsw__none_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 3)) (const? 4) (add e (const? 1) { «nsw» := true, «nuw» := false }) ⊑
    add e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_add__none_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 3)) (const? 4) (add e (const? 1)) ⊑ add e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_nuw_nsw__all_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 255)) (const? 6)) (const? (-260))
      (sub (const? (-254)) (LLVM.and e (const? 255)) { «nsw» := true, «nuw» := true }) ⊑
    sub (const? (-254)) (LLVM.and e (const? 255)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_nuw__all_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 255)) (const? 6)) (const? (-260))
      (sub (const? (-254)) (LLVM.and e (const? 255)) { «nsw» := false, «nuw» := true }) ⊑
    sub (const? (-254)) (LLVM.and e (const? 255)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_nsw__all_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 255)) (const? 6)) (const? (-260))
      (sub (const? (-254)) (LLVM.and e (const? 255)) { «nsw» := true, «nuw» := false }) ⊑
    sub (const? (-254)) (LLVM.and e (const? 255)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub__all_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 255)) (const? 6)) (const? (-260))
      (sub (const? (-254)) (LLVM.and e (const? 255))) ⊑
    sub (const? (-254)) (LLVM.and e (const? 255)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_nuw_nsw__nuw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 2147483647)) (const? 1073741824)) (const? 1073741824)
      (sub (const? (-2147483648)) (LLVM.and e (const? 2147483647)) { «nsw» := true, «nuw» := true }) ⊑
    sub (const? (-2147483648)) (LLVM.and e (const? 2147483647)) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_nuw__nuw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 2147483647)) (const? 1073741824)) (const? 1073741824)
      (sub (const? (-2147483648)) (LLVM.and e (const? 2147483647)) { «nsw» := false, «nuw» := true }) ⊑
    sub (const? (-2147483648)) (LLVM.and e (const? 2147483647)) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_nsw__nuw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 2147483647)) (const? 1073741824)) (const? 1073741824)
      (sub (const? (-2147483648)) (LLVM.and e (const? 2147483647)) { «nsw» := true, «nuw» := false }) ⊑
    sub (const? (-2147483648)) (LLVM.and e (const? 2147483647)) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub__nuw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 2147483647)) (const? 1073741824)) (const? 1073741824)
      (sub (const? (-2147483648)) (LLVM.and e (const? 2147483647))) ⊑
    sub (const? (-2147483648)) (LLVM.and e (const? 2147483647)) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_nuw_nsw__nsw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.or e (const? (-2147483648))) (const? (-2147483647))) (const? (-1))
      (sub (const? (-2147483648)) (LLVM.or e (const? (-2147483648))) { «nsw» := true, «nuw» := true }) ⊑
    sub (const? (-2147483648)) (LLVM.or e (const? (-2147483648))) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_nuw__nsw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.or e (const? (-2147483648))) (const? (-2147483647))) (const? (-1))
      (sub (const? (-2147483648)) (LLVM.or e (const? (-2147483648))) { «nsw» := false, «nuw» := true }) ⊑
    sub (const? (-2147483648)) (LLVM.or e (const? (-2147483648))) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_nsw__nsw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.or e (const? (-2147483648))) (const? (-2147483647))) (const? (-1))
      (sub (const? (-2147483648)) (LLVM.or e (const? (-2147483648))) { «nsw» := true, «nuw» := false }) ⊑
    sub (const? (-2147483648)) (LLVM.or e (const? (-2147483648))) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub__nsw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.or e (const? (-2147483648))) (const? (-2147483647))) (const? (-1))
      (sub (const? (-2147483648)) (LLVM.or e (const? (-2147483648)))) ⊑
    sub (const? (-2147483648)) (LLVM.or e (const? (-2147483648))) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_nuw_nsw__none_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 1)) (const? 2147483647)
      (sub (const? (-2147483648)) e { «nsw» := true, «nuw» := true }) ⊑
    sub (const? (-2147483648)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_nuw__none_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 1)) (const? 2147483647)
      (sub (const? (-2147483648)) e { «nsw» := false, «nuw» := true }) ⊑
    sub (const? (-2147483648)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub_nsw__none_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 1)) (const? 2147483647)
      (sub (const? (-2147483648)) e { «nsw» := true, «nuw» := false }) ⊑
    sub (const? (-2147483648)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_sub__none_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 1)) (const? 2147483647) (sub (const? (-2147483648)) e) ⊑
    sub (const? (-2147483648)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_mul_nuw_nsw__all_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 255)) (const? 17)) (const? 153)
      (mul (LLVM.and e (const? 255)) (const? 9) { «nsw» := true, «nuw» := true }) ⊑
    mul (LLVM.and e (const? 255)) (const? 9) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_mul_nuw__all_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 255)) (const? 17)) (const? 153)
      (mul (LLVM.and e (const? 255)) (const? 9) { «nsw» := false, «nuw» := true }) ⊑
    mul (LLVM.and e (const? 255)) (const? 9) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_mul_nsw__all_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 255)) (const? 17)) (const? 153)
      (mul (LLVM.and e (const? 255)) (const? 9) { «nsw» := true, «nuw» := false }) ⊑
    mul (LLVM.and e (const? 255)) (const? 9) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_mul__all_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 255)) (const? 17)) (const? 153)
      (mul (LLVM.and e (const? 255)) (const? 9)) ⊑
    mul (LLVM.and e (const? 255)) (const? 9) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_mul_nuw_nsw__nuw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 268435457)) (const? 268435456)) (const? (-1879048192))
      (mul (LLVM.and e (const? 268435457)) (const? 9) { «nsw» := true, «nuw» := true }) ⊑
    mul (LLVM.and e (const? 268435457)) (const? 9) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_mul_nuw__nuw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 268435457)) (const? 268435456)) (const? (-1879048192))
      (mul (LLVM.and e (const? 268435457)) (const? 9) { «nsw» := false, «nuw» := true }) ⊑
    mul (LLVM.and e (const? 268435457)) (const? 9) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_mul_nsw__nuw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 268435457)) (const? 268435456)) (const? (-1879048192))
      (mul (LLVM.and e (const? 268435457)) (const? 9) { «nsw» := true, «nuw» := false }) ⊑
    mul (LLVM.and e (const? 268435457)) (const? 9) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_mul__nuw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 268435457)) (const? 268435456)) (const? (-1879048192))
      (mul (LLVM.and e (const? 268435457)) (const? 9)) ⊑
    mul (LLVM.and e (const? 268435457)) (const? 9) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_mul_nuw_nsw__nsw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.or e (const? (-83886080))) (const? (-83886079))) (const? (-754974711))
      (mul (LLVM.or e (const? (-83886080))) (const? 9) { «nsw» := true, «nuw» := true }) ⊑
    mul (LLVM.or e (const? (-83886080))) (const? 9) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_mul_nuw__nsw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.or e (const? (-83886080))) (const? (-83886079))) (const? (-754974711))
      (mul (LLVM.or e (const? (-83886080))) (const? 9) { «nsw» := false, «nuw» := true }) ⊑
    mul (LLVM.or e (const? (-83886080))) (const? 9) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_mul_nsw__nsw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.or e (const? (-83886080))) (const? (-83886079))) (const? (-754974711))
      (mul (LLVM.or e (const? (-83886080))) (const? 9) { «nsw» := true, «nuw» := false }) ⊑
    mul (LLVM.or e (const? (-83886080))) (const? 9) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_mul__nsw_is_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.or e (const? (-83886080))) (const? (-83886079))) (const? (-754974711))
      (mul (LLVM.or e (const? (-83886080))) (const? 9)) ⊑
    mul (LLVM.or e (const? (-83886080))) (const? 9) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_mul_nuw_nsw__none_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 805306368)) (const? (-1342177280))
      (mul e (const? 9) { «nsw» := true, «nuw» := true }) ⊑
    mul e (const? 9) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_mul_nuw__none_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 805306368)) (const? (-1342177280))
      (mul e (const? 9) { «nsw» := false, «nuw» := true }) ⊑
    mul e (const? 9) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_mul_nsw__none_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 805306368)) (const? (-1342177280))
      (mul e (const? 9) { «nsw» := true, «nuw» := false }) ⊑
    mul e (const? 9) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test_mul__none_are_safe_thm (e : IntW 32) :
  select (icmp IntPredicate.eq e (const? 805306368)) (const? (-1342177280)) (mul e (const? 9)) ⊑
    mul e (const? 9) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


