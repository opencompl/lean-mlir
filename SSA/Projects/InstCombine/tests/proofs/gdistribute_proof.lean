
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gdistribute_proof
theorem factorize_thm (e : IntW 32) : LLVM.and (LLVM.or e (const? 32 1)) (LLVM.or e (const? 32 2)) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem factorize2_thm (e : IntW 32) : sub (mul (const? 32 3) e) (mul (const? 32 2) e) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem factorize3_thm (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or e_2 (LLVM.or e_1 e)) (LLVM.or e_2 e) ⊑ LLVM.or e_2 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem factorize4_thm (e e_1 : IntW 32) : sub (mul (shl e_1 (const? 32 1)) e) (mul e e_1) ⊑ mul e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem factorize5_thm (e e_1 : IntW 32) : sub (mul (mul e_1 (const? 32 2)) e) (mul e e_1) ⊑ mul e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem expand_thm (e : IntW 32) :
  LLVM.and (LLVM.or (LLVM.and e (const? 32 1)) (const? 32 2)) (const? 32 1) ⊑ LLVM.and e (const? 32 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


