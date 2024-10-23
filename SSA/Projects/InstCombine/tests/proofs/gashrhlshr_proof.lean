
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gashrhlshr_proof
theorem ashr_known_pos_exact_thm (x x_1 : BitVec 8) :
  (if 8#8 ≤ x then none else some ((x_1 &&& 127#8).sshiftRight x.toNat)) ⊑
    if 8#8 ≤ x then none else some ((x_1 &&& 127#8) >>> x.toNat) := sorry

theorem lshr_mul_times_3_div_2_thm (x : BitVec 32) :
  ((if signExtend 64 x * 3#64 < signExtend 64 (twoPow 32 31) ∨ twoPow 64 31 ≤ signExtend 64 x * 3#64 then none
        else if twoPow 64 31 <<< 1 ≤ setWidth 64 x * 3#64 then none else some (x * 3#32)).bind
      fun x' => some (x' >>> 1)) ⊑
    if x.msb = false ∧ ¬(x + x >>> 1).msb = x.msb then none
    else if x + x >>> 1 < x ∨ x + x >>> 1 < x >>> 1 then none else some (x + x >>> 1) := sorry

theorem lshr_mul_times_3_div_2_exact_thm (x : BitVec 32) :
  ((if signExtend 64 x * 3#64 < signExtend 64 (twoPow 32 31) ∨ twoPow 64 31 ≤ signExtend 64 x * 3#64 then none
        else some (x * 3#32)).bind
      fun x' => some (x' >>> 1)) ⊑
    if x.msb = false ∧ ¬(x + x >>> 1).msb = x.msb then none else some (x + x >>> 1) := sorry

theorem lshr_mul_times_3_div_2_exact_2_thm (x : BitVec 32) :
  ((if twoPow 64 31 <<< 1 ≤ setWidth 64 x * 3#64 then none else some (x * 3#32)).bind fun x' => some (x' >>> 1)) ⊑
    if x + x >>> 1 < x ∨ x + x >>> 1 < x >>> 1 then none else some (x + x >>> 1) := sorry

theorem lshr_mul_times_5_div_4_thm (x : BitVec 32) :
  ((if signExtend 64 x * 5#64 < signExtend 64 (twoPow 32 31) ∨ twoPow 64 31 ≤ signExtend 64 x * 5#64 then none
        else if twoPow 64 31 <<< 1 ≤ setWidth 64 x * 5#64 then none else some (x * 5#32)).bind
      fun x' => some (x' >>> 2)) ⊑
    if x.msb = false ∧ ¬(x + x >>> 2).msb = x.msb then none
    else if x + x >>> 2 < x ∨ x + x >>> 2 < x >>> 2 then none else some (x + x >>> 2) := sorry

theorem lshr_mul_times_5_div_4_exact_thm (x : BitVec 32) :
  ((if signExtend 64 x * 5#64 < signExtend 64 (twoPow 32 31) ∨ twoPow 64 31 ≤ signExtend 64 x * 5#64 then none
        else some (x * 5#32)).bind
      fun x' => some (x' >>> 2)) ⊑
    if x.msb = false ∧ ¬(x + x >>> 2).msb = x.msb then none else some (x + x >>> 2) := sorry

theorem lshr_mul_times_5_div_4_exact_2_thm (x : BitVec 32) :
  ((if twoPow 64 31 <<< 1 ≤ setWidth 64 x * 5#64 then none else some (x * 5#32)).bind fun x' => some (x' >>> 2)) ⊑
    if x + x >>> 2 < x ∨ x + x >>> 2 < x >>> 2 then none else some (x + x >>> 2) := sorry

theorem ashr_mul_times_3_div_2_thm (x : BitVec 32) :
  ((if signExtend 64 x * 3#64 < signExtend 64 (twoPow 32 31) ∨ twoPow 64 31 ≤ signExtend 64 x * 3#64 then none
        else if twoPow 64 31 <<< 1 ≤ setWidth 64 x * 3#64 then none else some (x * 3#32)).bind
      fun x' => some (x'.sshiftRight 1)) ⊑
    if x.msb = false ∧ ¬(x + x >>> 1).msb = x.msb then none
    else if x + x >>> 1 < x ∨ x + x >>> 1 < x >>> 1 then none else some (x + x >>> 1) := sorry

theorem ashr_mul_times_3_div_2_exact_thm (x : BitVec 32) :
  ((if signExtend 64 x * 3#64 < signExtend 64 (twoPow 32 31) ∨ twoPow 64 31 ≤ signExtend 64 x * 3#64 then none
        else some (x * 3#32)).bind
      fun x' => some (x'.sshiftRight 1)) ⊑
    if (x + x.sshiftRight 1).msb = x.msb then some (x + x.sshiftRight 1) else none := sorry

theorem ashr_mul_times_3_div_2_exact_2_thm (x : BitVec 32) :
  ((if signExtend 64 x * 3#64 < signExtend 64 (twoPow 32 31) ∨ twoPow 64 31 ≤ signExtend 64 x * 3#64 then none
        else some (x * 3#32)).bind
      fun x' => some (x'.sshiftRight 1)) ⊑
    if (x + x.sshiftRight 1).msb = x.msb then some (x + x.sshiftRight 1) else none := sorry

theorem ashr_mul_times_5_div_4_thm (x : BitVec 32) :
  ((if signExtend 64 x * 5#64 < signExtend 64 (twoPow 32 31) ∨ twoPow 64 31 ≤ signExtend 64 x * 5#64 then none
        else if twoPow 64 31 <<< 1 ≤ setWidth 64 x * 5#64 then none else some (x * 5#32)).bind
      fun x' => some (x'.sshiftRight 2)) ⊑
    if x.msb = false ∧ ¬(x + x >>> 2).msb = x.msb then none
    else if x + x >>> 2 < x ∨ x + x >>> 2 < x >>> 2 then none else some (x + x >>> 2) := sorry

theorem ashr_mul_times_5_div_4_exact_thm (x : BitVec 32) :
  ((if signExtend 64 x * 5#64 < signExtend 64 (twoPow 32 31) ∨ twoPow 64 31 ≤ signExtend 64 x * 5#64 then none
        else some (x * 5#32)).bind
      fun x' => some (x'.sshiftRight 2)) ⊑
    if (x + x.sshiftRight 2).msb = x.msb then some (x + x.sshiftRight 2) else none := sorry

theorem ashr_mul_times_5_div_4_exact_2_thm (x : BitVec 32) :
  ((if signExtend 64 x * 5#64 < signExtend 64 (twoPow 32 31) ∨ twoPow 64 31 ≤ signExtend 64 x * 5#64 then none
        else some (x * 5#32)).bind
      fun x' => some (x'.sshiftRight 2)) ⊑
    if (x + x.sshiftRight 2).msb = x.msb then some (x + x.sshiftRight 2) else none := sorry

theorem lsb_mask_sign_zext_wrong_cst2_thm (x : BitVec 32) :
  (x + 4294967295#32 &&& (x ^^^ 2#32)) >>> 31 = (x + 4294967295#32 &&& x) >>> 31 := sorry

theorem lsb_mask_sign_sext_wrong_cst2_thm (x : BitVec 32) :
  (x + 4294967295#32 &&& (x ^^^ 2#32)).sshiftRight 31 = (x + 4294967295#32 &&& x).sshiftRight 31 := sorry

