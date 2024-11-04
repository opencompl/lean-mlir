
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gapinthshlhtrunc_proof
theorem test0_thm (e e_1 : IntW 39) :
  trunc 1 (lshr e_1 e) ⊑
    icmp IntPredicate.ne (LLVM.and (shl (const? 39 1) e { «nsw» := false, «nuw» := true }) e_1) (const? 39 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test1_thm (e e_1 : IntW 799) :
  trunc 1 (lshr e_1 e) ⊑
    icmp IntPredicate.ne (LLVM.and (shl (const? 799 1) e { «nsw» := false, «nuw» := true }) e_1) (const? 799 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


