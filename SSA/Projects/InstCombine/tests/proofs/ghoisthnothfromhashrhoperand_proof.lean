
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section ghoisthnothfromhashrhoperand_proof
theorem t0_thm (e e_1 : IntW 8) :
  ashr (LLVM.xor e_1 (const? 8 (-1))) e ⊑ LLVM.xor (ashr e_1 e) (const? 8 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_thm (e e_1 : IntW 8) :
  ashr (LLVM.xor e_1 (const? 8 (-1))) e { «exact» := true } ⊑ LLVM.xor (ashr e_1 e) (const? 8 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


