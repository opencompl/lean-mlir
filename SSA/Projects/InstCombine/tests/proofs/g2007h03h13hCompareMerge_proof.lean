
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section g2007h03h13hCompareMerge_proof
theorem test_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.slt e_1 e) (icmp IntPred.eq e_1 e) ⊑ icmp IntPred.sle e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test_logical_thm (e e_1 : IntW 32) :
  select (icmp IntPred.slt e_1 e) (const? 1 1) (icmp IntPred.eq e_1 e) ⊑ icmp IntPred.sle e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
