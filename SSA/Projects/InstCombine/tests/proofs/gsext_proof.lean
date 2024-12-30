
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000

section gsext_proof
theorem test4_thm (e : IntW 32) :
  sext 64 (LLVM.udiv e (const? 32 3)) ⊑ zext 64 (LLVM.udiv e (const? 32 3)) { «nneg» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test5_thm (e : IntW 32) :
  sext 64 (urem e (const? 32 30000)) ⊑ zext 64 (urem e (const? 32 30000)) { «nneg» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test6_thm (e : IntW 32) :
  sext 64 (mul (lshr e (const? 32 3)) (const? 32 3)) ⊑
    zext 64 (mul (lshr e (const? 32 3)) (const? 32 3) { «nsw» := true, «nuw» := true }) { «nneg» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test7_thm (e : IntW 32) :
  sext 64 (sub (const? 32 20000) (LLVM.and e (const? 32 511))) ⊑
    zext 64 (sub (const? 32 20000) (LLVM.and e (const? 32 511)) { «nsw» := true, «nuw» := true })
      { «nneg» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test10_thm (e : IntW 32) :
  sext 32 (ashr (shl (trunc 8 e) (const? 8 6)) (const? 8 6)) ⊑
    ashr (shl e (const? 32 30)) (const? 32 30) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test13_thm (e : IntW 32) :
  sext 32 (icmp IntPredicate.eq (LLVM.and e (const? 32 8)) (const? 32 0)) ⊑
    add (LLVM.and (lshr e (const? 32 3)) (const? 32 1)) (const? 32 (-1)) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test14_thm (e : IntW 16) :
  sext 32 (icmp IntPredicate.ne (LLVM.and e (const? 16 16)) (const? 16 16)) ⊑
    sext 32
      (add (LLVM.and (lshr e (const? 16 4)) (const? 16 1)) (const? 16 (-1)) { «nsw» := true, «nuw» := false }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15_thm (e : IntW 32) :
  sext 32 (icmp IntPredicate.ne (LLVM.and e (const? 32 16)) (const? 32 0)) ⊑
    ashr (shl e (const? 32 27)) (const? 32 31) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test16_thm (e : IntW 16) :
  sext 32 (icmp IntPredicate.eq (LLVM.and e (const? 16 8)) (const? 16 8)) ⊑
    sext 32 (ashr (shl e (const? 16 12)) (const? 16 15)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test17_thm (e : IntW 1) : sub (const? 32 0) (sext 32 e) ⊑ zext 32 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test19_thm (e : IntW 10) :
  sext 10 (ashr (shl (trunc 3 e) (const? 3 2)) (const? 3 2)) ⊑
    sext 10 (sub (const? 3 0) (LLVM.and (trunc 3 e) (const? 3 1)) { «nsw» := true, «nuw» := false }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem smear_set_bit_thm (e : IntW 32) :
  sext 32 (ashr (trunc 8 e) (const? 8 7)) ⊑ ashr (shl e (const? 32 24)) (const? 32 31) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem smear_set_bit_different_dest_type_thm (e : IntW 32) :
  sext 16 (ashr (trunc 8 e) (const? 8 7)) ⊑
    trunc 16 (ashr (shl e (const? 32 24)) (const? 32 31)) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem smear_set_bit_different_dest_type_wider_dst_thm (e : IntW 32) :
  sext 64 (ashr (trunc 8 e) (const? 8 7)) ⊑ sext 64 (ashr (shl e (const? 32 24)) (const? 32 31)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


