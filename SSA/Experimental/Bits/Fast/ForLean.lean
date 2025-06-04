import Lean.Meta.ForEachExpr
import Lean.Meta.Tactic.Simp.BuiltinSimprocs.BitVec

import Lean
open Std Sat AIG

/--
info: Std.Sat.AIG.Entrypoint.relabelNat_unsat_iff {α : Type} [DecidableEq α] [Hashable α] {entry : Entrypoint α}
  [Nonempty α] : entry.relabelNat.Unsat ↔ entry.Unsat
-/
#guard_msgs in #check Entrypoint.relabelNat_unsat_iff


variable {α : Type} [DecidableEq α] [Hashable α]
variable {β : Type} [DecidableEq β] [Hashable β]

theorem relabel_unsat_iff_of_not_NonEmpty {aigα : AIG α} {r : α → β} {hidx1} {hidx2}
    (hαNonempty : ¬ Nonempty α) :
    (aigα.relabel r).UnsatAt idx invert hidx1 ↔ aigα.UnsatAt idx invert hidx2 := by
  constructor
  · intro hα assignα
    let assignβ : β → Bool := fun b => false
    specialize hα assignβ
    have hAssignα : assignα  = assignβ ∘ r := by
      ext a
      apply hαNonempty (Nonempty.intro a) |>.elim
    rw [hAssignα]
    rw [← denote_relabel]
    rw [← hα]
  · apply unsat_relabel

theorem relabelNat_unsat_iff_of_NonEmpty [Nonempty α] {aig : AIG α} {hidx1} {hidx2} :
    (aig.relabelNat).UnsatAt idx invert hidx1 ↔ aig.UnsatAt idx invert hidx2 := by
  dsimp only [relabelNat, relabelNat']
  rw [relabel_unsat_iff]
  intro x y hx hy heq
  split at heq
  · next hcase1 =>
    split at heq
    · next hcase2 =>
      apply RelabelNat.State.ofAIG_find_unique
      · assumption
      · rw [heq]
        assumption
    · next hcase2 =>
      exfalso
      rcases RelabelNat.State.ofAIG_find_some y hy with ⟨n, hn⟩
      simp [hcase2] at hn
  · next hcase =>
    exfalso
    rcases RelabelNat.State.ofAIG_find_some x hx with ⟨n, hn⟩
    simp [hcase] at hn

/--
`relabelNat` preserves unsatisfiablility.
-/
theorem relabelNat_unsat_iff' {aig : AIG α} {hidx1} {hidx2} :
    (aig.relabelNat).UnsatAt idx invert hidx1 ↔ aig.UnsatAt idx invert hidx2 := by
  by_cases hαNonempty : Nonempty α
  · apply relabelNat_unsat_iff_of_NonEmpty
  · apply relabel_unsat_iff_of_not_NonEmpty
    assumption
