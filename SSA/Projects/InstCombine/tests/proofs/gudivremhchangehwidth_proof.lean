
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gudivremhchangehwidth_proof
theorem udiv_i8_thm (e e_1 : IntW 8) : trunc 8 (LLVM.udiv (zext 32 e_1) (zext 32 e)) ⊑ LLVM.udiv e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem urem_i8_thm (e e_1 : IntW 8) : trunc 8 (urem (zext 32 e_1) (zext 32 e)) ⊑ urem e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_i32_thm (e e_1 : IntW 8) : LLVM.udiv (zext 32 e_1) (zext 32 e) ⊑ zext 32 (LLVM.udiv e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_i32_multiuse_thm (e e_1 : IntW 8) :
  mul (LLVM.udiv (zext 32 e_1) (zext 32 e)) (add (zext 32 e_1) (zext 32 e)) ⊑
    mul (LLVM.udiv (zext 32 e_1) (zext 32 e)) (add (zext 32 e_1) (zext 32 e) { «nsw» := true, «nuw» := true })
      { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_illegal_type_thm (e e_1 : IntW 9) : LLVM.udiv (zext 32 e_1) (zext 32 e) ⊑ zext 32 (LLVM.udiv e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem urem_i32_thm (e e_1 : IntW 8) : urem (zext 32 e_1) (zext 32 e) ⊑ zext 32 (urem e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem urem_i32_multiuse_thm (e e_1 : IntW 8) :
  mul (urem (zext 32 e_1) (zext 32 e)) (add (zext 32 e_1) (zext 32 e)) ⊑
    mul (urem (zext 32 e_1) (zext 32 e)) (add (zext 32 e_1) (zext 32 e) { «nsw» := true, «nuw» := true })
      { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem urem_illegal_type_thm (e e_1 : IntW 9) : urem (zext 32 e_1) (zext 32 e) ⊑ zext 32 (urem e_1 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_i32_c_thm (e : IntW 8) :
  LLVM.udiv (zext 32 e) (const? 32 10) ⊑ zext 32 (LLVM.udiv e (const? 8 10)) { «nneg» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_i32_c_multiuse_thm (e : IntW 8) :
  add (zext 32 e) (LLVM.udiv (zext 32 e) (const? 32 10)) ⊑
    add (LLVM.udiv (zext 32 e) (const? 32 10)) (zext 32 e) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_illegal_type_c_thm (e : IntW 9) :
  LLVM.udiv (zext 32 e) (const? 32 10) ⊑ zext 32 (LLVM.udiv e (const? 9 10)) { «nneg» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem urem_i32_c_thm (e : IntW 8) :
  urem (zext 32 e) (const? 32 10) ⊑ zext 32 (urem e (const? 8 10)) { «nneg» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem urem_i32_c_multiuse_thm (e : IntW 8) :
  add (zext 32 e) (urem (zext 32 e) (const? 32 10)) ⊑
    add (urem (zext 32 e) (const? 32 10)) (zext 32 e) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem urem_illegal_type_c_thm (e : IntW 9) :
  urem (zext 32 e) (const? 32 10) ⊑ zext 32 (urem e (const? 9 10)) { «nneg» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_c_i32_thm (e : IntW 8) :
  LLVM.udiv (const? 32 10) (zext 32 e) ⊑ zext 32 (LLVM.udiv (const? 8 10) e) { «nneg» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem urem_c_i32_thm (e : IntW 8) :
  urem (const? 32 10) (zext 32 e) ⊑ zext 32 (urem (const? 8 10) e) { «nneg» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


