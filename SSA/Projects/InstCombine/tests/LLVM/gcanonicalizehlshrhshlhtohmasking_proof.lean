import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



theorem positive_samevar_thm (x x_1 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (x_1 >>> x)) fun a => if 8 ≤ x.toNat then none else some (a <<< x)) ⊑
    Option.bind (if 8 ≤ x.toNat then none else some (255#8 <<< x)) fun a => some (a &&& x_1) := by
  sorry

theorem positive_sameconst_thm (x : _root_.BitVec 8) : 
    x >>> 3 <<< 3 = x &&& 248#8 := by
  sorry

theorem positive_biggerlshr_thm (x : _root_.BitVec 8) : 
    x >>> 6 <<< 3 = x >>> 3 &&& 24#8 := by
  sorry

theorem positive_biggershl_thm (x : _root_.BitVec 8) : 
    x >>> 3 <<< 6 = x <<< 3 &&& 192#8 := by
  sorry

theorem positive_samevar_shlnuw_thm (x x_1 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (x_1 >>> x)) fun a => if 8 ≤ x.toNat then none else some (a <<< x)) ⊑
    Option.bind (if 8 ≤ x.toNat then none else some (255#8 <<< x)) fun a => some (a &&& x_1) := by
  sorry

theorem positive_sameconst_shlnuw_thm (x : _root_.BitVec 8) : 
    x >>> 3 <<< 3 = x &&& 248#8 := by
  sorry

theorem positive_biggerlshr_shlnuw_thm (x : _root_.BitVec 8) : 
    x >>> 6 <<< 3 = x >>> 3 &&& 24#8 := by
  sorry

theorem positive_biggershl_shlnuw_thm (x : _root_.BitVec 8) : 
    x >>> 3 <<< 6 = x <<< 3 &&& 192#8 := by
  sorry

theorem positive_samevar_shlnsw_thm (x x_1 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (x_1 >>> x)) fun a => if 8 ≤ x.toNat then none else some (a <<< x)) ⊑
    Option.bind (if 8 ≤ x.toNat then none else some (255#8 <<< x)) fun a => some (a &&& x_1) := by
  sorry

theorem positive_sameconst_shlnsw_thm (x : _root_.BitVec 8) : 
    x >>> 3 <<< 3 = x &&& 248#8 := by
  sorry

theorem positive_biggerlshr_shlnsw_thm (x : _root_.BitVec 8) : 
    x >>> 6 <<< 3 = x >>> 3 &&& 24#8 := by
  sorry

theorem positive_biggershl_shlnsw_thm (x : _root_.BitVec 8) : 
    x >>> 3 <<< 6 = x <<< 3 &&& 64#8 := by
  sorry

theorem positive_samevar_shlnuwnsw_thm (x x_1 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (x_1 >>> x)) fun a => if 8 ≤ x.toNat then none else some (a <<< x)) ⊑
    Option.bind (if 8 ≤ x.toNat then none else some (255#8 <<< x)) fun a => some (a &&& x_1) := by
  sorry

theorem positive_sameconst_shlnuwnsw_thm (x : _root_.BitVec 8) : 
    x >>> 3 <<< 3 = x &&& 248#8 := by
  sorry

theorem positive_biggerlshr_shlnuwnsw_thm (x : _root_.BitVec 8) : 
    x >>> 6 <<< 3 = x >>> 3 &&& 24#8 := by
  sorry

theorem positive_biggershl_shlnuwnsw_thm (x : _root_.BitVec 8) : 
    x >>> 3 <<< 6 = x <<< 3 &&& 64#8 := by
  sorry

theorem positive_samevar_lshrexact_thm (x x_1 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (x_1 >>> x)) fun a => if 8 ≤ x.toNat then none else some (a <<< x)) ⊑
    some x_1 := by
  sorry

theorem positive_sameconst_lshrexact_thm (x : _root_.BitVec 8) : 
    x >>> 3 <<< 3 = x := by
  sorry

theorem positive_biggerlshr_lshrexact_thm (x : _root_.BitVec 8) : 
    x >>> 6 <<< 3 = x >>> 3 := by
  sorry

theorem positive_biggershl_lshrexact_thm (x : _root_.BitVec 8) : 
    x >>> 3 <<< 6 = x <<< 3 := by
  sorry

theorem positive_samevar_shlnsw_lshrexact_thm (x x_1 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (x_1 >>> x)) fun a => if 8 ≤ x.toNat then none else some (a <<< x)) ⊑
    some x_1 := by
  sorry

theorem positive_sameconst_shlnsw_lshrexact_thm (x : _root_.BitVec 8) : 
    x >>> 3 <<< 3 = x := by
  sorry

theorem positive_biggerlshr_shlnsw_lshrexact_thm (x : _root_.BitVec 8) : 
    x >>> 6 <<< 3 = x >>> 3 := by
  sorry

theorem positive_biggershl_shlnsw_lshrexact_thm (x : _root_.BitVec 8) : 
    x >>> 3 <<< 6 = x <<< 3 := by
  sorry

theorem positive_samevar_shlnuw_lshrexact_thm (x x_1 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (x_1 >>> x)) fun a => if 8 ≤ x.toNat then none else some (a <<< x)) ⊑
    some x_1 := by
  sorry

theorem positive_sameconst_shlnuw_lshrexact_thm (x : _root_.BitVec 8) : 
    x >>> 3 <<< 3 = x := by
  sorry

theorem positive_biggerlshr_shlnuw_lshrexact_thm (x : _root_.BitVec 8) : 
    x >>> 6 <<< 3 = x >>> 3 := by
  sorry

theorem positive_biggershl_shlnuw_lshrexact_thm (x : _root_.BitVec 8) : 
    x >>> 3 <<< 6 = x <<< 3 := by
  sorry

theorem positive_samevar_shlnuwnsw_lshrexact_thm (x x_1 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (x_1 >>> x)) fun a => if 8 ≤ x.toNat then none else some (a <<< x)) ⊑
    some x_1 := by
  sorry

theorem positive_sameconst_shlnuwnsw_lshrexact_thm (x : _root_.BitVec 8) : 
    x >>> 3 <<< 3 = x := by
  sorry

theorem positive_biggerlshr_shlnuwnsw_lshrexact_thm (x : _root_.BitVec 8) : 
    x >>> 6 <<< 3 = x >>> 3 := by
  sorry

theorem positive_biggershl_shlnuwnsw_lshrexact_thm (x : _root_.BitVec 8) : 
    x >>> 3 <<< 6 = x <<< 3 := by
  sorry

