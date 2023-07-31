import Std
import SSA.Experimental.Context
import Mathlib.Tactic

open Ctxt


inductive DSTLC : Ctxt → Ty → Type where
  | DVar : Γ.Var t → DSTLC Γ t
  | DLam : DSTLC (Γ.snoc a) b → DSTLC Γ (.fn a b)
  | DApp : DSTLC env (.fn a b) → DSTLC env a → DSTLC env b


class STLChoas (exp : Ctxt → Ty → Type) where
  /-- Expresses that the context of any expression may always grow -/
  toSnoc : exp Γ t → exp (Γ.snoc u) t
  /-- Lambda -/
  lam : (exp (Γ.snoc a) a → exp (Γ.snoc a) b) → exp Γ (.fn a b)
  /-- Application -/
  app : exp Γ (.fn a b) → exp Γ a → exp Γ b


def Ctxt.Env (Γ : Ctxt) (exp : Ctxt → Ty → Type) : Type :=
  ⦃t : Ty⦄ → Γ.Var t → exp Γ t


def Ctxt.Env.empty (exp : Ctxt → Ty → Type) : Env ∅ exp :=
  fun _ v => v.emptyElim


def Ctxt.Env.snoc {Γ : Ctxt} {exp : Ctxt → Ty → Type} [STLChoas exp] 
    (env : Γ.Env exp) (val : exp (Γ.snoc t) t) : 
    Ctxt.Env (Γ.snoc t) exp :=
  fun t v => match v with
    | ⟨0, h⟩ => cast (by simp[List.get?] at h; rw[h]) val
    | ⟨v+1, h⟩ => STLChoas.toSnoc <| env ⟨v, h⟩

/-- Open Hoas Term -/
def OTHoas (Γ : Ctxt) (t : Ty) := 
  ∀ exp, [STLChoas exp] → Γ.Env exp → exp Γ t

/-- Closed Hoas Term -/
def CTHoas (t : Ty) := 
  ∀ exp, [STLChoas exp] → exp ∅ t

def toHOAS : DSTLC Γ t → OTHoas Γ t
  | .DVar n => fun _ _ g => g n
  | .DLam t => fun exp _ g => STLChoas.lam fun x =>
      toHOAS t exp (g.snoc <| x)
  | .DApp f p => fun exp _ g => 
      STLChoas.app (toHOAS f exp g) (toHOAS p exp g)

def toCHOAS : DSTLC ∅ t → CTHoas t :=
  fun term exp _ =>
    toHOAS term exp (Ctxt.Env.empty _)



namespace DSTLC

def changeVars (m : Γ₁.hom Γ₂) : DSTLC Γ₁ a → DSTLC Γ₂ a
  | .DVar i => .DVar <| m i
  | .DApp x y => .DApp (changeVars m x) (changeVars m y)
  | .DLam f => .DLam (changeVars m.toSnoc f)

instance : STLChoas DSTLC where
  toSnoc := changeVars (Ctxt.Var.toSnoc)
  app := .DApp
  lam := fun f => .DLam <| f (.DVar <| .last ..)


end DSTLC


/-- Turn a HOAS term into a de Bruijn term -/
def fromCHOAS (h : ∀ exp, [STLChoas exp] → exp Γ a) : DSTLC Γ a :=
  h DSTLC

/-- Turn an open HOAS term into a de Bruijn term -/
def fromHOAS (h : OTHoas Γ a) : DSTLC Γ a :=
  h DSTLC (fun _ v => .DVar v)





@[simp]
theorem Env.snoc_toSnoc [STLChoas exp] (env : Env Γ exp) :
    (env.snoc val) (Var.toSnoc v) = STLChoas.toSnoc (env v) :=
  rfl

@[simp]
theorem Env.snoc_last [STLChoas exp] (env : Env Γ exp) :
    (env.snoc val) (Var.last ..) = val :=
  rfl


theorem fromHOAS_toHOAS (t : DSTLC Γ a) :
    fromHOAS (toHOAS t) = t := by 
  simp[fromHOAS]
  induction t
  . simp[toHOAS]
  next ih =>
    simp[toHOAS, STLChoas.lam]
    rw[←ih]
    congr
    funext t v
    cases v using Ctxt.Var.casesOn <;> simp
    rfl
  next ih₁ ih₂ => 
    simp[toHOAS, STLChoas.app, ih₁, ih₂]

