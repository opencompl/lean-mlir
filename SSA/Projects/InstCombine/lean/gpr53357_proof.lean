
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem src_thm (x x_1 : _root_.BitVec 32) :
  (x_1 &&& x) + ((x_1 ||| x) ^^^ 4294967295#32) = x_1 ^^^ x ^^^ 4294967295#32 := sorry

theorem src2_thm (x x_1 : _root_.BitVec 32) :
  (x_1 &&& x) + ((x ||| x_1) ^^^ 4294967295#32) = x_1 ^^^ x ^^^ 4294967295#32 := sorry

theorem src3_thm (x x_1 : _root_.BitVec 32) :
  (x_1 &&& x) + ((x ^^^ 4294967295#32) &&& (x_1 ^^^ 4294967295#32)) = x_1 ^^^ x ^^^ 4294967295#32 := sorry

theorem src4_thm (x x_1 : _root_.BitVec 32) :
  (x_1 &&& x) + ((x ||| x_1) ^^^ 4294967295#32) = x_1 ^^^ x ^^^ 4294967295#32 := sorry

theorem src5_thm (x x_1 : _root_.BitVec 32) :
  ((x_1 ||| x) ^^^ 4294967295#32) + (x_1 &&& x) = x_1 ^^^ x ^^^ 4294967295#32 := sorry

