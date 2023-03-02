import SSA.DependentTypedSSA.Context.Basic
import Mathlib.Data.SetLike.Basic
import Mathlib.Order.Lattice
import Mathlib.Data.Bool.Basic

namespace AST

def Subcontext (Γ : Context) : Type :=
  ∀ ⦃k⦄, Var Γ k → Bool

namespace Subcontext

open Context CategoryTheory

variable {Γ : Context} {Δ₁ Δ₂ : Subcontext Γ}

@[ext]
theorem ext (h : ∀ (k) (v : Var Γ k), Δ₁ v = Δ₂ v) : Δ₁ = Δ₂ :=
  by funext k v; exact h k v

theorem ext_iff : Δ₁ = Δ₂ ↔ ∀ (k) (v : Var Γ k), Δ₁ v = Δ₂ v :=
  ⟨fun h _ _ => h ▸ rfl, ext⟩

instance : BooleanAlgebra (Subcontext Γ) := by
  delta Subcontext; infer_instance

instance : Unique (Subcontext Context.nil) :=
  { default := ⊥,
    uniq := fun a => by
      ext k
      intro v
      cases v }

theorem le_def : Δ₁ ≤ Δ₂ ↔ ∀ {k} {v : Var Γ k}, Δ₁ v → Δ₂ v :=
  show (∀ (k) (v : Var Γ k), Δ₁ v ≤ Δ₂ v) ↔ ∀ (k) (v : Var Γ k), Δ₁ v → Δ₂ v by
    simp only [Bool.le_iff_imp]

def ofSnoc {k : Kind} (Δ : Subcontext (Γ.snoc k)) : Subcontext Γ
  | _, v => Δ (Var.succ v)

@[mono]
theorem ofSnoc_monotone : Monotone (@ofSnoc Γ k) :=
  fun Δ₁ Δ₂ h => by
    simp only [le_def, ofSnoc] at *
    exact h

def toSnocMem {k : Kind} (Δ : Subcontext Γ) : Subcontext (Γ.snoc k)
  | _, Var.zero _ _ => true
  | _, Var.succ v => Δ v

def toSnocNotMem {k : Kind} (Δ : Subcontext Γ) : Subcontext (Γ.snoc k)
  | _, Var.zero _ _ => false
  | _, Var.succ v => Δ v

theorem toSnocMem_ofSnoc_of_mem {k} (Δ : Subcontext (Γ.snoc k)) (h : Δ (Var.zero _ _)) :
    toSnocMem (ofSnoc Δ) = Δ := by
  ext k
  intro v
  cases v <;>
  simp [ofSnoc, toSnocMem, h]

theorem toSnocNotMem_ofSnoc_of_not_mem {k} (Δ : Subcontext (Γ.snoc k))
    (h : ¬Δ (Var.zero _ _)) : toSnocNotMem (ofSnoc Δ) = Δ := by
  ext k
  intro v
  cases v <;>
  simp [ofSnoc, toSnocNotMem, h]

@[elab_as_elim]
def recOn {motive : (Γ : Context) → Subcontext Γ → Sort _} :
    {Γ : Context} →
    (Δ : Subcontext Γ) →
    (nil : motive Context.nil ⊥) →
    (snoc_mem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocMem Δ)) →
    (snoc_not_mem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocNotMem Δ)) →
    motive Γ Δ
  | .nil, Δ, n, _, _ => by convert n; exact Subsingleton.elim _ _
  | .snoc Γ k, Δ, n, sm, snm =>
    if h : Δ (Var.zero _ _)
    then by
      simpa [toSnocMem_ofSnoc_of_mem _ h] using
        sm Γ k (ofSnoc Δ) (recOn (ofSnoc Δ) n sm snm)
    else by
      simpa [toSnocNotMem_ofSnoc_of_not_mem _ h] using
        snm Γ k (ofSnoc Δ) (recOn (ofSnoc Δ) n sm snm)

@[simp]
theorem recOn_nil_bot {motive : (Γ : Context) → Subcontext Γ → Sort _}
    (nil : motive Context.nil ⊥)
    (snoc_mem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocMem Δ))
    (snoc_not_mem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocNotMem Δ)) :
    recOn (⊥ : Subcontext Context.nil) nil snoc_mem snoc_not_mem = nil :=
  rfl

@[simp]
theorem recOn_toSnocMem {motive : (Γ : Context) → Subcontext Γ → Sort _}
    {Γ k} (Δ : Subcontext Γ)
    (nl : motive Context.nil ⊥)
    (snoc_mem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocMem Δ))
    (snoc_not_mem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocNotMem Δ)) :
    (recOn (toSnocMem Δ : Subcontext (Γ.snoc k)) nl snoc_mem snoc_not_mem
      : motive (Γ.snoc k) (toSnocMem Δ)) =
      snoc_mem _ _ _ (recOn Δ nl snoc_mem snoc_not_mem : motive Γ Δ) :=
  rfl

@[simp]
theorem recOn_toSnocNotMem {motive : (Γ : Context) → Subcontext Γ → Sort _}
    {Γ k} (Δ : Subcontext Γ)
    (nl : motive Context.nil ⊥)
    (snoc_mem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocMem Δ))
    (snoc_not_mem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocNotMem Δ)) :
    (recOn (toSnocNotMem Δ : Subcontext (Γ.snoc k)) nl snoc_mem snoc_not_mem
      : motive (Γ.snoc k) (toSnocNotMem Δ)) =
      snoc_not_mem _ _ _ (recOn Δ nl snoc_mem snoc_not_mem : motive Γ Δ) :=
  rfl

@[coe] def toContext {Γ : Context} (Δ : Subcontext Γ) : Context :=
  recOn Δ
    Context.nil
    (fun _ k _ Γ => Γ.snoc k)
    (fun _ _ _ => id)

instance : Coe (Subcontext Γ) Context := ⟨toContext⟩

def ofSubcontext {Γ : Context} (Δ : Subcontext Γ) : (Δ : Context) ⟶ Γ :=
  recOn Δ
    (𝟙 _)
    (fun _ _ _ => snocHom)
    (fun _ _ _ f => f ≫ toSnoc)

theorem ofSubcontext_nil_bot : ofSubcontext (⊥ : Subcontext Context.nil) = 𝟙 _ :=
  rfl

theorem ofSubcontext_toSnocMem {Γ k} (Δ : Subcontext Γ) :
    ofSubcontext (toSnocMem Δ : Subcontext (Γ.snoc k)) =
      snocHom (ofSubcontext Δ) :=
  rfl

theorem ofSubcontext_toSnocNotMem {Γ k} (Δ : Subcontext Γ) :
    ofSubcontext (toSnocNotMem Δ : Subcontext (Γ.snoc k)) =
      ofSubcontext Δ ≫ toSnoc :=
  rfl

instance ofSubcontext.Mono {Γ : Context}
    (Δ : Subcontext Γ) : Mono (ofSubcontext Δ) :=
  recOn Δ
    (by simp [ofSubcontext_nil_bot]; infer_instance)
    (fun _ _ _ h => by simp [ofSubcontext_toSnocMem]; infer_instance)
    (fun _ _ _ h => by simp [ofSubcontext_toSnocNotMem]; apply mono_comp)

def leRecOn {Γ : Context} {Δ₁ Δ₂ : Subcontext Γ} (h : Δ₁ ≤ Δ₂)
    {motive : (Γ : Context) → Subcontext Γ → SubContext Γ → Sort _}
    (start : motive )
    (snoc_mem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocMem Δ))
    (snoc_not_mem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocNotMem Δ)) :
    motive Γ Δ₁ → motive Γ Δ₂ :=
  recOn Δ₁
    (fun _ => nil)
    (fun _ _ _ => snoc_mem _ _ _)
    (fun _ _ _ => snoc_not_mem _ _ _)

def ofLE : {Γ : Context} → {Δ₁ Δ₂ : Subcontext Γ} → (h : Δ₁ ≤ Δ₂) →
    (Δ₁ : Context) ⟶ Δ₂
  | .nil, _, _, _ => by dsimp [toContext]; exact (𝟙 _)
  | .snoc _ k, Δ₁, Δ₂, h =>
    if h₁ : Δ₁ (Var.zero _ _)
    then by
      simp [h₁, toContext, le_def.1 h h₁]
      exact snocHom (ofLE (ofSnoc_monotone h))
    else
      if h₂ : Δ₂ (Var.zero _ _)
      then by
        simp [h₂, toContext, h₁]
        exact ofLE (ofSnoc_monotone h) ≫ toSnoc
      else by
        simp [h₁, h₂, toContext]
        exact ofLE (ofSnoc_monotone h)

@[simp]
theorem ofLE_refl : {Γ : Context} → {Δ : Subcontext Γ} → ofLE (le_refl Δ) = 𝟙 (Δ : Context)
  | .nil, _ => rfl
  | .snoc _ k, Δ => by
    funext k v
    dsimp [ofLE, toContext]
    split_ifs with h
    . simp only [h, ofLE, toContext]
      rw [cast_apply (α := Kind) (snocHom (ofLE (_ : ofSnoc Δ ≤ ofSnoc Δ))) k (by simp [h])]
      rw [cast_apply]

    . simp [h]

end Subcontext

end AST