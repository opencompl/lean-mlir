
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcomparehsigns_proof
theorem test1_thm (e e_1 : IntW 32) :
  zext 32 (LLVM.xor (icmp IntPredicate.slt e_1 (const? 0)) (icmp IntPredicate.sgt e (const? (-1)))) ⊑
    zext 32 (icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test2_thm (e e_1 : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and e_1 (const? 8)) (LLVM.and e (const? 8))) ⊑
    LLVM.xor (LLVM.and (lshr (LLVM.xor e_1 e) (const? 3)) (const? 1)) (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e e_1 : IntW 32) :
  zext 32 (icmp IntPredicate.eq (lshr e_1 (const? 31)) (lshr e (const? 31))) ⊑
    zext 32 (icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3i_thm (e e_1 : IntW 32) :
  zext 32
      (icmp IntPredicate.eq (LLVM.or (lshr e_1 (const? 29)) (const? 35)) (LLVM.or (lshr e (const? 29)) (const? 35))) ⊑
    zext 32 (icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4a_thm (e : IntW 32) :
  icmp IntPredicate.slt (LLVM.or (ashr e (const? 31)) (lshr (sub (const? 0) e) (const? 31))) (const? 1) ⊑
    icmp IntPredicate.slt e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4b_thm (e : IntW 64) :
  icmp IntPredicate.slt (LLVM.or (ashr e (const? 63)) (lshr (sub (const? 0) e) (const? 63))) (const? 1) ⊑
    icmp IntPredicate.slt e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4c_thm (e : IntW 64) :
  icmp IntPredicate.slt (trunc 32 (LLVM.or (ashr e (const? 63)) (lshr (sub (const? 0) e) (const? 63)))) (const? 1) ⊑
    icmp IntPredicate.slt e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shift_trunc_signbit_test_thm (e : IntW 32) :
  icmp IntPredicate.slt (trunc 8 (lshr e (const? 24))) (const? 0) ⊑ icmp IntPredicate.slt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem shift_trunc_wrong_shift_thm (e : IntW 32) :
  icmp IntPredicate.slt (trunc 8 (lshr e (const? 23))) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 1073741824)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


