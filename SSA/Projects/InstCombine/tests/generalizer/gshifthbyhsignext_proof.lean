
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gshifthbyhsignext_proof
theorem t0_shl_proof.t0_shl_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  shl e (sext 32 e_1) ⊑ shl e (zext 32 e_1 { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_lshr_proof.t1_lshr_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  lshr e (sext 32 e_1) ⊑ lshr e (zext 32 e_1 { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t2_ashr_proof.t2_ashr_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  ashr e (sext 32 e_1) ⊑ ashr e (zext 32 e_1 { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
