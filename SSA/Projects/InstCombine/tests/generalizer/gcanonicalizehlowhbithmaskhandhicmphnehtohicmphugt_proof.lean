
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gcanonicalizehlowhbithmaskhandhicmphnehtohicmphugt_proof
theorem p0_proof.p0_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ne (LLVM.and (lshr (const? 8 (-1)) e_1) e) e ⊑ icmp IntPred.ugt e (lshr (const? 8 (-1)) e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
