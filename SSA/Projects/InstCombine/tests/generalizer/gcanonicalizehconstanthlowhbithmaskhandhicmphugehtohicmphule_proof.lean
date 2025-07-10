
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gcanonicalizehconstanthlowhbithmaskhandhicmphugehtohicmphule_proof
theorem p0_proof.p0_thm_1 (e : IntW 8) :
  icmp IntPred.uge (LLVM.and e (const? 8 3)) e ⊑ icmp IntPred.ult e (const? 8 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem pv_proof.pv_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.uge (LLVM.and (lshr (const? 8 (-1)) e_1) e) e ⊑ icmp IntPred.ule e (lshr (const? 8 (-1)) e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n0_proof.n0_thm_1 (e : IntW 8) :
  icmp IntPred.uge (LLVM.and e (const? 8 4)) e ⊑ icmp IntPred.eq (LLVM.and e (const? 8 (-5))) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
