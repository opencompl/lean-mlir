
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gfreehinversion_proof
theorem xor_1_thm (e e_1 e_2 : IntW 8) (e_3 : IntW 1) :
  LLVM.xor (LLVM.xor (select e_3 (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor e_1 (const? 8 123))) e) (const? 8 (-1)) ⊑
    LLVM.xor (select e_3 e_2 (LLVM.xor e_1 (const? 8 (-124)))) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_2_thm (e e_1 : IntW 8) (e_2 : IntW 1) (e_3 : IntW 8) :
  LLVM.xor (LLVM.xor e_3 (select e_2 (LLVM.xor e_1 (const? 8 (-1))) (LLVM.xor e (const? 8 123)))) (const? 8 (-1)) ⊑
    LLVM.xor e_3 (select e_2 e_1 (LLVM.xor e (const? 8 (-124)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_1_thm (e e_1 e_2 : IntW 8) (e_3 : IntW 1) :
  LLVM.xor (add (select e_3 (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor e_1 (const? 8 123))) e) (const? 8 (-1)) ⊑
    sub (select e_3 e_2 (LLVM.xor e_1 (const? 8 (-124)))) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_2_thm (e e_1 : IntW 8) (e_2 : IntW 1) (e_3 : IntW 8) :
  LLVM.xor (add e_3 (select e_2 (LLVM.xor e_1 (const? 8 (-1))) (LLVM.xor e (const? 8 123)))) (const? 8 (-1)) ⊑
    sub (select e_2 e_1 (LLVM.xor e (const? 8 (-124)))) e_3 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_1_thm (e e_1 e_2 : IntW 8) (e_3 : IntW 1) :
  LLVM.xor (sub (select e_3 (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor e_1 (const? 8 123))) e) (const? 8 (-1)) ⊑
    add (select e_3 e_2 (LLVM.xor e_1 (const? 8 (-124)))) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_2_thm (e e_1 : IntW 8) (e_2 : IntW 1) (e_3 : IntW 8) :
  LLVM.xor (sub e_3 (select e_2 (LLVM.xor e_1 (const? 8 (-1))) (LLVM.xor e (const? 8 123)))) (const? 8 (-1)) ⊑
    sub (const? 8 (-2)) (add (select e_2 e_1 (LLVM.xor e (const? 8 (-124)))) e_3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_3_thm (e e_1 : IntW 128) (e_2 : IntW 1) (e_3 : IntW 128) :
  LLVM.xor (sub e_3 (select e_2 (LLVM.xor e_1 (const? 128 (-1))) (LLVM.xor e (const? 128 123)))) (const? 128 (-1)) ⊑
    sub (const? 128 (-2)) (add (select e_2 e_1 (LLVM.xor e (const? 128 (-124)))) e_3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_1_thm (e e_1 e_2 : IntW 8) (e_3 : IntW 1) :
  LLVM.xor (ashr (select e_3 (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor e_1 (const? 8 123))) e) (const? 8 (-1)) ⊑
    ashr (select e_3 e_2 (LLVM.xor e_1 (const? 8 (-124)))) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_1_thm (e e_1 : IntW 8) (e_2 : IntW 1) (e_3 e_4 : IntW 8) (e_5 : IntW 1) :
  LLVM.xor
      (select e_5 (LLVM.xor e_4 (LLVM.xor e_3 (const? 8 45)))
        (select e_2 (LLVM.xor e_1 (const? 8 (-1))) (LLVM.xor e (const? 8 123))))
      (const? 8 (-1)) ⊑
    select e_5 (LLVM.xor (LLVM.xor e_3 e_4) (const? 8 (-46))) (select e_2 e_1 (LLVM.xor e (const? 8 (-124)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_2_thm (e e_1 e_2 : IntW 8) (e_3 e_4 : IntW 1) :
  LLVM.xor
      (select e_4 (select e_3 (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor e_1 (const? 8 123))) (LLVM.xor e (const? 8 45)))
      (const? 8 (-1)) ⊑
    select e_4 (select e_3 e_2 (LLVM.xor e_1 (const? 8 (-124)))) (LLVM.xor e (const? 8 (-46))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_not_nneg2_thm (e : IntW 8) :
  LLVM.xor (lshr (LLVM.xor e (const? 8 (-1))) (const? 8 1)) (const? 8 (-1)) ⊑
    LLVM.or (lshr e (const? 8 1)) (const? 8 (-128)) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


