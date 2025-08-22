/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.DepRewrite

open Ctxt (Var Valuation Hom)

/-! ## DeleteRange -/

/-- A `DeleteRange Γ` indicates a consecutive range of variables in `Γ` to
be deleted. -/
structure DCE.DeleteRange (Γ : Ctxt Ty) where
  /-- The first variable to delete. -/
  start : Fin (Γ.length + 1)
  /-- The number of variables to delete -/
  num : Fin (Γ.length + 1 - start.val)
open DCE (DeleteRange)

/-- `DeleteRange.full Γ` is the range of all variables in `Γ`. -/
def DCE.DeleteRange.full (Γ : Ctxt Ty) : DeleteRange Γ where
  start := ⟨0, by omega⟩
  num := ⟨Γ.length, by simp⟩

def DCE.DeleteRange.appendInl {Γ : Ctxt Ty} {ts : List Ty}
    (r : DeleteRange Γ) : DeleteRange (Γ ++ ts) where
  start := ⟨r.start + ts.length, by grind⟩
  num := ⟨r.num, by grind⟩

def DCE.DeleteRange.appendInr {Γ : Ctxt Ty} {ts : List Ty}
    (r : DeleteRange ⟨ts⟩) : DeleteRange (Γ ++ ts) where
  start := ⟨r.start, by grind⟩
  num := ⟨r.num, by grind⟩

/-! ## Ctxt.delete -/

/-- Delete a vector of variables from a ctxt. -/
def Ctxt.delete (Γ : Ctxt Ty) (vs : DeleteRange Γ) : Ctxt Ty :=
  ⟨Γ.toList.zipIdx
    |>.filter (fun ⟨_, i⟩ => ¬(vs.start ≤ i ∧ i < vs.start + vs.num))
    |>.map Prod.fst
  ⟩

@[simp] theorem Ctxt.delete_append_appendInl {Γ : Ctxt Ty} {us : List Ty}
    {r : DeleteRange Γ} :
    (Γ ++ us).delete r.appendInl = (Γ.delete r) ++ us := by
  simp [delete]
  ext i t
  simp
  sorry

section Lemmas
variable {Γ : Ctxt Ty}

@[simp] lemma Ctxt.delete_empty :
    (empty : Ctxt Ty).delete vs = empty := by
  simp [empty, delete]

-- @[simp] lemma Ctxt.getElem_deleteOne_of_lt {i v : Nat} (h : i < v) :
--     (Γ.deleteOne v)[i]? = Γ[i]? := by
--   sorry

-- @[simp] lemma Ctxt.getElem_deleteOne_of_ge {i v : Nat} (h : v ≤ i) :
--     (Γ.deleteOne v)[i]? = Γ[i + 1]? := by
--   sorry

def DCE.DeleteRange.pred (vs : DeleteRange (Γ.snoc t)) (h : vs.start ≠ 0) :
    DeleteRange Γ where
  start := vs.start.pred (fun h' => by simp [h'] at h)
  num := ⟨vs.num, by
    rcases vs with ⟨⟨start, hs⟩, ⟨num, hn⟩⟩
    simp at h hn ⊢
    omega
  ⟩

lemma Ctxt.delete_eq_of_num_eq_zero {vs : DeleteRange Γ} (h : vs.num.val = 0) :
    Γ.delete vs = Γ := by
  simp [delete, h]

lemma Ctxt.delete_pred {vs : DeleteRange (Γ.snoc t)} {h : vs.start ≠ 0} :
    (Ctxt.delete _ vs) = (Γ.delete (vs.pred h)).snoc t := by
  rcases Γ with ⟨Γ⟩
  rcases vs with ⟨ (start : Fin <| Γ.length + 2), (num : Fin <| Γ.length + 2 - start) ⟩
  change start ≠ 0 at h

  simp [delete, DeleteRange.pred, Ctxt.snoc]
  suffices ∀ k,
    let P (k) (x) :=
      !decide (start.val ≤ x.2 + k) || decide (start.val - k + num.val ≤ x.2)
    List.map Prod.fst (List.filter (P k) ((t, 0) :: Γ.zipIdx (k + 1)))
    = t :: List.map Prod.fst (List.filter (P <| k + 1) (Γ.zipIdx k))
  by exact this 0
  induction Γ
  case nil =>
    obtain rfl : start = 1 := match start with | 1 => rfl
    simp
  case cons t' Γ ih =>
    intro k
    simp
    rw [List.filter_cons_of_pos]
    simp
    have : start.val ≠ 0 := sorry
    specialize ih (start.pred h) (num.cast <| by simp; omega) (k + 1)



#check Function.comp

theorem Ctxt.getElem_delete_of_lt {i : Nat} (vs : DeleteRange Γ) (h : i < vs.start) :
    Γ[i]? = (Γ.delete vs)[i]? := by
  rcases Γ with ⟨Γ⟩
  induction hnum : vs.num.val generalizing i Γ -- k
  case zero => rw [delete_eq_of_num_eq_zero hnum]
  case succ ih =>
    cases Γ with
    | nil => exfalso; sorry
    | cons t Γ =>
      cases i
      case zero =>
        simp only [List.length_cons, lt_add_iff_pos_left, add_pos_iff, zero_lt_one, or_true,
          getElem?_pos, List.getElem_cons_zero, List.zipIdx_cons, zero_add]
        -- grind [List.filter_cons_of_pos]
        rw [List.filter_cons_of_pos (by simp; sorry)]
        simp
      case succ i =>
        have ne_zero : vs.start ≠ 0 := by
          apply Fin.val_ne_zero_iff.mp
          omega
        specialize @ih i Γ (vs.pred ne_zero) (by simp [DeleteRange.pred]; omega)
        rw [List.getElem?_cons_succ, ih]
        rw [List.zipIdx_cons, List.filter_cons_of_pos (by grind)]
        simp [DeleteRange.pred]




        sorry
    -- rw [Nat.fold_succ, getElem_deleteOne_of_lt (by omega)]
    -- exact ih

theorem Ctxt.getElem_delete_of_ge {i : Nat} (vs : DeleteRange Γ) (h : vs.start ≤ i) :
    Γ[i + vs.num]? = (Γ.delete vs)[i]? := by
  stop
  rcases Γ
  simp only [getElem?_ofList, delete]
  induction vs.num
  case zero => rfl
  case succ ih =>
    rw [Nat.fold_succ, getElem_deleteOne_of_lt (by omega)]
    exact ih

/-
TODO: I am not at all certain that the index maths here is correct, but I am
cautiously optimistic that the general setup of these lemmas works
-/

theorem Ctxt.getElem_delete (i : Nat) (vs : DeleteRange Γ) :
    (Γ.delete vs)[i]? = Γ[if i < vs.start then i else i - vs.num]? := by
  split_ifs with h
  · rw [Ctxt.getElem_delete_of_lt _ h]
  · obtain ⟨_, rfl⟩ := Nat.exists_eq_add_of_le (by omega : vs.start ≤ i)
    stop
    rw [Ctxt.getElem_delete_of_ge]

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
      simp only [← hv]; clear hv
      split_ifs with h_val
      · rw [Ctxt.getElem_delete_of_lt _ h_val]
      · rw [Ctxt.getElem_delete_of_ge _ (by omega)]
    ⟩

/-- Witness that Γ' is Γ without v -/
def Deleted (Γ: Ctxt Ty) (vs : DeleteRange Γ) (Γ' : Ctxt Ty) : Prop :=
  Γ' = Γ.delete vs

/-- build a `Deleted` for a `(Γ ++ αs) → Γ`-/
def Deleted.deleteAppend (Γ : Ctxt Ty) (αs : List Ty) :
    Deleted (Γ ++ αs) (DeleteRange.full ⟨αs⟩).appendInr Γ := by
  stop
  simp [Deleted, Var.varsOfType, Ctxt.delete]
  induction αs
  · rfl
  case cons ih =>
    simp [HVector.ofFn, HVector.map_cons]
    rw [ih]
    -- congr 1
    -- rfl

  -- sorry -- rfl


/-- append an `ωs` to both the input and output contexts of `Deleted Γ v Γ'` -/
def Deleted.append {Γ : Ctxt Ty} {vs : DeleteRange Γ}
    (DEL : Deleted Γ vs Γ') (ωs : List Ty) :
    Deleted (Γ ++ ωs) vs.appendInl (Γ' ++ ωs) := by
  stop
  simp only [Deleted, Ctxt.delete, Ctxt.Var.val_toSnoc] at DEL ⊢
  subst DEL
  rfl

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
  funext t v;
  simp only [Deleted.toHom]
  cases v using Var.appendCases
  · stop simp
  · stop simp [Hom.delete]

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
    let idx := if v.val < delv.start then v.val else v.val + delv.num
    let v' := ⟨idx, by
      subst DEL idx
      simp at h_val_eq
      rw [Ctxt.getElem_delete]
      split_ifs
      · exact v.prop
      · exfalso; omega
      · rw [show v.val + delv.num - delv.num = v.val by omega]
        exact v.prop
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
        -- rcases v; congr; rw [Nat.sub_add_cancel (by omega)]
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

attribute [local simp] Ctxt.snoc

def ex1_pre_dce : Com Ex ∅ .pure [.nat] :=
  Com.var (cst 1) <|
  Com.var (cst 2) <|
  Com.ret ⟨0, rfl⟩

def ex1_post_dce : Com Ex ∅ .pure [.nat] := (dce' ex1_pre_dce).val

def ex1_post_dce_expected : Com Ex ∅ .pure [.nat] :=
  Com.var (cst 2) <|
  Com.ret ⟨0, rfl⟩

-- TODO: uncomment once sorries are fixed
-- theorem checkDCEasExpected :
--   ex1_post_dce = ex1_post_dce_expected := by native_decide

end Examples
end DCE
