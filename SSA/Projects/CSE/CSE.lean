/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
/-
This file implements common subexpression elimination for our SSA based IR.
-/
import SSA.Core
import SSA.Projects.DCE.DCE

/-! ## Prelims  -/

namespace Ctxt
variable {Ty} [TyDenote Ty]

/-- Remap the last variables in a context, to get a new context without those variables -/
def Hom.remapAppend {αs : List Ty} (Γ : Ctxt Ty) (var : HVector Γ.Var αs) :
  Ctxt.Hom (Γ ++ αs) Γ := fun ty' var' => by
    cases var' using Ctxt.Var.appendCases
    case left var' => exact var'
    case right v => exact var[v]

@[simp] lemma Valuation.comap_remapAppend {Γ : Ctxt Ty} (V : Valuation Γ) (vs : HVector _ ts) :
    V.comap (.remapAppend _ vs) = V ++ (vs.map V) := by
  funext t v; cases v using Var.appendCases <;> simp [Hom.remapAppend]

end Ctxt

/- Decidable Equality for Coms. -/
section DecEqCom
variable {d : Dialect}
variable [DialectSignature d]

/-- can decide equality on argument vectors. -/
def argVector.decEq : DecidableEq (HVector (Ctxt.Var Γ) ts) := inferInstance


/-- denoting a `var` is the same as `snoc`ing the denotation of `e` onto the old valuation `V`. -/
@[simp]
theorem Lets.denote_var_pure [TyDenote d.Ty] [DialectDenote d] [Monad d.m] [LawfulMonad d.m]
  {Γstart Γ : Ctxt d.Ty}
  {lets : Lets d Γstart .pure Γ}
  (e : Expr d Γ .pure α)
  (V : Ctxt.Valuation Γstart) :
  (lets.var e).denote V
  = (lets.denotePure V ++ e.pdenoteOp (lets.denote V)) := by
  simp [Expr.denote_unfold]; rfl

/-! # CSE  -/

variable [TyDenote d.Ty] [DialectDenote d] [Monad d.m]
namespace CSE
open Ctxt (Var)

/-- State stored by CSE pass. -/
structure State (d : Dialect) [TyDenote d.Ty] [DialectSignature d] [DialectDenote d] [Monad d.m]
    {Γstart Γ : Ctxt d.Ty}
    (lets : Lets d Γstart .pure Γ) where
  /-- map variable to its canonical value -/
  var2var : (v : Γ.Var α) → { v' : Γ.Var α //
    ∀ (V : Γstart.Valuation), (lets.denote V) v = (lets.denote V) v' }
  /-- map an Expr to its canonical variable -/
  expr2cache : (α : List d.Ty) → (e : Expr d Γ .pure α) →
    Option ({ vs : HVector Γ.Var α // ∀ (V : Γstart.Valuation),
                vs.map (lets.denote V) = e.denoteOp (lets.denote V) })

/-- The empty CSEing state. -/
def State.empty (lets : Lets d Γstart .pure Γ) : State d lets where
  var2var := fun v => ⟨v, by intros V; rfl⟩
  expr2cache := fun α e => .none

variable {Γstart Γ : Ctxt _} {lets : Lets d Γstart .pure Γ} in
/-- Generalization of `var2var` to a vector of variables. -/
def State.vars2vars (self : State d lets) (vs : HVector Γ.Var ts) :
    { vs' : HVector Γ.Var ts //
        ∀ (V : Γstart.Valuation), vs.map (lets.denote V) = vs'.map (lets.denote V) } :=
  let vs' := vs.map fun _ v => self.var2var v
  ⟨vs', by
    intro V
    ext i
    simp only [List.get_eq_getElem, HVector.get_map, vs']
    exact self.var2var (vs.get i) |>.prop _
  ⟩

variable [LawfulMonad d.m]

def State.snocNewExpr2Cache [DecidableEq d.Ty] [DecidableEq d.Op]
    {Γ : Ctxt d.Ty} {α}
    {lets : Lets d Γstart .pure Γ}
    (s : State d lets) (e : Expr d Γ .pure α) : State d (Lets.var lets e) where
  var2var v := by
    apply Subtype.mk
    intros V
    rfl
  expr2cache β eneedle := do
    let ⟨eneedleΓ, heneedleΓ⟩ ← DCE.Expr.deleteVar? (DEL := Deleted.deleteAppend Γ α) (eneedle)
    -- ^^ If `eneedleΓ` is none, this expression actually uses β in some
    --    nontrivial way, and there's nothing we can really do
    match s.expr2cache _ eneedleΓ with /- find in cache -/
    | .some ⟨v', hv'⟩ => .some ⟨v'.map fun _ v => v.appendInl, by
        simp [heneedleΓ, hv', HVector.map_map]
      ⟩
    | .none => /- not in cache, check if new expr. -/
      if hβ : α = β then
        if exprEq : (hβ ▸ eneedleΓ) = e then
          some ⟨hβ ▸ (Var.allVarsIn α).map (fun _ v => v.appendInr), by
            subst hβ
            intro V
            ext i
            simpa [heneedleΓ, exprEq, Var.allVarsIn, HVector.map_map]
              using HVector.getElem_ofFin_eq_get ..
          ⟩
        else
          none
      else
        none

section RemapVar
variable [DecidableEq d.Ty] [DecidableEq d.Op]
variable {Γstart Γ Γ' : Ctxt d.Ty} {α}
  (lets : Lets d Γstart .pure Γ)
  (hom : Ctxt.Hom Γ' Γ)
  (vold : HVector Γ.Var α)
  (vnew : HVector Γ'.Var α)
  (VNEW: ∀ (Vstart : Ctxt.Valuation Γstart), vold.map (lets.denote Vstart) =
      vnew.map ((lets.denote Vstart).comap hom))

def VarRemapVar
  (w': HVector Γ'.Var β) :
  {w : HVector Γ.Var β //
    ∀ (Vstart : Ctxt.Valuation Γstart),
      w.map (lets.denote Vstart)
      = w'.map ((lets.denote Vstart).comap hom)  } :=
    if TY : β = α then
      if H : TY ▸ w' = vnew then
        ⟨TY ▸ vold, by
          subst TY
          subst H
          intros Vstart
          rw [VNEW Vstart]⟩
      else ⟨w'.map hom, by intro; ext; simp⟩
    else ⟨w'.map hom, by intro; ext; simp⟩

def ExprRemapVar [DecidableEq d.Ty] [DecidableEq d.Op]
    {Γstart Γ Γ' : Ctxt d.Ty} {α}
    (lets : Lets d Γstart .pure Γ)
    (hom : Ctxt.Hom Γ' Γ)
    (vold : HVector Γ.Var α)
    (vnew : HVector Γ'.Var α)
    (VNEW: ∀ (Vstart : Ctxt.Valuation Γstart), vold.map (lets.denote Vstart) =
      vnew.map ((lets.denote Vstart).comap hom))
    (e' : Expr d Γ' .pure β) :
    {e : Expr d Γ .pure β // ∀ (V : Ctxt.Valuation Γstart),
          e.denoteOp (lets.denote V)
          = e'.denoteOp ((lets.denote V).comap hom) } :=
  match e' with
  | ⟨op, ty_eq, eff_le, args, regArgs⟩ =>
    let ⟨args', hargs'⟩ := VarRemapVar lets hom vold vnew VNEW args
    ⟨.mk op ty_eq eff_le args' regArgs, by
      intros Vstart
      subst ty_eq
      simp [Expr.denoteOp, hargs']
    ⟩
    -- TODO: extend to Com.
end RemapVar


/-
e: Expr d Γ .pure α
body: Com d (Ctxt.snoc Γ α) α✝
e': Expr d Γ .pure α
he': Expr.denote e' = Expr.denote e
v'?: Option { v' // ∀ (V : Ctxt.Valuation Γstart), Lets.denote lets V v' =
  Expr.denote e (Lets.denote lets V) }
s': State d.Op (Lets.var lets e') := snocNewExpr2Cache s e'
-/

def State.snocOldExpr2Cache [DecidableEq d.Ty] [DecidableEq d.Op]
    {Γ : Ctxt d.Ty} {α}
    {lets : Lets d Γstart .pure Γ}
    (s : State d lets) (enew : Expr d Γ .pure α) (eold : Expr d Γ .pure α) (henew :
        ∀ (V : Γstart.Valuation), enew.denote (lets.denote V) = eold.denote (lets.denote V))
    (vold : HVector Γ.Var α)
    (hv : ∀ (V : Γstart.Valuation), eold.denoteOp (lets.denote V) =
      vold.map (lets.denote V)) :
    State d (Lets.var lets enew) where
  var2var := fun v => by
    cases v using Ctxt.Var.appendCases
    case left v => -- old variable, look up 'var2var'
      let ⟨v', hv'⟩ := s.var2var v
      apply Subtype.mk v'.appendInl
      simp [Lets.denote_var_pure, hv']

    case right v => -- new variable, return the CSE'd variable.
      apply Subtype.mk <| vold[v].appendInl
      simp_all [Expr.denote_unfold]
  expr2cache := fun β eneedle =>
    let homRemap := Ctxt.Hom.remapAppend Γ vold
    let lastVar := (Var.allVarsIn α).map (fun _ v => v.appendInr)
    let ⟨eneedle', heneedle'⟩ := ExprRemapVar lets homRemap vold lastVar (by
        intros Vstart
        ext i
        simp +zetaDelta only [List.get_eq_getElem, HVector.get_map,
          Ctxt.Valuation.comap_remapAppend, Var.allVarsIn, HVector.map_map,
          Ctxt.Valuation.append_appendInr, HVector.getElem_map, HVector.get_ofFn]
        rw [← HVector.getElem_ofFin_eq_get]
        rfl
      )  eneedle
    match s.expr2cache β eneedle' with
    | .none => .none
    | .some ⟨e', he'⟩ => .some ⟨e'.map fun _ v => v.appendInl, by
        intro V
        simp_all only [Expr.denote_unfold, Ctxt.Valuation.comap_remapAppend, Lets.denote_var_pure,
          Lets.denotePure, Expr.pdenoteOp, HVector.map_map, Ctxt.Valuation.append_appendInl,
          homRemap]
        congr 1
        exact (henew V).symm
      ⟩

/-- Replace the variables in `as` with new variables that have the same valuation -/
def State.cseArgList
 [TyDenote d.Ty] [DialectSignature d] [DialectDenote d]
  {Γstart Γ : Ctxt d.Ty} {lets : Lets d Γstart .pure Γ} (s : State d lets)
  {ts : List d.Ty}
  (as : HVector (Ctxt.Var Γ) <| ts) :
  { as' : HVector (Ctxt.Var Γ) <| ts // ∀ (V : Γstart.Valuation),
    as.map (lets.denote V).eval = as'.map (lets.denote V).eval  } :=
  match as with
  | .nil => ⟨.nil, by
      simp [HVector.map]
    ⟩
  | .cons a as =>
    let ⟨a', ha'⟩ :=  s.var2var a
    let ⟨as', has'⟩ := s.cseArgList as
    ⟨.cons a' as', by
          intros V
          simp only [HVector.map, HVector.cons.injEq]
          constructor
          apply ha'
          apply has'
    ⟩

/-- Default instance for `partial def` to compile. -/
instance : Inhabited (
          {lets : Lets d Γstart .pure Γ} →
          State d lets →
          {ts : RegionSignature d.Ty} →
          (rs : HVector (fun t => Com d t.1 .impure t.2) ts) →
          { rs' : HVector (fun t => Com d t.1 .impure t.2) ts // HVector.denote rs =
            HVector.denote rs' }) where
  default := fun _s _ts rs => ⟨rs, rfl⟩

/-- Default instance for `partial def` to compile. -/
instance : Inhabited (
  {lets : Lets d Γstart .pure Γ} →
  State d lets →
  (com: Com d Γ .pure α) →
  { com' : Com d Γ .pure α // ∀ (V: Ctxt.Valuation Γ), com.denote V = com'.denote V }) where
  default := fun _s com => ⟨com, by intros V; rfl⟩


/- CSE for HVector / Com / Expr. -/
mutual
variable [DecidableEq d.Ty] [DecidableEq d.Op]

/-- Replace the regions in `rs` with new regions that have the same valuation -/
def State.cseRegionArgList
  {Γstart Γ : Ctxt d.Ty}
  {lets : Lets d Γstart .pure Γ}
  (_ : State d lets)
  {ts : RegionSignature d.Ty}
  (rs : HVector ((fun t => Com d t.1 .impure t.2)) <| ts) :
  {rs' : HVector ((fun t => Com d t.1 .impure t.2)) <| ts //
    HVector.denote rs = HVector.denote rs' } :=
  let _ := HVector.map (fun _Γα com => Com.denote com) rs
  match ts, rs with
  | _, .nil => ⟨.nil, by
      simp
    ⟩
  | ⟨Γ, t⟩::ts, .cons region rs =>
    -- 2023: Need to create a fresh state to CSE the region.
    -- Apr 2024: Bail out, to not try to CSE on regions since we now impose that
    -- all regions are impure.
    --   Improve this to be able to perform the rewrite when the region can be pure.
    ⟨.cons region rs, by rfl⟩
    /-
    let cseState := State.empty Lets.nil
    let ⟨(region' : Com d Γ .impure t), hr'⟩ :=  cseState.cseCom region
    let ⟨rs', hrs'⟩ := s.cseRegionArgList rs
    ⟨.cons region' rs', by
          simp [HVector.denote]
          constructor
          funext V
          apply hr'
          apply hrs'
    ⟩
    -/
/-- lookup an expression in the state and return a corresponding CSE'd variable for it,
  along with the CSE'd expression that was looked up in the map for the variable.  -/
def State.cseExpr
 {Γstart Γ : Ctxt d.Ty}
 {lets : Lets d Γstart .pure Γ}
 (s : State d lets)
 (e : Expr d Γ .pure α) :
 {e' : Expr d Γ .pure α //
  ∀ (V : Γstart.Valuation), e'.denote (lets.denote V) =
    e.denote (lets.denote V) }
    × Option ({ v' : HVector Γ.Var α // ∀ (V : Γstart.Valuation),
      v'.map (lets.denote V) = e.denoteOp (lets.denote V) }) :=
  match E : e with
  | .mk op ty_eq eff_le args regArgs =>
      let ⟨args', hargs'⟩ := s.cseArgList args
      let regArgs' := s.cseRegionArgList regArgs
      let ⟨regArgs', hregArgs'⟩ := regArgs'
      let e' : Expr d Γ .pure α  := .mk op ty_eq eff_le args' regArgs'
      ⟨⟨e', by {
        intros V
        simp +zetaDelta only [Expr.denote_unfold]
        congr 1
        apply Expr.denoteOp_eq_denoteOp_of
        · simpa [Ctxt.Valuation.eval] using (hargs' _).symm
        · simpa using hregArgs'.symm
        · rfl
      }⟩,
        match s.expr2cache _ e with
        | .some ⟨v', hv'⟩ =>
          .some ⟨v', by
            intros V
            simp [hv', E]
          ⟩
        | .none => .none
      ⟩

def State.cseCom {α}
  {lets : Lets d Γstart .pure Γ}
  (s : State d lets)
  (com: Com d Γ .pure α) :
  { com' : Com d Γ .pure α
    // ∀ (V : Ctxt.Valuation Γstart), com.denote (lets.denote V) = com'.denote (lets.denote V) } :=
  match com with
  | .rets vs =>
      let ⟨vs', hvs'⟩ := s.vars2vars vs
      ⟨.rets vs', by
        intros VΓ
        simp [Com.denote, hvs']⟩
  | .var e body =>
      let ⟨⟨e', he'⟩, v'?⟩ := s.cseExpr e
      match v'? with
      | .none => /- no variable to replace. -/
        let s' := s.snocNewExpr2Cache (e := e')
        /- add this expression into the cache for the latest variable. -/
        let ⟨body', hbody'⟩ := s'.cseCom body
        ⟨.var e' body',  by
            intros VΓ
            simp only [Com.denote]
            simp only [Lets.denote_var, Id.bind_eq'] at hbody' ⊢
            rw [← hbody']
            rw [he']⟩
      | .some ⟨v', hv'⟩ =>
        let s' := s.snocOldExpr2Cache (enew := e') (eold := e) (henew := by { intros V; rw [he'] })
          (vold := v') (hv := by {intros V; rw [hv'] })
          -- add this expression into the cache for the latest variable.
        let ⟨body', hbody'⟩ := s'.cseCom body
        -- TODO: delete the ``e` to get a `body'` in context `Γ`, not `Γ.snoc α`.
        ⟨.var e body' -- we still keep the `e` for now. In the next version, we will delete the `e`
        , by
            intros V
            simp only [Com.denote]
            simp only [Lets.denote_var, Id.bind_eq'] at hbody' ⊢
            specialize (hbody' V)
            specialize (he' V)
            rw [he'] at hbody'
            apply hbody'
        ⟩

end -- mutual.

/-- common subexpression elimination entry point. -/
def cse' [DecidableEq d.Ty] [DecidableEq d.Op]
  {α} {Γ : Ctxt d.Ty} (com: Com d Γ .pure α) :
  { com' : Com d Γ .pure α // ∀ (V: Ctxt.Valuation Γ), com.denote V = com'.denote V } :=
    let ⟨com', hcom'⟩ := State.cseCom (State.empty Lets.nil) com
    ⟨com', by {
      intros V
      specialize (hcom' V)
      simp only [Lets.denote] at hcom'
      assumption
    }⟩

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
  deriving DecidableEq, Repr

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
    | .add, .cons (a : Nat) (.cons b .nil), _ => a + b ::ₕ .nil
    | .beq, .cons (a : Nat) (.cons b .nil), _ => (a == b) ::ₕ .nil

def cst {Γ : Ctxt _} (n : ℕ) : Expr Ex Γ .pure [.nat]  :=
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

def ex1_pre_cse : Com Ex ∅ .pure [.nat] :=
  Com.var (cst 1) <|
  Com.var (cst 1) <|
  Com.var (add ⟨0, rfl⟩ ⟨1, rfl⟩) <|
  Com.ret ⟨0, rfl⟩
/--
info: {
  ^entry():
    %0 = CSE.Examples.ExOp.cst 1 : () → (CSE.Examples.ExTy.nat)
    %1 = CSE.Examples.ExOp.cst 1 : () → (CSE.Examples.ExTy.nat)
    %2 = CSE.Examples.ExOp.add(%1, %0) : (CSE.Examples.ExTy.nat, CSE.Examples.ExTy.nat) → (CSE.Examples.ExTy.nat)
    return %2 : (CSE.Examples.ExTy.nat) → ()
}
-/
#guard_msgs in #eval ex1_pre_cse

def ex1_post_cse :
 { com' : Com Ex ∅ .pure [.nat] // ∀ V, ex1_pre_cse.denote V = com'.denote V } :=
   cse' ex1_pre_cse
/--
info: {
  ^entry():
    %0 = CSE.Examples.ExOp.cst 1 : () → (CSE.Examples.ExTy.nat)
    %1 = CSE.Examples.ExOp.cst 1 : () → (CSE.Examples.ExTy.nat)
    %2 = CSE.Examples.ExOp.add(%0, %0) : (CSE.Examples.ExTy.nat, CSE.Examples.ExTy.nat) → (CSE.Examples.ExTy.nat)
    return %2 : (CSE.Examples.ExTy.nat) → ()
}
-/
#guard_msgs in #eval ex1_post_cse

def ex1_post_cse_post_dce :
  { com : Com Ex ∅ .pure [.nat] // ∀ V, ex1_post_cse.val.denote V = com.denote V } :=
    (DCE.dce' ex1_post_cse.val)
/--
info: {
  ^entry():
    %0 = CSE.Examples.ExOp.cst 1 : () → (CSE.Examples.ExTy.nat)
    %1 = CSE.Examples.ExOp.add(%0, %0) : (CSE.Examples.ExTy.nat, CSE.Examples.ExTy.nat) → (CSE.Examples.ExTy.nat)
    return %1 : (CSE.Examples.ExTy.nat) → ()
}
-/
#guard_msgs in #eval ex1_post_cse_post_dce

end Examples

end CSE

end DecEqCom
