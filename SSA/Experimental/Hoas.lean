import SSA.Core.WellTypedFramework
import SSA.Experimental.Context

namespace SSA

inductive Ty 
  | nat
  deriving DecidableEq, Repr

def Ty.toType : Ty → Type
  | .nat => Nat


/-- A very simple intrinsically typed expression. -/
inductive IExpr : Ctxt → Ty → Type
  | add (a b : Γ.Var .nat) : IExpr Γ .nat
  /-- Nat literals. -/
  | nat (n : Nat) : IExpr Γ .nat

/-- A very simple intrinsically typed program: a sequence of let bindings. -/
inductive ICom : Ctxt →  Ty → Type where
  | ret {Γ : Ctxt} : Γ.Var t → ICom Γ t
  | lete (e : IExpr Γ α) (body : ICom (Γ.snoc α) β) : ICom Γ β




class HOAS (expr stmt var : Ty → Type) where
  /-- let-binding -/
  assign {T : Ty} (rhs : expr T) 
      (rest : var T → stmt T')
      : stmt T'
  -- /-- above; ret v -/
  ret (v : expr T) : stmt T
  add (a b : var (.nat)) : expr (.nat)

def HOASExpr : Type := ∀ (expr stmt var : Ty → Type) [HOAS expr stmt var], expr
def HOASCom : Type := ∀ (expr stmt var : Ty → Type) [HOAS expr stmt var], stmt
def HOASVar : Type := ∀ (expr stmt var : Ty → Type) [HOAS expr stmt var], var




def IExpr.fromHOAS : HOASExpr t → IExpr ∅ t := 
  sorry


def TSSA.fromHOAS : 



end SSA