
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gcmphxhvshneghx_proof
theorem t0_thm (e : IntW 8) :
  icmp IntPred.sgt (sub (const? 8 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPred.slt e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem t1_thm (e : IntW 8) :
  icmp IntPred.sge (sub (const? 8 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPred.slt e (const? 8 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem t2_thm (e : IntW 8) :
  icmp IntPred.slt (sub (const? 8 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPred.sgt e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem t3_thm (e : IntW 8) :
  icmp IntPred.sle (sub (const? 8 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPred.sgt e (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem t4_thm (e : IntW 8) :
  icmp IntPred.ugt (sub (const? 8 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPred.sgt e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem t5_thm (e : IntW 8) :
  icmp IntPred.uge (sub (const? 8 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPred.sgt e (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem t6_thm (e : IntW 8) :
  icmp IntPred.ult (sub (const? 8 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPred.slt e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem t7_thm (e : IntW 8) :
  icmp IntPred.ule (sub (const? 8 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPred.slt e (const? 8 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem t8_thm (e : IntW 8) :
  icmp IntPred.eq (sub (const? 8 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPred.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem t9_thm (e : IntW 8) :
  icmp IntPred.ne (sub (const? 8 0) e { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPred.ne e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem n10_thm (e : IntW 8) :
  icmp IntPred.sgt (sub (const? 8 0) e) e ⊑ icmp IntPred.slt e (sub (const? 8 0) e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem n12_thm (e e_1 : IntW 8) :
  icmp IntPred.sgt (sub (const? 8 0) e_1 { «nsw» := true, «nuw» := false }) e ⊑
    icmp IntPred.slt e (sub (const? 8 0) e_1 { «nsw» := true, «nuw» := false }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
