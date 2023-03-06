import SSA.DependentTypedSSA.Context.Basic
import Mathlib.Data.SetLike.Basic
import Mathlib.Order.Lattice
import Mathlib.Data.Bool.Basic
import Mathlib.Order.GaloisConnection

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

@[mono]
theorem toSnocMem_monotone : {Γ : Context} → {k : Kind} → Monotone (@toSnocMem Γ k)
  | _, _, _, _, _, k, Var.zero _ _ => by
    simp [toSnocMem]
  | _, _, Δ₁, Δ₂, h, k, Var.succ v => by
    simp [toSnocMem]
    exact h _ v

def ofSnoc_toSnocMem_GaloisInsertion {Γ : Context} {k : Kind} :
    GaloisInsertion (@ofSnoc Γ k) (@toSnocMem Γ k) :=
  GaloisInsertion.monotoneIntro
    toSnocMem_monotone
    ofSnoc_monotone
    (fun a k v => by cases v <;> simp only [ofSnoc, toSnocMem, le_refl, Bool.le_true])
    (fun b => ext $ fun k v => by cases v <;> simp only [ofSnoc, toSnocMem])

@[simp]
theorem ofSnoc_toSnocMem {k : Kind} {Γ : Context} (Δ : Subcontext Γ) :
    ofSnoc (toSnocMem Δ : Subcontext (Γ.snoc k)) = Δ :=
  ofSnoc_toSnocMem_GaloisInsertion.l_u_eq _

@[simp]
theorem le_toSnocMem_iff {k : Kind} {Γ : Context} {Δ₁ : Subcontext (Γ.snoc k)}
    {Δ₂ : Subcontext Γ} : Δ₁ ≤ toSnocMem Δ₂ ↔ ofSnoc Δ₁ ≤ Δ₂  :=
  ofSnoc_toSnocMem_GaloisInsertion.gc.le_iff_le.symm

theorem toSnocMem_le_iff_le {k : Kind} {Γ : Context} {Δ₁ Δ₂  : Subcontext Γ} :
    (toSnocMem Δ₁ : Subcontext (Γ.snoc k)) ≤ toSnocMem Δ₂ ↔ Δ₁ ≤ Δ₂ :=
  ofSnoc_toSnocMem_GaloisInsertion.u_le_u_iff

def toSnocNotMem {k : Kind} (Δ : Subcontext Γ) : Subcontext (Γ.snoc k)
  | _, Var.zero _ _ => false
  | _, Var.succ v => Δ v

@[mono]
theorem toSnocNotMem_monotone : {Γ : Context} → {k : Kind} → Monotone (@toSnocNotMem Γ k)
  | _, _, _, _, _, k, Var.zero _ _ => by
    simp [toSnocNotMem]
  | _, _, Δ₁, Δ₂, h, k, Var.succ v => by
    simp [toSnocNotMem]
    exact h _ v

def toSnocNotMem_ofSnoc_GaloisCoinsertion {Γ : Context} {k : Kind} :
    GaloisCoinsertion (@toSnocNotMem Γ k) (@ofSnoc Γ k) :=
  GaloisCoinsertion.monotoneIntro
    ofSnoc_monotone
    toSnocNotMem_monotone
    (fun a k v => by cases v <;> simp [ofSnoc, toSnocNotMem])
    (fun b => by simp [ofSnoc, toSnocNotMem])

@[simp]
theorem toSnocNotMem_ofSnoc {k : Kind} {Γ : Context} (Δ : Subcontext Γ) :
    ofSnoc (toSnocNotMem Δ : Subcontext (Γ.snoc k)) = Δ :=
  toSnocNotMem_ofSnoc_GaloisCoinsertion.u_l_eq _

@[simp]
theorem toSnocNotMem_le_iff {k : Kind} {Γ : Context} {Δ₁ : Subcontext Γ}
    {Δ₂ : Subcontext (Γ.snoc k)} :
    (toSnocNotMem Δ₁ : Subcontext (Γ.snoc k)) ≤ Δ₂ ↔ Δ₁ ≤ ofSnoc Δ₂ :=
  toSnocNotMem_ofSnoc_GaloisCoinsertion.gc.le_iff_le

theorem toSnocNotMem_le_iff_le {k : Kind} {Γ : Context} {Δ₁ Δ₂  : Subcontext Γ} :
    (toSnocNotMem Δ₁ : Subcontext (Γ.snoc k)) ≤ toSnocNotMem Δ₂ ↔ Δ₁ ≤ Δ₂ :=
  toSnocNotMem_ofSnoc_GaloisCoinsertion.l_le_l_iff

@[simp]
theorem toSnocNotMem_le_toSnocMem {k : Kind} (Δ : Subcontext Γ) :
    (toSnocNotMem Δ : Subcontext (Γ.snoc k)) ≤ toSnocMem Δ :=
  fun k v => by cases v <;> simp [toSnocNotMem, toSnocMem]

@[simp]
theorem toSnocMem_not_le_toSnocNotMem {k : Kind} (Δ₁ Δ₂ : Subcontext Γ) :
    ¬(toSnocMem Δ₁ : Subcontext (Γ.snoc k)) ≤ toSnocNotMem Δ₂ :=
  fun h => absurd (h _ (Var.zero _ _)) (by simp [toSnocNotMem, toSnocMem])

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
    (snocMem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocMem Δ)) →
    (snocNotMem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
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
    (snocMem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocMem Δ))
    (snocNotMem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocNotMem Δ)) :
    recOn (⊥ : Subcontext Context.nil) nil snocMem snocNotMem = nil :=
  rfl

@[simp]
theorem recOn_toSnocMem {motive : (Γ : Context) → Subcontext Γ → Sort _}
    {Γ k} (Δ : Subcontext Γ)
    (nl : motive Context.nil ⊥)
    (snocMem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocMem Δ))
    (snocNotMem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocNotMem Δ)) :
    (recOn (toSnocMem Δ : Subcontext (Γ.snoc k)) nl snocMem snocNotMem
      : motive (Γ.snoc k) (toSnocMem Δ)) =
      snocMem _ _ _ (recOn Δ nl snocMem snocNotMem : motive Γ Δ) :=
  rfl

@[simp]
theorem recOn_toSnocNotMem {motive : (Γ : Context) → Subcontext Γ → Sort _}
    {Γ k} (Δ : Subcontext Γ)
    (nl : motive Context.nil ⊥)
    (snocMem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocMem Δ))
    (snocNotMem : ∀ (Γ k) (Δ : Subcontext Γ), motive  _ Δ →
      motive (Γ.snoc k) (toSnocNotMem Δ)) :
    (recOn (toSnocNotMem Δ : Subcontext (Γ.snoc k)) nl snocMem snocNotMem
      : motive (Γ.snoc k) (toSnocNotMem Δ)) =
      snocNotMem _ _ _ (recOn Δ nl snocMem snocNotMem : motive Γ Δ) :=
  rfl

@[coe] def toContext {Γ : Context} (Δ : Subcontext Γ) : Context :=
  recOn Δ
    Context.nil
    (fun _ k _ Γ => Γ.snoc k)
    (fun _ _ _ => id)

instance : Coe (Subcontext Γ) Context := ⟨toContext⟩

theorem toContext_nil : (⊥ : Subcontext Context.nil).toContext = Context.nil :=
  rfl

theorem toContext_toSnocMem {Γ k} (Δ : Subcontext Γ) :
    (toSnocMem Δ : Subcontext (Γ.snoc k)).toContext = (toContext Δ).snoc k :=
  rfl

theorem toContext_toSnocNotMem {Γ k} (Δ : Subcontext Γ) :
    (toSnocNotMem Δ : Subcontext (Γ.snoc k)).toContext = (Δ : Context) :=
  rfl

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

@[simp]
theorem app_ofSubcontext {Γ : Context} (Δ : Subcontext Γ) : ∀ (v : Var Δ k),
    Δ (ofSubcontext (Δ : Subcontext Γ) v) = true :=
  recOn Δ
    (fun v => by cases v)
    (fun Γ k Δ ih v => by
      cases v
      . rfl
      . exact ih _)
    (fun Γ k Δ ih v => ih _)

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

@[simp]
theorem bot_apply {Γ : Context} {k : Kind} (v : Var Γ k) :
    (⊥ : Subcontext Γ) v = false :=
  rfl

def restrictVar {Γ : Context} {k : Kind} {Δ : Subcontext Γ} :
    {v : Var Γ k} → Δ v → Var Δ k :=
  @fun v =>
  recOn Δ
    (fun _ h => by simp [bot_apply] at h)
    (fun Γ _ _ ih v =>
      v.elim
        (fun k v ih hv => toSnoc (ih v hv))
        (fun _ _ => Var.zero _ _)
        ih)
    (fun Γ _ _ ih v =>
      v.elim
        (fun k v ih hv => ih v hv)
        (fun _ h => by simp [toSnocNotMem] at h)
        ih) v

-- @[simp] theorem restrictVar_snocMem_succ {Γ : Context} {k : Kind} {v : Var Γ k₂}
--     {Δ : Subcontext Γ} (hv : (toSnocMem Δ v.succ)) :
--     restrictVar hv = restrictVar (show Δ v from _) :=
--   by cases v; rfl

@[simp]
theorem ofSubcontext_restrictVar {Γ : Context} {k : Kind} {Δ : Subcontext Γ} :
    {v : Var Γ k} → (hv : Δ v) → ofSubcontext Δ (restrictVar hv) = v :=
  @fun v =>
  recOn Δ
    (fun _ _ => Subsingleton.elim _ _)
    (fun Γ k Δ ih v hv => by
      cases v with
      | succ v => conv_rhs => rw [←ih v hv]
      | zero _ _ => rfl)
    (fun Γ k Δ ih v hv => by
      cases v with
      | succ v => conv_rhs => rw [←ih v hv]
      | zero _ _ => simp [toSnocNotMem] at hv)
    v

@[elab_as_elim]
def Var.subcontextCasesOn {Γ : Context} {k : Kind} {Δ : Subcontext Γ}
    {motive : Var Δ k → Sort _} (v : Var Δ k)
    (h : ∀ (v : Var Γ k) (hv : Δ v), motive (restrictVar hv)) : motive v := by
  convert h (ofSubcontext _ v) (app_ofSubcontext _ _)
  apply mono_iff_injective.1 (ofSubcontext.Mono Δ)
  simp

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

@[elab_as_elim]
def snocCasesOn {motive : (Γ : Context) → (k : Kind) → Subcontext (Γ.snoc k) → Sort _}
    {Γ : Context} {k : Kind}
    (Δ : Subcontext (Γ.snoc k))
    (snocMem : ∀ (Γ k) (Δ : Subcontext Γ), motive _ k (toSnocMem Δ))
    (snocNotMem : ∀ (Γ k) (Δ : Subcontext Γ),  motive _ k (toSnocNotMem Δ)) :
    motive _ _ Δ := by
  cases Δ using recOn with
  | snocMem Γ k Δ => exact snocMem _ _ _
  | snocNotMem Γ k Δ => exact snocNotMem _ _ _

@[simp]
theorem snocCasesOn_toSnocMem
    {motive : (Γ : Context) → (k : Kind) → Subcontext (Γ.snoc k) → Sort _}
    {Γ : Context} {k : Kind} (Δ : Subcontext Γ)
    (snocMem : ∀ (Γ k) (Δ : Subcontext Γ), motive _ k (toSnocMem Δ))
    (snocNotMem : ∀ (Γ k) (Δ : Subcontext Γ),  motive _ k (toSnocNotMem Δ)) :
    snocCasesOn (toSnocMem Δ) snocMem snocNotMem = snocMem Γ k Δ :=
  rfl

@[simp]
theorem snocCasesOn_toSnocNotMem
    {motive : (Γ : Context) → (k : Kind) → Subcontext (Γ.snoc k) → Sort _}
    {Γ : Context} {k : Kind} (Δ : Subcontext Γ)
    (snocMem : ∀ (Γ k) (Δ : Subcontext Γ), motive _ k (toSnocMem Δ))
    (snocNotMem : ∀ (Γ k) (Δ : Subcontext Γ),  motive _ k (toSnocNotMem Δ)) :
    snocCasesOn (toSnocNotMem Δ) snocMem snocNotMem = snocNotMem Γ k Δ :=
  rfl

def ofSubcontextSnocOfNotMem {Γ : Context} {k : Kind} {Δ : Subcontext (Γ.snoc k)}
    (h : ¬ Δ (Var.zero _ _)) : (Δ : Context) ⟶ Γ :=
  snocCasesOn Δ
    (fun _ _ _ h => by simp [toSnocMem] at h)
    (fun _ _ Δ _ => ofSubcontext Δ)
    h

@[simp]
theorem ofSubcontextSnocOfNotMem_restrictVar_succ
    {Γ : Context} {k₁ k₂ : Kind} {Δ : Subcontext (Γ.snoc k₁)}
    (h : ¬ Δ (Var.zero _ _)) (v : Var Γ k₂) (hv : Δ (Var.succ v)):
    ofSubcontextSnocOfNotMem h (restrictVar hv) = v := by
  induction Δ using snocCasesOn with
  | snocMem _ _ h => contradiction
  | snocNotMem _ _ Δ =>
      simp [ofSubcontextSnocOfNotMem, snocCasesOn_toSnocNotMem]
      have : restrictVar hv = @restrictVar _ _ Δ v hv := rfl
      rw [this, ofSubcontext_restrictVar]

end Subcontext

end AST