/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Finset.Union
import Mathlib.Tactic.DepRewrite

import SSA.Core.HVector

/--
  Typeclass for a `baseType` which is a Gödel code of Lean types.

  Intuitively, each `b : β` represents a Lean `Type`, but using `β` instead of `Type` directly
  avoids a universe bump
-/
class TyDenote (β : Type) : Type 1 where
  toType : β → Type
export TyDenote (toType)

notation "⟦" x "⟧" => TyDenote.toType x

instance : TyDenote Unit where toType := fun _ => Unit

structure Ctxt (Ty : Type) : Type where
  ofList :: toList : List Ty
  -- Erased <| List Ty
  deriving Repr, Lean.ToExpr, DecidableEq

attribute [coe] Ctxt.ofList

variable {Ty : Type} {Γ : Ctxt Ty} {ts : List Ty}
namespace Ctxt

/-! ### Typeclass Instances-/
section Instances

open Lean in
instance [ToMessageData Ty] : ToMessageData (Ctxt Ty) where
  toMessageData (Γ) := m!"{Γ.toList}"

instance : Coe (List Ty) (Ctxt Ty) where
  coe := ofList

end Instances

def empty : Ctxt Ty := .ofList []

instance : EmptyCollection (Ctxt Ty) := ⟨Ctxt.empty⟩
instance : Inhabited (Ctxt Ty) := ⟨Ctxt.empty⟩

lemma empty_eq : (∅ : Ctxt Ty) = .empty := rfl

@[match_pattern]
def snoc : Ctxt Ty → Ty → Ctxt Ty
  | ⟨tl⟩, hd => ⟨hd :: tl⟩

instance : GetElem? (Ctxt Ty) Nat Ty (fun as i => i < as.toList.length) where
  getElem xs i h := xs.toList[i]
  getElem? xs i  := xs.toList[i]?

instance instAppend : HAppend (Ctxt Ty) (List Ty) (Ctxt Ty) where
  hAppend Γ tys := ⟨tys ++ Γ.toList⟩

@[simp, deprecated "Use `getElem?`" (since := "")]
def get? : Ctxt Ty → Nat → Option Ty := (·[·]?)

/-- Map a function from one type universe to another over a context -/
def map (f : Ty₁ → Ty₂) : Ctxt Ty₁ → Ctxt Ty₂ :=
  ofList ∘ (List.map f) ∘ toList

def length (Γ : Ctxt Ty) : Nat := Γ.toList.length

section Lemmas
variable (Γ : Ctxt Ty) (ts us : List Ty)

@[simp] lemma snoc_inj : Γ.snoc t = Γ.snoc u ↔ t = u := by
  constructor <;> (rintro ⟨⟩; rfl)

variable {m} [Monad m] [LawfulMonad m] (t u : m _) in
@[simp] lemma snoc_map_inj : Γ.snoc <$> t = Γ.snoc <$> u ↔ t = u :=
  (map_inj_right (snoc_inj _).mp)

@[simp] lemma ofList_append : (⟨ts⟩ : Ctxt _) ++ us = us ++ ts := rfl
@[simp] lemma toList_append : (Γ ++ ts).toList = ts ++ Γ.toList := rfl

lemma getElem?_eq_toList_getElem? {i : Nat} : Γ[i]? = Γ.toList[i]? := rfl
@[simp] lemma getElem?_ofList (i : Nat) : (ofList ts)[i]? = ts[i]? := rfl

@[simp] lemma getElem?_snoc_zero (t : Ty)           : (Γ.snoc t)[0]? = some t := rfl
@[simp] lemma getElem?_snoc_succ (t : Ty) (i : Nat) : (Γ.snoc t)[i+1]? = Γ[i]? := rfl

@[simp] lemma map_nil (f : Ty → Ty') : map f ∅ = ∅ := rfl
@[simp] lemma map_snoc : (Γ.snoc a).map f = (Γ.map f).snoc (f a) := rfl

@[simp] lemma getElem?_map (Γ : Ctxt Ty) (f : Ty → Ty') (i : Nat) :
    (Γ.map f)[i]? = Γ[i]?.map f := by
  simp [map]; rfl

@[simp, grind=] lemma length_ofList : (ofList ts).length = ts.length := rfl
@[simp, grind=] lemma length_snoc (Γ : Ctxt α) (x : α) : (Γ.snoc x).length = Γ.length + 1 := rfl
@[simp, grind=] lemma length_map : (Γ.map f).length = Γ.length := by simp [map, length]
@[simp, grind=] lemma length_append : (Γ ++ ts).length = Γ.length + ts.length := by
  simp [length, Nat.add_comm]

instance : Functor Ctxt where
  map := map

@[simp] lemma map_eq_map : f <$> Γ = map f Γ := rfl

@[simp] lemma map_append (f : Ty₁ → Ty₂) (Γ : Ctxt Ty₁) (ts : List Ty₁) :
    (Γ ++ ts).map f = Γ.map f ++ (ts.map f) := by
  simp [map]

instance : LawfulFunctor Ctxt where
  comp_map  := by simp [(· <$> ·), map]
  id_map    := by simp [(· <$> ·), map]
  map_const := by simp only [Functor.mapConst, Functor.map, forall_const]

end Lemmas

section Rec

/-- Recursion principle for contexts in terms of `Ctxt.nil` and `Ctxt.snoc` -/
@[elab_as_elim, induction_eliminator]
def recOn' {motive : Ctxt Ty → Sort*}
    (nil  : motive empty)
    (snoc : (Γ : Ctxt Ty) → (t : Ty) → motive Γ → motive (Γ.snoc t)) :
    ∀ Γ, motive Γ
  | ⟨[]⟩        => nil
  | ⟨ty :: tys⟩ => snoc ⟨tys⟩ ty (recOn' nil snoc ⟨tys⟩)

end Rec

/-! ## Variables -/

def Var (Γ : Ctxt Ty) (t : Ty) : Type :=
  { i : Nat // Γ[i]? = some t }

namespace Var

/-- constructor for Var. -/
def mk {Γ : Ctxt Ty} {t : Ty} (i : Nat) (hi : Γ[i]? = some t) : Γ.Var t :=
  ⟨i, hi⟩

instance : DecidableEq (Var Γ t) := by
  delta Var
  infer_instance

@[match_pattern]
def last (Γ : Ctxt Ty) (t : Ty) : Ctxt.Var (Ctxt.snoc Γ t) t :=
  ⟨0, by rfl⟩

def emptyElim {α : Sort _} {t : Ty} : Ctxt.Var ∅ t → α :=
  fun ⟨_, h⟩ => by
    simp [getElem?_eq_toList_getElem?, EmptyCollection.emptyCollection, empty] at h

/-- Take a variable in a context `Γ` and get the corresponding variable
in context `Γ.snoc t`. This is marked as a coercion. -/
@[coe]
def toSnoc {Γ : Ctxt Ty} {t t' : Ty} (var : Var Γ t) : Var (snoc Γ t') t  :=
  ⟨var.1+1, var.2⟩

section Lemmas
variable {Γ : Ctxt Ty} {t : Ty}

lemma val_lt (v : Γ.Var t) : v.val < Γ.length := by
  rcases v with ⟨idx, h⟩
  suffices ¬(Γ.length ≤ idx) by grind
  rcases Γ
  simp only [length_ofList, ← List.getElem?_eq_none_iff]
  simp_all

@[simp] lemma zero_eq_last (h) : ⟨0, h⟩ = last Γ t := rfl
@[simp] lemma succ_eq_toSnoc {w} (h : (Γ.snoc t)[w+1]? = some t') :
    ⟨w+1, h⟩ = toSnoc ⟨w, h⟩ := rfl

end Lemmas

/-! ### toMap-/

/-- Transport a variable from `Γ` to any mapped context `Γ.map f` -/
def toMap : Var Γ t → Var (Γ.map f) (f t)
  | ⟨i, h⟩ => ⟨i, by simp_all⟩

@[simp]
theorem toMap_last {Γ : Ctxt Ty} {t : Ty} :
    (Ctxt.Var.last Γ t).toMap = Ctxt.Var.last (Γ.map f) (f t) := rfl

@[simp]
theorem toSnoc_toMap {Γ : Ctxt Ty} {t : Ty} {var : Ctxt.Var Γ t'} {f : Ty → Ty₂} :
    var.toSnoc.toMap (Γ := Γ.snoc t) (f := f) = var.toMap.toSnoc := rfl

/-! ### Cases -/

/-- This is an induction principle that case splits on whether or not a variable
is the last variable in a context. -/
@[elab_as_elim, cases_eliminator]
def casesOn
    {motive : (Γ : Ctxt Ty) → (t t' : Ty) → Ctxt.Var (Γ.snoc t') t → Sort _}
    {Γ : Ctxt Ty} {t t' : Ty} (v : (Γ.snoc t').Var t)
    (toSnoc : {t t' : Ty} →
        {Γ : Ctxt Ty} → (v : Γ.Var t) → motive Γ t t' v.toSnoc)
    (last : {Γ : Ctxt Ty} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
      motive Γ t t' v :=
  match v with
    | ⟨0, h⟩ =>
        _root_.cast (by
          obtain rfl : t' = t := by simpa [snoc] using h
          simp_all only [zero_eq_last]
          ) <| @last Γ t
    | ⟨i+1, h⟩ =>
        toSnoc ⟨i, by simpa [snoc] using h⟩

/-- `Ctxt.Var.casesOn` behaves in the expected way when applied to the last variable -/
@[simp]
def casesOn_last
    {motive : (Γ : Ctxt Ty) → (t t' : Ty) → Ctxt.Var (Γ.snoc t') t → Sort _}
    {Γ : Ctxt Ty} {t : Ty}
    (base : {t t' : Ty} →
        {Γ : Ctxt Ty} → (v : Γ.Var t) → motive Γ t t' v.toSnoc)
    (last : {Γ : Ctxt Ty} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
    Ctxt.Var.casesOn (motive := motive)
        (Ctxt.Var.last Γ t) base last = last :=
  rfl

/-- `Ctxt.Var.casesOn` behaves in the expected way when applied to a previous variable,
that is not the last one. -/
@[simp]
def casesOn_toSnoc
    {motive : (Γ : Ctxt Ty) → (t t' : Ty) → Ctxt.Var (Γ.snoc t') t → Sort _}
    {Γ : Ctxt Ty} {t t' : Ty} (v : Γ.Var t)
    (base : {t t' : Ty} →
        {Γ : Ctxt Ty} → (v : Γ.Var t) → motive Γ t t' v.toSnoc)
    (last : {Γ : Ctxt Ty} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
      Ctxt.Var.casesOn (motive := motive) (Ctxt.Var.toSnoc (t' := t') v) base last = base v :=
  rfl

theorem toSnoc_injective {Γ : Ctxt Ty} {t t' : Ty} :
    Function.Injective (@Ctxt.Var.toSnoc Ty Γ t t') := by
  let ofSnoc : (Γ.snoc t').Var t → Option (Γ.Var t) :=
    fun v => Ctxt.Var.casesOn v some none
  intro x y h
  simpa (config := { zetaDelta := true }) only [Var.casesOn_toSnoc, Option.some.injEq] using
    congr_arg ofSnoc h

/-! ### Var cast -/

def cast {Γ : Ctxt Op} (h_eq : ty₁ = ty₂) : Γ.Var ty₁ → Γ.Var ty₂
  | ⟨i, h⟩ => ⟨i, h_eq ▸ h⟩

def castCtxt {Γ : Ctxt Op} (h_eq : Γ = Δ) : Γ.Var ty → Δ.Var ty
  | ⟨i, h⟩ => ⟨i, h_eq ▸ h⟩

section Lemmas
variable {t} (v : Var Γ t)

@[simp] lemma cast_rfl (h : t = t) : v.cast h = v := rfl

@[simp] lemma castCtxt_rfl (h : Γ = Γ) : v.castCtxt h = v := rfl
@[simp] lemma castCtxt_castCtxt (h₁ : Γ = Δ) (h₂ : Δ = Ξ) :
    (v.castCtxt h₁).castCtxt h₂ = v.castCtxt (by simp [*]) := by subst h₁ h₂; simp

@[simp] lemma cast_mk : cast h ⟨vi, hv⟩ = ⟨vi, h ▸ hv⟩ := rfl
@[simp] lemma castCtxt_mk : castCtxt h ⟨vi, hv⟩ = ⟨vi, h ▸ hv⟩ := rfl

@[simp] lemma val_cast : (cast h v).val = v.val := rfl
@[simp] lemma val_castCtxt : (castCtxt h v).val = v.val := rfl

end Lemmas

/-! ### Var Append -/

def appendInl (v : Γ.Var t) : (Γ ++ ts).Var t :=
  ⟨v.1 + ts.length, by
      have := v.prop
      rcases Γ
      simp_all [List.getElem?_append_right]
    ⟩
instance : Coe (Γ.Var t) ((Γ ++ ts).Var t) where coe := appendInl

def appendInr : Var ⟨ts⟩ t → (Γ ++ ts).Var t
  | ⟨v, h⟩ => ⟨v, by
      rcases Γ
      have : v < ts.length := by
        suffices ¬(ts.length ≤ v) by omega
        rw [← List.getElem?_eq_none_iff]
        simp_all
      simp_all [List.getElem?_append_left]
    ⟩

@[elab_as_elim]
def appendCases
    {motive : (Γ ++ ts).Var t → Sort u}
    (left : (v : Var Γ t) → motive (appendInl v))
    (right : (v : Var ⟨ts⟩ t) → motive (appendInr v)) :
    (v : (Γ ++ ts).Var t) → motive v
  | ⟨idx, h⟩ =>
    if hv : idx < ts.length then
      let v' : Var _ _ := ⟨idx, by
        rcases Γ; simp_all [List.getElem?_append_left]
      ⟩
      right v'
    else
      let v' : Var _ _ := ⟨idx - ts.length, by
        rcases Γ; simp_all [List.getElem?_append_right]
      ⟩
      have eq : v'.appendInl = ⟨idx, h⟩ := by
        show Subtype.mk _ _ = _
        simp [v']; omega
      eq ▸ left v'

section Lemmas
variable {t : Ty} {v : Γ.Var t}

@[simp] lemma val_appendInl {v : Γ.Var t} : (v.appendInl (ts := ts)).val = v.val + ts.length := rfl
@[simp] lemma val_appendInr {v : Var ts t}  : (v.appendInr (Γ := Γ)).val = v.val := rfl

@[simp] theorem appendCases_appendInl (v : Γ.Var t) :
    appendCases (motive := motive) left right v.appendInl = (left v) := by
  rename_i ts
  rcases v with ⟨idx, h⟩
  have : ¬ idx + ts.length < ts.length := by omega
  apply eq_of_heq
  simp only [appendInl, appendCases, this, ↓reduceDIte, eqRec_heq_iff_heq]
  congr
  omega

@[simp] theorem lt_length (v : Γ.Var t) : v.1 < Γ.length := by
  rcases v with ⟨idx, h⟩
  simp only [Ctxt.length]
  suffices ¬ Γ.toList.length ≤ idx by omega
  simp only [getElem?_eq_toList_getElem?] at h
  simp [← List.getElem?_eq_none_iff, h]

@[simp] theorem appendCases_appendInr (v : Γ.Var t) :
    appendCases (motive := motive) left right v.appendInr = (right v) := by
  have : v.1 < Γ.toList.length := v.lt_length
  rcases v with ⟨idx, h⟩
  simp [appendInr, appendCases, this]

end Lemmas

/-! ### Var Fin Helpers -/

def toFin (v : Γ.Var t) : Fin Γ.length :=
  ⟨v.val, v.val_lt⟩

def ofFin (i : Fin Γ.length) : Γ.Var (Γ[i]) :=
  ⟨i.val, by simpa using List.getElem?_eq_getElem _⟩

def ofFinCases
    {motive : ∀ {t}, Γ.Var t → Sort u}
    (ofFin : (i : Fin Γ.length) → motive (ofFin i))
    (v : Γ.Var t) :
    motive v := by
  let i := ofFin v.toFin
  rcases v with ⟨v, hv⟩
  refine _root_.cast ?h i
  simp [Var.toFin, Var.ofFin]
  stop
  congr
  · rcases Γ
    simp_all



end Var

end Ctxt
open Ctxt

/-!
### Indexing an HVector by `Var`
Note that a `Var` is quite similar to a `Fin`, plus a static proof of the item
at the particular index. This extra knowledge is useful when indexing into an
HVector as well.
-/
instance : GetElem (HVector A as) (Ctxt.Var ⟨as⟩ a) (A a) (fun _ _ => True) where
  getElem xs i _ := (cast · <| xs.get i.toFin) <| by
    congr 1
    rcases i with ⟨i, h⟩
    simpa [Ctxt.Var.toFin, List.getElem_eq_iff] using h

@[simp] lemma HVector.getElem_eq_get (xs : HVector A as) (i : Fin as.length) :
    xs[Ctxt.Var.ofFin i] = xs.get i := rfl
@[simp] lemma HVector.getElem_map (xs : HVector A as) (v : Var ⟨as⟩ a) :
    (xs.map f)[v] = f _ xs[v] := by
  cases v using Var.ofFinCases
  rw [HVector.getElem_eq_get, HVector.getElem_eq_get]
  simp only [length_ofList, get_map, List.get_eq_getElem]
  rfl

namespace Ctxt
/-!
## Context Homomorphisms
-/

abbrev Hom (Γ Γ' : Ctxt Ty) := ⦃t : Ty⦄ → Γ.Var t → Γ'.Var t

@[simp]
abbrev Hom.id {Γ : Ctxt Ty} : Γ.Hom Γ :=
  fun _ v => v

/-! ### Morphism Composition -/
section Comp
variable {Γ Δ Ξ : Ctxt Ty} (f : Hom Γ Δ) (g : Hom Δ Ξ)

/-- `f.comp g := g(f(x))` -/
def Hom.comp : Hom Γ Ξ :=
  fun _t v => g (f v)

@[simp, grind=] lemma Hom.comp_apply : f.comp g v = g (f v) := rfl

end Comp

/--
  `map.with v₁ v₂` adjusts a vector of variables of a Context map, so that in
  the resulting map:
   * `v₁[i]` now maps to `v₂[i]`
   * all other variables `v` still map to `map v` as in the original map
-/
def Hom.with [DecidableEq Ty] {Γ₁ Γ₂ : Ctxt Ty} (f : Γ₁.Hom Γ₂) {ts}
    (v₁ : HVector Γ₁.Var ts) (v₂ : HVector Γ₂.Var ts) : Γ₁.Hom Γ₂ :=
  fun _ w =>
    match v₁.idxOf? w with
    | none => f w
    | some ⟨i, h⟩ => (v₂.get i).cast h

def Hom.snocMap {Γ Γ' : Ctxt Ty} (f : Hom Γ Γ') {t : Ty} :
    (Γ.snoc t).Hom (Γ'.snoc t) := by
  intro t' v
  cases v using Ctxt.Var.casesOn with
  | toSnoc v => exact Ctxt.Var.toSnoc (f v)
  | last => exact Ctxt.Var.last _ _

@[simp] lemma Hom.snocMap_last {Γ Γ' : Ctxt Ty} (f : Hom Γ Γ') {t : Ty} :
    (f.snocMap (Ctxt.Var.last Γ t)) = Ctxt.Var.last Γ' t := rfl
@[simp] lemma Hom.snocMap_toSnoc {Γ Γ' : Ctxt Ty} (f : Hom Γ Γ') {t t' : Ty} (v : Γ.Var t') :
    (f.snocMap v.toSnoc (t := t)) = (f v).toSnoc := rfl

@[simp]
abbrev Hom.snocRight {Γ Γ' : Ctxt Ty} (f : Hom Γ Γ') {t : Ty} : Γ.Hom (Γ'.snoc t) :=
  fun _ v => (f v).toSnoc

/-- Remove a type from the domain (left) context -/
def Hom.unSnoc (f : Hom (Γ.snoc t) Δ) : Hom Γ Δ :=
  fun _ v => f v.toSnoc

@[simp] lemma Hom.unSnoc_apply {Γ : Ctxt Ty} (f : Hom (Γ.snoc t) Δ) (v : Var Γ u) :
    f.unSnoc v = f v.toSnoc := rfl

instance : Coe (Γ.Var t) ((Γ.snoc t').Var t) := ⟨Ctxt.Var.toSnoc⟩

/-! ### Append -/

/--
Lift a context morphism `f` from context `Γ` to context `Δ` into a morphism
where a list of types `ts` is appended to *both* the domain and codomain.
That is, on any variables in the original domain `Γ`, `f.append` acts like `f`,
but on any *new* variables, in the appended list of types `ts`, `f.append`
maps to the corresponding new variable in the codomain (`Δ ++ ts`).
-/
def Hom.append {ts : List Ty} (f : Γ.Hom Δ) : Hom (Γ ++ ts) (Δ ++ ts) :=
  fun _ => Var.appendCases
    (fun v => (f v).appendInl)
    (fun v => v.appendInr)

/--
Lift a context morphism `f` from context `Γ` to context `Δ` into a morphism
where a list of types is appended to just to codomain `Δ`.
-/
def Hom.appendCodomain {ts : List Ty} (f : Γ.Hom Δ) : Hom Γ (Δ ++ ts) :=
  fun _ v => (f v).appendInl

section Lemmas

@[simp] theorem Hom.append_appendInl (f : Γ.Hom Δ) (v : Γ.Var t) :
    (f.append (ts := ts)) v.appendInl = (f v).appendInl := by
  simp [append]

@[simp] theorem Hom.append_appendInr (f : Γ.Hom Δ) (v : Var ⟨ts⟩ t) :
    (f.append (ts := ts)) v.appendInr = v.appendInr := by
  simp [append]

@[simp] theorem Hom.appendCodomain_apply (f : Γ.Hom Δ) (v : Γ.Var t) :
    (f.appendCodomain (ts := ts)) v = (f v).appendInl :=
  rfl

@[simp] lemma Hom.id_append : (Hom.id (Γ:=Γ)).append (ts := ts) = .id := by
  funext t v; cases v using Var.appendCases <;> simp [id, append]

end Lemmas

/-! ### Cast -/

variable {Γ Δ Δ' : Ctxt Ty} in
def Hom.castCodomain (h : Δ = Δ') (f : Γ.Hom Δ) : Γ.Hom Δ' :=
  fun _t v => (f v).castCtxt h

@[simp] lemma Hom.castDomain_apply {h : Δ = Δ'} {f : Γ.Hom Δ} {v : Γ.Var t} :
    f.castCodomain h v = (f v).castCtxt h := rfl

/-!
## Context Valuations
-/
section Valuation
variable [TyDenote Ty]
-- ^^ for a valuation, we need to evaluate the Lean `Type` corresponding to a `Ty`

/-- A valuation for a context. Provide a way to evaluate every variable in a context. -/
def Valuation (Γ : Ctxt Ty) : Type :=
  ⦃t : Ty⦄ → Γ.Var t → (toType t)

/-- A valuation for a context. Provide a way to evaluate every variable in a context. -/
def Valuation.eval {Γ : Ctxt Ty} (VAL : Valuation Γ) ⦃t : Ty⦄ (v : Γ.Var t) : toType t :=
    VAL v

/-- Make a valuation for the empty context. -/
def Valuation.nil : Ctxt.Valuation (∅ : Ctxt Ty) := fun _ v => v.emptyElim

instance : Inhabited (Ctxt.Valuation (∅ : Ctxt Ty)) := ⟨Valuation.nil⟩

/-- Make a valuation for `Γ.snoc t` from a valuation for `Γ` and an element of `t.toType`. -/
def Valuation.snoc {Γ : Ctxt Ty} {t : Ty} (s : Γ.Valuation) (x : toType t) :
    (Γ.snoc t).Valuation := by
  intro t' v
  revert s x
  refine Ctxt.Var.casesOn v ?_ ?_
  · intro _ _ _ v s _; exact s v
  · intro _ _ _ x; exact x

infixl:50 "::ᵥ" => Valuation.snoc

/-- Show the equivalence between the definition in terms of `snoc` and `snoc'`. -/
theorem Valuation.snoc_eq {Γ : Ctxt Ty} {t : Ty} (s : Γ.Valuation) (x : toType t) :
    (s.snoc x) = fun t var => match var with
      | ⟨0, hvar⟩ => by
          obtain rfl : _ = t := by simpa using hvar
          exact x
      | ⟨.succ i, hvar⟩ => s ⟨i, hvar⟩ := by
  funext t' v
  rcases v with ⟨⟨⟩|i, hi⟩
  · injection hi with hi
    subst hi
    rfl
  · rfl

@[simp]
theorem Valuation.snoc_last {t : Ty} (s : Γ.Valuation) (x : toType t) :
    (s.snoc x) (Ctxt.Var.last _ _) = x :=
  rfl

@[simp]
theorem Valuation.snoc_zero {ty : Ty} (s : Γ.Valuation) (x : toType ty)
    (h : (Ctxt.snoc Γ ty)[0]? = some ty) :
    (s.snoc x) ⟨0, h⟩ = x :=
  rfl

@[simp] lemma Valuation.snoc_toSnoc {t t' : Ty} (s : Γ.Valuation)
    (x : toType t) (v : Γ.Var t') :
    (s.snoc x) v.toSnoc = s v :=
  rfl

@[simp] lemma Valuation.snoc_inj {t : Ty} {x y : ⟦t⟧} :
    (V ::ᵥ x) = (V ::ᵥ y) ↔ x = y where
  mpr := by rintro rfl; rfl
  mp := by
    intro h
    rw [← snoc_last V x, ← snoc_last V y, h]

variable {m} [Monad m] [LawfulMonad m] in
@[simp] lemma Valuation.snoc_map_inj {V : Γ.Valuation} {x y : m ⟦t⟧} :
    (V.snoc <$> x) = (V.snoc <$> y) ↔ x = y :=
  map_inj_right <| Valuation.snoc_inj.mp

/-!
# Helper to simplify context manipulation with toSnoc and variable access.
-/
/--  (ctx.snoc v₁) ⟨n+1, _⟩ = ctx ⟨n, _⟩ -/
@[simp]
theorem Valuation.snoc_eval {ty : Ty} (Γ : Ctxt Ty) (V : Γ.Valuation) (v : ⟦ty⟧)
    (hvar : (Ctxt.snoc Γ ty)[n+1]? = some var_val) :
    (V.snoc v) ⟨n+1, hvar⟩ = V ⟨n, by simpa using hvar⟩ :=
  rfl

/-- There is only one distinct valuation for the empty context -/
theorem Valuation.eq_nil (V : Valuation (empty : Ctxt Ty)) : V = Valuation.nil := by
  funext _ ⟨_, h⟩; contradiction

@[simp]
theorem Valuation.snoc_toSnoc_last {Γ : Ctxt Ty} {t : Ty} (V : Valuation (Γ.snoc t)) :
    snoc (fun _ v' => V v'.toSnoc) (V <|.last ..) = V := by
  funext _ v
  cases v using Var.casesOn <;> rfl

/-! ## Valuation Append -/

instance (Γ : Ctxt Ty) (ts : List Ty) : HAppend (Valuation Γ) (HVector toType ts) (Valuation <| Γ ++ ts) where
  hAppend V vals := fun t v =>
    v.appendCases (@V t) (vals[·])

variable {V : Γ.Valuation} {xs : HVector toType ts}

@[simp] theorem Valuation.append_appendInl {v : Γ.Var t} :
    (V ++ xs) v.appendInl = V v := by
  simp [(· ++ ·)]

@[simp] theorem Valuation.append_appendInr {v : Var ⟨ts⟩ t} :
    (V ++ xs) v.appendInr = xs[v] := by
  simp [(· ++ ·)]

@[simp] lemma Valuation.append_inj {V : Γ.Valuation}
    {ts : List Ty} {xs ys : HVector toType ts} :
    (V ++ xs) = (V ++ ys) ↔ xs = ys where
  mpr := by rintro rfl; rfl
  mp := by
    intro h
    replace h {t} (v : Var _ t) : (V ++ xs) v.appendInr = (V ++ ys) v.appendInr := by
      rw [h]
    simp only [append_appendInr] at h
    ext i
    exact h (Var.ofFin i)

/-! ## Valuation Construction Helpers -/

/-- Make a a valuation for a singleton value -/
def Valuation.singleton {t : Ty} (v : toType t) : Ctxt.Valuation ⟨[t]⟩ :=
  Ctxt.Valuation.nil.snoc v

/-- Build valuation from a vector of values of types `types`. -/
def Valuation.ofHVector {types : List Ty} : HVector toType types → Valuation (Ctxt.ofList types)
  | .nil        => (default : Ctxt.Valuation ∅)
  | .cons x xs  => (Valuation.ofHVector xs).snoc x

/-- Build valuation from a vector of values of types `types`. -/
def Valuation.ofPair  {t₁ t₂ : Ty} (v₁: ⟦t₁⟧) (v₂ : ⟦t₂⟧) :
    Valuation (Ctxt.ofList [t₁, t₂]) :=
  Valuation.ofHVector (.cons v₁ <| .cons v₂ <| .nil )

@[simp]
theorem Valuation.ofPair_fst {t₁ t₂ : Ty} (v₁: ⟦t₁⟧) (v₂ : ⟦t₂⟧) :
  (Ctxt.Valuation.ofPair v₁ v₂) ⟨0, by rfl⟩ = v₁ := rfl
@[simp]
theorem Valuation.ofPair_snd {t₁ t₂ : Ty} (v₁: ⟦t₁⟧) (v₂ : ⟦t₂⟧) :
  (Ctxt.Valuation.ofPair v₁ v₂) ⟨1, by rfl⟩ = v₂ := rfl

/-! ### Valuation Pullback (comap) -/

/-- transport/pullback a valuation along a context homomorphism. -/
def Valuation.comap {Γi Γo : Ctxt Ty} (Γiv: Γi.Valuation) (hom : Ctxt.Hom Γo Γi) : Γo.Valuation :=
  fun _to vo => Γiv (hom vo)

@[simp] theorem Valuation.comap_apply {Γi Γo : Ctxt Ty}
    (V : Γi.Valuation) (f : Ctxt.Hom Γo Γi) (v : Γo.Var t) :
    V.comap f v = V (f v) := rfl

@[simp] theorem Valuation.comap_comap {Γ Δ Ξ : Ctxt Ty} (V : Γ.Valuation) (f : Δ.Hom Γ) (g : Ξ.Hom Δ) :
    (V.comap f).comap g = V.comap (fun _t v => f (g v)) := rfl

@[simp] theorem Valuation.comap_snoc_snocMap {Γ Γ_out : Ctxt Ty}
    (V : Γ_out.Valuation) {t} (x : ⟦t⟧) (map : Γ.Hom Γ_out) :
    Valuation.comap (Valuation.snoc V x) (Ctxt.Hom.snocMap map)
    = Valuation.snoc (Valuation.comap V map) x := by
  funext t' v
  cases v using Var.casesOn <;> rfl

@[simp] lemma Valuation.comap_id {Γ : Ctxt Ty} (Γv : Valuation Γ) : comap Γv Hom.id = Γv := rfl
@[simp] lemma Valuation.comap_snoc_snocRight {Γ Δ : Ctxt Ty} (Γv : Valuation Γ) (f : Hom Δ Γ) :
    comap (Γv.snoc x) (f.snocRight) = comap Γv f :=
  rfl

@[simp] lemma Valuation.comap_append_append {Γ Δ : Ctxt Ty} {ts : List Ty}
    (V : Γ.Valuation) (xs : HVector toType ts)
    (f : Δ.Hom Γ) :
    (V ++ xs).comap (f.append) = (V.comap f) ++ xs := by
  funext t v; cases v using Var.appendCases <;> simp

@[simp] lemma Valuation.comap_appendCodomain {Γ Δ : Ctxt Ty} {ts : List Ty}
    (V : Γ.Valuation) (xs : HVector toType ts) (f : Δ.Hom Γ) :
    (V ++ xs).comap f.appendCodomain = V.comap f := by
  funext t v; simp

/-! ### Reassign Variables-/

/-- Reassign the variable var to value val in context ctxt -/
def Valuation.reassignVars [DecidableEq Ty] {ts : List Ty} {Γ : Ctxt Ty}
    (V : Γ.Valuation) (var : HVector Γ.Var ts) (val : HVector toType ts) : Γ.Valuation :=
  fun _ vneedle =>
    match var.idxOf? vneedle with
    | none => V vneedle
    | some ⟨i, h⟩ => h ▸ val.get i

-- @[simp] lemma Valuation.reassignVars_apply_same [DecidableEq Ty] (V : Γ.Valuation) :
--     V.reassignVars v x v = x := by
--   simp [reassignVar]

-- @[simp] lemma Valuation.reassignVar_apply_of_neq [DecidableEq Ty] (V : Γ.Valuation)
--     (h : v ≠ w) :
--     V.reassignVar v x w = V w := by
--   simp only [reassignVar, exists_const, dite_eq_ite, ite_eq_right_iff]
--   rintro rfl
--   contradiction

@[simp] lemma Valuation.reassignVars_eq [DecidableEq Ty] (V : Γ.Valuation) :
    V.reassignVars vs (vs.map V) = V := by
  sorry
--   funext t w
--   simp only [reassignVar, dite_eq_right_iff, forall_exists_index]
--   rintro rfl rfl
  -- rfl

@[simp] lemma Valuation.comap_with [DecidableEq Ty] {Γ Δ : Ctxt Ty}
    {V : Valuation Γ} {map : Δ.Hom Γ} {vs : HVector Δ.Var ty} {ws : HVector Γ.Var ty} :
    V.comap (map.with vs ws) = (V.comap map).reassignVars vs (ws.map V) := by
  funext t' v'
  simp only [comap, Hom.with, reassignVars]
  split <;> aesop

/-! ### Recursion -/

/-- Recursion principle for valuations in terms of `Valuation.nil` and `Valuation.snoc` -/
@[elab_as_elim, induction_eliminator]
def Valuation.recOn {motive : ∀ {Γ : Ctxt Ty}, Γ.Valuation → Sort*}
    (nil  : motive (Valuation.nil))
    (snoc : ∀ {Γ t} (V : Valuation Γ) (v : ⟦t⟧), motive V → motive (Valuation.snoc V v)) :
    ∀ {Γ} (V : Valuation Γ), motive V := by
  intro Γ V
  induction' Γ with Γ t ih
  · exact (eq_nil V).symm ▸ nil
  · exact snoc_toSnoc_last V ▸ (snoc (fun _ v' => V v'.toSnoc) (V <|.last ..) (ih _))

/-! ### Cast -/

def Valuation.cast {Γ Δ : Ctxt Ty} (h : Γ = Δ) (V : Valuation Γ) : Valuation Δ :=
  fun _ v => V <| v.castCtxt h.symm

@[simp] lemma Valuation.cast_rfl {Γ : Ctxt Ty} (h : Γ = Γ) (V : Valuation Γ) : V.cast h = V := rfl

@[simp] lemma Valuation.cast_apply {Γ : Ctxt Ty} (h : Γ = Δ) (V : Γ.Valuation) (v : Δ.Var t) :
    V.cast h v = V (v.castCtxt h.symm) := rfl

/-- Show that a valuation is equivalent to a `HVector` -/
def Valuation.equivHVector {Γ : List Ty} : Valuation ⟨Γ⟩ ≃ HVector toType Γ where
  toFun V   := HVector.ofFn _ _ <| fun i => V ⟨i, by simp⟩
  invFun    := Valuation.ofHVector
  left_inv V := by
    funext t v
    simp only [Fin.getElem_fin]
    induction Γ
    case nil =>
      rcases v with ⟨_, _⟩
      contradiction
    case cons Γ u ih =>
      cases v
      case last   => rfl
      case toSnoc => apply ih (fun t v => V v.toSnoc)
  right_inv vs := by
    simp only [Fin.getElem_fin]
    induction vs
    case nil => rfl
    case cons Γ t v vs ih => simp [HVector.ofFn, ofHVector, ih]

end Valuation


/- ## VarSet -/

/-- `VarSet Γ` is the type of sets of variables from context `Γ` -/
abbrev VarSet (Γ : Ctxt Ty) : Type :=
  Finset (Σ t, Γ.Var t)

namespace VarSet

/-- A `VarSet` with exactly one variable `v` -/
@[simp]
def ofVar {Γ : Ctxt Ty} (v : Γ.Var t) : VarSet Γ :=
  {⟨_, v⟩}

end VarSet

namespace Var

@[simp]
theorem val_last {Γ : Ctxt Ty} {t : Ty} : (last Γ t).val = 0 :=
  rfl

@[simp]
theorem val_toSnoc {Γ : Ctxt Ty} {t t' : Ty} (v : Γ.Var t) : (@toSnoc _ _ _ t' v).val = v.val + 1 :=
  rfl

instance : Repr (Var Γ t) where
  reprPrec v _ := f!"%{Γ.toList.length - v.val - 1}"

end Var

/-
## Context difference, notes that Γ1[i] = Γ2[i + d].
   This means that Γ2 has a new prefix of 'd' elements before getting to Γ1
-/

@[simp]
abbrev Diff.Valid (Γ₁ Γ₂ : Ctxt Ty) (d : Nat) : Prop :=
  ∀ {i t}, Γ₁[i]? = some t → Γ₂[i+d]? = some t

/--
  If `Γ₁` is a prefix of `Γ₂`,
  then `d : Γ₁.Diff Γ₂` represents the number of elements that `Γ₂` has more than `Γ₁`
-/
def Diff (Γ₁ Γ₂ : Ctxt Ty) : Type :=
  {d : Nat // Diff.Valid Γ₁ Γ₂ d}

namespace Diff

/-- The difference between any context and itself is 0 -/
def zero (Γ : Ctxt Ty) : Diff Γ Γ :=
  ⟨0, fun h => h⟩

/-- Adding a new type to the right context corresponds to incrementing the difference by 1 -/
def toSnoc (d : Diff Γ₁ Γ₂) : Diff Γ₁ (Γ₂.snoc t) :=
  ⟨d.val + 1, by
    intro i _ h_get_snoc
    rcases d with ⟨d, h_get_d⟩
    simp only [← h_get_d h_get_snoc]
    rfl
  ⟩

/-- Removing a type from the left context corresponds to incrementing the difference by 1 -/
def unSnoc (d : Diff (Γ₁.snoc t) Γ₂) : Diff Γ₁ Γ₂ :=
  ⟨d.val + 1, by
    intro i t h_get
    rcases d with ⟨d, h_get_d⟩
    specialize @h_get_d (i+1) t
    rw [←h_get_d h_get, Nat.add_assoc, Nat.add_comm 1]
  ⟩

/-!
### `toMap`
-/

/-- Mapping over contexts does not change their difference -/
@[coe]
def toMap (d : Diff Γ₁ Γ₂) : Diff (Γ₁.map f) (Γ₂.map f) :=
  ⟨d.val, by
    rcases d with ⟨d, h_get_d⟩
    simp only [Valid, getElem?_map, Option.map_eq_some_iff, forall_exists_index, and_imp,
      forall_apply_eq_imp_iff₂] at h_get_d ⊢
    intros a b c
    simp [h_get_d c]
  ⟩

/-!
### `append`
-/

theorem append_valid {Γ₁ Γ₂ Γ₃  : Ctxt Ty} {d₁ d₂ : Nat} :
  Diff.Valid Γ₁ Γ₂ d₁ →  Diff.Valid Γ₂ Γ₃ d₂ → Diff.Valid Γ₁ Γ₃ (d₁ + d₂) := by
  intros h₁ h₂ i t hi
  specialize @h₁ i t hi
  specialize @h₂ (i + d₁) t h₁
  rw [← h₂, Nat.add_assoc]

/-- Addition of the differences of two contexts -/
def append (d₁ : Diff Γ₁ Γ₂) (d₂ : Diff Γ₂ Γ₃) : Diff Γ₁ Γ₃ :=
  {val := d₁.val + d₂.val,  property := append_valid d₁.property d₂.property}


/-!
### add
-/

def add : Diff Γ₁ Γ₂ → Diff Γ₂ Γ₃ → Diff Γ₁ Γ₃
  | ⟨d₁, h₁⟩, ⟨d₂, h₂⟩ => ⟨d₁ + d₂, fun h => by
      rw [←Nat.add_assoc]
      apply h₂ <| h₁ h
    ⟩

instance : HAdd (Diff Γ₁ Γ₂) (Diff Γ₂ Γ₃) (Diff Γ₁ Γ₃) := ⟨add⟩

@[simp, grind] lemma val_add (f : Γ.Diff Δ) (g : Δ.Diff Ξ) : (f + g).val = f.val + g.val := rfl

/-!
### `toHom`
-/

/-- Adding the difference of two contexts to variable indices is a context mapping -/
def toHom (d : Diff Γ₁ Γ₂) : Hom Γ₁ Γ₂ :=
  fun _ v => ⟨v.val + d.val, d.property v.property⟩

section Lemmas

@[simp, grind] lemma val_toHom_apply (d : Diff Γ Δ) (v : Γ.Var t) :
    (d.toHom v).val = v.val + d.val := rfl

theorem Valid.of_succ {Γ₁ Γ₂ : Ctxt Ty} {d : Nat} (h_valid : Valid Γ₁ (Γ₂.snoc t) (d+1)) :
    Valid Γ₁ Γ₂ d := by
  intro i t h_get
  simp [←h_valid h_get, snoc, List.getElem?_cons]
  rfl

lemma toHom_succ {Γ₁ Γ₂ : Ctxt Ty} {d : Nat} (h : Valid Γ₁ (Γ₂.snoc t) (d+1)) :
    toHom ⟨d+1, h⟩ = (toHom ⟨d, Valid.of_succ h⟩).snocRight := by
  rfl

@[simp] lemma toHom_zero {Γ : Ctxt Ty} {h : Valid Γ Γ 0} :
    toHom ⟨0, h⟩ = Hom.id := by
  rfl

@[simp] lemma toHom_unSnoc {Γ₁ Γ₂ : Ctxt Ty} (d : Diff (Γ₁.snoc t) Γ₂) :
    toHom (unSnoc d) = fun _ v => (toHom d) v.toSnoc := by
  unfold unSnoc Var.toSnoc toHom
  simp only [Valid]
  funext x v
  congr 1
  rw [Nat.add_assoc, Nat.add_comm 1]

@[simp] lemma toHom_comp_toHom (f : Γ.Diff Δ) (g : Δ.Diff Ξ) :
    f.toHom.comp g.toHom = (f + g).toHom := by
  funext t v
  apply Subtype.eq
  grind

end Lemmas

def cast (h₁ : Γ = Γ') (h₂ : Δ = Δ') : Diff Γ Δ → Diff Γ' Δ'
  | ⟨n, h⟩ => ⟨n, by subst h₁ h₂; exact h⟩

end Diff

/-## Derived Contexts
Contexts that grow a base context-/

/-- `Δ : DerivedCtxt Γ` means that `Δ` is a context obtained by adding elements to context `Γ`.
That is, there exists a context difference `diff : Γ.Diff Δ`. -/
structure DerivedCtxt (Γ : Ctxt Ty) where
  ctxt : Ctxt Ty
  diff : Ctxt.Diff Γ ctxt

namespace DerivedCtxt

/-- Every context is trivially derived from itself -/
@[simp]
abbrev ofCtxt (Γ : Ctxt Ty) : DerivedCtxt Γ := ⟨Γ, .zero _⟩

/-- value of a dervied context from an empty context,
     is the empty context with a zero diff. -/
@[simp]
theorem ofCtxt_empty : DerivedCtxt.ofCtxt (∅ : Ctxt Ty) = ⟨∅, .zero _⟩ := rfl

/-- `snoc` of a derived context applies `snoc` to the underlying context, and updates the diff -/
@[simp]
def snoc {Γ : Ctxt Ty} : DerivedCtxt Γ → Ty → DerivedCtxt Γ
  | ⟨⟨Δ⟩, diff⟩, ty => ⟨ty::Δ, diff.toSnoc⟩

theorem snoc_ctxt_eq_ctxt_snoc {Γ : DerivedCtxt Δ}:
    (DerivedCtxt.snoc Γ ty).ctxt = Ctxt.snoc Γ.ctxt ty := by
  rfl

@[simp]
instance {Γ : Ctxt Ty} : CoeHead (DerivedCtxt Γ) (Ctxt Ty) where
  coe := fun ⟨Γ', _⟩ => Γ'

instance {Γ : Ctxt Ty} : CoeDep (Ctxt Ty) Γ (DerivedCtxt Γ) where
  coe := ⟨Γ, .zero _⟩

instance {Γ : Ctxt Ty} {Γ' : DerivedCtxt Γ} :
    CoeHead (DerivedCtxt (Γ' : Ctxt Ty)) (DerivedCtxt Γ) where
  coe := fun ⟨Γ'', diff⟩ => ⟨Γ'', Γ'.diff + diff⟩

instance {Γ' : DerivedCtxt Γ} : Coe (Ctxt.Var Γ t) (Ctxt.Var (Γ' : Ctxt Ty) t) where
  coe v := Γ'.diff.toHom v

end DerivedCtxt

/-! ## `dropUntil` -/
section DropUntil
variable (Γ : Ctxt Ty) {ty} (v : Var Γ ty)

/-- `Γ.dropUntil v` is the largest prefix of context `Γ` that no longer contains variable `v`. -/
def dropUntil : Ctxt Ty :=
  ⟨List.drop (v.val + 1) Γ.toList⟩

variable {Γ} {v}

@[simp] lemma dropUntil_last   : dropUntil (snoc Γ ty) (Var.last Γ ty) = Γ := rfl
@[simp] lemma dropUntil_toSnoc : dropUntil (snoc Γ ty) (Var.toSnoc v) = dropUntil Γ v := rfl

@[simp] lemma dropUntil_castCtxt {h : Γ = Γ'} :
    Γ'.dropUntil (v.castCtxt h) = Γ.dropUntil v := by
  subst h; rfl

@[simp] lemma dropUntil_appendInl :
    (Γ ++ ts).dropUntil v.appendInl = Γ.dropUntil v := by
  simp only [dropUntil, Var.val_appendInl]
  rw [Nat.add_right_comm, Nat.add_comm]
  simp

@[simp] lemma dropUntil_appendInr {v : Var ⟨ts⟩ t} :
    (Γ ++ ts).dropUntil v.appendInr = Γ ++ (ts.drop <| v.1 + 1) := by
  rcases Γ
  -- TODO: upstream the following as a `List` lemma
  suffices ∀ {xs} (i : Nat) (hi : i ≤ xs.length) (ys : List Ty),
    List.drop i (xs ++ ys) = List.drop i xs ++ ys
  by
    have hi : v.val + 1 ≤ ts.length := by
      simpa using v.val_lt
    simpa [dropUntil] using this _ hi _
  intro xs i hi ys
  induction xs generalizing i
  case nil => cases i <;> simp_all
  case cons ih =>
    rcases i with _|i
    · rfl
    · simp [ih i (by simp_all)]

/-- The difference between `Γ.dropUntil v` and `Γ` is exactly `v.val + 1` -/
def dropUntilDiff : Diff (Γ.dropUntil v) Γ :=
  ⟨v.val+1, by
    intro i _ h
    induction Γ
    case nil => exact v.emptyElim
    case snoc Γ _ ih =>
      cases v using Var.casesOn
      · simp only [Var.val_toSnoc] at h ⊢
        apply ih h
      · simpa! using h
  ⟩

/-- Context homomorphism from `(Γ.dropUntil v)` to `Γ`, see also `dropUntilDiff` -/
abbrev dropUntilHom : Hom (Γ.dropUntil v) Γ := dropUntilDiff.toHom

@[simp, grind=] lemma val_dropUntilDiff : (@dropUntilDiff _ Γ _ v).val = v.val+1 := rfl

@[simp] lemma dropUntilHom_last : dropUntilHom (v := Var.last Γ ty) = Hom.id.snocRight := rfl
@[simp] lemma dropUntilHom_toSnoc {v : Var Γ t} :
  dropUntilHom (v := v.toSnoc (t' := t')) = (dropUntilHom (v:=v)).snocRight := rfl

instance : CoeOut (Var (Γ.dropUntil v) ty) (Var Γ ty) where
  coe v := dropUntilDiff.toHom v

end DropUntil

/-!
# ToExpr
-/
section ToExpr
open Lean Qq
variable [ToExpr Ty] {Γ : Ctxt Ty} {ty : Ty}

/-- Construct an expression of type `Var Γ ty`.

If no proof `hi : Γ[i]? = some ty` is provided,
it's assumed to be true by rfl. -/
def mkVar (Ty : Q(Type)) (Γ : Q(Ctxt $Ty)) (ty : Q($Ty)) (i : Q(Nat))
    (hi? : Option Q(($Γ)[$i]? = some $ty) := none) :
    Q(($Γ).Var $ty) :=
  let optTy := mkApp (.const ``Option [0]) Ty
  let someTy := mkApp2 (.const ``Option.some [0]) Ty ty
  let P :=
    let i : Q(Nat) := Expr.bvar 0
    let getE := q($Γ[$i]?)
    let eq := mkApp3 (.const ``Eq [1]) optTy getE someTy
    Expr.lam `i (mkConst ``Nat) eq .default
  let hi := hi?.getD <| /- : Γ[i]? = some ty := rfl -/
    mkApp2 (.const ``rfl [1]) optTy someTy
  mkApp4 (.const ``Subtype.mk [1]) (mkConst ``Nat) P i hi

instance : ToExpr (Var Γ ty) where
  toTypeExpr := mkApp3 (mkConst ``Var) (toTypeExpr Ty) (toExpr Γ) (toExpr ty)
  toExpr := fun ⟨i, _hi⟩ =>
    let Ty := toTypeExpr Ty
    let Γ := toExpr Γ
    let ty := toExpr ty
    let i := toExpr i
    /- Folklore suggests an explicit proof (instead of `rfl`) would be more
        efficient, as the kernel might not know what to reduce.
        In this case, though, `ty` should be in normal form by construction,
        thus reduction should be safe. -/
    mkVar Ty Γ ty i

instance : HVector.ToExprPi (Var Γ) where
  toTypeExpr := mkApp2 (mkConst ``Var) (toTypeExpr Ty) (toExpr Γ)

/--
Given an array `Γ` of types (i.e., expressions of type `Ty`), and an array
of values `xs`, such that `xs[i]` is an expression of type `Γ[i]`,
construct an expression of type `Valuation Γ`.
-/
def Valuation.mkOfElems (Ty instTyDenote : Expr) (Γ : Array Expr) (xs : Array Expr) : Expr :=
  @id (Id _) <| do
    let mut V_acc := mkApp2 (mkConst ``Ctxt.Valuation.nil) Ty instTyDenote
    let mut Γ_acc := mkApp (.const ``List.nil [0]) Ty
    for (ty, x) in Γ.zip xs do
      let Γ := mkApp2 (mkConst ``Ctxt.ofList) Ty Γ_acc
      V_acc := mkApp6 (mkConst ``Ctxt.Valuation.snoc) Ty instTyDenote Γ ty V_acc x
      Γ_acc := mkApp3 (.const ``List.cons [0]) Ty ty Γ_acc
    V_acc

end ToExpr

end Ctxt
