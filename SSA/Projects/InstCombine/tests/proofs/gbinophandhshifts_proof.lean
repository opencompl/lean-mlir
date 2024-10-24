
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gbinophandhshifts_proof
theorem shl_and_and_thm (x x_1 : BitVec 8) : x_1 <<< 4 &&& (x <<< 4 &&& 88#8) = (x &&& x_1) <<< 4 &&& 80#8 := sorry

theorem shl_and_and_fail_thm (x x_1 : BitVec 8) : x_1 <<< 4 &&& (x <<< 5 &&& 88#8) = x_1 <<< 4 &&& (x <<< 5 &&& 64#8) := sorry

theorem shl_add_add_thm (x x_1 : BitVec 8) : x_1 <<< 2 + (x <<< 2 + 48#8) = x <<< 2 + x_1 <<< 2 + 48#8 := sorry

theorem shl_add_add_fail_thm (x x_1 : BitVec 8) :
  some (x_1 >>> 2 + (x >>> 2 + 48#8)) ⊑
    (if (48#8).msb = false ∧ (x >>> 2 + 48#8).msb = true then none
        else if x >>> 2 + 48#8 < x >>> 2 ∨ x >>> 2 + 48#8 < 48#8 then none else some (x >>> 2 + 48#8)).bind
      fun y' => if x_1 >>> 2 + y' < x_1 >>> 2 ∨ x_1 >>> 2 + y' < y' then none else some (x_1 >>> 2 + y') := sorry

theorem shl_and_xor_thm (x x_1 : BitVec 8) : x_1 <<< 1 ^^^ x <<< 1 &&& 20#8 = (x_1 ^^^ x &&& 10#8) <<< 1 := sorry

theorem shl_and_add_thm (x : BitVec 8) : x <<< 1 &&& 119#8 = (x &&& 59#8) <<< 1 := sorry

theorem lshr_or_and_thm (x x_1 : BitVec 8) : (x_1 >>> 5 ||| 198#8) &&& x >>> 5 = (x &&& (x_1 ||| 192#8)) >>> 5 := sorry

theorem lshr_or_or_fail_thm (x x_1 : BitVec 8) : x_1 >>> 5 ||| (x >>> 5 ||| 198#8) = (x ||| x_1) >>> 5 ||| 198#8 := sorry

theorem lshr_or_or_no_const_thm (x x_1 x_2 x_3 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x_2 then none else some (x_3 >>> x_2.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x_2 then none else some (x_1 >>> x_2.toNat)) fun a_1 => some (a ||| (a_1 ||| x))) ⊑
    Option.bind (if 8#8 ≤ x_2 then none else some ((x_1 ||| x_3) >>> x_2.toNat)) fun a => some (a ||| x) := sorry

theorem shl_xor_xor_no_const_thm (x x_1 x_2 x_3 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x_2 then none else some (x_3 <<< x_2.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x_2 then none else some (x_1 <<< x_2.toNat)) fun a_1 => some (a ^^^ (a_1 ^^^ x))) ⊑
    Option.bind (if 8#8 ≤ x_2 then none else some ((x_1 ^^^ x_3) <<< x_2.toNat)) fun a => some (a ^^^ x) := sorry

theorem shl_add_add_no_const_thm (x x_1 x_2 x_3 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x_2 then none else some (x_3 <<< x_2.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x_2 then none else some (x_1 <<< x_2.toNat)) fun a_1 => some (a + (a_1 + x))) ⊑
    Option.bind (if 8#8 ≤ x_2 then none else some (x_1 <<< x_2.toNat + x_3 <<< x_2.toNat)) fun a =>
      some (a + x) := sorry

theorem lshr_xor_or_good_mask_thm (x x_1 : BitVec 8) : x_1 >>> 4 ||| x >>> 4 ^^^ 48#8 = (x ||| x_1) >>> 4 ||| 48#8 := sorry

theorem shl_xor_xor_good_mask_thm (x x_1 : BitVec 8) : x_1 <<< 1 ^^^ (x <<< 1 ^^^ 88#8) = (x ^^^ x_1) <<< 1 ^^^ 88#8 := sorry

theorem shl_xor_xor_bad_mask_distribute_thm (x x_1 : BitVec 8) : x_1 <<< 1 ^^^ (x <<< 1 ^^^ 188#8) = (x ^^^ x_1) <<< 1 ^^^ 188#8 := sorry

theorem shl_add_and_thm (x x_1 : BitVec 8) : x_1 <<< 1 &&& x <<< 1 + 123#8 = (x_1 &&& x + 61#8) <<< 1 := sorry

theorem lshr_and_add_fail_thm (x x_1 : BitVec 8) :
  some (x_1 >>> 1 + (x >>> 1 &&& 123#8)) ⊑
    if x_1 >>> 1 + (x >>> 1 &&& 123#8) < x_1 >>> 1 ∨ x_1 >>> 1 + (x >>> 1 &&& 123#8) < x >>> 1 &&& 123#8 then none
    else some (x_1 >>> 1 + (x >>> 1 &&& 123#8)) := sorry

theorem lshr_add_or_fail_thm (x x_1 : BitVec 8) :
  some (x_1 >>> 1 ||| x >>> 1 + 123#8) ⊑
    (if x >>> 1 + 123#8 < x >>> 1 ∨ x >>> 1 + 123#8 < 123#8 then none else some (x >>> 1 + 123#8)).bind fun y' =>
      some (x_1 >>> 1 ||| y') := sorry

theorem lshr_add_xor_fail_thm (x x_1 : BitVec 8) :
  some (x_1 >>> 1 ^^^ x >>> 1 + 123#8) ⊑
    (if x >>> 1 + 123#8 < x >>> 1 ∨ x >>> 1 + 123#8 < 123#8 then none else some (x >>> 1 + 123#8)).bind fun y' =>
      some (x_1 >>> 1 ^^^ y') := sorry

theorem shl_add_and_fail_mismatch_shift_thm (x x_1 : BitVec 8) :
  some (x_1 <<< 1 &&& x >>> 1 + 123#8) ⊑
    (if x >>> 1 + 123#8 < x >>> 1 ∨ x >>> 1 + 123#8 < 123#8 then none else some (x >>> 1 + 123#8)).bind fun y' =>
      some (x_1 <<< 1 &&& y') := sorry

theorem and_ashr_not_thm (x x_1 x_2 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x_1 then none else some (x_2.sshiftRight x_1.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x_1 then none else some (x.sshiftRight x_1.toNat)) fun x => some (a &&& (x ^^^ 255#8))) ⊑
    if 8#8 ≤ x_1 then none else some ((x_2 &&& (x ^^^ 255#8)).sshiftRight x_1.toNat) := sorry

theorem and_ashr_not_commuted_thm (x x_1 x_2 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x_1 then none else some (x_2.sshiftRight x_1.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x_1 then none else some (x.sshiftRight x_1.toNat)) fun y' => some ((a ^^^ 255#8) &&& y')) ⊑
    if 8#8 ≤ x_1 then none else some ((x &&& (x_2 ^^^ 255#8)).sshiftRight x_1.toNat) := sorry

theorem or_ashr_not_thm (x x_1 x_2 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x_1 then none else some (x_2.sshiftRight x_1.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x_1 then none else some (x.sshiftRight x_1.toNat)) fun x => some (a ||| x ^^^ 255#8)) ⊑
    if 8#8 ≤ x_1 then none else some ((x_2 ||| x ^^^ 255#8).sshiftRight x_1.toNat) := sorry

theorem or_ashr_not_commuted_thm (x x_1 x_2 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x_1 then none else some (x_2.sshiftRight x_1.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x_1 then none else some (x.sshiftRight x_1.toNat)) fun y' => some (a ^^^ 255#8 ||| y')) ⊑
    if 8#8 ≤ x_1 then none else some ((x ||| x_2 ^^^ 255#8).sshiftRight x_1.toNat) := sorry

theorem xor_ashr_not_thm (x x_1 x_2 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x_1 then none else some (x_2.sshiftRight x_1.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x_1 then none else some (x.sshiftRight x_1.toNat)) fun x => some (a ^^^ (x ^^^ 255#8))) ⊑
    Option.bind (if 8#8 ≤ x_1 then none else some ((x ^^^ x_2).sshiftRight x_1.toNat)) fun x' =>
      some (x' ^^^ 255#8) := sorry

theorem xor_ashr_not_commuted_thm (x x_1 x_2 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x_1 then none else some (x_2.sshiftRight x_1.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x_1 then none else some (x.sshiftRight x_1.toNat)) fun y' => some (a ^^^ 255#8 ^^^ y')) ⊑
    Option.bind (if 8#8 ≤ x_1 then none else some ((x_2 ^^^ x).sshiftRight x_1.toNat)) fun x' =>
      some (x' ^^^ 255#8) := sorry

theorem xor_ashr_not_fail_lshr_ashr_thm (x x_1 x_2 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x_1 then none else some (x_2 >>> x_1.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x_1 then none else some (x.sshiftRight x_1.toNat)) fun x => some (a ^^^ (x ^^^ 255#8))) ⊑
    Option.bind (if 8#8 ≤ x_1 then none else some (x.sshiftRight x_1.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x_1 then none else some (x_2 >>> x_1.toNat)) fun x => some (a ^^^ x ^^^ 255#8) := sorry

theorem xor_ashr_not_fail_ashr_lshr_thm (x x_1 x_2 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x_1 then none else some (x_2.sshiftRight x_1.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x_1 then none else some (x >>> x_1.toNat)) fun x => some (a ^^^ (x ^^^ 255#8))) ⊑
    Option.bind (if 8#8 ≤ x_1 then none else some (x >>> x_1.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x_1 then none else some (x_2.sshiftRight x_1.toNat)) fun x =>
        some (a ^^^ x ^^^ 255#8) := sorry

theorem xor_ashr_not_fail_invalid_xor_constant_thm (x x_1 x_2 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x_1 then none else some (x_2.sshiftRight x_1.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x_1 then none else some (x.sshiftRight x_1.toNat)) fun x => some (a ^^^ (x ^^^ 254#8))) ⊑
    Option.bind (if 8#8 ≤ x_1 then none else some ((x ^^^ x_2).sshiftRight x_1.toNat)) fun x' =>
      some (x' ^^^ 254#8) := sorry

