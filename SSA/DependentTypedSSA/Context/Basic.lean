import Mathlib.CategoryTheory.EpiMono
import Mathlib.Data.Fintype.Basic
import SSA.DependentTypedSSA.Kind

namespace AST

inductive Context : Type
  | nil : Context
  | snoc : Context → Kind → Context

inductive Var : (Γ : Context) → Kind → Type where
  | zero (Γ : Context) (k : Kind) : Var (Γ.snoc k) k
  | succ {Γ : Context} {k₁ k₂ : Kind} : Var Γ k₁ → Var (Γ.snoc k₂) k₁
  deriving DecidableEq

@[elab_as_elim]
def Var.elim {Γ : Context} {k₁ : Kind} {motive : ∀ k₂, Var (Γ.snoc k₁) k₂ → Sort _} {k₂ : Kind} :
    ∀ (v : Var (Γ.snoc k₁) k₂)
    (_succ : ∀ k₂ v, motive k₂ (.succ v))
    (_zero : motive _ (.zero Γ k₁)) , motive _ v
  | .zero _ _, _, h => h
  | .succ v, hsucc, _ => hsucc _ v

@[simp]
theorem Var.elim_zero {Γ : Context} {k₁ : Kind} {motive : ∀ k₂, Var (Γ.snoc k₁) k₂ → Sort _}
    (succ : ∀ k₂ v, motive k₂ (.succ v))
    (zero : motive _ (.zero Γ k₁)) :
    (Var.elim (motive := motive) (Var.zero Γ k₁) succ zero) = zero :=
  rfl

@[simp]
theorem Var.elim_succ {Γ : Context} {k₁ : Kind} {motive : ∀ k₂, Var (Γ.snoc k₁) k₂ → Sort _}
    (v : Var Γ k₁) (succ : ∀ k₂ v, motive k₂ (.succ v))
    (zero : motive _ (.zero Γ k₁)) :
    (Var.elim (motive := motive) (.succ v) succ zero) = succ _ v :=
  rfl

instance Var.Fintype : ∀ (Γ : Context) (k : Kind), Fintype (Var Γ k)
  | .nil, _ => ⟨∅, fun v => by cases v⟩
  | Context.snoc Γ k₁, k₂ =>
    let F := Var.Fintype Γ k₂
    if h : k₁ = k₂
    then by
      subst h
      exact ⟨⟨Var.zero _ _ ::ₘ (F.elems.1.map Var.succ),
              Multiset.nodup_cons.2 ⟨by simp,
              (Multiset.nodup_map_iff_inj_on F.elems.2).2 (by simp)⟩⟩,
            fun v => by
              cases v <;> simp [Fintype.complete]⟩
    else ⟨F.elems.map ⟨Var.succ, fun _ => by simp⟩,
      fun v => by cases v <;> simp [Fintype.complete] at *⟩

namespace Context

open CategoryTheory

instance : Category Context where
  Hom := fun Γ₁ Γ₂ => ∀ ⦃k : Kind⦄, Var Γ₁ k → Var Γ₂ k
  id := fun Γ _ => id
  comp := fun f g k v => g (f v)

variable {Γ₁ Γ₂ Γ₃ : Context}

@[simp]
theorem id_apply (k : Kind) (v : Var Γ₁ k) : (𝟙 Γ₁) v = v :=
  rfl

@[simp]
theorem comp_apply (f : Γ₁ ⟶ Γ₂) (g : Γ₂ ⟶ Γ₃) (k : Kind) (v : Var Γ₁ k) :
    (f ≫ g) v = g (f v) :=
  rfl

def toSnoc {Γ : Context} {k : Kind} : Γ ⟶ (Γ.snoc k) :=
  fun _ v => v.succ

def snocElim {Γ₁ Γ₂  : Context} {k : Kind} (f : Γ₁ ⟶ Γ₂) (v : Var Γ₂ k) :
  (Γ₁.snoc k) ⟶ Γ₂ :=
  fun _ v₁ => v₁.elim f v

@[reassoc (attr := simp)]
theorem toSnoc_comp_snocElim {Γ₁ Γ₂  : Context} {k : Kind} (f : Γ₁ ⟶ Γ₂) (v : Var Γ₂ k) :
    toSnoc ≫ snocElim f v = f :=
  rfl

@[ext]
theorem snoc_ext {Γ₁ Γ₂  : Context} {k : Kind} {f g : Γ₁.snoc k ⟶ Γ₂}
    (h₁ : f (Var.zero _ _) = g (Var.zero _ _))
    (h₂ : toSnoc ≫ f = toSnoc ≫ g) : f = g := by
  funext k v
  cases v
  . exact h₁
  . exact Function.funext_iff.1 (Function.funext_iff.1 h₂ k) _

@[simp]
theorem snocElim_toSnoc_apply {Γ₁ Γ₂  : Context} {k k' : Kind} (f : Γ₁ ⟶ Γ₂) (v : Var Γ₂ k)
    (v' : Var Γ₁ k') : snocElim f v (toSnoc v') = f v' :=
  rfl

@[simp]
theorem snocElim_zero {Γ₁ Γ₂  : Context} {k : Kind} (f : Γ₁ ⟶ Γ₂) (v : Var Γ₂ k) :
    snocElim f v (Var.zero Γ₁ k) = v :=
  rfl

theorem snocElim_comp {Γ₁ Γ₂ Γ₃ : Context} {k : Kind} (f : Γ₁ ⟶ Γ₂) (v : Var Γ₂ k) (g : Γ₂ ⟶ Γ₃) :
    snocElim f v ≫ g = snocElim (f ≫ g) (g v) :=
  snoc_ext (by simp) (by simp)

def snocHom {Γ₁ Γ₂ : Context} (f : Γ₁ ⟶ Γ₂) : (Γ₁.snoc k ⟶ Γ₂.snoc k) :=
  snocElim (f ≫ toSnoc) (Var.zero _ _)

def append (Γ₁ : Context) : Context → Context
  | .nil => Γ₁
  | .snoc Γ₂ k => (Γ₁.append Γ₂).snoc k

instance : IsEmpty (Var (nil) k) where
  false := fun v => match v with.

instance (Γ : Context) : Unique (nil ⟶ Γ) where
  default := fun _ v => match v with.
  uniq := fun f => by funext k v; cases v

def single (k : Kind) : Context :=
  snoc nil k

instance : Unique (Var (single k) k) where
  default := Var.zero _ _
  uniq := fun v => match v with | Var.zero _ _ => rfl

instance : Subsingleton (Var (single k₁) k₂) :=
  ⟨fun v₁ v₂ => match v₁, v₂ with | Var.zero _ _, Var.zero _ _ => rfl⟩

def singleElim {Γ : Context} (v : Var Γ k) : single k ⟶ Γ :=
  snocElim default v

theorem singleElim_injective {Γ : Context} :
   Function.Injective (singleElim : Var Γ k → (single k ⟶ Γ)) :=
  fun v₁ v₂ h => by
    have : singleElim v₁ (Var.zero _ _) = singleElim v₂ (Var.zero _ _) := by rw [h]
    simpa using this

@[simp]
theorem singleElim_zero {Γ : Context} (v : Var Γ k) :
    singleElim v (Var.zero _ _) = v :=
  rfl

def inl {Γ₁ : Context} : {Γ₂ : Context} → Γ₁ ⟶ Γ₁.append Γ₂
  | .nil => 𝟙 _
  | .snoc _ _ => inl ≫ toSnoc

def inr {Γ₁ : Context} : {Γ₂ : Context} → Γ₂ ⟶ Γ₁.append Γ₂
  | .nil => default
  | .snoc _ _ => snocHom inr

def appendElim {Γ₁ : Context} : {Γ₂ Γ₃ : Context} → (Γ₁ ⟶ Γ₃) → (Γ₂ ⟶ Γ₃) → (Γ₁.append Γ₂ ⟶ Γ₃)
  | .nil, _, f, _ => f
  | .snoc _ _, _, f, g => snocElim (appendElim f (toSnoc ≫ g)) (g (Var.zero _ _))

@[reassoc (attr := simp)]
theorem inl_comp_appendElim {Γ₁ Γ₂ Γ₃ : Context} (f : Γ₁ ⟶ Γ₃) (g : Γ₂ ⟶ Γ₃) :
    inl ≫ appendElim f g = f :=
  by induction Γ₂ <;> simp [*, inl, appendElim] at *

@[reassoc (attr := simp)]
theorem inr_comp_appendElim {Γ₁ Γ₂ Γ₃ : Context} (f : Γ₁ ⟶ Γ₃) (g : Γ₂ ⟶ Γ₃) :
    inr ≫ appendElim f g = g := by
  induction Γ₂ <;> simp [*, inr, appendElim, snocHom, snocElim_comp] at *
  . apply snoc_ext
    . simp [inr, snocHom, appendElim]
    . simp [inr, snocHom, appendElim, snocElim_toSnoc_apply, *]

theorem append_ext : ∀ {Γ₁ Γ₂ Γ₃ : Context} {f g : Γ₁.append Γ₂ ⟶ Γ₃}
    (_h₁ : inl ≫ f = inl ≫ g)
    (_h₂ : inr ≫ f = inr ≫ g), f = g
  | _, .nil, _, _, _, h₁, _ => h₁
  | _, .snoc Γ₂ k, _, f, g, h₁, h₂ => snoc_ext
    (have : (inr ≫ f) (Var.zero _ _) = (inr ≫ g) (Var.zero _ _) := by rw [h₂]
     by simpa using this)
    (append_ext h₁
      (have : toSnoc ≫ (inr ≫ f) = toSnoc ≫ (inr ≫ g) := by rw [h₂]
       by simpa [inr, snocHom] using this))

@[simp]
theorem snocHom_id : snocHom (𝟙 Γ₁) = 𝟙 (Γ₁.snoc k) := by
  ext <;> simp [snocHom]

@[simp]
theorem snocHom_comp (f : Γ₁ ⟶ Γ₂) (g : Γ₂ ⟶ Γ₃) :
    (snocHom (f ≫ g) : Γ₁.snoc k ⟶ Γ₃.snoc k) =
    snocHom f ≫ snocHom g := by
  ext <;> simp [snocHom]

@[simp] theorem elim_snocHom {Γ₁ Γ₂ : Context} {k₁ : Kind}
    {motive : ∀ k₂, Var (Γ₂.snoc k₁) k₂ → Sort _} {k₂ : Kind}
    (f : Γ₁ ⟶ Γ₂) (v : Var (Γ₁.snoc k₁) k₂)
    (succ : ∀ k₂ v, motive k₂ (Var.succ v))
    (zero : motive k₁ (Var.zero _ _)) :
    (Var.elim (snocHom f v) succ zero : motive k₂ (snocHom f v)) =
    (Var.elim v (fun _ v => succ _ (f v)) zero) := by
  cases v <;> simp [Var.elim, snocHom, snocElim, toSnoc]

open Var

-- def _root_.AST.Var.preimage : {Γ₁ Γ₂ : Context} → (Γ₁ ⟶ Γ₂) → Var Γ₂ k → Option (Var Γ₁ k)
--   | nil, _, _, _ => none
--   | snoc _ k', _, f, v =>
--     match Var.preimage (toSnoc ≫ f) v with
--     | none => if h : ∃ h : k' = k, f (Var.zero _ _) = h ▸ v
--         then some (h.fst ▸ Var.zero _ _) else none
--     | some v' => some (toSnoc v')

-- theorem _root_.AST.Var.eq_of_mem_preimage : ∀ {Γ₁ Γ₂ : Context} {f : Γ₁ ⟶ Γ₂} {v : Var Γ₂ k}
--     {v' : Var Γ₁ k}, Var.preimage f v = some v' → f v' = v
--   | snoc _ k', _, f, v, v', h => by
--     simp only [Var.preimage] at h
--     cases h' : preimage (toSnoc ≫ f) v
--     . simp only [h'] at h
--       split_ifs at h with h₁
--       cases h
--       rcases h₁ with ⟨rfl, h₁⟩
--       exact h₁
--     . simp only [h', Option.some.injEq] at h
--       rw [← Var.eq_of_mem_preimage h', ← h]
--       simp

-- theorem _root_.AST.Var.preimage_eq_none_iff : ∀ {Γ₁ Γ₂ : Context} (f : Γ₁ ⟶ Γ₂) (v : Var Γ₂ k),
--     Var.preimage f v = none ↔ ∀ (v' : Var Γ₁ k), f v' ≠ v
--   | nil, _, _, _ => by simp [Var.preimage]
--   | snoc _ k', _, f, v => by
--       rw [Var.preimage]
--       cases h : preimage (toSnoc ≫ f) v
--       . rw [Var.preimage_eq_none_iff] at h
--         simp only [dite_eq_right_iff, forall_exists_index, ne_eq]
--         constructor
--         . intro h' v'
--           cases v'
--           . exact h' rfl
--           exact h _
--         . intro h' heq
--           cases heq
--           exact h' _
--       . simp only [ne_eq, false_iff, not_forall, not_not]
--         rw [← Var.eq_of_mem_preimage h]
--         simp

theorem mono_iff_injective {Γ₁ Γ₂ : Context} {f : Γ₁ ⟶ Γ₂} :
    Mono f ↔ (∀ k, Function.Injective (@f k)) := by
  constructor
  . intro h k v₁ v₂ hv
    refine singleElim_injective
      (Mono.right_cancellation (f := f)
        (singleElim v₁) (singleElim v₂) ?_)
    funext k v
    cases v with
    | zero _ _ => simp [hv]
    | succ v => cases v
  . intro h
    constructor
    intro Γ₃ g i gi
    funext k v
    apply h
    rw [← comp_apply g f, gi, comp_apply]

theorem injective {Γ₁ Γ₂ : Context} (f : Γ₁ ⟶ Γ₂) [Mono f] :
    ∀ k, Function.Injective (@f k) := by
  rw [← mono_iff_injective]; infer_instance

@[simp]
theorem eq_iff {Γ₁ Γ₂ : Context} (f : Γ₁ ⟶ Γ₂) [Mono f] {k : Kind} (v₁ v₂ : Var Γ₁ k) :
    f v₁ = f v₂ ↔ v₁ = v₂ := (injective f k).eq_iff

instance : Mono (@toSnoc Γ k) :=
  mono_iff_injective.2 (fun _ _ h => by simp [toSnoc] at *)

instance {k : Kind} (v : Var Γ k) : Mono (singleElim v) :=
  mono_iff_injective.2 (fun _ _ _ _ => Subsingleton.elim _ _)

instance (f : Γ₁ ⟶ Γ₂) [Mono f] : Mono (@snocHom k _ _ f) :=
  mono_iff_injective.2 <| fun k v₁ v₂ h => by
    cases v₁ <;> cases v₂ <;>
    simp [snocHom, snocElim, Var.elim, toSnoc] at *
    assumption

end Context

end AST
