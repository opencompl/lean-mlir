
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section greusehconstanthfromhselecthinhicmp_proof
theorem p0_ult_65536_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ult e_1 (const? 65536)) e (const? 65535) ⊑
    select (icmp IntPredicate.ugt e_1 (const? 65535)) (const? 65535) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p1_ugt_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ugt e_1 (const? 65534)) e (const? 65535) ⊑
    select (icmp IntPredicate.ult e_1 (const? 65535)) (const? 65535) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p2_slt_65536_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.slt e_1 (const? 65536)) e (const? 65535) ⊑
    select (icmp IntPredicate.sgt e_1 (const? 65535)) (const? 65535) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p3_sgt_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.sgt e_1 (const? 65534)) e (const? 65535) ⊑
    select (icmp IntPredicate.slt e_1 (const? 65535)) (const? 65535) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p13_commutativity0_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ult e_1 (const? 65536)) (const? 65535) e ⊑
    select (icmp IntPredicate.ugt e_1 (const? 65535)) e (const? 65535) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p14_commutativity1_thm (e : IntW 32) :
  select (icmp IntPredicate.ult e (const? 65536)) (const? 65535) (const? 42) ⊑
    select (icmp IntPredicate.ugt e (const? 65535)) (const? 42) (const? 65535) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem p15_commutativity2_thm (e : IntW 32) :
  select (icmp IntPredicate.ult e (const? 65536)) (const? 42) (const? 65535) ⊑
    select (icmp IntPredicate.ugt e (const? 65535)) (const? 65535) (const? 42) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t22_sign_check_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.slt e_1 (const? 0)) (const? (-1)) e ⊑
    select (icmp IntPredicate.sgt e_1 (const? (-1))) e (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t22_sign_check2_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.sgt e_1 (const? (-1))) (const? 0) e ⊑
    select (icmp IntPredicate.slt e_1 (const? 0)) e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


