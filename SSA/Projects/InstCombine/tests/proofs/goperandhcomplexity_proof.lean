
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section goperandhcomplexity_proof
theorem neg_thm :
  ∀ (e : IntW 8),
    LLVM.xor (sub (const? 0) e) (LLVM.udiv e (const? 42)) ⊑
      LLVM.xor (LLVM.udiv e (const? 42)) (sub (const? 0) e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_thm :
  ∀ (e : IntW 8),
    mul (LLVM.xor (const? (-1)) e) (LLVM.udiv e (const? 42)) ⊑
      mul (LLVM.udiv e (const? 42)) (LLVM.xor e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


