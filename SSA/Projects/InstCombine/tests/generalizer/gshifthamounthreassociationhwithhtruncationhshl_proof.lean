
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gshifthamounthreassociationhwithhtruncationhshl_proof
theorem t0_proof.t0_thm_1 (e : IntW 32) (e_1 : IntW 16) :
  shl (trunc 16 (shl e (zext 32 (sub (const? 16 32) e_1)))) (add e_1 (const? 16 (-24))) ⊑
    shl (trunc 16 e) (const? 16 8) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n11_proof.n11_thm_1 (e : IntW 32) (e_1 : IntW 16) :
  shl (trunc 16 (shl e (zext 32 (sub (const? 16 30) e_1)))) (add e_1 (const? 16 (-31))) ⊑
    shl (trunc 16 (shl e (zext 32 (sub (const? 16 30) e_1) { «nneg» := true }))) (add e_1 (const? 16 (-31))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
