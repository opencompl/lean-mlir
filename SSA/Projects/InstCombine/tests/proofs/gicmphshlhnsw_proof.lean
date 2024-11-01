
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gicmphshlhnsw_proof
theorem icmp_shl_nsw_sgt_thm (e : IntW 32) :
  icmp IntPredicate.sgt (shl e (const? 21) { «nsw» := true, «nuw» := false }) (const? 0) ⊑
    icmp IntPredicate.sgt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_shl_nsw_sge0_thm (e : IntW 32) :
  icmp IntPredicate.sge (shl e (const? 21) { «nsw» := true, «nuw» := false }) (const? 0) ⊑
    icmp IntPredicate.sgt e (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_shl_nsw_sge1_thm (e : IntW 32) :
  icmp IntPredicate.sge (shl e (const? 21) { «nsw» := true, «nuw» := false }) (const? 1) ⊑
    icmp IntPredicate.sgt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_shl_nsw_eq_thm (e : IntW 32) :
  icmp IntPredicate.eq (shl e (const? 5) { «nsw» := true, «nuw» := false }) (const? 0) ⊑
    icmp IntPredicate.eq e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sgt1_thm (e : IntW 8) :
  icmp IntPredicate.sgt (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? (-128)) ⊑
    icmp IntPredicate.ne e (const? (-64)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sgt2_thm (e : IntW 8) :
  icmp IntPredicate.sgt (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? (-127)) ⊑
    icmp IntPredicate.sgt e (const? (-64)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sgt3_thm (e : IntW 8) :
  icmp IntPredicate.sgt (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? (-16)) ⊑
    icmp IntPredicate.sgt e (const? (-8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sgt4_thm (e : IntW 8) :
  icmp IntPredicate.sgt (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? (-2)) ⊑
    icmp IntPredicate.sgt e (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sgt5_thm (e : IntW 8) :
  icmp IntPredicate.sgt (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? 1) ⊑
    icmp IntPredicate.sgt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sgt6_thm (e : IntW 8) :
  icmp IntPredicate.sgt (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? 16) ⊑
    icmp IntPredicate.sgt e (const? 8) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sgt7_thm (e : IntW 8) :
  icmp IntPredicate.sgt (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? 124) ⊑
    icmp IntPredicate.sgt e (const? 62) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sgt8_thm (e : IntW 8) :
  icmp IntPredicate.sgt (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? 125) ⊑
    icmp IntPredicate.eq e (const? 63) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sgt9_thm (e : IntW 8) :
  icmp IntPredicate.sgt (shl e (const? 7) { «nsw» := true, «nuw» := false }) (const? (-128)) ⊑
    icmp IntPredicate.eq e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sgt10_thm (e : IntW 8) :
  icmp IntPredicate.sgt (shl e (const? 7) { «nsw» := true, «nuw» := false }) (const? (-127)) ⊑
    icmp IntPredicate.sgt e (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sgt11_thm (e : IntW 8) :
  icmp IntPredicate.sgt (shl e (const? 7) { «nsw» := true, «nuw» := false }) (const? (-2)) ⊑
    icmp IntPredicate.sgt e (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sle1_thm (e : IntW 8) :
  icmp IntPredicate.sle (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? (-128)) ⊑
    icmp IntPredicate.eq e (const? (-64)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sle2_thm (e : IntW 8) :
  icmp IntPredicate.sle (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? (-127)) ⊑
    icmp IntPredicate.slt e (const? (-63)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sle3_thm (e : IntW 8) :
  icmp IntPredicate.sle (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? (-16)) ⊑
    icmp IntPredicate.slt e (const? (-7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sle4_thm (e : IntW 8) :
  icmp IntPredicate.sle (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? (-2)) ⊑
    icmp IntPredicate.slt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sle5_thm (e : IntW 8) :
  icmp IntPredicate.sle (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? 1) ⊑
    icmp IntPredicate.slt e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sle6_thm (e : IntW 8) :
  icmp IntPredicate.sle (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? 16) ⊑
    icmp IntPredicate.slt e (const? 9) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sle7_thm (e : IntW 8) :
  icmp IntPredicate.sle (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? 124) ⊑
    icmp IntPredicate.slt e (const? 63) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sle8_thm (e : IntW 8) :
  icmp IntPredicate.sle (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? 125) ⊑
    icmp IntPredicate.ne e (const? 63) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sle9_thm (e : IntW 8) :
  icmp IntPredicate.sle (shl e (const? 7) { «nsw» := true, «nuw» := false }) (const? (-128)) ⊑
    icmp IntPredicate.ne e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sle10_thm (e : IntW 8) :
  icmp IntPredicate.sle (shl e (const? 7) { «nsw» := true, «nuw» := false }) (const? (-127)) ⊑
    icmp IntPredicate.slt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_sle11_thm (e : IntW 8) :
  icmp IntPredicate.sle (shl e (const? 7) { «nsw» := true, «nuw» := false }) (const? (-2)) ⊑
    icmp IntPredicate.slt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_eq1_thm (e : IntW 8) :
  icmp IntPredicate.eq (shl e (const? 1) { «nsw» := true, «nuw» := false }) (const? 12) ⊑
    icmp IntPredicate.eq e (const? 6) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem icmp_ne1_thm (e : IntW 8) :
  icmp IntPredicate.ne (shl e (const? 6) { «nsw» := true, «nuw» := false }) (const? (-128)) ⊑
    icmp IntPredicate.ne e (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


