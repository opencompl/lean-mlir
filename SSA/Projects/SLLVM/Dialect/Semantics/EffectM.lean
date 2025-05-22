/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import SSA.Core.Util.Poison
import SSA.Projects.SLLVM.Tactic.SimpSet

namespace LeanMLIR

structure MemoryState where
  -- TODO: actually implement memory state
  deriving Inhabited

instance : Refinement MemoryState := .ofEq

abbrev EffectM := StateT MemoryState PoisonOr

namespace EffectM

/-! ## Constructors -/

abbrev ub : EffectM α := PoisonOr.poison
abbrev value (a : α) : EffectM α := StateT.lift (PoisonOr.value a)

@[simp, simp_denote]
theorem pure_eq : @pure EffectM _ = @value := rfl

@[simp, simp_denote]
theorem lift_isRefinedBy_lift_iff [HRefinement α α] (a b : PoisonOr α) :
    (StateT.lift a : EffectM α) ⊑ (StateT.lift b : EffectM α) ↔ a ⊑ b := by
  rw [StateT.isRefinedBy_iff]
  unfold StateT.lift
  cases a; simp [-EffectKind.return_impure_toMonad_eq] -- TODO: this lemma causes an infinite loop
  cases b; simp [-EffectKind.return_impure_toMonad_eq]

  have (s : MemoryState) : s ⊑ s := by rfl
  simp [-EffectKind.return_impure_toMonad_eq, this]
