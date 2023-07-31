import SSA.Core.WellTypedFramework
import SSA.Experimental.Context

namespace SSA

/-- A very simple intrinsically typed expression. -/
inductive IExpr : Ctxt → Ty → Type
  | add (a b : Γ.Var .nat) : IExpr Γ .nat
  /-- Nat literals. -/
  | nat (n : Nat) : IExpr Γ .nat

/-- A very simple intrinsically typed program: a sequence of let bindings. -/
inductive ICom : Ctxt →  Ty → Type where
  | ret {Γ : Ctxt} : Γ.Var t → ICom Γ t
  | lete (e : IExpr Γ α) (body : ICom (Γ.snoc α) β) : ICom Γ β


class HasToSnoc (ε : Ctxt → Ty → Type) where
  toSnoc {Γ : Ctxt} {t u : Ty} : ε Γ t → ε (Γ.snoc u) t 


class HOAS (expr stmt var : Ctxt → Ty → Type) where
  [toSnocExpr : HasToSnoc expr]
  [toSnocStmt : HasToSnoc stmt]
  [toSnocVar : HasToSnoc var]  
  /-- let-binding -/
  assign {Γ : Ctxt} {T : Ty} (rhs : expr Γ T) 
      (rest : var (Γ.snoc T) T → stmt (Γ.snoc T) T')
      : stmt Γ T'
  /-- above; ret v -/
  ret (v : var Γ T) : stmt Γ T
  add (a b : var Γ (.nat)) : expr Γ (.nat)



def HOASExpr (Γ : Ctxt) (t : Ty) : Type 1 := 
  ∀ expr stmt var, [HOAS expr stmt var] → expr Γ t

def HOASCom (Γ : Ctxt) (t : Ty) : Type 1 := 
  ∀ expr stmt var, [HOAS expr stmt var] → stmt Γ t

def HOASVar (Γ : Ctxt) (t : Ty) : Type 1 := 
  ∀ expr stmt var, [HOAS expr stmt var] → var Γ t




instance : HasToSnoc (Ctxt.Var) where
  toSnoc v := v.toSnoc

def IExpr.changeVars (varsMap : Γ.hom Γ') : 
    (e : IExpr Γ ty) → IExpr Γ' ty
  | .nat n => .nat n
  | .add a b => .add (varsMap a) (varsMap b)

instance : HasToSnoc (IExpr) := ⟨IExpr.changeVars Ctxt.Var.toSnoc⟩

def ICom.changeVars (varsMap : Γ.hom Γ') : ICom Γ ty → ICom Γ' ty
  | .ret e => .ret (varsMap e)
  | .lete e body => .lete (e.changeVars varsMap) 
      (body.changeVars (fun t v => varsMap.toSnoc v))

instance : HasToSnoc (ICom) := ⟨ICom.changeVars Ctxt.Var.toSnoc⟩


instance : HOAS IExpr ICom Ctxt.Var where
  assign rhs rest := ICom.lete rhs (rest <| .last ..)
  ret := ICom.ret
  add := IExpr.add



def ICom.fromHOAS (com : HOASCom Γ t) : ICom Γ t :=
  com IExpr ICom Ctxt.Var



end SSA