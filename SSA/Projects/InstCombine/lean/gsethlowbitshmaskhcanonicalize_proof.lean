
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem shl_add_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a => some (a + 4294967295#32)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (4294967295#32 <<< x)) fun a => some (a ^^^ 4294967295#32) := sorry

theorem shl_add_nsw_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a => some (a + 4294967295#32)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (4294967295#32 <<< x)) fun a => some (a ^^^ 4294967295#32) := sorry

theorem shl_add_nuw_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a => some (a + 4294967295#32)) ⊑
    some 4294967295#32 := sorry

theorem shl_add_nsw_nuw_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a => some (a + 4294967295#32)) ⊑
    some 4294967295#32 := sorry

theorem shl_nsw_add_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a => some (a + 4294967295#32)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (4294967295#32 <<< x)) fun a => some (a ^^^ 4294967295#32) := sorry

theorem shl_nsw_add_nsw_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a => some (a + 4294967295#32)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (4294967295#32 <<< x)) fun a => some (a ^^^ 4294967295#32) := sorry

theorem shl_nsw_add_nuw_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a => some (a + 4294967295#32)) ⊑
    some 4294967295#32 := sorry

theorem shl_nsw_add_nsw_nuw_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a => some (a + 4294967295#32)) ⊑
    some 4294967295#32 := sorry

theorem shl_nuw_add_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a => some (a + 4294967295#32)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (4294967295#32 <<< x)) fun a => some (a ^^^ 4294967295#32) := sorry

theorem shl_nuw_add_nsw_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a => some (a + 4294967295#32)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (4294967295#32 <<< x)) fun a => some (a ^^^ 4294967295#32) := sorry

theorem shl_nuw_add_nuw_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a => some (a + 4294967295#32)) ⊑
    some 4294967295#32 := sorry

theorem shl_nuw_add_nsw_nuw_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a => some (a + 4294967295#32)) ⊑
    some 4294967295#32 := sorry

theorem shl_nsw_nuw_add_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a => some (a + 4294967295#32)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (4294967295#32 <<< x)) fun a => some (a ^^^ 4294967295#32) := sorry

theorem shl_nsw_nuw_add_nsw_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a => some (a + 4294967295#32)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (4294967295#32 <<< x)) fun a => some (a ^^^ 4294967295#32) := sorry

theorem shl_nsw_nuw_add_nuw_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a => some (a + 4294967295#32)) ⊑
    some 4294967295#32 := sorry

theorem shl_nsw_nuw_add_nsw_nuw_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a => some (a + 4294967295#32)) ⊑
    some 4294967295#32 := sorry

