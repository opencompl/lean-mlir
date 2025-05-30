
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphrange_proof
theorem ugt_zext_thm (e : IntW 8) (e_1 : IntW 1) :
  icmp IntPred.ugt (zext 8 e_1) e ⊑ LLVM.and (icmp IntPred.eq e (const? 8 0)) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_zext_thm (e : IntW 8) (e_1 : IntW 1) :
  icmp IntPred.uge (zext 8 e_1) e ⊑ icmp IntPred.ule e (zext 8 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_ult_zext_thm (e : IntW 1) (e_1 e_2 : IntW 8) :
  icmp IntPred.ult (sub e_2 e_1) (zext 8 e) ⊑ LLVM.and (icmp IntPred.eq e_2 e_1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_ult_zext_thm (e : IntW 1) (e_1 : IntW 8) :
  icmp IntPred.ult (zext 16 (mul e_1 e_1)) (zext 16 e) ⊑
    LLVM.and (icmp IntPred.eq (mul e_1 e_1) (const? 8 0)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem uge_sext_thm (e : IntW 8) (e_1 : IntW 1) :
  icmp IntPred.uge (sext 8 e_1) e ⊑ LLVM.or (icmp IntPred.eq e (const? 8 0)) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_sext_thm (e : IntW 8) (e_1 : IntW 1) :
  icmp IntPred.ugt (sext 8 e_1) e ⊑ icmp IntPred.ult e (sext 8 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_ule_sext_thm (e : IntW 1) (e_1 e_2 : IntW 8) :
  icmp IntPred.ule (sub e_2 e_1) (sext 8 e) ⊑ LLVM.or (icmp IntPred.eq e_2 e_1) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_ule_sext_thm (e : IntW 1) (e_1 : IntW 8) :
  icmp IntPred.ule (sext 16 (mul e_1 e_1)) (sext 16 e) ⊑
    LLVM.or (icmp IntPred.eq (mul e_1 e_1) (const? 8 0)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_slt_minus1_thm (e e_1 : IntW 1) :
  icmp IntPred.slt (add (zext 8 e_1) (sext 8 e)) (const? 8 (-1)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_sgt_1_thm (e e_1 : IntW 1) :
  icmp IntPred.sgt (add (zext 8 e_1) (sext 8 e)) (const? 8 1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_sgt_minus2_thm (e e_1 : IntW 1) :
  icmp IntPred.sgt (add (zext 8 e_1) (sext 8 e)) (const? 8 (-2)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_slt_2_thm (e e_1 : IntW 1) :
  icmp IntPred.slt (add (zext 8 e_1) (sext 8 e)) (const? 8 2) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_i128_thm (e e_1 : IntW 1) :
  icmp IntPred.sgt (add (zext 128 e_1) (sext 128 e)) (const? 128 9223372036854775808) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_eq_minus1_thm (e e_1 : IntW 1) :
  icmp IntPred.eq (add (zext 8 e_1) (sext 8 e)) (const? 8 (-1)) ⊑ LLVM.and e (LLVM.xor e_1 (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_ne_minus1_thm (e e_1 : IntW 1) :
  icmp IntPred.ne (add (zext 8 e_1) (sext 8 e)) (const? 8 (-1)) ⊑ LLVM.or e_1 (LLVM.xor e (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_sgt_minus1_thm (e e_1 : IntW 1) :
  icmp IntPred.sgt (add (zext 8 e_1) (sext 8 e)) (const? 8 (-1)) ⊑ LLVM.or e_1 (LLVM.xor e (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_ult_minus1_thm (e e_1 : IntW 1) :
  icmp IntPred.ult (add (zext 8 e_1) (sext 8 e)) (const? 8 (-1)) ⊑ LLVM.or e_1 (LLVM.xor e (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_sgt_0_thm (e e_1 : IntW 1) :
  icmp IntPred.sgt (add (zext 8 e_1) (sext 8 e)) (const? 8 0) ⊑ LLVM.and e_1 (LLVM.xor e (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_slt_0_thm (e e_1 : IntW 1) :
  icmp IntPred.slt (add (zext 8 e_1) (sext 8 e)) (const? 8 0) ⊑ LLVM.and e (LLVM.xor e_1 (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_eq_1_thm (e e_1 : IntW 1) :
  icmp IntPred.eq (add (zext 8 e_1) (sext 8 e)) (const? 8 1) ⊑ LLVM.and e_1 (LLVM.xor e (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_ne_1_thm (e e_1 : IntW 1) :
  icmp IntPred.ne (add (zext 8 e_1) (sext 8 e)) (const? 8 1) ⊑ LLVM.or e (LLVM.xor e_1 (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_slt_1_thm (e e_1 : IntW 1) :
  icmp IntPred.slt (add (zext 8 e_1) (sext 8 e)) (const? 8 1) ⊑ LLVM.or e (LLVM.xor e_1 (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_ugt_1_thm (e e_1 : IntW 1) :
  icmp IntPred.ugt (add (zext 8 e_1) (sext 8 e)) (const? 8 1) ⊑ LLVM.and e (LLVM.xor e_1 (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_slt_1_rhs_not_const_thm (e : IntW 8) (e_1 e_2 : IntW 1) :
  icmp IntPred.slt (add (zext 8 e_2) (sext 8 e_1)) e ⊑
    icmp IntPred.slt (add (zext 8 e_2) (sext 8 e_1) { «nsw» := true, «nuw» := false }) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_sext_add_icmp_slt_1_type_not_i1_thm (e : IntW 1) (e_1 : IntW 2) :
  icmp IntPred.slt (add (zext 8 e_1) (sext 8 e)) (const? 8 1) ⊑
    icmp IntPred.slt (add (zext 8 e_1) (sext 8 e) { «nsw» := true, «nuw» := false }) (const? 8 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_zext_eq_zero_thm (e : IntW 32) :
  icmp IntPred.ne (zext 32 (icmp IntPred.eq e (const? 32 0))) e ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_zext_ne_zero_thm (e : IntW 32) :
  icmp IntPred.ne (zext 32 (icmp IntPred.ne e (const? 32 0))) e ⊑
    icmp IntPred.ugt e (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_zext_eq_zero_thm (e : IntW 32) :
  icmp IntPred.eq (zext 32 (icmp IntPred.eq e (const? 32 0))) e ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_zext_ne_zero_thm (e : IntW 32) :
  icmp IntPred.eq (zext 32 (icmp IntPred.ne e (const? 32 0))) e ⊑
    icmp IntPred.ult e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_zext_eq_one_thm (e : IntW 32) :
  icmp IntPred.ne (zext 32 (icmp IntPred.eq e (const? 32 1))) e ⊑
    icmp IntPred.ugt e (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_zext_ne_one_thm (e : IntW 32) :
  icmp IntPred.ne (zext 32 (icmp IntPred.ne e (const? 32 1))) e ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_zext_eq_one_thm (e : IntW 32) :
  icmp IntPred.eq (zext 32 (icmp IntPred.eq e (const? 32 1))) e ⊑
    icmp IntPred.ult e (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_zext_ne_one_thm (e : IntW 32) :
  icmp IntPred.eq (zext 32 (icmp IntPred.ne e (const? 32 1))) e ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_zext_eq_non_boolean_thm (e : IntW 32) :
  icmp IntPred.ne (zext 32 (icmp IntPred.eq e (const? 32 2))) e ⊑
    icmp IntPred.ne e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_zext_ne_non_boolean_thm (e : IntW 32) :
  icmp IntPred.ne (zext 32 (icmp IntPred.ne e (const? 32 2))) e ⊑
    icmp IntPred.ne e (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_zext_eq_non_boolean_thm (e : IntW 32) :
  icmp IntPred.eq (zext 32 (icmp IntPred.eq e (const? 32 2))) e ⊑
    icmp IntPred.eq e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_zext_ne_non_boolean_thm (e : IntW 32) :
  icmp IntPred.eq (zext 32 (icmp IntPred.ne e (const? 32 2))) e ⊑
    icmp IntPred.eq e (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_sext_eq_zero_thm (e : IntW 32) :
  icmp IntPred.ne (sext 32 (icmp IntPred.eq e (const? 32 0))) e ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_sext_ne_zero_thm (e : IntW 32) :
  icmp IntPred.ne (sext 32 (icmp IntPred.ne e (const? 32 0))) e ⊑
    icmp IntPred.ult (add e (const? 32 (-1))) (const? 32 (-2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_sext_eq_zero_thm (e : IntW 32) :
  icmp IntPred.eq (sext 32 (icmp IntPred.eq e (const? 32 0))) e ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_sext_ne_zero_thm (e : IntW 32) :
  icmp IntPred.eq (sext 32 (icmp IntPred.ne e (const? 32 0))) e ⊑
    icmp IntPred.ult (add e (const? 32 1)) (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_sext_eq_allones_thm (e : IntW 32) :
  icmp IntPred.ne (sext 32 (icmp IntPred.eq e (const? 32 (-1)))) e ⊑
    icmp IntPred.ult (add e (const? 32 (-1))) (const? 32 (-2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_sext_ne_allones_thm (e : IntW 32) :
  icmp IntPred.ne (sext 32 (icmp IntPred.ne e (const? 32 (-1)))) e ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_sext_eq_allones_thm (e : IntW 32) :
  icmp IntPred.eq (sext 32 (icmp IntPred.eq e (const? 32 (-1)))) e ⊑
    icmp IntPred.ult (add e (const? 32 1)) (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_sext_ne_allones_thm (e : IntW 32) :
  icmp IntPred.eq (sext 32 (icmp IntPred.ne e (const? 32 (-1)))) e ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_sext_eq_otherwise_thm (e : IntW 32) :
  icmp IntPred.ne (sext 32 (icmp IntPred.eq e (const? 32 2))) e ⊑
    icmp IntPred.ne e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_sext_ne_otherwise_thm (e : IntW 32) :
  icmp IntPred.ne (sext 32 (icmp IntPred.ne e (const? 32 2))) e ⊑
    icmp IntPred.ne e (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_sext_eq_otherwise_thm (e : IntW 32) :
  icmp IntPred.eq (sext 32 (icmp IntPred.eq e (const? 32 2))) e ⊑
    icmp IntPred.eq e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_eq_sext_ne_otherwise_thm (e : IntW 32) :
  icmp IntPred.eq (sext 32 (icmp IntPred.ne e (const? 32 2))) e ⊑
    icmp IntPred.eq e (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_sext_ne_zero_i128_thm (e : IntW 128) :
  icmp IntPred.ne (sext 128 (icmp IntPred.ne e (const? 128 0))) e ⊑
    icmp IntPred.ult (add e (const? 128 (-1))) (const? 128 (-2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_sext_ne_otherwise_i128_thm (e : IntW 128) :
  icmp IntPred.ne (sext 128 (icmp IntPred.ne e (const? 128 2))) e ⊑
    icmp IntPred.ne e (const? 128 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_sext_sgt_zero_nofold_thm (e : IntW 32) :
  icmp IntPred.ne (sext 32 (icmp IntPred.sgt e (const? 32 0))) e ⊑
    icmp IntPred.ne e (sext 32 (icmp IntPred.sgt e (const? 32 0))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_sext_ne_zero_nofold_thm (e : IntW 32) :
  icmp IntPred.slt (sext 32 (icmp IntPred.ne e (const? 32 0))) e ⊑
    icmp IntPred.sgt e (sext 32 (icmp IntPred.ne e (const? 32 0))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_sext_slt_allones_nofold_thm (e : IntW 32) :
  icmp IntPred.ne (sext 32 (icmp IntPred.slt e (const? 32 (-1)))) e ⊑
    icmp IntPred.ne e (sext 32 (icmp IntPred.slt e (const? 32 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_sext_ne_allones_nofold_thm (e : IntW 32) :
  icmp IntPred.slt (sext 32 (icmp IntPred.ne e (const? 32 (-1)))) e ⊑
    icmp IntPred.sgt e (sext 32 (icmp IntPred.ne e (const? 32 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ne_sext_slt_otherwise_nofold_thm (e : IntW 32) :
  icmp IntPred.ne (sext 32 (icmp IntPred.slt e (const? 32 2))) e ⊑
    icmp IntPred.ne e (sext 32 (icmp IntPred.slt e (const? 32 2))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_slt_sext_ne_otherwise_nofold_thm (e : IntW 32) :
  icmp IntPred.slt (sext 32 (icmp IntPred.ne e (const? 32 2))) e ⊑
    icmp IntPred.sgt e (sext 32 (icmp IntPred.ne e (const? 32 2))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
