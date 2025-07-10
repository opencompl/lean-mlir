
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gcanonicalizehconstanthlowhbithmaskhandhicmphsgehtohicmphsle_proof
theorem p0_proof.p0_thm_1 (e : IntW 8) :
  icmp IntPred.sge (LLVM.and e (const? 8 3)) e ⊑ icmp IntPred.slt e (const? 8 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
