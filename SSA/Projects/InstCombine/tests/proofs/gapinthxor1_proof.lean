
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gapinthxor1_proof
theorem test1_thm (e e_1 : IntW 47) :
  LLVM.xor (LLVM.and e_1 (const? 47 (-70368744177664))) (LLVM.and e (const? 47 70368744177661)) ⊑
    LLVM.or (LLVM.and e_1 (const? 47 (-70368744177664))) (LLVM.and e (const? 47 70368744177661))
      { «disjoint» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e : IntW 15) : LLVM.xor e (const? 15 0) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e : IntW 23) : LLVM.xor e e ⊑ const? 23 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4_thm (e : IntW 37) : LLVM.xor e (LLVM.xor (const? 37 (-1)) e) ⊑ const? 37 (-1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test5_thm (e : IntW 7) :
  LLVM.xor (LLVM.or e (const? 7 23)) (const? 7 23) ⊑ LLVM.and e (const? 7 (-24)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test6_thm (e : IntW 7) : LLVM.xor (LLVM.xor e (const? 7 23)) (const? 7 23) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test7_thm (e : IntW 47) :
  LLVM.xor (LLVM.or e (const? 47 70368744177663)) (const? 47 703687463) ⊑
    LLVM.or (LLVM.and e (const? 47 (-70368744177664))) (const? 47 70368040490200) { «disjoint» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


