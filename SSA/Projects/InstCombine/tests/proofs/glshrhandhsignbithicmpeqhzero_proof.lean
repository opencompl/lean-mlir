
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section glshrhandhsignbithicmpeqhzero_proof
theorem scalar_i8_lshr_and_signbit_eq_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (lshr e_1 e) (const? (-128))) (const? 0) ⊑
    icmp IntPredicate.sgt (lshr e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i16_lshr_and_signbit_eq_thm (e e_1 : IntW 16) :
  icmp IntPredicate.eq (LLVM.and (lshr e_1 e) (const? (-32768))) (const? 0) ⊑
    icmp IntPredicate.sgt (lshr e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i32_lshr_and_signbit_eq_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (lshr e_1 e) (const? (-2147483648))) (const? 0) ⊑
    icmp IntPredicate.sgt (lshr e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i64_lshr_and_signbit_eq_thm (e e_1 : IntW 64) :
  icmp IntPredicate.eq (LLVM.and (lshr e_1 e) (const? (-9223372036854775808))) (const? 0) ⊑
    icmp IntPredicate.sgt (lshr e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i32_lshr_and_signbit_ne_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (lshr e_1 e) (const? (-2147483648))) (const? 0) ⊑
    icmp IntPredicate.slt (lshr e_1 e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i32_lshr_and_signbit_eq_X_is_constant1_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (lshr (const? 12345) e) (const? (-2147483648))) (const? 0) ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i32_lshr_and_negC_eq_X_is_constant2_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (lshr (const? (-2147483648)) e) (const? (-2147483648))) (const? 0) ⊑
    icmp IntPredicate.ne e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i32_lshr_and_negC_slt_thm (e e_1 : IntW 32) :
  icmp IntPredicate.slt (LLVM.and (lshr e_1 e) (const? (-2147483648))) (const? 0) ⊑
    icmp IntPredicate.slt (lshr e_1 e) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar_i32_lshr_and_negC_eq_nonzero_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (lshr e_1 e) (const? (-2147483648))) (const? 1) ⊑ const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


