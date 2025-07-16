
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gJavaCompare_proof
theorem le_proof.le_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.sle
      (select (icmp IntPred.slt e e_1) (const? 32 (-1)) (select (icmp IntPred.sgt e e_1) (const? 32 1) (const? 32 0)))
      (const? 32 0) ⊑
    icmp IntPred.sle e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
