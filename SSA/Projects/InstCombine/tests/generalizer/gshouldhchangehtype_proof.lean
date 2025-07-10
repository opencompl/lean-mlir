
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gshouldhchangehtype_proof
theorem test1_proof.test1_thm_1 (e e_1 : IntW 8) : trunc 8 (add (zext 64 e) (zext 64 e_1)) ⊑ add e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_proof.test2_thm_1 (e e_1 : IntW 16) : trunc 16 (add (zext 64 e) (zext 64 e_1)) ⊑ add e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_proof.test3_thm_1 (e e_1 : IntW 32) : trunc 32 (add (zext 64 e) (zext 64 e_1)) ⊑ add e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test4_proof.test4_thm_1 (e e_1 : IntW 9) :
  trunc 9 (add (zext 64 e) (zext 64 e_1)) ⊑
    trunc 9 (add (zext 64 e) (zext 64 e_1) { «nsw» := true, «nuw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
