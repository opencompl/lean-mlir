
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsignbithshlhandhicmpeqhzero_proof
theorem scalar_i32_signbit_shl_and_eq_X_is_constant1_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl (const? (-2147483648)) e) (const? 12345)) (const? 0) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i32_signbit_shl_and_eq_X_is_constant2_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl (const? (-2147483648)) e) (const? 1)) (const? 0) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i32_signbit_shl_and_slt_thm (e e_1 : IntW 32) :
  icmp IntPredicate.slt (LLVM.and (shl (const? (-2147483648)) e_1) e) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and (shl (const? (-2147483648)) e_1) e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i32_signbit_shl_and_eq_nonzero_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl (const? (-2147483648)) e_1) e) (const? 1) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


