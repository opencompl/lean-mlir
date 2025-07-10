
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gshifthamounthreassociationhwithhtruncationhashr_proof
theorem t0_proof.t0_thm_1 (e : IntW 32) (e_1 : IntW 16) :
  ashr (trunc 16 (ashr e (zext 32 (sub (const? 16 32) e_1)))) (add e_1 (const? 16 (-1))) ⊑
    trunc 16 (ashr e (const? 32 31)) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t9_ashr_proof.t9_ashr_thm_1 (e : IntW 32) (e_1 : IntW 16) :
  ashr (trunc 16 (ashr e (zext 32 (sub (const? 16 32) e_1)))) (add e_1 (const? 16 (-2))) ⊑
    ashr (trunc 16 (ashr e (zext 32 (sub (const? 16 32) e_1) { «nneg» := true }))) (add e_1 (const? 16 (-2))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n10_lshr_ashr_proof.n10_lshr_ashr_thm_1 (e : IntW 32) (e_1 : IntW 16) :
  ashr (trunc 16 (lshr e (zext 32 (sub (const? 16 32) e_1)))) (add e_1 (const? 16 (-1))) ⊑
    ashr (trunc 16 (lshr e (zext 32 (sub (const? 16 32) e_1) { «nneg» := true }))) (add e_1 (const? 16 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
