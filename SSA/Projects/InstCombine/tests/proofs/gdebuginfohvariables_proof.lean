
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gdebuginfohvariables_proof
theorem test_sext_zext_thm (x : BitVec 16) : signExtend 64 (setWidth 32 x) = setWidth 64 x := by bv_compare'

theorem test_cast_select_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 3#16
      | some { toFin := ⟨0, ⋯⟩ } => some 5#16)
      fun x' => some (setWidth 32 x')) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 3#32
    | some { toFin := ⟨0, ⋯⟩ } => some 5#32 := by bv_compare'

