
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem test_sdiv_canonicalize_op0_thm (x x_1 : _root_.BitVec 32) :
  (if x = 0#32 ∨ x_1 * 4294967295#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none
    else some ((x_1 * 4294967295#32).sdiv x)) ⊑
    Option.bind (if x = 0#32 ∨ x_1 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some (x_1.sdiv x)) fun a =>
      some (4294967295#32 * a) := sorry

theorem test_sdiv_canonicalize_op0_exact_thm (x x_1 : _root_.BitVec 32) :
  (if x = 0#32 ∨ x_1 * 4294967295#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none
    else some ((x_1 * 4294967295#32).sdiv x)) ⊑
    Option.bind (if x = 0#32 ∨ x_1 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some (x_1.sdiv x)) fun a =>
      some (4294967295#32 * a) := sorry

