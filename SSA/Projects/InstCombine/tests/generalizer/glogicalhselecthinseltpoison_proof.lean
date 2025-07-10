
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section glogicalhselecthinseltpoison_proof
theorem foo_proof.foo_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (LLVM.and e_2 (sext 32 (icmp IntPred.slt e e_1)))
      (LLVM.and e_3 (LLVM.xor (sext 32 (icmp IntPred.slt e e_1)) (const? 32 (-1)))) ⊑
    select (icmp IntPred.slt e e_1) e_2 e_3 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem bar_proof.bar_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (LLVM.and e_3 (LLVM.xor (sext 32 (icmp IntPred.slt e e_1)) (const? 32 (-1))))
      (LLVM.and e_2 (sext 32 (icmp IntPred.slt e e_1))) ⊑
    select (icmp IntPred.slt e e_1) e_2 e_3 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem goo_proof.goo_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (LLVM.and (select (icmp IntPred.slt e e_1) (const? 32 (-1)) (const? 32 0)) e_2)
      (LLVM.and (LLVM.xor (select (icmp IntPred.slt e e_1) (const? 32 (-1)) (const? 32 0)) (const? 32 (-1))) e_3) ⊑
    select (icmp IntPred.slt e e_1) e_2 e_3 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem poo_proof.poo_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (LLVM.and (select (icmp IntPred.slt e e_1) (const? 32 (-1)) (const? 32 0)) e_2)
      (LLVM.and (select (icmp IntPred.slt e e_1) (const? 32 0) (const? 32 (-1))) e_3) ⊑
    select (icmp IntPred.slt e e_1) e_2 e_3 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_inverted_icmp_preds_proof.fold_inverted_icmp_preds_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (select (icmp IntPred.slt e e_1) e_2 (const? 32 0)) (select (icmp IntPred.sge e e_1) e_3 (const? 32 0)) ⊑
    LLVM.or (select (icmp IntPred.slt e e_1) e_2 (const? 32 0))
      (select (icmp IntPred.slt e e_1) (const? 32 0) e_3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem fold_inverted_icmp_preds_reverse_proof.fold_inverted_icmp_preds_reverse_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (select (icmp IntPred.slt e e_1) (const? 32 0) e_2) (select (icmp IntPred.sge e e_1) (const? 32 0) e_3) ⊑
    LLVM.or (select (icmp IntPred.slt e e_1) (const? 32 0) e_2)
      (select (icmp IntPred.slt e e_1) e_3 (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem par_proof.par_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  LLVM.or (LLVM.and (select (icmp IntPred.slt e e_1) (const? 32 (-1)) (const? 32 0)) e_2)
      (LLVM.and (LLVM.xor (select (icmp IntPred.slt e e_1) (const? 32 (-1)) (const? 32 0)) (const? 32 (-1))) e_3) ⊑
    select (icmp IntPred.slt e e_1) e_2 e_3 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem bools_proof.bools_thm_1 (e e_1 e_2 : IntW 1) :
  LLVM.or (LLVM.and (LLVM.xor e_2 (const? 1 1)) e) (LLVM.and e_2 e_1) ⊑ select e_2 e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem bools_logical_proof.bools_logical_thm_1 (e e_1 e_2 : IntW 1) :
  select (select (LLVM.xor e_2 (const? 1 1)) e (const? 1 0)) (const? 1 1) (select e_2 e_1 (const? 1 0)) ⊑
    select e_2 e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem bools_multi_uses1_proof.bools_multi_uses1_thm_1 (e e_1 e_2 : IntW 1) :
  LLVM.xor (LLVM.or (LLVM.and (LLVM.xor e_2 (const? 1 1)) e) (LLVM.and e_2 e_1))
      (LLVM.and (LLVM.xor e_2 (const? 1 1)) e) ⊑
    LLVM.xor (select e_2 e_1 e) (LLVM.and e (LLVM.xor e_2 (const? 1 1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem bools_multi_uses1_logical_proof.bools_multi_uses1_logical_thm_1 (e e_1 e_2 : IntW 1) :
  LLVM.xor (select (select (LLVM.xor e_2 (const? 1 1)) e (const? 1 0)) (const? 1 1) (select e_2 e_1 (const? 1 0)))
      (select (LLVM.xor e_2 (const? 1 1)) e (const? 1 0)) ⊑
    LLVM.xor (select e_2 e_1 e) (select (LLVM.xor e_2 (const? 1 1)) e (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem bools_multi_uses2_proof.bools_multi_uses2_thm_1 (e e_1 e_2 : IntW 1) :
  LLVM.and (LLVM.or (LLVM.and (LLVM.xor e_2 (const? 1 1)) e) (LLVM.and e_2 e_1))
      (add (LLVM.and (LLVM.xor e_2 (const? 1 1)) e) (LLVM.and e_2 e_1)) ⊑
    select e_2 e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem bools_multi_uses2_logical_proof.bools_multi_uses2_logical_thm_1 (e e_1 e_2 : IntW 1) :
  select (select (select (LLVM.xor e_2 (const? 1 1)) e (const? 1 0)) (const? 1 1) (select e_2 e_1 (const? 1 0)))
      (add (select (LLVM.xor e_2 (const? 1 1)) e (const? 1 0)) (select e_2 e_1 (const? 1 0))) (const? 1 0) ⊑
    select (select e_2 e_1 e)
      (LLVM.xor (select (LLVM.xor e_2 (const? 1 1)) e (const? 1 0)) (select e_2 e_1 (const? 1 0))) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem allSignBits_proof.allSignBits_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (LLVM.and e_1 (ashr e (const? 32 31))) (LLVM.and (LLVM.xor (ashr e (const? 32 31)) (const? 32 (-1))) e_2) ⊑
    LLVM.or (select (icmp IntPred.slt e (const? 32 0)) e_1 (const? 32 0))
      (select (icmp IntPred.slt e (const? 32 0)) (const? 32 0) e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
