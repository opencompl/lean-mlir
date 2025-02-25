
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gexact_proof
theorem sdiv2_thm (e : IntW 32) :
  LLVM.sdiv e (const? 32 8) { «exact» := true } ⊑ ashr e (const? 32 3) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv4_thm (e : IntW 32) : mul (LLVM.sdiv e (const? 32 3) { «exact» := true }) (const? 32 3) ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv6_thm (e : IntW 32) :
  mul (LLVM.sdiv e (const? 32 3) { «exact» := true }) (const? 32 (-3)) ⊑ sub (const? 32 0) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv1_thm (e e_1 : IntW 32) : mul (LLVM.udiv e_1 e { «exact» := true }) e ⊑ e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv2_thm (e e_1 : IntW 32) :
  LLVM.udiv e_1 (shl (const? 32 1) e) { «exact» := true } ⊑ lshr e_1 e { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr1_thm (e : IntW 64) :
  ashr (shl e (const? 64 8)) (const? 64 2) ⊑ ashr (shl e (const? 64 8)) (const? 64 2) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_icmp1_thm (e : IntW 64) :
  icmp IntPredicate.eq (ashr e (const? 64 2) { «exact» := true }) (const? 64 0) ⊑
    icmp IntPredicate.eq e (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_icmp2_thm (e : IntW 64) :
  icmp IntPredicate.slt (ashr e (const? 64 2) { «exact» := true }) (const? 64 4) ⊑
    icmp IntPredicate.slt e (const? 64 16) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem pr9998_thm (e : IntW 32) :
  icmp IntPredicate.ugt (sext 64 (ashr (shl e (const? 32 31)) (const? 32 31) { «exact» := true }))
      (const? 64 7297771788697658747) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 32 1)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_icmp1_thm (e : IntW 64) :
  icmp IntPredicate.ne (LLVM.udiv e (const? 64 5) { «exact» := true }) (const? 64 0) ⊑
    icmp IntPredicate.ne e (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem udiv_icmp2_thm (e : IntW 64) :
  icmp IntPredicate.eq (LLVM.udiv e (const? 64 5) { «exact» := true }) (const? 64 0) ⊑
    icmp IntPredicate.eq e (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv_icmp1_thm (e : IntW 64) :
  icmp IntPredicate.eq (LLVM.sdiv e (const? 64 5) { «exact» := true }) (const? 64 0) ⊑
    icmp IntPredicate.eq e (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv_icmp2_thm (e : IntW 64) :
  icmp IntPredicate.eq (LLVM.sdiv e (const? 64 5) { «exact» := true }) (const? 64 1) ⊑
    icmp IntPredicate.eq e (const? 64 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv_icmp3_thm (e : IntW 64) :
  icmp IntPredicate.eq (LLVM.sdiv e (const? 64 5) { «exact» := true }) (const? 64 (-1)) ⊑
    icmp IntPredicate.eq e (const? 64 (-5)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv_icmp4_thm (e : IntW 64) :
  icmp IntPredicate.eq (LLVM.sdiv e (const? 64 (-5)) { «exact» := true }) (const? 64 0) ⊑
    icmp IntPredicate.eq e (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv_icmp5_thm (e : IntW 64) :
  icmp IntPredicate.eq (LLVM.sdiv e (const? 64 (-5)) { «exact» := true }) (const? 64 1) ⊑
    icmp IntPredicate.eq e (const? 64 (-5)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sdiv_icmp6_thm (e : IntW 64) :
  icmp IntPredicate.eq (LLVM.sdiv e (const? 64 (-5)) { «exact» := true }) (const? 64 (-1)) ⊑
    icmp IntPredicate.eq e (const? 64 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_of_udiv_thm (e : IntW 8) :
  mul (LLVM.udiv e (const? 8 12) { «exact» := true }) (const? 8 6) ⊑ lshr e (const? 8 1) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_of_sdiv_thm (e : IntW 8) :
  mul (LLVM.sdiv e (const? 8 12) { «exact» := true }) (const? 8 (-6)) ⊑
    sub (const? 8 0) (ashr e (const? 8 1) { «exact» := true }) { «nsw» := true, «nuw» := false } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_of_udiv_fail_bad_remainder_thm (e : IntW 8) :
  mul (LLVM.udiv e (const? 8 11) { «exact» := true }) (const? 8 6) ⊑
    mul (LLVM.udiv e (const? 8 11) { «exact» := true }) (const? 8 6) { «nsw» := false, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_of_sdiv_fail_ub_thm (e : IntW 8) :
  mul (LLVM.sdiv e (const? 8 6) { «exact» := true }) (const? 8 (-6)) ⊑ sub (const? 8 0) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
