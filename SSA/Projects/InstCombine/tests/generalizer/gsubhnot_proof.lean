
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsubhnot_proof
theorem sub_not_proof.sub_not_thm_1 (e e_1 : IntW 8) :
  LLVM.xor (sub e e_1) (const? 8 (-1)) ⊑ add e_1 (LLVM.xor e (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem dec_sub_proof.dec_sub_thm_1 (e e_1 : IntW 8) :
  add (sub e e_1) (const? 8 (-1)) ⊑ add e (LLVM.xor e_1 (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_inc_proof.sub_inc_thm_1 (e e_1 : IntW 8) :
  sub e_1 (add e (const? 8 1)) ⊑ add e_1 (LLVM.xor e (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_dec_proof.sub_dec_thm_1 (e e_1 : IntW 8) :
  sub (add e (const? 8 (-1))) e_1 ⊑ add e (LLVM.xor e_1 (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
