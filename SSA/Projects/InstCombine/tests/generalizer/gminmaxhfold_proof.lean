
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gminmaxhfold_proof
theorem add_umin_constant_limit_proof.add_umin_constant_limit_thm_1 (e : IntW 32) :
  select (icmp IntPred.ult (add e (const? 32 41) { «nuw» := true }) (const? 32 42))
      (add e (const? 32 41) { «nuw» := true }) (const? 32 42) ⊑
    select (icmp IntPred.eq e (const? 32 0)) (const? 32 41) (const? 32 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_umin_simplify_proof.add_umin_simplify_thm_1 (e : IntW 32) :
  select (icmp IntPred.ult (add e (const? 32 42) { «nuw» := true }) (const? 32 42))
      (add e (const? 32 42) { «nuw» := true }) (const? 32 42) ⊑
    const? 32 42 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_umin_simplify2_proof.add_umin_simplify2_thm_1 (e : IntW 32) :
  select (icmp IntPred.ult (add e (const? 32 43) { «nuw» := true }) (const? 32 42))
      (add e (const? 32 43) { «nuw» := true }) (const? 32 42) ⊑
    const? 32 42 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_umax_simplify_proof.add_umax_simplify_thm_1 (e : IntW 37) :
  select (icmp IntPred.ugt (add e (const? 37 42) { «nuw» := true }) (const? 37 42))
      (add e (const? 37 42) { «nuw» := true }) (const? 37 42) ⊑
    add e (const? 37 42) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_umax_simplify2_proof.add_umax_simplify2_thm_1 (e : IntW 32) :
  select (icmp IntPred.ugt (add e (const? 32 57) { «nuw» := true }) (const? 32 56))
      (add e (const? 32 57) { «nuw» := true }) (const? 32 56) ⊑
    add e (const? 32 57) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_smin_simplify_proof.add_smin_simplify_thm_1 (e : IntW 32) :
  select (icmp IntPred.slt (add e (const? 32 (-3)) { «nsw» := true }) (const? 32 2147483644))
      (add e (const? 32 (-3)) { «nsw» := true }) (const? 32 2147483644) ⊑
    add e (const? 32 (-3)) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_smin_simplify2_proof.add_smin_simplify2_thm_1 (e : IntW 32) :
  select (icmp IntPred.slt (add e (const? 32 (-3)) { «nsw» := true }) (const? 32 2147483645))
      (add e (const? 32 (-3)) { «nsw» := true }) (const? 32 2147483645) ⊑
    add e (const? 32 (-3)) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_smax_simplify_proof.add_smax_simplify_thm_1 (e : IntW 8) :
  select (icmp IntPred.sgt (add e (const? 8 126) { «nsw» := true }) (const? 8 (-2)))
      (add e (const? 8 126) { «nsw» := true }) (const? 8 (-2)) ⊑
    add e (const? 8 126) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_smax_simplify2_proof.add_smax_simplify2_thm_1 (e : IntW 8) :
  select (icmp IntPred.sgt (add e (const? 8 127) { «nsw» := true }) (const? 8 (-2)))
      (add e (const? 8 127) { «nsw» := true }) (const? 8 (-2)) ⊑
    add e (const? 8 127) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem twoway_clamp_lt_proof.twoway_clamp_lt_thm_1 (e : IntW 32) :
  select (icmp IntPred.sgt (select (icmp IntPred.slt e (const? 32 13768)) e (const? 32 13768)) (const? 32 13767))
      (select (icmp IntPred.slt e (const? 32 13768)) e (const? 32 13768)) (const? 32 13767) ⊑
    select (icmp IntPred.sgt e (const? 32 13767)) (const? 32 13768) (const? 32 13767) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
