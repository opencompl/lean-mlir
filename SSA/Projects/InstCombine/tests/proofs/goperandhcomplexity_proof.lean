
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section goperandhcomplexity_proof
theorem neg_thm (e : IntW 8) :
  LLVM.xor (sub (const? 8 0) e) (LLVM.udiv e (const? 8 42)) ⊑
    LLVM.xor (LLVM.udiv e (const? 8 42)) (sub (const? 8 0) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_thm (e : IntW 8) :
  mul (LLVM.xor (const? 8 (-1)) e) (LLVM.udiv e (const? 8 42)) ⊑
    mul (LLVM.udiv e (const? 8 42)) (LLVM.xor e (const? 8 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
