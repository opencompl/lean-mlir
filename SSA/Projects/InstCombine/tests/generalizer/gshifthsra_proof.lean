
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gshifthsra_proof
theorem test1_proof.test1_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  LLVM.and (ashr e (zext 32 e_1)) (const? 32 1) ⊑
    LLVM.and (lshr e (zext 32 e_1 { «nneg» := true })) (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_proof.test2_thm_1 (e : IntW 8) :
  ashr (add (zext 32 e) (const? 32 7)) (const? 32 3) ⊑
    lshr (add (zext 32 e) (const? 32 7) { «nsw» := true, «nuw» := true }) (const? 32 3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ashr_proof.ashr_ashr_thm_1 (e : IntW 32) :
  ashr (ashr e (const? 32 5)) (const? 32 7) ⊑ ashr e (const? 32 12) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_overshift_proof.ashr_overshift_thm_1 (e : IntW 32) :
  ashr (ashr e (const? 32 15)) (const? 32 17) ⊑ ashr e (const? 32 31) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem hoist_ashr_ahead_of_sext_1_proof.hoist_ashr_ahead_of_sext_1_thm_1 (e : IntW 8) :
  ashr (sext 32 e) (const? 32 3) ⊑ sext 32 (ashr e (const? 8 3)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem hoist_ashr_ahead_of_sext_2_proof.hoist_ashr_ahead_of_sext_2_thm_1 (e : IntW 8) :
  ashr (sext 32 e) (const? 32 8) ⊑ sext 32 (ashr e (const? 8 7)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
