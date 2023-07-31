import Mathlib.Tactic

/-- A very simple type universe. -/
inductive Ty
  | nat
  | bool
  | fn : Ty → Ty → Ty
  deriving DecidableEq, Repr

@[reducible]
def Ty.toType
  | nat => Nat
  | bool => Bool
  | fn a b => a.toType → b.toType



def Ctxt : Type :=
  List Ty
  deriving DecidableEq

namespace Ctxt

def empty : Ctxt := []

instance : EmptyCollection Ctxt := ⟨Ctxt.empty⟩

def snoc : Ctxt → Ty → Ctxt :=
  fun tl hd => hd :: tl

def Var (Γ : Ctxt) (t : Ty) : Type :=
  { i : Nat // Γ.get? i = some t }

namespace Var

instance : DecidableEq (Var Γ t) := 
  fun ⟨i, ih⟩ ⟨j, jh⟩ => match inferInstanceAs (Decidable (i = j)) with
    | .isTrue h => .isTrue <| by simp_all
    | .isFalse h => .isFalse <| by intro hc; apply h; apply Subtype.mk.inj hc

def last (Γ : Ctxt) (t : Ty) : Ctxt.Var (Ctxt.snoc Γ t) t :=
  ⟨0, by simp[snoc, List.get?]⟩

def emptyElim {α : Sort _} {t : Ty} : Ctxt.Var ∅ t → α :=
  fun ⟨_, h⟩ => by contradiction

/-- Take a variable in a context `Γ` and get the corresponding variable
in context `Γ.snoc t`. This is marked as a coercion. -/
@[coe]
def toSnoc {Γ : Ctxt} {t' : Ty} ⦃t⦄ (var : Ctxt.Var Γ t) : Ctxt.Var (Ctxt.snoc Γ t') t  :=
  ⟨var.1+1, by cases var; simp_all[snoc]⟩
  
/-- This is an induction principle that case splits on whether or not a variable 
is the last variable in a context. -/
@[elab_as_elim]
def casesOn 
    {motive : (Γ : Ctxt) → (t t' : Ty) → Ctxt.Var (Γ.snoc t') t → Sort _}
    {Γ : Ctxt} {t t' : Ty} (v : (Γ.snoc t').Var t)
    (base : {t t' : Ty} → 
        {Γ : Ctxt} → (v : Γ.Var t) → motive Γ t t' v.toSnoc)
    (last : {Γ : Ctxt} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
      motive Γ t t' v :=
  match v with
    | ⟨0, h⟩ => 
        cast (by cases h; simp only [Var.last]) <| @last Γ t
    | ⟨i+1, h⟩ =>
        base ⟨i, h⟩

/-- `Ctxt.Var.casesOn` behaves in the expected way when applied to the last variable -/
@[simp]
def casesOn_last
    {motive : (Γ : Ctxt) → (t t' : Ty) → Ctxt.Var (Γ.snoc t') t → Sort _}
    {Γ : Ctxt} {t : Ty}
    (base : {t t' : Ty} → 
        {Γ : Ctxt} → (v : Γ.Var t) → motive Γ t t' v.toSnoc)
    (last : {Γ : Ctxt} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
    Ctxt.Var.casesOn (motive := motive)
        (Ctxt.Var.last Γ t) base last = last :=
  rfl

/-- `Ctxt.Var.casesOn` behaves in the expected way when applied to a previous variable,
that is not the last one. -/
@[simp]
def casesOn_toSnoc 
    {motive : (Γ : Ctxt) → (t t' : Ty) → Ctxt.Var (Γ.snoc t') t → Sort _}
    {Γ : Ctxt} {t t' : Ty} (v : Γ.Var t)
    (base : {t t' : Ty} → 
        {Γ : Ctxt} → (v : Γ.Var t) → motive Γ t t' v.toSnoc)
    (last : {Γ : Ctxt} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
      Ctxt.Var.casesOn (motive := motive) (Ctxt.Var.toSnoc (t' := t') v) base last = base v :=
  rfl

end Var


section Append

instance instAppend : Append (Ctxt) where
  append Γ₁ Γ₂ := List.append Γ₂ Γ₁

instance : HasSubset (Ctxt) where
  Subset Γ₁ Γ₂ := ∃ Δ, Γ₂ = Γ₁ ++ Δ

def drop : Nat → Ctxt → Ctxt := List.drop

theorem append_empty (Γ : Ctxt) : Γ ++ ∅ = Γ := by
  show List.append [] Γ = Γ  
  simp
  

theorem append_snoc (Γ Γ' : Ctxt) (t : Ty) : 
    Γ ++ (Ctxt.snoc Γ' t) = (Γ ++ Γ').snoc t := by
  show List.append (Ctxt.snoc Γ' t) Γ = snoc (List.append Γ' Γ) t
  simp only [snoc, List.append]

@[simp]
theorem _root_.List.get?_append_add :
    List.get? (xs ++ ys) (i + xs.length) = List.get? ys i := by
  induction xs
  . rfl
  next ih =>
    simp[List.get?]
    apply ih

def Var.inl {Γ Γ' : Ctxt} {t : Ty} : Var Γ t → Var (Γ ++ Γ') t
  | ⟨v, h⟩ => ⟨v + Γ'.length, by simp[←h, (· ++ ·), Append.append, List.get?_append_add]⟩

def Var.inr {Γ Γ' : Ctxt} {t : Ty} : Var Γ' t → Var (Γ ++ Γ') t
  | ⟨v, h⟩ => ⟨v, by 
      simp[(· ++ ·), Append.append]
      induction Γ' generalizing v
      case nil =>
        contradiction
      case cons ih =>
        cases v
        case zero =>
          rw[←h]; rfl
        case succ v =>
          apply ih v h
    ⟩

def Var.appendSplit {Γ₁} : Var (Γ₁ ++ Γ₂) t → (Var Γ₁ t) ⊕ (Var Γ₂ t) :=
  fun v => match Γ₂, v with 
    | [], v => .inl v
    | _::_, ⟨0, h⟩ => .inr ⟨0, h⟩
    | _::Γ, ⟨v+1, h⟩ => 
      match appendSplit (Γ₂:=Γ) ⟨v, h⟩ with
        | .inl v => .inl v
        | .inr v => .inr v.toSnoc


def Ctxt.subset_diff {Γ₁ Γ₂ : Ctxt} (h : Γ₁ ⊆ Γ₂) : {Δ : Ctxt // Γ₂ = Γ₁ ++ Δ} :=
  sorry

def Var.weaken {Γ₁ Γ₂ : Ctxt} {t} (h : Γ₁ ⊆ Γ₂) (v : Γ₁.Var t) : Γ₂.Var t :=
  let ⟨Δ, hΔ⟩ := Ctxt.subset_diff h
  hΔ ▸ @Var.inl Γ₁ Δ _ v
  

def hom (Γ₁ Γ₂ : Ctxt) : Type :=
  ⦃t : Ty⦄ → Γ₁.Var t → Γ₂.Var t


@[coe]
def hom.toSnocRight {Γ₁ Γ₂ : Ctxt} (f : Γ₁.hom Γ₂) : Γ₁.hom (Γ₂.snoc t) :=
  fun _ v => (f v).toSnoc

def hom.toSnoc {Γ₁ Γ₂ : Ctxt} (f : Γ₁.hom Γ₂) : (Γ₁.snoc t).hom (Γ₂.snoc t) :=
  fun _ v => by 
    cases v using Ctxt.Var.casesOn with
    | last => exact .last ..
    | base v => exact .toSnoc <| f v



end Append

end Ctxt