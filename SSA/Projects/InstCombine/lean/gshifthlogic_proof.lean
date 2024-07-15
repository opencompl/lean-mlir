import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem shl_and_thm (x x_1 : _root_.BitVec 8) : (x_1 <<< 3 &&& x) <<< 2 = x_1 <<< 5 &&& x <<< 2 := sorry

theorem shl_or_thm (x x_1 : _root_.BitVec 16) :
  (x_1 + x_1.sdiv 42#16 * 65494#16 ||| x <<< 5) <<< 7 = x <<< 12 ||| (x_1 + x_1.sdiv 42#16 * 65494#16) <<< 7 := sorry

theorem shl_xor_thm (x x_1 : _root_.BitVec 32) : (x_1 <<< 5 ^^^ x) <<< 7 = x_1 <<< 12 ^^^ x <<< 7 := sorry

theorem lshr_and_thm (x x_1 : _root_.BitVec 64) :
  (x_1 + x_1.sdiv 42#64 * 18446744073709551574#64 &&& x >>> 5) >>> 7 =
    x >>> 12 &&& (x_1 + x_1.sdiv 42#64 * 18446744073709551574#64) >>> 7 := sorry

theorem ashr_xor_thm (x x_1 : _root_.BitVec 32) :
  (x_1 + x_1.sdiv 42#32 * 4294967254#32 ^^^ x.sshiftRight 5).sshiftRight 7 =
    x.sshiftRight 12 ^^^ (x_1 + x_1.sdiv 42#32 * 4294967254#32).sshiftRight 7 := sorry

theorem ashr_overshift_xor_thm (x x_1 : _root_.BitVec 32) :
  (x_1 ^^^ x.sshiftRight 15).sshiftRight 17 = (x.sshiftRight 15 ^^^ x_1).sshiftRight 17 := sorry

theorem lshr_mul_thm (x : _root_.BitVec 64) : (x * 52#64) >>> 2 = x * 13#64 := sorry

theorem lshr_mul_nuw_nsw_thm (x : _root_.BitVec 64) : (x * 52#64) >>> 2 = x * 13#64 := sorry

theorem shl_add_thm (x x_1 : _root_.BitVec 8) : (x_1 <<< 3 + x) <<< 2 = x_1 <<< 5 + x <<< 2 := sorry

theorem shl_sub_thm (x x_1 : _root_.BitVec 8) : (x_1 <<< 3 + x * 255#8) <<< 2 = 255#8 * x <<< 2 + x_1 <<< 5 := sorry

theorem shl_sub_no_commute_thm (x x_1 : _root_.BitVec 8) : (x_1 + x <<< 3 * 255#8) <<< 2 = 255#8 * x <<< 5 + x_1 <<< 2 := sorry

