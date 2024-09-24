
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gshlhfactor_proof
theorem add_shl_same_amount_thm (x x_1 x_2 : BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1.toNat)) fun a_1 => some (a + a_1)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 + x) <<< x_1.toNat) := sorry

theorem add_shl_same_amount_nuw_thm (x x_1 x_2 : BitVec 64) :
  (Option.bind (if 64 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 64 ≤ x_1.toNat then none else some (x <<< x_1.toNat)) fun a_1 => some (a + a_1)) ⊑
    if 64 ≤ x_1.toNat then none else some ((x_2 + x) <<< x_1.toNat) := sorry

theorem add_shl_same_amount_partial_nsw1_thm (x x_1 x_2 : BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1.toNat)) fun a_1 => some (a + a_1)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 + x) <<< x_1.toNat) := sorry

theorem add_shl_same_amount_partial_nsw2_thm (x x_1 x_2 : BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1.toNat)) fun a_1 => some (a + a_1)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 + x) <<< x_1.toNat) := sorry

theorem add_shl_same_amount_partial_nuw1_thm (x x_1 x_2 : BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1.toNat)) fun a_1 => some (a + a_1)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 + x) <<< x_1.toNat) := sorry

theorem add_shl_same_amount_partial_nuw2_thm (x x_1 x_2 : BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1.toNat)) fun a_1 => some (a + a_1)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 + x) <<< x_1.toNat) := sorry

theorem sub_shl_same_amount_thm (x x_1 x_2 : BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1.toNat)) fun a_1 => some (a - a_1)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 - x) <<< x_1.toNat) := sorry

theorem sub_shl_same_amount_nuw_thm (x x_1 x_2 : BitVec 64) :
  (Option.bind (if 64 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 64 ≤ x_1.toNat then none else some (x <<< x_1.toNat)) fun a_1 => some (a - a_1)) ⊑
    if 64 ≤ x_1.toNat then none else some ((x_2 - x) <<< x_1.toNat) := sorry

theorem sub_shl_same_amount_partial_nsw1_thm (x x_1 x_2 : BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1.toNat)) fun a_1 => some (a - a_1)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 - x) <<< x_1.toNat) := sorry

theorem sub_shl_same_amount_partial_nsw2_thm (x x_1 x_2 : BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1.toNat)) fun a_1 => some (a - a_1)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 - x) <<< x_1.toNat) := sorry

theorem sub_shl_same_amount_partial_nuw1_thm (x x_1 x_2 : BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1.toNat)) fun a_1 => some (a - a_1)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 - x) <<< x_1.toNat) := sorry

theorem sub_shl_same_amount_partial_nuw2_thm (x x_1 x_2 : BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1.toNat)) fun a_1 => some (a - a_1)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 - x) <<< x_1.toNat) := sorry

theorem add_shl_same_amount_constants_thm (x : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (4#8 <<< x.toNat)) fun a =>
      Option.bind (if 8 ≤ x.toNat then none else some (3#8 <<< x.toNat)) fun a_1 => some (a + a_1)) ⊑
    if 8 ≤ x.toNat then none else some (7#8 <<< x.toNat) := sorry

