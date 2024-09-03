
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gdivhshift_proof
theorem t7_thm (x : BitVec 32) :
  (if x = 0#32 ∨ x <<< 2 = intMin 32 ∧ x = 4294967295#32 then none else some ((x <<< 2).sdiv x)) ⊑ some 4#32 := sorry

theorem t10_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x.toNat)) fun a =>
      if x_1 = 0#32 ∨ a = intMin 32 ∧ x_1 = 4294967295#32 then none else some (a.sdiv x_1)) ⊑
    if 32 ≤ x.toNat then none else some (1#32 <<< x.toNat) := sorry

theorem sdiv_mul_shl_nsw_thm (x x_1 x_2 : BitVec 5) :
  (Option.bind (if 5 ≤ x.toNat then none else some (x_2 <<< x.toNat)) fun a =>
      if a = 0#5 ∨ x_2 * x_1 = intMin 5 ∧ a = 31#5 then none else some ((x_2 * x_1).sdiv a)) ⊑
    Option.bind (if 5 ≤ x.toNat then none else some (1#5 <<< x.toNat)) fun a =>
      if a = 0#5 ∨ x_1 = intMin 5 ∧ a = 31#5 then none else some (x_1.sdiv a) := sorry

theorem sdiv_mul_shl_nsw_exact_commute1_thm (x x_1 x_2 : BitVec 5) :
  (Option.bind (if 5 ≤ x.toNat then none else some (x_1 <<< x.toNat)) fun a =>
      if a = 0#5 ∨ x_2 * x_1 = intMin 5 ∧ a = 31#5 then none else some ((x_2 * x_1).sdiv a)) ⊑
    Option.bind (if 5 ≤ x.toNat then none else some (1#5 <<< x.toNat)) fun a =>
      if a = 0#5 ∨ x_2 = intMin 5 ∧ a = 31#5 then none else some (x_2.sdiv a) := sorry

theorem sdiv_shl_shl_nsw2_nuw_thm (x x_1 x_2 : BitVec 8) :
  (Option.bind (if 8 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 8 ≤ x_1.toNat then none else some (x <<< x_1.toNat)) fun a_1 =>
        if a_1 = 0#8 ∨ a = intMin 8 ∧ a_1 = 255#8 then none else some (a.sdiv a_1)) ⊑
    if x = 0#8 ∨ x_2 = intMin 8 ∧ x = 255#8 then none else some (x_2.sdiv x) := sorry

theorem sdiv_shl_pair_const_thm (x : BitVec 32) :
  (if x <<< 1 = 0#32 ∨ x <<< 2 = intMin 32 ∧ x <<< 1 = 4294967295#32 then none else some ((x <<< 2).sdiv (x <<< 1))) ⊑
    some 2#32 := sorry

theorem sdiv_shl_pair1_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 32 ≤ x.toNat then none else some (x_2 <<< x.toNat)) fun a_1 =>
        if a_1 = 0#32 ∨ a = intMin 32 ∧ a_1 = 4294967295#32 then none else some (a.sdiv a_1)) ⊑
    Option.bind (if 32 ≤ x_1.toNat then none else some (1#32 <<< x_1.toNat)) fun a =>
      if 32 ≤ x.toNat then none else some (a >>> x.toNat) := sorry

theorem sdiv_shl_pair2_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 32 ≤ x.toNat then none else some (x_2 <<< x.toNat)) fun a_1 =>
        if a_1 = 0#32 ∨ a = intMin 32 ∧ a_1 = 4294967295#32 then none else some (a.sdiv a_1)) ⊑
    Option.bind (if 32 ≤ x_1.toNat then none else some (1#32 <<< x_1.toNat)) fun a =>
      if 32 ≤ x.toNat then none else some (a >>> x.toNat) := sorry

theorem sdiv_shl_pair3_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 32 ≤ x.toNat then none else some (x_2 <<< x.toNat)) fun a_1 =>
        if a_1 = 0#32 ∨ a = intMin 32 ∧ a_1 = 4294967295#32 then none else some (a.sdiv a_1)) ⊑
    Option.bind (if 32 ≤ x_1.toNat then none else some (1#32 <<< x_1.toNat)) fun a =>
      if 32 ≤ x.toNat then none else some (a >>> x.toNat) := sorry

