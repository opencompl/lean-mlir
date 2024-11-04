
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gpr53357_proof
theorem src_thm (e e_1 : IntW 32) :
  add (LLVM.and e_1 e) (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))) ⊑ LLVM.xor (LLVM.xor e_1 e) (const? 32 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src2_thm (e e_1 : IntW 32) :
  add (LLVM.and e_1 e) (LLVM.xor (LLVM.or e e_1) (const? 32 (-1))) ⊑ LLVM.xor (LLVM.xor e_1 e) (const? 32 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src3_thm (e e_1 : IntW 32) :
  add (LLVM.and e_1 e) (LLVM.and (LLVM.xor e (const? 32 (-1))) (LLVM.xor e_1 (const? 32 (-1)))) ⊑
    LLVM.xor (LLVM.xor e_1 e) (const? 32 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src4_thm (e e_1 : IntW 32) :
  add (LLVM.and e_1 e) (LLVM.xor (LLVM.or e e_1) (const? 32 (-1))) ⊑ LLVM.xor (LLVM.xor e_1 e) (const? 32 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem src5_thm (e e_1 : IntW 32) :
  add (LLVM.xor (LLVM.or e_1 e) (const? 32 (-1))) (LLVM.and e_1 e) ⊑ LLVM.xor (LLVM.xor e_1 e) (const? 32 (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


