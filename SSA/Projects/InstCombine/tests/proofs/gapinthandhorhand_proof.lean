
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gapinthandhorhand_proof
theorem test1_thm (e e_1 : IntW 17) :
  LLVM.and (LLVM.or (LLVM.and e_1 (const? 17 7)) (LLVM.and e (const? 17 8))) (const? 17 7) ⊑
    LLVM.and e_1 (const? 17 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e e_1 : IntW 49) :
  LLVM.and (LLVM.or e_1 (shl e (const? 49 1))) (const? 49 1) ⊑ LLVM.and e_1 (const? 49 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4_thm (e e_1 : IntW 67) :
  LLVM.and (LLVM.or e_1 (lshr e (const? 67 66))) (const? 67 2) ⊑ LLVM.and e_1 (const? 67 2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_test1_thm (e : IntW 231) : LLVM.or (LLVM.and e (const? 231 1)) (const? 231 1) ⊑ const? 231 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_test2_thm (e : IntW 7) : LLVM.or (shl e (const? 7 6)) (const? 7 (-64)) ⊑ const? 7 (-64) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


