
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section geqhofhparts_proof
theorem eq_10_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.eq (trunc 8 e_1) (trunc 8 e))
      (icmp IntPredicate.eq (trunc 8 (lshr e_1 (const? 32 8))) (trunc 8 (lshr e (const? 32 8)))) ⊑
    icmp IntPredicate.eq (trunc 16 e_1) (trunc 16 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_210_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.eq (trunc 8 (lshr e_1 (const? 32 16))) (trunc 8 (lshr e (const? 32 16))))
      (LLVM.and (icmp IntPredicate.eq (trunc 8 e_1) (trunc 8 e))
        (icmp IntPredicate.eq (trunc 8 (lshr e_1 (const? 32 8))) (trunc 8 (lshr e (const? 32 8))))) ⊑
    icmp IntPredicate.eq (trunc 24 e_1) (trunc 24 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_3210_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.eq (trunc 8 (lshr e_1 (const? 32 24))) (trunc 8 (lshr e (const? 32 24))))
      (LLVM.and (icmp IntPredicate.eq (trunc 8 (lshr e_1 (const? 32 16))) (trunc 8 (lshr e (const? 32 16))))
        (LLVM.and (icmp IntPredicate.eq (trunc 8 e_1) (trunc 8 e))
          (icmp IntPredicate.eq (trunc 8 (lshr e_1 (const? 32 8))) (trunc 8 (lshr e (const? 32 8)))))) ⊑
    icmp IntPredicate.eq e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_21_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.eq (trunc 8 (lshr e_1 (const? 32 16))) (trunc 8 (lshr e (const? 32 16))))
      (icmp IntPredicate.eq (trunc 8 (lshr e_1 (const? 32 8))) (trunc 8 (lshr e (const? 32 8)))) ⊑
    icmp IntPredicate.eq (trunc 16 (lshr e_1 (const? 32 8))) (trunc 16 (lshr e (const? 32 8))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_21_comm_and_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.eq (trunc 8 (lshr e_1 (const? 32 8))) (trunc 8 (lshr e (const? 32 8))))
      (icmp IntPredicate.eq (trunc 8 (lshr e_1 (const? 32 16))) (trunc 8 (lshr e (const? 32 16)))) ⊑
    icmp IntPredicate.eq (trunc 16 (lshr e_1 (const? 32 8))) (trunc 16 (lshr e (const? 32 8))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_21_comm_eq_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.eq (trunc 8 (lshr e_1 (const? 32 16))) (trunc 8 (lshr e (const? 32 16))))
      (icmp IntPredicate.eq (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8)))) ⊑
    icmp IntPredicate.eq (trunc 16 (lshr e_1 (const? 32 8))) (trunc 16 (lshr e (const? 32 8))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_21_comm_eq2_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.eq (trunc 8 (lshr e_1 (const? 32 16))) (trunc 8 (lshr e (const? 32 16))))
      (icmp IntPredicate.eq (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8)))) ⊑
    icmp IntPredicate.eq (trunc 16 (lshr e_1 (const? 32 8))) (trunc 16 (lshr e (const? 32 8))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_irregular_bit_widths_thm (e e_1 : IntW 31) :
  LLVM.and (icmp IntPredicate.eq (trunc 5 (lshr e_1 (const? 31 13))) (trunc 5 (lshr e (const? 31 13))))
      (icmp IntPredicate.eq (trunc 6 (lshr e_1 (const? 31 7))) (trunc 6 (lshr e (const? 31 7)))) ⊑
    icmp IntPredicate.eq (trunc 11 (lshr e_1 (const? 31 7))) (trunc 11 (lshr e (const? 31 7))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_21_logical_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (trunc 8 (lshr e_1 (const? 32 16))) (trunc 8 (lshr e (const? 32 16))))
      (icmp IntPredicate.eq (trunc 8 (lshr e_1 (const? 32 8))) (trunc 8 (lshr e (const? 32 8)))) (const? 1 0) ⊑
    icmp IntPredicate.eq (trunc 16 (lshr e_1 (const? 32 8))) (trunc 16 (lshr e (const? 32 8))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_shift_in_zeros_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.eq (trunc 24 (lshr e_1 (const? 32 16))) (trunc 24 (lshr e (const? 32 16))))
      (icmp IntPredicate.eq (trunc 8 (lshr e_1 (const? 32 8))) (trunc 8 (lshr e (const? 32 8)))) ⊑
    icmp IntPredicate.ult (LLVM.xor e_1 e) (const? 32 256) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_10_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.ne (trunc 8 e_1) (trunc 8 e))
      (icmp IntPredicate.ne (trunc 8 (lshr e_1 (const? 32 8))) (trunc 8 (lshr e (const? 32 8)))) ⊑
    icmp IntPredicate.ne (trunc 16 e_1) (trunc 16 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_210_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.ne (trunc 8 (lshr e_1 (const? 32 16))) (trunc 8 (lshr e (const? 32 16))))
      (LLVM.or (icmp IntPredicate.ne (trunc 8 e_1) (trunc 8 e))
        (icmp IntPredicate.ne (trunc 8 (lshr e_1 (const? 32 8))) (trunc 8 (lshr e (const? 32 8))))) ⊑
    icmp IntPredicate.ne (trunc 24 e_1) (trunc 24 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_3210_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.ne (trunc 8 (lshr e_1 (const? 32 24))) (trunc 8 (lshr e (const? 32 24))))
      (LLVM.or (icmp IntPredicate.ne (trunc 8 (lshr e_1 (const? 32 16))) (trunc 8 (lshr e (const? 32 16))))
        (LLVM.or (icmp IntPredicate.ne (trunc 8 e_1) (trunc 8 e))
          (icmp IntPredicate.ne (trunc 8 (lshr e_1 (const? 32 8))) (trunc 8 (lshr e (const? 32 8)))))) ⊑
    icmp IntPredicate.ne e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_21_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.ne (trunc 8 (lshr e_1 (const? 32 16))) (trunc 8 (lshr e (const? 32 16))))
      (icmp IntPredicate.ne (trunc 8 (lshr e_1 (const? 32 8))) (trunc 8 (lshr e (const? 32 8)))) ⊑
    icmp IntPredicate.ne (trunc 16 (lshr e_1 (const? 32 8))) (trunc 16 (lshr e (const? 32 8))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_21_comm_or_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.ne (trunc 8 (lshr e_1 (const? 32 8))) (trunc 8 (lshr e (const? 32 8))))
      (icmp IntPredicate.ne (trunc 8 (lshr e_1 (const? 32 16))) (trunc 8 (lshr e (const? 32 16)))) ⊑
    icmp IntPredicate.ne (trunc 16 (lshr e_1 (const? 32 8))) (trunc 16 (lshr e (const? 32 8))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_21_comm_ne_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.ne (trunc 8 (lshr e_1 (const? 32 16))) (trunc 8 (lshr e (const? 32 16))))
      (icmp IntPredicate.ne (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8)))) ⊑
    icmp IntPredicate.ne (trunc 16 (lshr e_1 (const? 32 8))) (trunc 16 (lshr e (const? 32 8))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_21_comm_ne2_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.ne (trunc 8 (lshr e_1 (const? 32 16))) (trunc 8 (lshr e (const? 32 16))))
      (icmp IntPredicate.ne (trunc 8 (lshr e (const? 32 8))) (trunc 8 (lshr e_1 (const? 32 8)))) ⊑
    icmp IntPredicate.ne (trunc 16 (lshr e_1 (const? 32 8))) (trunc 16 (lshr e (const? 32 8))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_irregular_bit_widths_thm (e e_1 : IntW 31) :
  LLVM.or (icmp IntPredicate.ne (trunc 5 (lshr e_1 (const? 31 13))) (trunc 5 (lshr e (const? 31 13))))
      (icmp IntPredicate.ne (trunc 6 (lshr e_1 (const? 31 7))) (trunc 6 (lshr e (const? 31 7)))) ⊑
    icmp IntPredicate.ne (trunc 11 (lshr e_1 (const? 31 7))) (trunc 11 (lshr e (const? 31 7))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_21_logical_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ne (trunc 8 (lshr e_1 (const? 32 16))) (trunc 8 (lshr e (const? 32 16)))) (const? 1 1)
      (icmp IntPredicate.ne (trunc 8 (lshr e_1 (const? 32 8))) (trunc 8 (lshr e (const? 32 8)))) ⊑
    icmp IntPredicate.ne (trunc 16 (lshr e_1 (const? 32 8))) (trunc 16 (lshr e (const? 32 8))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_shift_in_zeros_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.ne (trunc 24 (lshr e_1 (const? 32 16))) (trunc 24 (lshr e (const? 32 16))))
      (icmp IntPredicate.ne (trunc 8 (lshr e_1 (const? 32 8))) (trunc 8 (lshr e (const? 32 8)))) ⊑
    icmp IntPredicate.ugt (LLVM.xor e_1 e) (const? 32 255) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem eq_optimized_highbits_cmp_thm (e e_1 : IntW 32) :
  LLVM.and (icmp IntPredicate.ult (LLVM.xor e_1 e) (const? 32 33554432))
      (icmp IntPredicate.eq (trunc 25 e) (trunc 25 e_1)) ⊑
    icmp IntPredicate.eq e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ne_optimized_highbits_cmp_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPredicate.ugt (LLVM.xor e_1 e) (const? 32 16777215))
      (icmp IntPredicate.ne (trunc 24 e) (trunc 24 e_1)) ⊑
    icmp IntPredicate.ne e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
