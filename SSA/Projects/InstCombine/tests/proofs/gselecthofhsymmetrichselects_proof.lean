
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gselecthofhsymmetrichselects_proof
theorem select_of_symmetric_selects_thm (x : BitVec 1) :
  (match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:43:17: theorem select_of_symmetric_selects_thm :
  ∀ (x x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      match some (x ^^^ x_1) with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:43:17: theorem select_of_symmetric_selects_thm :
  BitVec 32 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:43:17: theorem select_of_symmetric_selects_thm :
  ∀ (x : BitVec 32) (x_1 x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x) ⊑
      match some (x_1 ^^^ x_2) with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => some x := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:43:17: theorem select_of_symmetric_selects_thm :
  BitVec 32 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:43:17: theorem select_of_symmetric_selects_thm :
  ∀ (x : BitVec 32) (x_1 x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      match some (x_1 ^^^ x_2) with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:43:17: theorem select_of_symmetric_selects_thm :
  BitVec 32 →
    BitVec 32 →
      ∀ (x : BitVec 1),
        (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
          none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:43:17: theorem select_of_symmetric_selects_thm :
  ∀ (x x_1 : BitVec 32) (x_2 x_3 : BitVec 1),
    (match some x_3 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_1
        | some { toFin := ⟨0, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => some x_1) ⊑
      match some (x_2 ^^^ x_3) with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } => some x_1 := by bv_compare'

theorem select_of_symmetric_selects_negative1_thm (x : BitVec 1) :
  (match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } =>
      match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:75:17: theorem select_of_symmetric_selects_negative1_thm :
  ∀ (x x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:75:17: theorem select_of_symmetric_selects_negative1_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => some x := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:75:17: theorem select_of_symmetric_selects_negative1_thm :
  ∀ (x : BitVec 32) (x_1 x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x) ⊑
      match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => some x := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:75:17: theorem select_of_symmetric_selects_negative1_thm :
  ∀ (x : BitVec 32) (x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:75:17: theorem select_of_symmetric_selects_negative1_thm :
  ∀ (x : BitVec 32) (x_1 x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:75:17: theorem select_of_symmetric_selects_negative1_thm :
  ∀ (x x_1 : BitVec 32) (x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => some x_1) ⊑
      match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => some x_1 := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:75:17: theorem select_of_symmetric_selects_negative1_thm :
  ∀ (x x_1 : BitVec 32) (x_2 x_3 : BitVec 1),
    (match some x_3 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_1
        | some { toFin := ⟨0, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x_3 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => some x_1) ⊑
      match some x_3 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_1
        | some { toFin := ⟨0, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } => some x_1 := by bv_compare'

theorem select_of_symmetric_selects_commuted_thm (x : BitVec 1) :
  (match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:107:17: theorem select_of_symmetric_selects_commuted_thm :
  ∀ (x x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      match some (x ^^^ x_1) with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:107:17: theorem select_of_symmetric_selects_commuted_thm :
  BitVec 32 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:107:17: theorem select_of_symmetric_selects_commuted_thm :
  ∀ (x : BitVec 32) (x_1 x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x) ⊑
      match some (x_1 ^^^ x_2) with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => none
      | some { toFin := ⟨0, ⋯⟩ } => some x := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:107:17: theorem select_of_symmetric_selects_commuted_thm :
  BitVec 32 →
    ∀ (x : BitVec 1),
      (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
        none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:107:17: theorem select_of_symmetric_selects_commuted_thm :
  ∀ (x : BitVec 32) (x_1 x_2 : BitVec 1),
    (match some x_2 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => none
        | some { toFin := ⟨0, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
      match some (x_1 ^^^ x_2) with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } => none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:107:17: theorem select_of_symmetric_selects_commuted_thm :
  BitVec 32 →
    BitVec 32 →
      ∀ (x : BitVec 1),
        (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => none
          | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
          none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthofhsymmetrichselects.lean:107:17: theorem select_of_symmetric_selects_commuted_thm :
  ∀ (x x_1 : BitVec 32) (x_2 x_3 : BitVec 1),
    (match some x_3 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } =>
        match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x_1
        | some { toFin := ⟨0, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } =>
        match some x_2 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some x
        | some { toFin := ⟨0, ⋯⟩ } => some x_1) ⊑
      match some (x_2 ^^^ x_3) with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some x
      | some { toFin := ⟨0, ⋯⟩ } => some x_1 := by bv_compare'

