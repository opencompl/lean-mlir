
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gudiv_select_to_select_shift_proof
theorem test_thm (x : BitVec 1) (x_1 : BitVec 64) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 16#64
      | some { toFin := ⟨0, ⋯⟩ } => some 8#64)
      fun a =>
      Option.bind (if a = 0#64 then none else some (x_1 / a)) fun a =>
        Option.bind
          (match some x with
          | none => none
          | some { toFin := ⟨1, ⋯⟩ } => some 8#64
          | some { toFin := ⟨0, ⋯⟩ } => some 0#64)
          fun x => Option.bind (if x = 0#64 then none else some (x_1 / x)) fun y' => some (a + y')) ⊑
    if (x_1 >>> 4 + x_1 >>> 3).msb = true then none
    else
      if x_1 >>> 4 + x_1 >>> 3 < x_1 >>> 4 ∨ x_1 >>> 4 + x_1 >>> 3 < x_1 >>> 3 then none
      else some (x_1 >>> 4 + x_1 >>> 3) := by bv_compare'

