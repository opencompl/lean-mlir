
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gconditionalhnegation_proof
theorem t0_proof.t0_thm_1 (e : IntW 8) (e_1 : IntW 1) :
  LLVM.xor (add (sext 8 e_1) e) (sext 8 e_1) ⊑ select e_1 (sub (const? 8 0) e) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_proof.t1_thm_1 (e : IntW 8) (e_1 : IntW 1) :
  LLVM.xor (add (sext 8 e_1) e) (sext 8 e_1) ⊑ select e_1 (sub (const? 8 0) e) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t2_proof.t2_thm_1 (e : IntW 8) (e_1 e_2 : IntW 1) :
  LLVM.xor (add (sext 8 e_1) e) (sext 8 e_2) ⊑ LLVM.xor (add e (sext 8 e_1)) (sext 8 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t3_proof.t3_thm_1 (e : IntW 8) (e_1 : IntW 2) :
  LLVM.xor (add (sext 8 e_1) e) (sext 8 e_1) ⊑ LLVM.xor (add e (sext 8 e_1)) (sext 8 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
