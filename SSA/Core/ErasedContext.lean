/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Data.Fintype.Basic

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

variable {Ty : Type} {Γ Δ : Ctxt Ty}
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

theorem empty_eq : (∅ : Ctxt Ty) = .empty := rfl

@[match_pattern]
def cons : Ty → Ctxt Ty → Ctxt Ty
  | hd, ⟨tl⟩ => ⟨hd :: tl⟩

@[deprecated cons (since := "2025-09-14")]
abbrev snoc := fun Γ t => @cons Ty t Γ


@[grind=]
def length (Γ : Ctxt Ty) : Nat := Γ.toList.length

instance : GetElem? (Ctxt Ty) Nat Ty (fun Γ i => i < Γ.length) where
  getElem Γ i h := Γ.toList[i]
  getElem? Γ i  := Γ.toList[i]?

section GetElemLemmas

theorem getElem?_eq_toList_getElem? {i : Nat} : Γ[i]? = Γ.toList[i]? := rfl
@[simp, grind=] theorem getElem?_ofList (i : Nat) : (ofList ts)[i]? = ts[i]? := rfl
@[simp, grind=] theorem getElem_ofList (i : Nat) (h : _) : (ofList ts)[i]'h = ts[i]'h := rfl

instance : LawfulGetElem (Ctxt Ty) Nat Ty (fun as i => i < as.length) where
  getElem?_def Γ i _ := by rcases Γ; grind

@[ext]
theorem ext_getElem? {Γ Δ : Ctxt Ty} (h : ∀ (i : Nat), Γ[i]? = Δ[i]?) : Γ = Δ := by
  rcases Γ; rcases Δ;
  rw [ofList.injEq]
  exact List.ext_getElem?_iff.mpr h

end GetElemLemmas

@[simp, deprecated "Use `getElem?`" (since := "")]
def get? : Ctxt Ty → Nat → Option Ty := (·[·]?)

/-- Map a function from one type universe to another over a context -/
def map (f : Ty₁ → Ty₂) : Ctxt Ty₁ → Ctxt Ty₂ :=
  ofList ∘ (List.map f) ∘ toList

section Lemmas
variable (Γ : Ctxt Ty) (ts us : List Ty)

@[simp] theorem cons_inj : Γ.cons t = Γ.cons u ↔ t = u := by
  constructor <;> (rintro ⟨⟩; rfl)

variable {m} [Monad m] [LawfulMonad m] (t u : m _) in
@[simp] theorem cons_map_inj : Γ.cons <$> t = Γ.cons <$> u ↔ t = u :=
  (map_inj_right (cons_inj _).mp)

@[simp] theorem getElem?_cons_zero (t : Ty)           : (Γ.cons t)[0]? = some t := rfl
@[simp] theorem getElem?_cons_succ (t : Ty) (i : Nat) : (Γ.cons t)[i+1]? = Γ[i]? := rfl

@[simp] theorem map_nil (f : Ty → Ty') : map f ∅ = ∅ := rfl
@[simp] theorem map_cons : (Γ.cons a).map f = (Γ.map f).cons (f a) := rfl

@[simp] theorem getElem?_map (Γ : Ctxt Ty) (f : Ty → Ty') (i : Nat) :
    (Γ.map f)[i]? = Γ[i]?.map f := by
  simp [map]; rfl

@[simp, grind=] theorem length_ofList : (ofList ts).length = ts.length := rfl
@[simp, grind=] theorem length_cons (Γ : Ctxt α) (x : α) : (Γ.cons x).length = Γ.length + 1 := rfl
@[simp, grind=] theorem length_map : (Γ.map f).length = Γ.length := by simp [map, length]

/-! ### Ctxt Append -/

instance instAppendList : HAppend (Ctxt Ty) (List Ty) (Ctxt Ty) where
  hAppend Γ tys := ⟨Γ.toList ++ tys⟩

instance instAppend : Append (Ctxt Ty) where
  append Γ Δ := ⟨Γ.toList ++ Δ.toList⟩

section Lemmas
variable {Γ Δ : Ctxt Ty} {tys : List Ty}

@[simp] theorem appendList_eq : Γ ++ tys = Γ ++ ⟨tys⟩ := rfl

@[simp] theorem toList_append : (Γ ++ Δ).toList = Γ.toList ++ Δ.toList := rfl
@[simp] theorem ofList_append {ts us : List Ty} :
    Ctxt.ofList ts ++ Ctxt.ofList us = Ctxt.ofList (ts ++ us) := rfl

@[simp, grind=] theorem length_append : (Γ ++ Δ).length = Γ.length + Δ.length := by
  simp [length]

theorem getElem?_append :
    (Γ ++ Δ)[i]? = if i < Γ.length then Γ[i]? else Δ[i - Γ.length]? :=
  List.getElem?_append

end Lemmas

/-! ### Ctxt is a Functor -/

instance : Functor Ctxt where
  map := map

@[simp] theorem map_eq_map : f <$> Γ = map f Γ := rfl

@[simp] theorem map_append (f : Ty₁ → Ty₂) (Γ Δ : Ctxt Ty₁) :
    (Γ ++ Δ).map f = Γ.map f ++ Δ.map f := by
  simp [map]

instance : LawfulFunctor Ctxt where
  comp_map  := by simp [(· <$> ·), map]
  id_map    := by simp [(· <$> ·), map]
  map_const := by simp only [Functor.mapConst, Functor.map, forall_const]

end Lemmas

section Rec

/-- Recursion principle for contexts in terms of `Ctxt.nil` and `Ctxt.cons` -/
@[elab_as_elim, induction_eliminator]
def recOn' {motive : Ctxt Ty → Sort*}
    (nil  : motive empty)
    (cons : (Γ : Ctxt Ty) → (t : Ty) → motive Γ → motive (Γ.cons t)) :
    ∀ Γ, motive Γ
  | ⟨[]⟩        => nil
  | ⟨ty :: tys⟩ => cons ⟨tys⟩ ty (recOn' nil cons ⟨tys⟩)

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
def last (Γ : Ctxt Ty) (t : Ty) : Ctxt.Var (Ctxt.cons t Γ) t :=
  ⟨0, by rfl⟩

def emptyElim {α : Sort _} {t : Ty} : Ctxt.Var ∅ t → α :=
  fun ⟨_, h⟩ => by
    simp [EmptyCollection.emptyCollection, empty] at h

/-- Take a variable in a context `Γ` and get the corresponding variable
in context `Γ.cons t`. This is marked as a coercion. -/
@[coe]
def toCons {Γ : Ctxt Ty} {t t' : Ty} (var : Var Γ t) : Var (cons t' Γ) t  :=
  ⟨var.1+1, var.2⟩

section Lemmas
variable {Γ : Ctxt Ty} {t : Ty}

theorem val_lt (v : Γ.Var t) : v.val < Γ.length := by
  rcases v with ⟨idx, h⟩
  suffices ¬(Γ.length ≤ idx) by grind
  rcases Γ
  simp only [length_ofList, ← List.getElem?_eq_none_iff]
  simp_all

@[simp] theorem zero_eq_last (h) : ⟨0, h⟩ = last Γ t := rfl
@[simp] theorem succ_eq_toCons {w} (h : (Γ.cons t)[w+1]? = some t') :
    ⟨w+1, h⟩ = toCons ⟨w, h⟩ := rfl

end Lemmas

/-! ### toMap-/

/-- Transport a variable from `Γ` to any mapped context `Γ.map f` -/
def toMap : Var Γ t → Var (Γ.map f) (f t)
  | ⟨i, h⟩ => ⟨i, by simp_all⟩

@[simp]
theorem toMap_last {Γ : Ctxt Ty} {t : Ty} :
    (Ctxt.Var.last Γ t).toMap = Ctxt.Var.last (Γ.map f) (f t) := rfl

@[simp]
theorem toCons_toMap {Γ : Ctxt Ty} {t : Ty} {var : Ctxt.Var Γ t'} {f : Ty → Ty₂} :
    var.toCons.toMap (Γ := Γ.cons t) (f := f) = var.toMap.toCons := rfl

/-! ### Cases -/

/-- This is an induction principle that case splits on whether or not a variable
is the last variable in a context. -/
@[elab_as_elim, cases_eliminator]
def casesOn
    {motive : (Γ : Ctxt Ty) → (t t' : Ty) → Ctxt.Var (Γ.cons t') t → Sort _}
    {Γ : Ctxt Ty} {t t' : Ty} (v : (Γ.cons t').Var t)
    (toCons : {t t' : Ty} →
        {Γ : Ctxt Ty} → (v : Γ.Var t) → motive Γ t t' v.toCons)
    (last : {Γ : Ctxt Ty} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
      motive Γ t t' v :=
  match v with
    | ⟨0, h⟩ =>
        _root_.cast (by
          obtain rfl : t' = t := by simpa [cons] using h
          simp_all only [zero_eq_last]
          ) <| @last Γ t
    | ⟨i+1, h⟩ =>
        toCons ⟨i, by simpa [cons] using h⟩

/-- `Ctxt.Var.casesOn` behaves in the expected way when applied to the last variable -/
@[simp]
def casesOn_last
    {motive : (Γ : Ctxt Ty) → (t t' : Ty) → Ctxt.Var (Γ.cons t') t → Sort _}
    {Γ : Ctxt Ty} {t : Ty}
    (base : {t t' : Ty} →
        {Γ : Ctxt Ty} → (v : Γ.Var t) → motive Γ t t' v.toCons)
    (last : {Γ : Ctxt Ty} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
    Ctxt.Var.casesOn (motive := motive)
        (Ctxt.Var.last Γ t) base last = last :=
  rfl

/-- `Ctxt.Var.casesOn` behaves in the expected way when applied to a previous variable,
that is not the last one. -/
@[simp]
def casesOn_toCons
    {motive : (Γ : Ctxt Ty) → (t t' : Ty) → Ctxt.Var (Γ.cons t') t → Sort _}
    {Γ : Ctxt Ty} {t t' : Ty} (v : Γ.Var t)
    (base : {t t' : Ty} →
        {Γ : Ctxt Ty} → (v : Γ.Var t) → motive Γ t t' v.toCons)
    (last : {Γ : Ctxt Ty} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
      Ctxt.Var.casesOn (motive := motive) (toCons (t' := t') v) base last = base v :=
  rfl

theorem toCons_injective {Γ : Ctxt Ty} {t t' : Ty} :
    Function.Injective (@toCons Ty Γ t t') := by
  let ofCons : (Γ.cons t').Var t → Option (Γ.Var t) :=
    fun v => Ctxt.Var.casesOn v some none
  intro x y h
  simpa (config := { zetaDelta := true }) only [Var.casesOn_toCons, Option.some.injEq] using
    congr_arg ofCons h

/-! ### Var cast -/

def cast (h_eq : ty₁ = ty₂) : Γ.Var ty₁ → Γ.Var ty₂
  | ⟨i, h⟩ => ⟨i, h_eq ▸ h⟩

def castCtxt (h_eq : Γ = Δ) : Γ.Var ty → Δ.Var ty
  | ⟨i, h⟩ => ⟨i, h_eq ▸ h⟩

section Lemmas
variable {t} (v : Var Γ t)

@[simp, grind=] theorem cast_rfl (h : t = t) : v.cast h = v := rfl

@[simp, grind=] theorem castCtxt_rfl (h : Γ = Γ) : v.castCtxt h = v := rfl
@[simp, grind=] theorem castCtxt_castCtxt (h₁ : Γ = Δ) (h₂ : Δ = Ξ) :
    (v.castCtxt h₁).castCtxt h₂ = v.castCtxt (by simp [*]) := by subst h₁ h₂; simp

@[simp, grind=] theorem cast_mk : cast h ⟨vi, hv⟩ = ⟨vi, h ▸ hv⟩ := rfl
@[simp, grind=] theorem castCtxt_mk : castCtxt h ⟨vi, hv⟩ = ⟨vi, h ▸ hv⟩ := rfl

@[simp, grind=] theorem val_cast : (cast h v).val = v.val := rfl
@[simp, grind=] theorem val_castCtxt : (castCtxt h v).val = v.val := rfl

end Lemmas

/-! ### Var Append -/

def appendInl (v : Γ.Var t) : (Γ ++ Δ).Var t :=
  ⟨v.val, by
    have h := v.prop
    grind [getElem?_append]
  ⟩
instance : Coe (Γ.Var t) ((Γ ++ ts).Var t) where coe := appendInl

def appendInr (v : Var Δ t) : (Γ ++ Δ).Var t :=
  ⟨v.val + Γ.length, by
    have h := v.prop
    grind [getElem?_append]
  ⟩

@[elab_as_elim]
def appendCases
    {motive : (Γ ++ Δ).Var t → Sort u}
    (left : (v : Var Γ t) → motive (appendInl v))
    (right : (v : Var Δ t) → motive (appendInr v)) :
    (v : (Γ ++ Δ).Var t) → motive v
  | ⟨idx, h⟩ =>
    if hv : idx < Γ.length then
      left ⟨idx, by grind [getElem?_append]⟩
    else
      let v' : Var _ _ := ⟨idx - Γ.length, by grind [getElem?_append]⟩
      have eq : v'.appendInr = ⟨idx, h⟩ := by
        show Subtype.mk _ _ = _
        simp [v']; omega
      eq ▸ right v'

section Lemmas
variable {t : Ty} {v : Γ.Var t}

@[simp] theorem val_appendInl {v : Γ.Var t} : (v.appendInl (Δ := Δ)).val = v.val := rfl
@[simp] theorem val_appendInr {v : Var Δ t} : (v.appendInr (Γ := Γ)).val = v.val + Γ.length := rfl

theorem appendInl_toCons {v : Var Γ t} :
    v.toCons (t':=t').appendInl (Δ := Δ) = v.appendInl.toCons :=
  rfl

theorem toCons_appendInr {v : Var Δ t} :
    v.appendInr (Γ := Γ.cons t') = v.appendInr.toCons :=
  rfl

@[simp] theorem last_appendInl :
    (Var.last Γ t |>.appendInl (Δ := Δ)) = Var.last (Γ ++ Δ) t :=
  rfl

@[simp] theorem appendCases_appendInl (v : Γ.Var t) :
    appendCases (motive := motive) left right v.appendInl = (left v) := by
  rcases v with ⟨idx, h⟩
  grind [appendInl, appendCases]

@[simp] theorem lt_length (v : Γ.Var t) : v.1 < Γ.length := by
  rcases v with ⟨idx, h⟩
  simp only [Ctxt.length]
  suffices ¬ Γ.toList.length ≤ idx by omega
  simp only [getElem?_eq_toList_getElem?] at h
  simp [← List.getElem?_eq_none_iff, h]

@[simp] theorem appendCases_appendInr (v : Γ.Var t) :
    appendCases (motive := motive) left right v.appendInr = (right v) := by
  rcases v with ⟨idx, h⟩
  grind [appendInr, appendCases]

end Lemmas

/-! ### Var equality -/

/--
Given two variables `v, w` in the same context `Γ`, but with potentially
different types `t` and `u`, `v.eq w` holds if `v = w` (after
substituing along a proof that `t = u`).
-/
def eq (v : Γ.Var t) (w : Γ.Var u) : Prop :=
  ∃ (h : t = u), v = h ▸ w

instance [DecidableEq Ty] {v : Γ.Var t} {w : Γ.Var u} : Decidable (v.eq w) := by
  unfold Var.eq; infer_instance

/-- Given variables `v, w : Γ.Var t` with the same type index `t`, `v.eq w`
coincides exactly with `v = w`. -/
@[simp] theorem eq_iff {v w : Γ.Var t} : v.eq w ↔ v = w := by
  simp [Var.eq]

@[inherit_doc eq_iff] theorem eq.to_eq {v w : Γ.Var t} : v.eq w → v = w := eq_iff.mp

/-- From `v.eq w` it follows that the types of `v` and `w` are the same. -/
theorem eq.ty_eq {v : Γ.Var t} {w : Γ.Var u} (h : v.eq w) : t = u := h.1

/-! ### Fintype instance -/

instance [DecidableEq Ty] {Γ : Ctxt Ty} {t : Ty} : Fintype (Γ.Var t) where
  elems := {
      val := .ofList <|
                List.range Γ.length
                |>.filterMap fun i =>
                    if h : Γ[i]? = some t then
                      some ⟨i, h⟩
                    else
                      none
      nodup := by
        apply List.Nodup.filterMap ?_ List.nodup_range
        simp only [Option.mem_def, Option.dite_none_right_eq_some, Option.some.injEq,
          forall_exists_index, forall_apply_eq_imp_iff]
        intro i j hi hj h_eq
        cases h_eq
        rfl
    }
  complete v := by simpa using ⟨v.val, v.val_lt, v.prop, rfl⟩

/-! ### Var Fin Helpers -/

def toFin (v : Γ.Var t) : Fin Γ.length :=
  ⟨v.val, v.val_lt⟩

def ofFin (i : Fin Γ.length) : Γ.Var (Γ[i]) :=
  ⟨i.val, by simp⟩

section Lemmas

@[simp, grind=] theorem ofFin_toFin (v : Γ.Var t) :
    ofFin v.toFin = v.cast (by have := v.prop; grind [toFin]) := rfl

def ofFinCases
    {motive : ∀ {t}, Γ.Var t → Sort u}
    (ofFin : (i : Fin Γ.length) → motive (ofFin i))
    (v : Γ.Var t) :
    motive v := by
  refine _root_.cast ?h <| ofFin v.toFin
  grind

@[simp] theorem toFin_toCons (v : Γ.Var t) : (v.toCons (t':=t')).toFin = v.toFin.succ := rfl
@[simp] theorem toFin_last : (Var.last Γ t).toFin = (0 : Fin <| _ + 1) := rfl

end Lemmas

/-! ### All vars in a context -/

def allVarsIn (ts : List Ty) : HVector (Var ⟨ts⟩) ts :=
  .ofFn _ ts Var.ofFin

end Var

/-!
### Indexing an HVector by `Var`
Note that a `Var` is quite similar to a `Fin`, plus a static proof of the item
at the particular index. This extra knowledge is useful when indexing into an
HVector as well.
-/
end Ctxt
open Ctxt

instance {Γ} : GetElem (HVector A as) (Var Γ a) (A a) (fun _ _ => as = Γ.toList) where
  getElem xs i h := (cast · <| xs.get <| i.toFin.cast <| by rw [h]; rfl) <| by
    subst h
    congr 1
    rcases i with ⟨i, h⟩
    simpa [Ctxt.Var.toFin, List.getElem_eq_iff] using h

namespace HVector
variable {A : α → _} {as : List α} (xs : HVector A as) {Γ : Ctxt α}

/-! #### HVector GetElem lemmas -/

@[simp] theorem getElem_ofFin_eq_get (i : Fin as.length) :
    xs[Ctxt.Var.ofFin i] = xs.get i := rfl
@[simp] theorem getElem_map (xs : HVector A as) (v : Var ⟨as⟩ a) :
    (xs.map f)[v] = f _ xs[v] := by
  cases v using Var.ofFinCases
  rw [getElem_ofFin_eq_get, getElem_ofFin_eq_get]
  simp only [length_ofList, get_map, List.get_eq_getElem]
  rfl

@[simp] theorem cons_getElem_toCons (x : A a) (v : Var Γ u)
    (h : as = Γ.toList := by rfl) (h' : a :: as = (Γ.cons a).toList := by rfl) :
    (HVector.cons x xs)[v.toCons (t' := a)]'h' = xs[v]'h := by
  simp only [GetElem.getElem]
  simp

@[simp] theorem cons_getElem_last (x : A a)
    (h' : a :: as = (Γ.cons a).toList := by rfl) :
    (HVector.cons x xs)[Var.last Γ a]'h' = x := by
  simp only [GetElem.getElem]
  simp

-- @[simp] theorem getElem_appendInl (xs : HVector A (as ++ bs)) (v : Var Γ a) :
--     xs[v] = _ := by
--   sorry

end HVector
namespace Ctxt
/-!
## Context Homomorphisms
-/

abbrev Hom (Γ Γ' : Ctxt Ty) := ⦃t : Ty⦄ → Γ.Var t → Γ'.Var t

@[simp] abbrev Hom.id {Γ : Ctxt Ty} : Γ.Hom Γ :=
  fun _ v => v

/-! ### Morphism Composition -/
section Comp
variable {Γ Δ Ξ : Ctxt Ty} (f : Hom Γ Δ) (g : Hom Δ Ξ)

/-- `f.comp g := g(f(x))` -/
def Hom.comp : Hom Γ Ξ :=
  fun _t v => g (f v)

@[simp, grind=] theorem Hom.comp_apply : f.comp g v = g (f v) := rfl

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

def Hom.consMap {Γ Γ' : Ctxt Ty} (f : Hom Γ Γ') {t : Ty} :
    (Γ.cons t).Hom (Γ'.cons t) := by
  intro t' v
  cases v using Ctxt.Var.casesOn with
  | toCons v => exact Var.toCons (f v)
  | last => exact Ctxt.Var.last _ _

@[simp] theorem Hom.consMap_last {Γ Γ' : Ctxt Ty} (f : Hom Γ Γ') {t : Ty} :
    (f.consMap (Ctxt.Var.last Γ t)) = Ctxt.Var.last Γ' t := rfl
@[simp] theorem Hom.consMap_toCons {Γ Γ' : Ctxt Ty} (f : Hom Γ Γ') {t t' : Ty} (v : Γ.Var t') :
    (f.consMap v.toCons (t := t)) = (f v).toCons := rfl

@[simp]
abbrev Hom.consRight {Γ Γ' : Ctxt Ty} (f : Hom Γ Γ') {t : Ty} : Γ.Hom (Γ'.cons t) :=
  fun _ v => (f v).toCons

/-- Remove a type from the domain (left) context -/
def Hom.unCons (f : Hom (Γ.cons t) Δ) : Hom Γ Δ :=
  fun _ v => f v.toCons

@[simp] theorem Hom.unCons_apply {Γ : Ctxt Ty} (f : Hom (Γ.cons t) Δ) (v : Var Γ u) :
    f.unCons v = f v.toCons := rfl

instance : Coe (Γ.Var t) ((Γ.cons t').Var t) := ⟨Var.toCons⟩

/-! ### Append -/

/--
Lift a context morphism `f` from context `Γ` to context `Δ` into a morphism
where a list of types `ts` is prepended to *both* the domain and codomain.
That is, on any variables in the original domain `Γ`, `f.append` acts like `f`,
but on any *new* variables, in the appended list of types `ts`, `f.append`
maps to the corresponding new variable in the codomain (`Δ ++ ts`).
-/
def Hom.append {ζ : Ctxt Ty} (f : Γ.Hom Δ) : Hom (ζ ++ Γ) (ζ ++ Δ) :=
  fun _ => Var.appendCases
    (fun v => v.appendInl)
    (fun v => (f v).appendInr)

/--
Lift a context morphism `f` from context `Γ` to context `Δ` into a morphism
where a list of types is appended to just to codomain `Δ`.
-/
def Hom.appendCodomain {ts : List Ty} (f : Γ.Hom Δ) : Hom Γ (ts ++ Δ) :=
  fun _ v => (f v).appendInr

section Lemmas

@[simp] theorem Hom.append_appendInl (f : Γ.Hom Δ) (v : ζ.Var t) :
    (f.append (ζ := ζ)) v.appendInl = v.appendInl := by
  simp [append]

@[simp] theorem Hom.append_appendInr (f : Γ.Hom Δ) (v : Γ.Var t) :
    (f.append (ζ := ζ)) v.appendInr = (f v).appendInr := by
  simp [append]

@[simp] theorem Hom.appendCodomain_apply (f : Γ.Hom Δ) (v : Γ.Var t) :
    (f.appendCodomain (ts := ts)) v = (f v).appendInr :=
  rfl

@[simp] theorem Hom.id_append : (Hom.id (Γ:=Γ)).append (ζ:=ζ) = .id := by
  funext t v; cases v using Var.appendCases <;> simp [id, append]

end Lemmas

/-! ### Cast -/

variable {Γ Δ Δ' : Ctxt Ty} in
def Hom.castCodomain (h : Δ = Δ') (f : Γ.Hom Δ) : Γ.Hom Δ' :=
  fun _t v => (f v).castCtxt h

@[simp] theorem Hom.castDomain_apply {h : Δ = Δ'} {f : Γ.Hom Δ} {v : Γ.Var t} :
    f.castCodomain h v = (f v).castCtxt h := rfl

@[simp] theorem Hom.castDomain_castCodomain {h₁ : Δ₁ = Δ₂} {h₂ : Δ₂ = Δ₃}
    {f : Γ.Hom Δ₁} :
    (f.castCodomain h₁).castCodomain h₂ = f.castCodomain (h₁ ▸ h₂) := rfl

@[simp] theorem Hom.castDomain_rfl {h : Δ = Δ} {f : Γ.Hom Δ} :
    (f.castCodomain h) = f := rfl

/-!
## Context Valuations
-/
section Valuation
variable [TyDenote Ty]
-- ^^ for a valuation, we need to evaluate the Lean `Type` corresponding to a `Ty`

/-- A valuation for a context. Provide a way to evaluate every variable in a context. -/
abbrev Valuation (Γ : Ctxt Ty) : Type :=
  HVector toType Γ.toList

/-!
### Function Coercion

This is a backwards compatibility wrapper for code that expects `Valuation` to
be a functions.
-/

instance : CoeFun (Γ.Valuation) (fun _ => {ty : Ty} → Γ.Var ty → ⟦ty⟧) where
  coe (V : HVector _ _) := (V[·])

/--
The `·[·]` notation is preferred over the function coercion for `Valuation`s
-/
@[simp] theorem coeFun_eq (V : Γ.Valuation) {t} (v : Γ.Var t) : V v = V[v] := rfl

/-!
### Basic Valuation API
-/

/-- A valuation for a context. Provide a way to evaluate every variable in a context. -/
def Valuation.eval {Γ : Ctxt Ty} (VAL : Valuation Γ) ⦃t : Ty⦄ (v : Γ.Var t) : toType t :=
    VAL v

/-- Make a valuation for the empty context. -/
@[deprecated HVector.nil]
def Valuation.nil : Ctxt.Valuation (∅ : Ctxt Ty) :=
  HVector.nil

instance : Inhabited (Ctxt.Valuation (∅ : Ctxt Ty)) := ⟨[]ₕ⟩

/-- Make a valuation for `Γ.cons t` from a valuation for `Γ` and an element of `t.toType`. -/
def Valuation.cons {Γ : Ctxt Ty} {t : Ty} (x : toType t) (V : Γ.Valuation) :
    (Γ.cons t).Valuation :=
  HVector.cons x V

infixr:67 "::ᵥ" => Valuation.cons

@[simp]
theorem Valuation.cons_last {t : Ty} (s : Γ.Valuation) (x : toType t) :
    (s.cons x : no_index _) (Ctxt.Var.last _ _) = x :=
  rfl

@[simp]
theorem Valuation.cons_zero {ty : Ty} (s : Γ.Valuation) (x : toType ty)
    (h : (Ctxt.cons ty Γ)[0]? = some ty) :
    (s.cons x) ⟨0, h⟩ = x :=
  rfl

@[simp] theorem Valuation.cons_toCons {t t' : Ty} (s : Γ.Valuation)
    (x : toType t) (v : Γ.Var t') :
    (s.cons x) v.toCons = s v :=
  rfl

@[simp] theorem Valuation.cons_inj {t : Ty} {x y : ⟦t⟧} :
    (x ::ᵥ V) = (y ::ᵥ V) ↔ x = y where
  mpr := by rintro rfl; rfl
  mp := by
    intro h
    rw [← cons_last V x, ← cons_last V y, h]

variable {m} [Monad m] [LawfulMonad m] in
@[simp] theorem Valuation.cons_map_inj {V : Γ.Valuation} {x y : m ⟦t⟧} :
    (V.cons <$> x) = (V.cons <$> y) ↔ x = y :=
  map_inj_right <| Valuation.cons_inj.mp

/-!
# Helper to simplify context manipulation with toCons and variable access.
-/
/--  (ctx.cons v₁) ⟨n+1, _⟩ = ctx ⟨n, _⟩ -/
@[simp]
theorem Valuation.cons_eval {ty : Ty} (Γ : Ctxt Ty) (V : Γ.Valuation) (v : ⟦ty⟧)
    (hvar : (Ctxt.cons ty Γ)[n+1]? = some var_val) :
    (V.cons v) ⟨n+1, hvar⟩ = V ⟨n, by simpa using hvar⟩ :=
  rfl

/-- There is only one distinct valuation for the empty context -/
theorem Valuation.eq_nil : ∀ (V : Valuation (empty : Ctxt Ty)), V = HVector.nil :=
  HVector.eq_nil

@[simp]
theorem Valuation.cons_toCons_last {Γ : Ctxt Ty} {t : Ty} (V : Valuation (Γ.cons t)) :
    cons (V <|.last ..) (fun _ v' => V v'.toCons) = V := by
  funext _ v
  cases v using Var.casesOn <;> rfl

/-! ## Valuation Append -/

instance (Γ Δ : Ctxt Ty) : HAppend (Valuation Γ) (Valuation Δ) (Valuation <| Γ ++ Δ) where
  hAppend V W := fun t v =>
    v.appendCases (@V t) (@W t)

variable {V : Γ.Valuation} {W : Δ.Valuation}

@[simp] theorem Valuation.append_appendInl {v : Γ.Var t} :
    (V ++ W) v.appendInl = V v := by
  simp [(· ++ ·)]

@[simp] theorem Valuation.append_appendInr {v : Var Δ t} :
    (V ++ W) v.appendInr = W v := by
  simp [(· ++ ·)]

@[simp] theorem Valuation.append_inj_right {V : Γ.Valuation} {W W' : Δ.Valuation} :
    (V ++ W) = (V ++ W') ↔ W = W' where
  mpr := by rintro rfl; rfl
  mp := by
    intro h
    funext t v
    suffices (V ++ W) v.appendInr = (V ++ W') v.appendInr by simpa
    rw [h]

@[simp] theorem Valuation.append_inj_left {V V' : Γ.Valuation} {W : Δ.Valuation} :
    (V ++ W) = (V' ++ W) ↔ V = V' where
  mpr := by rintro rfl; rfl
  mp := by
    intro h
    funext t v
    suffices (V ++ W) v.appendInl = (V' ++ W) v.appendInl by simpa
    rw [h]

@[simp] theorem Valuation.nil_append {V : Γ.Valuation} :
    HAppend.hAppend (α := Valuation no_index _) (γ := Valuation no_index _)
      (nil (Ty:=Ty)) V -- nil ++ V
    = V := rfl

@[simp] theorem Valuation.cons_append {V : Γ.Valuation} {W : Δ.Valuation} {x : ⟦t⟧} :
    HAppend.hAppend (α := Valuation no_index _) (γ := Valuation no_index _)
      (x ::ᵥ V) W -- x::ᵥV ++ W
    = x ::ᵥ (V ++ W) := by
  funext _t v
  cases v using Var.appendCases with
  | left v =>
      rw [append_appendInl]
      cases v using Var.casesOn
      <;> simp [Var.appendInl_toCons]
  | right v =>
      rw [append_appendInr, Var.toCons_appendInr]
      simp

/-! ## Valuation ofHVector -/

/-- Build valuation from a vector of values of types `types`. -/
def Valuation.ofHVector {types : List Ty} : HVector toType types → Valuation (Ctxt.ofList types)
  | .nil        => (nil : Ctxt.Valuation ∅)
  | .cons x xs  => cons x (ofHVector xs)

@[simp]
instance Valuation.instAppendHVector (Γ : Ctxt Ty) (ts : List Ty) :
    HAppend (HVector toType ts) (Valuation Γ) (Valuation <| ⟨ts⟩ ++ Γ) where
  hAppend vals V :=
    (Valuation.ofHVector vals) ++ V

section Lemmas
variable {ts : List Ty}

@[simp] theorem Valuation.ofHVector_nil : ofHVector (Ty:=Ty) .nil = nil := rfl
@[simp] theorem Valuation.ofHVector_cons :
    ofHVector (Ty:=Ty) (x ::ₕ xs) = x ::ᵥ (ofHVector xs) := rfl

@[simp] theorem Valuation.ofHVector_apply (xs : HVector toType ts)
    (v : Var ⟨ts⟩ t) :
    ofHVector xs v = xs[v] := by
  induction xs
  case nil => exact v.emptyElim
  case cons x xs ih =>
    cases v using Var.casesOn
    · simpa [ih] using (HVector.cons_getElem_toCons _ _ _).symm
    · simpa [ih] using (HVector.cons_getElem_last _ _ _).symm

@[simp] theorem Valuation.ofHVector_inj (xs ys : HVector toType ts) :
    ofHVector xs = ofHVector ys ↔ xs = ys := by
  apply Iff.intro (mpr := by rintro rfl; rfl)
  intro h
  induction xs <;> cases ys
  case nil => rfl
  case cons x xs ih y ys =>
    replace h {t} (v : Var _ t) : (x::ᵥofHVector xs) v = (y::ᵥofHVector ys) v := by
      simp_all
    rw [HVector.cons.injEq]
    apply And.intro
    · simpa using h (Var.last _ _)
    · apply ih
      funext t v
      simpa using h v.toCons


end Lemmas

/-! ## Valuation Construction Helpers -/

/-- Make a a valuation for a singleton value -/
def Valuation.singleton {t : Ty} (v : toType t) : Ctxt.Valuation ⟨[t]⟩ :=
  Ctxt.Valuation.nil.cons v

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

@[simp] theorem Valuation.comap_cons_consMap {Γ Γ_out : Ctxt Ty}
    (V : Γ_out.Valuation) {t} (x : ⟦t⟧) (map : Γ.Hom Γ_out) :
    Valuation.comap (x ::ᵥ V) (Ctxt.Hom.consMap map)
    = (x ::ᵥ (Valuation.comap V map)) := by
  funext t' v
  cases v using Var.casesOn <;> rfl

@[simp] theorem Valuation.comap_id {Γ : Ctxt Ty} (V : Valuation Γ) : comap V Hom.id = V := rfl

@[simp] theorem Valuation.comap_cons_consRight {Γ Δ : Ctxt Ty} (Γv : Valuation Γ) (f : Hom Δ Γ) :
    comap (Γv.cons x) (f.consRight) = comap Γv f :=
  rfl

@[simp] theorem Valuation.comap_append_append {Γ Δ ζ : Ctxt Ty}
    (V : Γ.Valuation) (W : ζ.Valuation)
    (f : Δ.Hom Γ) :
    (W ++ V).comap (f.append) = W ++ (V.comap f) := by
  funext t v; cases v using Var.appendCases <;> simp

@[simp] theorem Valuation.comap_appendCodomain {Γ Δ ζ : Ctxt Ty}
    (V : Γ.Valuation) (W : ζ.Valuation) (f : Δ.Hom Γ) :
    (W ++ V).comap f.appendCodomain = V.comap f := by
  funext t v; simp

/-! ### Reassign Variables-/

/-- Reassign the variable var to value val in context ctxt -/
def Valuation.reassignVars [DecidableEq Ty] {ts : List Ty} {Γ : Ctxt Ty}
    (V : Γ.Valuation) (var : HVector Γ.Var ts) (val : HVector toType ts) : Γ.Valuation :=
  fun _ vneedle =>
    match var.idxOf? vneedle with
    | none => V vneedle
    | some ⟨i, h⟩ => h ▸ val.get i

@[simp] theorem Valuation.reassignVars_eq [DecidableEq Ty] (V : Γ.Valuation) :
    V.reassignVars vs (vs.map V) = V := by
  funext t w
  unfold reassignVars
  induction vs
  case nil => rfl
  case cons v vs ih =>
    by_cases h_eq : w.eq v
    · have := h_eq.ty_eq
      subst this
      have := h_eq.to_eq
      subst this
      simp
    · unfold Var.eq at h_eq
      simp only [HVector.idxOf?, h_eq, ↓reduceDIte, List.get_eq_getElem, List.length_cons,
        HVector.map_cons]
      split at ih <;> simp_all

@[simp] theorem Valuation.comap_with [DecidableEq Ty] {Γ Δ : Ctxt Ty}
    {V : Valuation Γ} {map : Δ.Hom Γ} {vs : HVector Δ.Var ty} {ws : HVector Γ.Var ty} :
    V.comap (map.with vs ws) = (V.comap map).reassignVars vs (ws.map V) := by
  funext t' v'
  simp only [comap, Hom.with, reassignVars]
  split <;> aesop

/-! ### Recursion -/

/-- Recursion principle for valuations in terms of `Valuation.nil` and `Valuation.cons` -/
@[elab_as_elim, induction_eliminator]
def Valuation.recOn {motive : ∀ {Γ : Ctxt Ty}, Γ.Valuation → Sort*}
    (nil  : motive (Valuation.nil))
    (cons : ∀ {Γ t} (V : Valuation Γ) (v : ⟦t⟧), motive V → motive (v ::ᵥ V)) :
    ∀ {Γ} (V : Valuation Γ), motive V := by
  intro Γ V
  induction' Γ with Γ t ih
  · exact (eq_nil V).symm ▸ nil
  · exact cons_toCons_last V ▸ (cons (fun _ v' => V v'.toCons) (V <|.last ..) (ih _))

/-! ### Cast -/

def Valuation.cast {Γ Δ : Ctxt Ty} (h : Γ = Δ) (V : Valuation Γ) : Valuation Δ :=
  fun _ v => V <| v.castCtxt h.symm

@[simp] theorem Valuation.cast_rfl {Γ : Ctxt Ty} (h : Γ = Γ) (V : Valuation Γ) : V.cast h = V := rfl

@[simp] theorem Valuation.cast_apply {Γ : Ctxt Ty} (h : Γ = Δ) (V : Γ.Valuation) (v : Δ.Var t) :
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
    case cons u Γ ih =>
      cases v
      case last   => rfl
      case toCons => apply ih (fun t v => V v.toCons)
  right_inv vs := by
    simp only [Fin.getElem_fin]
    induction vs
    case nil => rfl
    case cons t Γ v vs ih =>
      simp [HVector.ofFn, ofHVector, ih, -ofHVector_apply]

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
theorem val_toCons {Γ : Ctxt Ty} {t t' : Ty} (v : Γ.Var t) : (@toCons _ _ _ t' v).val = v.val + 1 :=
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
def toCons (d : Diff Γ₁ Γ₂) : Diff Γ₁ (Γ₂.cons t) :=
  ⟨d.val + 1, by
    intro i _ h_get_cons
    rcases d with ⟨d, h_get_d⟩
    simp only [← h_get_d h_get_cons]
    rfl
  ⟩

/-- Removing a type from the left context corresponds to incrementing the difference by 1 -/
def unCons (d : Diff (Γ₁.cons t) Γ₂) : Diff Γ₁ Γ₂ :=
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

@[simp, grind] theorem val_add (f : Γ.Diff Δ) (g : Δ.Diff Ξ) : (f + g).val = f.val + g.val := rfl

/-!
### `toHom`
-/

/-- Adding the difference of two contexts to variable indices is a context mapping -/
def toHom (d : Diff Γ₁ Γ₂) : Hom Γ₁ Γ₂ :=
  fun _ v => ⟨v.val + d.val, d.property v.property⟩

section Lemmas

@[simp, grind] theorem val_toHom_apply (d : Diff Γ Δ) (v : Γ.Var t) :
    (d.toHom v).val = v.val + d.val := rfl

theorem Valid.of_succ {Γ₁ Γ₂ : Ctxt Ty} {d : Nat} (h_valid : Valid Γ₁ (Γ₂.cons t) (d+1)) :
    Valid Γ₁ Γ₂ d := by
  intro i t h_get
  simp [←h_valid h_get, cons, List.getElem?_cons]
  rfl

theorem toHom_succ {Γ₁ Γ₂ : Ctxt Ty} {d : Nat} (h : Valid Γ₁ (Γ₂.cons t) (d+1)) :
    toHom ⟨d+1, h⟩ = (toHom ⟨d, Valid.of_succ h⟩).consRight := by
  rfl

@[simp] theorem toHom_zero {Γ : Ctxt Ty} {h : Valid Γ Γ 0} :
    toHom ⟨0, h⟩ = Hom.id := by
  rfl

@[simp] theorem toHom_unCons {Γ₁ Γ₂ : Ctxt Ty} (d : Diff (Γ₁.cons t) Γ₂) :
    toHom (unCons d) = fun _ v => (toHom d) v.toCons := by
  unfold unCons Var.toCons toHom
  simp only [Valid]
  funext x v
  congr 1
  rw [Nat.add_assoc, Nat.add_comm 1]

@[simp] theorem toHom_comp_toHom (f : Γ.Diff Δ) (g : Δ.Diff Ξ) :
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

/-- `cons` of a derived context applies `cons` to the underlying context, and updates the diff -/
@[simp]
def cons {Γ : Ctxt Ty} : Ty → DerivedCtxt Γ → DerivedCtxt Γ
  | ty, ⟨⟨Δ⟩, diff⟩ => ⟨ty::Δ, diff.toCons⟩

@[simp]
theorem ctxt_cons {Γ : DerivedCtxt Δ} :
    (Γ.cons ty).ctxt = Γ.ctxt.cons ty :=
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
  ⟨Γ.toList.drop (v.val + 1)⟩

variable {Γ} {v}

@[simp] theorem dropUntil_last   : dropUntil (cons ty Γ) (Var.last Γ ty) = Γ := rfl
@[simp] theorem dropUntil_toCons : dropUntil (cons ty Γ) (Var.toCons v) = dropUntil Γ v := rfl

@[simp] theorem dropUntil_castCtxt {h : Γ = Γ'} :
    Γ'.dropUntil (v.castCtxt h) = Γ.dropUntil v := by
  subst h; rfl

@[simp] theorem dropUntil_appendInr (v : Δ.Var t) :
    (Γ ++ Δ).dropUntil v.appendInr = Δ.dropUntil v := by
  have : v.1 + Γ.length + 1 = Γ.toList.length + (v.1 + 1) := by grind
  simp [dropUntil, this]

@[simp] theorem dropUntil_appendInl {v : Var Γ t} :
    (Γ ++ Δ).dropUntil v.appendInl = (Γ.dropUntil v) ++ Δ := by
  rcases Γ
  rcases Δ
  -- TODO: upstream the following as a `List` lemma
  suffices ∀ {xs} (i : Nat) (hi : i ≤ xs.length) (ys : List Ty),
    List.drop i (xs ++ ys) = List.drop i xs ++ ys
  by
    have h := v.val_lt
    simpa [dropUntil] using this _ (by grind) _
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
    case cons _ _ ih =>
      cases v using Var.casesOn
      · simp only [Var.val_toCons] at h ⊢
        apply ih h
      · simpa! using h
  ⟩

/-- Context homomorphism from `(Γ.dropUntil v)` to `Γ`, see also `dropUntilDiff` -/
abbrev dropUntilHom : Hom (Γ.dropUntil v) Γ := dropUntilDiff.toHom

@[simp, grind=] theorem val_dropUntilDiff : (@dropUntilDiff _ Γ _ v).val = v.val+1 := rfl

@[simp] theorem dropUntilHom_last : dropUntilHom (v := Var.last Γ ty) = Hom.id.consRight := rfl
@[simp] theorem dropUntilHom_toCons {v : Var Γ t} :
  dropUntilHom (v := v.toCons (t' := t')) = (dropUntilHom (v:=v)).consRight := rfl

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
      V_acc := mkApp6 (mkConst ``Ctxt.Valuation.cons) Ty instTyDenote Γ ty x V_acc
      Γ_acc := mkApp3 (.const ``List.cons [0]) Ty ty Γ_acc
    V_acc

end ToExpr

end Ctxt
