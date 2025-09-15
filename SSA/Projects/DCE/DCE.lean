/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.DepRewrite

open Ctxt (Var Valuation Hom)

/-! ## DeleteRange -/
namespace DCE

/-- A `DeleteRange Γ` indicates a consecutive range of variables in `Γ` to
be deleted. -/
structure DeleteRange (Γ : Ctxt Ty) where
  /-- The first variable to delete. -/
  start : Fin (Γ.length + 1)
  /-- The number of variables to delete -/
  num : Fin (Γ.length + 1 - start.val)
open DCE (DeleteRange)

namespace DeleteRange

/-- `DeleteRange.full Γ` is the range of all variables in `Γ`. -/
def full (Γ : Ctxt Ty) : DeleteRange Γ where
  start := ⟨0, by omega⟩
  num := ⟨Γ.length, by simp⟩

def appendInl {Γ : Ctxt Ty} {ts : List Ty}
    (r : DeleteRange Γ) : DeleteRange (Γ ++ ts) where
  start := ⟨r.start + ts.length, by grind⟩
  num := ⟨r.num, by grind⟩

def appendInr {Γ : Ctxt Ty} {ts : List Ty}
    (r : DeleteRange ⟨ts⟩) : DeleteRange (Γ ++ ts) where
  start := ⟨r.start, by grind⟩
  num := ⟨r.num, by grind⟩

section Lemmas

@[simp, grind=] lemma val_start_full  :
    (full Γ).start.val = 0 := rfl
@[simp, grind=] lemma val_num_full :
    (full Γ).num.val = Γ.length := rfl

@[simp, grind=] lemma val_start_appendInl (r : DeleteRange Γ) :
    (r.appendInl (ts := ts)).start.val = r.start.val + ts.length := rfl
@[simp, grind=] lemma val_num_appendInl (r : DeleteRange Γ) :
    (r.appendInl (ts := ts)).num.val = r.num.val := rfl

@[simp, grind=] lemma val_start_appendInr (r : DeleteRange ⟨ts⟩) :
    (r.appendInr (Γ := Γ)).start.val = r.start.val := rfl
@[simp, grind=] lemma val_num_appendInr (r : DeleteRange ⟨ts⟩) :
    (r.appendInr (Γ := Γ)).num.val = r.num.val := rfl

end Lemmas

end DeleteRange
end DCE

/-! ## Ctxt.delete -/
open DCE (DeleteRange)

/-- Delete a vector of variables from a ctxt. -/
def Ctxt.delete (Γ : Ctxt Ty) (vs : DeleteRange Γ) : Ctxt Ty :=
  Ctxt.ofList <| List.ofFn (n := Γ.length - vs.num.val) fun i =>
    have := vs.start.prop
    if hi : i.val < vs.start then
      Γ[i.val]
    else
      Γ[i.val + vs.num]

@[simp] theorem Ctxt.delete_append_appendInl {Γ : Ctxt Ty} {us : List Ty}
    {r : DeleteRange Γ} :
    (Γ ++ us).delete r.appendInl = (Γ.delete r) ++ us := by
  rcases Γ with ⟨Γ⟩
  ext i t
  simp only [delete, ofList_append, length_ofList, List.length_append,
    DeleteRange.val_start_appendInl, DeleteRange.val_num_appendInl, Fin.coe_cast, getElem_ofList,
    dite_eq_ite, getElem?_ofList, List.getElem?_ofFn, Option.dite_none_right_eq_some,
    Option.some.injEq]
  rw [List.getElem?_append]
  by_cases hi : i < us.length <;> simp only [reduceIte, hi]
  · have : i < us.length + Γ.length - r.num := by grind
    have : i < r.start + us.length := by grind
    simp [*]
  · simp only [List.getElem?_ofFn, Option.dite_none_right_eq_some, Option.some.injEq]
    simp only [
      List.getElem_append_right (Nat.ge_of_not_lt hi),
      List.getElem_append_right (by grind : us.length ≤ i + r.num),
      length_ofList
    ]
    split <;> grind

section Lemmas
variable {Γ : Ctxt Ty}

@[simp] lemma Ctxt.delete_empty :
    (empty : Ctxt Ty).delete vs = empty := by
  simp [empty, delete]

@[simp, grind=] lemma Ctxt.getElem?_delete_of_lt_start {i : Nat} {vs : DeleteRange Γ}
    (h : i < vs.start) :
    (Γ.delete vs)[i]? = Γ[i]? := by
  grind [delete]

@[simp, grind=] lemma Ctxt.getElem?_delete_of_ge_start {i : Nat} {vs : DeleteRange Γ}
    (h : vs.start ≤ i) :
    (Γ.delete vs)[i]? = Γ[i + vs.num]? := by
  grind [delete]

@[simp, grind=] lemma Ctxt.getElem?_delete_eq_none_iff {i : Nat} {vs : DeleteRange Γ} :
    (Γ.delete vs)[i]? = none ↔ Γ.length ≤ i + vs.num := by
  simp [delete]

lemma Ctxt.getElem?_delete {i : Nat} {vs : DeleteRange Γ} :
    (Γ.delete vs)[i]? = if i < vs.start then Γ[i]? else Γ[i + vs.num]? := by
  split <;> grind

/-- Subtract one from the starting position of a `DeleteRange` (without changing
the number of variables deleted). -/
def DCE.DeleteRange.pred (vs : DeleteRange (Γ.cons t)) (h : vs.start ≠ 0) :
    DeleteRange Γ where
  start := vs.start.pred (fun h' => by simp [h'] at h)
  num := ⟨vs.num, by
    rcases vs with ⟨⟨start, hs⟩, ⟨num, hn⟩⟩
    simp at h hn ⊢
    omega
  ⟩

lemma Ctxt.delete_eq_of_num_eq_zero {vs : DeleteRange Γ} (h : vs.num.val = 0) :
    Γ.delete vs = Γ := by
  ext i; grind [delete]

lemma Ctxt.delete_cons {vs : DeleteRange (Γ.cons t)} {h : vs.start ≠ 0} :
    (Γ.cons t |>.delete vs) = (Γ.delete (vs.pred h) |>.cons t) := by
  ext i
  rw [Ctxt.getElem?_delete]
  induction i generalizing vs
  case zero =>
    have : 0 < vs.start := by
      cases h : vs.start using Fin.succRec
      · contradiction
      · simp
    simp [this]
    rfl
  case succ i ih =>
    simp only [length_cons, getElem?_cons_succ,
      show i + 1 + vs.num = i + vs.num + 1 by omega]
    rw [Ctxt.getElem?_delete]
    simp [DeleteRange.pred]
    grind

end Lemmas

def Hom.delete {Γ : Ctxt Ty} (delv : DeleteRange Γ) : Hom (Γ.delete delv) Γ :=
  fun t' v =>
    let idx :=
      if v.val < delv.start then
        v.val
      else
        v.val + delv.num
    ⟨idx, by
      subst idx
      rcases v with ⟨v, hv⟩
      simp only [← hv, Ctxt.getElem?_delete]
      split_ifs with h_val <;> rfl
    ⟩

/-- Witness that Γ' is Γ without v -/
def Deleted (Γ: Ctxt Ty) (vs : DeleteRange Γ) (Γ' : Ctxt Ty) : Prop :=
  Γ' = Γ.delete vs

/-- build a `Deleted` for a `(Γ ++ αs) → Γ`-/
def Deleted.deleteAppend (Γ : Ctxt Ty) (αs : List Ty) :
    Deleted (Γ ++ αs) (DeleteRange.full ⟨αs⟩).appendInr Γ := by
  ext i
  rw [Ctxt.getElem?_delete]
  rcases Γ
  simp
  grind [List.getElem?_append_right]

/-- append an `ωs` to both the input and output contexts of `Deleted Γ v Γ'` -/
def Deleted.append {Γ : Ctxt Ty} {vs : DeleteRange Γ}
    (DEL : Deleted Γ vs Γ') (ωs : List Ty) :
    Deleted (Γ ++ ωs) vs.appendInl (Γ' ++ ωs) := by
  ext i
  subst DEL
  simp

def Deleted.toHom (h : Deleted Γ r Γ') : Γ'.Hom Γ :=
  fun _ v => Hom.delete r (v.castCtxt h)

@[simp] lemma Deleted.toHom_append {Γ Γ' : Ctxt Ty} {vs : DeleteRange Γ}
    (DEL : Deleted (Γ ++ us) vs.appendInl (Γ' ++ us)) :
    DEL.toHom
    = have DEL' : Deleted Γ vs Γ' := by
        rcases Γ'
        simp only [Deleted, Ctxt.delete_append_appendInl] at DEL ⊢
        injection DEL
        simp_all [Ctxt.delete]
      DEL'.toHom.append := by
  have DEL' : Deleted Γ vs Γ' := by
    rcases Γ'
    simp only [Deleted, Ctxt.delete_append_appendInl] at DEL ⊢
    injection DEL
    simp_all [Ctxt.delete]
  subst DEL'
  funext t v
  apply Subtype.eq
  simp only [toHom, Hom.delete, Var.val_castCtxt, DeleteRange.val_start_appendInl,
    DeleteRange.val_num_appendInl, Hom.append, Var.castCtxt_rfl]
  cases v using Var.appendCases with
  | left _  => simp; grind
  | right v =>
    have := v.val_lt
    simp; grind

@[simp] lemma Deleted.toHom_last
    (DEL : Deleted (Γ ++ us) (DeleteRange.full ⟨us⟩).appendInr Γ) :
    DEL.toHom = Hom.id.appendCodomain := by
  simp [Deleted] at DEL
  funext t v
  apply Subtype.eq
  simp [toHom, Hom.delete, DeleteRange.full, DeleteRange.appendInr]

/-! ## tryDelete? -/

/-- Given  `Γ' := Γ/delv`, transport a variable from `Γ` to `Γ', if `v ≠ delv`. -/
def Var.tryDeleteOne? [TyDenote Ty] {Γ Γ' : Ctxt Ty} {delv : DeleteRange Γ}
  (DEL : Deleted Γ delv Γ') (v : Γ.Var β) :
    Option { v' : Γ'.Var β // v = DEL.toHom v' } :=
  if h_val_eq : delv.start ≤ v.val ∧ v.val < delv.start.val + delv.num.val then
    none -- if `v` is in the range of deleted variables, return nothing.
  else
    let idx := if v.val < delv.start then v.val else v.val - delv.num
    let v' := ⟨idx, by
      subst DEL idx
      simp at h_val_eq
      rw [Ctxt.getElem?_delete]
      split_ifs
      · exact v.prop
      · exfalso; omega
      · have := v.prop
        grind
    ⟩
    some ⟨v', by
      subst DEL idx v'
      simp only [Deleted.toHom, Hom.delete, Var.castCtxt_rfl]
      split_ifs
      · rfl
      · exfalso; omega
      · apply Subtype.eq
        simp
        omega
    ⟩

/-- Given  `Γ' := Γ/delv`, transport a vector of variables from `Γ` to `Γ',
assuming that none of those variables were deleted. -/
def Var.tryDelete? [TyDenote Ty] {Γ Γ' : Ctxt Ty} {delv : DeleteRange Γ}
  (DEL : Deleted Γ delv Γ') (vs : HVector Γ.Var β) :
    Option { v' : HVector Γ'.Var β // vs = v'.map DEL.toHom } := do
  match vs with
  | .nil => some ⟨.nil, rfl⟩
  | v ::ₕ vs => do
      let ⟨v, hv⟩ ← tryDeleteOne? DEL v
      let ⟨vs, hvs⟩ ← tryDelete? DEL vs
      return ⟨v ::ₕ vs, by simp_all⟩

namespace DCE

variable {d : Dialect} [TyDenote d.Ty]

variable [DialectSignature d] [DialectDenote d] [Monad d.m] [LawfulMonad d.m]

/- Try to delete a variable from an Expr -/
def Expr.deleteVar? (DEL : Deleted Γ delv Γ') (e: Expr d Γ .pure t) :
  Option { e' : Expr d Γ' .pure t // ∀ (V : Γ.Valuation),
    e.denoteOp V = e'.denoteOp (V.comap DEL.toHom) } :=
  match e with
  | .mk op ty_eq eff_le args regArgs => do
    let args' ← Var.tryDelete? DEL args
    some ⟨.mk op ty_eq eff_le args' regArgs, by
      obtain ⟨ args', rfl ⟩ := args'
      intros V
      simp [Expr.denoteOp, HVector.map_map]
      rfl
    ⟩

/-- Delete a variable from an Com. -/
def Com.deleteVar? (DEL : Deleted Γ delv Γ')
    (com : Com d Γ .pure ts) :
    Option { com' : Com d Γ' .pure ts // ∀ (V : Γ.Valuation),
      com.denote V = com'.denote (V.comap DEL.toHom) } :=
  match com with
  | .rets vs => do
    let ⟨vs, hv⟩ ← Var.tryDelete? DEL vs
    return ⟨.rets vs, by
      intro V
      simp [hv, HVector.map_map]; rfl
    ⟩
  | .var (ty := ω) e body => do
    let ⟨body', hbody'⟩ ← Com.deleteVar? (DEL.append ω) body
    let ⟨e', he'⟩ ← Expr.deleteVar? DEL e
    .some ⟨.var e' body', by
      intros V
      apply Id.ext
      simp [Com.denote, Expr.denote_unfold, ←he', hbody']
    ⟩

/-- Declare the type of DCE up-front, so we can declare an `Inhabited` instance.
This is necessary so that we can mark the DCE implementation as a `partial def`
and ensure that Lean does not freak out on us, since it's indeed unclear to Lean
that the output type of `dce` is always inhabited.
-/
def DCEType [DialectSignature d] [DialectDenote d] {Γ : Ctxt d.Ty}
    {t} (com : Com d Γ .pure t) : Type :=
  Σ (Γ' : Ctxt d.Ty) (hom: Hom Γ' Γ),
    { com' : Com d Γ' .pure t //  ∀ (V : Γ.Valuation), com.denote V = com'.denote (V.comap hom)}

/-- Show that DCEType in inhabited. -/
instance [SIG : DialectSignature d] [DENOTE : DialectDenote d] {Γ : Ctxt d.Ty} {t}
    (com : Com d Γ .pure t) : Inhabited (DCEType com) where
  default :=
    ⟨Γ, Hom.id, com, by intros V; rfl⟩

variable [LawfulMonad d.m]
/-- walk the list of bindings, and for each `let`, try to delete the variable
defined by the `let` in the body/ Note that this is `O(n^2)`, for an easy
proofs, as it is written as a forward pass.  The fast `O(n)` version is a
backward pass.
-/
partial def dce_ {Γ : Ctxt d.Ty} {t}
    (com : Com d Γ .pure t) : DCEType com :=
  match HCOM: com with
  | .rets v => -- If we have a `ret`, return it.
    ⟨Γ, Hom.id, ⟨.rets v, by
      intros V
      unfold Ctxt.Valuation.comap
      simp
      ⟩⟩
  | .var (ty := tys) e body =>
    let DEL := Deleted.deleteAppend Γ tys
    -- Try to delete the variable α in the body.
    match Com.deleteVar? DEL body with
    | .none => -- we don't succeed, so DCE the child, and rebuild the same `let` binding.
      let ⟨Γ', hom', ⟨body', hbody'⟩⟩
        : Σ (Γ' : Ctxt d.Ty) (hom: Hom Γ' (Γ ++ tys)),
        { body' : Com d Γ' .pure t //  ∀ (V : (Γ ++ tys).Valuation),
        body.denote V = body'.denote (V.comap hom)} :=
        (dce_ body)
      let com' := Com.var e (body'.changeVars hom')
      ⟨Γ, Hom.id, com', by
        intros V
        apply Id.ext
        simp (config := {zetaDelta := true}) [Com.denote, hbody']
      ⟩
    | .some ⟨body', hbody⟩ =>
      let ⟨Γ', hom', ⟨com', hcom'⟩⟩
      : Σ (Γ' : Ctxt d.Ty) (hom: Hom Γ' Γ),
        { com' : Com d Γ' .pure t //  ∀ (V : Γ.Valuation),
          com.denote V = com'.denote (V.comap hom)} :=
        ⟨Γ, Hom.id, ⟨body', by -- NOTE: we deleted the `let` binding.
          intros V
          simp [HCOM, Com.denote_var,
            Ctxt.Valuation.comap_id, hbody, Id.bind_eq']
        ⟩⟩
      let ⟨Γ'', hom'', ⟨com'', hcom''⟩⟩
        :   Σ (Γ'' : Ctxt d.Ty) (hom : Hom Γ'' Γ'),
          { com'' : Com d Γ'' .pure t //  ∀ (V' : Γ'.Valuation),
            com'.denote V' = com''.denote (V'.comap hom)} :=
        dce_ com'
        -- recurse into `com'`, which contains *just* the `body`, not the `let`,
        -- and return this.
      ⟨Γ'', hom''.comp hom', com'', by
        intros V
        rw [← HCOM]
        rw [hcom']
        rw [hcom'']
        rfl⟩

/-- This is the real entrypoint to `dce` which unfolds the type of `dce_`, where
we play the `DCEType` trick to convince Lean that the output type is in fact
inhabited. -/
def dce {Γ : Ctxt d.Ty} {t} (com : Com d Γ .pure t) :
  Σ (Γ' : Ctxt d.Ty) (hom: Hom Γ' Γ),
    { com' : Com d Γ' .pure t //  ∀ (V : Γ.Valuation), com.denote V = com'.denote (V.comap hom)} :=
  dce_ com

/-- A version of DCE that returns an output program with the same context. It uses the context
   morphism of `dce` to adapt the result of DCE to work with the original context -/
def dce' {Γ : Ctxt d.Ty} {t}
    (com : Com d Γ .pure t) :
    { com' : Com d Γ .pure t //  ∀ (V : Γ.Valuation), com.denote V = com'.denote V} :=
  let ⟨ Γ', hom, com', hcom'⟩ := dce_ com
  ⟨com'.changeVars hom, by simp [hcom']⟩

/-- info: 'DCE.dce' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms dce

namespace Examples

/-- A very simple type universe. -/
inductive ExTy
  | nat
  | bool
  deriving DecidableEq, Repr

@[reducible]
instance : TyDenote ExTy where
  toType
    | .nat => Nat
    | .bool => Bool

inductive ExOp :  Type
  | add : ExOp
  | beq : ExOp
  | cst : ℕ → ExOp
  deriving DecidableEq

abbrev Ex : Dialect where
  Op := ExOp
  Ty := ExTy

instance : DialectSignature Ex where
  signature
    | .add    => ⟨[.nat, .nat], [], [.nat], .pure⟩
    | .beq    => ⟨[.nat, .nat], [], [.bool], .pure⟩
    | .cst _  => ⟨[], [], [.nat], .pure⟩

@[reducible]
instance : DialectDenote Ex where
  denote
    | .cst n, _, _ => n ::ₕ .nil
    | .add, (a : Nat) ::ₕ b ::ₕ .nil, _ => a + b    ::ₕ .nil
    | .beq, (a : Nat) ::ₕ b ::ₕ .nil, _ => (a == b) ::ₕ .nil

def cst {Γ : Ctxt _} (n : ℕ) : Expr Ex Γ .pure [.nat] :=
  Expr.mk
    (op := .cst n)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .nil)
    (regArgs := .nil)

def add {Γ : Ctxt _} (e₁ e₂ : Ctxt.Var Γ .nat) : Expr Ex Γ .pure [.nat] :=
  Expr.mk
    (op := .add)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := .nil)

attribute [local simp] Ctxt.cons

def ex1_pre_dce : Com Ex ∅ .pure [.nat] :=
  Com.var (cst 1) <|
  Com.var (cst 2) <|
  Com.ret ⟨0, rfl⟩

def ex1_post_dce : Com Ex ∅ .pure [.nat] := (dce' ex1_pre_dce).val

def ex1_post_dce_expected : Com Ex ∅ .pure [.nat] :=
  Com.var (cst 2) <|
  Com.ret ⟨0, rfl⟩

theorem checkDCEasExpected :
  ex1_post_dce = ex1_post_dce_expected := by native_decide

end Examples
end DCE
