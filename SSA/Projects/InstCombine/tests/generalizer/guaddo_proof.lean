
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section guaddo_proof
theorem uaddo_commute3_proof.uaddo_commute3_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ult (LLVM.xor e_1 (const? 32 (-1))) e) e_2 (add e e_1) ⊑
    select (icmp IntPred.ugt e (LLVM.xor e_1 (const? 32 (-1)))) e_2 (add e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem uaddo_commute4_proof.uaddo_commute4_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ult (LLVM.xor e_1 (const? 32 (-1))) e) e_2 (add e_1 e) ⊑
    select (icmp IntPred.ugt e (LLVM.xor e_1 (const? 32 (-1)))) e_2 (add e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem uaddo_commute7_proof.uaddo_commute7_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ult (LLVM.xor e_1 (const? 32 (-1))) e) (add e e_1) e_2 ⊑
    select (icmp IntPred.ugt e (LLVM.xor e_1 (const? 32 (-1)))) (add e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem uaddo_commute8_proof.uaddo_commute8_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ult (LLVM.xor e_1 (const? 32 (-1))) e) (add e_1 e) e_2 ⊑
    select (icmp IntPred.ugt e (LLVM.xor e_1 (const? 32 (-1)))) (add e_1 e) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem uaddo_wrong_pred2_proof.uaddo_wrong_pred2_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.uge e (LLVM.xor e_1 (const? 32 (-1)))) e_2 (add e e_1) ⊑
    select (icmp IntPred.ult e (LLVM.xor e_1 (const? 32 (-1)))) (add e e_1) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
