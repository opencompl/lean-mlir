
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gshifthamounthreassociationhwithhtruncationhlshr_proof
theorem t0_proof.t0_thm_1 (e : IntW 32) (e_1 : IntW 16) :
  lshr (trunc 16 (lshr e (zext 32 (sub (const? 16 32) e_1)))) (add e_1 (const? 16 (-1))) ⊑
    trunc 16 (lshr e (const? 32 31)) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t9_lshr_proof.t9_lshr_thm_1 (e : IntW 32) (e_1 : IntW 16) :
  lshr (trunc 16 (lshr e (zext 32 (sub (const? 16 32) e_1)))) (add e_1 (const? 16 (-2))) ⊑
    lshr (trunc 16 (lshr e (zext 32 (sub (const? 16 32) e_1) { «nneg» := true }))) (add e_1 (const? 16 (-2))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n10_ashr_lshr_proof.n10_ashr_lshr_thm_1 (e : IntW 32) (e_1 : IntW 16) :
  lshr (trunc 16 (ashr e (zext 32 (sub (const? 16 32) e_1)))) (add e_1 (const? 16 (-1))) ⊑
    lshr (trunc 16 (ashr e (zext 32 (sub (const? 16 32) e_1) { «nneg» := true }))) (add e_1 (const? 16 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
