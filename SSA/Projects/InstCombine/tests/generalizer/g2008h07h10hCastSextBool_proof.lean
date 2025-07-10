
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section g2008h07h10hCastSextBool_proof
theorem PR2539_A_proof.PR2539_A_thm_1 (e : IntW 1) :
  icmp IntPred.slt (zext 32 e) (const? 32 1) ⊑ LLVM.xor e (const? 1 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR2539_B_proof.PR2539_B_thm_1 (e : IntW 1) : icmp IntPred.slt e (const? 1 1) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
