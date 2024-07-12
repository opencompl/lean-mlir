
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem test_with_even_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (4#32 <<< x)) fun a => some (a &&& 1#32)) ⊑ some 0#32 := sorry

theorem test_with_neg_even_thm (x : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (4294967292#32 <<< x)) fun a => some (a &&& 1#32)) ⊑
    some 0#32 := sorry

theorem test2_thm (x : _root_.BitVec 32) : x &&& 4294967295#32 = x := sorry

theorem test7_thm (x : _root_.BitVec 32) : x &&& (x ^^^ 4294967295#32) = 0#32 := sorry

theorem test8_thm (x : _root_.BitVec 8) : x &&& 3#8 &&& 4#8 = 0#8 := sorry

theorem test10_thm (x : _root_.BitVec 32) : (x &&& 12#32 ^^^ 15#32) &&& 1#32 = 1#32 := sorry

theorem test15_thm (x : _root_.BitVec 8) : x >>> 7 &&& 2#8 = 0#8 := sorry

theorem test16_thm (x : _root_.BitVec 8) : x <<< 2 &&& 3#8 = 0#8 := sorry

theorem test19_thm (x : _root_.BitVec 32) : x <<< 3 &&& 4294967294#32 = x <<< 3 := sorry

theorem test20_thm (x : _root_.BitVec 8) : x >>> 7 &&& 1#8 = x >>> 7 := sorry

theorem test27_thm (x : _root_.BitVec 8) : 16#8 + ((x &&& 4#8) + 240#8 &&& 240#8) = 0#8 := sorry

theorem ashr_lowmask_thm (x : _root_.BitVec 32) : x.sshiftRight 24 &&& 255#32 = x >>> 24 := sorry

theorem test32_thm (x : _root_.BitVec 32) : (x &&& 16#32) >>> 2 &&& 1#32 = 0#32 := sorry

theorem test33_thm (x : _root_.BitVec 32) : x &&& 4294967294#32 ||| x &&& 1#32 ^^^ 1#32 = x ^^^ 1#32 := sorry

theorem test33b_thm (x : _root_.BitVec 32) : x &&& 1#32 ^^^ 1#32 ||| x &&& 4294967294#32 = x ^^^ 1#32 := sorry

theorem test42_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32 ^^^ x_1 * x) &&& (x_2 ||| x_1 * x) = x_1 * x &&& x_2 := sorry

theorem test43_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ||| x_1 * x) &&& (x_2 ^^^ 4294967295#32 ^^^ x_1 * x) = x_1 * x &&& x_2 := sorry

theorem test44_thm (x x_1 : _root_.BitVec 32) : (x_1 ^^^ 4294967295#32 ||| x) &&& x_1 = x &&& x_1 := sorry

theorem test45_thm (x x_1 : _root_.BitVec 32) : (x_1 ||| x ^^^ 4294967295#32) &&& x = x_1 &&& x := sorry

theorem test46_thm (x x_1 : _root_.BitVec 32) : x_1 &&& (x_1 ^^^ 4294967295#32 ||| x) = x &&& x_1 := sorry

theorem test47_thm (x x_1 : _root_.BitVec 32) : x_1 &&& (x ||| x_1 ^^^ 4294967295#32) = x &&& x_1 := sorry

theorem lowmask_add_2_thm (x : _root_.BitVec 8) : x + 192#8 &&& 63#8 = x &&& 63#8 := sorry

theorem flip_masked_bit_thm (x : _root_.BitVec 8) : x + 16#8 &&& 16#8 = x &&& 16#8 ^^^ 16#8 := sorry

theorem shl_lshr_pow2_const_negative_overflow1_thm (x : _root_.BitVec 16) :
  (Option.bind (if 16 ≤ x.toNat then none else some (4096#16 <<< x)) fun a => some (a >>> 6 &&& 8#16)) ⊑
    some 0#16 := sorry

theorem shl_lshr_pow2_const_negative_overflow2_thm (x : _root_.BitVec 16) :
  (Option.bind (if 16 ≤ x.toNat then none else some (8#16 <<< x)) fun a => some (a >>> 6 &&& 32768#16)) ⊑
    some 0#16 := sorry

theorem lshr_lshr_pow2_const_negative_nopow2_1_thm (x : _root_.BitVec 16) :
  (Option.bind (if 16 ≤ x.toNat then none else some (2047#16 >>> x)) fun a => some (a >>> 6 &&& 4#16)) ⊑
    Option.bind (if 16 ≤ x.toNat then none else some (31#16 >>> x)) fun a => some (a &&& 4#16) := sorry

theorem lshr_lshr_pow2_const_negative_nopow2_2_thm (x : _root_.BitVec 16) :
  (Option.bind (if 16 ≤ x.toNat then none else some (8192#16 >>> x)) fun a => some (a >>> 6 &&& 3#16)) ⊑
    Option.bind (if 16 ≤ x.toNat then none else some (128#16 >>> x)) fun a => some (a &&& 3#16) := sorry

theorem lshr_lshr_pow2_const_negative_overflow_thm (x : _root_.BitVec 16) :
  (Option.bind (if 16 ≤ x.toNat then none else some (32768#16 >>> x)) fun a => some (a >>> 15 &&& 4#16)) ⊑
    some 0#16 := sorry

theorem lshr_shl_pow2_const_overflow_thm (x : _root_.BitVec 16) :
  (Option.bind (if 16 ≤ x.toNat then none else some (8192#16 >>> x)) fun a => some (a <<< 6 &&& 32#16)) ⊑
    some 0#16 := sorry

theorem add_constant_equal_with_the_top_bit_of_demandedbits_pass_thm (x : _root_.BitVec 32) : x + 16#32 &&& 24#32 = x &&& 24#32 ^^^ 16#32 := sorry

theorem add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_thm (x x_1 : _root_.BitVec 32) :
  (x_1 + 16#32 ||| x) &&& 24#32 = (x_1 ^^^ 16#32 ||| x) &&& 24#32 := sorry

