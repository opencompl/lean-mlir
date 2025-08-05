/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core
import Mathlib.Tactic.Linarith

open Ctxt (Var Valuation Hom)


/-- Delete a variable from a list. -/
def Ctxt.delete (Γ : Ctxt Ty) (v : Γ.Var α) : Ctxt Ty :=
  ⟨Γ.toList.eraseIdx v.val⟩

@[simp] theorem Ctxt.delete_snoc_toSnoc {Γ : Ctxt Ty} {v : Γ.Var t} :
    (Γ.snoc u).delete (v.toSnoc) = (Γ.delete v).snoc u := rfl

def Hom.delete {Γ : Ctxt Ty} (delv : Γ.Var t) : Hom (Γ.delete delv) Γ :=
  fun t' v =>
    let idx :=
      if v.val < delv.val then
        v.val
      else
        v.val + 1
    ⟨idx, by
      unfold idx
      split_ifs with h_val
      <;> simpa [Ctxt.delete, List.getElem?_eraseIdx, h_val] using v.prop
    ⟩

@[simp] lemma Hom.delete_toSnoc_toSnoc {Γ : Ctxt Ty}
    {delv : Γ.Var t} {v : (Γ.delete delv).Var t'} :
    Hom.delete (delv.toSnoc : (Γ.snoc u).Var t) v.toSnoc = (Hom.delete delv v).toSnoc := by
  simp only [delete, Var.val_toSnoc, add_lt_add_iff_right]
  split <;> rfl

/-- Witness that Γ' is Γ without v -/
def Deleted {α : Ty} (Γ: Ctxt Ty) (v : Γ.Var α) (Γ' : Ctxt Ty) : Prop :=
  Γ' = Γ.delete v

/-- build a `Deleted` for a `(Γ.snoc α) → Γ`-/
def Deleted.deleteSnoc (Γ : Ctxt Ty) (α : Ty) : Deleted (Γ.snoc α) (Ctxt.Var.last Γ α) Γ := rfl


/-- snoc an `ω` to both the input and output contexts of `Deleted Γ v Γ'` -/
def Deleted.snoc {α : Ty} {Γ : Ctxt Ty} {v : Γ.Var α}
    (DEL : Deleted Γ v Γ') (ω : Ty) :
    Deleted (Γ.snoc ω) v.toSnoc (Γ'.snoc ω) := by
  simp only [Deleted, Ctxt.delete, Ctxt.Var.val_toSnoc] at DEL ⊢
  subst DEL
  rfl

def Deleted.toHom (h : Deleted Γ v Γ') : Γ'.Hom Γ :=
  h ▸ Hom.delete _

@[simp] lemma Deleted.toHom_snoc {Γ Γ' : Ctxt Ty} {v : Γ.Var t}
    (DEL : Deleted (Γ.snoc u) v.toSnoc (Γ'.snoc u)) :
    DEL.toHom =
      have DEL' : Deleted Γ v Γ' := by
        rcases Γ'
        simp only [Deleted, Ctxt.delete_snoc_toSnoc] at DEL ⊢
        injection DEL
        simp_all [Ctxt.delete]
      DEL'.toHom.snocMap := by
  have DEL' : Deleted Γ v Γ' := by
    rcases Γ'
    simp only [Deleted, Ctxt.delete_snoc_toSnoc] at DEL ⊢
    injection DEL
    simp_all [Ctxt.delete]
  subst DEL'
  funext t v;
  simp only [Deleted.toHom]
  cases v
  · simp
  · simp [Hom.delete]

@[simp] lemma Deleted.toHom_last (DEL : Deleted (Γ.snoc u) (Var.last _ _) Γ) :
    DEL.toHom = Hom.id.snocRight := rfl

/-! ## tryDelete? -/

/-- Given  `Γ' := Γ/delv`, transport a variable from `Γ` to `Γ', if `v ≠ delv`. -/
def Var.tryDelete? [TyDenote Ty] {Γ Γ' : Ctxt Ty} {delv : Γ.Var α}
  (DEL : Deleted Γ delv Γ') (v : Γ.Var β) :
    Option { v' : Γ'.Var β // v = (DEL.toHom) v' } :=
  if h_val_eq : v.val = delv.val then
    none -- if it's the deleted variable, then return nothing.
  else
    let idx := if v.val < delv.val then v.val else v.val - 1
    let v' := ⟨idx, by
      subst DEL
      simp only [Ctxt.delete, Ctxt.getElem?_ofList, List.getElem?_eraseIdx, idx]
      split_ifs with h_val_lt h_val_sub_lt
      · exact v.prop
      · omega
      · rw [Nat.sub_add_cancel (by omega)]
        exact v.prop
    ⟩
    some ⟨v', by
      subst DEL
      simp +zetaDelta only [Deleted.toHom, Hom.delete]
      split_ifs
      · rfl
      · omega
      · rcases v; congr; rw [Nat.sub_add_cancel (by omega)]
    ⟩

namespace DCE

variable {d : Dialect} [TyDenote d.Ty]

/-- Try to delete the variable from the argument list.
  Succeeds if variable does not occur in the argument list.
  Fails otherwise. -/
def arglistDeleteVar? {Γ: Ctxt d.Ty} {delv : Γ.Var α} {Γ' : Ctxt d.Ty} {ts : List d.Ty}
  (DEL : Deleted Γ delv Γ')
  (as : HVector (Ctxt.Var Γ) <| ts) :
  Option
    { as' : HVector (Ctxt.Var Γ') <| ts // as = as'.map DEL.toHom } :=
  match as with
  | .nil => .some ⟨.nil, by rfl⟩
  | .cons a as =>
    match Var.tryDelete? DEL a with
    | .none => .none
    | .some ⟨a', ha'⟩ =>
      match arglistDeleteVar? DEL as with
      | .none => .none
      | .some ⟨as', has'⟩ => .some ⟨.cons a' as', by simp [HVector.map_cons, *]⟩

variable [DialectSignature d] [DialectDenote d] [Monad d.m] [LawfulMonad d.m]

/- Try to delete a variable from an Expr -/
def Expr.deleteVar? (DEL : Deleted Γ delv Γ') (e: Expr d Γ .pure t) :
  Option { e' : Expr d Γ' .pure t // ∀ (V : Γ.Valuation),
    e.denoteOp V = e'.denoteOp (V.comap DEL.toHom) } :=
  match e with
  | .mk op ty_eq eff_le args regArgs => do
    let args' ← arglistDeleteVar? DEL args
    some ⟨.mk op ty_eq eff_le args' regArgs, by
      obtain ⟨ args', rfl ⟩ := args'
      intros V
      simp [Expr.denoteOp, HVector.map_map]
      rfl
    ⟩

/-- Delete a variable from an Com. -/
def Com.deleteVar? (DEL : Deleted Γ delv Γ') (com : Com d Γ .pure t) :
  Option { com' : Com d Γ' .pure t // ∀ (V : Γ.Valuation),
    com.denote V = com'.denote (V.comap DEL.toHom) } :=
  match com with
  | .ret v => do
    let ⟨v, hv⟩ ← Var.tryDelete? DEL v
    return ⟨.ret v, by simp [hv]⟩
  | .var (α := ω) e body => do
    let ⟨body', hbody'⟩ ← Com.deleteVar? (DEL.snoc _) body
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
    {t : d.Ty} (com : Com d Γ .pure t) : Type :=
  Σ (Γ' : Ctxt d.Ty) (hom: Hom Γ' Γ),
    { com' : Com d Γ' .pure t //  ∀ (V : Γ.Valuation), com.denote V = com'.denote (V.comap hom)}

/-- Show that DCEType in inhabited. -/
instance [SIG : DialectSignature d] [DENOTE : DialectDenote d] {Γ : Ctxt d.Ty} {t : d.Ty}
    (com : Com d Γ .pure t) : Inhabited (DCEType com) where
  default :=
    ⟨Γ, Hom.id, com, by intros V; rfl⟩

variable [LawfulMonad d.m]
/-- walk the list of bindings, and for each `let`, try to delete the variable
defined by the `let` in the body/ Note that this is `O(n^2)`, for an easy
proofs, as it is written as a forward pass.  The fast `O(n)` version is a
backward pass.
-/
partial def dce_ {Γ : Ctxt d.Ty} {t : d.Ty}
    (com : Com d Γ .pure t) : DCEType com :=
  match HCOM: com with
  | .ret v => -- If we have a `ret`, return it.
    ⟨Γ, Hom.id, ⟨.ret v, by
      intros V
      unfold Ctxt.Valuation.comap
      simp
      ⟩⟩
  | .var (α := α) e body =>
    let DEL := Deleted.deleteSnoc Γ α
    -- Try to delete the variable α in the body.
    match Com.deleteVar? DEL body with
    | .none => -- we don't succeed, so DCE the child, and rebuild the same `let` binding.
      let ⟨Γ', hom', ⟨body', hbody'⟩⟩
        : Σ (Γ' : Ctxt d.Ty) (hom: Hom Γ' (Ctxt.snoc Γ α)),
        { body' : Com d Γ' .pure t //  ∀ (V : (Γ.snoc α).Valuation),
        body.denote V = body'.denote (V.comap hom)} :=
        (dce_ body)
      let com' := Com.var (α := α) e (body'.changeVars hom')
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
          simp [EffectKind.toMonad_pure, HCOM, Com.denote_var,
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
def dce {Γ : Ctxt d.Ty} {t : d.Ty} (com : Com d Γ .pure t) :
  Σ (Γ' : Ctxt d.Ty) (hom: Hom Γ' Γ),
    { com' : Com d Γ' .pure t //  ∀ (V : Γ.Valuation), com.denote V = com'.denote (V.comap hom)} :=
  dce_ com

/-- A version of DCE that returns an output program with the same context. It uses the context
   morphism of `dce` to adapt the result of DCE to work with the original context -/
def dce' {Γ : Ctxt d.Ty} {t : d.Ty}
    (com : Com d Γ .pure t) :
    { com' : Com d Γ .pure t //  ∀ (V : Γ.Valuation), com.denote V = com'.denote V} :=
  let ⟨ Γ', hom, com', hcom'⟩ := dce_ com
  ⟨com'.changeVars hom, by simp [hcom']⟩

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
    | .add    => ⟨[.nat, .nat], [], .nat, .pure⟩
    | .beq    => ⟨[.nat, .nat], [], .bool, .pure⟩
    | .cst _  => ⟨[], [], .nat, .pure⟩

@[reducible]
instance : DialectDenote Ex where
  denote
    | .cst n, _, _ => n
    | .add, .cons (a : Nat) (.cons b .nil), _ => a + b
    | .beq, .cons (a : Nat) (.cons b .nil), _ => a == b

def cst {Γ : Ctxt _} (n : ℕ) : Expr Ex Γ .pure .nat  :=
  Expr.mk
    (op := .cst n)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .nil)
    (regArgs := .nil)

def add {Γ : Ctxt _} (e₁ e₂ : Ctxt.Var Γ .nat) : Expr Ex Γ .pure .nat :=
  Expr.mk
    (op := .add)
    (ty_eq := rfl)
    (eff_le := by constructor)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := .nil)

attribute [local simp] Ctxt.snoc

def ex1_pre_dce : Com Ex ∅ .pure .nat :=
  Com.var (cst 1) <|
  Com.var (cst 2) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

/-- TODO: how do we evaluate 'ex1_post_dce' within Lean? :D -/
def ex1_post_dce : Com Ex ∅ .pure .nat := (dce' ex1_pre_dce).val

def ex1_post_dce_expected : Com Ex ∅ .pure .nat :=
  Com.var (cst 2) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

theorem checkDCEasExpected :
  ex1_post_dce = ex1_post_dce_expected := by native_decide

end Examples
end DCE
