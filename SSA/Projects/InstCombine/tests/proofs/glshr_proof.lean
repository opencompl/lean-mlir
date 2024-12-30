
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000

section glshr_proof
theorem lshr_exact_thm (e : IntW 8) :
  lshr (add (shl e (const? 8 2)) (const? 8 4)) (const? 8 2) ⊑ LLVM.and (add e (const? 8 1)) (const? 8 63) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_add_thm (e e_1 : IntW 8) :
  lshr (add (shl e_1 (const? 8 2)) e) (const? 8 2) ⊑ LLVM.and (add (lshr e (const? 8 2)) e_1) (const? 8 63) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bool_zext_thm (e : IntW 1) : lshr (sext 16 e) (const? 16 15) ⊑ zext 16 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem smear_sign_and_widen_thm (e : IntW 8) : lshr (sext 32 e) (const? 32 24) ⊑ zext 32 (ashr e (const? 8 7)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fake_sext_thm (e : IntW 3) :
  lshr (sext 18 e) (const? 18 17) ⊑ zext 18 (lshr e (const? 3 2)) { «nneg» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_splat_fold_thm (e : IntW 32) :
  lshr (mul e (const? 32 65537) { «nsw» := false, «nuw» := true }) (const? 32 16) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_add_lshr_flag_preservation_thm (e e_1 e_2 : IntW 32) :
  lshr (add (shl e_2 e_1 { «nsw» := false, «nuw» := true }) e { «nsw» := true, «nuw» := true }) e_1
      { «exact» := true } ⊑
    add (lshr e e_1 { «exact» := true }) e_2 { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_add_lshr_thm (e e_1 e_2 : IntW 32) :
  lshr (add (shl e_2 e_1 { «nsw» := false, «nuw» := true }) e { «nsw» := false, «nuw» := true }) e_1 ⊑
    add (lshr e e_1) e_2 { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_add_lshr_comm_thm (e e_1 e_2 : IntW 32) :
  lshr (add (mul e_2 e_2) (shl e_1 e { «nsw» := false, «nuw» := true }) { «nsw» := false, «nuw» := true }) e ⊑
    add (lshr (mul e_2 e_2) e) e_1 { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_sub_lshr_thm (e e_1 e_2 : IntW 32) :
  lshr (sub (shl e_2 e_1 { «nsw» := false, «nuw» := true }) e { «nsw» := true, «nuw» := true }) e_1
      { «exact» := true } ⊑
    sub e_2 (lshr e e_1 { «exact» := true }) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_sub_lshr_reverse_thm (e e_1 e_2 : IntW 32) :
  lshr (sub e_2 (shl e_1 e { «nsw» := false, «nuw» := true }) { «nsw» := true, «nuw» := true }) e { «exact» := true } ⊑
    sub (lshr e_2 e { «exact» := true }) e_1 { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_sub_lshr_reverse_no_nsw_thm (e e_1 e_2 : IntW 32) :
  lshr (sub e_2 (shl e_1 e { «nsw» := false, «nuw» := true }) { «nsw» := false, «nuw» := true }) e { «exact» := true } ⊑
    sub (lshr e_2 e { «exact» := true }) e_1 { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_sub_lshr_reverse_nsw_on_op1_thm (e e_1 e_2 : IntW 32) :
  lshr (sub e_2 (shl e_1 e { «nsw» := true, «nuw» := true }) { «nsw» := false, «nuw» := true }) e { «exact» := true } ⊑
    sub (lshr e_2 e { «exact» := true }) e_1 { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_or_lshr_thm (e e_1 e_2 : IntW 32) :
  lshr (LLVM.or (shl e_2 e_1 { «nsw» := false, «nuw» := true }) e) e_1 ⊑ LLVM.or (lshr e e_1) e_2 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_or_disjoint_lshr_thm (e e_1 e_2 : IntW 32) :
  lshr (LLVM.or (shl e_2 e_1 { «nsw» := false, «nuw» := true }) e { «disjoint» := true }) e_1 ⊑
    LLVM.or (lshr e e_1) e_2 { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_or_lshr_comm_thm (e e_1 e_2 : IntW 32) :
  lshr (LLVM.or e_2 (shl e_1 e { «nsw» := false, «nuw» := true })) e ⊑ LLVM.or (lshr e_2 e) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_or_disjoint_lshr_comm_thm (e e_1 e_2 : IntW 32) :
  lshr (LLVM.or e_2 (shl e_1 e { «nsw» := false, «nuw» := true }) { «disjoint» := true }) e ⊑
    LLVM.or (lshr e_2 e) e_1 { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_xor_lshr_thm (e e_1 e_2 : IntW 32) :
  lshr (LLVM.xor (shl e_2 e_1 { «nsw» := false, «nuw» := true }) e) e_1 ⊑ LLVM.xor (lshr e e_1) e_2 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_xor_lshr_comm_thm (e e_1 e_2 : IntW 32) :
  lshr (LLVM.xor e_2 (shl e_1 e { «nsw» := false, «nuw» := true })) e ⊑ LLVM.xor (lshr e_2 e) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_and_lshr_thm (e e_1 e_2 : IntW 32) :
  lshr (LLVM.and (shl e_2 e_1 { «nsw» := false, «nuw» := true }) e) e_1 ⊑ LLVM.and (lshr e e_1) e_2 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_and_lshr_comm_thm (e e_1 e_2 : IntW 32) :
  lshr (LLVM.and e_2 (shl e_1 e { «nsw» := false, «nuw» := true })) e ⊑ LLVM.and (lshr e_2 e) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_lshr_and_exact_thm (e e_1 e_2 : IntW 32) :
  lshr (LLVM.and (shl e_2 e_1 { «nsw» := false, «nuw» := true }) e) e_1 { «exact» := true } ⊑
    LLVM.and (lshr e e_1) e_2 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_splat_fold_no_nuw_thm (e : IntW 32) :
  lshr (mul e (const? 32 65537) { «nsw» := true, «nuw» := false }) (const? 32 16) ⊑
    add e (lshr e (const? 32 16)) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_splat_fold_too_narrow_thm (e : IntW 2) :
  lshr (mul e (const? 2 (-2)) { «nsw» := false, «nuw» := true }) (const? 2 1) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem negative_and_odd_thm (e : IntW 32) :
  lshr (LLVM.srem e (const? 32 2)) (const? 32 31) ⊑ LLVM.and (lshr e (const? 32 31)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_sandwich_thm (e : IntW 32) :
  lshr (trunc 12 (lshr e (const? 32 28))) (const? 12 2) ⊑
    trunc 12 (lshr e (const? 32 30)) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_sandwich_min_shift1_thm (e : IntW 32) :
  lshr (trunc 12 (lshr e (const? 32 20))) (const? 12 1) ⊑
    trunc 12 (lshr e (const? 32 21)) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_sandwich_small_shift1_thm (e : IntW 32) :
  lshr (trunc 12 (lshr e (const? 32 19))) (const? 12 1) ⊑
    LLVM.and (trunc 12 (lshr e (const? 32 20)) { «nsw» := false, «nuw» := true }) (const? 12 2047) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_sandwich_max_sum_shift_thm (e : IntW 32) :
  lshr (trunc 12 (lshr e (const? 32 20))) (const? 12 11) ⊑
    trunc 12 (lshr e (const? 32 31)) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_sandwich_max_sum_shift2_thm (e : IntW 32) :
  lshr (trunc 12 (lshr e (const? 32 30))) (const? 12 1) ⊑
    trunc 12 (lshr e (const? 32 31)) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_sandwich_big_sum_shift1_thm (e : IntW 32) : lshr (trunc 12 (lshr e (const? 32 21))) (const? 12 11) ⊑ const? 12 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem trunc_sandwich_big_sum_shift2_thm (e : IntW 32) : lshr (trunc 12 (lshr e (const? 32 31))) (const? 12 1) ⊑ const? 12 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_sext_i1_to_i16_thm (e : IntW 1) : lshr (sext 16 e) (const? 16 4) ⊑ select e (const? 16 4095) (const? 16 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_sext_i1_to_i128_thm (e : IntW 1) :
  lshr (sext 128 e) (const? 128 42) ⊑ select e (const? 128 77371252455336267181195263) (const? 128 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ule_thm (e e_1 : IntW 32) : icmp IntPredicate.ule (lshr e_1 e) e_1 ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_ugt_thm (e e_1 : IntW 32) : icmp IntPredicate.ugt (lshr e_1 e) e_1 ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_signbit_thm (e : IntW 8) :
  lshr (LLVM.xor e (const? 8 (-1))) (const? 8 7) ⊑ zext 8 (icmp IntPredicate.sgt e (const? 8 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_signbit_alt_xor_thm (e : IntW 8) :
  lshr (LLVM.xor e (const? 8 (-2))) (const? 8 7) ⊑ zext 8 (icmp IntPredicate.sgt e (const? 8 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_signbit_zext_thm (e : IntW 16) :
  zext 32 (lshr (LLVM.xor e (const? 16 (-1))) (const? 16 15)) ⊑
    zext 32 (icmp IntPredicate.sgt e (const? 16 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_signbit_trunc_thm (e : IntW 16) :
  trunc 8 (lshr (LLVM.xor e (const? 16 (-1))) (const? 16 15)) ⊑
    zext 8 (icmp IntPredicate.sgt e (const? 16 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bool_add_lshr_thm (e e_1 : IntW 1) :
  lshr (add (zext 2 e_1) (zext 2 e)) (const? 2 1) ⊑ zext 2 (LLVM.and e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_bool_add_lshr_thm (e e_1 : IntW 2) :
  lshr (add (zext 4 e_1) (zext 4 e)) (const? 4 2) ⊑
    zext 4 (icmp IntPredicate.ugt e (LLVM.xor e_1 (const? 2 (-1)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bool_add_ashr_thm (e e_1 : IntW 1) :
  ashr (add (zext 2 e_1) (zext 2 e)) (const? 2 1) ⊑
    ashr (add (zext 2 e_1) (zext 2 e) { «nsw» := false, «nuw» := true }) (const? 2 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


