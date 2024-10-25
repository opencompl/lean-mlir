
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthdiv1_proof
theorem test1_thm (x : BitVec 33) : x / 4096#33 = x >>> 12 := by bv_compare'

theorem test2_thm (x : BitVec 49) : x / 536870912#49 = x >>> 29 := by bv_compare'

theorem test3_thm (x : BitVec 1) (x_1 : BitVec 59) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 1024#59
      | some { toFin := ⟨0, ⋯⟩ } => some 4096#59)
      fun y' => if y' = 0#59 then none else some (x_1 / y')) ⊑
    Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 10#59
      | some { toFin := ⟨0, ⋯⟩ } => some 12#59)
      fun y' => if 59#59 ≤ y' then none else some (x_1 >>> y'.toNat) := by bv_compare'

