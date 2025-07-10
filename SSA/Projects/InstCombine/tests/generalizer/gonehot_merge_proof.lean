
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gonehot_merge_proof
theorem and_consts_proof.and_consts_thm_1 (e : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and (const? 32 4) e) (const? 32 0))
      (icmp IntPred.eq (LLVM.and (const? 32 8) e) (const? 32 0)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 12)) (const? 32 12) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem and_consts_logical_proof.and_consts_logical_thm_1 (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and (const? 32 4) e) (const? 32 0)) (const? 1 1)
      (icmp IntPred.eq (LLVM.and (const? 32 8) e) (const? 32 0)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 12)) (const? 32 12) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo1_and_proof.foo1_and_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and (shl (const? 32 1) e_1) e) (const? 32 0))
      (icmp IntPred.eq (LLVM.and (shl (const? 32 1) e_2) e) (const? 32 0)) ⊑
    icmp IntPred.ne
      (LLVM.and e (LLVM.or (shl (const? 32 1) e_1 { «nuw» := true }) (shl (const? 32 1) e_2 { «nuw» := true })))
      (LLVM.or (shl (const? 32 1) e_1 { «nuw» := true }) (shl (const? 32 1) e_2 { «nuw» := true })) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo1_and_commuted_proof.foo1_and_commuted_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and (mul e e) (shl (const? 32 1) e_1)) (const? 32 0))
      (icmp IntPred.eq (LLVM.and (shl (const? 32 1) e_2) (mul e e)) (const? 32 0)) ⊑
    icmp IntPred.ne
      (LLVM.and (mul e e) (LLVM.or (shl (const? 32 1) e_1 { «nuw» := true }) (shl (const? 32 1) e_2 { «nuw» := true })))
      (LLVM.or (shl (const? 32 1) e_1 { «nuw» := true }) (shl (const? 32 1) e_2 { «nuw» := true })) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_consts_proof.or_consts_thm_1 (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and (const? 32 4) e) (const? 32 0))
      (icmp IntPred.ne (LLVM.and (const? 32 8) e) (const? 32 0)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 12)) (const? 32 12) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem or_consts_logical_proof.or_consts_logical_thm_1 (e : IntW 32) :
  select (icmp IntPred.ne (LLVM.and (const? 32 4) e) (const? 32 0))
      (icmp IntPred.ne (LLVM.and (const? 32 8) e) (const? 32 0)) (const? 1 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 12)) (const? 32 12) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo1_or_proof.foo1_or_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and (shl (const? 32 1) e_1) e) (const? 32 0))
      (icmp IntPred.ne (LLVM.and (shl (const? 32 1) e_2) e) (const? 32 0)) ⊑
    icmp IntPred.eq
      (LLVM.and e (LLVM.or (shl (const? 32 1) e_1 { «nuw» := true }) (shl (const? 32 1) e_2 { «nuw» := true })))
      (LLVM.or (shl (const? 32 1) e_1 { «nuw» := true }) (shl (const? 32 1) e_2 { «nuw» := true })) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo1_or_commuted_proof.foo1_or_commuted_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and (mul e e) (shl (const? 32 1) e_1)) (const? 32 0))
      (icmp IntPred.ne (LLVM.and (shl (const? 32 1) e_2) (mul e e)) (const? 32 0)) ⊑
    icmp IntPred.eq
      (LLVM.and (mul e e) (LLVM.or (shl (const? 32 1) e_1 { «nuw» := true }) (shl (const? 32 1) e_2 { «nuw» := true })))
      (LLVM.or (shl (const? 32 1) e_1 { «nuw» := true }) (shl (const? 32 1) e_2 { «nuw» := true })) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo1_and_signbit_lshr_proof.foo1_and_signbit_lshr_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and (shl (const? 32 1) e_1) e) (const? 32 0))
      (icmp IntPred.eq (LLVM.and (lshr (const? 32 (-2147483648)) e_2) e) (const? 32 0)) ⊑
    icmp IntPred.ne
      (LLVM.and e
        (LLVM.or (shl (const? 32 1) e_1 { «nuw» := true }) (lshr (const? 32 (-2147483648)) e_2 { «exact» := true })))
      (LLVM.or (shl (const? 32 1) e_1 { «nuw» := true })
        (lshr (const? 32 (-2147483648)) e_2 { «exact» := true })) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo1_or_signbit_lshr_proof.foo1_or_signbit_lshr_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and (shl (const? 32 1) e_1) e) (const? 32 0))
      (icmp IntPred.ne (LLVM.and (lshr (const? 32 (-2147483648)) e_2) e) (const? 32 0)) ⊑
    icmp IntPred.eq
      (LLVM.and e
        (LLVM.or (shl (const? 32 1) e_1 { «nuw» := true }) (lshr (const? 32 (-2147483648)) e_2 { «exact» := true })))
      (LLVM.or (shl (const? 32 1) e_1 { «nuw» := true })
        (lshr (const? 32 (-2147483648)) e_2 { «exact» := true })) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo1_and_signbit_lshr_without_shifting_signbit_proof.foo1_and_signbit_lshr_without_shifting_signbit_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.and (shl (const? 32 1) e_1) e) (const? 32 0))
      (icmp IntPred.sgt (shl e e_2) (const? 32 (-1))) ⊑
    LLVM.or (icmp IntPred.eq (LLVM.and (shl (const? 32 1) e_1 { «nuw» := true }) e) (const? 32 0))
      (icmp IntPred.sgt (shl e e_2) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo1_and_signbit_lshr_without_shifting_signbit_logical_proof.foo1_and_signbit_lshr_without_shifting_signbit_logical_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and (shl (const? 32 1) e_1) e) (const? 32 0)) (const? 1 1)
      (icmp IntPred.sgt (shl e e_2) (const? 32 (-1))) ⊑
    select (icmp IntPred.eq (LLVM.and (shl (const? 32 1) e_1 { «nuw» := true }) e) (const? 32 0)) (const? 1 1)
      (icmp IntPred.sgt (shl e e_2) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo1_or_signbit_lshr_without_shifting_signbit_proof.foo1_or_signbit_lshr_without_shifting_signbit_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and (shl (const? 32 1) e_1) e) (const? 32 0))
      (icmp IntPred.slt (shl e e_2) (const? 32 0)) ⊑
    LLVM.and (icmp IntPred.ne (LLVM.and (shl (const? 32 1) e_1 { «nuw» := true }) e) (const? 32 0))
      (icmp IntPred.slt (shl e e_2) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo1_or_signbit_lshr_without_shifting_signbit_logical_proof.foo1_or_signbit_lshr_without_shifting_signbit_logical_thm_1 (e e_1 e_2 : IntW 32) :
  select (icmp IntPred.ne (LLVM.and (shl (const? 32 1) e_1) e) (const? 32 0))
      (icmp IntPred.slt (shl e e_2) (const? 32 0)) (const? 1 0) ⊑
    select (icmp IntPred.ne (LLVM.and (shl (const? 32 1) e_1 { «nuw» := true }) e) (const? 32 0))
      (icmp IntPred.slt (shl e e_2) (const? 32 0)) (const? 1 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo1_and_signbit_lshr_without_shifting_signbit_both_sides_proof.foo1_and_signbit_lshr_without_shifting_signbit_both_sides_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (icmp IntPred.sgt (shl e e_1) (const? 32 (-1))) (icmp IntPred.sgt (shl e e_2) (const? 32 (-1))) ⊑
    icmp IntPred.sgt (LLVM.and (shl e e_1) (shl e e_2)) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo1_or_signbit_lshr_without_shifting_signbit_both_sides_proof.foo1_or_signbit_lshr_without_shifting_signbit_both_sides_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.and (icmp IntPred.slt (shl e e_1) (const? 32 0)) (icmp IntPred.slt (shl e e_2) (const? 32 0)) ⊑
    icmp IntPred.slt (LLVM.and (shl e e_1) (shl e e_2)) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
