
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gminmaxhdemandbits_proof
theorem and_umax_less_thm (e : IntW 32) :
  LLVM.and (select (icmp IntPredicate.ugt (const? 32 31) e) (const? 32 31) e) (const? 32 (-32)) ⊑
    LLVM.and e (const? 32 (-32)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_umax_muchless_thm (e : IntW 32) :
  LLVM.and (select (icmp IntPredicate.ugt (const? 32 12) e) (const? 32 12) e) (const? 32 (-32)) ⊑
    LLVM.and e (const? 32 (-32)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shr_umax_thm (e : IntW 32) :
  lshr (select (icmp IntPredicate.ugt (const? 32 15) e) (const? 32 15) e) (const? 32 4) ⊑ lshr e (const? 32 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t_0_1_thm (e : IntW 8) :
  LLVM.and (select (icmp IntPredicate.ugt e (const? 8 0)) e (const? 8 0)) (const? 8 1) ⊑
    LLVM.and e (const? 8 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t_0_10_thm (e : IntW 8) :
  LLVM.and (select (icmp IntPredicate.ugt e (const? 8 0)) e (const? 8 0)) (const? 8 10) ⊑
    LLVM.and e (const? 8 10) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t_1_10_thm (e : IntW 8) :
  LLVM.and (select (icmp IntPredicate.ugt e (const? 8 1)) e (const? 8 1)) (const? 8 10) ⊑
    LLVM.and e (const? 8 10) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t_2_4_thm (e : IntW 8) :
  LLVM.and (select (icmp IntPredicate.ugt e (const? 8 2)) e (const? 8 2)) (const? 8 4) ⊑
    LLVM.and e (const? 8 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t_2_192_thm (e : IntW 8) :
  LLVM.and (select (icmp IntPredicate.ugt e (const? 8 2)) e (const? 8 2)) (const? 8 (-64)) ⊑
    LLVM.and e (const? 8 (-64)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t_2_63_or_thm (e : IntW 8) :
  LLVM.or (select (icmp IntPredicate.ugt e (const? 8 2)) e (const? 8 2)) (const? 8 63) ⊑
    LLVM.or e (const? 8 63) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_umin_thm (e : IntW 32) :
  LLVM.and (select (icmp IntPredicate.ult (const? 32 15) e) (const? 32 15) e) (const? 32 (-32)) ⊑ const? 32 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_umin_thm (e : IntW 32) :
  LLVM.or (select (icmp IntPredicate.ult (const? 32 15) e) (const? 32 15) e) (const? 32 31) ⊑ const? 32 31 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_min_31_30_thm (e : IntW 8) :
  LLVM.or (select (icmp IntPredicate.ult e (const? 8 (-30))) e (const? 8 (-30))) (const? 8 31) ⊑
    LLVM.or e (const? 8 31) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_min_7_7_thm (e : IntW 8) :
  LLVM.and (select (icmp IntPredicate.ult e (const? 8 (-7))) e (const? 8 (-7))) (const? 8 (-8)) ⊑
    LLVM.and e (const? 8 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_min_7_8_thm (e : IntW 8) :
  LLVM.and (select (icmp IntPredicate.ult e (const? 8 (-8))) e (const? 8 (-8))) (const? 8 (-8)) ⊑
    LLVM.and e (const? 8 (-8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
