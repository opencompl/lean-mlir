
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gcomparehsigns_proof
theorem test1_thm (e e_1 : IntW 32) :
  zext 32 (LLVM.xor (icmp IntPredicate.slt e_1 (const? 32 0)) (icmp IntPredicate.sgt e (const? 32 (-1)))) ⊑
    zext 32 (icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? 32 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e e_1 : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 8)) (LLVM.and e (const? 32 8))) ⊑
    LLVM.xor (LLVM.and (lshr (LLVM.xor e_1 e) (const? 32 3)) (const? 32 1)) (const? 32 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e e_1 : IntW 32) :
  zext 32 (icmp IntPredicate.eq (lshr e_1 (const? 32 31)) (lshr e (const? 32 31))) ⊑
    zext 32 (icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? 32 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3i_thm (e e_1 : IntW 32) :
  zext 32
      (icmp IntPredicate.eq (LLVM.or (lshr e_1 (const? 32 29)) (const? 32 35))
        (LLVM.or (lshr e (const? 32 29)) (const? 32 35))) ⊑
    zext 32 (icmp IntPredicate.sgt (LLVM.xor e_1 e) (const? 32 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4a_thm (e : IntW 32) :
  icmp IntPredicate.slt (LLVM.or (ashr e (const? 32 31)) (lshr (sub (const? 32 0) e) (const? 32 31))) (const? 32 1) ⊑
    icmp IntPredicate.slt e (const? 32 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4b_thm (e : IntW 64) :
  icmp IntPredicate.slt (LLVM.or (ashr e (const? 64 63)) (lshr (sub (const? 64 0) e) (const? 64 63))) (const? 64 1) ⊑
    icmp IntPredicate.slt e (const? 64 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4c_thm (e : IntW 64) :
  icmp IntPredicate.slt (trunc 32 (LLVM.or (ashr e (const? 64 63)) (lshr (sub (const? 64 0) e) (const? 64 63))))
      (const? 32 1) ⊑
    icmp IntPredicate.slt e (const? 64 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shift_trunc_signbit_test_thm (e : IntW 32) :
  icmp IntPredicate.slt (trunc 8 (lshr e (const? 32 24))) (const? 8 0) ⊑ icmp IntPredicate.slt e (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shift_trunc_wrong_shift_thm (e : IntW 32) :
  icmp IntPredicate.slt (trunc 8 (lshr e (const? 32 23))) (const? 8 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 32 1073741824)) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shift_trunc_wrong_cmp_thm (e : IntW 32) :
  icmp IntPredicate.slt (trunc 8 (lshr e (const? 32 24))) (const? 8 1) ⊑
    icmp IntPredicate.slt (trunc 8 (lshr e (const? 32 24)) { «nsw» := false, «nuw» := true }) (const? 8 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


