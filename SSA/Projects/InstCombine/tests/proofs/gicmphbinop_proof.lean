
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphbinop_proof
theorem mul_unkV_oddC_eq_thm (e : IntW 32) :
  icmp IntPred.eq (mul e (const? 32 3)) (const? 32 0) ⊑ icmp IntPred.eq e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem mul_unkV_oddC_sge_thm (e : IntW 8) :
  icmp IntPred.sge (mul e (const? 8 3)) (const? 8 0) ⊑
    icmp IntPred.sgt (mul e (const? 8 3)) (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem mul_unkV_evenC_ne_thm (e : IntW 64) :
  icmp IntPred.ne (mul e (const? 64 4)) (const? 64 0) ⊑
    icmp IntPred.ne (LLVM.and e (const? 64 4611686018427387903)) (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem mul_setnzV_unkV_nuw_eq_thm (e e_1 : IntW 8) :
  icmp IntPred.eq (mul (LLVM.or e_1 (const? 8 2)) e { «nsw» := false, «nuw» := true }) (const? 8 0) ⊑
    icmp IntPred.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
