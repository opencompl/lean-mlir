
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsubtracthofhonehhandhofhselect_proof
theorem t0_sub_of_trueval_thm (x : BitVec 8) (x_1 : BitVec 1) :
  (Option.bind
      (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun a => some (a - x)) ⊑
    match some x_1 with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 0#8
    | some { toFin := ⟨0, ⋯⟩ } => none := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gsubtracthofhonehhandhofhselect.lean:43:17: theorem t0_sub_of_trueval_thm :
  ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
    (Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_1
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun a => some (a - x_1)) ⊑
      match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 0#8
      | some { toFin := ⟨0, ⋯⟩ } => some (x - x_1) := sorry

theorem t1_sub_of_falseval_thm (x : BitVec 8) (x_1 : BitVec 1) :
  (Option.bind
      (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => some x)
      fun a => some (a - x)) ⊑
    match some x_1 with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => some 0#8 := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gsubtracthofhonehhandhofhselect.lean:75:17: theorem t1_sub_of_falseval_thm :
  ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1),
    (Option.bind
        (match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_1
        | some { toFin := ⟨0, ⋯⟩ } => some x)
        fun a => some (a - x)) ⊑
      match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x_1 - x)
      | some { toFin := ⟨0, ⋯⟩ } => some 0#8 := sorry

