import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem positive_samevar_thm (x x_1 : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x)) fun a =>
      if 32 ≤ x.toNat then none else some (a >>> x)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (4294967295#32 >>> x)) fun a => some (a &&& x_1) := by
  sorry

theorem positive_sameconst_thm (x : _root_.BitVec 32) : 
    x <<< 5 >>> 5 = x &&& 134217727#32 := by
  sorry

theorem positive_biggerShl_thm (x : _root_.BitVec 32) : 
    x <<< 10 >>> 5 = x <<< 5 &&& 134217696#32 := by
  sorry

theorem positive_biggerLshr_thm (x : _root_.BitVec 32) : 
    x <<< 5 >>> 10 = x >>> 5 &&& 4194303#32 := by
  sorry

theorem positive_biggerLshr_lshrexact_thm (x : _root_.BitVec 32) : 
    x <<< 5 >>> 10 = x >>> 5 &&& 4194303#32 := by
  sorry

theorem positive_samevar_shlnuw_thm (x x_1 : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x)) fun a =>
      if 32 ≤ x.toNat then none else some (a >>> x)) ⊑
    some x_1 := by
  sorry

theorem positive_sameconst_shlnuw_thm (x : _root_.BitVec 32) : 
    x <<< 5 >>> 5 = x := by
  sorry

theorem positive_biggerShl_shlnuw_thm (x : _root_.BitVec 32) : 
    x <<< 10 >>> 5 = x <<< 5 := by
  sorry

theorem positive_biggerLshr_shlnuw_thm (x : _root_.BitVec 32) : 
    x <<< 5 >>> 10 = x >>> 5 := by
  sorry

theorem positive_biggerLshr_shlnuw_lshrexact_thm (x : _root_.BitVec 32) : 
    x <<< 5 >>> 10 = x >>> 5 := by
  sorry

