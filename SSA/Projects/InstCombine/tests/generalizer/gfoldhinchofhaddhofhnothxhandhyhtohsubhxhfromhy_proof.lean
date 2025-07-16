
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gfoldhinchofhaddhofhnothxhandhyhtohsubhxhfromhy_proof
theorem t0_proof.t0_thm_1 (e e_1 : IntW 32) :
  add (add (LLVM.xor e (const? 32 (-1))) e_1) (const? 32 1) ⊑ sub e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n12_proof.n12_thm_1 (e e_1 : IntW 32) :
  add (add (LLVM.xor e (const? 32 (-1))) e_1) (const? 32 2) ⊑
    add (add e_1 (LLVM.xor e (const? 32 (-1)))) (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
