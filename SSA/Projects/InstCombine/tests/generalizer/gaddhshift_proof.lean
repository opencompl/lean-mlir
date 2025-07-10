
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gaddhshift_proof
theorem flip_add_of_shift_neg_proof.flip_add_of_shift_neg_thm_1 (e e_1 e_2 : IntW 8) :
  add (shl (sub (const? 8 0) e) e_1 { «nsw» := true, «nuw» := true }) e_2 ⊑ sub e_2 (shl e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
