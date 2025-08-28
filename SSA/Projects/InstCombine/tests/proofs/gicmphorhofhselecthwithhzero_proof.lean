
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphorhofhselecthwithhzero_proof
theorem src_tv_eq_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPred.eq (LLVM.or (select e_2 (const? 8 0) (add e_1 (const? 8 1) { «nsw» := false, «nuw» := true })) e)
      (const? 8 0) ⊑
    LLVM.and (icmp IntPred.eq e (const? 8 0)) e_2 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem src_fv_ne_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPred.ne (LLVM.or (select e_2 (add e_1 (const? 8 1) { «nsw» := false, «nuw» := true }) (const? 8 0)) e)
      (const? 8 0) ⊑
    LLVM.or (icmp IntPred.ne e (const? 8 0)) e_2 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem src_tv_ne_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPred.ne (LLVM.or (select e_2 (const? 8 0) (add e_1 (const? 8 1) { «nsw» := false, «nuw» := true })) e)
      (const? 8 0) ⊑
    LLVM.or (icmp IntPred.ne e (const? 8 0)) (LLVM.xor e_2 (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem src_fv_eq_thm (e e_1 : IntW 8) (e_2 : IntW 1) :
  icmp IntPred.eq (LLVM.or (select e_2 (add e_1 (const? 8 1) { «nsw» := false, «nuw» := true }) (const? 8 0)) e)
      (const? 8 0) ⊑
    LLVM.and (icmp IntPred.eq e (const? 8 0)) (LLVM.xor e_2 (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
