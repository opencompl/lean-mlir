import SSA.DependentTypedSSA.Context.Basic
import Mathlib.Data.SetLike.Basic
import Mathlib.Order.Lattice
import Mathlib.Data.Bool.Basic
import Mathlib.Order.GaloisConnection

namespace AST

def Subcontext (Γ : Context) : Type :=
  ∀ ⦃k⦄, Var Γ k → Prop

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

@[simp]
theorem bot_apply {Γ : Context} {k : Kind} (v : Var Γ k) :
    (⊥ : Subcontext Γ) v = False :=
  rfl

theorem le_def : Δ₁ ≤ Δ₂ ↔ ∀ {k} {v : Var Γ k}, Δ₁ v → Δ₂ v :=
  Iff.rfl

def map {Γ₁ Γ₂ : Context} (f : Γ₁ ⟶ Γ₂) (Δ : Subcontext Γ₁) : Subcontext Γ₂ :=
  @fun _ v => (∃ v', Δ v' ∧ f v' = v)

theorem map_apply {Γ₁ Γ₂ : Context} (Δ : Subcontext Γ₁) (f : Γ₁ ⟶ Γ₂) (v : Var Γ₂ k) :
    map f Δ v = ∃ v', Δ v' ∧ f v' = v :=
  by simp [map]

def comap {Γ₁ Γ₂ : Context}(f : Γ₁ ⟶ Γ₂) (Δ : Subcontext Γ₂) : Subcontext Γ₁ :=
  @fun _ v => Δ (f v)

theorem comap_apply {Γ₁ Γ₂ : Context} (Δ : Subcontext Γ₂) (f : Γ₁ ⟶ Γ₂) (v : Var Γ₁ k) :
    comap f Δ v = Δ (f v) :=
  rfl

theorem map_comap_galoisConnection {Γ₁ Γ₂ : Context} (f : Γ₁ ⟶ Γ₂) :
    GaloisConnection (map f) (comap f) :=
  fun Δ₁ Δ₂ => (by simp [le_def, map, comap])

@[coe] def toContext {Γ : Context} (Δ : Subcontext Γ) : Context :=
  fun k => { v : Var Γ k // Δ v }

instance : Coe (Subcontext Γ) Context := ⟨toContext⟩

def ofSubcontext {Γ : Context} (Δ : Subcontext Γ) : (Δ : Context) ⟶ Γ :=
  fun _ v => v.val

instance ofSubcontext.Mono {Γ : Context}
    (Δ : Subcontext Γ) : Mono (ofSubcontext Δ) :=
  mono_iff_injective.2 (fun _ => Subtype.val_injective)

def restrictVar {Γ : Context} {k : Kind} {Δ : Subcontext Γ} :
    (v : Var Γ k) → Δ v → Var Δ k :=
  fun v hv => ⟨v, hv⟩

@[simp]
theorem ofSubcontext_restrictVar {Γ : Context} {k : Kind} {Δ : Subcontext Γ}
    {v : Var Γ k} (hv : Δ v) : ofSubcontext Δ (restrictVar v hv) = v :=
  rfl

@[simp]
theorem app_ofSubcontext {Γ : Context} (Δ : Subcontext Γ) (v : Var Δ k) :
    Δ (ofSubcontext (Δ : Subcontext Γ) v) :=
  v.2

def singleton {Γ : Context} {k : Kind} (v : Var Γ k) : Subcontext Γ :=
  fun k' v' => ∃ h : k = k', v = by rw [h]; exact v'

@[simp]
def singleton_apply_self {Γ : Context} {k : Kind} (v : Var Γ k) :
    singleton v v = true := by
  simp [singleton]

@[simp]
theorem singleton_le_iff {Γ : Context} {k : Kind} {v : Var Γ k}
    {Δ : Subcontext Γ} : singleton v ≤ Δ ↔ Δ v :=
  ⟨fun h => le_def.1 h (by simp [singleton]), fun h => le_def.2 <| by
    simp only [singleton, eq_mpr_eq_cast, decide_eq_true_eq, forall_exists_index]
    intro k' v' hk hv
    subst hk hv
    assumption⟩

def ofLE {Γ : Context} {Δ₁ Δ₂ : Subcontext Γ} (h : Δ₁ ≤ Δ₂) : (Δ₁ : Context) ⟶ Δ₂ :=
  fun k v => restrictVar (v := ofSubcontext Δ₁ v)  (le_def.1 h (by simp))

@[reassoc (attr := simp)]
theorem ofLE_comp_ofSubcontext {Γ : Context} {Δ₁ Δ₂ : Subcontext Γ} (h : Δ₁ ≤ Δ₂) :
    ofLE h ≫ ofSubcontext Δ₂ = ofSubcontext Δ₁ := by
  funext k v; simp [ofLE]

@[simp]
theorem ofSubcontext_ofLE_apply {Γ : Context} {Δ₁ Δ₂ : Subcontext Γ} (h : Δ₁ ≤ Δ₂) :
    ∀ (v : Var Δ₁ k), ofSubcontext Δ₂ (ofLE h v) = ofSubcontext Δ₁ v := by
  rw [←ofLE_comp_ofSubcontext h]; simp

@[simp]
theorem ofLE_refl {Γ : Context} {Δ : Subcontext Γ} : ofLE (le_refl Δ) = 𝟙 (Δ : Context) :=
  Mono.right_cancellation (f := ofSubcontext Δ) _ _ (by simp)

@[simp]
theorem ofLE_trans {Γ : Context} {Δ₁ Δ₂ Δ₃ : Subcontext Γ}
    (h₁ : Δ₁ ≤ Δ₂) (h₂ : Δ₂ ≤ Δ₃) :
    ofLE (le_trans h₁ h₂) = ofLE h₁ ≫ ofLE h₂ :=
  Mono.right_cancellation (f := ofSubcontext Δ₃) _ _ (by simp)

end Subcontext

end AST