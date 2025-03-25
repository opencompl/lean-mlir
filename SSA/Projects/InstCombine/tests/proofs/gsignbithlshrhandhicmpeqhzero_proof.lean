
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gsignbithlshrhandhicmpeqhzero_proof
theorem scalar_i8_signbit_lshr_and_eq_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (lshr (const? 8 (-128)) e_1) e) (const? 8 0) ⊑
    icmp IntPredicate.eq (LLVM.and (lshr (const? 8 (-128)) e_1 { «exact» := true }) e) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i16_signbit_lshr_and_eq_thm (e e_1 : IntW 16) :
  icmp IntPredicate.eq (LLVM.and (lshr (const? 16 (-32768)) e_1) e) (const? 16 0) ⊑
    icmp IntPredicate.eq (LLVM.and (lshr (const? 16 (-32768)) e_1 { «exact» := true }) e) (const? 16 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i32_signbit_lshr_and_eq_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (lshr (const? 32 (-2147483648)) e_1) e) (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and (lshr (const? 32 (-2147483648)) e_1 { «exact» := true }) e) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i64_signbit_lshr_and_eq_thm (e e_1 : IntW 64) :
  icmp IntPredicate.eq (LLVM.and (lshr (const? 64 (-9223372036854775808)) e_1) e) (const? 64 0) ⊑
    icmp IntPredicate.eq (LLVM.and (lshr (const? 64 (-9223372036854775808)) e_1 { «exact» := true }) e)
      (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i32_signbit_lshr_and_ne_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (lshr (const? 32 (-2147483648)) e_1) e) (const? 32 0) ⊑
    icmp IntPredicate.ne (LLVM.and (lshr (const? 32 (-2147483648)) e_1 { «exact» := true }) e) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i32_signbit_lshr_and_eq_X_is_constant1_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (lshr (const? 32 (-2147483648)) e) (const? 32 12345)) (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and (lshr (const? 32 (-2147483648)) e { «exact» := true }) (const? 32 12345))
      (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i32_signbit_lshr_and_eq_X_is_constant2_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (lshr (const? 32 (-2147483648)) e) (const? 32 1)) (const? 32 0) ⊑
    icmp IntPredicate.ne e (const? 32 31) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i32_signbit_lshr_and_slt_thm (e e_1 : IntW 32) :
  icmp IntPredicate.slt (LLVM.and (lshr (const? 32 (-2147483648)) e_1) e) (const? 32 0) ⊑
    icmp IntPredicate.slt (LLVM.and (lshr (const? 32 (-2147483648)) e_1 { «exact» := true }) e) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i32_signbit_lshr_and_eq_nonzero_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (lshr (const? 32 (-2147483648)) e_1) e) (const? 32 1) ⊑
    icmp IntPredicate.eq (LLVM.and (lshr (const? 32 (-2147483648)) e_1 { «exact» := true }) e) (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
