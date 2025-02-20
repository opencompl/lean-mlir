
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gminmaxhfold_proof
theorem add_umin_constant_limit_thm (e : IntW 32) :
  select (icmp IntPredicate.ult (add e (const? 32 41) { «nsw» := false, «nuw» := true }) (const? 32 42))
      (add e (const? 32 41) { «nsw» := false, «nuw» := true }) (const? 32 42) ⊑
    select (icmp IntPredicate.eq e (const? 32 0)) (const? 32 41) (const? 32 42) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_umin_simplify_thm (e : IntW 32) :
  select (icmp IntPredicate.ult (add e (const? 32 42) { «nsw» := false, «nuw» := true }) (const? 32 42))
      (add e (const? 32 42) { «nsw» := false, «nuw» := true }) (const? 32 42) ⊑
    const? 32 42 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_umin_simplify2_thm (e : IntW 32) :
  select (icmp IntPredicate.ult (add e (const? 32 43) { «nsw» := false, «nuw» := true }) (const? 32 42))
      (add e (const? 32 43) { «nsw» := false, «nuw» := true }) (const? 32 42) ⊑
    const? 32 42 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_umax_simplify_thm (e : IntW 37) :
  select (icmp IntPredicate.ugt (add e (const? 37 42) { «nsw» := false, «nuw» := true }) (const? 37 42))
      (add e (const? 37 42) { «nsw» := false, «nuw» := true }) (const? 37 42) ⊑
    add e (const? 37 42) { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_umax_simplify2_thm (e : IntW 32) :
  select (icmp IntPredicate.ugt (add e (const? 32 57) { «nsw» := false, «nuw» := true }) (const? 32 56))
      (add e (const? 32 57) { «nsw» := false, «nuw» := true }) (const? 32 56) ⊑
    add e (const? 32 57) { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_smin_simplify_thm (e : IntW 32) :
  select (icmp IntPredicate.slt (add e (const? 32 (-3)) { «nsw» := true, «nuw» := false }) (const? 32 2147483644))
      (add e (const? 32 (-3)) { «nsw» := true, «nuw» := false }) (const? 32 2147483644) ⊑
    add e (const? 32 (-3)) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_smin_simplify2_thm (e : IntW 32) :
  select (icmp IntPredicate.slt (add e (const? 32 (-3)) { «nsw» := true, «nuw» := false }) (const? 32 2147483645))
      (add e (const? 32 (-3)) { «nsw» := true, «nuw» := false }) (const? 32 2147483645) ⊑
    add e (const? 32 (-3)) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_smax_simplify_thm (e : IntW 8) :
  select (icmp IntPredicate.sgt (add e (const? 8 126) { «nsw» := true, «nuw» := false }) (const? 8 (-2)))
      (add e (const? 8 126) { «nsw» := true, «nuw» := false }) (const? 8 (-2)) ⊑
    add e (const? 8 126) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_smax_simplify2_thm (e : IntW 8) :
  select (icmp IntPredicate.sgt (add e (const? 8 127) { «nsw» := true, «nuw» := false }) (const? 8 (-2)))
      (add e (const? 8 127) { «nsw» := true, «nuw» := false }) (const? 8 (-2)) ⊑
    add e (const? 8 127) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem twoway_clamp_lt_thm (e : IntW 32) :
  select
      (icmp IntPredicate.sgt (select (icmp IntPredicate.slt e (const? 32 13768)) e (const? 32 13768)) (const? 32 13767))
      (select (icmp IntPredicate.slt e (const? 32 13768)) e (const? 32 13768)) (const? 32 13767) ⊑
    select (icmp IntPredicate.sgt e (const? 32 13767)) (const? 32 13768) (const? 32 13767) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
