
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gcanonicalizehshlhlshrhtohmasking_proof
theorem positive_samevar_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some (x_1 <<< x.toNat)) fun a =>
      if 32#32 ≤ x then none else some (a >>> x.toNat)) ⊑
    Option.bind (if 32#32 ≤ x then none else some (4294967295#32 >>> x.toNat)) fun a => some (a &&& x_1) := by bv_compare'

theorem positive_sameconst_thm (x : BitVec 32) : x <<< 5 >>> 5 = x &&& 134217727#32 := by bv_compare'

theorem positive_biggerShl_thm (x : BitVec 32) : x <<< 10 >>> 5 = x <<< 5 &&& 134217696#32 := by bv_compare'

theorem positive_biggerLshr_thm (x : BitVec 32) : x <<< 5 >>> 10 = x >>> 5 &&& 4194303#32 := by bv_compare'

theorem positive_biggerLshr_lshrexact_thm (x : BitVec 32) : x <<< 5 >>> 10 = x >>> 5 &&& 4194303#32 := by bv_compare'

theorem positive_samevar_shlnuw_thm (x x_1 : BitVec 32) :
  ((if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a => if 32#32 ≤ x then none else some (a >>> x.toNat)) ⊑
    some x_1 := by bv_compare'

theorem positive_sameconst_shlnuw_thm (x : BitVec 32) :
  ((if x <<< 5 >>> 5 = x then none else some (x <<< 5)).bind fun x' => some (x' >>> 5)) ⊑ some x := by bv_compare'

theorem positive_biggerShl_shlnuw_thm (x : BitVec 32) :
  ((if x <<< 10 >>> 10 = x then none else some (x <<< 10)).bind fun x' => some (x' >>> 5)) ⊑
    if (x <<< 5).sshiftRight 5 = x then none else if x <<< 5 >>> 5 = x then none else some (x <<< 5) := by bv_compare'

theorem positive_biggerLshr_shlnuw_thm (x : BitVec 32) :
  ((if x <<< 5 >>> 5 = x then none else some (x <<< 5)).bind fun x' => some (x' >>> 10)) ⊑ some (x >>> 5) := by bv_compare'

theorem positive_biggerLshr_shlnuw_lshrexact_thm (x : BitVec 32) :
  ((if x <<< 5 >>> 5 = x then none else some (x <<< 5)).bind fun x' => some (x' >>> 10)) ⊑ some (x >>> 5) := by bv_compare'

