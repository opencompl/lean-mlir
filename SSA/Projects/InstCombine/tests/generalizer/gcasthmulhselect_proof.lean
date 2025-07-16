
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gcasthmulhselect_proof
theorem mul_proof.mul_thm_1 (e e_1 : IntW 32) :
  zext 32 (mul (trunc 8 e) (trunc 8 e_1)) ⊑ LLVM.and (mul e e_1) (const? 32 255) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select1_proof.select1_thm_1 (e : IntW 1) (e_1 e_2 e_3 : IntW 32) :
  zext 32 (select e (trunc 8 e_3) (add (trunc 8 e_1) (trunc 8 e_2))) ⊑
    LLVM.and (select e e_3 (add e_1 e_2)) (const? 32 255) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select2_proof.select2_thm_1 (e : IntW 1) (e_1 e_2 e_3 : IntW 8) :
  trunc 8 (select e (zext 32 e_3) (add (zext 32 e_1) (zext 32 e_2))) ⊑ select e e_3 (add e_1 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eval_zext_multi_use_in_one_inst_proof.eval_zext_multi_use_in_one_inst_thm_1 (e : IntW 32) :
  zext 32
      (mul (LLVM.and (trunc 16 e) (const? 16 5)) (LLVM.and (trunc 16 e) (const? 16 5))
        { «nsw» := true, «nuw» := true }) ⊑
    zext 32
      (mul (LLVM.and (trunc 16 e) (const? 16 5)) (LLVM.and (trunc 16 e) (const? 16 5)) { «nsw» := true, «nuw» := true })
      { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eval_sext_multi_use_in_one_inst_proof.eval_sext_multi_use_in_one_inst_thm_1 (e : IntW 32) :
  sext 32
      (LLVM.or
        (mul (LLVM.and (trunc 16 e) (const? 16 14)) (LLVM.and (trunc 16 e) (const? 16 14))
          { «nsw» := true, «nuw» := true })
        (const? 16 (-32768))) ⊑
    sext 32
      (LLVM.or
        (mul (LLVM.and (trunc 16 e) (const? 16 14)) (LLVM.and (trunc 16 e) (const? 16 14))
          { «nsw» := true, «nuw» := true })
        (const? 16 (-32768)) { «disjoint» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo_proof.foo_thm_1 (e : IntW 1) : e ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
