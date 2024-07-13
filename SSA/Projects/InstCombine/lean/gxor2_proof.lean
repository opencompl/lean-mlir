
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem test2_thm (x : _root_.BitVec 32) : (x &&& 32#32) + 145#32 ^^^ 153#32 = x &&& 32#32 ||| 8#32 := sorry

theorem test3_thm (x : _root_.BitVec 32) : (x ||| 145#32) &&& 177#32 ^^^ 153#32 = x &&& 32#32 ||| 8#32 := sorry

theorem test5_thm (x : _root_.BitVec 32) : (x ^^^ 1234#32) >>> 8 ^^^ 1#32 = x >>> 8 ^^^ 5#32 := sorry

theorem test6_thm (x : _root_.BitVec 32) : (x ^^^ 1234#32) >>> 16 = x >>> 16 := sorry

theorem test7_thm (x x_1 : _root_.BitVec 32) :
  (x_1 ||| x) ^^^ (x_1 ^^^ 4294967295#32) = x ^^^ 4294967295#32 ||| x_1 := sorry

theorem test8_thm (x x_1 : _root_.BitVec 32) :
  x_1 ^^^ 4294967295#32 ^^^ (x_1 ||| x) = x ^^^ 4294967295#32 ||| x_1 := sorry

theorem test12_thm (x x_1 : _root_.BitVec 32) :
  x_1 &&& (x ^^^ 4294967295#32) ^^^ (x_1 ^^^ 4294967295#32) = x_1 &&& x ^^^ 4294967295#32 := sorry

theorem test12commuted_thm (x x_1 : _root_.BitVec 32) :
  (x_1 ^^^ 4294967295#32) &&& x ^^^ (x ^^^ 4294967295#32) = x &&& x_1 ^^^ 4294967295#32 := sorry

theorem test13_thm (x x_1 : _root_.BitVec 32) :
  x_1 ^^^ 4294967295#32 ^^^ x_1 &&& (x ^^^ 4294967295#32) = x_1 &&& x ^^^ 4294967295#32 := sorry

theorem test13commuted_thm (x x_1 : _root_.BitVec 32) :
  x_1 ^^^ 4294967295#32 ^^^ (x ^^^ 4294967295#32) &&& x_1 = x_1 &&& x ^^^ 4294967295#32 := sorry

theorem xor_or_xor_common_op_commute1_thm (x x_1 x_2 : _root_.BitVec 32) :
  x_2 ^^^ x_1 ^^^ (x_2 ||| x) = (x_2 ^^^ 4294967295#32) &&& x ^^^ x_1 := sorry

theorem xor_or_xor_common_op_commute2_thm (x x_1 x_2 : _root_.BitVec 32) :
  x_2 ^^^ x_1 ^^^ (x_1 ||| x) = (x_1 ^^^ 4294967295#32) &&& x ^^^ x_2 := sorry

theorem xor_or_xor_common_op_commute3_thm (x x_1 x_2 : _root_.BitVec 32) :
  x_2 ^^^ x_1 ^^^ (x ||| x_2) = (x_2 ^^^ 4294967295#32) &&& x ^^^ x_1 := sorry

theorem xor_or_xor_common_op_commute4_thm (x x_1 x_2 : _root_.BitVec 32) :
  x_2 ^^^ x_1 ^^^ (x ||| x_1) = (x_1 ^^^ 4294967295#32) &&& x ^^^ x_2 := sorry

theorem xor_or_xor_common_op_commute5_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ||| x_1) ^^^ (x_2 ^^^ x) = (x_2 ^^^ 4294967295#32) &&& x_1 ^^^ x := sorry

theorem xor_or_xor_common_op_commute6_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ||| x_1) ^^^ (x ^^^ x_2) = (x_2 ^^^ 4294967295#32) &&& x_1 ^^^ x := sorry

theorem xor_or_xor_common_op_commute7_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ||| x_1) ^^^ (x_1 ^^^ x) = (x_1 ^^^ 4294967295#32) &&& x_2 ^^^ x := sorry

theorem xor_or_xor_common_op_commute8_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ||| x_1) ^^^ (x ^^^ x_1) = (x_1 ^^^ 4294967295#32) &&& x_2 ^^^ x := sorry

theorem test15_thm (x x_1 : _root_.BitVec 8) :
  ((x_1 ^^^ x) &&& (x ^^^ 33#8 ^^^ x_1)) * (x ^^^ 33#8 ^^^ x_1) =
    ((x_1 ^^^ x) &&& (x ^^^ x_1 ^^^ 33#8)) * (x ^^^ x_1 ^^^ 33#8) := sorry

theorem test16_thm (x x_1 : _root_.BitVec 8) :
  ((x_1 ^^^ 33#8 ^^^ x) &&& (x ^^^ x_1)) * (x_1 ^^^ 33#8 ^^^ x) =
    ((x_1 ^^^ x ^^^ 33#8) &&& (x ^^^ x_1)) * (x_1 ^^^ x ^^^ 33#8) := sorry

theorem not_xor_to_or_not1_thm (x x_1 x_2 : _root_.BitVec 3) :
  x_2 &&& x_1 ^^^ (x ||| x_1) ^^^ 7#3 = x_2 &&& x_1 ||| (x ||| x_1) ^^^ 7#3 := sorry

theorem not_xor_to_or_not2_thm (x x_1 x_2 : _root_.BitVec 3) :
  x_2 &&& x_1 ^^^ (x_1 ||| x) ^^^ 7#3 = x_2 &&& x_1 ||| (x_1 ||| x) ^^^ 7#3 := sorry

theorem not_xor_to_or_not3_thm (x x_1 x_2 : _root_.BitVec 3) :
  x_2 &&& x_1 ^^^ (x_2 ||| x) ^^^ 7#3 = x_2 &&& x_1 ||| (x_2 ||| x) ^^^ 7#3 := sorry

theorem not_xor_to_or_not4_thm (x x_1 x_2 : _root_.BitVec 3) :
  x_2 &&& x_1 ^^^ (x ||| x_2) ^^^ 7#3 = x_2 &&& x_1 ||| (x ||| x_2) ^^^ 7#3 := sorry

theorem xor_notand_to_or_not1_thm (x x_1 x_2 : _root_.BitVec 3) :
  x_2 &&& x_1 ^^^ 7#3 ^^^ (x ||| x_1) = x_2 &&& x_1 ||| (x ||| x_1) ^^^ 7#3 := sorry

theorem xor_notand_to_or_not2_thm (x x_1 x_2 : _root_.BitVec 3) :
  x_2 &&& x_1 ^^^ 7#3 ^^^ (x_1 ||| x) = x_2 &&& x_1 ||| (x_1 ||| x) ^^^ 7#3 := sorry

theorem xor_notand_to_or_not3_thm (x x_1 x_2 : _root_.BitVec 3) :
  x_2 &&& x_1 ^^^ 7#3 ^^^ (x_2 ||| x) = x_2 &&& x_1 ||| (x_2 ||| x) ^^^ 7#3 := sorry

theorem xor_notand_to_or_not4_thm (x x_1 x_2 : _root_.BitVec 3) :
  x_2 &&& x_1 ^^^ 7#3 ^^^ (x ||| x_2) = x_2 &&& x_1 ||| (x ||| x_2) ^^^ 7#3 := sorry

