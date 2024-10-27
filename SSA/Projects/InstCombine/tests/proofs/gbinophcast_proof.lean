
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gbinophcast_proof
theorem and_sext_to_sel_thm (x : BitVec 32) (x_1 : BitVec 1) :
  some (signExtend 32 x_1 &&& x) ⊑
    match some x_1 with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some x
    | some { toFin := ⟨0, ⋯⟩ } => some 0#32 := by bv_compare'

theorem or_sext_to_sel_thm (x : BitVec 32) (x_1 : BitVec 1) :
  some (signExtend 32 x_1 ||| x) ⊑
    match some x_1 with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 4294967295#32
    | some { toFin := ⟨0, ⋯⟩ } => some x := by bv_compare'

theorem xor_sext_to_sel_thm (x : BitVec 32) (x_1 : BitVec 1) : signExtend 32 x_1 ^^^ x = x ^^^ signExtend 32 x_1 := by bv_compare'

theorem and_add_bool_to_select_thm (x : BitVec 32) (x_1 : BitVec 1) :
  some (4294967295#32 + setWidth 32 x_1 &&& x) ⊑
    match some x_1 with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 0#32
    | some { toFin := ⟨0, ⋯⟩ } => some x := by bv_compare'

theorem and_add_bool_to_select_multi_use_thm (x : BitVec 32) (x_1 : BitVec 1) :
  some ((4294967295#32 + setWidth 32 x_1 &&& x) + (4294967295#32 + setWidth 32 x_1)) ⊑
    match some x_1 with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 0#32
    | some { toFin := ⟨0, ⋯⟩ } => some (x + 4294967295#32) := by bv_compare'

