
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gandhxorhmerge_proof
theorem test1_thm (e e_1 e_2 : IntW 32) :
  LLVM.xor (LLVM.and e_2 e_1) (LLVM.and e_2 e) ⊑ LLVM.and e_2 (LLVM.xor e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e e_1 : IntW 32) : LLVM.xor (LLVM.and e_1 e) (LLVM.or e_1 e) ⊑ LLVM.xor e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR38781_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.xor (lshr e_1 (const? 32 31)) (const? 32 1)) (LLVM.xor (lshr e (const? 32 31)) (const? 32 1)) ⊑
    zext 32 (icmp IntPredicate.sgt (LLVM.or e_1 e) (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR75692_1_thm (e : IntW 32) :
  LLVM.and (LLVM.xor e (const? 32 4)) (LLVM.xor e (const? 32 (-5))) ⊑ const? 32 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


