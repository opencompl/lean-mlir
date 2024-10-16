
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gcanonicalizehlshrhshlhtohmasking_proof
theorem positive_samevar_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (x_1 >>> x.toNat)) fun a =>
      if 8#8 ≤ x then none else some (a <<< x.toNat)) ⊑
    (if (255#8 <<< x.toNat).sshiftRight x.toNat = 255#8 then none
        else if 8#8 ≤ x then none else some (255#8 <<< x.toNat)).bind
      fun a => some (a &&& x_1) := sorry

theorem positive_biggerlshr_thm (x : BitVec 8) : x >>> 6 <<< 3 = x >>> 3 &&& 24#8 := sorry

theorem positive_biggershl_thm (x : BitVec 8) : x >>> 3 <<< 6 = x <<< 3 &&& 192#8 := sorry

theorem positive_samevar_shlnuw_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (x_1 >>> x.toNat)) fun a =>
      if a <<< x.toNat >>> x.toNat = a then none else if 8#8 ≤ x then none else some (a <<< x.toNat)) ⊑
    (if (255#8 <<< x.toNat).sshiftRight x.toNat = 255#8 then none
        else if 8#8 ≤ x then none else some (255#8 <<< x.toNat)).bind
      fun a => some (a &&& x_1) := sorry

theorem positive_sameconst_shlnuw_thm (x : BitVec 8) :
  (if (x &&& 248#8) >>> 3 = x >>> 3 then none else some (x &&& 248#8)) ⊑ some (x &&& 248#8) := sorry

theorem positive_biggerlshr_shlnuw_thm (x : BitVec 8) :
  (if x >>> 6 <<< 3 >>> 3 = x >>> 6 then none else some (x >>> 6 <<< 3)) ⊑ some (x >>> 3 &&& 24#8) := sorry

theorem positive_biggershl_shlnuw_thm (x : BitVec 8) :
  (if x >>> 3 <<< 6 >>> 6 = x >>> 3 then none else some (x >>> 3 <<< 6)) ⊑
<<<<<<< HEAD
    (if x <<< 3 >>> 3 = x then none else some (x <<< 3)).bind fun x' => some (x' &&& 192#8) := sorry
=======
    (if x <<< 3 >>> 3 = x then none else some (x <<< 3)).bind fun a => some (a &&& 192#8) := sorry
>>>>>>> 43a49182 (re-ran scripts)

theorem positive_samevar_shlnsw_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (x_1 >>> x.toNat)) fun a =>
      if (a <<< x.toNat).sshiftRight x.toNat = a then none else if 8#8 ≤ x then none else some (a <<< x.toNat)) ⊑
    (if (255#8 <<< x.toNat).sshiftRight x.toNat = 255#8 then none
        else if 8#8 ≤ x then none else some (255#8 <<< x.toNat)).bind
      fun a => some (a &&& x_1) := sorry

theorem positive_sameconst_shlnsw_thm (x : BitVec 8) :
  (if (x &&& 248#8).sshiftRight 3 = x >>> 3 then none else some (x &&& 248#8)) ⊑ some (x &&& 248#8) := sorry

theorem positive_biggerlshr_shlnsw_thm (x : BitVec 8) :
  (if (x >>> 6 <<< 3).sshiftRight 3 = x >>> 6 then none else some (x >>> 6 <<< 3)) ⊑ some (x >>> 3 &&& 24#8) := sorry

theorem positive_biggershl_shlnsw_thm (x : BitVec 8) :
  (if (x >>> 3 <<< 6).sshiftRight 6 = x >>> 3 then none else some (x >>> 3 <<< 6)) ⊑
<<<<<<< HEAD
    (if (x <<< 3).sshiftRight 3 = x then none else if x <<< 3 >>> 3 = x then none else some (x <<< 3)).bind fun x' =>
      some (x' &&& 64#8) := sorry
=======
    (if (x <<< 3).sshiftRight 3 = x then none else if x <<< 3 >>> 3 = x then none else some (x <<< 3)).bind fun a =>
      some (a &&& 64#8) := sorry
>>>>>>> 43a49182 (re-ran scripts)

theorem positive_samevar_shlnuwnsw_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (x_1 >>> x.toNat)) fun a =>
      if (a <<< x.toNat).sshiftRight x.toNat = a then none
      else if a <<< x.toNat >>> x.toNat = a then none else if 8#8 ≤ x then none else some (a <<< x.toNat)) ⊑
    (if (255#8 <<< x.toNat).sshiftRight x.toNat = 255#8 then none
        else if 8#8 ≤ x then none else some (255#8 <<< x.toNat)).bind
      fun a => some (a &&& x_1) := sorry

theorem positive_sameconst_shlnuwnsw_thm (x : BitVec 8) :
  (if (x &&& 248#8).sshiftRight 3 = x >>> 3 then none
    else if (x &&& 248#8) >>> 3 = x >>> 3 then none else some (x &&& 248#8)) ⊑
    some (x &&& 248#8) := sorry

theorem positive_biggerlshr_shlnuwnsw_thm (x : BitVec 8) :
  (if (x >>> 6 <<< 3).sshiftRight 3 = x >>> 6 then none
    else if x >>> 6 <<< 3 >>> 3 = x >>> 6 then none else some (x >>> 6 <<< 3)) ⊑
    some (x >>> 3 &&& 24#8) := sorry

theorem positive_biggershl_shlnuwnsw_thm (x : BitVec 8) :
  (if (x >>> 3 <<< 6).sshiftRight 6 = x >>> 3 then none
    else if x >>> 3 <<< 6 >>> 6 = x >>> 3 then none else some (x >>> 3 <<< 6)) ⊑
<<<<<<< HEAD
    (if (x <<< 3).sshiftRight 3 = x then none else if x <<< 3 >>> 3 = x then none else some (x <<< 3)).bind fun x' =>
      some (x' &&& 64#8) := sorry
=======
    (if (x <<< 3).sshiftRight 3 = x then none else if x <<< 3 >>> 3 = x then none else some (x <<< 3)).bind fun a =>
      some (a &&& 64#8) := sorry
>>>>>>> 43a49182 (re-ran scripts)

theorem positive_samevar_lshrexact_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (x_1 >>> x.toNat)) fun a =>
      if 8#8 ≤ x then none else some (a <<< x.toNat)) ⊑
    some x_1 := sorry

theorem positive_sameconst_lshrexact_thm (x : BitVec 8) : x &&& 248#8 = x := sorry

theorem positive_biggerlshr_lshrexact_thm (x : BitVec 8) : x >>> 6 <<< 3 = x >>> 3 := sorry

theorem positive_biggershl_lshrexact_thm (x : BitVec 8) : x >>> 3 <<< 6 = x <<< 3 := sorry

theorem positive_samevar_shlnsw_lshrexact_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (x_1 >>> x.toNat)) fun a =>
      if (a <<< x.toNat).sshiftRight x.toNat = a then none else if 8#8 ≤ x then none else some (a <<< x.toNat)) ⊑
    some x_1 := sorry

theorem positive_sameconst_shlnsw_lshrexact_thm (x : BitVec 8) :
  (if (x &&& 248#8).sshiftRight 3 = x >>> 3 then none else some (x &&& 248#8)) ⊑ some x := sorry

theorem positive_biggerlshr_shlnsw_lshrexact_thm (x : BitVec 8) :
  (if (x >>> 6 <<< 3).sshiftRight 3 = x >>> 6 then none else some (x >>> 6 <<< 3)) ⊑ some (x >>> 3) := sorry

theorem positive_biggershl_shlnsw_lshrexact_thm (x : BitVec 8) :
  (if (x >>> 3 <<< 6).sshiftRight 6 = x >>> 3 then none else some (x >>> 3 <<< 6)) ⊑
    if (x <<< 3).sshiftRight 3 = x then none else if x <<< 3 >>> 3 = x then none else some (x <<< 3) := sorry

theorem positive_samevar_shlnuw_lshrexact_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (x_1 >>> x.toNat)) fun a =>
      if a <<< x.toNat >>> x.toNat = a then none else if 8#8 ≤ x then none else some (a <<< x.toNat)) ⊑
    some x_1 := sorry

theorem positive_sameconst_shlnuw_lshrexact_thm (x : BitVec 8) :
  (if (x &&& 248#8) >>> 3 = x >>> 3 then none else some (x &&& 248#8)) ⊑ some x := sorry

theorem positive_biggerlshr_shlnuw_lshrexact_thm (x : BitVec 8) :
  (if x >>> 6 <<< 3 >>> 3 = x >>> 6 then none else some (x >>> 6 <<< 3)) ⊑ some (x >>> 3) := sorry

theorem positive_biggershl_shlnuw_lshrexact_thm (x : BitVec 8) :
  (if x >>> 3 <<< 6 >>> 6 = x >>> 3 then none else some (x >>> 3 <<< 6)) ⊑
    if x <<< 3 >>> 3 = x then none else some (x <<< 3) := sorry

theorem positive_samevar_shlnuwnsw_lshrexact_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (x_1 >>> x.toNat)) fun a =>
      if (a <<< x.toNat).sshiftRight x.toNat = a then none
      else if a <<< x.toNat >>> x.toNat = a then none else if 8#8 ≤ x then none else some (a <<< x.toNat)) ⊑
    some x_1 := sorry

theorem positive_sameconst_shlnuwnsw_lshrexact_thm (x : BitVec 8) :
  (if (x &&& 248#8).sshiftRight 3 = x >>> 3 then none
    else if (x &&& 248#8) >>> 3 = x >>> 3 then none else some (x &&& 248#8)) ⊑
    some x := sorry

theorem positive_biggerlshr_shlnuwnsw_lshrexact_thm (x : BitVec 8) :
  (if (x >>> 6 <<< 3).sshiftRight 3 = x >>> 6 then none
    else if x >>> 6 <<< 3 >>> 3 = x >>> 6 then none else some (x >>> 6 <<< 3)) ⊑
    some (x >>> 3) := sorry

theorem positive_biggershl_shlnuwnsw_lshrexact_thm (x : BitVec 8) :
  (if (x >>> 3 <<< 6).sshiftRight 6 = x >>> 3 then none
    else if x >>> 3 <<< 6 >>> 6 = x >>> 3 then none else some (x >>> 3 <<< 6)) ⊑
    if (x <<< 3).sshiftRight 3 = x then none else if x <<< 3 >>> 3 = x then none else some (x <<< 3) := sorry

