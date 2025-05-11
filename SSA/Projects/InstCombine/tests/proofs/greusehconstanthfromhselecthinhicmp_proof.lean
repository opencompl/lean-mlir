
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section greusehconstanthfromhselecthinhicmp_proof
theorem p0_ult_65536_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ult e_1 (const? 32 65536)) e (const? 32 65535) ⊑
    select (icmp IntPredicate.ugt e_1 (const? 32 65535)) (const? 32 65535) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem p1_ugt_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ugt e_1 (const? 32 65534)) e (const? 32 65535) ⊑
    select (icmp IntPredicate.ult e_1 (const? 32 65535)) (const? 32 65535) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem p2_slt_65536_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.slt e_1 (const? 32 65536)) e (const? 32 65535) ⊑
    select (icmp IntPredicate.sgt e_1 (const? 32 65535)) (const? 32 65535) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem p3_sgt_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.sgt e_1 (const? 32 65534)) e (const? 32 65535) ⊑
    select (icmp IntPredicate.slt e_1 (const? 32 65535)) (const? 32 65535) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem p13_commutativity0_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ult e_1 (const? 32 65536)) (const? 32 65535) e ⊑
    select (icmp IntPredicate.ugt e_1 (const? 32 65535)) e (const? 32 65535) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem p14_commutativity1_thm (e : IntW 32) :
  select (icmp IntPredicate.ult e (const? 32 65536)) (const? 32 65535) (const? 32 42) ⊑
    select (icmp IntPredicate.ugt e (const? 32 65535)) (const? 32 42) (const? 32 65535) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem p15_commutativity2_thm (e : IntW 32) :
  select (icmp IntPredicate.ult e (const? 32 65536)) (const? 32 42) (const? 32 65535) ⊑
    select (icmp IntPredicate.ugt e (const? 32 65535)) (const? 32 65535) (const? 32 42) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t22_sign_check_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.slt e_1 (const? 32 0)) (const? 32 (-1)) e ⊑
    select (icmp IntPredicate.sgt e_1 (const? 32 (-1))) e (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t22_sign_check2_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.sgt e_1 (const? 32 (-1))) (const? 32 0) e ⊑
    select (icmp IntPredicate.slt e_1 (const? 32 0)) e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
