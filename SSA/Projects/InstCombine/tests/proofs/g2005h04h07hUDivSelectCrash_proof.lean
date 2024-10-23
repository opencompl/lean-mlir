
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2005h04h07hUDivSelectCrash_proof
theorem test_thm (x : BitVec 1) (x_1 : BitVec 32) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 8#32
      | some { toFin := ⟨0, ⋯⟩ } => some 1#32)
      fun y' => if y' = 0#32 then none else some (x_1 / y')) ⊑
    Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 3#32
      | some { toFin := ⟨0, ⋯⟩ } => some 0#32)
      fun y' => if 32#32 ≤ y' then none else some (x_1 >>> y'.toNat) := sorry

