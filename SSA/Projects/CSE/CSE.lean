import SSA.Core.Framework

/-
This file implements common subexpression elimination for our SSA based IR. 
-/
import Mathlib.Data.HashMap

namespace CSE


/-- State stored by CSE pass. -/
structure State (Op : Type) [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty] (Γ : Ctxt Ty) where
  /-- map variable to its canonical value -/
  var2var : (v : Γ.Var α) → { v' : Γ.Var α // ∀ (V : Γ.Valuation), V v' = V v }
  /-- map an IExpr to its canonical variable -/
  expr2cache : (e : IExpr Op Γ α) → Option ({ v : Γ.Var α // ∀ (V : Γ.Valuation), V v = e.denote V }) 

/-- internal method:
  canonicalize an expression into another expression that's more likely to be in the cache, whose
  denotation is the same as the current expression -/
def State.canonicalizeExpr_ 
 [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty]
 {Γ : Ctxt Ty} (s : State Op Γ) (e : IExpr Op Γ α) : { e' : IExpr Op Γ α // e.denote = e'.denote } :=
  match e with
  | .mk op ty_eq args regArgs => sorry

/-- assign an expression to a snoc'd variable with a given expression into the CSE map -/
def State.assignSnocVar
 [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty]
 {Γ : Ctxt Ty} (s : State Op Γ) (e : IExpr Op Γ α) : State Op (Γ.snoc α) := sorry

def _root_.Ctxt.Valuation.pullback [Goedel Ty] {Γ Δ : Ctxt Ty} (hom : Ctxt.Hom Γ Δ) (V : Δ.Valuation) : Γ.Valuation :=
  fun _tΓ vΓ => V (hom vΓ)

@[simp]
theorem Ctxt.Valuation.pullback_id [Goedel Ty] {Γ : Ctxt Ty} (V : Γ.Valuation) :
  V.pullback Ctxt.Hom.id = V := by
    funext _t _v
    simp[Ctxt.Valuation.pullback]

/-- return value of the CSE pass. -/
structure CSERet [OpSignature Op Ty] [Goedel Ty] [OpDenote Op Ty] (com: ICom Op Γ α) where
  Δ : Ctxt Ty
  hom : Ctxt.Hom Δ Γ
  com' : ICom Op Δ α
  hcom' : ∀ (VΓ: Ctxt.Valuation Γ), com.denote VΓ = com'.denote (VΓ.pullback hom) 

/- CSE for HVector / ICom / IExpr. -/
mutual 

/-- lookup an expression in the state and return a corresponding CSE'd variable for it -/
def State.cseExpr
 [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty]
 {Γ : Ctxt Ty} (s : State Op Γ)
 (e : IExpr Op Γ α) : Option ({ v' : Γ.Var α // ∀ (V : Γ.Valuation), V v' = e.denote V }) := 
    match e with
  | .mk op ty_eq args regArgs => 
      sorry

def State.cseICom [OpSignature Op Ty] [Goedel Ty] [OpDenote Op Ty] {α : Ty}  (s : State Op Γ) (com: ICom Op Γ α) : 
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
      match s.cseExpr e with
      | .none => 
        let ⟨e', he'⟩ := s.canonicalizeExpr_ e
        let s' := s.assignSnocVar e'
        let ret' := s'.cseICom body
        {
          Δ := Γ
          hom := Ctxt.Hom.id
          com' := .lete e' sorry -- need to pullback `body` along the morphism. 
          hcom' := sorry
        } 
      | .some ⟨e', he'⟩ => sorry 

end -- mutual. 

end CSE
