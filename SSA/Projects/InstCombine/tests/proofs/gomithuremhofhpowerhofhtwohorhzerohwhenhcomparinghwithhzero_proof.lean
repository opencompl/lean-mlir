
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gomithuremhofhpowerhofhtwohorhzerohwhenhcomparinghwithhzero_proof
theorem p0_scalar_urem_by_const_thm (e : IntW 32) :
  icmp IntPredicate.eq (urem (LLVM.and e (const? 32 128)) (const? 32 6)) (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 128)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem p1_scalar_urem_by_nonconst_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (urem (LLVM.and e_1 (const? 32 128)) (LLVM.or e (const? 32 6))) (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and e_1 (const? 32 128)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem p2_scalar_shifted_urem_by_const_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (urem (shl (LLVM.and e_1 (const? 32 1)) e) (const? 32 3)) (const? 32 0) ⊑
    icmp IntPredicate.eq (urem (shl (LLVM.and e_1 (const? 32 1)) e { «nsw» := false, «nuw» := true }) (const? 32 3))
      (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
