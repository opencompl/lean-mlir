
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gtrunchbinophext_proof
theorem narrow_sext_and_thm (e : IntW 32) (e_1 : IntW 16) :
  trunc 16 (LLVM.and (sext 32 e_1) e) ⊑ LLVM.and e_1 (trunc 16 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem narrow_zext_and_thm (e : IntW 32) (e_1 : IntW 16) :
  trunc 16 (LLVM.and (zext 32 e_1) e) ⊑ LLVM.and e_1 (trunc 16 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem narrow_sext_or_thm (e : IntW 32) (e_1 : IntW 16) :
  trunc 16 (LLVM.or (sext 32 e_1) e) ⊑ LLVM.or e_1 (trunc 16 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem narrow_zext_or_thm (e : IntW 32) (e_1 : IntW 16) :
  trunc 16 (LLVM.or (zext 32 e_1) e) ⊑ LLVM.or e_1 (trunc 16 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem narrow_sext_xor_thm (e : IntW 32) (e_1 : IntW 16) :
  trunc 16 (LLVM.xor (sext 32 e_1) e) ⊑ LLVM.xor e_1 (trunc 16 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem narrow_zext_xor_thm (e : IntW 32) (e_1 : IntW 16) :
  trunc 16 (LLVM.xor (zext 32 e_1) e) ⊑ LLVM.xor e_1 (trunc 16 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem narrow_sext_add_thm (e : IntW 32) (e_1 : IntW 16) : trunc 16 (add (sext 32 e_1) e) ⊑ add e_1 (trunc 16 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem narrow_zext_add_thm (e : IntW 32) (e_1 : IntW 16) : trunc 16 (add (zext 32 e_1) e) ⊑ add e_1 (trunc 16 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem narrow_sext_sub_thm (e : IntW 32) (e_1 : IntW 16) : trunc 16 (sub (sext 32 e_1) e) ⊑ sub e_1 (trunc 16 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem narrow_zext_sub_thm (e : IntW 32) (e_1 : IntW 16) : trunc 16 (sub (zext 32 e_1) e) ⊑ sub e_1 (trunc 16 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem narrow_sext_mul_thm (e : IntW 32) (e_1 : IntW 16) : trunc 16 (mul (sext 32 e_1) e) ⊑ mul e_1 (trunc 16 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem narrow_zext_mul_thm (e : IntW 32) (e_1 : IntW 16) : trunc 16 (mul (zext 32 e_1) e) ⊑ mul e_1 (trunc 16 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem narrow_zext_ashr_keep_trunc_thm (e e_1 : IntW 8) :
  trunc 8 (ashr (add (sext 32 e_1) (sext 32 e) { «nsw» := true, «nuw» := false }) (const? 32 1)) ⊑
    trunc 8 (lshr (add (sext 16 e_1) (sext 16 e) { «nsw» := true, «nuw» := false }) (const? 16 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem narrow_zext_ashr_keep_trunc2_thm (e e_1 : IntW 9) :
  trunc 8 (ashr (add (sext 64 e_1) (sext 64 e) { «nsw» := true, «nuw» := false }) (const? 64 1)) ⊑
    trunc 8 (lshr (add (zext 16 e_1) (zext 16 e) { «nsw» := true, «nuw» := true }) (const? 16 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem narrow_zext_ashr_keep_trunc3_thm (e e_1 : IntW 8) :
  trunc 7 (ashr (add (sext 64 e_1) (sext 64 e) { «nsw» := true, «nuw» := false }) (const? 64 1)) ⊑
    trunc 7 (lshr (add (zext 14 e_1) (zext 14 e) { «nsw» := true, «nuw» := true }) (const? 14 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem dont_narrow_zext_ashr_keep_trunc_thm (e e_1 : IntW 8) :
  trunc 8 (ashr (add (sext 16 e_1) (sext 16 e) { «nsw» := true, «nuw» := false }) (const? 16 1)) ⊑
    trunc 8 (lshr (add (sext 16 e_1) (sext 16 e) { «nsw» := true, «nuw» := false }) (const? 16 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
