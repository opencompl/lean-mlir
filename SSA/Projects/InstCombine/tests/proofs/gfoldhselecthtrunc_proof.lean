
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gfoldhselecthtrunc_proof
theorem fold_select_trunc_nuw_true_thm (x : BitVec 8) :
  (match some (setWidth 1 x) with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some x
    | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    match some (setWidth 1 x) with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 1#8
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gfoldhselecthtrunc.lean:43:17: theorem fold_select_trunc_nuw_true_thm :
  ∀ (x x_1 : BitVec 8),
    (match some (setWidth 1 x_1) with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some x_1
      | some { toFin := ⟨0, ⋯⟩ } => some x) ⊑
      match some (setWidth 1 x_1) with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 1#8
      | some { toFin := ⟨0, ⋯⟩ } => some x := by bv_compare'

theorem fold_select_trunc_nuw_false_thm (x : BitVec 8) :
  (match some (setWidth 1 x) with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => some x) ⊑
    match some (setWidth 1 x) with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => some 0#8 := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gfoldhselecthtrunc.lean:75:17: theorem fold_select_trunc_nuw_false_thm :
  ∀ (x x_1 : BitVec 8),
    (match some (setWidth 1 x_1) with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } => some x_1) ⊑
      match some (setWidth 1 x_1) with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } => some 0#8 := by bv_compare'

theorem fold_select_trunc_nsw_true_thm (x : BitVec 128) :
  (match some (setWidth 1 x) with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some x
    | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    match some (setWidth 1 x) with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 340282366920938463463374607431768211455#128
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gfoldhselecthtrunc.lean:107:17: theorem fold_select_trunc_nsw_true_thm :
  ∀ (x x_1 : BitVec 128),
    (match some (setWidth 1 x_1) with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some x_1
      | some { toFin := ⟨0, ⋯⟩ } => some x) ⊑
      match some (setWidth 1 x_1) with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 340282366920938463463374607431768211455#128
      | some { toFin := ⟨0, ⋯⟩ } => some x := by bv_compare'

theorem fold_select_trunc_nsw_false_thm (x : BitVec 8) :
  (match some (setWidth 1 x) with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => some x) ⊑
    match some (setWidth 1 x) with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => some 0#8 := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gfoldhselecthtrunc.lean:139:17: theorem fold_select_trunc_nsw_false_thm :
  ∀ (x x_1 : BitVec 8),
    (match some (setWidth 1 x_1) with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } => some x_1) ⊑
      match some (setWidth 1 x_1) with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } => some 0#8 := by bv_compare'

