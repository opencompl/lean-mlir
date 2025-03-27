
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gzext_proof
theorem test_sext_zext_thm (e : IntW 16) : sext 64 (zext 32 e) ⊑ zext 64 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_xor_zext_sandwich_thm (e : IntW 1) :
  zext 64 (LLVM.xor (zext 32 e) (const? 32 1)) ⊑ zext 64 (LLVM.xor e (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_and_zext_icmp_thm (e e_1 e_2 : IntW 64) :
  LLVM.and (zext 8 (icmp IntPredicate.sgt e_2 e_1)) (zext 8 (icmp IntPredicate.slt e_2 e)) ⊑
    zext 8 (LLVM.and (icmp IntPredicate.sgt e_2 e_1) (icmp IntPredicate.slt e_2 e)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_or_zext_icmp_thm (e e_1 e_2 : IntW 64) :
  LLVM.or (zext 8 (icmp IntPredicate.sgt e_2 e_1)) (zext 8 (icmp IntPredicate.slt e_2 e)) ⊑
    zext 8 (LLVM.or (icmp IntPredicate.sgt e_2 e_1) (icmp IntPredicate.slt e_2 e)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_xor_zext_icmp_thm (e e_1 e_2 : IntW 64) :
  LLVM.xor (zext 8 (icmp IntPredicate.sgt e_2 e_1)) (zext 8 (icmp IntPredicate.slt e_2 e)) ⊑
    zext 8 (LLVM.xor (icmp IntPredicate.sgt e_2 e_1) (icmp IntPredicate.slt e_2 e)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_nested_logic_zext_icmp_thm (e e_1 e_2 e_3 : IntW 64) :
  LLVM.or (LLVM.and (zext 8 (icmp IntPredicate.sgt e_3 e_2)) (zext 8 (icmp IntPredicate.slt e_3 e_1)))
      (zext 8 (icmp IntPredicate.eq e_3 e)) ⊑
    zext 8
      (LLVM.or (LLVM.and (icmp IntPredicate.sgt e_3 e_2) (icmp IntPredicate.slt e_3 e_1))
        (icmp IntPredicate.eq e_3 e)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_zext_apint1_thm (e : IntW 77) : sext 1024 (zext 533 e) ⊑ zext 1024 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_zext_apint2_thm (e : IntW 11) : sext 47 (zext 39 e) ⊑ zext 47 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem masked_bit_set_thm (e e_1 : IntW 32) :
  zext 32 (icmp IntPredicate.ne (LLVM.and (shl (const? 32 1) e_1) e) (const? 32 0)) ⊑
    LLVM.and (lshr e e_1) (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem masked_bit_clear_commute_thm (e e_1 : IntW 32) :
  zext 32 (icmp IntPredicate.eq (LLVM.and (LLVM.srem (const? 32 42) e_1) (shl (const? 32 1) e)) (const? 32 0)) ⊑
    LLVM.and (lshr (LLVM.xor (LLVM.srem (const? 32 42) e_1) (const? 32 (-1))) e) (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem div_bit_set_thm (e e_1 : IntW 32) :
  zext 32 (icmp IntPredicate.ne (LLVM.sdiv (shl (const? 32 1) e_1) e) (const? 32 0)) ⊑
    zext 32
      (icmp IntPredicate.ne (LLVM.sdiv (shl (const? 32 1) e_1 { «nsw» := false, «nuw» := true }) e)
        (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem masked_bit_set_nonzero_cmp_thm (e e_1 : IntW 32) :
  zext 32 (icmp IntPredicate.ne (LLVM.and (shl (const? 32 1) e_1) e) (const? 32 1)) ⊑
    zext 32
      (icmp IntPredicate.ne (LLVM.and (shl (const? 32 1) e_1 { «nsw» := false, «nuw» := true }) e)
        (const? 32 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem masked_bit_wrong_pred_thm (e e_1 : IntW 32) :
  zext 32 (icmp IntPredicate.sgt (LLVM.and (shl (const? 32 1) e_1) e) (const? 32 0)) ⊑
    zext 32
      (icmp IntPredicate.sgt (LLVM.and (shl (const? 32 1) e_1 { «nsw» := false, «nuw» := true }) e)
        (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_or_masked_bit_test_thm (e e_1 e_2 : IntW 32) :
  zext 32
      (LLVM.or (icmp IntPredicate.ne (LLVM.and (shl (const? 32 1) e_2) e_1) (const? 32 0))
        (icmp IntPredicate.eq e e_2)) ⊑
    zext 32
      (LLVM.or
        (icmp IntPredicate.ne (LLVM.and (shl (const? 32 1) e_2 { «nsw» := false, «nuw» := true }) e_1) (const? 32 0))
        (icmp IntPredicate.eq e e_2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_masked_bit_zero_to_smaller_bitwidth_thm (e e_1 : IntW 32) :
  zext 16 (icmp IntPredicate.eq (LLVM.and (shl (const? 32 1) e_1) e) (const? 32 0)) ⊑
    LLVM.and (trunc 16 (lshr (LLVM.xor e (const? 32 (-1))) e_1)) (const? 16 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_masked_bit_nonzero_to_smaller_bitwidth_thm (e e_1 : IntW 32) :
  zext 16 (icmp IntPredicate.ne (LLVM.and (shl (const? 32 1) e_1) e) (const? 32 0)) ⊑
    LLVM.and (trunc 16 (lshr e e_1)) (const? 16 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_masked_bit_zero_to_larger_bitwidth_thm (e e_1 : IntW 32) :
  zext 64 (icmp IntPredicate.eq (LLVM.and (shl (const? 32 1) e_1) e) (const? 32 0)) ⊑
    zext 64 (LLVM.and (lshr (LLVM.xor e (const? 32 (-1))) e_1) (const? 32 1)) { «nneg» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_nneg_flag_drop_thm (e : IntW 16) (e_1 : IntW 8) :
  LLVM.or (LLVM.or (zext 16 (LLVM.and e_1 (const? 8 127)) { «nneg» := true }) e) (const? 16 128) ⊑
    LLVM.or (LLVM.or e (zext 16 e_1)) (const? 16 128) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_nneg_redundant_and_thm (e : IntW 8) :
  LLVM.and (zext 32 e { «nneg» := true }) (const? 32 127) ⊑ zext 32 e { «nneg» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_nneg_signbit_extract_thm (e : IntW 32) : lshr (zext 64 e { «nneg» := true }) (const? 64 31) ⊑ const? 64 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem zext_nneg_i1_thm (e : IntW 1) : zext 32 e { «nneg» := true } ⊑ const? 32 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
