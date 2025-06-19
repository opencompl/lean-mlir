
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gunsigned_saturated_sub_proof
theorem max_sub_ugt_c0_thm (e : IntW 32) :
  select (icmp IntPred.ugt e (const? 32 (-1))) (add e (const? 32 0)) (const? 32 0) ⊑ const? 32 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem max_sub_ult_c1_thm (e : IntW 32) :
  select (icmp IntPred.ult e (const? 32 1)) (add e (const? 32 (-1))) (const? 32 0) ⊑
    sext 32 (icmp IntPred.eq e (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem max_sub_ugt_c32_thm (e : IntW 32) :
  select (icmp IntPred.ugt (const? 32 3) e) (add e (const? 32 (-2))) (const? 32 0) ⊑
    select (icmp IntPred.ult e (const? 32 3)) (add e (const? 32 (-2))) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem max_sub_uge_c32_thm (e : IntW 32) :
  select (icmp IntPred.uge (const? 32 2) e) (add e (const? 32 (-2))) (const? 32 0) ⊑
    select (icmp IntPred.ult e (const? 32 3)) (add e (const? 32 (-2))) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem max_sub_ult_c12_thm (e : IntW 32) :
  select (icmp IntPred.ult e (const? 32 1)) (add e (const? 32 (-2))) (const? 32 0) ⊑
    select (icmp IntPred.eq e (const? 32 0)) (const? 32 (-2)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem max_sub_ult_c0_thm (e : IntW 32) :
  select (icmp IntPred.ult e (const? 32 0)) (add e (const? 32 (-1))) (const? 32 0) ⊑ const? 32 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
