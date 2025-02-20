
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gshifthlogic_proof
theorem shl_and_thm (e e_1 : IntW 8) :
  shl (LLVM.and (shl e_1 (const? 8 3)) e) (const? 8 2) ⊑ LLVM.and (shl e_1 (const? 8 5)) (shl e (const? 8 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_or_thm (e e_1 : IntW 16) :
  shl (LLVM.or (LLVM.srem e_1 (const? 16 42)) (shl e (const? 16 5))) (const? 16 7) ⊑
    LLVM.or (shl e (const? 16 12))
      (shl (LLVM.srem e_1 (const? 16 42)) (const? 16 7) { «nsw» := true, «nuw» := false }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_xor_thm (e e_1 : IntW 32) :
  shl (LLVM.xor (shl e_1 (const? 32 5)) e) (const? 32 7) ⊑
    LLVM.xor (shl e_1 (const? 32 12)) (shl e (const? 32 7)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_and_thm (e e_1 : IntW 64) :
  lshr (LLVM.and (LLVM.srem e_1 (const? 64 42)) (lshr e (const? 64 5))) (const? 64 7) ⊑
    LLVM.and (lshr e (const? 64 12)) (lshr (LLVM.srem e_1 (const? 64 42)) (const? 64 7)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_xor_thm (e e_1 : IntW 32) :
  ashr (LLVM.xor (LLVM.srem e_1 (const? 32 42)) (ashr e (const? 32 5))) (const? 32 7) ⊑
    LLVM.xor (ashr e (const? 32 12)) (ashr (LLVM.srem e_1 (const? 32 42)) (const? 32 7)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_mul_thm (e : IntW 64) :
  lshr (mul e (const? 64 52) { «nsw» := false, «nuw» := true }) (const? 64 2) ⊑
    mul e (const? 64 13) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_mul_nuw_nsw_thm (e : IntW 64) :
  lshr (mul e (const? 64 52) { «nsw» := true, «nuw» := true }) (const? 64 2) ⊑
    mul e (const? 64 13) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_mul_negative_nonuw_thm (e : IntW 64) :
  lshr (mul e (const? 64 52)) (const? 64 2) ⊑ lshr (mul e (const? 64 52)) (const? 64 2) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_mul_negative_nsw_thm (e : IntW 64) :
  lshr (mul e (const? 64 52) { «nsw» := true, «nuw» := false }) (const? 64 2) ⊑
    lshr (mul e (const? 64 52) { «nsw» := true, «nuw» := false }) (const? 64 2) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_add_thm (e e_1 : IntW 8) :
  shl (add (shl e_1 (const? 8 3)) e) (const? 8 2) ⊑ add (shl e_1 (const? 8 5)) (shl e (const? 8 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_sub_thm (e e_1 : IntW 8) :
  shl (sub (shl e_1 (const? 8 3)) e) (const? 8 2) ⊑ sub (shl e_1 (const? 8 5)) (shl e (const? 8 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl_sub_no_commute_thm (e e_1 : IntW 8) :
  shl (sub e_1 (shl e (const? 8 3))) (const? 8 2) ⊑ sub (shl e_1 (const? 8 2)) (shl e (const? 8 5)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
