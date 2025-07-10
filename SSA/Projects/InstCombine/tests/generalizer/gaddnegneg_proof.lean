
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gaddnegneg_proof
theorem l_proof.l_thm_1 (e_1 e_2 e_3 : IntW 32) :
  add (add (sub (const? 32 0) e_2) (sub (const? 32 0) e_1)) e_3 ⊑ sub e_3 (add e_2 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
