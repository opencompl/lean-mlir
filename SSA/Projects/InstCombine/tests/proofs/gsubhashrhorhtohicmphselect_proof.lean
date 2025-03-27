
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gsubhashrhorhtohicmphselect_proof
theorem sub_ashr_or_i8_thm (e e_1 : IntW 8) :
  LLVM.or (ashr (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 8 7)) e ⊑
    select (icmp IntPredicate.slt e_1 e) (const? 8 (-1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_ashr_or_i16_thm (e e_1 : IntW 16) :
  LLVM.or (ashr (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 16 15)) e ⊑
    select (icmp IntPredicate.slt e_1 e) (const? 16 (-1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_ashr_or_i32_thm (e e_1 : IntW 32) :
  LLVM.or (ashr (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 32 31)) e ⊑
    select (icmp IntPredicate.slt e_1 e) (const? 32 (-1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_ashr_or_i64_thm (e e_1 : IntW 64) :
  LLVM.or (ashr (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 64 63)) e ⊑
    select (icmp IntPredicate.slt e_1 e) (const? 64 (-1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_or_ashr_i32_thm (e : IntW 32) :
  ashr (LLVM.or (sub (const? 32 0) e) e) (const? 32 31) ⊑ sext 32 (icmp IntPredicate.ne e (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_ashr_or_i32_nuw_nsw_thm (e e_1 : IntW 32) :
  LLVM.or (ashr (sub e_1 e { «nsw» := true, «nuw» := true }) (const? 32 31)) e ⊑
    select (icmp IntPredicate.slt e_1 e) (const? 32 (-1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_ashr_or_i32_commute_thm (e e_1 : IntW 32) :
  LLVM.or e_1 (ashr (sub e e_1 { «nsw» := true, «nuw» := false }) (const? 32 31)) ⊑
    select (icmp IntPredicate.slt e e_1) (const? 32 (-1)) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem neg_or_ashr_i32_commute_thm (e : IntW 32) :
  ashr (LLVM.or (LLVM.sdiv (const? 32 42) e) (sub (const? 32 0) (LLVM.sdiv (const? 32 42) e))) (const? 32 31) ⊑
    sext 32 (icmp IntPredicate.ne (LLVM.sdiv (const? 32 42) e) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
