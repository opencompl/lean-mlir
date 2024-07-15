
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem test9_thm (x : _root_.BitVec 64) : x * 18446744073709551615#64 &&& 1#64 = x &&& 1#64 := sorry

theorem test10_thm (x : _root_.BitVec 64) :
  x * 18446744073709551615#64 + (x * 18446744073709551615#64 &&& 1#64) =
    18446744073709551615#64 * (x &&& 18446744073709551614#64) := sorry

theorem and1_lshr1_is_cmp_eq_0_thm (x : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (1#8 >>> x)) fun a => some (a &&& 1#8)) ⊑
    if 8 ≤ x.toNat then none else some (1#8 >>> x) := sorry

theorem and1_lshr1_is_cmp_eq_0_multiuse_thm (x : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (1#8 >>> x)) fun a =>
      Option.bind (if 8 ≤ x.toNat then none else some (1#8 >>> x)) fun a_1 => some (a + (a_1 &&& 1#8))) ⊑
    Option.bind (if 8 ≤ x.toNat then none else some (1#8 >>> x)) fun a => some (a <<< 1) := sorry

theorem test11_thm (x x_1 : _root_.BitVec 32) :
  x_1 <<< 8 * (x_1 <<< 8 + x &&& 128#32) = x_1 <<< 8 * (x &&& 128#32) := sorry

theorem test12_thm (x x_1 : _root_.BitVec 32) :
  x <<< 8 * (x_1 + x <<< 8 &&& 128#32) = x <<< 8 * (x_1 &&& 128#32) := sorry

theorem test13_thm (x x_1 : _root_.BitVec 32) :
  x <<< 8 * (x_1 + x <<< 8 * 4294967295#32 &&& 128#32) = x <<< 8 * (x_1 &&& 128#32) := sorry

theorem test14_thm (x x_1 : _root_.BitVec 32) :
  x_1 <<< 8 * (x_1 <<< 8 + x * 4294967295#32 &&& 128#32) = x_1 <<< 8 * (x * 4294967295#32 &&& 128#32) := sorry

