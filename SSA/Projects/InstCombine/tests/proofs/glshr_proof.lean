
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section glshr_proof
theorem lshr_exact_thm (x : BitVec 8) : (x <<< 2 + 4#8) >>> 2 = x + 1#8 &&& 63#8 := sorry

theorem shl_add_thm (x x_1 : BitVec 8) : (x_1 <<< 2 + x) >>> 2 = x >>> 2 + x_1 &&& 63#8 := sorry

theorem mul_splat_fold_thm (x : BitVec 32) :
  ((if twoPow 64 31 <<< 1 ≤ setWidth 64 x * 65537#64 then none else some (x * 65537#32)).bind fun x' =>
      some (x' >>> 16)) ⊑
    some x := sorry

theorem shl_add_lshr_flag_preservation_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if a.msb = x.msb ∧ ¬(a + x).msb = a.msb then none else if a + x < a ∨ a + x < x then none else some (a + x)).bind
        fun a => if 32#32 ≤ x_1 then none else some (a >>> x_1.toNat)) ⊑
    Option.bind (if 32#32 ≤ x_1 then none else some (x >>> x_1.toNat)) fun a =>
      if a.msb = x_2.msb ∧ ¬(a + x_2).msb = a.msb then none
      else if a + x_2 < a ∨ a + x_2 < x_2 then none else some (a + x_2) := sorry

theorem shl_add_lshr_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if a + x < a ∨ a + x < x then none else some (a + x)).bind fun a =>
        if 32#32 ≤ x_1 then none else some (a >>> x_1.toNat)) ⊑
    Option.bind (if 32#32 ≤ x_1 then none else some (x >>> x_1.toNat)) fun a =>
      if a + x_2 < a ∨ a + x_2 < x_2 then none else some (a + x_2) := sorry

theorem shl_add_lshr_comm_thm (x x_1 x_2 : BitVec 32) :
  ((if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a =>
      (if x_2 * x_2 + a < x_2 * x_2 ∨ x_2 * x_2 + a < a then none else some (x_2 * x_2 + a)).bind fun a =>
        if 32#32 ≤ x then none else some (a >>> x.toNat)) ⊑
    Option.bind (if 32#32 ≤ x then none else some ((x_2 * x_2) >>> x.toNat)) fun a =>
      if a + x_1 < a ∨ a + x_1 < x_1 then none else some (a + x_1) := sorry

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
      else none := sorry

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
      else none := sorry

theorem shl_sub_lshr_reverse_no_nsw_thm (x x_1 x_2 : BitVec 32) :
  ((if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a =>
      (if x_2 < a then none else some (x_2 - a)).bind fun a => if 32#32 ≤ x then none else some (a >>> x.toNat)) ⊑
    Option.bind (if 32#32 ≤ x then none else some (x_2 >>> x.toNat)) fun a =>
      if a < x_1 then none else some (a - x_1) := sorry

theorem shl_sub_lshr_reverse_nsw_on_op1_thm (x x_1 x_2 : BitVec 32) :
  ((if (x_1 <<< x.toNat).sshiftRight x.toNat = x_1 then none
        else
          if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a =>
      (if x_2 < a then none else some (x_2 - a)).bind fun a => if 32#32 ≤ x then none else some (a >>> x.toNat)) ⊑
    Option.bind (if 32#32 ≤ x then none else some (x_2 >>> x.toNat)) fun a =>
      if a < x_1 then none else some (a - x_1) := sorry

theorem shl_or_lshr_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x_1 then none else some ((a ||| x) >>> x_1.toNat)) ⊑
    Option.bind (if 32#32 ≤ x_1 then none else some (x >>> x_1.toNat)) fun a => some (a ||| x_2) := sorry

theorem shl_or_disjoint_lshr_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x_1 then none else some ((a ||| x) >>> x_1.toNat)) ⊑
    Option.bind (if 32#32 ≤ x_1 then none else some (x >>> x_1.toNat)) fun a => some (a ||| x_2) := sorry

theorem shl_or_lshr_comm_thm (x x_1 x_2 : BitVec 32) :
  ((if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a => if 32#32 ≤ x then none else some ((x_2 ||| a) >>> x.toNat)) ⊑
    Option.bind (if 32#32 ≤ x then none else some (x_2 >>> x.toNat)) fun a => some (a ||| x_1) := sorry

theorem shl_or_disjoint_lshr_comm_thm (x x_1 x_2 : BitVec 32) :
  ((if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a => if 32#32 ≤ x then none else some ((x_2 ||| a) >>> x.toNat)) ⊑
    Option.bind (if 32#32 ≤ x then none else some (x_2 >>> x.toNat)) fun a => some (a ||| x_1) := sorry

theorem shl_xor_lshr_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x_1 then none else some ((a ^^^ x) >>> x_1.toNat)) ⊑
    Option.bind (if 32#32 ≤ x_1 then none else some (x >>> x_1.toNat)) fun a => some (a ^^^ x_2) := sorry

theorem shl_xor_lshr_comm_thm (x x_1 x_2 : BitVec 32) :
  ((if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a => if 32#32 ≤ x then none else some ((x_2 ^^^ a) >>> x.toNat)) ⊑
    Option.bind (if 32#32 ≤ x then none else some (x_2 >>> x.toNat)) fun a => some (a ^^^ x_1) := sorry

theorem shl_and_lshr_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x_1 then none else some ((a &&& x) >>> x_1.toNat)) ⊑
    Option.bind (if 32#32 ≤ x_1 then none else some (x >>> x_1.toNat)) fun a => some (a &&& x_2) := sorry

theorem shl_and_lshr_comm_thm (x x_1 x_2 : BitVec 32) :
  ((if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a => if 32#32 ≤ x then none else some ((x_2 &&& a) >>> x.toNat)) ⊑
    Option.bind (if 32#32 ≤ x then none else some (x_2 >>> x.toNat)) fun a => some (a &&& x_1) := sorry

theorem shl_lshr_and_exact_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x_1 then none else some ((a &&& x) >>> x_1.toNat)) ⊑
    Option.bind (if 32#32 ≤ x_1 then none else some (x >>> x_1.toNat)) fun a => some (a &&& x_2) := sorry

theorem mul_splat_fold_no_nuw_thm (x : BitVec 32) :
  ((if signExtend 64 x * 65537#64 < signExtend 64 (twoPow 32 31) ∨ twoPow 64 31 ≤ signExtend 64 x * 65537#64 then none
        else some (x * 65537#32)).bind
      fun x' => some (x' >>> 16)) ⊑
    if x.msb = false ∧ ¬(x + x >>> 16).msb = x.msb then none else some (x + x >>> 16) := sorry

theorem mul_splat_fold_too_narrow_thm (x : BitVec 2) :
  ((if twoPow 4 1 <<< 1 ≤ setWidth 4 x * 2#4 then none else some (x * 2#2)).bind fun x' => some (x' >>> 1)) ⊑
    some x := sorry

theorem negative_and_odd_thm (x : BitVec 32) : (x - x.sdiv 2#32 * 2#32) >>> 31 = x >>> 31 &&& x := sorry

