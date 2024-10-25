
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthrem1_proof
theorem test1_thm (x : BitVec 33) : x % 4096#33 = x &&& 4095#33 := by bv_compare'

theorem test2_thm (x : BitVec 49) : x % 8388608#49 = x &&& 8388607#49 := by bv_compare'

theorem test3_thm (x : BitVec 1) (x_1 : BitVec 59) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 70368744177664#59
      | some { toFin := ⟨0, ⋯⟩ } => some 4096#59)
      fun y' => if y' = 0#59 then none else some (x_1 % y')) ⊑
    Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 70368744177663#59
      | some { toFin := ⟨0, ⋯⟩ } => some 4095#59)
      fun y' => some (x_1 &&& y') := by bv_compare'

