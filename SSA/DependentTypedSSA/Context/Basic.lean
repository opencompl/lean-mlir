import Mathlib.CategoryTheory.EpiMono
import Mathlib.Data.Fintype.Basic
import SSA.DependentTypedSSA.Kind

namespace AST

def Context : Type 1 := Kind → Type

def Var : (Γ : Context) → Kind → Type := id

def Context.nil : Context := fun _ => Empty

inductive Context.snoc' (Γ : Context) (k : Kind) : Kind → Type
| zero : snoc' Γ k k
| succ : ∀ {k' : Kind}, Γ k' → snoc' Γ k k'

def Context.snoc (Γ : Context) (k : Kind) : Context :=
  Context.snoc' Γ k

def Var.succ {Γ : Context} {k₁ k₂ : Kind} (v : Var Γ k₁) : Var (Γ.snoc k₂) k₁ :=
  Context.snoc'.succ v

def Var.zero {Γ : Context} {k : Kind} : Var (Γ.snoc k) k :=
  Context.snoc'.zero

@[elab_as_elim]
def Var.elim {Γ : Context} {k₁ : Kind} {motive : ∀ k₂, Var (Γ.snoc k₁) k₂ → Sort _} {k₂ : Kind} :
    ∀ (v : Var (Γ.snoc k₁) k₂)
    (_succ : ∀ k₂ v, motive k₂ (.succ v))
    (_zero : motive _ .zero) , motive _ v
  | .zero, _, h => h
  | .succ v, hsucc, _ => hsucc _ v

@[simp]
theorem Var.elim_zero {Γ : Context} {k₁ : Kind} {motive : ∀ k₂, Var (Γ.snoc k₁) k₂ → Sort _}
    (succ : ∀ k₂ v, motive k₂ (.succ v))
    (zero : motive _ .zero) :
    (Var.elim (motive := motive) .zero succ zero) = zero :=
  rfl

@[simp]
theorem Var.elim_succ {Γ : Context} {k₁ : Kind} {motive : ∀ k₂, Var (Γ.snoc k₁) k₂ → Sort _}
    (v : Var Γ k₁) (succ : ∀ k₂ v, motive k₂ (.succ v))
    (zero : motive _ .zero) :
    (Var.elim (motive := motive) (.succ v) succ zero) = succ _ v :=
  rfl

-- instance Var.Fintype : ∀ (Γ : Context) (k : Kind), Fintype (Var Γ k)
--   | .nil, _ => ⟨∅, fun v => by cases v⟩
--   | Context.snoc Γ k₁, k₂ =>
--     let F := Var.Fintype Γ k₂
--     if h : k₁ = k₂
--     then by
--       subst h
--       exact ⟨⟨Var.zero _ _ ::ₘ (F.elems.1.map Var.succ),
--               Multiset.nodup_cons.2 ⟨by simp,
--               (Multiset.nodup_map_iff_inj_on F.elems.2).2 (by simp)⟩⟩,
--             fun v => by
--               cases v <;> simp [Fintype.complete]⟩
--     else ⟨F.elems.map ⟨Var.succ, fun _ => by simp⟩,
--       fun v => by cases v <;> simp [Fintype.complete] at *⟩

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
    (h₁ : f Var.zero = g Var.zero)
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
    snocElim f v Var.zero = v :=
  rfl

theorem snocElim_comp {Γ₁ Γ₂ Γ₃ : Context} {k : Kind} (f : Γ₁ ⟶ Γ₂) (v : Var Γ₂ k) (g : Γ₂ ⟶ Γ₃) :
    snocElim f v ≫ g = snocElim (f ≫ g) (g v) :=
  snoc_ext (by simp) (by simp)

def snocHom {Γ₁ Γ₂ : Context} (f : Γ₁ ⟶ Γ₂) : (Γ₁.snoc k ⟶ Γ₂.snoc k) :=
  snocElim (f ≫ toSnoc) Var.zero

@[simp]
theorem snocHom_id {Γ : Context} : snocHom (𝟙 Γ) = 𝟙 (Γ.snoc k) :=
  snoc_ext (by simp [snocHom]) (by simp [snocHom])

@[simp]
theorem snocHom_comp {Γ₁ Γ₂ Γ₃ : Context} {k : Kind} (f : Γ₁ ⟶ Γ₂) (g : Γ₂ ⟶ Γ₃) :
    (snocHom (f ≫ g) : Γ₁.snoc k ⟶ _) = snocHom f ≫ snocHom g :=
  snoc_ext (by simp [snocHom]) (by simp [snocHom])

@[simp] theorem elim_snocHom {Γ₁ Γ₂ : Context} {k₁ : Kind}
    {motive : ∀ k₂, Var (Γ₂.snoc k₁) k₂ → Sort _} {k₂ : Kind}
    (f : Γ₁ ⟶ Γ₂) (v : Var (Γ₁.snoc k₁) k₂)
    (succ : ∀ k₂ v, motive k₂ (Var.succ v))
    (zero : motive k₁ Var.zero) :
    (Var.elim (snocHom f v) succ zero : motive k₂ (snocHom f v)) =
    (Var.elim v (fun _ v => succ _ (f v)) zero) := by
  cases v <;> rfl

instance : IsEmpty (Var nil k) where
  false := fun v => match v with.

instance (Γ : Context) : Unique (nil ⟶ Γ) where
  default := fun _ v => match v with.
  uniq := fun f => by funext k v; cases v

def single (k : Kind) : Context :=
  fun k' => PLift (k' = k)

instance : Unique (Var (single k) k) where
  default := ⟨rfl⟩
  uniq := fun _ => rfl

instance : Subsingleton (Var (single k₁) k₂) :=
  ⟨fun v₁ v₂ => by cases v₁; cases v₂; rfl⟩

def singleElim {Γ : Context} (v : Var Γ k) : single k ⟶ Γ :=
  fun _ h => by rcases h with ⟨rfl⟩; exact v

theorem singleElim_injective {Γ : Context} :
    Function.Injective (singleElim : Var Γ k → (single k ⟶ Γ)) :=
  fun _ _ h => congr_fun (congr_fun h k) ⟨rfl⟩

open Var

theorem mono_iff_injective {Γ₁ Γ₂ : Context} {f : Γ₁ ⟶ Γ₂} :
    Mono f ↔ (∀ k, Function.Injective (@f k)) := by
  constructor
  . intro h k v₁ v₂ hv
    refine singleElim_injective
      (Mono.right_cancellation (f := f)
        (singleElim v₁) (singleElim v₂) ?_)
    funext k v
    rcases v with ⟨rfl⟩
    exact hv
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

instance {k : Kind} (v : Var Γ k) : Mono (singleElim v) :=
  mono_iff_injective.2 (fun _ _ _ _ => Subsingleton.elim _ _)

end Context

end AST
