
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gandhorhand_proof
theorem test1_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.or (LLVM.and e_1 (const? 32 7)) (LLVM.and e (const? 32 8))) (const? 32 7) ⊑
    LLVM.and e_1 (const? 32 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e : IntW 8) (e_1 : IntW 32) :
  LLVM.and (LLVM.or e_1 (zext 32 e)) (const? 32 65536) ⊑ LLVM.and e_1 (const? 32 65536) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.or e_1 (shl e (const? 32 1))) (const? 32 1) ⊑ LLVM.and e_1 (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4_thm (e e_1 : IntW 32) :
  LLVM.and (LLVM.or e_1 (lshr e (const? 32 31))) (const? 32 2) ⊑ LLVM.and e_1 (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_test1_thm (e : IntW 32) : LLVM.or (LLVM.and e (const? 32 1)) (const? 32 1) ⊑ const? 32 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_test2_thm (e : IntW 8) : LLVM.or (shl e (const? 8 7)) (const? 8 (-128)) ⊑ const? 8 (-128) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


