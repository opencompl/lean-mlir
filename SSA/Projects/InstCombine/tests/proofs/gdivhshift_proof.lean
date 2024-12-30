
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000

section gdivhshift_proof
theorem t1_thm (e : IntW 32) (e_1 : IntW 16) :
  LLVM.sdiv (zext 32 e_1) (shl (const? 32 2) e) ⊑ lshr (zext 32 e_1) (add e (const? 32 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t2_thm (e : IntW 32) (e_1 : IntW 64) :
  LLVM.udiv e_1 (zext 64 (shl (const? 32 1) e)) ⊑ lshr e_1 (zext 64 e { «nneg» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t3_thm (e : IntW 32) (e_1 : IntW 64) :
  LLVM.udiv e_1 (zext 64 (shl (const? 32 4) e)) ⊑ lshr e_1 (zext 64 (add e (const? 32 2)) { «nneg» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t5_thm (e e_1 : IntW 1) (e_2 : IntW 32) :
  LLVM.udiv e_2 (select e_1 (select e (const? 32 32) (const? 32 64)) (shl (const? 32 1) e_2)) ⊑
    lshr e_2 (select e_1 (select e (const? 32 5) (const? 32 6)) e_2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t7_thm (e : IntW 32) :
  LLVM.sdiv (shl e (const? 32 2) { «nsw» := true, «nuw» := false }) e ⊑ const? 32 4 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t10_thm (e e_1 : IntW 32) :
  LLVM.sdiv (shl e_1 e { «nsw» := true, «nuw» := false }) e_1 ⊑
    shl (const? 32 1) e { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t12_thm (e : IntW 32) :
  LLVM.udiv (shl e (const? 32 2) { «nsw» := false, «nuw» := true }) e ⊑ const? 32 4 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t15_thm (e e_1 : IntW 32) :
  LLVM.udiv (shl e_1 e { «nsw» := false, «nuw» := true }) e_1 ⊑
    shl (const? 32 1) e { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv_mul_shl_nsw_thm (e e_1 e_2 : IntW 5) :
  LLVM.sdiv (mul e_2 e_1 { «nsw» := true, «nuw» := false }) (shl e_2 e { «nsw» := true, «nuw» := false }) ⊑
    LLVM.sdiv e_1 (shl (const? 5 1) e { «nsw» := false, «nuw» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv_mul_shl_nsw_exact_commute1_thm (e e_1 e_2 : IntW 5) :
  LLVM.sdiv (mul e_2 e_1 { «nsw» := true, «nuw» := false }) (shl e_1 e { «nsw» := true, «nuw» := false })
      { «exact» := true } ⊑
    LLVM.sdiv e_2 (shl (const? 5 1) e { «nsw» := false, «nuw» := true }) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_mul_shl_nuw_thm (e e_1 e_2 : IntW 5) :
  LLVM.udiv (mul e_2 e_1 { «nsw» := false, «nuw» := true }) (shl e_2 e { «nsw» := false, «nuw» := true }) ⊑
    lshr e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_mul_shl_nuw_exact_commute1_thm (e e_1 e_2 : IntW 5) :
  LLVM.udiv (mul e_2 e_1 { «nsw» := false, «nuw» := true }) (shl e_1 e { «nsw» := false, «nuw» := true })
      { «exact» := true } ⊑
    lshr e_2 e { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_shl_mul_nuw_thm (e e_1 e_2 : IntW 5) :
  LLVM.udiv (shl e_2 e_1 { «nsw» := false, «nuw» := true }) (mul e_2 e { «nsw» := false, «nuw» := true }) ⊑
    LLVM.udiv (shl (const? 5 1) e_1 { «nsw» := false, «nuw» := true }) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_shl_mul_nuw_swap_thm (e e_1 e_2 : IntW 5) :
  LLVM.udiv (shl e_2 e_1 { «nsw» := false, «nuw» := true }) (mul e e_2 { «nsw» := false, «nuw» := true }) ⊑
    LLVM.udiv (shl (const? 5 1) e_1 { «nsw» := false, «nuw» := true }) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_shl_mul_nuw_exact_thm (e e_1 e_2 : IntW 5) :
  LLVM.udiv (shl e_2 e_1 { «nsw» := false, «nuw» := true }) (mul e_2 e { «nsw» := false, «nuw» := true })
      { «exact» := true } ⊑
    LLVM.udiv (shl (const? 5 1) e_1 { «nsw» := false, «nuw» := true }) e { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_lshr_mul_nuw_thm (e e_1 e_2 : IntW 8) :
  LLVM.udiv (lshr (mul e_2 e_1 { «nsw» := false, «nuw» := true }) e) e_2 ⊑ lshr e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv_shl_shl_nsw2_nuw_thm (e e_1 e_2 : IntW 8) :
  LLVM.sdiv (shl e_2 e_1 { «nsw» := true, «nuw» := false }) (shl e e_1 { «nsw» := true, «nuw» := true }) ⊑
    LLVM.sdiv e_2 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_shl_shl_nuw_nsw2_thm (e e_1 e_2 : IntW 8) :
  LLVM.udiv (shl e_2 e_1 { «nsw» := true, «nuw» := true }) (shl e e_1 { «nsw» := true, «nuw» := false }) ⊑
    LLVM.udiv e_2 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv_shl_pair_const_thm (e : IntW 32) :
  LLVM.sdiv (shl e (const? 32 2) { «nsw» := true, «nuw» := false })
      (shl e (const? 32 1) { «nsw» := true, «nuw» := false }) ⊑
    const? 32 2 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_shl_pair_const_thm (e : IntW 32) :
  LLVM.udiv (shl e (const? 32 2) { «nsw» := false, «nuw» := true })
      (shl e (const? 32 1) { «nsw» := false, «nuw» := true }) ⊑
    const? 32 2 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv_shl_pair1_thm (e e_1 e_2 : IntW 32) :
  LLVM.sdiv (shl e_2 e_1 { «nsw» := true, «nuw» := false }) (shl e_2 e { «nsw» := true, «nuw» := true }) ⊑
    lshr (shl (const? 32 1) e_1 { «nsw» := true, «nuw» := true }) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv_shl_pair2_thm (e e_1 e_2 : IntW 32) :
  LLVM.sdiv (shl e_2 e_1 { «nsw» := true, «nuw» := true }) (shl e_2 e { «nsw» := true, «nuw» := false }) ⊑
    lshr (shl (const? 32 1) e_1 { «nsw» := true, «nuw» := true }) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv_shl_pair3_thm (e e_1 e_2 : IntW 32) :
  LLVM.sdiv (shl e_2 e_1 { «nsw» := true, «nuw» := false }) (shl e_2 e { «nsw» := true, «nuw» := false }) ⊑
    lshr (shl (const? 32 1) e_1 { «nsw» := false, «nuw» := true }) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_shl_pair1_thm (e e_1 e_2 : IntW 32) :
  LLVM.udiv (shl e_2 e_1 { «nsw» := false, «nuw» := true }) (shl e_2 e { «nsw» := false, «nuw» := true }) ⊑
    lshr (shl (const? 32 1) e_1 { «nsw» := false, «nuw» := true }) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_shl_pair2_thm (e e_1 e_2 : IntW 32) :
  LLVM.udiv (shl e_2 e_1 { «nsw» := true, «nuw» := true }) (shl e_2 e { «nsw» := false, «nuw» := true }) ⊑
    lshr (shl (const? 32 1) e_1 { «nsw» := true, «nuw» := true }) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_shl_pair3_thm (e e_1 e_2 : IntW 32) :
  LLVM.udiv (shl e_2 e_1 { «nsw» := false, «nuw» := true }) (shl e_2 e { «nsw» := true, «nuw» := true }) ⊑
    lshr (shl (const? 32 1) e_1 { «nsw» := false, «nuw» := true }) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


