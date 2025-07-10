
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gbinophselect_proof
theorem and_sel_op0_proof.and_sel_op0_thm_1 (e : IntW 1) :
  LLVM.and (select e (const? 32 25) (const? 32 0)) (const? 32 1) ⊑ zext 32 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem mul_sel_op0_proof.mul_sel_op0_thm_1 (e : IntW 1) (e_1 : IntW 32) :
  mul (select e (const? 32 0) (LLVM.udiv (const? 32 42) e_1 { «exact» := true })) e_1 ⊑
    select e (const? 32 0) (const? 32 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_sel_op1_proof.sub_sel_op1_thm_1 (e : IntW 1) :
  sub (const? 32 42) (select e (const? 32 42) (const? 32 41)) { «nsw» := true } ⊑
    zext 32 (LLVM.xor e (const? 1 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_sel_op1_proof.ashr_sel_op1_thm_1 (e : IntW 1) :
  ashr (const? 32 (-2)) (select e (const? 32 2) (const? 32 0)) ⊑ select e (const? 32 (-1)) (const? 32 (-2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
