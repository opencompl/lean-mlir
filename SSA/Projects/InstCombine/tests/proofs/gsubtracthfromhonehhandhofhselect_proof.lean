
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsubtracthfromhonehhandhofhselect_proof
theorem t0_sub_from_trueval_thm (x : BitVec 1) (x_1 : BitVec 8) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some x_1
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun y' => some (x_1 - y')) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 0#8
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gsubtracthfromhonehhandhofhselect.lean:43:17: theorem t0_sub_from_trueval_thm :
  ∀ (x : BitVec 8) (x_1 : BitVec 1) (x_2 : BitVec 8),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_2
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun y' => some (x_2 - y')) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 0#8
      | some { toFin := ⟨0, ⋯⟩ } => some (x_2 - x) := by bv_compare'

theorem t1_sub_from_falseval_thm (x : BitVec 1) (x_1 : BitVec 8) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => some x_1)
      fun y' => some (x_1 - y')) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => some 0#8 := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gsubtracthfromhonehhandhofhselect.lean:75:17: theorem t1_sub_from_falseval_thm :
  ∀ (x : BitVec 8) (x_1 : BitVec 1) (x_2 : BitVec 8),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => some x_2)
        fun y' => some (x_2 - y')) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x_2 - x)
      | some { toFin := ⟨0, ⋯⟩ } => some 0#8 := by bv_compare'

