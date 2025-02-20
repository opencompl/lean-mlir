
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gcanonicalizehclamphlikehpatternhbetweenhnegativehandhpositivehthresholds_proof
theorem t0_ult_slt_128_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ult (add e_2 (const? 32 16)) (const? 32 144)) e_2
      (select (icmp IntPredicate.slt e_2 (const? 32 128)) e_1 e) ⊑
    select (icmp IntPredicate.sgt e_2 (const? 32 127)) e
      (select (icmp IntPredicate.slt e_2 (const? 32 (-16))) e_1 e_2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_ult_slt_0_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ult (add e_2 (const? 32 16)) (const? 32 144)) e_2
      (select (icmp IntPredicate.slt e_2 (const? 32 (-16))) e_1 e) ⊑
    select (icmp IntPredicate.sgt e_2 (const? 32 127)) e
      (select (icmp IntPredicate.slt e_2 (const? 32 (-16))) e_1 e_2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t2_ult_sgt_128_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ult (add e_2 (const? 32 16)) (const? 32 144)) e_2
      (select (icmp IntPredicate.sgt e_2 (const? 32 127)) e_1 e) ⊑
    select (icmp IntPredicate.sgt e_2 (const? 32 127)) e_1
      (select (icmp IntPredicate.slt e_2 (const? 32 (-16))) e e_2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t3_ult_sgt_neg1_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ult (add e_2 (const? 32 16)) (const? 32 144)) e_2
      (select (icmp IntPredicate.sgt e_2 (const? 32 (-17))) e_1 e) ⊑
    select (icmp IntPredicate.sgt e_2 (const? 32 127)) e_1
      (select (icmp IntPredicate.slt e_2 (const? 32 (-16))) e e_2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t4_ugt_slt_128_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ugt (add e_2 (const? 32 16)) (const? 32 143))
      (select (icmp IntPredicate.slt e_2 (const? 32 128)) e_1 e) e_2 ⊑
    select (icmp IntPredicate.sgt e_2 (const? 32 127)) e
      (select (icmp IntPredicate.slt e_2 (const? 32 (-16))) e_1 e_2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t5_ugt_slt_0_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ugt (add e_2 (const? 32 16)) (const? 32 143))
      (select (icmp IntPredicate.slt e_2 (const? 32 (-16))) e_1 e) e_2 ⊑
    select (icmp IntPredicate.sgt e_2 (const? 32 127)) e
      (select (icmp IntPredicate.slt e_2 (const? 32 (-16))) e_1 e_2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t6_ugt_sgt_128_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ugt (add e_2 (const? 32 16)) (const? 32 143))
      (select (icmp IntPredicate.sgt e_2 (const? 32 127)) e_1 e) e_2 ⊑
    select (icmp IntPredicate.sgt e_2 (const? 32 127)) e_1
      (select (icmp IntPredicate.slt e_2 (const? 32 (-16))) e e_2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t7_ugt_sgt_neg1_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ugt (add e_2 (const? 32 16)) (const? 32 143))
      (select (icmp IntPredicate.sgt e_2 (const? 32 (-17))) e_1 e) e_2 ⊑
    select (icmp IntPredicate.sgt e_2 (const? 32 127)) e_1
      (select (icmp IntPredicate.slt e_2 (const? 32 (-16))) e e_2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n10_ugt_slt_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ugt e_2 (const? 32 128)) e_2 (select (icmp IntPredicate.slt e_2 (const? 32 0)) e_1 e) ⊑
    select (icmp IntPredicate.ugt e_2 (const? 32 128)) e_2 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n11_uge_slt_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ult e_2 (const? 32 129)) (select (icmp IntPredicate.slt e_2 (const? 32 0)) e_1 e) e_2 ⊑
    select (icmp IntPredicate.ult e_2 (const? 32 129)) e e_2 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
