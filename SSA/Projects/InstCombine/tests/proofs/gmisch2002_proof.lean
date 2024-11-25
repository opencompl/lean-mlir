
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gmisch2002_proof
theorem cast_test_2002h08h02_thm (e : IntW 64) : zext 64 (trunc 8 e) ⊑ LLVM.and e (const? 64 255) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem missed_const_prop_2002h12h05_thm (e : IntW 32) :
  add (sub (const? 32 0) e) (add e (add (sub (const? 32 0) (const? 32 1)) (const? 32 1))) ⊑ const? 32 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


