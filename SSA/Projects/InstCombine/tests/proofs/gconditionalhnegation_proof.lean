
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000

section gconditionalhnegation_proof
theorem t0_thm (e : IntW 8) (e_1 : IntW 1) :
  LLVM.xor (add (sext 8 e_1) e) (sext 8 e_1) ⊑ select e_1 (sub (const? 8 0) e) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_thm (e : IntW 8) (e_1 : IntW 1) :
  LLVM.xor (add (sext 8 e_1) e) (sext 8 e_1) ⊑ select e_1 (sub (const? 8 0) e) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t2_thm (e : IntW 1) (e_1 : IntW 8) (e_2 : IntW 1) :
  LLVM.xor (add (sext 8 e_2) e_1) (sext 8 e) ⊑ LLVM.xor (add e_1 (sext 8 e_2)) (sext 8 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t3_thm (e : IntW 8) (e_1 : IntW 2) :
  LLVM.xor (add (sext 8 e_1) e) (sext 8 e_1) ⊑ LLVM.xor (add e (sext 8 e_1)) (sext 8 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


