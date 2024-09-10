
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section glshr_proof
theorem lshr_exact_thm (x : BitVec 8) : (x <<< 2 + 4#8) >>> 2 = x + 1#8 &&& 63#8 := sorry

theorem shl_add_thm (x x_1 : BitVec 8) : (x_1 <<< 2 + x) >>> 2 = x >>> 2 + x_1 &&& 63#8 := sorry

theorem mul_splat_fold_thm (x : BitVec 32) : (x * 65537#32) >>> 16 = x := sorry

theorem shl_add_lshr_flag_preservation_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      if 32 ≤ x_1.toNat then none else some ((a + x) >>> x_1.toNat)) ⊑
    Option.bind (if 32 ≤ x_1.toNat then none else some (x >>> x_1.toNat)) fun a => some (a + x_2) := sorry

theorem shl_add_lshr_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      if 32 ≤ x_1.toNat then none else some ((a + x) >>> x_1.toNat)) ⊑
    Option.bind (if 32 ≤ x_1.toNat then none else some (x >>> x_1.toNat)) fun a => some (a + x_2) := sorry

theorem shl_add_lshr_comm_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x.toNat)) fun a =>
      if 32 ≤ x.toNat then none else some ((x_2 * x_2 + a) >>> x.toNat)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some ((x_2 * x_2) >>> x.toNat)) fun a => some (a + x_1) := sorry

theorem shl_sub_lshr_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      if 32 ≤ x_1.toNat then none else some ((a - x) >>> x_1.toNat)) ⊑
    Option.bind (if 32 ≤ x_1.toNat then none else some (x >>> x_1.toNat)) fun a => some (x_2 - a) := sorry

theorem shl_sub_lshr_reverse_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x.toNat)) fun a =>
      if 32 ≤ x.toNat then none else some ((x_2 - a) >>> x.toNat)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (x_2 >>> x.toNat)) fun a => some (a - x_1) := sorry

theorem shl_sub_lshr_reverse_no_nsw_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x.toNat)) fun a =>
      if 32 ≤ x.toNat then none else some ((x_2 - a) >>> x.toNat)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (x_2 >>> x.toNat)) fun a => some (a - x_1) := sorry

theorem shl_sub_lshr_reverse_nsw_on_op1_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x.toNat)) fun a =>
      if 32 ≤ x.toNat then none else some ((x_2 - a) >>> x.toNat)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (x_2 >>> x.toNat)) fun a => some (a - x_1) := sorry

theorem shl_or_lshr_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      if 32 ≤ x_1.toNat then none else some ((a ||| x) >>> x_1.toNat)) ⊑
    Option.bind (if 32 ≤ x_1.toNat then none else some (x >>> x_1.toNat)) fun a => some (a ||| x_2) := sorry

theorem shl_or_disjoint_lshr_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      if 32 ≤ x_1.toNat then none else some ((a ||| x) >>> x_1.toNat)) ⊑
    Option.bind (if 32 ≤ x_1.toNat then none else some (x >>> x_1.toNat)) fun a => some (a ||| x_2) := sorry

theorem shl_or_lshr_comm_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x.toNat)) fun a =>
      if 32 ≤ x.toNat then none else some ((x_2 ||| a) >>> x.toNat)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (x_2 >>> x.toNat)) fun a => some (a ||| x_1) := sorry

theorem shl_or_disjoint_lshr_comm_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x.toNat)) fun a =>
      if 32 ≤ x.toNat then none else some ((x_2 ||| a) >>> x.toNat)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (x_2 >>> x.toNat)) fun a => some (a ||| x_1) := sorry

theorem shl_xor_lshr_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      if 32 ≤ x_1.toNat then none else some ((a ^^^ x) >>> x_1.toNat)) ⊑
    Option.bind (if 32 ≤ x_1.toNat then none else some (x >>> x_1.toNat)) fun a => some (a ^^^ x_2) := sorry

theorem shl_xor_lshr_comm_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x.toNat)) fun a =>
      if 32 ≤ x.toNat then none else some ((x_2 ^^^ a) >>> x.toNat)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (x_2 >>> x.toNat)) fun a => some (a ^^^ x_1) := sorry

theorem shl_and_lshr_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      if 32 ≤ x_1.toNat then none else some ((a &&& x) >>> x_1.toNat)) ⊑
    Option.bind (if 32 ≤ x_1.toNat then none else some (x >>> x_1.toNat)) fun a => some (a &&& x_2) := sorry

theorem shl_and_lshr_comm_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x.toNat)) fun a =>
      if 32 ≤ x.toNat then none else some ((x_2 &&& a) >>> x.toNat)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (x_2 >>> x.toNat)) fun a => some (a &&& x_1) := sorry

theorem shl_lshr_and_exact_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32 ≤ x_1.toNat then none else some (x_2 <<< x_1.toNat)) fun a =>
      if 32 ≤ x_1.toNat then none else some ((a &&& x) >>> x_1.toNat)) ⊑
    Option.bind (if 32 ≤ x_1.toNat then none else some (x >>> x_1.toNat)) fun a => some (a &&& x_2) := sorry

theorem mul_splat_fold_no_nuw_thm (x : BitVec 32) : (x * 65537#32) >>> 16 = x >>> 16 + x := sorry

theorem mul_splat_fold_too_narrow_thm (x : BitVec 2) : (x * 2#2) >>> 1 = x := sorry

theorem negative_and_odd_thm (x : BitVec 32) : (x - x.sdiv 2#32 * 2#32) >>> 31 = x >>> 31 &&& x := sorry

