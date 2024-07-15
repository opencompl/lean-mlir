import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem add_or_sub_comb_i32_commuted1_nuw_thm (x : _root_.BitVec 32) : 
    x * 4294967295#32 ||| x = 0#32 := by
  sorry

theorem add_or_sub_comb_i8_commuted2_nsw_thm (x : _root_.BitVec 8) : 
    x ^ 2 + (x ^ 2 * 255#8 ||| x ^ 2) = x ^ 2 + 255#8 &&& x ^ 2 := by
  sorry

theorem add_or_sub_comb_i128_commuted3_nuw_nsw_thm (x : _root_.BitVec 128) :
  x ^ 2 ||| x ^ 2 * 340282366920938463463374607431768211455#128 = 0#128 := by
  sorry

theorem add_or_sub_comb_i64_commuted4_thm (x : _root_.BitVec 64) :
  x ^ 2 + (x ^ 2 ||| x ^ 2 * 18446744073709551615#64) = x ^ 2 + 18446744073709551615#64 &&& x ^ 2 := by
  sorry

