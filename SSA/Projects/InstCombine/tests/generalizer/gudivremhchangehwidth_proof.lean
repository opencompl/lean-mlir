
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gudivremhchangehwidth_proof
theorem udiv_i8_proof.udiv_i8_thm_1 (e e_1 : IntW 8) :
  trunc 8 (LLVM.udiv (zext 32 e) (zext 32 e_1)) ⊑ LLVM.udiv e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem urem_i8_proof.urem_i8_thm_1 (e e_1 : IntW 8) : trunc 8 (urem (zext 32 e) (zext 32 e_1)) ⊑ urem e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_i32_proof.udiv_i32_thm_1 (e e_1 : IntW 8) :
  LLVM.udiv (zext 32 e) (zext 32 e_1) ⊑ zext 32 (LLVM.udiv e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_i32_multiuse_proof.udiv_i32_multiuse_thm_1 (e e_1 : IntW 8) :
  mul (LLVM.udiv (zext 32 e) (zext 32 e_1)) (add (zext 32 e) (zext 32 e_1)) ⊑
    mul (LLVM.udiv (zext 32 e) (zext 32 e_1)) (add (zext 32 e) (zext 32 e_1) { «nsw» := true, «nuw» := true })
      { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_illegal_type_proof.udiv_illegal_type_thm_1 (e e_1 : IntW 9) :
  LLVM.udiv (zext 32 e) (zext 32 e_1) ⊑ zext 32 (LLVM.udiv e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem urem_i32_proof.urem_i32_thm_1 (e e_1 : IntW 8) : urem (zext 32 e) (zext 32 e_1) ⊑ zext 32 (urem e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem urem_i32_multiuse_proof.urem_i32_multiuse_thm_1 (e e_1 : IntW 8) :
  mul (urem (zext 32 e) (zext 32 e_1)) (add (zext 32 e) (zext 32 e_1)) ⊑
    mul (urem (zext 32 e) (zext 32 e_1)) (add (zext 32 e) (zext 32 e_1) { «nsw» := true, «nuw» := true })
      { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem urem_illegal_type_proof.urem_illegal_type_thm_1 (e e_1 : IntW 9) :
  urem (zext 32 e) (zext 32 e_1) ⊑ zext 32 (urem e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_i32_c_proof.udiv_i32_c_thm_1 (e : IntW 8) :
  LLVM.udiv (zext 32 e) (const? 32 10) ⊑ zext 32 (LLVM.udiv e (const? 8 10)) { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_i32_c_multiuse_proof.udiv_i32_c_multiuse_thm_1 (e : IntW 8) :
  add (zext 32 e) (LLVM.udiv (zext 32 e) (const? 32 10)) ⊑
    add (LLVM.udiv (zext 32 e) (const? 32 10)) (zext 32 e) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_illegal_type_c_proof.udiv_illegal_type_c_thm_1 (e : IntW 9) :
  LLVM.udiv (zext 32 e) (const? 32 10) ⊑ zext 32 (LLVM.udiv e (const? 9 10)) { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem urem_i32_c_proof.urem_i32_c_thm_1 (e : IntW 8) :
  urem (zext 32 e) (const? 32 10) ⊑ zext 32 (urem e (const? 8 10)) { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem urem_i32_c_multiuse_proof.urem_i32_c_multiuse_thm_1 (e : IntW 8) :
  add (zext 32 e) (urem (zext 32 e) (const? 32 10)) ⊑
    add (urem (zext 32 e) (const? 32 10)) (zext 32 e) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem urem_illegal_type_c_proof.urem_illegal_type_c_thm_1 (e : IntW 9) :
  urem (zext 32 e) (const? 32 10) ⊑ zext 32 (urem e (const? 9 10)) { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem udiv_c_i32_proof.udiv_c_i32_thm_1 (e : IntW 8) :
  LLVM.udiv (const? 32 10) (zext 32 e) ⊑ zext 32 (LLVM.udiv (const? 8 10) e) { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem urem_c_i32_proof.urem_c_i32_thm_1 (e : IntW 8) :
  urem (const? 32 10) (zext 32 e) ⊑ zext 32 (urem (const? 8 10) e) { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
