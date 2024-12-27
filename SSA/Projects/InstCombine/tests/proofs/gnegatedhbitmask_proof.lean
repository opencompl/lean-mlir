
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gnegatedhbitmask_proof
theorem neg_mask1_lshr_thm (e : IntW 8) :
  sub (const? 8 0) (LLVM.and (lshr e (const? 8 3)) (const? 8 1)) ⊑ ashr (shl e (const? 8 4)) (const? 8 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_mask1_lshr_thm (e : IntW 8) :
  sub (const? 8 10) (LLVM.and (lshr e (const? 8 1)) (const? 8 1)) ⊑
    add (ashr (shl e (const? 8 6)) (const? 8 7)) (const? 8 10) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_mask1_trunc_lshr_thm (e : IntW 64) :
  sub (const? 8 10) (LLVM.and (trunc 8 (lshr e (const? 64 15))) (const? 8 1)) ⊑
    add (trunc 8 (ashr (shl e (const? 64 48)) (const? 64 63)) { «nsw» := true, «nuw» := false }) (const? 8 10)
      { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_sext_mask1_trunc_lshr_thm (e : IntW 64) :
  sub (const? 32 10) (sext 32 (LLVM.and (trunc 8 (lshr e (const? 64 15))) (const? 8 1))) ⊑
    zext 32
      (add (trunc 8 (ashr (shl e (const? 64 48)) (const? 64 63)) { «nsw» := true, «nuw» := false }) (const? 8 10)
        { «nsw» := true, «nuw» := false }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_zext_trunc_lshr_thm (e : IntW 64) :
  sub (const? 32 10) (zext 32 (trunc 1 (lshr e (const? 64 15)))) ⊑
    add (ashr (shl (trunc 32 e) (const? 32 16)) (const? 32 31)) (const? 32 10)
      { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_mask2_lshr_thm (e : IntW 8) :
  sub (const? 8 0) (LLVM.and (lshr e (const? 8 3)) (const? 8 2)) ⊑
    sub (const? 8 0) (LLVM.and (lshr e (const? 8 3)) (const? 8 2)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_signbit_thm (e : IntW 8) :
  sub (const? 32 0) (zext 32 (lshr e (const? 8 7))) ⊑ sext 32 (ashr e (const? 8 7)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_not_signbit1_thm (e : IntW 8) :
  sub (const? 32 1) (zext 32 (lshr e (const? 8 7))) ⊑ zext 32 (icmp IntPredicate.sgt e (const? 8 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_not_signbit2_thm (e : IntW 8) :
  sub (const? 32 0) (zext 32 (lshr e (const? 8 6))) ⊑
    sub (const? 32 0) (zext 32 (lshr e (const? 8 6)) { «nneg» := true }) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_not_signbit3_thm (e : IntW 8) :
  sub (const? 32 0) (zext 32 (ashr e (const? 8 7))) ⊑
    sub (const? 32 0) (zext 32 (ashr e (const? 8 7))) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_mask_thm (e : IntW 16) (e_1 : IntW 32) :
  LLVM.and (sub e_1 (sext 32 e) { «nsw» := true, «nuw» := false })
      (sub (const? 32 0) (zext 32 (lshr e (const? 16 15))) { «nsw» := true, «nuw» := false }) ⊑
    select (icmp IntPredicate.slt e (const? 16 0)) (sub e_1 (sext 32 e) { «nsw» := true, «nuw» := false })
      (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_mask_const_thm (e : IntW 16) :
  LLVM.and (sub (const? 32 1000) (sext 32 e) { «nsw» := true, «nuw» := false })
      (sub (const? 32 0) (zext 32 (lshr e (const? 16 15))) { «nsw» := true, «nuw» := false }) ⊑
    select (icmp IntPredicate.slt e (const? 16 0)) (sub (const? 32 1000) (sext 32 e) { «nsw» := true, «nuw» := false })
      (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


