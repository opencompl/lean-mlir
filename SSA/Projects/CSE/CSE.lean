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

/-- Remap the last variable in a context, to get a new context without the last variable -/
def Hom.remapLast {α : Ty} (Γ : Ctxt Ty) (var : Γ.Var α) :
  Ctxt.Hom (Γ.snoc α) Γ := fun ty' var' => by
    cases var' using Ctxt.Var.casesOn
    case toSnoc var' => exact var'
    case last => exact var

@[simp] lemma Valuation.comap_remapList {Γ : Ctxt Ty} (V : Valuation Γ) (v : Γ.Var t) :
    V.comap (.remapLast _ v) = V.snoc (V v) := by
  funext t v; cases v <;> simp [Hom.remapLast]

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
  Lets.denote (Lets.var lets e) V =
    (Ctxt.Valuation.snoc (Lets.denote lets V) (Expr.denoteOp e (Lets.denote lets V))) := by
  simp [Expr.denote_unfold]; rfl

/-! # CSE  -/

variable [TyDenote d.Ty] [DialectDenote d] [Monad d.m]
namespace CSE

/-- State stored by CSE pass. -/
structure State (d : Dialect) [TyDenote d.Ty] [DialectSignature d] [DialectDenote d] [Monad d.m]
    {Γstart Γ : Ctxt d.Ty}
    (lets : Lets d Γstart .pure Γ) where
  /-- map variable to its canonical value -/
  var2var : (v : Γ.Var α) → { v' : Γ.Var α // ∀ (V : Γstart.Valuation),
    (lets.denote V) v = (lets.denote V) v' }
  /-- map an Expr to its canonical variable -/
  expr2cache : (α : d.Ty) → (e : Expr d Γ .pure α) →
    Option ({ v : Γ.Var α // ∀ (V : Γstart.Valuation), (lets.denote V) v =
    e.denoteOp (lets.denote V) })

/-- The empty CSEing state. -/
def State.empty (lets : Lets d Γstart .pure Γ) : State d lets where
  var2var := fun v => ⟨v, by intros V; rfl⟩
  expr2cache := fun α e => .none

variable [LawfulMonad d.m]

def State.snocNewExpr2Cache [DecidableEq d.Ty] [DecidableEq d.Op]
    {Γ : Ctxt d.Ty} {α : d.Ty}
    {lets : Lets d Γstart .pure Γ}
    (s : State d lets) (e : Expr d Γ .pure α) : State d (Lets.var lets e) where
  var2var v := by
    apply Subtype.mk
    intros V
    rfl
  expr2cache β eneedle := do
    let ⟨eneedleΓ, heneedleΓ⟩ ← DCE.Expr.deleteVar? (DEL := Deleted.deleteSnoc Γ α) (eneedle)
    -- If `eneedleΓ` is none, this expression actually uses β in some nontrivial way,
    -- and there's nothing we can really do
    match s.expr2cache _ eneedleΓ with /- find in cache -/
    | .some ⟨v', hv'⟩ => .some ⟨v', by
        simp [heneedleΓ, hv']
      ⟩
    | .none => /- not in cache, check if new expr. -/
      if hβ : α = β then
        if exprEq : (hβ ▸ eneedleΓ) = e then
          some ⟨hβ ▸ Ctxt.Var.last Γ α, by
            subst hβ; simp [heneedleΓ, exprEq]
          ⟩
        else
          none
      else
        none

section RemapVar
def VarRemapVar [DecidableEq d.Ty] [DecidableEq d.Op]
  {Γstart Γ Γ' : Ctxt d.Ty} {α : d.Ty}
  (lets : Lets d Γstart .pure Γ)
  (hom : Ctxt.Hom Γ' Γ)
  (vold : Γ.Var α) (vnew : Γ'.Var α)
  (VNEW: ∀ (Vstart : Ctxt.Valuation Γstart), (lets.denote Vstart) vold =
    ((lets.denote Vstart).comap hom) vnew)
  (w' : Γ'.Var β) :
  { w : Γ.Var β //
    ∀ (Vstart : Ctxt.Valuation Γstart), (lets.denote Vstart) w =
      ((lets.denote Vstart).comap hom) w' } :=
    if TY : β = α
    then
      if H : TY ▸ w' = vnew
      then ⟨TY ▸ vold, by
        subst TY
        subst H
        intros Vstart
        rw [VNEW Vstart]⟩
      else ⟨hom w', by simp [Ctxt.Valuation.comap]⟩
    else ⟨hom w', by simp [Ctxt.Valuation.comap]⟩

def arglistRemapVar [DecidableEq d.Ty] [DecidableEq d.Op]
  {Γstart Γ Γ' : Ctxt d.Ty} {α : d.Ty}
  (lets : Lets d Γstart .pure Γ)
  (hom : Ctxt.Hom Γ' Γ)
  (vold : Γ.Var α) (vnew : Γ'.Var α)
  (VNEW: ∀ (Vstart : Ctxt.Valuation Γstart), (lets.denote Vstart) vold =
    ((lets.denote Vstart).comap hom) vnew)
  {ts : List d.Ty} (as' : HVector (Ctxt.Var Γ') <| ts) :
    { as : HVector (Ctxt.Var Γ) <| ts //
      ∀ (Vstart : Γstart.Valuation), as.map (fun _ v => (lets.denote Vstart) v) =
        as'.map (fun _ v' => ((lets.denote Vstart).comap hom) v') } :=
  match as' with
  | .nil => ⟨.nil, by simp [HVector.map]⟩
  | .cons a' as' =>
    let ⟨a, ha⟩ := VarRemapVar lets hom vold vnew VNEW a'
    let ⟨as, has⟩ := arglistRemapVar lets hom vold vnew VNEW as'
    ⟨.cons a as, by
      intros Vstart
      simp only [HVector.map, HVector.cons.injEq]
      rw [ha Vstart]
      rw [has Vstart]
      constructor
      simp only
      congr
    ⟩

def ExprRemapVar [DecidableEq d.Ty] [DecidableEq d.Op]
  {Γstart Γ Γ' : Ctxt d.Ty} {α : d.Ty}
  (lets : Lets d Γstart .pure Γ)
  (hom : Ctxt.Hom Γ' Γ)
  (vold : Γ.Var α) (vnew : Γ'.Var α)
  (VNEW: ∀ (Vstart : Ctxt.Valuation Γstart), (lets.denote Vstart) vold =
    ((lets.denote Vstart).comap hom) vnew)
  (e' : Expr d Γ' .pure β) :
  { e : Expr d Γ .pure β  // ∀ (Vstart : Ctxt.Valuation Γstart),
    e.denoteOp (lets.denote Vstart) = e'.denoteOp ((lets.denote Vstart).comap hom) } :=
    match e' with
    | ⟨op, ty_eq, eff_le, args, regArgs⟩ =>
      let ⟨args', hargs'⟩ := arglistRemapVar lets hom vold vnew VNEW args
      ⟨.mk op ty_eq eff_le args' regArgs, by
        intros Vstart
        subst ty_eq
        simp [Expr.denoteOp, hargs']
        rfl
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
 {Γ : Ctxt d.Ty} {α : d.Ty}
 {lets : Lets d Γstart .pure Γ}
 (s : State d lets) (enew : Expr d Γ .pure α) (eold : Expr d Γ .pure α) (henew :
    ∀ (V : Γstart.Valuation), enew.denote (lets.denote V) = eold.denote (lets.denote V))
  (vold : Γ.Var α) (hv : ∀ (V : Γstart.Valuation), eold.denoteOp (lets.denote V) =
    lets.denote V vold) :
  State d (Lets.var lets enew) := {
    var2var := fun v => by
      cases v using Ctxt.Var.casesOn
      case toSnoc v => -- old variable, look up 'var2var'
        let ⟨v', hv'⟩ := s.var2var v
        apply (Subtype.mk v'.toSnoc)
        intros V
        simp only [Lets.denote_var_pure, Ctxt.Valuation.snoc_toSnoc]
        rw [hv']

      case last => -- new variable, return the CSE'd variable.
        apply Subtype.mk vold.toSnoc
        simp_all [Expr.denote_unfold]
    expr2cache := fun β eneedle =>
      let homRemap := Ctxt.Hom.remapLast Γ vold
      let lastVar := (Ctxt.Var.last Γ α)
      let ⟨eneedle', heneedle'⟩ := ExprRemapVar lets homRemap vold lastVar (by {
        intros Vstart
        simp (config := { zetaDelta := true }) only [Ctxt.Valuation.comap, Ctxt.Hom.remapLast,
          Ctxt.Var.casesOn_last]
      })  eneedle
      match s.expr2cache β eneedle' with
      | .none => .none
      | .some ⟨e', he'⟩ => .some ⟨e', by
          simp_all [Expr.denote_unfold, homRemap]
        ⟩
}

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
          {ts : List (Ctxt d.Ty × d.Ty)} →
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
  {ts : List (Ctxt d.Ty × d.Ty)}
  (rs : HVector ((fun t : Ctxt d.Ty × d.Ty => Com d t.1 .impure t.2)) <| ts) :
  { rs' : HVector ((fun t : Ctxt d.Ty × d.Ty => Com d t.1 .impure t.2)) <| ts //
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
    e.denote (lets.denote V) } × Option ({ v' : Γ.Var α // ∀ (V : Γstart.Valuation),
      (lets.denote V) v' = e.denoteOp (lets.denote V) }) :=
  match E : e with
  | .mk op ty_eq eff_le args regArgs =>
      let ⟨args', hargs'⟩ := s.cseArgList args
      let regArgs' := s.cseRegionArgList regArgs
      let ⟨regArgs', hregArgs'⟩ := regArgs'
      let e' : Expr d Γ .pure α  := .mk op ty_eq eff_le args' regArgs'
      ⟨⟨e', by {
        intros V
        simp +zetaDelta only [Expr.denote_unfold, Ctxt.Valuation.snoc_map_inj]
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

def State.cseCom {α : d.Ty}
  {lets : Lets d Γstart .pure Γ}
  (s : State d lets)
  (com: Com d Γ .pure α) :
  { com' : Com d Γ .pure α
    // ∀ (V : Ctxt.Valuation Γstart), com.denote (lets.denote V) = com'.denote (lets.denote V) } :=
  match com with
  | .ret v => ⟨.ret (s.var2var v).val, by
      let ⟨v', hv'⟩ := s.var2var v
      intros VΓ
      simp [Com.denote, hv']⟩
  | .var (α := α) e body =>
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
  {α : d.Ty} {Γ : Ctxt d.Ty} (com: Com d Γ .pure α) :
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

def ex1_pre_cse : Com Ex ∅ .pure .nat :=
  Com.var (cst 1) <|
  Com.var (cst 1) <|
  Com.var (add ⟨0, by simp⟩ ⟨1, by simp⟩) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩
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
 { com' : Com Ex ∅ .pure .nat // ∀ V, ex1_pre_cse.denote V = com'.denote V } :=
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
  { com : Com Ex ∅ .pure  .nat // ∀ V, ex1_post_cse.val.denote V = com.denote V } :=
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
