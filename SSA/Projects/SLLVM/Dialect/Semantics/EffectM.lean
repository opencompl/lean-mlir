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
@[simp, simp_sllvm]
theorem MemoryState.isRefinedBy_iff (s t : MemoryState) : s ⊑ t ↔ s = t := by rfl

def EffectM := StateT MemoryState PoisonOr

namespace EffectM

/-! ## Instances -/

instance : Monad EffectM        := by unfold EffectM; infer_instance
instance : LawfulMonad EffectM  := by unfold EffectM; infer_instance

/-! ## Constructors -/

abbrev ub : EffectM α := fun _ => PoisonOr.poison
abbrev poison : EffectM (PoisonOr α) := pure PoisonOr.poison
abbrev value (a : α) : EffectM (PoisonOr α) := pure (PoisonOr.value a)

/-! ## Lemmas -/

@[simp, simp_sllvm]
theorem pure_eq (x : α) (s) : (pure x : EffectM _) s = .value (x, s) := rfl

@[simp, simp_sllvm]
theorem bind_eq (x : EffectM α) (f : α → EffectM β) (s) :
    (x >>= f) s = x s >>= (fun (x, s) => f x s) := rfl

@[simp] lemma run_pure : StateT.run (pure x : EffectM α) s = .value (x, s) := rfl
@[simp] lemma run_ub : StateT.run (ub : EffectM α) s = .poison := rfl

@[simp, simp_sllvm]
lemma ub_bind : ub >>= f = ub := rfl

/-! ## Refinement -/
section Refinement

@[simp, simp_denote]
instance : MRefinement EffectM EffectM :=
  inferInstanceAs <| MRefinement (StateT _ PoisonOr) (StateT _ PoisonOr)

section Lemmas
variable {α β} [HRefinement α β]

-- @[simp, simp_denote]
theorem pure_isRefinedBy_pure (x : α) (y : β) :
    (pure x : EffectM _) ⊑ (pure y : EffectM _) ↔ x ⊑ y := by
  rw [StateT.isRefinedBy_iff]
  simp

omit [HRefinement α β] in
theorem cons_map_isRefinedBy_cons_map
    {A : α' → Type} {B : β' → Type} [∀ a b, HRefinement (A a) (B b)]
    (x? : EffectM α) (f : α → A a) (xs : HVector A as)
    (y? : EffectM β) (g : β → B b) (ys : HVector B bs) :
    (f · ::ₕ xs) <$> x? ⊑ (g · ::ₕ ys) <$> y?
    ↔ (∀ s s' x, StateT.run x? s = .value (x, s') →
        (PoisonOr.value <| f x) ⊑ ((fun p => g p.1) <$> StateT.run y? s)
        ∧ xs ⊑ ys) := by
  rw [StateT.isRefinedBy_iff_run]
  simp only [StateT.run_map]
  constructor
  · rintro h s s' x hx?
    specialize h s
    simp only [hx?, PoisonOr.map_value] at h
    cases hy? : StateT.run y? s
    · simp [hy?] at h
    · simpa [hy?] using h
  · intro h s
    cases hx? : StateT.run x? s
    · simp
    · specialize h _ _ _ hx?
      cases hy? : StateT.run y? s
      · simp [hy?] at h
      · simpa [hy?] using h

end Lemmas

end Refinement
