import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



theorem t7_thm (x : _root_.BitVec 32) :
  (if x = 0#32 ∨ x <<< 2 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((x <<< 2).sdiv x)) ⊑
    some 4#32 := by
  sorry

theorem t10_thm (x x_1 : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x)) fun a =>
      if x_1 = 0#32 ∨ a = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some (a.sdiv x_1)) ⊑
    if 32 ≤ x.toNat then none else some (1#32 <<< x) := by
  sorry

theorem sdiv_mul_shl_nsw_thm (x x_1 x_2 : _root_.BitVec 5) :
  (Option.bind (if 5 ≤ x.toNat then none else some (x_2 <<< x)) fun a =>
      if a = 0#5 ∨ x_2 * x_1 = LLVM.intMin 5 ∧ a = 31#5 then none else some ((x_2 * x_1).sdiv a)) ⊑
    Option.bind (if 5 ≤ x.toNat then none else some (1#5 <<< x)) fun a =>
      if a = 0#5 ∨ x_1 = LLVM.intMin 5 ∧ a = 31#5 then none else some (x_1.sdiv a) := by
  sorry

theorem sdiv_mul_shl_nsw_exact_commute1_thm (x x_1 x_2 : _root_.BitVec 5) :
  (Option.bind (if 5 ≤ x.toNat then none else some (x_1 <<< x)) fun a =>
      if a = 0#5 ∨ x_2 * x_1 = LLVM.intMin 5 ∧ a = 31#5 then none else some ((x_2 * x_1).sdiv a)) ⊑
    Option.bind (if 5 ≤ x.toNat then none else some (1#5 <<< x)) fun a =>
      if a = 0#5 ∨ x_2 = LLVM.intMin 5 ∧ a = 31#5 then none else some (x_2.sdiv a) := by
  sorry

theorem sdiv_shl_shl_nsw2_nuw_thm (x x_1 x_2 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 8 ≤ x_1.toNat then none else some (x <<< x_1)) fun a_1 =>
        if a_1 = 0#8 ∨ a = LLVM.intMin 8 ∧ a_1 = 255#8 then none else some (a.sdiv a_1)) ⊑
    if x = 0#8 ∨ x_2 = LLVM.intMin 8 ∧ x = 255#8 then none else some (x_2.sdiv x) := by
  sorry

theorem sdiv_shl_pair_const_thm (x : _root_.BitVec 32) :
  (if x <<< 1 = 0#32 ∨ x <<< 2 = LLVM.intMin 32 ∧ x <<< 1 = 4294967295#32 then none
    else some ((x <<< 2).sdiv (x <<< 1))) ⊑
    some 2#32 := by
  sorry

theorem sdiv_shl_pair1_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 32 ≤ x.toNat then none else some (x_2 <<< x)) fun a_1 =>
        if a_1 = 0#32 ∨ a = LLVM.intMin 32 ∧ a_1 = 4294967295#32 then none else some (a.sdiv a_1)) ⊑
    Option.bind (if 32 ≤ x_1.toNat then none else some (1#32 <<< x_1)) fun a =>
      if 32 ≤ x.toNat then none else some (a >>> x) := by
  sorry

theorem sdiv_shl_pair2_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 32 ≤ x.toNat then none else some (x_2 <<< x)) fun a_1 =>
        if a_1 = 0#32 ∨ a = LLVM.intMin 32 ∧ a_1 = 4294967295#32 then none else some (a.sdiv a_1)) ⊑
    Option.bind (if 32 ≤ x_1.toNat then none else some (1#32 <<< x_1)) fun a =>
      if 32 ≤ x.toNat then none else some (a >>> x) := by
  sorry

theorem sdiv_shl_pair3_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 32 ≤ x.toNat then none else some (x_2 <<< x)) fun a_1 =>
        if a_1 = 0#32 ∨ a = LLVM.intMin 32 ∧ a_1 = 4294967295#32 then none else some (a.sdiv a_1)) ⊑
    Option.bind (if 32 ≤ x_1.toNat then none else some (1#32 <<< x_1)) fun a =>
      if 32 ≤ x.toNat then none else some (a >>> x) := by
  sorry

