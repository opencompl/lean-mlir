import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem not_ashr_not_thm (x x_1 : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some ((x_1 ^^^ 4294967295#32).sshiftRight x.toNat)) fun a =>
      some (a ^^^ 4294967295#32)) ⊑
    if 32 ≤ x.toNat then none else some (x_1.sshiftRight x.toNat) := by
  sorry

theorem not_ashr_const_thm (x : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some ((214#8).sshiftRight x.toNat)) fun a => some (a ^^^ 255#8)) ⊑
    if 8 ≤ x.toNat then none else some (41#8 >>> x) := by
  sorry

theorem not_lshr_const_thm (x : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (42#8 >>> x)) fun a => some (a ^^^ 255#8)) ⊑
    if 8 ≤ x.toNat then none else some ((213#8).sshiftRight x.toNat) := by
  sorry

theorem not_sub_thm (x : _root_.BitVec 32) : 
    123#32 + x * 4294967295#32 ^^^ 4294967295#32 = x + 4294967172#32 := by
  sorry

theorem not_add_thm (x : _root_.BitVec 32) : 
    x + 123#32 ^^^ 4294967295#32 = x * 4294967295#32 + 4294967172#32 := by
  sorry

theorem not_or_neg_thm (x x_1 : _root_.BitVec 8) : 
    (x_1 * 255#8 ||| x) ^^^ 255#8 = x_1 + 255#8 &&& (x ^^^ 255#8) := by
  sorry

