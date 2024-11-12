
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section g2006h11h10hashrhmiscompile_proof
theorem test_thm (e : IntW 8) :
  lshr (const? 32 (-1)) (zext 32 e) ⊑ lshr (const? 32 (-1)) (zext 32 e { «nneg» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


