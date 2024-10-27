
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gzexthboolhaddhsub_proof
theorem a_thm (x x_1 : BitVec 1) :
  some (setWidth 32 x_1 + 1#32 + -setWidth 32 x) ⊑
    Option.bind
      (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 2#32
      | some { toFin := ⟨0, ⋯⟩ } => some 1#32)
      fun a => if a.msb = x.msb ∧ ¬(a + signExtend 32 x).msb = a.msb then none else some (a + signExtend 32 x) := sorry

theorem PR30273_three_bools_thm (x : BitVec 1) :
  (match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    none := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gzexthboolhaddhsub.lean:90:17: theorem PR30273_three_bools_thm :
  ∀ (x x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        Option.bind
          (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none)
          fun x' => if x'.msb = false ∧ ¬(x' + 1#32).msb = x'.msb then none else some (x' + 1#32)
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      Option.bind
        (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none)
        fun a =>
        if a.msb = (setWidth 32 x_1).msb ∧ ¬(a + setWidth 32 x_1).msb = a.msb then none
        else
          if a + setWidth 32 x_1 < a ∨ a + setWidth 32 x_1 < setWidth 32 x_1 then none
          else some (a + setWidth 32 x_1) := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gzexthboolhaddhsub.lean:90:17: theorem PR30273_three_bools_thm :
  BitVec 1 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gzexthboolhaddhsub.lean:90:17: theorem PR30273_three_bools_thm :
  ∀ (x x_1 x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        Option.bind
          (match some x_1 with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } =>
            if (setWidth 32 x).msb = false ∧ ¬(setWidth 32 x + 1#32).msb = (setWidth 32 x).msb then none
            else some (setWidth 32 x + 1#32)
          | some { toFin := ⟨0, ⋯⟩ } => some (setWidth 32 x))
          fun x' => if x'.msb = false ∧ ¬(x' + 1#32).msb = x'.msb then none else some (x' + 1#32)
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } =>
          if (setWidth 32 x).msb = false ∧ ¬(setWidth 32 x + 1#32).msb = (setWidth 32 x).msb then none
          else some (setWidth 32 x + 1#32)
        | some { toFin := ⟨0, ⋯⟩ } => some (setWidth 32 x)) ⊑
      Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } =>
          match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => some 2#32
          | some { toFin := ⟨0, ⋯⟩ } => some 1#32
        | some { toFin := ⟨0, ⋯⟩ } => some (setWidth 32 x))
        fun a =>
        if a.msb = (setWidth 32 x_2).msb ∧ ¬(a + setWidth 32 x_2).msb = a.msb then none
        else
          if a + setWidth 32 x_2 < a ∨ a + setWidth 32 x_2 < setWidth 32 x_2 then none
          else some (a + setWidth 32 x_2) := sorry

theorem zext_add_scalar_thm (x : BitVec 1) :
  some (setWidth 32 x + 42#32) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 43#32
    | some { toFin := ⟨0, ⋯⟩ } => some 42#32 := sorry

theorem zext_negate_thm (x : BitVec 1) : -setWidth 64 x = signExtend 64 x := sorry

theorem zext_sub_const_thm (x : BitVec 1) :
  some (42#64 - setWidth 64 x) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 41#64
    | some { toFin := ⟨0, ⋯⟩ } => some 42#64 := sorry

theorem sext_negate_thm (x : BitVec 1) : -signExtend 64 x = setWidth 64 x := sorry

theorem sext_sub_const_thm (x : BitVec 1) :
  some (42#64 - signExtend 64 x) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 43#64
    | some { toFin := ⟨0, ⋯⟩ } => some 42#64 := sorry

theorem sext_sub_thm (x : BitVec 1) (x_1 : BitVec 8) : x_1 - signExtend 8 x = x_1 + setWidth 8 x := sorry

theorem sext_sub_nuw_thm (x : BitVec 1) (x_1 : BitVec 8) :
  (if x_1 < signExtend 8 x then none else some (x_1 - signExtend 8 x)) ⊑ some (x_1 + setWidth 8 x) := sorry

theorem sextbool_add_thm (x : BitVec 32) (x_1 : BitVec 1) : signExtend 32 x_1 + x = x + signExtend 32 x_1 := sorry

theorem sextbool_add_commute_thm (x : BitVec 1) (x_1 : BitVec 32) :
  some (x_1 % 42#32 + signExtend 32 x) ⊑
    if (x_1 % 42#32).msb = x.msb ∧ ¬(x_1 % 42#32 + signExtend 32 x).msb = (x_1 % 42#32).msb then none
    else some (x_1 % 42#32 + signExtend 32 x) := sorry

