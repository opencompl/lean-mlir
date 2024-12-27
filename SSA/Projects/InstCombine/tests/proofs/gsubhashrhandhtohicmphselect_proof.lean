
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gsubhashrhandhtohicmphselect_proof
theorem sub_ashr_and_i8_thm (e e_1 : IntW 8) :
  LLVM.and (ashr (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 8 7)) e ⊑
    select (icmp IntPredicate.slt e_1 e) e (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_ashr_and_i16_thm (e e_1 : IntW 16) :
  LLVM.and (ashr (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 16 15)) e ⊑
    select (icmp IntPredicate.slt e_1 e) e (const? 16 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_ashr_and_i32_thm (e e_1 : IntW 32) :
  LLVM.and (ashr (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 32 31)) e ⊑
    select (icmp IntPredicate.slt e_1 e) e (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_ashr_and_i64_thm (e e_1 : IntW 64) :
  LLVM.and (ashr (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 64 63)) e ⊑
    select (icmp IntPredicate.slt e_1 e) e (const? 64 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_ashr_and_i32_nuw_nsw_thm (e e_1 : IntW 32) :
  LLVM.and (ashr (sub e_1 e { «nsw» := true, «nuw» := true }) (const? 32 31)) e ⊑
    select (icmp IntPredicate.slt e_1 e) e (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_ashr_and_i32_commute_thm (e e_1 : IntW 32) :
  LLVM.and e_1 (ashr (sub e e_1 { «nsw» := true, «nuw» := false }) (const? 32 31)) ⊑
    select (icmp IntPredicate.slt e e_1) e_1 (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


