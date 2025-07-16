
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section g2007h03h13hCompareMerge_proof
theorem test_proof.test_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.slt e e_1) (icmp IntPred.eq e e_1) ⊑ icmp IntPred.sle e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_logical_proof.test_logical_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.slt e e_1) (const? 1 1) (icmp IntPred.eq e e_1) ⊑ icmp IntPred.sle e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
