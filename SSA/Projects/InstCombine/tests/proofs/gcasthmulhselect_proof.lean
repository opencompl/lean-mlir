
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gcasthmulhselect_proof
theorem mul_thm (x x_1 : BitVec 32) : setWidth 32 (setWidth 8 x_1 * setWidth 8 x) = x_1 * x &&& 255#32 := sorry

theorem select1_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun a => some (setWidth 32 a)) ⊑
    Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun a => some (a &&& 255#32) := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gcasthmulhselect.lean:82:17: theorem select1_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (setWidth 8 x)
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun a => some (setWidth 32 a)) ⊑
      Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun a => some (a &&& 255#32) := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gcasthmulhselect.lean:82:17: theorem select1_thm :
  BitVec 32 →
    ∀ (x : BitVec 1),
      (Option.bind
          (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none)
          fun a => some (setWidth 32 a)) ⊑
        Option.bind
          (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none)
          fun a => some (a &&& 255#32) := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gcasthmulhselect.lean:82:17: theorem select1_thm :
  BitVec 32 →
    ∀ (x : BitVec 32) (x_1 : BitVec 1),
      (Option.bind
          (match some x_1 with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => some (setWidth 8 x)
          | some { toFin := ⟨0, ⋯⟩ } => none)
          fun a => some (setWidth 32 a)) ⊑
        Option.bind
          (match some x_1 with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => some x
          | some { toFin := ⟨0, ⋯⟩ } => none)
          fun a => some (a &&& 255#32) := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gcasthmulhselect.lean:82:17: theorem select1_thm :
  BitVec 32 →
    ∀ (x : BitVec 1),
      (Option.bind
          (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none)
          fun a => some (setWidth 32 a)) ⊑
        Option.bind
          (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none)
          fun a => some (a &&& 255#32) := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gcasthmulhselect.lean:82:17: theorem select1_thm :
  BitVec 32 →
    ∀ (x : BitVec 32) (x_1 : BitVec 1),
      (Option.bind
          (match some x_1 with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => some (setWidth 8 x)
          | some { toFin := ⟨0, ⋯⟩ } => none)
          fun a => some (setWidth 32 a)) ⊑
        Option.bind
          (match some x_1 with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => some x
          | some { toFin := ⟨0, ⋯⟩ } => none)
          fun a => some (a &&& 255#32) := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gcasthmulhselect.lean:82:17: theorem select1_thm :
  ∀ (x x_1 : BitVec 32) (x_2 : BitVec 1),
    (Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some (setWidth 8 x_1 + setWidth 8 x))
        fun a => some (setWidth 32 a)) ⊑
      Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some (x_1 + x))
        fun a => some (a &&& 255#32) := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gcasthmulhselect.lean:82:17: theorem select1_thm :
  ∀ (x x_1 x_2 : BitVec 32) (x_3 : BitVec 1),
    (Option.bind
        (match some x_3 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (setWidth 8 x_2)
        | some { toFin := ⟨0, ⋯⟩ } => some (setWidth 8 x_1 + setWidth 8 x))
        fun a => some (setWidth 32 a)) ⊑
      Option.bind
        (match some x_3 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_2
        | some { toFin := ⟨0, ⋯⟩ } => some (x_1 + x))
        fun a => some (a &&& 255#32) := sorry

theorem select2_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun a => some (setWidth 8 a)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gcasthmulhselect.lean:117:17: theorem select2_thm :
  ∀ (x : BitVec 8) (x_1 : BitVec 1),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (setWidth 32 x)
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun a => some (setWidth 8 a)) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } => none := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gcasthmulhselect.lean:117:17: theorem select2_thm :
  BitVec 8 →
    ∀ (x : BitVec 1),
      (Option.bind
          (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none)
          fun a => some (setWidth 8 a)) ⊑
        match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gcasthmulhselect.lean:117:17: theorem select2_thm :
  BitVec 8 →
    ∀ (x : BitVec 8) (x_1 : BitVec 1),
      (Option.bind
          (match some x_1 with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => some (setWidth 32 x)
          | some { toFin := ⟨0, ⋯⟩ } => none)
          fun a => some (setWidth 8 a)) ⊑
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => none := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gcasthmulhselect.lean:117:17: theorem select2_thm :
  BitVec 8 →
    ∀ (x : BitVec 1),
      (Option.bind
          (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none)
          fun a => some (setWidth 8 a)) ⊑
        match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gcasthmulhselect.lean:117:17: theorem select2_thm :
  BitVec 8 →
    ∀ (x : BitVec 8) (x_1 : BitVec 1),
      (Option.bind
          (match some x_1 with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => some (setWidth 32 x)
          | some { toFin := ⟨0, ⋯⟩ } => none)
          fun a => some (setWidth 8 a)) ⊑
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => none := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gcasthmulhselect.lean:117:17: theorem select2_thm :
  ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
    (Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some (setWidth 32 x_1 + setWidth 32 x))
        fun a => some (setWidth 8 a)) ⊑
      match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => some (x_1 + x) := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gcasthmulhselect.lean:117:17: theorem select2_thm :
  ∀ (x x_1 x_2 : BitVec 8) (x_3 : BitVec 1),
    (Option.bind
        (match some x_3 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some (setWidth 32 x_2)
        | some { toFin := ⟨0, ⋯⟩ } => some (setWidth 32 x_1 + setWidth 32 x))
        fun a => some (setWidth 8 a)) ⊑
      match some x_3 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some x_2
      | some { toFin := ⟨0, ⋯⟩ } => some (x_1 + x) := sorry

