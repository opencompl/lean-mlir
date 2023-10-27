import SSA.Core.Framework
import SSA.Projects.DCE.DCE

/-
This file implements common subexpression elimination for our SSA based IR.
-/
import Mathlib.Data.HashMap

/- Decidable Equality for IComs. -/
section DecEqICom
variable [DecidableEq Ty]
variable [OP_DECEQ : DecidableEq Op]
variable [OpSignature Op Ty]

/-- can decide equality on argument vectors. -/
def argVector.decEq : DecidableEq (HVector (Ctxt.Var Γ) ts) :=
  fun as bs =>
    match as, bs with
    | .nil, .nil => .isTrue rfl
    | .cons (a := ty) a as', .cons b bs' =>
      have VAR_DECEQ : DecidableEq (Ctxt.Var Γ ty) := inferInstance
      match VAR_DECEQ a b with
      | .isTrue heq =>
        match argVector.decEq as' bs' with
        | .isFalse hneq => .isFalse (fun CONTRA => by obtain ⟨ha, has⟩ := CONTRA; contradiction)
        | .isTrue heq' => .isTrue (by simp[heq', heq])
      | .isFalse hneq => .isFalse (fun CONTRA => by obtain ⟨ha, has⟩ := CONTRA; contradiction)

mutual
def regionVector.decEq (ts : List (Ctxt Ty × Ty))
  (as bs : (HVector ((fun t : Ctxt Ty × Ty => ICom Op t.1 t.2)) <| ts)) :
  Decidable (as = bs) :=
    match as, bs with
    | .nil, .nil => .isTrue rfl
    | .cons (a := α) a as', .cons b bs' =>
      match ICom.decEq a b with
      | .isTrue HD_EQ =>
        match regionVector.decEq _ as' bs' with
        | .isTrue TL_EQ => .isTrue (by subst HD_EQ; subst TL_EQ; rfl; done)
        | .isFalse neq => .isFalse (fun CONTRA => by rcases CONTRA; . contradiction)
      | .isFalse neq => .isFalse (fun CONTRA => by rcases CONTRA; . contradiction)

def IExpr.decEq (e e' : IExpr Op Γ α) : Decidable (e = e') :=
  match e, e' with
  | .mk op ty_eq args regArgs, .mk op' ty_eq' args' regArgs' =>
    if OP : op = op'
    then
      match argVector.decEq args (OP ▸ args') with
      | .isTrue ARGEQ =>
        match regionVector.decEq _ regArgs (OP ▸ regArgs') with
        | .isTrue REGEQ =>
            .isTrue (by subst ty_eq; subst OP; subst ARGEQ; subst REGEQ; rfl; done)
        | .isFalse neq =>
          .isFalse (fun CONTRA => by rcases CONTRA; . contradiction)
      | .isFalse neq =>
        .isFalse (fun CONTRA => by rcases CONTRA; . contradiction)
    else .isFalse (fun CONTRA => by rcases CONTRA; . contradiction)

def ICom.decEq (c c' : ICom Op Γ α) : Decidable (c = c') :=
  match c, c' with
  | .ret v, .ret v' =>
    have VAR_DECEQ : DecidableEq (Ctxt.Var Γ α) := inferInstance
    match VAR_DECEQ v v' with
    | .isTrue heq => .isTrue (by simp[heq])
    | .isFalse f => .isFalse (fun CONTRA => by rcases CONTRA; . contradiction)
  | .lete (α := α) e body, .lete (α := β) e' body' =>
    match decEq α β with
    | .isTrue TY_EQ =>
      match IExpr.decEq e (TY_EQ ▸ e') with
      | .isFalse neq => .isFalse (fun CONTRA => by rcases CONTRA; . contradiction)
      | .isTrue EXPR_EQ =>
        match ICom.decEq body (TY_EQ ▸ body') with
        | .isFalse neq =>  .isFalse (fun CONTRA => by rcases CONTRA; . contradiction)
        | .isTrue BODY_EQ =>
          .isTrue (by subst TY_EQ; subst EXPR_EQ; subst BODY_EQ; rfl)
    | .isFalse f => .isFalse (fun CONTRA => by rcases CONTRA; . contradiction)
  | .ret .., .lete .. => .isFalse ICom.noConfusion
  | .lete .., .ret .. => .isFalse ICom.noConfusion
end
termination_by
ICom.decEq c c' =>  sizeOf c
IExpr.decEq e e' => sizeOf e
regionVector.decEq as bs => sizeOf as

end DecEqICom

namespace CSE

/-- State stored by CSE pass. -/
structure State (Op : Type) [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty] (lets : Lets Op Γstart Γ) where
  /-- map variable to its canonical value -/
  var2var : (v : Γ.Var α) → { v' : Γ.Var α // ∀ (V : Γ.Valuation), V v = V v' }
  /-- map an IExpr to its canonical variable -/
  expr2cache : (α : Ty) → (e : IExpr Op Γ α) → Option ({ v : Γ.Var α // ∀ (V : Γstart.Valuation), (lets.denote V) v = e.denote (lets.denote V) })

/-- The empty CSEing state. -/
def State.empty [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty] (lets : Lets Op Γstart Γ) : State Op lets where
  var2var := fun v => ⟨v, by intros V; rfl⟩
  expr2cache := fun α e => .none

def State.snocExpr2Cache
 [Goedel Ty] [DecidableEq Ty] [DecidableEq Op] [OpSignature Op Ty] [OpDenote Op Ty]
 {Γ : Ctxt Ty} {α : Ty}
 {lets : Lets Op Γstart Γ}
 (s : State Op lets) (e : IExpr Op Γ α) : State Op (Lets.lete lets e) := {
  var2var := fun v => by /- TODO: refactor to use term mode. -/
    refine Ctxt.Var.casesOn v ?_ ?_
    . intros t t' Δ v
      constructor
      intros V
      rfl
    . intros Δ t
      constructor
      intros V
      rfl
  expr2cache := fun β eneedle =>
    /-
    Since `eneedle` lives in `(Γ.snoc β)`, we need to try to corce it into `Γ`. To do this,
    we use the tools built in DCE to try to delete the variable in `eneedle`.
    -/
    let eneedleΓ? := DCE.IExpr.deleteVar? (DEL := Deleted.deleteSnoc Γ α) (eneedle)
    match eneedleΓ? with
    | .none => .none -- this expression actually uses β in some nontrivial way, we're fucked,
    | .some ⟨eneedleΓ, heneedleΓ⟩ =>
        match s.expr2cache _ eneedleΓ with /- find in cache -/
        | .some ⟨v', hv'⟩ =>
          .some ⟨v', by {
            intros V
            rw[heneedleΓ]
            simp[Lets.denote]
            rw[hv' V]
            congr
            done
          }⟩
        | .none => /- not in cache, check if new expr. -/
          match decEq α β with
          | .isFalse _neq => .none
          | .isTrue hβ =>
            match IExpr.decEq (hβ ▸  eneedleΓ) e with
            | .isTrue exprEq => /- same expression, return the variable. -/
                .some ⟨hβ ▸ Ctxt.Var.last Γ α, by {
                  intros V; subst hβ; simp at exprEq; subst exprEq; simp[cast_eq];
                  rw[heneedleΓ]; congr; done}⟩
            | .isFalse _neq => .none -- s.expr2cache β eneedleΓ /- different expression, query cache. -/
 }

/-
/-- assign an expression to a snoc'd variable with a given expression into the CSE map -/
def State.addExpr2Cache
 [Goedel Ty] [DecidableEq Ty] [DecidableEq Op] [OpSignature Op Ty] [OpDenote Op Ty]
 {Γstart Γ : Ctxt Ty} {α : Ty}
 {lets : Lets Op Γstart Γ}
 (s : State Op lets) (v : Γ.Var α) (e : { e : IExpr Op Γ α // ∀ (V : Γstart.Valuation), e.denote (lets.denote V)  = (lets.denote V) v }) : State Op lets := {
  s with
  expr2cache := fun β eneedle =>
    if hβ : α = β
    then
      match he : IExpr.decEq (hβ ▸  eneedle) e.val with
      | .isTrue exprEq => /- same expression, return the variable. -/
          .some ⟨hβ ▸ v, by subst hβ; simp at exprEq; subst exprEq; simp at he; simp[e.property]⟩
      | .isFalse _neq => s.expr2cache β eneedle /- different expression, query cache. -/
    else s.expr2cache β eneedle
 }
-/

@[simp]
theorem Ctxt.Valuation.pullback_id [Goedel Ty] {Γ : Ctxt Ty} (V : Γ.Valuation) :
  V.hom Ctxt.Hom.id = V := by
    funext _t _v
    simp[Ctxt.Valuation.hom]

/-- return value of the CSE pass. -/
structure CSERet [OpSignature Op Ty] [Goedel Ty] [OpDenote Op Ty] (lets : Lets Op Γstart Γ) (com: ICom Op Γ α) where
  Δ : Ctxt Ty
  hom : Ctxt.Hom Δ Γ
  com' : ICom Op Δ α
  hcom' : ∀ (V: Ctxt.Valuation Γstart), com.denote (lets.denote V) = com'.denote ((lets.denote V).hom hom)

/-- Replace the variables in `as` with new variables that have the same valuation -/
def State.cseArgList
 [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty]
  {Γstart Γ : Ctxt Ty} {lets : Lets Op Γstart Γ} (s : State Op lets)
  {ts : List Ty}
  (as : HVector (Ctxt.Var Γ) <| ts) :
  { as' : HVector (Ctxt.Var Γ) <| ts // ∀ (V : Γ.Valuation), as.map V.eval = as'.map V.eval  } :=
  match as with
  | .nil => ⟨.nil, by
      simp[HVector.map]
    ⟩
  | .cons a as =>
    let ⟨a', ha'⟩ :=  s.var2var a
    let ⟨as', has'⟩ := s.cseArgList as
    ⟨.cons a' as', by
          intros V
          simp[HVector.map]
          constructor
          apply ha'
          apply has'
    ⟩

/-- Default instance for `partial def` to compile. -/
instance [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty] : Inhabited (
          {lets : Lets Op Γstart Γ} →
          State Op lets →
          {ts : List (Ctxt Ty × Ty)} →
          (rs : HVector (fun t => ICom Op t.1 t.2) ts) →
          { rs' : HVector (fun t => ICom Op t.1 t.2) ts // HVector.denote rs = HVector.denote rs' }) where
  default := fun _s _ts rs => ⟨rs, rfl⟩

/-- Default instance for `partial def` to compile. -/
instance [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty] : Inhabited (
  {lets : Lets Op Γstart Γ} →
  State Op lets →
  (com: ICom Op Γ α) →
  { com' : ICom Op Γ α // ∀ (V: Ctxt.Valuation Γ), com.denote V = com'.denote V }) where
  default := fun _s com => ⟨com, by intros V; rfl⟩


/-- Default instance for `partial def` to compile. -/
instance [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty] : Inhabited (
  {lets : Lets Op Γstart Γ} →
  State Op lets →
  (com: ICom Op Γ α) →  CSERet lets com) where
  default := fun _s com => CSERet.mk Γ Ctxt.Hom.id com (by intros V; rfl)
instance [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty] : Inhabited (
  {lets : Lets Op Γstart Γ} →
  State Op lets →
 (e : IExpr Op Γ α) → {e' : IExpr Op Γ α // e'.denote = e.denote } × Option ({ v' : Γ.Var α // ∀ (V : Γ.Valuation), V v' = e.denote V })) where
 default := fun _s e => (⟨e, rfl⟩, .none)


/- denoting a `lete` is the same as `snoc`ing the denotation of `e` onto the old valuation `V`. -/
@[simp]
theorem Lets.denote_lete [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty]
  {Γstart Γ : Ctxt Ty}
  {lets : Lets Op Γstart Γ}
  (e : IExpr Op Γ α)
  (V : Ctxt.Valuation Γstart) :
  Lets.denote (Lets.lete lets e) V = (Ctxt.Valuation.snoc (Lets.denote lets V) (IExpr.denote e (Lets.denote lets V))) := by
  simp[Lets.denote, eq_rec_constant]
  funext t v
  cases v using Ctxt.Var.casesOn <;> simp
  done



-- given an variable `v` that equals `e` in `(lets VΓstart)`, replace a variable `v'` in the context
-- given by `(e (lets VΓstart))`, which uses `v` instead of the variable is the new one added by `e`,
-- and uses the non-shadowing variable from the old context `(lets VΓstart)` sotherwise.
def varSubstVar [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty]
  {Γstart Γ : Ctxt Ty}
  {lets : Lets Op Γstart Γ}
  (s : State Op lets)
  (replacee : IExpr Op Γ α)
  (replacev : Γ.Var α)
  (REPLACEV : ∀ (V : Γstart.Valuation), replacee.denote (lets.denote V) = (lets.denote V) replacev)
  (findv : (Γ.snoc α).Var β) :
  { findv' : Γ.Var β //
    ∀ (V : Γstart.Valuation), ((Lets.lete lets replacee).denote V) findv = (lets.denote V) findv' } := by
    cases findv using Ctxt.Var.casesOn <;> try simp
    case toSnoc findv_unsnoc =>
      apply (Subtype.mk findv_unsnoc)
      intros V
      rfl
    case last =>
      apply (Subtype.mk replacev)
      exact REPLACEV

/-- Try to delete the variable from the argument list.
  Succeeds if variable does not occur in the argument list.
  Fails otherwise. -/
def arglistSubstVar [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty]
  {Γstart Γ : Ctxt Ty}
  {lets : Lets Op Γstart Γ}
  (s : State Op lets)
  (replacee : IExpr Op Γ α)
  (replacev : Γ.Var α)
  (REPLACEV : ∀ (V : Γstart.Valuation), replacee.denote (lets.denote V) = (lets.denote V) replacev)
  (findv : (Γ.snoc α).Var α)
  (as : HVector (Ctxt.Var (Γ.snoc α)) <| ts) :
    { as' : HVector (Ctxt.Var Γ) <| ts // ∀ (Vstart : Γstart.Valuation),
      as.map (fun (t : Ty) (a : (Γ.snoc α).Var t) => (Lets.lete lets replacee).denote Vstart a) =
      as'.map (fun (t : Ty) (a : Γ.Var t) => lets.denote Vstart a)} :=
  match as with
  | .nil => ⟨.nil, by simp[HVector.map]; done⟩
  | .cons (a := α) a as =>
    let ⟨a', ha'⟩ := varSubstVar s replacee replacev REPLACEV a
    let ⟨as', has'⟩ := arglistSubstVar s replacee replacev REPLACEV findv as
    ⟨.cons a' as', by
      intros V
      simp at ha' has' ⊢
      simp[HVector.map]
      constructor
      . apply ha'
      . apply has'
      done
    ⟩

mutual

def IExpr.substVar [DecidableEq Ty] [DecidableEq Op] [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty]
  {Γstart Γ : Ctxt Ty}
  {lets : Lets Op Γstart Γ}
  (s : State Op lets)
  (replacee : IExpr Op Γ α)
  (replacev : Γ.Var α)
  (REPLACEV : ∀ (V : Γstart.Valuation), replacee.denote (lets.denote V) = (lets.denote V) replacev)
  (findv : (Γ.snoc α).Var α)
  (body : IExpr Op (Γ.snoc α) β) :
  { body' : IExpr Op Γ β //
    ∀ (V : Γstart.Valuation), body.denote ((Lets.lete lets replacee).denote V)  = body'.denote (lets.denote V) } :=
  match body with
  | .mk op ty_eq args regArgs =>
    let ⟨args', hargs'⟩ := arglistSubstVar s replacee replacev REPLACEV findv args
    ⟨.mk op ty_eq args' regArgs, by
      subst ty_eq
      simp[IExpr.denote, hargs']
      intros V
      congr 1
      simp[Lets.denote_lete] at hargs'
      rw[hargs']
      done
    ⟩

/- replace the snoc'd variable of an ICom with a different variable of the same denotation-/
def ICom.substVar [DecidableEq Ty] [DecidableEq Op] [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty]
  {Γstart Γ : Ctxt Ty}
  {lets : Lets Op Γstart Γ}
  (s : State Op lets)
  (replacee : IExpr Op Γ α)
  (replacev : Γ.Var α)
  (REPLACEV : ∀ (V : Γstart.Valuation), replacee.denote (lets.denote V) = (lets.denote V) replacev)
  (findv : (Γ.snoc α).Var α)
  (body : ICom Op (Γ.snoc α) β) (v : Γ.Var α) :
  { body' : ICom Op Γ β //
    ∀ (V : Γstart.Valuation), body.denote ((Lets.lete lets replacee).denote V)  = body'.denote (lets.denote V) } :=
  match body with
  | .ret (t := γ) v =>
      let ⟨v', hv'⟩ :=  varSubstVar s replacee replacev REPLACEV v
      ⟨.ret v', by
        intros V
        apply hv'
        done⟩
  | .lete e body' =>
    let ⟨e', he'⟩ := IExpr.substVar s replacee replacev REPLACEV findv e
    -- fucked x(
    -- need to create new state?
    let lets' := Lets.lete lets e
    let ⟨body'', hbody''⟩ := ICom.substVar s replacee replacev REPLACEV findv body'
    _

end


/- CSE for HVector / ICom / IExpr. -/
mutual
variable [DecidableEq Ty] [DecidableEq Op] [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty]

/-- Replace the regions in `rs` with new regions that have the same valuation -/
unsafe def State.cseRegionArgList
  {Γstart Γ : Ctxt Ty}
  {lets : Lets Op Γstart Γ}
  (s : State Op lets)
  {ts : List (Ctxt Ty × Ty)}
  (rs : HVector ((fun t : Ctxt Ty × Ty => ICom Op t.1 t.2)) <| ts) :
  { rs' : HVector ((fun t : Ctxt Ty × Ty => ICom Op t.1 t.2)) <| ts //
    HVector.denote rs = HVector.denote rs' } :=
  let H := HVector.map (fun _Γα icom => ICom.denote icom) rs
  match rs with
  | .nil => ⟨.nil, by
      simp[HVector.map]
    ⟩
  | .cons r rs =>
    -- Need to create a fresh state to CSE the region.
    let s' := State.empty Lets.nil
    let ⟨r', hr'⟩ :=  s'.cseICom' r
    let ⟨rs', hrs'⟩ := s.cseRegionArgList rs
    ⟨.cons r' rs', by
          simp[HVector.denote]
          constructor
          funext V
          apply hr'
          apply hrs'
    ⟩

/-- lookup an expression in the state and return a corresponding CSE'd variable for it, along with the CSE'd expression
  that was looked up in the map for the variable.  -/
unsafe def State.cseExpr
 {Γstart Γ : Ctxt Ty}
 {lets : Lets Op Γstart Γ}
 (s : State Op lets)
 (e : IExpr Op Γ α) :
 {e' : IExpr Op Γ α // e'.denote = e.denote } × Option ({ v' : Γ.Var α // ∀ (V : Γstart.Valuation), (lets.denote V) v' = e.denote (lets.denote V) }) :=
  match E : e with
  | .mk op ty_eq args regArgs =>
      let ⟨args', hargs'⟩ := s.cseArgList args
      let regArgs' := s.cseRegionArgList regArgs
      let ⟨regArgs', hregArgs'⟩ := regArgs'
      let e' : IExpr Op Γ α  := .mk op ty_eq args' regArgs'
      ⟨⟨e', by {
        funext V
        simp[E, hargs', IExpr.denote_unfold]

        congr 1
        simp[Ctxt.Valuation.eval] at hargs'
        rw[hargs']
        rw[hregArgs']
        done
      }⟩,
        match s.expr2cache _ e with
        | .some ⟨v', hv'⟩ =>
          .some ⟨v', by
            intros V
            simp[hv']
            simp[E]
          ⟩
        | .none => .none
      ⟩



unsafe def State.cseICom {α : Ty}
  {lets : Lets Op Γstart Γ}
  (s : State Op lets)
  (com: ICom Op Γ α) :
  CSERet lets com :=
  match com with
  | .ret v => {
    Δ := Γ
    hom := Ctxt.Hom.id
    com' := .ret (s.var2var v).val
    hcom' := by
      let ⟨v', hv'⟩ := s.var2var v
      intros VΓ
      simp
      simp[ICom.denote, hv']
  }
  | .lete (α := α) e body =>
      let ⟨⟨e', he'⟩, v'?⟩ := s.cseExpr e
      match v'? with
      | .none => /- no variable to replace. -/
        let s' := s.snocExpr2Cache (e := e') /- add this expression into the cache for the latest variable. -/
        let ⟨body', hbody'⟩ := s'.cseICom' body
        {
          Δ := Γ
          hom := Ctxt.Hom.id
          com' := .lete e' body' -- need to pullback `body` along the morphism.
          hcom' := by {
            intros VΓ
            simp[ICom.denote]
            rw[hbody']
            rw[he']
            done
          }
        }
      | .some ⟨v', hv'⟩ =>
        let ⟨body', hbody'⟩ := ICom.substVar s e body v' (by
          intros V
          rw[hv']
          done
        )
        {
          Δ := Γ
          hom := Ctxt.Hom.id
          com' := body'
          hcom' := by {
            intros V
            simp[ICom.denote]
            rw[← hbody']
            simp
            done
          }
        }

/-- A variant of cseICom that exposes the same context `Γ`, instead of witnessing the change in context. This
  uses the context morphism in `CSERet` to adapt the original context `Γ` to the new context `Δ`. -/
unsafe def State.cseICom'
  {lets : Lets Op Γstart Γ}
  (s : State Op lets)
  (com: ICom Op Γ α) :
  { com' : ICom Op Γ α // ∀ (V: Ctxt.Valuation Γ), com.denote V = com'.denote V } :=
  let ⟨Δ, hom, com', hcom'⟩ := s.cseICom com
  ⟨com'.changeVars hom, by
    intros V
    rw[hcom']
    simp[Ctxt.Valuation.hom]⟩
end -- mutual.
end CSE
