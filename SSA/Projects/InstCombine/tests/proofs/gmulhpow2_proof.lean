
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gmulhpow2_proof
<<<<<<< HEAD
theorem mul_selectp2_x_thm (x : BitVec 8) (x_1 : BitVec 1) :
  (Option.bind
      (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 2#8
      | some { toFin := ⟨0, ⋯⟩ } => some 4#8)
      fun a => some (a * x)) ⊑
    Option.bind
      (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 1#8
      | some { toFin := ⟨0, ⋯⟩ } => some 2#8)
      fun y' => if 8#8 ≤ y' then none else some (x <<< y'.toNat) := sorry

theorem mul_selectp2_x_propegate_nuw_thm (x : BitVec 8) (x_1 : BitVec 1) :
  (Option.bind
      (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 2#8
      | some { toFin := ⟨0, ⋯⟩ } => some 4#8)
      fun a =>
      if
          signExtend 16 a * signExtend 16 x < signExtend 16 (twoPow 8 7) ∨
            twoPow 16 7 ≤ signExtend 16 a * signExtend 16 x then
        none
      else if twoPow 16 7 <<< 1 ≤ setWidth 16 a * setWidth 16 x then none else some (a * x)) ⊑
    Option.bind
      (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 1#8
      | some { toFin := ⟨0, ⋯⟩ } => some 2#8)
      fun y' =>
      if x <<< y'.toNat >>> y'.toNat = x then none else if 8#8 ≤ y' then none else some (x <<< y'.toNat) := sorry

theorem mul_selectp2_x_non_const_thm (x : BitVec 8) (x_1 : BitVec 1) :
  (Option.bind
      (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 2#8
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun a => some (a * x)) ⊑
    Option.bind
      (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 1#8
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun y' => if 8#8 ≤ y' then none else some (x <<< y'.toNat) := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gmulhpow2.lean:116:17: theorem mul_selectp2_x_non_const_thm :
  ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
    (Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some 2#8
        | some { toFin := ⟨0, ⋯⟩ } => if 8#8 ≤ x_1 then none else some (1#8 <<< x_1.toNat))
        fun a => some (a * x)) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some 1#8
        | some { toFin := ⟨0, ⋯⟩ } => some x_1)
        fun y' => if 8#8 ≤ y' then none else some (x <<< y'.toNat) := sorry

theorem mul_x_selectp2_thm (x : BitVec 1) (x_1 : BitVec 8) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 8#8
      | some { toFin := ⟨0, ⋯⟩ } => some 1#8)
      fun y' => some (x_1 * x_1 * y')) ⊑
    Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 3#8
      | some { toFin := ⟨0, ⋯⟩ } => some 0#8)
      fun y' => if 8#8 ≤ y' then none else some ((x_1 * x_1) <<< y'.toNat) := sorry

theorem shl_add_log_may_cause_poison_pr62175_with_nuw_thm (x x_1 : BitVec 8) :
  ((if 4#8 <<< x.toNat >>> x.toNat = 4#8 then none else if 8#8 ≤ x then none else some (4#8 <<< x.toNat)).bind fun y' =>
      some (x_1 * y')) ⊑
=======
theorem shl_add_log_may_cause_poison_pr62175_with_nuw_thm (x x_1 : BitVec 8) :
<<<<<<< HEAD
  ((if 4#8 <<< x.toNat >>> x.toNat = 4#8 then none else if 8#8 ≤ x then none else some (4#8 <<< x.toNat)).bind fun a =>
      some (x_1 * a)) ⊑
>>>>>>> 43a49182 (re-ran scripts)
=======
  ((if 4#8 <<< x.toNat >>> x.toNat = 4#8 then none else if 8#8 ≤ x then none else some (4#8 <<< x.toNat)).bind fun y' =>
      some (x_1 * y')) ⊑
>>>>>>> 1011dc2e (re-ran the tests)
    if 8#8 ≤ x + 2#8 then none else some (x_1 <<< ((x.toNat + 2) % 256)) := sorry

theorem shl_add_log_may_cause_poison_pr62175_with_nsw_thm (x x_1 : BitVec 8) :
  ((if (4#8 <<< x.toNat).sshiftRight x.toNat = 4#8 then none else if 8#8 ≤ x then none else some (4#8 <<< x.toNat)).bind
<<<<<<< HEAD
<<<<<<< HEAD
      fun y' => some (x_1 * y')) ⊑
=======
      fun a => some (x_1 * a)) ⊑
>>>>>>> 43a49182 (re-ran scripts)
=======
      fun y' => some (x_1 * y')) ⊑
>>>>>>> 1011dc2e (re-ran the tests)
    if 8#8 ≤ x + 2#8 then none else some (x_1 <<< ((x.toNat + 2) % 256)) := sorry

