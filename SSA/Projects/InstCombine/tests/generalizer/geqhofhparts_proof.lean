
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section geqhofhparts_proof
theorem eq_10_proof.eq_10_thm_1 (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.eq (trunc 8 e) (trunc 8 e_1))
      (icmp IntPred.eq (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8)))) ⊑
    icmp IntPred.eq (trunc 16 e) (trunc 16 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_210_proof.eq_210_thm_1 (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.eq (trunc 8 (lshr e (const? 32 16))) (trunc 8 (lshr e_1 (const? 32 16))))
      (LLVM.and (icmp IntPred.eq (trunc 8 e) (trunc 8 e_1))
        (icmp IntPred.eq (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8))))) ⊑
    icmp IntPred.eq (trunc 24 e) (trunc 24 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_3210_proof.eq_3210_thm_1 (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.eq (trunc 8 (lshr e (const? 32 24))) (trunc 8 (lshr e_1 (const? 32 24))))
      (LLVM.and (icmp IntPred.eq (trunc 8 (lshr e (const? 32 16))) (trunc 8 (lshr e_1 (const? 32 16))))
        (LLVM.and (icmp IntPred.eq (trunc 8 e) (trunc 8 e_1))
          (icmp IntPred.eq (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8)))))) ⊑
    icmp IntPred.eq e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_21_proof.eq_21_thm_1 (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.eq (trunc 8 (lshr e (const? 32 16))) (trunc 8 (lshr e_1 (const? 32 16))))
      (icmp IntPred.eq (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8)))) ⊑
    icmp IntPred.eq (trunc 16 (lshr e (const? 32 8))) (trunc 16 (lshr e_1 (const? 32 8))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_21_comm_and_proof.eq_21_comm_and_thm_1 (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.eq (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8))))
      (icmp IntPred.eq (trunc 8 (lshr e (const? 32 16))) (trunc 8 (lshr e_1 (const? 32 16)))) ⊑
    icmp IntPred.eq (trunc 16 (lshr e (const? 32 8))) (trunc 16 (lshr e_1 (const? 32 8))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_21_comm_eq_proof.eq_21_comm_eq_thm_1 (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.eq (trunc 8 (lshr e_1 (const? 32 16))) (trunc 8 (lshr e (const? 32 16))))
      (icmp IntPred.eq (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8)))) ⊑
    icmp IntPred.eq (trunc 16 (lshr e_1 (const? 32 8))) (trunc 16 (lshr e (const? 32 8))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_21_comm_eq2_proof.eq_21_comm_eq2_thm_1 (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.eq (trunc 8 (lshr e (const? 32 16))) (trunc 8 (lshr e_1 (const? 32 16))))
      (icmp IntPred.eq (trunc 8 (lshr e_1 (const? 32 8))) (trunc 8 (lshr e (const? 32 8)))) ⊑
    icmp IntPred.eq (trunc 16 (lshr e (const? 32 8))) (trunc 16 (lshr e_1 (const? 32 8))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_irregular_bit_widths_proof.eq_irregular_bit_widths_thm_1 (e e_1 : IntW 31) :
  LLVM.and (icmp IntPred.eq (trunc 5 (lshr e (const? 31 13))) (trunc 5 (lshr e_1 (const? 31 13))))
      (icmp IntPred.eq (trunc 6 (lshr e (const? 31 7))) (trunc 6 (lshr e_1 (const? 31 7)))) ⊑
    icmp IntPred.eq (trunc 11 (lshr e (const? 31 7))) (trunc 11 (lshr e_1 (const? 31 7))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_21_logical_proof.eq_21_logical_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq (trunc 8 (lshr e (const? 32 16))) (trunc 8 (lshr e_1 (const? 32 16))))
      (icmp IntPred.eq (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8)))) (const? 1 0) ⊑
    icmp IntPred.eq (trunc 16 (lshr e (const? 32 8))) (trunc 16 (lshr e_1 (const? 32 8))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_shift_in_zeros_proof.eq_shift_in_zeros_thm_1 (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.eq (trunc 24 (lshr e (const? 32 16))) (trunc 24 (lshr e_1 (const? 32 16))))
      (icmp IntPred.eq (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8)))) ⊑
    icmp IntPred.ult (LLVM.xor e e_1) (const? 32 256) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_10_proof.ne_10_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.ne (trunc 8 e) (trunc 8 e_1))
      (icmp IntPred.ne (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8)))) ⊑
    icmp IntPred.ne (trunc 16 e) (trunc 16 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_210_proof.ne_210_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.ne (trunc 8 (lshr e (const? 32 16))) (trunc 8 (lshr e_1 (const? 32 16))))
      (LLVM.or (icmp IntPred.ne (trunc 8 e) (trunc 8 e_1))
        (icmp IntPred.ne (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8))))) ⊑
    icmp IntPred.ne (trunc 24 e) (trunc 24 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_3210_proof.ne_3210_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.ne (trunc 8 (lshr e (const? 32 24))) (trunc 8 (lshr e_1 (const? 32 24))))
      (LLVM.or (icmp IntPred.ne (trunc 8 (lshr e (const? 32 16))) (trunc 8 (lshr e_1 (const? 32 16))))
        (LLVM.or (icmp IntPred.ne (trunc 8 e) (trunc 8 e_1))
          (icmp IntPred.ne (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8)))))) ⊑
    icmp IntPred.ne e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_21_proof.ne_21_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.ne (trunc 8 (lshr e (const? 32 16))) (trunc 8 (lshr e_1 (const? 32 16))))
      (icmp IntPred.ne (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8)))) ⊑
    icmp IntPred.ne (trunc 16 (lshr e (const? 32 8))) (trunc 16 (lshr e_1 (const? 32 8))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_21_comm_or_proof.ne_21_comm_or_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.ne (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8))))
      (icmp IntPred.ne (trunc 8 (lshr e (const? 32 16))) (trunc 8 (lshr e_1 (const? 32 16)))) ⊑
    icmp IntPred.ne (trunc 16 (lshr e (const? 32 8))) (trunc 16 (lshr e_1 (const? 32 8))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_21_comm_ne_proof.ne_21_comm_ne_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.ne (trunc 8 (lshr e_1 (const? 32 16))) (trunc 8 (lshr e (const? 32 16))))
      (icmp IntPred.ne (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8)))) ⊑
    icmp IntPred.ne (trunc 16 (lshr e_1 (const? 32 8))) (trunc 16 (lshr e (const? 32 8))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_21_comm_ne2_proof.ne_21_comm_ne2_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.ne (trunc 8 (lshr e (const? 32 16))) (trunc 8 (lshr e_1 (const? 32 16))))
      (icmp IntPred.ne (trunc 8 (lshr e_1 (const? 32 8))) (trunc 8 (lshr e (const? 32 8)))) ⊑
    icmp IntPred.ne (trunc 16 (lshr e (const? 32 8))) (trunc 16 (lshr e_1 (const? 32 8))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_irregular_bit_widths_proof.ne_irregular_bit_widths_thm_1 (e e_1 : IntW 31) :
  LLVM.or (icmp IntPred.ne (trunc 5 (lshr e (const? 31 13))) (trunc 5 (lshr e_1 (const? 31 13))))
      (icmp IntPred.ne (trunc 6 (lshr e (const? 31 7))) (trunc 6 (lshr e_1 (const? 31 7)))) ⊑
    icmp IntPred.ne (trunc 11 (lshr e (const? 31 7))) (trunc 11 (lshr e_1 (const? 31 7))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_21_logical_proof.ne_21_logical_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ne (trunc 8 (lshr e (const? 32 16))) (trunc 8 (lshr e_1 (const? 32 16)))) (const? 1 1)
      (icmp IntPred.ne (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8)))) ⊑
    icmp IntPred.ne (trunc 16 (lshr e (const? 32 8))) (trunc 16 (lshr e_1 (const? 32 8))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_shift_in_zeros_proof.ne_shift_in_zeros_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.ne (trunc 24 (lshr e (const? 32 16))) (trunc 24 (lshr e_1 (const? 32 16))))
      (icmp IntPred.ne (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8)))) ⊑
    icmp IntPred.ugt (LLVM.xor e e_1) (const? 32 255) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem eq_optimized_highbits_cmp_proof.eq_optimized_highbits_cmp_thm_1 (e e_1 : IntW 32) :
  LLVM.and (icmp IntPred.ult (LLVM.xor e_1 e) (const? 32 33554432)) (icmp IntPred.eq (trunc 25 e) (trunc 25 e_1)) ⊑
    icmp IntPred.eq e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ne_optimized_highbits_cmp_proof.ne_optimized_highbits_cmp_thm_1 (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.ugt (LLVM.xor e_1 e) (const? 32 16777215)) (icmp IntPred.ne (trunc 24 e) (trunc 24 e_1)) ⊑
    icmp IntPred.ne e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
