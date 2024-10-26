
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gselecth2_proof
theorem ashr_exact_poison_constant_fold_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => some 42#8)
      fun x' => some (x'.sshiftRight 3)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => some 5#8 := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecth2.lean:46:17: theorem ashr_exact_poison_constant_fold_thm :
  ∀ (x : BitVec 8) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => some 42#8)
        fun x' => some (x'.sshiftRight 3)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x.sshiftRight 3)
      | some { toFin := ⟨0, ⋯⟩ } => some 5#8 := sorry

theorem ashr_exact_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => some 16#8)
      fun x' => some (x'.sshiftRight 3)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => some 2#8 := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecth2.lean:81:17: theorem ashr_exact_thm :
  ∀ (x : BitVec 8) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => some 16#8)
        fun x' => some (x'.sshiftRight 3)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x.sshiftRight 3)
      | some { toFin := ⟨0, ⋯⟩ } => some 2#8 := sorry

theorem shl_nsw_nuw_poison_constant_fold_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 3#8
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun y' =>
      if (16#8 <<< y'.toNat).sshiftRight y'.toNat = 16#8 then none
      else
        if 16#8 <<< y'.toNat >>> y'.toNat = 16#8 then none else if 8#8 ≤ y' then none else some (16#8 <<< y'.toNat)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 128#8
    | some { toFin := ⟨0, ⋯⟩ } => none := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecth2.lean:116:17: theorem shl_nsw_nuw_poison_constant_fold_thm :
  ∀ (x : BitVec 8) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some 3#8
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun y' =>
        if (16#8 <<< y'.toNat).sshiftRight y'.toNat = 16#8 then none
        else
          if 16#8 <<< y'.toNat >>> y'.toNat = 16#8 then none else if 8#8 ≤ y' then none else some (16#8 <<< y'.toNat)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 128#8
      | some { toFin := ⟨0, ⋯⟩ } =>
        if (16#8 <<< x.toNat).sshiftRight x.toNat = 16#8 then none
        else
          if 16#8 <<< x.toNat >>> x.toNat = 16#8 then none
          else if 8#8 ≤ x then none else some (16#8 <<< x.toNat) := sorry

theorem shl_nsw_nuw_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 3#8
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun y' =>
      if (7#8 <<< y'.toNat).sshiftRight y'.toNat = 7#8 then none
      else if 7#8 <<< y'.toNat >>> y'.toNat = 7#8 then none else if 8#8 ≤ y' then none else some (7#8 <<< y'.toNat)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 56#8
    | some { toFin := ⟨0, ⋯⟩ } => none := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecth2.lean:151:17: theorem shl_nsw_nuw_thm :
  ∀ (x : BitVec 8) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some 3#8
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun y' =>
        if (7#8 <<< y'.toNat).sshiftRight y'.toNat = 7#8 then none
        else if 7#8 <<< y'.toNat >>> y'.toNat = 7#8 then none else if 8#8 ≤ y' then none else some (7#8 <<< y'.toNat)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 56#8
      | some { toFin := ⟨0, ⋯⟩ } =>
        if (7#8 <<< x.toNat).sshiftRight x.toNat = 7#8 then none
        else
          if 7#8 <<< x.toNat >>> x.toNat = 7#8 then none else if 8#8 ≤ x then none else some (7#8 <<< x.toNat) := sorry

theorem add_nsw_poison_constant_fold_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => some 65#8)
      fun x' => if x'.msb = (64#8).msb ∧ ¬(x' + 64#8).msb = x'.msb then none else some (x' + 64#8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => some 129#8 := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecth2.lean:186:17: theorem add_nsw_poison_constant_fold_thm :
  ∀ (x : BitVec 8) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => some 65#8)
        fun x' => if x'.msb = (64#8).msb ∧ ¬(x' + 64#8).msb = x'.msb then none else some (x' + 64#8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x.msb = (64#8).msb ∧ ¬(x + 64#8).msb = x.msb then none else some (x + 64#8)
      | some { toFin := ⟨0, ⋯⟩ } => some 129#8 := sorry

theorem add_nsw_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => some 7#8)
      fun x' => if x'.msb = (64#8).msb ∧ ¬(x' + 64#8).msb = x'.msb then none else some (x' + 64#8)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => some 71#8 := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecth2.lean:221:17: theorem add_nsw_thm :
  ∀ (x : BitVec 8) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => some 7#8)
        fun x' => if x'.msb = (64#8).msb ∧ ¬(x' + 64#8).msb = x'.msb then none else some (x' + 64#8)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => if x.msb = (64#8).msb ∧ ¬(x + 64#8).msb = x.msb then none else some (x + 64#8)
      | some { toFin := ⟨0, ⋯⟩ } => some 71#8 := sorry

