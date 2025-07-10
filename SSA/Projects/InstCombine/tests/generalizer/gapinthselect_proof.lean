
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gapinthselect_proof
theorem zext_proof.zext_thm_1 (e : IntW 1) : select e (const? 41 1) (const? 41 0) ⊑ zext 41 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_proof.sext_thm_1 (e : IntW 1) : select e (const? 41 (-1)) (const? 41 0) ⊑ sext 41 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_zext_proof.not_zext_thm_1 (e : IntW 1) :
  select e (const? 999 0) (const? 999 1) ⊑ zext 999 (LLVM.xor e (const? 1 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem not_sext_proof.not_sext_thm_1 (e : IntW 1) :
  select e (const? 999 0) (const? 999 (-1)) ⊑ sext 999 (LLVM.xor e (const? 1 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_proof.test3_thm_1 (e : IntW 41) :
  select (icmp IntPred.slt e (const? 41 0)) (const? 41 (-1)) (const? 41 0) ⊑ ashr e (const? 41 40) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test4_proof.test4_thm_1 (e : IntW 1023) :
  select (icmp IntPred.slt e (const? 1023 0)) (const? 1023 (-1)) (const? 1023 0) ⊑ ashr e (const? 1023 1022) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
