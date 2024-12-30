
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000

section ghoisthnegationhouthofhbiashcalculationhwithhconstant_proof
theorem t0_thm (e : IntW 8) :
  sub (LLVM.and e (const? 8 42)) e ⊑ sub (const? 8 0) (LLVM.and e (const? 8 (-43))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n5_thm (e : IntW 8) : sub e (LLVM.and e (const? 8 42)) ⊑ LLVM.and e (const? 8 (-43)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


