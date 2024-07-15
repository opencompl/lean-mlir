import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem lshr_exact_thm (x : _root_.BitVec 8) : (x <<< 2 + 4#8) >>> 2 = x + 1#8 &&& 63#8 := sorry

theorem shl_add_thm (x x_1 : _root_.BitVec 8) : (x_1 <<< 2 + x) >>> 2 = x >>> 2 + x_1 &&& 63#8 := sorry

theorem mul_splat_fold_thm (x : _root_.BitVec 32) : (x * 65537#32) >>> 16 = x &&& 65535#32 := sorry

theorem shl_or_lshr_comm_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x)) fun a =>
      if 32 ≤ x.toNat then none else some ((x_2 ||| a) >>> x)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x)) fun a =>
      if 32 ≤ x.toNat then none else some ((a ||| x_2) >>> x) := sorry

theorem shl_or_disjoint_lshr_comm_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x)) fun a =>
      if 32 ≤ x.toNat then none else some ((x_2 ||| a) >>> x)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x)) fun a =>
      if 32 ≤ x.toNat then none else some ((a ||| x_2) >>> x) := sorry

theorem shl_xor_lshr_comm_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x)) fun a =>
      if 32 ≤ x.toNat then none else some ((x_2 ^^^ a) >>> x)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x)) fun a =>
      if 32 ≤ x.toNat then none else some ((a ^^^ x_2) >>> x) := sorry

theorem shl_and_lshr_comm_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x)) fun a =>
      if 32 ≤ x.toNat then none else some ((x_2 &&& a) >>> x)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x)) fun a =>
      if 32 ≤ x.toNat then none else some ((a &&& x_2) >>> x) := sorry

theorem mul_splat_fold_too_narrow_thm (x : _root_.BitVec 2) : (x * 2#2) >>> 1 = x := sorry

theorem negative_and_odd_thm (x : _root_.BitVec 32) : (x + x.sdiv 2#32 * 4294967294#32) >>> 31 = x >>> 31 &&& x := sorry

