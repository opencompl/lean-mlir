
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gapinthadd_proof
theorem test1_thm (e : IntW 1) : add (LLVM.xor e (const? 1 1)) (const? 1 1) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e : IntW 47) :
  add (LLVM.xor e (const? 47 (-70368744177664))) (const? 47 (-70368744177664)) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e : IntW 15) : add (LLVM.xor e (const? 15 (-16384))) (const? 15 (-16384)) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4_thm (e : IntW 49) : add (LLVM.and e (const? 49 (-2))) (const? 49 1) ⊑ LLVM.or e (const? 49 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_thm (e : IntW 4) :
  add (zext 7 (LLVM.xor e (const? 4 (-8)))) (const? 7 (-8)) { «nsw» := true, «nuw» := false } ⊑ sext 7 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_multiuse_thm (e : IntW 4) :
  LLVM.sdiv
      (trunc 4
        (LLVM.sdiv (zext 7 (LLVM.xor e (const? 4 (-8))))
          (add (zext 7 (LLVM.xor e (const? 4 (-8)))) (const? 7 (-8)) { «nsw» := true, «nuw» := false })))
      (LLVM.xor e (const? 4 (-8))) ⊑
    LLVM.sdiv (trunc 4 (LLVM.sdiv (zext 7 (LLVM.xor e (const? 4 (-8)))) (sext 7 e)))
      (LLVM.xor e (const? 4 (-8))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test5_thm (e : IntW 111) :
  add (LLVM.xor e (shl (const? 111 1) (const? 111 110))) (shl (const? 111 1) (const? 111 110)) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test6_thm (e : IntW 65) :
  add (LLVM.xor e (shl (const? 65 1) (const? 65 64))) (shl (const? 65 1) (const? 65 64)) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test7_thm (e : IntW 1024) :
  add (LLVM.xor e (shl (const? 1024 1) (const? 1024 1023))) (shl (const? 1024 1) (const? 1024 1023)) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test8_thm (e : IntW 128) :
  add (LLVM.xor e (ashr (shl (const? 128 1) (const? 128 127)) (const? 128 120))) (shl (const? 128 1) (const? 128 127)) ⊑
    LLVM.xor e (const? 128 170141183460469231731687303715884105600) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test9_thm (e : IntW 77) :
  add (LLVM.and e (const? 77 562949953421310)) (const? 77 1) ⊑
    LLVM.or (LLVM.and e (const? 77 562949953421310)) (const? 77 1) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
