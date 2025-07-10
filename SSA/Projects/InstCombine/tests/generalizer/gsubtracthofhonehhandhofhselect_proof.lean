
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsubtracthofhonehhandhofhselect_proof
theorem t0_sub_of_trueval_proof.t0_sub_of_trueval_thm_1 (e : IntW 1) (e_1 e_2 : IntW 8) :
  sub (select e e_1 e_2) e_1 ⊑ select e (const? 8 0) (sub e_2 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_sub_of_falseval_proof.t1_sub_of_falseval_thm_1 (e : IntW 1) (e_1 e_2 : IntW 8) :
  sub (select e e_1 e_2) e_2 ⊑ select e (sub e_1 e_2) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
