import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem sub_to_xor_thm (x x_1 : _root_.BitVec 32) : 
    (x_1 ||| x) + (x_1 &&& x) * 4294967295#32 = x_1 ^^^ x := by
  sorry

theorem sub_to_xor_or_commuted_thm (x x_1 : _root_.BitVec 32) : 
    (x_1 ||| x) + (x &&& x_1) * 4294967295#32 = x ^^^ x_1 := by
  sorry

theorem sub_to_xor_and_commuted_thm (x x_1 : _root_.BitVec 32) : 
    (x_1 ||| x) + (x &&& x_1) * 4294967295#32 = x ^^^ x_1 := by
  sorry

