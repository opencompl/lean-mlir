
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gcanonicalizehashrhshlhtohmasking_proof
theorem positive_samevar_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (x_1.sshiftRight x.toNat)) fun a =>
      if 8 ≤ x.toNat then none else some (a <<< x.toNat)) ⊑
    Option.bind (if 8 ≤ x.toNat then none else some (255#8 <<< x.toNat)) fun a => some (a &&& x_1) := sorry

theorem positive_sameconst_thm (x : BitVec 8) : x.sshiftRight 3 <<< 3 = x &&& 248#8 := sorry

theorem positive_biggerashr_thm (x : BitVec 8) : x.sshiftRight 6 <<< 3 = x.sshiftRight 3 &&& 248#8 := sorry

theorem positive_biggershl_thm (x : BitVec 8) : x.sshiftRight 3 <<< 6 = x <<< 3 &&& 192#8 := sorry

theorem positive_samevar_shlnuw_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (x_1.sshiftRight x.toNat)) fun a =>
      if 8 ≤ x.toNat then none else some (a <<< x.toNat)) ⊑
    Option.bind (if 8 ≤ x.toNat then none else some (255#8 <<< x.toNat)) fun a => some (a &&& x_1) := sorry

theorem positive_sameconst_shlnuw_thm (x : BitVec 8) : x.sshiftRight 3 <<< 3 = x &&& 248#8 := sorry

theorem positive_biggerashr_shlnuw_thm (x : BitVec 8) : x.sshiftRight 6 <<< 3 = x.sshiftRight 3 &&& 248#8 := sorry

theorem positive_biggershl_shlnuw_thm (x : BitVec 8) : x.sshiftRight 3 <<< 6 = x <<< 3 &&& 192#8 := sorry

theorem positive_samevar_shlnsw_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (x_1.sshiftRight x.toNat)) fun a =>
      if 8 ≤ x.toNat then none else some (a <<< x.toNat)) ⊑
    Option.bind (if 8 ≤ x.toNat then none else some (255#8 <<< x.toNat)) fun a => some (a &&& x_1) := sorry

theorem positive_sameconst_shlnsw_thm (x : BitVec 8) : x.sshiftRight 3 <<< 3 = x &&& 248#8 := sorry

theorem positive_biggerashr_shlnsw_thm (x : BitVec 8) : x.sshiftRight 6 <<< 3 = x.sshiftRight 3 &&& 248#8 := sorry

theorem positive_biggershl_shlnsw_thm (x : BitVec 8) : x.sshiftRight 3 <<< 6 = x <<< 3 &&& 192#8 := sorry

theorem positive_samevar_shlnuwnsw_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (x_1.sshiftRight x.toNat)) fun a =>
      if 8 ≤ x.toNat then none else some (a <<< x.toNat)) ⊑
    Option.bind (if 8 ≤ x.toNat then none else some (255#8 <<< x.toNat)) fun a => some (a &&& x_1) := sorry

theorem positive_sameconst_shlnuwnsw_thm (x : BitVec 8) : x.sshiftRight 3 <<< 3 = x &&& 248#8 := sorry

theorem positive_biggerashr_shlnuwnsw_thm (x : BitVec 8) : x.sshiftRight 6 <<< 3 = x.sshiftRight 3 &&& 248#8 := sorry

theorem positive_biggershl_shlnuwnsw_thm (x : BitVec 8) : x.sshiftRight 3 <<< 6 = x <<< 3 &&& 64#8 := sorry

theorem positive_samevar_ashrexact_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (x_1.sshiftRight x.toNat)) fun a =>
      if 8 ≤ x.toNat then none else some (a <<< x.toNat)) ⊑
    some x_1 := sorry

theorem positive_sameconst_ashrexact_thm (x : BitVec 8) : x.sshiftRight 3 <<< 3 = x := sorry

theorem positive_biggerashr_ashrexact_thm (x : BitVec 8) : x.sshiftRight 6 <<< 3 = x.sshiftRight 3 := sorry

theorem positive_biggershl_ashrexact_thm (x : BitVec 8) : x.sshiftRight 3 <<< 6 = x <<< 3 := sorry

theorem positive_samevar_shlnsw_ashrexact_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (x_1.sshiftRight x.toNat)) fun a =>
      if 8 ≤ x.toNat then none else some (a <<< x.toNat)) ⊑
    some x_1 := sorry

theorem positive_sameconst_shlnsw_ashrexact_thm (x : BitVec 8) : x.sshiftRight 3 <<< 3 = x := sorry

theorem positive_biggerashr_shlnsw_ashrexact_thm (x : BitVec 8) : x.sshiftRight 6 <<< 3 = x.sshiftRight 3 := sorry

theorem positive_biggershl_shlnsw_ashrexact_thm (x : BitVec 8) : x.sshiftRight 3 <<< 6 = x <<< 3 := sorry

theorem positive_samevar_shlnuw_ashrexact_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (x_1.sshiftRight x.toNat)) fun a =>
      if 8 ≤ x.toNat then none else some (a <<< x.toNat)) ⊑
    some x_1 := sorry

theorem positive_sameconst_shlnuw_ashrexact_thm (x : BitVec 8) : x.sshiftRight 3 <<< 3 = x := sorry

theorem positive_biggerashr_shlnuw_ashrexact_thm (x : BitVec 8) : x.sshiftRight 6 <<< 3 = x.sshiftRight 3 := sorry

theorem positive_biggershl_shlnuw_ashrexact_thm (x : BitVec 8) : x.sshiftRight 3 <<< 6 = x <<< 3 := sorry

theorem positive_samevar_shlnuwnsw_ashrexact_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (x_1.sshiftRight x.toNat)) fun a =>
      if 8 ≤ x.toNat then none else some (a <<< x.toNat)) ⊑
    some x_1 := sorry

theorem positive_sameconst_shlnuwnsw_ashrexact_thm (x : BitVec 8) : x.sshiftRight 3 <<< 3 = x := sorry

theorem positive_biggerashr_shlnuwnsw_ashrexact_thm (x : BitVec 8) : x.sshiftRight 6 <<< 3 = x.sshiftRight 3 := sorry

theorem positive_biggershl_shlnuwnsw_ashrexact_thm (x : BitVec 8) : x.sshiftRight 3 <<< 6 = x <<< 3 := sorry

