import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem dec_mask_neg_i32_thm (x : _root_.BitVec 32) :
  4294967295#32 + (x * 4294967295#32 &&& x) = x + 4294967295#32 &&& (x ^^^ 4294967295#32) := sorry

theorem dec_mask_commute_neg_i32_thm (x : _root_.BitVec 32) :
  (Option.bind (if x = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x)) fun a =>
      Option.bind (if x = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x))
        fun a_1 => some (4294967295#32 + (a &&& a_1 * 4294967295#32))) ⊑
    Option.bind (if x = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x)) fun a =>
      Option.bind (if x = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x))
        fun a_1 => some (a + 4294967295#32 &&& (a_1 ^^^ 4294967295#32)) := sorry

theorem dec_commute_mask_neg_i32_thm (x : _root_.BitVec 32) :
  4294967295#32 + (4294967295#32 * x &&& x) = 4294967295#32 + x &&& (x ^^^ 4294967295#32) := sorry

