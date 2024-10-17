import Mathlib.Computability.NFA

open Set

namespace NFA

def restrict (M : NFA α σ) (R : Set σ) : NFA α σ where
  step s a := M.step s a ∩ R -- do we have to test `s ∈ S` too?
  start := M.start ∩ R
  accept := M.accept ∩ R

@[simp, aesop 50% unsafe]
theorem restrict_start_incl (M : NFA α σ) :
    (M.restrict R).start ⊆ M.start := by
  simp only [restrict, inter_subset_left]

@[simp, aesop 50% unsafe]
theorem restrict_accept_incl (M : NFA α σ) :
    (M.restrict R).accept ⊆ M.accept := by
  simp [restrict]

@[simp, aesop 50% unsafe]
theorem restrict_step_incl (M : NFA α σ) (s : σ) (a : α) :
    (M.restrict R).step s a ⊆ M.step s a := by
  simp [restrict]

@[simp, aesop 50% unsafe]
theorem restrict_stepSet_incl (M : NFA α σ) (R S : Set σ) (a : α) :
    (M.restrict R).stepSet S a ⊆ M.stepSet S a := by
  intros s'; simp only [mem_stepSet, restrict]; aesop

@[simp, aesop 50% unsafe]
theorem stepSet_mono (M : NFA α σ) (S₁ S₂ : Set σ) (a : α) (h : S₁ ⊆ S₂) :
    M.stepSet S₁ a ⊆ M.stepSet S₂ a := by
  simp only [stepSet]; apply biUnion_mono <;> simp_all

@[simp, aesop 50% unsafe]
theorem evalFrom_mono (M : NFA α σ) (S₁ S₂ : Set σ) (x : List α) (h : S₁ ⊆ S₂) :
    M.evalFrom S₁ x ⊆ M.evalFrom S₂ x := by
  simp only [evalFrom]; induction' x with a x ih generalizing S₁ S₂ <;> simp_all [List.foldl_cons]

@[simp, aesop 50% unsafe]
theorem restrict_evalFrom_incl' (M : NFA α σ) (R S₁ S₂ : Set σ) (h : S₁ ⊆ S₂) (x : List α) :
    (M.restrict R).evalFrom S₁ x ⊆ M.evalFrom S₂ x := by
  simp [evalFrom]; induction' x with a x ih generalizing S₁ S₂; tauto
  dsimp only [List.foldl_cons]; transitivity
  · apply evalFrom_mono; apply restrict_stepSet_incl
  · apply ih; simp_all

@[simp, aesop 50% unsafe]
theorem restrict_evalFrom_incl (M : NFA α σ) (R S : Set σ) (x : List α) :
    (M.restrict R).evalFrom S x ⊆ M.evalFrom S x := by
  simp

@[simp, aesop 50% unsafe]
theorem restrict_eval_incl (M : NFA α σ) (R : Set σ) (x : List α) :
    (M.restrict R).eval x ⊆ M.eval x := by
  simp [eval]

@[simp, aesop 50% unsafe]
theorem restrict_language_incl (M : NFA α σ) (S : Set σ) :
    (M.restrict S).accepts ≤ M.accepts := by
  unfold accepts; rintro x ⟨s, ha, he⟩; simp; use s; constructor
  · apply restrict_accept_incl; aesop
  · apply restrict_eval_incl; aesop

-- The idea is that the worklist iterator will explore a closed set of states...
def closed_set (M : NFA α σ) (S : Set σ) := M.start ⊆ S ∧ ∀ a, M.stepSet S a ⊆ S

-- ...so that the language is the right one
theorem closed_set_equiv (M : NFA α σ) (S : Set σ) : M.closed_set S ↔ (M.start ⊆ S ∧ ∀ a s, s ∈ S → M.step s a ⊆ S) := by
  simp only [closed_set, and_congr_right_iff]; intros _; constructor
  · intros hcl a s hin s' hin'; apply (hcl a); rw [mem_stepSet]; tauto
  . intros hcl a s' hin'; rw [mem_stepSet] at hin'; aesop

theorem restrict_closed_set (M : NFA α σ) (S : Set σ) (hcl : M.closed_set S) :
    (M.restrict S).accepts = M.accepts := by
  apply Language.ext; intros x; constructor
  { apply restrict_language_incl }
  unfold accepts; rintro ⟨s', ha, he⟩; use s' --; simp; use s; constructor
  sorry


/-
Maybe it's better to define a simulation restricted to a set, so that we don't have to do all this?
And then prove that m ~R M  and R closed → m ~ M and be done with it!
-/
