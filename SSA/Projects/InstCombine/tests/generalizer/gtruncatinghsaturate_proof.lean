
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gtruncatinghsaturate_proof
theorem testtrunclowhigh_proof.testtrunclowhigh_thm_1 (e : IntW 32) (e_1 e_2 : IntW 16) :
  select (icmp IntPred.ult (add e (const? 32 128)) (const? 32 256)) (trunc 16 e)
      (select (icmp IntPred.sgt e (const? 32 (-1))) e_2 e_1) ⊑
    select (icmp IntPred.ult (add e (const? 32 128)) (const? 32 256)) (trunc 16 e)
      (select (icmp IntPred.slt e (const? 32 0)) e_1 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem testi32i8_proof.testi32i8_thm_1 (e : IntW 32) :
  select (icmp IntPred.eq (ashr (trunc 8 e) (const? 8 7)) (trunc 8 (lshr e (const? 32 8)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 32 15))) (const? 8 127)) ⊑
    select (icmp IntPred.eq (ashr (trunc 8 e) (const? 8 7)) (trunc 8 (lshr e (const? 32 8)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (lshr e (const? 32 15))) (const? 8 127)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem differentconsts_proof.differentconsts_thm_1 (e : IntW 32) :
  select (icmp IntPred.ult (add e (const? 32 16)) (const? 32 144)) (trunc 16 e)
      (select (icmp IntPred.slt e (const? 32 128)) (const? 16 256) (const? 16 (-1))) ⊑
    select (icmp IntPred.sgt e (const? 32 127)) (const? 16 (-1))
      (select (icmp IntPred.slt e (const? 32 (-16))) (const? 16 256) (trunc 16 e)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem badimm1_proof.badimm1_thm_1 (e : IntW 16) :
  select (icmp IntPred.eq (ashr (trunc 8 e) (const? 8 7)) (trunc 8 (lshr e (const? 16 9)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 16 15))) (const? 8 127)) ⊑
    select
      (icmp IntPred.eq (ashr (trunc 8 e) (const? 8 7))
        (trunc 8 (lshr e (const? 16 9)) { «nsw» := true, «nuw» := true }))
      (trunc 8 e) (select (icmp IntPred.sgt e (const? 16 (-1))) (const? 8 127) (const? 8 (-128))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem badimm2_proof.badimm2_thm_1 (e : IntW 16) :
  select (icmp IntPred.eq (ashr (trunc 8 e) (const? 8 6)) (trunc 8 (lshr e (const? 16 8)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 16 15))) (const? 8 127)) ⊑
    select (icmp IntPred.eq (ashr (trunc 8 e) (const? 8 6)) (trunc 8 (lshr e (const? 16 8)) { «nuw» := true }))
      (trunc 8 e) (select (icmp IntPred.sgt e (const? 16 (-1))) (const? 8 127) (const? 8 (-128))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem badimm3_proof.badimm3_thm_1 (e : IntW 16) :
  select (icmp IntPred.eq (ashr (trunc 8 e) (const? 8 7)) (trunc 8 (lshr e (const? 16 8)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 16 14))) (const? 8 127)) ⊑
    select (icmp IntPred.ult (add e (const? 16 128)) (const? 16 256)) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 16 14)) { «nsw» := true }) (const? 8 127)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem badimm4_proof.badimm4_thm_1 (e : IntW 16) :
  select (icmp IntPred.eq (ashr (trunc 8 e) (const? 8 7)) (trunc 8 (lshr e (const? 16 8)))) (trunc 8 e)
      (LLVM.xor (trunc 8 (ashr e (const? 16 15))) (const? 8 126)) ⊑
    select (icmp IntPred.sgt e (const? 16 127)) (const? 8 126)
      (select (icmp IntPred.slt e (const? 16 (-128))) (const? 8 (-127)) (trunc 8 e)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem C0zero_proof.C0zero_thm_1 (e e_1 e_2 : IntW 8) :
  select (icmp IntPred.ult (add e (const? 8 10)) (const? 8 0)) e
      (select (icmp IntPred.slt e (const? 8 (-10))) e_1 e_2) ⊑
    select (icmp IntPred.slt e (const? 8 (-10))) e_1 e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
