
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gfoldhinchofhaddhofhnothxhandhyhtohsubhxhfromhy_proof
theorem t0_thm (e e_1 : IntW 32) : add (add (LLVM.xor e_1 (const? 32 (-1))) e) (const? 32 1) ⊑ sub e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n12_thm (e e_1 : IntW 32) :
  add (add (LLVM.xor e_1 (const? 32 (-1))) e) (const? 32 2) ⊑
    add (add e (LLVM.xor e_1 (const? 32 (-1)))) (const? 32 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


