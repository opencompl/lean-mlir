
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gshouldhchangehtype_proof
theorem test1_thm (e e_1 : IntW 8) : trunc 8 (add (zext 64 e_1) (zext 64 e)) ⊑ add e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e e_1 : IntW 16) : trunc 16 (add (zext 64 e_1) (zext 64 e)) ⊑ add e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test3_thm (e e_1 : IntW 32) : trunc 32 (add (zext 64 e_1) (zext 64 e)) ⊑ add e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4_thm (e e_1 : IntW 9) :
  trunc 9 (add (zext 64 e_1) (zext 64 e)) ⊑
    trunc 9 (add (zext 64 e_1) (zext 64 e) { «nsw» := true, «nuw» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
