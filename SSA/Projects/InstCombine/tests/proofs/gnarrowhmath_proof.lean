
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gnarrowhmath_proof
theorem sext_sext_add_thm (e : IntW 32) :
  add (sext 64 (ashr e (const? 32 7))) (sext 64 (ashr e (const? 32 9))) ⊑
    sext 64 (add (ashr e (const? 32 7)) (ashr e (const? 32 9)) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_zext_add_mismatched_exts_thm (e : IntW 32) :
  add (sext 64 (ashr e (const? 32 7))) (zext 64 (lshr e (const? 32 9))) ⊑
    add (sext 64 (ashr e (const? 32 7))) (zext 64 (lshr e (const? 32 9)) { «nneg» := true })
      { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_sext_add_mismatched_types_thm (e : IntW 32) (e_1 : IntW 16) :
  add (sext 64 (ashr e_1 (const? 16 7))) (sext 64 (ashr e (const? 32 9))) ⊑
    add (sext 64 (ashr e_1 (const? 16 7))) (sext 64 (ashr e (const? 32 9))) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test5_thm (e : IntW 32) :
  add (sext 64 (ashr e (const? 32 1))) (const? 64 1073741823) ⊑
    sext 64 (add (ashr e (const? 32 1)) (const? 32 1073741823) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test6_thm (e : IntW 32) :
  add (sext 64 (ashr e (const? 32 1))) (const? 64 (-1073741824)) ⊑
    sext 64 (add (ashr e (const? 32 1)) (const? 32 (-1073741824)) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test7_thm (e : IntW 32) :
  add (zext 64 (lshr e (const? 32 1))) (const? 64 2147483647) ⊑
    zext 64 (add (lshr e (const? 32 1)) (const? 32 2147483647) { «nsw» := false, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test8_thm (e : IntW 32) :
  mul (sext 64 (ashr e (const? 32 16))) (const? 64 32767) ⊑
    sext 64 (mul (ashr e (const? 32 16)) (const? 32 32767) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test9_thm (e : IntW 32) :
  mul (sext 64 (ashr e (const? 32 16))) (const? 64 (-32767)) ⊑
    sext 64 (mul (ashr e (const? 32 16)) (const? 32 (-32767)) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test10_thm (e : IntW 32) :
  mul (zext 64 (lshr e (const? 32 16))) (const? 64 65535) ⊑
    zext 64 (mul (lshr e (const? 32 16)) (const? 32 65535) { «nsw» := false, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15_thm (e : IntW 32) :
  sub (const? 64 8) (sext 64 (ashr e (const? 32 1))) ⊑
    sext 64 (sub (const? 32 8) (ashr e (const? 32 1)) { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test16_thm (e : IntW 32) :
  sub (const? 64 4294967294) (zext 64 (lshr e (const? 32 1))) ⊑
    zext 64 (sub (const? 32 (-2)) (lshr e (const? 32 1)) { «nsw» := false, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


