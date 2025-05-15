
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphshlhnsw_proof
theorem icmp_shl_nsw_sgt_thm (e : IntW 32) :
  icmp IntPred.sgt (shl e (const? 32 21) { «nsw» := true, «nuw» := false }) (const? 32 0) ⊑
    icmp IntPred.sgt e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_shl_nsw_sge0_thm (e : IntW 32) :
  icmp IntPred.sge (shl e (const? 32 21) { «nsw» := true, «nuw» := false }) (const? 32 0) ⊑
    icmp IntPred.sgt e (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_shl_nsw_sge1_thm (e : IntW 32) :
  icmp IntPred.sge (shl e (const? 32 21) { «nsw» := true, «nuw» := false }) (const? 32 1) ⊑
    icmp IntPred.sgt e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_shl_nsw_eq_thm (e : IntW 32) :
  icmp IntPred.eq (shl e (const? 32 5) { «nsw» := true, «nuw» := false }) (const? 32 0) ⊑
    icmp IntPred.eq e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sgt1_thm (e : IntW 8) :
  icmp IntPred.sgt (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 (-128)) ⊑
    icmp IntPred.ne e (const? 8 (-64)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sgt2_thm (e : IntW 8) :
  icmp IntPred.sgt (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 (-127)) ⊑
    icmp IntPred.sgt e (const? 8 (-64)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sgt3_thm (e : IntW 8) :
  icmp IntPred.sgt (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 (-16)) ⊑
    icmp IntPred.sgt e (const? 8 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sgt4_thm (e : IntW 8) :
  icmp IntPred.sgt (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 (-2)) ⊑
    icmp IntPred.sgt e (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sgt5_thm (e : IntW 8) :
  icmp IntPred.sgt (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 1) ⊑
    icmp IntPred.sgt e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sgt6_thm (e : IntW 8) :
  icmp IntPred.sgt (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 16) ⊑
    icmp IntPred.sgt e (const? 8 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sgt7_thm (e : IntW 8) :
  icmp IntPred.sgt (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 124) ⊑
    icmp IntPred.sgt e (const? 8 62) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sgt8_thm (e : IntW 8) :
  icmp IntPred.sgt (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 125) ⊑
    icmp IntPred.eq e (const? 8 63) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sgt9_thm (e : IntW 8) :
  icmp IntPred.sgt (shl e (const? 8 7) { «nsw» := true, «nuw» := false }) (const? 8 (-128)) ⊑
    icmp IntPred.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sgt10_thm (e : IntW 8) :
  icmp IntPred.sgt (shl e (const? 8 7) { «nsw» := true, «nuw» := false }) (const? 8 (-127)) ⊑
    icmp IntPred.sgt e (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sgt11_thm (e : IntW 8) :
  icmp IntPred.sgt (shl e (const? 8 7) { «nsw» := true, «nuw» := false }) (const? 8 (-2)) ⊑
    icmp IntPred.sgt e (const? 8 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sle1_thm (e : IntW 8) :
  icmp IntPred.sle (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 (-128)) ⊑
    icmp IntPred.eq e (const? 8 (-64)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sle2_thm (e : IntW 8) :
  icmp IntPred.sle (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 (-127)) ⊑
    icmp IntPred.slt e (const? 8 (-63)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sle3_thm (e : IntW 8) :
  icmp IntPred.sle (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 (-16)) ⊑
    icmp IntPred.slt e (const? 8 (-7)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sle4_thm (e : IntW 8) :
  icmp IntPred.sle (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 (-2)) ⊑
    icmp IntPred.slt e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sle5_thm (e : IntW 8) :
  icmp IntPred.sle (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 1) ⊑
    icmp IntPred.slt e (const? 8 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sle6_thm (e : IntW 8) :
  icmp IntPred.sle (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 16) ⊑
    icmp IntPred.slt e (const? 8 9) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sle7_thm (e : IntW 8) :
  icmp IntPred.sle (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 124) ⊑
    icmp IntPred.slt e (const? 8 63) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sle8_thm (e : IntW 8) :
  icmp IntPred.sle (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 125) ⊑
    icmp IntPred.ne e (const? 8 63) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sle9_thm (e : IntW 8) :
  icmp IntPred.sle (shl e (const? 8 7) { «nsw» := true, «nuw» := false }) (const? 8 (-128)) ⊑
    icmp IntPred.ne e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sle10_thm (e : IntW 8) :
  icmp IntPred.sle (shl e (const? 8 7) { «nsw» := true, «nuw» := false }) (const? 8 (-127)) ⊑
    icmp IntPred.slt e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_sle11_thm (e : IntW 8) :
  icmp IntPred.sle (shl e (const? 8 7) { «nsw» := true, «nuw» := false }) (const? 8 (-2)) ⊑
    icmp IntPred.slt e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq1_thm (e : IntW 8) :
  icmp IntPred.eq (shl e (const? 8 1) { «nsw» := true, «nuw» := false }) (const? 8 12) ⊑
    icmp IntPred.eq e (const? 8 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne1_thm (e : IntW 8) :
  icmp IntPred.ne (shl e (const? 8 6) { «nsw» := true, «nuw» := false }) (const? 8 (-128)) ⊑
    icmp IntPred.ne e (const? 8 (-2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
