
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section glshr_proof
theorem lshr_exact_thm (x : BitVec 8) : (x <<< 2 + 4#8) >>> 2 = x + 1#8 &&& 63#8 := by bv_compare'

theorem shl_add_thm (x x_1 : BitVec 8) : (x_1 <<< 2 + x) >>> 2 = x >>> 2 + x_1 &&& 63#8 := by bv_compare'

theorem bool_zext_thm (x : BitVec 1) : signExtend 16 x >>> 15 = setWidth 16 x := sorry

theorem smear_sign_and_widen_thm (x : BitVec 8) : signExtend 32 x >>> 24 = setWidth 32 (x.sshiftRight 7) := sorry

theorem fake_sext_thm (x : BitVec 3) : signExtend 18 x >>> 17 = setWidth 18 (x >>> 2) := sorry

theorem mul_splat_fold_thm (x : BitVec 32) :
  ((if twoPow 64 31 <<< 1 ≤ setWidth 64 x * 65537#64 then none else some (x * 65537#32)).bind fun x' =>
      some (x' >>> 16)) ⊑
    some x := by bv_compare'

theorem shl_add_lshr_flag_preservation_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if a.msb = x.msb ∧ ¬(a + x).msb = a.msb then none else if a + x < a ∨ a + x < x then none else some (a + x)).bind
        fun a => if 32#32 ≤ x_1 then none else some (a >>> x_1.toNat)) ⊑
    Option.bind (if 32#32 ≤ x_1 then none else some (x >>> x_1.toNat)) fun a =>
      if a.msb = x_2.msb ∧ ¬(a + x_2).msb = a.msb then none
      else if a + x_2 < a ∨ a + x_2 < x_2 then none else some (a + x_2) := by bv_compare'

theorem shl_add_lshr_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if a + x < a ∨ a + x < x then none else some (a + x)).bind fun a =>
        if 32#32 ≤ x_1 then none else some (a >>> x_1.toNat)) ⊑
    Option.bind (if 32#32 ≤ x_1 then none else some (x >>> x_1.toNat)) fun a =>
      if a + x_2 < a ∨ a + x_2 < x_2 then none else some (a + x_2) := by bv_compare'

theorem shl_add_lshr_comm_thm (x x_1 x_2 : BitVec 32) :
  ((if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a =>
      (if x_2 * x_2 + a < x_2 * x_2 ∨ x_2 * x_2 + a < a then none else some (x_2 * x_2 + a)).bind fun a =>
        if 32#32 ≤ x then none else some (a >>> x.toNat)) ⊑
    Option.bind (if 32#32 ≤ x then none else some ((x_2 * x_2) >>> x.toNat)) fun a =>
      if a + x_1 < a ∨ a + x_1 < x_1 then none else some (a + x_1) := by bv_compare'

theorem shl_sub_lshr_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if (signExtend 33 a - signExtend 33 x).msb = (signExtend 33 a - signExtend 33 x).getMsbD 1 then
            if a < x then none else some (a - x)
          else none).bind
        fun a => if 32#32 ≤ x_1 then none else some (a >>> x_1.toNat)) ⊑
    Option.bind (if 32#32 ≤ x_1 then none else some (x >>> x_1.toNat)) fun y' =>
      if (signExtend 33 x_2 - signExtend 33 y').msb = (signExtend 33 x_2 - signExtend 33 y').getMsbD 1 then
        if x_2 < y' then none else some (x_2 - y')
      else none := by bv_compare'

theorem shl_sub_lshr_reverse_thm (x x_1 x_2 : BitVec 32) :
  ((if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a =>
      (if (signExtend 33 x_2 - signExtend 33 a).msb = (signExtend 33 x_2 - signExtend 33 a).getMsbD 1 then
            if x_2 < a then none else some (x_2 - a)
          else none).bind
        fun a => if 32#32 ≤ x then none else some (a >>> x.toNat)) ⊑
    Option.bind (if 32#32 ≤ x then none else some (x_2 >>> x.toNat)) fun a =>
      if (signExtend 33 a - signExtend 33 x_1).msb = (signExtend 33 a - signExtend 33 x_1).getMsbD 1 then
        if a < x_1 then none else some (a - x_1)
      else none := by bv_compare'

theorem shl_sub_lshr_reverse_no_nsw_thm (x x_1 x_2 : BitVec 32) :
  ((if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a =>
      (if x_2 < a then none else some (x_2 - a)).bind fun a => if 32#32 ≤ x then none else some (a >>> x.toNat)) ⊑
    Option.bind (if 32#32 ≤ x then none else some (x_2 >>> x.toNat)) fun a =>
      if a < x_1 then none else some (a - x_1) := by bv_compare'

theorem shl_sub_lshr_reverse_nsw_on_op1_thm (x x_1 x_2 : BitVec 32) :
  ((if (x_1 <<< x.toNat).sshiftRight x.toNat = x_1 then none
        else
          if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a =>
      (if x_2 < a then none else some (x_2 - a)).bind fun a => if 32#32 ≤ x then none else some (a >>> x.toNat)) ⊑
    Option.bind (if 32#32 ≤ x then none else some (x_2 >>> x.toNat)) fun a =>
      if a < x_1 then none else some (a - x_1) := by bv_compare'

theorem shl_or_lshr_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x_1 then none else some ((a ||| x) >>> x_1.toNat)) ⊑
    Option.bind (if 32#32 ≤ x_1 then none else some (x >>> x_1.toNat)) fun a => some (a ||| x_2) := by bv_compare'

theorem shl_or_disjoint_lshr_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x_1 then none else some ((a ||| x) >>> x_1.toNat)) ⊑
    Option.bind (if 32#32 ≤ x_1 then none else some (x >>> x_1.toNat)) fun a => some (a ||| x_2) := by bv_compare'

theorem shl_or_lshr_comm_thm (x x_1 x_2 : BitVec 32) :
  ((if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a => if 32#32 ≤ x then none else some ((x_2 ||| a) >>> x.toNat)) ⊑
    Option.bind (if 32#32 ≤ x then none else some (x_2 >>> x.toNat)) fun a => some (a ||| x_1) := by bv_compare'

theorem shl_or_disjoint_lshr_comm_thm (x x_1 x_2 : BitVec 32) :
  ((if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a => if 32#32 ≤ x then none else some ((x_2 ||| a) >>> x.toNat)) ⊑
    Option.bind (if 32#32 ≤ x then none else some (x_2 >>> x.toNat)) fun a => some (a ||| x_1) := by bv_compare'

theorem shl_xor_lshr_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x_1 then none else some ((a ^^^ x) >>> x_1.toNat)) ⊑
    Option.bind (if 32#32 ≤ x_1 then none else some (x >>> x_1.toNat)) fun a => some (a ^^^ x_2) := by bv_compare'

theorem shl_xor_lshr_comm_thm (x x_1 x_2 : BitVec 32) :
  ((if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a => if 32#32 ≤ x then none else some ((x_2 ^^^ a) >>> x.toNat)) ⊑
    Option.bind (if 32#32 ≤ x then none else some (x_2 >>> x.toNat)) fun a => some (a ^^^ x_1) := by bv_compare'

theorem shl_and_lshr_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x_1 then none else some ((a &&& x) >>> x_1.toNat)) ⊑
    Option.bind (if 32#32 ≤ x_1 then none else some (x >>> x_1.toNat)) fun a => some (a &&& x_2) := by bv_compare'

theorem shl_and_lshr_comm_thm (x x_1 x_2 : BitVec 32) :
  ((if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a => if 32#32 ≤ x then none else some ((x_2 &&& a) >>> x.toNat)) ⊑
    Option.bind (if 32#32 ≤ x then none else some (x_2 >>> x.toNat)) fun a => some (a &&& x_1) := by bv_compare'

theorem shl_lshr_and_exact_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x_1 then none else some ((a &&& x) >>> x_1.toNat)) ⊑
    Option.bind (if 32#32 ≤ x_1 then none else some (x >>> x_1.toNat)) fun a => some (a &&& x_2) := by bv_compare'

theorem mul_splat_fold_no_nuw_thm (x : BitVec 32) :
  ((if signExtend 64 x * 65537#64 < signExtend 64 (twoPow 32 31) ∨ twoPow 64 31 ≤ signExtend 64 x * 65537#64 then none
        else some (x * 65537#32)).bind
      fun x' => some (x' >>> 16)) ⊑
    if x.msb = false ∧ ¬(x + x >>> 16).msb = x.msb then none else some (x + x >>> 16) := by bv_compare'

theorem mul_splat_fold_too_narrow_thm (x : BitVec 2) :
  ((if twoPow 4 1 <<< 1 ≤ setWidth 4 x * 2#4 then none else some (x * 2#2)).bind fun x' => some (x' >>> 1)) ⊑
    some x := by bv_compare'

theorem negative_and_odd_thm (x : BitVec 32) : (x - x.sdiv 2#32 * 2#32) >>> 31 = x >>> 31 &&& x := by bv_compare'

theorem trunc_sandwich_thm (x : BitVec 32) : setWidth 12 (x >>> 28) >>> 2 = setWidth 12 (x >>> 30) := sorry

theorem trunc_sandwich_min_shift1_thm (x : BitVec 32) : setWidth 12 (x >>> 20) >>> 1 = setWidth 12 (x >>> 21) := sorry

theorem trunc_sandwich_small_shift1_thm (x : BitVec 32) : setWidth 12 (x >>> 19) >>> 1 = setWidth 12 (x >>> 20) &&& 2047#12 := sorry

theorem trunc_sandwich_max_sum_shift_thm (x : BitVec 32) : setWidth 12 (x >>> 20) >>> 11 = setWidth 12 (x >>> 31) := sorry

theorem trunc_sandwich_max_sum_shift2_thm (x : BitVec 32) : setWidth 12 (x >>> 30) >>> 1 = setWidth 12 (x >>> 31) := sorry

theorem trunc_sandwich_big_sum_shift1_thm (x : BitVec 32) : setWidth 12 (x >>> 21) >>> 11 = 0#12 := sorry

theorem trunc_sandwich_big_sum_shift2_thm (x : BitVec 32) : setWidth 12 (x >>> 31) >>> 1 = 0#12 := sorry

theorem lshr_sext_i1_to_i16_thm (x : BitVec 1) :
  some (signExtend 16 x >>> 4) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 4095#16
    | some { toFin := ⟨0, ⋯⟩ } => some 0#16 := sorry

theorem lshr_sext_i1_to_i128_thm (x : BitVec 1) :
  some (signExtend 128 x >>> 42) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 77371252455336267181195263#128
    | some { toFin := ⟨0, ⋯⟩ } => some 0#128 := sorry

theorem bool_add_lshr_thm (x x_1 : BitVec 1) :
  (setWidth 2 x_1 + setWidth 2 x) >>> 1 = setWidth 2 x_1 &&& setWidth 2 x := sorry

theorem bool_add_ashr_thm (x x_1 : BitVec 1) :
  some ((setWidth 2 x_1 + setWidth 2 x).sshiftRight 1) ⊑
    (if setWidth 2 x_1 + setWidth 2 x < setWidth 2 x_1 ∨ setWidth 2 x_1 + setWidth 2 x < setWidth 2 x then none
        else some (setWidth 2 x_1 + setWidth 2 x)).bind
      fun x' => some (x'.sshiftRight 1) := sorry

