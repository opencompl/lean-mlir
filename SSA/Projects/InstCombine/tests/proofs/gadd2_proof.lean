
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gadd2_proof
theorem test1_thm (e : IntW 64) (e_1 : IntW 32) :
  LLVM.and (add (shl (zext 64 e_1) (const? 64 32)) e) (const? 64 123) ⊑ LLVM.and e (const? 64 123) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e : IntW 32) :
  add (LLVM.and e (const? 32 7)) (LLVM.and e (const? 32 32)) ⊑ LLVM.and e (const? 32 39) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e : IntW 32) :
  add (LLVM.and e (const? 32 128)) (lshr e (const? 32 30)) ⊑
    LLVM.or (LLVM.and e (const? 32 128)) (lshr e (const? 32 30)) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4_thm (e : IntW 32) :
  add e e { «nsw» := false, «nuw» := true } ⊑ shl e (const? 32 1) { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test9_thm (e : IntW 16) :
  add (mul e (const? 16 2)) (mul e (const? 16 32767)) ⊑ mul e (const? 16 (-32767)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test10_thm (e e_1 : IntW 32) :
  add (add e_1 (const? 32 1))
      (LLVM.xor (LLVM.or (ashr e (const? 32 3)) (const? 32 (-1431655766))) (const? 32 1431655765)) ⊑
    sub e_1 (LLVM.and (ashr e (const? 32 3)) (const? 32 1431655765)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test11_thm (e e_1 : IntW 32) :
  add (add e_1 (const? 32 1)) (LLVM.xor (LLVM.or e (const? 32 (-1431655766))) (const? 32 1431655765)) ⊑
    sub e_1 (LLVM.and e (const? 32 1431655765)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test12_thm (e e_1 : IntW 32) :
  add (add e_1 (const? 32 1) { «nsw» := true, «nuw» := false })
      (LLVM.xor (LLVM.or e (const? 32 (-1431655766))) (const? 32 1431655765)) { «nsw» := true, «nuw» := false } ⊑
    sub e_1 (LLVM.and e (const? 32 1431655765)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test13_thm (e e_1 : IntW 32) :
  add (add e_1 (const? 32 1)) (LLVM.xor (LLVM.or e (const? 32 (-1431655767))) (const? 32 1431655766)) ⊑
    sub e_1 (LLVM.and e (const? 32 1431655766)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test14_thm (e e_1 : IntW 32) :
  add (add e_1 (const? 32 1) { «nsw» := true, «nuw» := false })
      (LLVM.xor (LLVM.or e (const? 32 (-1431655767))) (const? 32 1431655766)) { «nsw» := true, «nuw» := false } ⊑
    sub e_1 (LLVM.and e (const? 32 1431655766)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15_thm (e e_1 : IntW 32) :
  add (add e_1 (const? 32 1)) (LLVM.xor (LLVM.and e (const? 32 (-1431655767))) (const? 32 (-1431655767))) ⊑
    sub e_1 (LLVM.or e (const? 32 1431655766)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test16_thm (e e_1 : IntW 32) :
  add (add e_1 (const? 32 1) { «nsw» := true, «nuw» := false })
      (LLVM.xor (LLVM.and e (const? 32 (-1431655767))) (const? 32 (-1431655767))) { «nsw» := true, «nuw» := false } ⊑
    sub e_1 (LLVM.or e (const? 32 1431655766)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test17_thm (e e_1 : IntW 32) :
  add (LLVM.xor (LLVM.and e_1 (const? 32 (-1431655766))) (const? 32 (-1431655765))) e
      { «nsw» := true, «nuw» := false } ⊑
    sub e (LLVM.or e_1 (const? 32 1431655765)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test18_thm (e e_1 : IntW 32) :
  add (add e_1 (const? 32 1) { «nsw» := true, «nuw» := false })
      (LLVM.xor (LLVM.and e (const? 32 (-1431655766))) (const? 32 (-1431655766))) { «nsw» := true, «nuw» := false } ⊑
    sub e_1 (LLVM.or e (const? 32 1431655765)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_nsw_mul_nsw_thm (e : IntW 16) :
  add (add e e { «nsw» := true, «nuw» := false }) e { «nsw» := true, «nuw» := false } ⊑
    mul e (const? 16 3) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_add_to_mul_1_thm (e : IntW 16) :
  add e (mul e (const? 16 8) { «nsw» := true, «nuw» := false }) { «nsw» := true, «nuw» := false } ⊑
    mul e (const? 16 9) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_add_to_mul_2_thm (e : IntW 16) :
  add (mul e (const? 16 8) { «nsw» := true, «nuw» := false }) e { «nsw» := true, «nuw» := false } ⊑
    mul e (const? 16 9) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_add_to_mul_3_thm (e : IntW 16) :
  add (mul e (const? 16 2)) (mul e (const? 16 3)) { «nsw» := true, «nuw» := false } ⊑ mul e (const? 16 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_add_to_mul_4_thm (e : IntW 16) :
  add (mul e (const? 16 2) { «nsw» := true, «nuw» := false }) (mul e (const? 16 7) { «nsw» := true, «nuw» := false })
      { «nsw» := true, «nuw» := false } ⊑
    mul e (const? 16 9) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_add_to_mul_5_thm (e : IntW 16) :
  add (mul e (const? 16 3) { «nsw» := true, «nuw» := false }) (mul e (const? 16 7) { «nsw» := true, «nuw» := false })
      { «nsw» := true, «nuw» := false } ⊑
    mul e (const? 16 10) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_add_to_mul_6_thm (e e_1 : IntW 32) :
  add (mul e_1 e { «nsw» := true, «nuw» := false })
      (mul (mul e_1 e { «nsw» := true, «nuw» := false }) (const? 32 5) { «nsw» := true, «nuw» := false })
      { «nsw» := true, «nuw» := false } ⊑
    mul (mul e_1 e { «nsw» := true, «nuw» := false }) (const? 32 6) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_add_to_mul_7_thm (e : IntW 16) :
  add e (mul e (const? 16 32767) { «nsw» := true, «nuw» := false }) { «nsw» := true, «nuw» := false } ⊑
    shl e (const? 16 15) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_add_to_mul_8_thm (e : IntW 16) :
  add (mul e (const? 16 16383) { «nsw» := true, «nuw» := false })
      (mul e (const? 16 16384) { «nsw» := true, «nuw» := false }) { «nsw» := true, «nuw» := false } ⊑
    mul e (const? 16 32767) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_add_to_mul_9_thm (e : IntW 16) :
  add (mul e (const? 16 16384) { «nsw» := true, «nuw» := false })
      (mul e (const? 16 16384) { «nsw» := true, «nuw» := false }) { «nsw» := true, «nuw» := false } ⊑
    shl e (const? 16 15) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_or_and_thm (e e_1 : IntW 32) : add (LLVM.or e_1 e) (LLVM.and e_1 e) ⊑ add e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_or_and_commutative_thm (e e_1 : IntW 32) : add (LLVM.or e_1 e) (LLVM.and e e_1) ⊑ add e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_and_or_thm (e e_1 : IntW 32) : add (LLVM.and e_1 e) (LLVM.or e_1 e) ⊑ add e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_and_or_commutative_thm (e e_1 : IntW 32) : add (LLVM.and e_1 e) (LLVM.or e e_1) ⊑ add e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_nsw_or_and_thm (e e_1 : IntW 32) :
  add (LLVM.or e_1 e) (LLVM.and e_1 e) { «nsw» := true, «nuw» := false } ⊑
    add e_1 e { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_nuw_or_and_thm (e e_1 : IntW 32) :
  add (LLVM.or e_1 e) (LLVM.and e_1 e) { «nsw» := false, «nuw» := true } ⊑
    add e_1 e { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_nuw_nsw_or_and_thm (e e_1 : IntW 32) :
  add (LLVM.or e_1 e) (LLVM.and e_1 e) { «nsw» := true, «nuw» := true } ⊑
    add e_1 e { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_of_mul_thm (e e_1 e_2 : IntW 8) :
  add (mul e_2 e_1 { «nsw» := true, «nuw» := false }) (mul e_2 e { «nsw» := true, «nuw» := false })
      { «nsw» := true, «nuw» := false } ⊑
    mul e_2 (add e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_of_selects_thm (e : IntW 32) (e_1 : IntW 1) :
  add (select e_1 (const? 32 0) (const? 32 (-2))) (select e_1 e (const? 32 2)) ⊑ select e_1 e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_undemanded_low_bits_thm (e : IntW 32) :
  lshr (add (LLVM.or e (const? 32 15)) (const? 32 1616)) (const? 32 4) ⊑
    lshr (add e (const? 32 1616)) (const? 32 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_undemanded_low_bits_thm (e : IntW 32) :
  lshr (sub (LLVM.or e (const? 32 15)) (const? 32 1616)) (const? 32 4) ⊑
    lshr (add e (const? 32 (-1616))) (const? 32 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


