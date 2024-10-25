
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gshifthshift_proof
theorem shl_shl_thm (x : BitVec 32) : x <<< 34 = 0#32 := sorry

theorem lshr_lshr_thm (x : BitVec 232) : x >>> 232 = 0#232 := sorry

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> edb64a33 (Updated tests)
=======
theorem shl_trunc_bigger_lshr_thm (x : BitVec 32) : setWidth 8 (x >>> 5) <<< 3 = setWidth 8 (x >>> 2) &&& 248#8 := sorry

theorem shl_trunc_smaller_lshr_thm (x : BitVec 32) : setWidth 8 (x >>> 3) <<< 5 = setWidth 8 x <<< 2 &&& 224#8 := sorry

theorem shl_trunc_bigger_ashr_thm (x : BitVec 32) :
  setWidth 24 (x.sshiftRight 12) <<< 3 = setWidth 24 (x.sshiftRight 9) &&& 16777208#24 := sorry

theorem shl_trunc_smaller_ashr_thm (x : BitVec 32) :
  setWidth 24 (x.sshiftRight 10) <<< 13 = setWidth 24 x <<< 3 &&& 16769024#24 := sorry

theorem shl_trunc_bigger_shl_thm (x : BitVec 32) : setWidth 8 (x <<< 4) <<< 2 = setWidth 8 x <<< 6 := sorry

theorem shl_trunc_smaller_shl_thm (x : BitVec 32) : setWidth 8 (x <<< 2) <<< 4 = setWidth 8 x <<< 6 := sorry

>>>>>>> bd0a83c7 (Updated the generated tests)
theorem shl_shl_constants_div_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun x =>
      if x <<< 2 = 0#32 then none else some (x_1 / x <<< 2)) ⊑
    if 32#32 ≤ x + 2#32 then none else some (x_1 >>> ((x.toNat + 2) % 4294967296)) := sorry

theorem ashr_shl_constants_thm (x : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some ((4294967263#32).sshiftRight x.toNat)) fun x' => some (x' <<< 3)) ⊑
    Option.bind (if 32#32 ≤ x then none else some ((4294967263#32).sshiftRight x.toNat)) fun x' =>
      if (x' <<< 3).sshiftRight 3 = x' then none else some (x' <<< 3) := sorry

theorem shl_lshr_demand1_thm (x : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (40#8 <<< x.toNat)) fun x => some (x >>> 3 ||| 224#8)) ⊑
    Option.bind (if 8#8 ≤ x then none else some (5#8 <<< x.toNat)) fun x' => some (x' ||| 224#8) := sorry

theorem shl_lshr_demand6_thm (x : BitVec 16) :
  (Option.bind (if 16#16 ≤ x then none else some (32912#16 <<< x.toNat)) fun x => some (x >>> 4 &&& 4094#16)) ⊑
    Option.bind (if 16#16 ≤ x then none else some (2057#16 <<< x.toNat)) fun x' => some (x' &&& 4094#16) := sorry

theorem lshr_shl_demand1_thm (x : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (28#8 >>> x.toNat)) fun x => some (x <<< 3 ||| 7#8)) ⊑
    Option.bind (if 8#8 ≤ x then none else some (224#8 >>> x.toNat)) fun x' => some (x' ||| 7#8) := sorry

theorem lshr_shl_demand3_thm (x : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (28#8 >>> x.toNat)) fun x => some (x <<< 3 ||| 3#8)) ⊑
    Option.bind (if 8#8 ≤ x then none else some (28#8 >>> x.toNat)) fun x =>
      (if x <<< 3 >>> 3 = x then none else some (x <<< 3)).bind fun x' => some (x' ||| 3#8) := sorry
=======
theorem ashr_shl_constants_thm (x : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some ((4294967263#32).sshiftRight x.toNat)) fun x' => some (x' <<< 3)) ⊑
    Option.bind (if 32#32 ≤ x then none else some ((4294967263#32).sshiftRight x.toNat)) fun x' =>
      if (x' <<< 3).sshiftRight 3 = x' then none else some (x' <<< 3) := sorry

theorem shl_lshr_demand1_thm (x : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (40#8 <<< x.toNat)) fun x => some (x >>> 3 ||| 224#8)) ⊑
    Option.bind (if 8#8 ≤ x then none else some (5#8 <<< x.toNat)) fun x' => some (x' ||| 224#8) := sorry

theorem shl_lshr_demand6_thm (x : BitVec 16) :
  (Option.bind (if 16#16 ≤ x then none else some (32912#16 <<< x.toNat)) fun x => some (x >>> 4 &&& 4094#16)) ⊑
    Option.bind (if 16#16 ≤ x then none else some (2057#16 <<< x.toNat)) fun x' => some (x' &&& 4094#16) := sorry

theorem lshr_shl_demand1_thm (x : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (28#8 >>> x.toNat)) fun x => some (x <<< 3 ||| 7#8)) ⊑
    Option.bind (if 8#8 ≤ x then none else some (224#8 >>> x.toNat)) fun x' => some (x' ||| 7#8) := sorry

theorem lshr_shl_demand3_thm (x : BitVec 8) :
<<<<<<< HEAD
  (Option.bind (if 8#8 ≤ x then none else some (28#8 >>> x.toNat)) fun a => some (a <<< 3 ||| 3#8)) ⊑
    Option.bind (if 8#8 ≤ x then none else some (28#8 >>> x.toNat)) fun a =>
      (if a <<< 3 >>> 3 = a then none else some (a <<< 3)).bind fun a => some (a ||| 3#8) := sorry
>>>>>>> 43a49182 (re-ran scripts)
=======
  (Option.bind (if 8#8 ≤ x then none else some (28#8 >>> x.toNat)) fun x => some (x <<< 3 ||| 3#8)) ⊑
    Option.bind (if 8#8 ≤ x then none else some (28#8 >>> x.toNat)) fun x =>
      (if x <<< 3 >>> 3 = x then none else some (x <<< 3)).bind fun x' => some (x' ||| 3#8) := sorry
>>>>>>> 1011dc2e (re-ran the tests)

