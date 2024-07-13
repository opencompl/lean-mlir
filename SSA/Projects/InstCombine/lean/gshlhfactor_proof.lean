
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem add_shl_same_amount_thm (x x_1 x_2 : _root_.BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1)) fun a_1 => some (a + a_1)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 + x) <<< x_1) := sorry

theorem add_shl_same_amount_nuw_thm (x x_1 x_2 : _root_.BitVec 64) :
  (Option.bind (if 64 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 64 ≤ x_1.toNat then none else some (x <<< x_1)) fun a_1 => some (a + a_1)) ⊑
    if 64 ≤ x_1.toNat then none else some ((x_2 + x) <<< x_1) := sorry

theorem add_shl_same_amount_partial_nsw1_thm (x x_1 x_2 : _root_.BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1)) fun a_1 => some (a + a_1)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 + x) <<< x_1) := sorry

theorem add_shl_same_amount_partial_nsw2_thm (x x_1 x_2 : _root_.BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1)) fun a_1 => some (a + a_1)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 + x) <<< x_1) := sorry

theorem add_shl_same_amount_partial_nuw1_thm (x x_1 x_2 : _root_.BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1)) fun a_1 => some (a + a_1)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 + x) <<< x_1) := sorry

theorem add_shl_same_amount_partial_nuw2_thm (x x_1 x_2 : _root_.BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1)) fun a_1 => some (a + a_1)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 + x) <<< x_1) := sorry

theorem sub_shl_same_amount_thm (x x_1 x_2 : _root_.BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1)) fun a_1 => some (a + a_1 * 63#6)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 - x) <<< x_1) := sorry

theorem sub_shl_same_amount_nuw_thm (x x_1 x_2 : _root_.BitVec 64) :
  (Option.bind (if 64 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 64 ≤ x_1.toNat then none else some (x <<< x_1)) fun a_1 =>
        some (a + a_1 * 18446744073709551615#64)) ⊑
    if 64 ≤ x_1.toNat then none else some ((x_2 - x) <<< x_1) := sorry

theorem sub_shl_same_amount_partial_nsw1_thm (x x_1 x_2 : _root_.BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1)) fun a_1 => some (a + a_1 * 63#6)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 - x) <<< x_1) := sorry

theorem sub_shl_same_amount_partial_nsw2_thm (x x_1 x_2 : _root_.BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1)) fun a_1 => some (a + a_1 * 63#6)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 - x) <<< x_1) := sorry

theorem sub_shl_same_amount_partial_nuw1_thm (x x_1 x_2 : _root_.BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1)) fun a_1 => some (a + a_1 * 63#6)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 - x) <<< x_1) := sorry

theorem sub_shl_same_amount_partial_nuw2_thm (x x_1 x_2 : _root_.BitVec 6) :
  (Option.bind (if 6 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 6 ≤ x_1.toNat then none else some (x <<< x_1)) fun a_1 => some (a + a_1 * 63#6)) ⊑
    if 6 ≤ x_1.toNat then none else some ((x_2 - x) <<< x_1) := sorry

