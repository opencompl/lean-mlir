
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthdiv2_proof
theorem test1_thm (x : BitVec 333) :
  some (x / 70368744177664#333) ⊑ if 333 % 2 ^ 333 ≤ 46 % 2 ^ 333 then none else some (x >>> (46 % 2 ^ 333)) := by bv_compare'

theorem test2_thm (x : BitVec 499) :
  (Option.bind (if 499 % 2 ^ 499 ≤ 197 % 2 ^ 499 then none else some (4096#499 <<< (197 % 2 ^ 499))) fun y' =>
      if y' = 0#499 then none else some (x / y')) ⊑
    if 499 % 2 ^ 499 ≤ 209 % 2 ^ 499 then none else some (x >>> (209 % 2 ^ 499)) := by bv_compare'

theorem test3_thm (x : BitVec 1) (x_1 : BitVec 599) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 70368744177664#599
      | some { toFin := ⟨0, ⋯⟩ } => some 4096#599)
      fun y' => if y' = 0#599 then none else some (x_1 / y')) ⊑
    Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 46#599
      | some { toFin := ⟨0, ⋯⟩ } => some 12#599)
      fun y' => if 599#599 ≤ y' then none else some (x_1 >>> y'.toNat) := by bv_compare'

