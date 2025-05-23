
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gsignbithshlhandhicmpeqhzero_proof
theorem scalar_i32_signbit_shl_and_eq_X_is_constant1_thm (e : IntW 32) :
  icmp IntPred.eq (LLVM.and (shl (const? 32 (-2147483648)) e) (const? 32 12345)) (const? 32 0) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i32_signbit_shl_and_eq_X_is_constant2_thm (e : IntW 32) :
  icmp IntPred.eq (LLVM.and (shl (const? 32 (-2147483648)) e) (const? 32 1)) (const? 32 0) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i32_signbit_shl_and_slt_thm (e e_1 : IntW 32) :
  icmp IntPred.slt (LLVM.and (shl (const? 32 (-2147483648)) e_1) e) (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and (shl (const? 32 (-2147483648)) e_1) e) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem scalar_i32_signbit_shl_and_eq_nonzero_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.and (shl (const? 32 (-2147483648)) e_1) e) (const? 32 1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
