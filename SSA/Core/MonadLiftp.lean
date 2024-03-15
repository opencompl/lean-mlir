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
class LawfulLiftp (F : Type u → Type u) [Functor F] where
  /-- Every value contained in `x` is an element of its support -/
  liftp_mem_supp : ∀ {α} (x : F α), Liftp (· ∈ supp x) x
  /-- The support of `f` mapped over a monadic value `x` is
  the set image of `f` over the support of `x` -/
  supp_map {α} (f : α → β) (x : F α) : supp (f <$> x) = f '' (supp x)

export LawfulLiftp (liftp_mem_supp)

/-! Various instances of `LawfilLiftP`-/
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

end Option

namespace StateM

theorem supp_eq (x : StateM σ α) : supp x = {x.snd} := rfl

instance (σ) : LawfulLiftp (StateM σ) where
  liftp_mem_supp x := _
  supp_map := _

end StateM

end Instances

-- depends on `Functor.liftp_mem_supp`
theorem Functor.liftp_iff_supp (x : F α) [LawfulLiftp F] :
    Liftp P x ↔ ∀ x' ∈ supp x, P x' := by
  constructor <;> intro h
  · intro x' h_mem
    apply h_mem h
  · let u := Subtype.joinLiftp ⟨x, liftp_mem_supp _⟩
    let f := fun (⟨a, ha⟩ : Subtype _) => Subtype.mk a (h _ ha)
    have val_f : Subtype.val ∘ f = Subtype.val := rfl
    use f <$> u
    simp [← comp_map, val_f]

-- #check Functor.fold
-- #check Foldable

-- lemma Functor.map_supp_aux {x : F α} {f : α → β} :
--     supp (f <$> x) = ⋃₀ ((supp ∘ f) <$> x) := by
--   sorry

-- theorem Functor.map_supp (x : F α) (f : α → β) : supp (f <$> x) = f <$> supp x := by
--   ext y
--   simp [Set.mem_image, (· <$> ·)]
--   constructor
--   · intro h
--     simp
--   · rintro ⟨x', hx₁, rfl⟩ hy h
--     simp [liftp_iff_supp] at h
--     apply h
--     apply (liftp_iff_supp _).mp

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
