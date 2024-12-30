
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gapinthxor2_proof
theorem test1_thm (e e_1 : IntW 447) :
  LLVM.xor (LLVM.and e_1 (const? 447 70368744177664)) (LLVM.and e (const? 447 70368744177663)) ⊑
    LLVM.or (LLVM.and e_1 (const? 447 70368744177664)) (LLVM.and e (const? 447 70368744177663))
      { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e : IntW 1005) : LLVM.xor e (const? 1005 0) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e : IntW 123) : LLVM.xor e e ⊑ const? 123 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4_thm (e : IntW 737) : LLVM.xor e (LLVM.xor (const? 737 (-1)) e) ⊑ const? 737 (-1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test5_thm (e : IntW 700) :
  LLVM.xor (LLVM.or e (const? 700 288230376151711743)) (const? 700 288230376151711743) ⊑
    LLVM.and e (const? 700 (-288230376151711744)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test6_thm (e : IntW 77) : LLVM.xor (LLVM.xor e (const? 77 23)) (const? 77 23) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test7_thm (e : IntW 1023) :
  LLVM.xor (LLVM.or e (const? 1023 70368744177663)) (const? 1023 703687463) ⊑
    LLVM.or (LLVM.and e (const? 1023 (-70368744177664))) (const? 1023 70368040490200) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


