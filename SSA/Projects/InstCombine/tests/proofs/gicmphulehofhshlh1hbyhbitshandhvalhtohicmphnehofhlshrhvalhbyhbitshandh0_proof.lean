
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gicmphulehofhshlh1hbyhbitshandhvalhtohicmphnehofhlshrhvalhbyhbitshandh0_proof
theorem p0_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ule (shl (const? 8 1) e_1) e ⊑ icmp IntPredicate.ne (lshr e e_1) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem both_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ule (shl (const? 8 1) e_1) (shl (const? 8 1) e) ⊑
    icmp IntPredicate.ne (lshr (shl (const? 8 1) e { «nsw» := false, «nuw» := true }) e_1) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n2_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ult (shl (const? 8 1) e_1) e ⊑
    icmp IntPredicate.ult (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true }) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
