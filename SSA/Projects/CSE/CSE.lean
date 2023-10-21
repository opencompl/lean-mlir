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
  sorry

/-- add a variable with a given expression into the CSE map -/
def State.assignVar
 [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty]
 {Γ : Ctxt Ty} (s : State Op Γ)
 (v : Γ.Var α) (e : IExpr Op Γ α) : State Op Γ := sorry

/-- lookup an expression in the state and return a corresponding CSE'd variable for it -/
def State.cseExpr
 [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty]
 {Γ : Ctxt Ty} (s : State Op Γ)
 (e : IExpr Op Γ α) (e : IExpr Op Γ α) : Option ({ v' : Γ.Var α // ∀ (V : Γ.Valuation), V v' = e.denote V }) := sorry


def _root_.Ctxt.Valuation.pullback [Goedel Ty] {Γ Δ : Ctxt Ty} (hom : Ctxt.Hom Γ Δ) (V : Δ.Valuation) : Γ.Valuation :=
  fun _tΓ vΓ => V (hom vΓ)
/-- return value of the CSE pass. -/
structure CSERet [OpSignature Op Ty] [Goedel Ty] [OpDenote Op Ty] (com: ICom Op Γ α) where
  Δ : Ctxt Ty
  hom : Ctxt.Hom Δ Γ
  com' : ICom Op Δ α
  hcom' : ∀ (VΓ: Ctxt.Valuation Γ), com.denote VΓ = com'.denote (VΓ.pullback hom) 

def cse [OpSignature Op Ty] [Goedel Ty] [OpDenote Op Ty] {α : Ty} (com: ICom Op Γ α) (cseState : State Op Γ) : 
  CSERet com := 
  match com with
  | .ret v => sorry
  | .lete (α := α) e body => sorry

end CSE
