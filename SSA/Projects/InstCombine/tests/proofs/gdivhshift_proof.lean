
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gdivhshift_proof
theorem t1_thm (x : BitVec 32) (x_1 : BitVec 16) :
  (Option.bind (if 32#32 ≤ x then none else some (2#32 <<< x.toNat)) fun y' =>
      if y' = 0#32 ∨ setWidth 32 x_1 = intMin 32 ∧ y' = 4294967295#32 then none else some ((setWidth 32 x_1).sdiv y')) ⊑
    if 32#32 ≤ x + 1#32 then none else some (setWidth 32 x_1 >>> ((x.toNat + 1) % 4294967296)) := sorry

theorem t2_thm (x : BitVec 32) (x_1 : BitVec 64) :
  (Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun x =>
      if setWidth 64 x = 0#64 then none else some (x_1 / setWidth 64 x)) ⊑
    if 64#64 ≤ setWidth 64 x then none else some (x_1 >>> (x.toNat % 18446744073709551616)) := sorry

theorem t3_thm (x : BitVec 32) (x_1 : BitVec 64) :
  (Option.bind (if 32#32 ≤ x then none else some (4#32 <<< x.toNat)) fun x =>
      if setWidth 64 x = 0#64 then none else some (x_1 / setWidth 64 x)) ⊑
    if 64#64 ≤ setWidth 64 (x + 2#32) then none
    else some (x_1 >>> ((x.toNat + 2) % 4294967296 % 18446744073709551616)) := sorry

theorem t5_thm (x : BitVec 1) (x_1 : BitVec 32) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat))
      fun y' => if y' = 0#32 then none else some (x_1 / y')) ⊑
    Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => some x_1)
      fun y' => if 32#32 ≤ y' then none else some (x_1 >>> y'.toNat) := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gdivhshift.lean:50:17: theorem t5_thm :
  ∀ (x x_1 : BitVec 1) (x_2 : BitVec 32),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } =>
          match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => some 32#32
          | some { toFin := ⟨0, ⋯⟩ } => some 64#32
        | some { toFin := ⟨0, ⋯⟩ } => if 32#32 ≤ x_2 then none else some (1#32 <<< x_2.toNat))
        fun y' => if y' = 0#32 then none else some (x_2 / y')) ⊑
      Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } =>
          match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => some 5#32
          | some { toFin := ⟨0, ⋯⟩ } => some 6#32
        | some { toFin := ⟨0, ⋯⟩ } => some x_2)
        fun y' => if 32#32 ≤ y' then none else some (x_2 >>> y'.toNat) := sorry

theorem t7_thm (x : BitVec 32) :
  ((if (x <<< 2).sshiftRight 2 = x then none else some (x <<< 2)).bind fun a =>
      if x = 0#32 ∨ a = intMin 32 ∧ x = 4294967295#32 then none else some (a.sdiv x)) ⊑
    some 4#32 := sorry

theorem t10_thm (x x_1 : BitVec 32) :
  ((if (x_1 <<< x.toNat).sshiftRight x.toNat = x_1 then none
        else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a => if x_1 = 0#32 ∨ a = intMin 32 ∧ x_1 = 4294967295#32 then none else some (a.sdiv x_1)) ⊑
    if (1#32 <<< x.toNat).sshiftRight x.toNat = 1#32 then none
    else
      if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat) := sorry

theorem t12_thm (x : BitVec 32) :
  ((if x <<< 2 >>> 2 = x then none else some (x <<< 2)).bind fun a => if x = 0#32 then none else some (a / x)) ⊑
    some 4#32 := sorry

theorem t15_thm (x x_1 : BitVec 32) :
  ((if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a => if x_1 = 0#32 then none else some (a / x_1)) ⊑
    if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat) := sorry

theorem sdiv_mul_shl_nsw_thm (x x_1 x_2 : BitVec 5) :
  ((if
            signExtend 10 x_2 * signExtend 10 x_1 < signExtend 10 (twoPow 5 4) ∨
              twoPow 10 4 ≤ signExtend 10 x_2 * signExtend 10 x_1 then
          none
        else some (x_2 * x_1)).bind
      fun a =>
      (if (x_2 <<< x.toNat).sshiftRight x.toNat = x_2 then none
          else if 5#5 ≤ x then none else some (x_2 <<< x.toNat)).bind
        fun y' => if y' = 0#5 ∨ a = intMin 5 ∧ y' = 31#5 then none else some (a.sdiv y')) ⊑
    (if 1#5 <<< x.toNat >>> x.toNat = 1#5 then none else if 5#5 ≤ x then none else some (1#5 <<< x.toNat)).bind
      fun y' => if y' = 0#5 ∨ x_1 = intMin 5 ∧ y' = 31#5 then none else some (x_1.sdiv y') := sorry

theorem sdiv_mul_shl_nsw_exact_commute1_thm (x x_1 x_2 : BitVec 5) :
  ((if
            signExtend 10 x_2 * signExtend 10 x_1 < signExtend 10 (twoPow 5 4) ∨
              twoPow 10 4 ≤ signExtend 10 x_2 * signExtend 10 x_1 then
          none
        else some (x_2 * x_1)).bind
      fun a =>
      (if (x_1 <<< x.toNat).sshiftRight x.toNat = x_1 then none
          else if 5#5 ≤ x then none else some (x_1 <<< x.toNat)).bind
        fun y' => if y' = 0#5 ∨ a = intMin 5 ∧ y' = 31#5 then none else some (a.sdiv y')) ⊑
    (if 1#5 <<< x.toNat >>> x.toNat = 1#5 then none else if 5#5 ≤ x then none else some (1#5 <<< x.toNat)).bind
      fun y' => if y' = 0#5 ∨ x_2 = intMin 5 ∧ y' = 31#5 then none else some (x_2.sdiv y') := sorry

theorem udiv_mul_shl_nuw_thm (x x_1 x_2 : BitVec 5) :
  ((if twoPow 10 4 <<< 1 ≤ setWidth 10 x_2 * setWidth 10 x_1 then none else some (x_2 * x_1)).bind fun a =>
      (if x_2 <<< x.toNat >>> x.toNat = x_2 then none else if 5#5 ≤ x then none else some (x_2 <<< x.toNat)).bind
        fun y' => if y' = 0#5 then none else some (a / y')) ⊑
    if 5#5 ≤ x then none else some (x_1 >>> x.toNat) := sorry

theorem udiv_mul_shl_nuw_exact_commute1_thm (x x_1 x_2 : BitVec 5) :
  ((if twoPow 10 4 <<< 1 ≤ setWidth 10 x_2 * setWidth 10 x_1 then none else some (x_2 * x_1)).bind fun a =>
      (if x_1 <<< x.toNat >>> x.toNat = x_1 then none else if 5#5 ≤ x then none else some (x_1 <<< x.toNat)).bind
        fun y' => if y' = 0#5 then none else some (a / y')) ⊑
    if 5#5 ≤ x then none else some (x_2 >>> x.toNat) := sorry

theorem udiv_shl_mul_nuw_thm (x x_1 x_2 : BitVec 5) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 5#5 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if twoPow 10 4 <<< 1 ≤ setWidth 10 x_2 * setWidth 10 x then none else some (x_2 * x)).bind fun y' =>
        if y' = 0#5 then none else some (a / y')) ⊑
    (if 1#5 <<< x_1.toNat >>> x_1.toNat = 1#5 then none else if 5#5 ≤ x_1 then none else some (1#5 <<< x_1.toNat)).bind
      fun a => if x = 0#5 then none else some (a / x) := sorry

theorem udiv_shl_mul_nuw_swap_thm (x x_1 x_2 : BitVec 5) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 5#5 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if twoPow 10 4 <<< 1 ≤ setWidth 10 x * setWidth 10 x_2 then none else some (x * x_2)).bind fun y' =>
        if y' = 0#5 then none else some (a / y')) ⊑
    (if 1#5 <<< x_1.toNat >>> x_1.toNat = 1#5 then none else if 5#5 ≤ x_1 then none else some (1#5 <<< x_1.toNat)).bind
      fun a => if x = 0#5 then none else some (a / x) := sorry

theorem udiv_shl_mul_nuw_exact_thm (x x_1 x_2 : BitVec 5) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 5#5 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if twoPow 10 4 <<< 1 ≤ setWidth 10 x_2 * setWidth 10 x then none else some (x_2 * x)).bind fun y' =>
        if y' = 0#5 then none else some (a / y')) ⊑
    (if 1#5 <<< x_1.toNat >>> x_1.toNat = 1#5 then none else if 5#5 ≤ x_1 then none else some (1#5 <<< x_1.toNat)).bind
      fun a => if x = 0#5 then none else some (a / x) := sorry

theorem udiv_lshr_mul_nuw_thm (x x_1 x_2 : BitVec 8) :
  ((if twoPow 16 7 <<< 1 ≤ setWidth 16 x_2 * setWidth 16 x_1 then none else some (x_2 * x_1)).bind fun a =>
      Option.bind (if 8#8 ≤ x then none else some (a >>> x.toNat)) fun a =>
        if x_2 = 0#8 then none else some (a / x_2)) ⊑
    if 8#8 ≤ x then none else some (x_1 >>> x.toNat) := sorry

theorem sdiv_shl_shl_nsw2_nuw_thm (x x_1 x_2 : BitVec 8) :
  ((if (x_2 <<< x_1.toNat).sshiftRight x_1.toNat = x_2 then none
        else if 8#8 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if (x <<< x_1.toNat).sshiftRight x_1.toNat = x then none
          else
            if x <<< x_1.toNat >>> x_1.toNat = x then none else if 8#8 ≤ x_1 then none else some (x <<< x_1.toNat)).bind
        fun y' => if y' = 0#8 ∨ a = intMin 8 ∧ y' = 255#8 then none else some (a.sdiv y')) ⊑
    if x = 0#8 ∨ x_2 = intMin 8 ∧ x = 255#8 then none else some (x_2.sdiv x) := sorry

theorem udiv_shl_shl_nuw_nsw2_thm (x x_1 x_2 : BitVec 8) :
  ((if (x_2 <<< x_1.toNat).sshiftRight x_1.toNat = x_2 then none
        else
          if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none
          else if 8#8 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if (x <<< x_1.toNat).sshiftRight x_1.toNat = x then none
          else if 8#8 ≤ x_1 then none else some (x <<< x_1.toNat)).bind
        fun y' => if y' = 0#8 then none else some (a / y')) ⊑
    if x = 0#8 then none else some (x_2 / x) := sorry

theorem sdiv_shl_pair_const_thm (x : BitVec 32) :
  ((if (x <<< 2).sshiftRight 2 = x then none else some (x <<< 2)).bind fun a =>
      (if (x <<< 1).sshiftRight 1 = x then none else some (x <<< 1)).bind fun y' =>
        if y' = 0#32 ∨ a = intMin 32 ∧ y' = 4294967295#32 then none else some (a.sdiv y')) ⊑
    some 2#32 := sorry

theorem udiv_shl_pair_const_thm (x : BitVec 32) :
  ((if x <<< 2 >>> 2 = x then none else some (x <<< 2)).bind fun a =>
      (if x <<< 1 >>> 1 = x then none else some (x <<< 1)).bind fun y' => if y' = 0#32 then none else some (a / y')) ⊑
    some 2#32 := sorry

theorem sdiv_shl_pair1_thm (x x_1 x_2 : BitVec 32) :
  ((if (x_2 <<< x_1.toNat).sshiftRight x_1.toNat = x_2 then none
        else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if (x_2 <<< x.toNat).sshiftRight x.toNat = x_2 then none
          else
            if x_2 <<< x.toNat >>> x.toNat = x_2 then none else if 32#32 ≤ x then none else some (x_2 <<< x.toNat)).bind
        fun y' => if y' = 0#32 ∨ a = intMin 32 ∧ y' = 4294967295#32 then none else some (a.sdiv y')) ⊑
    (if (1#32 <<< x_1.toNat).sshiftRight x_1.toNat = 1#32 then none
        else
          if 1#32 <<< x_1.toNat >>> x_1.toNat = 1#32 then none
          else if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x then none else some (a >>> x.toNat) := sorry

theorem sdiv_shl_pair2_thm (x x_1 x_2 : BitVec 32) :
  ((if (x_2 <<< x_1.toNat).sshiftRight x_1.toNat = x_2 then none
        else
          if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none
          else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if (x_2 <<< x.toNat).sshiftRight x.toNat = x_2 then none
          else if 32#32 ≤ x then none else some (x_2 <<< x.toNat)).bind
        fun y' => if y' = 0#32 ∨ a = intMin 32 ∧ y' = 4294967295#32 then none else some (a.sdiv y')) ⊑
    (if (1#32 <<< x_1.toNat).sshiftRight x_1.toNat = 1#32 then none
        else
          if 1#32 <<< x_1.toNat >>> x_1.toNat = 1#32 then none
          else if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x then none else some (a >>> x.toNat) := sorry

theorem sdiv_shl_pair3_thm (x x_1 x_2 : BitVec 32) :
  ((if (x_2 <<< x_1.toNat).sshiftRight x_1.toNat = x_2 then none
        else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if (x_2 <<< x.toNat).sshiftRight x.toNat = x_2 then none
          else if 32#32 ≤ x then none else some (x_2 <<< x.toNat)).bind
        fun y' => if y' = 0#32 ∨ a = intMin 32 ∧ y' = 4294967295#32 then none else some (a.sdiv y')) ⊑
    (if 1#32 <<< x_1.toNat >>> x_1.toNat = 1#32 then none
        else if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x then none else some (a >>> x.toNat) := sorry

theorem udiv_shl_pair1_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if x_2 <<< x.toNat >>> x.toNat = x_2 then none else if 32#32 ≤ x then none else some (x_2 <<< x.toNat)).bind
        fun y' => if y' = 0#32 then none else some (a / y')) ⊑
    (if 1#32 <<< x_1.toNat >>> x_1.toNat = 1#32 then none
        else if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x then none else some (a >>> x.toNat) := sorry

theorem udiv_shl_pair2_thm (x x_1 x_2 : BitVec 32) :
  ((if (x_2 <<< x_1.toNat).sshiftRight x_1.toNat = x_2 then none
        else
          if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none
          else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if x_2 <<< x.toNat >>> x.toNat = x_2 then none else if 32#32 ≤ x then none else some (x_2 <<< x.toNat)).bind
        fun y' => if y' = 0#32 then none else some (a / y')) ⊑
    (if (1#32 <<< x_1.toNat).sshiftRight x_1.toNat = 1#32 then none
        else
          if 1#32 <<< x_1.toNat >>> x_1.toNat = 1#32 then none
          else if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x then none else some (a >>> x.toNat) := sorry

theorem udiv_shl_pair3_thm (x x_1 x_2 : BitVec 32) :
  ((if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if (x_2 <<< x.toNat).sshiftRight x.toNat = x_2 then none
          else
            if x_2 <<< x.toNat >>> x.toNat = x_2 then none else if 32#32 ≤ x then none else some (x_2 <<< x.toNat)).bind
        fun y' => if y' = 0#32 then none else some (a / y')) ⊑
    (if 1#32 <<< x_1.toNat >>> x_1.toNat = 1#32 then none
        else if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x then none else some (a >>> x.toNat) := sorry
