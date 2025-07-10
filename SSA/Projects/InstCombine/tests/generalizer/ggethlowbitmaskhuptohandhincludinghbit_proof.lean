
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section ggethlowbitmaskhuptohandhincludinghbit_proof
theorem t0_proof.t0_thm_1 (e : IntW 8) :
  LLVM.or (add (shl (const? 8 1) e) (const? 8 (-1))) (shl (const? 8 1) e) ⊑
    lshr (const? 8 (-1)) (sub (const? 8 7) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_proof.t1_thm_1 (e : IntW 16) :
  LLVM.or (add (shl (const? 16 1) e) (const? 16 (-1))) (shl (const? 16 1) e) ⊑
    lshr (const? 16 (-1)) (sub (const? 16 15) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t9_nocse_proof.t9_nocse_thm_1 (e : IntW 8) :
  LLVM.or (add (shl (const? 8 1) e) (const? 8 (-1))) (shl (const? 8 1) e) ⊑
    LLVM.or (shl (const? 8 1) e { «nuw» := true })
      (LLVM.xor (shl (const? 8 (-1)) e { «nsw» := true }) (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t17_nocse_mismatching_x_proof.t17_nocse_mismatching_x_thm_1 (e e_1 : IntW 8) :
  LLVM.or (add (shl (const? 8 1) e) (const? 8 (-1))) (shl (const? 8 1) e_1) ⊑
    LLVM.or (shl (const? 8 1) e_1 { «nuw» := true })
      (LLVM.xor (shl (const? 8 (-1)) e { «nsw» := true }) (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
