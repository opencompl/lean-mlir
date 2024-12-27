
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gicmphexthext_proof
theorem zext_zext_sgt_thm (e e_1 : IntW 8) :
  icmp IntPredicate.sgt (zext 32 e_1) (zext 32 e) ⊑ icmp IntPredicate.ugt e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_zext_eq_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (zext 32 e_1) (zext 32 e) ⊑ icmp IntPredicate.eq e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_zext_sle_op0_narrow_thm (e : IntW 16) (e_1 : IntW 8) :
  icmp IntPredicate.sle (zext 32 e_1) (zext 32 e) ⊑ icmp IntPredicate.uge e (zext 16 e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_zext_ule_op0_wide_thm (e : IntW 8) (e_1 : IntW 9) :
  icmp IntPredicate.ule (zext 32 e_1) (zext 32 e) ⊑ icmp IntPredicate.ule e_1 (zext 9 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_sext_slt_thm (e e_1 : IntW 8) :
  icmp IntPredicate.slt (sext 32 e_1) (sext 32 e) ⊑ icmp IntPredicate.slt e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_sext_ult_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (sext 32 e_1) (sext 32 e) ⊑ icmp IntPredicate.ult e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_sext_ne_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (sext 32 e_1) (sext 32 e) ⊑ icmp IntPredicate.ne e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_sext_sge_op0_narrow_thm (e : IntW 8) (e_1 : IntW 5) :
  icmp IntPredicate.sge (sext 32 e_1) (sext 32 e) ⊑ icmp IntPredicate.sle e (sext 8 e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_nneg_sext_sgt_thm (e e_1 : IntW 8) :
  icmp IntPredicate.sgt (zext 32 e_1 { «nneg» := true }) (sext 32 e) ⊑ icmp IntPredicate.sgt e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_nneg_sext_ugt_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ugt (zext 32 e_1 { «nneg» := true }) (sext 32 e) ⊑ icmp IntPredicate.ugt e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_nneg_sext_eq_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (zext 32 e_1 { «nneg» := true }) (sext 32 e) ⊑ icmp IntPredicate.eq e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_nneg_sext_sle_op0_narrow_thm (e : IntW 16) (e_1 : IntW 8) :
  icmp IntPredicate.sle (zext 32 e_1 { «nneg» := true }) (sext 32 e) ⊑ icmp IntPredicate.sge e (sext 16 e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_nneg_sext_ule_op0_wide_thm (e : IntW 8) (e_1 : IntW 9) :
  icmp IntPredicate.ule (zext 32 e_1 { «nneg» := true }) (sext 32 e) ⊑ icmp IntPredicate.ule e_1 (sext 9 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_zext_nneg_slt_thm (e e_1 : IntW 8) :
  icmp IntPredicate.slt (sext 32 e_1) (zext 32 e { «nneg» := true }) ⊑ icmp IntPredicate.slt e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_zext_nneg_ult_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (sext 32 e_1) (zext 32 e { «nneg» := true }) ⊑ icmp IntPredicate.ult e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_zext_nneg_sge_op0_narrow_thm (e : IntW 8) (e_1 : IntW 5) :
  icmp IntPredicate.sge (sext 32 e_1) (zext 32 e { «nneg» := true }) ⊑ icmp IntPredicate.sle e (sext 8 e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_zext_nneg_uge_op0_wide_thm (e : IntW 8) (e_1 : IntW 16) :
  icmp IntPredicate.uge (sext 32 e_1) (zext 32 e { «nneg» := true }) ⊑ icmp IntPredicate.uge e_1 (sext 16 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_sgt_known_nonneg_thm (e e_1 : IntW 8) :
  icmp IntPredicate.sgt (zext 32 (LLVM.udiv (const? 8 127) e_1)) (sext 32 e) ⊑
    icmp IntPredicate.sgt (LLVM.udiv (const? 8 127) e_1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_ugt_known_nonneg_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ugt (zext 32 (LLVM.and e_1 (const? 8 127))) (sext 32 e) ⊑
    icmp IntPredicate.ugt (LLVM.and e_1 (const? 8 127)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_eq_known_nonneg_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (zext 32 (lshr e_1 (const? 8 1))) (sext 32 e) ⊑
    icmp IntPredicate.eq (lshr e_1 (const? 8 1)) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_sle_known_nonneg_op0_narrow_thm (e : IntW 16) (e_1 : IntW 8) :
  icmp IntPredicate.sle (zext 32 (LLVM.and e_1 (const? 8 12))) (sext 32 e) ⊑
    icmp IntPredicate.sge e (zext 16 (LLVM.and e_1 (const? 8 12)) { «nneg» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_ule_known_nonneg_op0_wide_thm (e : IntW 8) (e_1 : IntW 9) :
  icmp IntPredicate.ule (zext 32 (urem e_1 (const? 9 254))) (sext 32 e) ⊑
    icmp IntPredicate.ule (urem e_1 (const? 9 254)) (sext 9 e) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_zext_slt_known_nonneg_thm (e e_1 : IntW 8) :
  icmp IntPredicate.slt (sext 32 e_1) (zext 32 (LLVM.and e (const? 8 126))) ⊑
    icmp IntPredicate.slt e_1 (LLVM.and e (const? 8 126)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_zext_ult_known_nonneg_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (sext 32 e_1) (zext 32 (lshr e (const? 8 6))) ⊑
    icmp IntPredicate.ult e_1 (lshr e (const? 8 6)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_zext_ne_known_nonneg_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (sext 32 e_1) (zext 32 (LLVM.udiv e (const? 8 6))) ⊑
    icmp IntPredicate.ne e_1 (LLVM.udiv e (const? 8 6)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_zext_uge_known_nonneg_op0_wide_thm (e : IntW 8) (e_1 : IntW 16) :
  icmp IntPredicate.uge (sext 32 e_1) (zext 32 (LLVM.and e (const? 8 12))) ⊑
    icmp IntPredicate.uge e_1 (zext 16 (LLVM.and e (const? 8 12)) { «nneg» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_eq_sext_thm (e e_1 : IntW 1) :
  icmp IntPredicate.eq (zext 32 e_1) (sext 32 e) ⊑ LLVM.xor (LLVM.or e_1 e) (const? 1 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


