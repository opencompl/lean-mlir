import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem factorize_thm (x : _root_.BitVec 32) : 
    (x ||| 1#32) &&& (x ||| 2#32) = x := by
  sorry

theorem factorize2_thm (x : _root_.BitVec 32) : 
    3#32 * x + x * 4294967294#32 = x := by
  sorry

theorem factorize4_thm (x x_1 : _root_.BitVec 32) : 
    x_1 <<< 1 * x + x * x_1 * 4294967295#32 = x * x_1 := by
  sorry

theorem factorize5_thm (x x_1 : _root_.BitVec 32) : 
    x_1 * 2#32 * x + x_1 * x * 4294967295#32 = x_1 * x := by
  sorry

theorem expand_thm (x : _root_.BitVec 32) : 
    (x &&& 1#32 ||| 2#32) &&& 1#32 = x &&& 1#32 := by
  sorry

