
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsubhxorhcmp_proof
theorem sext_xor_sub_thm (x : BitVec 1) (x_1 : BitVec 64) :
  some ((x_1 ^^^ signExtend 64 x) - signExtend 64 x) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some (-x_1)
    | some { toFin := ⟨0, ⋯⟩ } => some x_1 := by bv_compare'

theorem sext_xor_sub_1_thm (x : BitVec 64) (x_1 : BitVec 1) :
  some ((signExtend 64 x_1 ^^^ x) - signExtend 64 x_1) ⊑
    match some x_1 with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some (-x)
    | some { toFin := ⟨0, ⋯⟩ } => some x := by bv_compare'

theorem sext_xor_sub_2_thm (x : BitVec 64) (x_1 : BitVec 1) :
  some (signExtend 64 x_1 - (x ^^^ signExtend 64 x_1)) ⊑
    match some x_1 with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some x
    | some { toFin := ⟨0, ⋯⟩ } => some (-x) := by bv_compare'

theorem sext_xor_sub_3_thm (x : BitVec 64) (x_1 : BitVec 1) :
  some (signExtend 64 x_1 - (signExtend 64 x_1 ^^^ x)) ⊑
    match some x_1 with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some x
    | some { toFin := ⟨0, ⋯⟩ } => some (-x) := by bv_compare'

theorem sext_non_bool_xor_sub_1_thm (x : BitVec 64) (x_1 : BitVec 8) : signExtend 64 x_1 ^^^ x = x ^^^ signExtend 64 x_1 := by bv_compare'

theorem sext_diff_i1_xor_sub_thm (x x_1 : BitVec 1) :
  some (signExtend 64 x_1 - signExtend 64 x) ⊑
    if (setWidth 64 x).msb = x_1.msb ∧ ¬(setWidth 64 x + signExtend 64 x_1).msb = (setWidth 64 x).msb then none
    else some (setWidth 64 x + signExtend 64 x_1) := by bv_compare'

theorem sext_diff_i1_xor_sub_1_thm (x x_1 : BitVec 1) :
  some (signExtend 64 x_1 - signExtend 64 x) ⊑
    if (setWidth 64 x).msb = x_1.msb ∧ ¬(setWidth 64 x + signExtend 64 x_1).msb = (setWidth 64 x).msb then none
    else some (setWidth 64 x + signExtend 64 x_1) := by bv_compare'

theorem sext_multi_uses_thm (x : BitVec 64) (x_1 : BitVec 1) (x_2 : BitVec 64) :
  some (x_2 * signExtend 64 x_1 + ((x ^^^ signExtend 64 x_1) - signExtend 64 x_1)) ⊑
    match some x_1 with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some (-x + -x_2)
    | some { toFin := ⟨0, ⋯⟩ } => some x := by bv_compare'

