
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gcanonicalizehshlhlshrhtohmasking_proof
theorem positive_samevar_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x.toNat)) fun a =>
      if 32 ≤ x.toNat then none else some (a >>> x.toNat)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (4294967295#32 >>> x.toNat)) fun a => some (a &&& x_1) := sorry

theorem positive_sameconst_thm (x : BitVec 32) : x <<< 5 >>> 5 = x &&& 134217727#32 := sorry

theorem positive_biggerShl_thm (x : BitVec 32) : x <<< 10 >>> 5 = x <<< 5 &&& 134217696#32 := sorry

theorem positive_biggerLshr_thm (x : BitVec 32) : x <<< 5 >>> 10 = x >>> 5 &&& 4194303#32 := sorry

theorem positive_biggerLshr_lshrexact_thm (x : BitVec 32) : x <<< 5 >>> 10 = x >>> 5 &&& 4194303#32 := sorry

theorem positive_samevar_shlnuw_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (x_1 <<< x.toNat)) fun a =>
      if 32 ≤ x.toNat then none else some (a >>> x.toNat)) ⊑
    some x_1 := sorry

theorem positive_sameconst_shlnuw_thm (x : BitVec 32) : x <<< 5 >>> 5 = x := sorry

theorem positive_biggerShl_shlnuw_thm (x : BitVec 32) : x <<< 10 >>> 5 = x <<< 5 := sorry

theorem positive_biggerLshr_shlnuw_thm (x : BitVec 32) : x <<< 5 >>> 10 = x >>> 5 := sorry

theorem positive_biggerLshr_shlnuw_lshrexact_thm (x : BitVec 32) : x <<< 5 >>> 10 = x >>> 5 := sorry

