
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gmaskedhmergehandhofhors_proof
theorem p_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor e_2 (const? 32 (-1))) e_1) (LLVM.or e e_2) ⊑
    LLVM.and (LLVM.or e_1 (LLVM.xor e_2 (const? 32 (-1)))) (LLVM.or e e_2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem p_commutative2_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or e_2 e_1) (LLVM.or (LLVM.xor e_1 (const? 32 (-1))) e) ⊑
    LLVM.and (LLVM.or e_2 e_1) (LLVM.or e (LLVM.xor e_1 (const? 32 (-1)))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n2_badmask_thm (e e_1 e_2 e_3 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.xor e_3 (const? 32 (-1))) e_2) (LLVM.or e_1 e) ⊑
    LLVM.and (LLVM.or e_2 (LLVM.xor e_3 (const? 32 (-1)))) (LLVM.or e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n3_constmask_samemask_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.or e_1 (const? 32 (-65281))) (LLVM.or e (const? 32 (-65281))) ⊑
    LLVM.or (LLVM.and e_1 e) (const? 32 (-65281)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


