
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gudiv_select_to_select_shift_proof
theorem test_proof.test_thm_1 (e : IntW 64) (e_1 : IntW 1) :
  add (LLVM.udiv e (select e_1 (const? 64 16) (const? 64 8))) (LLVM.udiv e (select e_1 (const? 64 8) (const? 64 0))) ⊑
    add (lshr e (const? 64 4)) (lshr e (const? 64 3)) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
