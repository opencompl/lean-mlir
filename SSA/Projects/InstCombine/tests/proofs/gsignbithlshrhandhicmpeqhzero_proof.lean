
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsignbithlshrhandhicmpeqhzero_proof
theorem scalar_i32_signbit_lshr_and_eq_X_is_constant2_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (lshr (const? 32 (-2147483648)) e) (const? 32 1)) (const? 32 0) ⊑
    icmp IntPredicate.ne e (const? 32 31) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


