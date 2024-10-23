
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gshlhfactor_proof
theorem add_shl_same_amount_thm (x x_1 x_2 : BitVec 6) :
  (Option.bind (if 6#6 ≤ x_1 then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 6#6 ≤ x_1 then none else some (x <<< x_1.toNat)) fun y' => some (a + y')) ⊑
    if 6#6 ≤ x_1 then none else some (x_2 <<< x_1.toNat + x <<< x_1.toNat) := sorry

theorem add_shl_same_amount_nuw_thm (x x_1 x_2 : BitVec 64) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 64#64 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if x <<< x_1.toNat >>> x_1.toNat = x then none else if 64#64 ≤ x_1 then none else some (x <<< x_1.toNat)).bind
        fun y' => if a + y' < a ∨ a + y' < y' then none else some (a + y')) ⊑
    (if x_2 + x < x_2 ∨ x_2 + x < x then none else some (x_2 + x)).bind fun a =>
      if a <<< x_1.toNat >>> x_1.toNat = a then none else if 64#64 ≤ x_1 then none else some (a <<< x_1.toNat) := sorry

theorem add_shl_same_amount_partial_nsw1_thm (x x_1 x_2 : BitVec 6) :
  ((if (x_2 <<< x_1.toNat).sshiftRight x_1.toNat = x_2 then none
        else if 6#6 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if (x <<< x_1.toNat).sshiftRight x_1.toNat = x then none
          else if 6#6 ≤ x_1 then none else some (x <<< x_1.toNat)).bind
        fun y' => some (a + y')) ⊑
    if 6#6 ≤ x_1 then none else some (x_2 <<< x_1.toNat + x <<< x_1.toNat) := sorry

theorem add_shl_same_amount_partial_nsw2_thm (x x_1 x_2 : BitVec 6) :
  (Option.bind (if 6#6 ≤ x_1 then none else some (x_2 <<< x_1.toNat)) fun a =>
      (if (x <<< x_1.toNat).sshiftRight x_1.toNat = x then none
          else if 6#6 ≤ x_1 then none else some (x <<< x_1.toNat)).bind
        fun y' => if a.msb = y'.msb ∧ ¬(a + y').msb = a.msb then none else some (a + y')) ⊑
    if 6#6 ≤ x_1 then none else some (x_2 <<< x_1.toNat + x <<< x_1.toNat) := sorry

theorem add_shl_same_amount_partial_nuw1_thm (x x_1 x_2 : BitVec 6) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 6#6 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if x <<< x_1.toNat >>> x_1.toNat = x then none else if 6#6 ≤ x_1 then none else some (x <<< x_1.toNat)).bind
        fun y' => some (a + y')) ⊑
    if 6#6 ≤ x_1 then none else some (x_2 <<< x_1.toNat + x <<< x_1.toNat) := sorry

theorem add_shl_same_amount_partial_nuw2_thm (x x_1 x_2 : BitVec 6) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 6#6 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      Option.bind (if 6#6 ≤ x_1 then none else some (x <<< x_1.toNat)) fun y' =>
        if a + y' < a ∨ a + y' < y' then none else some (a + y')) ⊑
    if 6#6 ≤ x_1 then none else some (x_2 <<< x_1.toNat + x <<< x_1.toNat) := sorry

theorem sub_shl_same_amount_thm (x x_1 x_2 : BitVec 6) :
  (Option.bind (if 6#6 ≤ x_1 then none else some (x_2 <<< x_1.toNat)) fun a =>
      Option.bind (if 6#6 ≤ x_1 then none else some (x <<< x_1.toNat)) fun y' => some (a - y')) ⊑
    if 6#6 ≤ x_1 then none else some ((x_2 - x) <<< x_1.toNat) := sorry

theorem sub_shl_same_amount_nuw_thm (x x_1 x_2 : BitVec 64) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 64#64 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if x <<< x_1.toNat >>> x_1.toNat = x then none else if 64#64 ≤ x_1 then none else some (x <<< x_1.toNat)).bind
        fun y' => if a < y' then none else some (a - y')) ⊑
    (if x_2 < x then none else some (x_2 - x)).bind fun a =>
      if a <<< x_1.toNat >>> x_1.toNat = a then none else if 64#64 ≤ x_1 then none else some (a <<< x_1.toNat) := sorry

theorem sub_shl_same_amount_partial_nsw1_thm (x x_1 x_2 : BitVec 6) :
  ((if (x_2 <<< x_1.toNat).sshiftRight x_1.toNat = x_2 then none
        else if 6#6 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if (x <<< x_1.toNat).sshiftRight x_1.toNat = x then none
          else if 6#6 ≤ x_1 then none else some (x <<< x_1.toNat)).bind
        fun y' => some (a - y')) ⊑
    if 6#6 ≤ x_1 then none else some ((x_2 - x) <<< x_1.toNat) := sorry

theorem sub_shl_same_amount_partial_nsw2_thm (x x_1 x_2 : BitVec 6) :
  (Option.bind (if 6#6 ≤ x_1 then none else some (x_2 <<< x_1.toNat)) fun a =>
      (if (x <<< x_1.toNat).sshiftRight x_1.toNat = x then none
          else if 6#6 ≤ x_1 then none else some (x <<< x_1.toNat)).bind
        fun y' =>
        if (signExtend 7 a - signExtend 7 y').msb = (signExtend 7 a - signExtend 7 y').getMsbD 1 then some (a - y')
        else none) ⊑
    if 6#6 ≤ x_1 then none else some ((x_2 - x) <<< x_1.toNat) := sorry

theorem sub_shl_same_amount_partial_nuw1_thm (x x_1 x_2 : BitVec 6) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 6#6 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if x <<< x_1.toNat >>> x_1.toNat = x then none else if 6#6 ≤ x_1 then none else some (x <<< x_1.toNat)).bind
        fun y' => some (a - y')) ⊑
    if 6#6 ≤ x_1 then none else some ((x_2 - x) <<< x_1.toNat) := sorry

theorem sub_shl_same_amount_partial_nuw2_thm (x x_1 x_2 : BitVec 6) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 6#6 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      Option.bind (if 6#6 ≤ x_1 then none else some (x <<< x_1.toNat)) fun y' =>
        if a < y' then none else some (a - y')) ⊑
    if 6#6 ≤ x_1 then none else some ((x_2 - x) <<< x_1.toNat) := sorry

theorem add_shl_same_amount_constants_thm (x : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (4#8 <<< x.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x then none else some (3#8 <<< x.toNat)) fun y' => some (a + y')) ⊑
    if 8#8 ≤ x then none else some (7#8 <<< x.toNat) := sorry

