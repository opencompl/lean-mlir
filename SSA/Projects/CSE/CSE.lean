import SSA.Core.Framework
import SSA.Projects.DCE.DCE

/-
This file implements common subexpression elimination for our SSA based IR. 
-/
import Mathlib.Data.HashMap

/- Decidable Equality for IComs. -/
namespace DecEqICom
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
structure State (Op : Type) [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty] (Γ : Ctxt Ty) where
  /-- map variable to its canonical value -/
  var2var : (v : Γ.Var α) → { v' : Γ.Var α // ∀ (V : Γ.Valuation), V v = V v' }
  /-- map an IExpr to its canonical variable -/
  expr2cache : (α : Ty) → (e : IExpr Op Γ α) → Option ({ v : Γ.Var α // ∀ (V : Γ.Valuation), V v = e.denote V }) 

/-- The empty CSEing state. -/
def State.empty [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty] : State Op Γ where
  var2var := fun v => ⟨v, by intros V; rfl⟩
  expr2cache := fun α e => .none

/-- assign an expression to a snoc'd variable with a given expression into the CSE map -/
def State.addExpr2Cache
 [Goedel Ty] [DecidableEq Ty] [OpSignature Op Ty] [OpDenote Op Ty]
 {Γ : Ctxt Ty} {α : Ty}
 (s : State Op Γ) (v : Γ.Var α) (e : { e : IExpr Op Γ α // ∀ (V : Γ.Valuation), e.denote V = V v }) : State Op Γ := {
  s with
  expr2cache := fun β eneedle => 
    if hβ : α = β
    then
      if he : (hβ ▸  eneedle) = e.val
      then sorry
      else s.expr2cache eneedle  
    else s.expr2cache β eneedle
 }

@[simp]
theorem Ctxt.Valuation.pullback_id [Goedel Ty] {Γ : Ctxt Ty} (V : Γ.Valuation) :
  V.hom Ctxt.Hom.id = V := by
    funext _t _v
    simp[Ctxt.Valuation.hom]

/-- return value of the CSE pass. -/
structure CSERet [OpSignature Op Ty] [Goedel Ty] [OpDenote Op Ty] (com: ICom Op Γ α) where
  Δ : Ctxt Ty
  hom : Ctxt.Hom Δ Γ
  com' : ICom Op Δ α
  hcom' : ∀ (VΓ: Ctxt.Valuation Γ), com.denote VΓ = com'.denote (VΓ.hom hom) 

/-- Replace the variables in `as` with new variables that have the same valuation -/
def State.cseArgList
 [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty]
  {Γ : Ctxt Ty} (s : State Op Γ)
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
          State Op Γ →
          {ts : List (Ctxt Ty × Ty)} →
          (rs : HVector (fun t => ICom Op t.1 t.2) ts) →
          { rs' : HVector (fun t => ICom Op t.1 t.2) ts // HVector.denote rs = HVector.denote rs' }) where
  default := fun _s _ts rs => ⟨rs, rfl⟩

/-- Default instance for `partial def` to compile. -/
instance [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty] : Inhabited (
  (s : State Op Γ) → (com: ICom Op Γ α) →  
  { com' : ICom Op Γ α // ∀ (V: Ctxt.Valuation Γ), com.denote V = com'.denote V }) where
  default := fun _s com => ⟨com, by intros V; rfl⟩

/-- Default instance for `partial def` to compile. -/
instance [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty] : Inhabited (
  (s : State Op Γ) → (com: ICom Op Γ α) →  CSERet com) where
  default := fun _s com => CSERet.mk Γ Ctxt.Hom.id com (by intros V; rfl) 

/- CSE for HVector / ICom / IExpr. -/
mutual 

/-- Replace the regions in `rs` with new regions that have the same valuation -/
partial def State.cseRegionArgList
 [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty]
  {Γ : Ctxt Ty} (s : State Op Γ)
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
    let s' := State.empty
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
partial def State.cseExpr
 [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty]
 {Γ : Ctxt Ty} (s : State Op Γ)
 (e : IExpr Op Γ α) : {e' : IExpr Op Γ α // e'.denote = e.denote } × Option ({ v' : Γ.Var α // ∀ (V : Γ.Valuation), V v' = e.denote V }) := 
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
        match s.expr2cache e with
        | .some ⟨v', hv'⟩ =>
          .some ⟨v', by
            intros V
            simp[hv']
            simp[E]
          ⟩
        | .none => .none
      ⟩

partial def State.cseICom [OpSignature Op Ty] [Goedel Ty] [OpDenote Op Ty] {α : Ty}  (s : State Op Γ) (com: ICom Op Γ α) : 
  CSERet com := 
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
      let ⟨e', v'?⟩ := s.cseExpr e 
      match v'? with
      | .none => 
        let s' := s.assignSnocVar e'
        let ret' := s'.cseICom body
        {
          Δ := Γ
          hom := Ctxt.Hom.id
          com' := .lete e' sorry -- need to pullback `body` along the morphism. 
          hcom' := sorry
        } 
      | .some ⟨v', hv'⟩ => sorry 

/-- A variant of cseICom that exposes the same context `Γ`, instead of witnessing the change in context. This
  uses the context morphism in `CSERet` to adapt the original context `Γ` to the new context `Δ`. -/
partial def State.cseICom' [OpSignature Op Ty] [Goedel Ty] [OpDenote Op Ty] {α : Ty}  (s : State Op Γ) (com: ICom Op Γ α) : 
  { com' : ICom Op Γ α // ∀ (V: Ctxt.Valuation Γ), com.denote V = com'.denote V } :=  
  let ⟨Δ, hom, com', hcom'⟩ := s.cseICom com
  ⟨com'.changeVars hom, by
    intros V
    rw[hcom']
    simp[Ctxt.Valuation.hom]⟩
end -- mutual. 
end CSE
