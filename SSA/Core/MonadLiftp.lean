import Mathlib.Control.Monad.Basic
import Mathlib.Control.Functor
import Mathlib.Data.Set.Basic
import Mathlib.Data.Set.Lattice

--TODO: this whole file should live upstream

variable {m : Type u → Type u} {α : Type u} {P : α → Prop}

open Functor Monad

section Functor
variable {F : Type u → Type u} [Functor F] [LawfulFunctor F]

/-- Given an element of a the subtype over the lifting of predicate `P : α → Prop` into a predicate
on monadic values `m α → Prop`, return a monadic value of the subtype over just `P`.

This relies on the axiom of choice, and is thus noncomputable -/
noncomputable def Subtype.joinLiftp :
    Subtype (Liftp P : F α → Prop) → F (Subtype P) :=
  fun ⟨_, ha⟩ => ha.choose

@[simp] lemma  Subtype.val_map_joinLiftp (x : Subtype (Liftp P : F α → Prop)) :
    val <$> (joinLiftp x) = x.val := by
  simp [joinLiftp, Exists.choose_spec (P := x.property)]

-- TODO:  I strongly suspect these theorems are already implied by `LawfulFunctor`, but have not
--        succeeded in proving so
--        At the very least, they should hold for polynomial functors (i.e.,
--        functors that are equivalent to a `PFunctor`).
--        Restricting to polynomials seems sensible enough
class LawfulLiftp (F : Type u → Type u) [Functor F] where
  /-- Every value contained in `x` is an element of its support -/
  liftp_mem_supp : ∀ {α} (x : F α), Liftp (· ∈ supp x) x
  /-- The support of `f` mapped over a monadic value `x` is
  the set image of `f` over the support of `x` -/
  supp_map {α} (f : α → β) (x : F α) : supp (f <$> x) = f '' (supp x)

  -- Actually, this theorem won't be true for `Set`, so my earlier comment about this being
  -- implied by lawfulfunctor is false
  /--  -/
  eq_of_map_eq_of_supp {α β : Type u} (x : F α) (f g : α → β) :
    f <$> x = g <$> x → ∀ x' ∈ supp x, f x' = g x'

export LawfulLiftp (liftp_mem_supp supp_map)
attribute [simp] supp_map


/-! We show that `Option` and `StateT σ` obey `LawfulLiftp` -/
section Instances

namespace Option

@[simp] theorem liftp_none {P : α → Prop} : Liftp P none := by simp [Liftp]
@[simp] theorem liftp_some_iff {P : α → Prop} (x : α) : Liftp P (some x) ↔ P x := by
  simp [Liftp]
  constructor
  · rintro ⟨u, h, rfl⟩; exact h
  · intro h; exact ⟨some ⟨x, h⟩, h, rfl⟩

@[simp] theorem supp_none : supp (none : Option α) = {} := by
  ext h
  simp only [supp, Set.mem_setOf_eq, Set.mem_empty_iff_false, iff_false, not_forall, exists_prop]
  use (fun _ => False)
  simp

@[simp] theorem supp_some {x : α} : supp (some x) = {x} := by
  ext x'
  simp [supp]
  constructor
  · intro hp
    apply hp
    simp
  · rintro rfl; simp

instance : LawfulLiftp (Option) where
  liftp_mem_supp x := by
    cases x <;> simp
  supp_map f x := by
    cases x <;> simp
  -- map_eq_iff_supp_eq x := by
  --   cases x <;> simp
  eq_of_map_eq_of_supp x := by
    cases x <;> simp

end Option

namespace StateM

@[simp] theorem liftp_iff (x : StateM σ α) : Liftp P x ↔ ∀ s, P (x s).1 := by
  simp [Liftp]
  constructor
  · rintro ⟨u, rfl⟩ s
    simp [(· <$> ·), StateT.map]
    exact (u s).1.property
  · intro h
    use (fun s => (⟨_, h s⟩, (x s).2))
    simp (config := {unfoldPartialApp := true}) [(· <$> ·), StateT.map]

-- `σ → m (α × σ)`
@[simp] theorem supp_eq (x : StateM σ α) : supp x = {y | ∃ s : σ, (x s).fst = y} := by
  ext y
  simp only [supp, liftp_iff]
  constructor
  · intro h; apply h (by simp)
  · rintro ⟨s, rfl⟩ p h; apply h

instance (σ) : LawfulLiftp (StateM σ) where
  liftp_mem_supp := by simp
  supp_map := by simp [(· <$> ·), StateT.map, Set.image]
  -- map_eq_iff_supp_eq x f g := by
  --   simp (config := {unfoldPartialApp := true}) [(· <$> ·), StateT.map, Set.image]
  --   constructor
  --   · intro h
  --     ext y
  --     have : (∃ s, f (x s).1 = y) = (∃ s, ((fun s => (f (x s).1, (x s).2)) s).1 = y) := rfl
  --     rw [Set.mem_setOf_eq, Set.mem_setOf_eq, this, h]
  --   · intro h
  --     funext s
  --     congr
  --     simp at h
  --     sorry
  eq_of_map_eq_of_supp x f g := by
    simp (config := {unfoldPartialApp := true}) [(· <$> ·), StateT.map, Set.image]
    intro h s
    have : f (x s).1 = ((fun s => (f (x s).1, (x s).2)) s).1 := rfl
    rw [this, h]


end StateM

end Instances

variable [LawfulLiftp F]

theorem Functor.liftp_iff_supp (x : F α) :
    Liftp P x ↔ ∀ x' ∈ supp x, P x' := by
  constructor <;> intro h
  · intro x' h_mem
    apply h_mem h
  · let u := Subtype.joinLiftp ⟨x, liftp_mem_supp _⟩
    let f := fun (⟨a, ha⟩ : Subtype _) => Subtype.mk a (h _ ha)
    have val_f : Subtype.val ∘ f = Subtype.val := rfl
    use f <$> u
    simp [← comp_map, val_f]

-- theorem Functor.liftr_iff_supp (x y : Option α) {R : α → α → Prop} :
--     Liftr R x y ↔ ((
--       ∀ x' ∈ supp x, ∃ y' ∈ supp y, R x' y')
--       ∧ (∀ y' ∈ supp y, ∃ x' ∈ supp x, R x' y')) := by
--   cases' x with x
--   <;> cases' y with y
--   <;> simp [Liftr]
--   use some ⟨(x, y), by simp⟩


-- /-- If we map two functions over the same monadic value `x`, the result will always have the same
-- monadic action, the only difference is in the contained values, i.e., `supp (_ <$> x)` -/
-- theorem Functor.map_eq_iff_supp_eq {x : F α} {f g : α → β} :
--     f <$> x = g <$> x ↔ supp (f <$> x) = supp (g <$> x) := by
--   exact LawfulLiftp.map_eq_iff_supp_eq

theorem Functor.eq_of_map_eq {fx : F α} {f g : α → β}
    (h_fg : f <$> fx = g <$> fx) {x : α} (h_x : x ∈ supp fx) :
    f x = g x := by
  simp


end Functor

section Monad
variable [Monad m] [LawfulMonad m]

theorem Monad.liftp_pure {a : α} (h : P a) : Liftp P (pure a : m _) := by
  exact ⟨pure ⟨a, h⟩, by simp⟩


/-- Given that a monadic value `ma` satisfies a lifted property, and if `a` satisfying `P` implies
that `f a` satisfies `Liftp Q`, then the result of the bind satisfies `Liftp Q` -/
theorem Monad.liftp_bind {ma : m α} {f : α → m β} {P : α → Prop} {Q : β → Prop}
    (h_f : ∀ a, P a → (Liftp Q) (f a)) :
    Liftp P ma → Liftp Q (ma >>= f) := by
  rintro ⟨u, rfl⟩
  let f' : Subtype P → m (Subtype Q) := fun x => Subtype.joinLiftp ⟨_, h_f x.val x.property⟩
  have : (fun x => f x.val) = (fun x => Subtype.val <$> (f' x)) := by simp
  simp only [← bind_pure_comp]
  simp [this, Liftp, ← map_bind]

-- theorem Monad.liftp_of_liftp_bind {ma : m α} {f : α → m β} {P : α → Prop} {Q : β → Prop}
--     (h_f : ∀ a, (Liftp Q) (f a) → P a) :
--     Liftp Q (ma >>= f) → Liftp P ma := by
--   rintro ⟨u, hu⟩
--   refine ⟨Subtype.joinLiftp ⟨ma, ?_⟩, by simp⟩


-- theorem Monad.liftp_bind_iff {ma : m α} {f : α → m β} {P : α → Prop} {Q : β → Prop}
--     (h_f : ∀ a, P a ↔ (Liftp Q) (f a)) :
--     Liftp Q (ma >>= f) ↔ Liftp P ma := by
--   constructor

theorem Monad.bind_congr_of_liftp {x : m α} {f g : α → m β}
    (h_x : Liftp P x) (h_fg : ∀ a, P a → f a = g a) :
    (x >>= f) = (x >>= g) := by
  have x_eq : x = Subtype.val <$> (Subtype.joinLiftp ⟨x, h_x⟩) := by simp
  rw [x_eq, seq_bind_eq, seq_bind_eq]
  apply bind_congr
  intro ⟨a, ha⟩
  apply h_fg a ha

theorem Monad.bind_congr_of_supp {x : m α} {f g : α → m β} [LawfulLiftp m]
    (h_fg : ∀ a ∈ supp x, f a = g a) :
    (x >>= f) = (x >>= g) := by
  apply bind_congr_of_liftp (liftp_mem_supp _) h_fg


/-- The support of `pure x` contains at most `x`.
Note that the support may be empty, for certain degenerate (but lawful!) monads -/
theorem Monad.supp_pure : y ∈ (supp (pure x : m α)) → y = x :=
  (· ⟨pure ⟨x, rfl⟩, by simp⟩ |>.symm)

theorem Monad.supp_bind {mx : m α} {f : α → m β} :
    supp (mx >>= f) = {y | ∃ x ∈ supp mx, y ∈ supp (f x)} := by
  ext y
  simp [supp]
  constructor
  · intro h_mx
    obtain ⟨x, hx⟩ : ∃ x, y ∈ supp (f x) := by
      apply h_mx
      -- simp [supp]
      sorry
    use x

    simp
  · sorry

/-- Corollary of `supp_bind` -/
example (h : supp (pure x : m α) = ∅) : ∀ y, supp (pure y : m α) = ∅ := by
  intro y
  have : (pure y : m _) = (pure x) >>= (fun _ => pure y) := by simp
  rw [this, supp_bind, h]
  simp

theorem Monad.pure_eq_of_supp_eq (h : supp (pure x : m α) = supp (pure y : m α)) :
    (pure x : m α) = (pure y : m α) := by
  simp [supp] at h
  replace h (y) : y ∈ {y | ∀ ⦃p : α → Prop⦄, Liftp p (pure x) → p y} ↔ y ∈ _ := by
    rw [h]
  simp at h
  have hx := h x
  sorry

theorem Monad.supp_map' {mx : m α} (f : α → β) : f x ∈ supp (f <$> mx) → x ∈ supp mx := by
  simp [supp]
  intro h_map p h_mx
  specialize @h_map (fun b => _)
  sorry

theorem Monad.eq_of_map_eq_of_supp {mx : m α} {f : α → β}
    (h_bind : (f <$> mx) = (g <$> mx)) (h_supp : x ∈ supp mx) :
    f x = g x := by
  sorry
  -- have h_supp' : f x ∈ supp (f <$> mx) := supp_map f h_supp
  -- -- replace h_supp' :
  -- have := @h_supp' (∃ a, · = f a)
  -- simp [supp] at h_supp'

end Monad
