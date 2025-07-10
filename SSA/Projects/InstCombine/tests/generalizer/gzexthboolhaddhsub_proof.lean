
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gzexthboolhaddhsub_proof
theorem a_proof.a_thm_1 (e e_1 : IntW 1) :
  add (add (zext 32 e) (const? 32 1)) (sub (const? 32 0) (zext 32 e_1)) ⊑
    add (select e (const? 32 2) (const? 32 1)) (sext 32 e_1) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR30273_three_bools_proof.PR30273_three_bools_thm_1 (e e_1 e_2 : IntW 1) :
  select e_2
      (add (select e_1 (add (zext 32 e) (const? 32 1) { «nsw» := true }) (zext 32 e)) (const? 32 1) { «nsw» := true })
      (select e_1 (add (zext 32 e) (const? 32 1) { «nsw» := true }) (zext 32 e)) ⊑
    add (select e_1 (select e (const? 32 2) (const? 32 1)) (zext 32 e)) (zext 32 e_2)
      { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem zext_add_scalar_proof.zext_add_scalar_thm_1 (e : IntW 1) :
  add (zext 32 e) (const? 32 42) ⊑ select e (const? 32 43) (const? 32 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem zext_negate_proof.zext_negate_thm_1 (e : IntW 1) : sub (const? 64 0) (zext 64 e) ⊑ sext 64 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem zext_sub_const_proof.zext_sub_const_thm_1 (e : IntW 1) :
  sub (const? 64 42) (zext 64 e) ⊑ select e (const? 64 41) (const? 64 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_negate_proof.sext_negate_thm_1 (e : IntW 1) : sub (const? 64 0) (sext 64 e) ⊑ zext 64 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_sub_const_proof.sext_sub_const_thm_1 (e : IntW 1) :
  sub (const? 64 42) (sext 64 e) ⊑ select e (const? 64 43) (const? 64 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_sub_proof.sext_sub_thm_1 (e : IntW 8) (e_1 : IntW 1) : sub e (sext 8 e_1) ⊑ add e (zext 8 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_sub_nuw_proof.sext_sub_nuw_thm_1 (e : IntW 8) (e_1 : IntW 1) :
  sub e (sext 8 e_1) { «nuw» := true } ⊑ add e (zext 8 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sextbool_add_proof.sextbool_add_thm_1 (e : IntW 1) (e_1 : IntW 32) :
  add (sext 32 e) e_1 ⊑ add e_1 (sext 32 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sextbool_add_commute_proof.sextbool_add_commute_thm_1 (e : IntW 1) (e_1 : IntW 32) :
  add (urem e_1 (const? 32 42)) (sext 32 e) ⊑ add (urem e_1 (const? 32 42)) (sext 32 e) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
