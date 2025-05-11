
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphmulhand_proof
theorem mul_mask_pow2_eq0_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (mul e (const? 8 44)) (const? 8 4)) (const? 8 0) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 1)) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_mask_pow2_sgt0_thm (e : IntW 8) :
  icmp IntPredicate.sgt (LLVM.and (mul e (const? 8 44)) (const? 8 4)) (const? 8 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 8 1)) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_mask_fakepow2_ne0_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (mul e (const? 8 44)) (const? 8 5)) (const? 8 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 8 1)) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_mask_pow2_eq4_thm (e : IntW 8) :
  icmp IntPredicate.eq (LLVM.and (mul e (const? 8 44)) (const? 8 4)) (const? 8 4) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 8 1)) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul_mask_notpow2_ne_thm (e : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (mul e (const? 8 60)) (const? 8 12)) (const? 8 0) ⊑
    icmp IntPredicate.ne (LLVM.and (mul e (const? 8 12)) (const? 8 12)) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem pr40493_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (mul e (const? 32 12)) (const? 32 4)) (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 1)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem pr40493_neg1_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (mul e (const? 32 11)) (const? 32 4)) (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and (mul e (const? 32 3)) (const? 32 4)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem pr40493_neg2_thm (e : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (mul e (const? 32 12)) (const? 32 15)) (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and (mul e (const? 32 12)) (const? 32 12)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem pr40493_neg3_thm (e : IntW 32) :
  LLVM.and (mul e (const? 32 12)) (const? 32 4) ⊑ LLVM.and (shl e (const? 32 2)) (const? 32 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem pr51551_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq
      (LLVM.and (mul (LLVM.or (LLVM.and e_1 (const? 32 (-7))) (const? 32 1)) e { «nsw» := true, «nuw» := false })
        (const? 32 3))
      (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 3)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem pr51551_2_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq
      (LLVM.and (mul (LLVM.or (LLVM.and e_1 (const? 32 (-7))) (const? 32 1)) e { «nsw» := true, «nuw» := false })
        (const? 32 1))
      (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 1)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem pr51551_neg1_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq
      (LLVM.and (mul (LLVM.or (LLVM.and e_1 (const? 32 (-3))) (const? 32 1)) e { «nsw» := true, «nuw» := false })
        (const? 32 7))
      (const? 32 0) ⊑
    icmp IntPredicate.eq
      (LLVM.and (mul (LLVM.or (LLVM.and e_1 (const? 32 4)) (const? 32 1) { «disjoint» := true }) e) (const? 32 7))
      (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem pr51551_neg2_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq
      (LLVM.and (mul (LLVM.and e_1 (const? 32 (-7))) e { «nsw» := true, «nuw» := false }) (const? 32 7)) (const? 32 0) ⊑
    select (LLVM.xor (trunc 1 e_1) (const? 1 1)) (const? 1 1)
      (icmp IntPredicate.eq (LLVM.and e (const? 32 7)) (const? 32 0)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem pr51551_demand3bits_thm (e e_1 : IntW 32) :
  LLVM.and (mul (LLVM.or (LLVM.and e_1 (const? 32 (-7))) (const? 32 1)) e { «nsw» := true, «nuw» := false })
      (const? 32 7) ⊑
    LLVM.and e (const? 32 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
