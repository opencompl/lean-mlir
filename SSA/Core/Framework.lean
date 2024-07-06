import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import SSA.Core.Framework.Dialect

open Ctxt (Var VarSet Valuation)
open TyDenote (toType)

/- # Classes -/

abbrev RegionSignature Ty := List (Ctxt Ty × Ty)

structure Signature (Ty : Type) where
  mkEffectful ::
  sig        : List Ty
  regSig     : RegionSignature Ty
  outTy      : Ty
  effectKind : EffectKind := .pure

abbrev Signature.mk (sig : List Ty) (regSig : RegionSignature Ty) (outTy : Ty) : Signature Ty :=
 { sig := sig, regSig := regSig, outTy := outTy }

class DialectSignature (d : Dialect) where
  signature : d.Op → Signature d.Ty
export DialectSignature (signature)

section
variable {d} [s : DialectSignature d]

def DialectSignature.sig        := Signature.sig ∘ s.signature
def DialectSignature.regSig     := Signature.regSig ∘ s.signature
def DialectSignature.outTy      := Signature.outTy ∘ s.signature
def DialectSignature.effectKind := Signature.effectKind ∘ s.signature

end

class DialectDenote (d : Dialect) [TyDenote d.Ty] [DialectSignature d] where
  denote : (op : d.Op) → HVector toType (DialectSignature.sig op) →
    (HVector (fun t : Ctxt d.Ty × d.Ty => t.1.Valuation → toType t.2)
            (DialectSignature.regSig op)) →
    (toType <| DialectSignature.outTy op)

section DataStructures

variable (d : Dialect) [DialectSignature d]

mutual
inductive Expr : (Γ : Ctxt d.Ty) → (ty : d.Ty) → Type :=
  | mk {Γ} {ty} (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (args : HVector (Var Γ) <| DialectSignature.sig op)
    (regArgs : HVector (fun t : Ctxt d.Ty × d.Ty => Com t.1 t.2)
      (DialectSignature.regSig op)) : Expr Γ ty

inductive Com : Ctxt d.Ty → d.Ty → Type where
  | ret (v : Var Γ t) : Com Γ t
  | var (e : Expr Γ α) (body : Com (Γ.snoc α) β) : Com Γ β
end

inductive Lets (Γ_in : Ctxt d.Ty) :
    (Γ_out : Ctxt d.Ty) → Type where
  | nil : Lets Γ_in Γ_in
  | var (body : Lets Γ_in Γ_out) (e : Expr d Γ_out t) : Lets Γ_in (Γ_out.snoc t)

end DataStructures

/-
  # Definitions
-/

variable {d : Dialect} [DialectSignature d]

@[elab_as_elim]
def Com.recAux' {motive : ∀ {Γ t}, Com d Γ t → Sort u}
    (ret : ∀ {Γ t}, (v : Var Γ t) → motive (Com.ret v))
    (var : ∀ {Γ} {t u : d.Ty},
      (e : Expr d Γ t) → (body : Com d (Ctxt.snoc Γ t) u) →
        motive body → motive (Com.var e body)) :
    ∀ {Γ t}, (com : Com d Γ t) → motive com
  | _, _, Com.ret v => ret v
  | _, _, Com.var e body => var e body (Com.recAux' ret var body)

@[implemented_by Com.recAux', elab_as_elim, induction_eliminator]
-- ^^^^ `Com.rec` is noncomputable, so have a computable version as well
--      See `Com.recAux'_eq` for a theorem that states these definitions are equal
def Com.rec' {motive : ∀ {Γ t}, Com d Γ t → Sort u}
    (ret : ∀ {Γ t}, (v : Var Γ t) → motive (Com.ret v))
    (var : ∀ {Γ} {t u : d.Ty},
      (e : Expr d Γ t) → (body : Com d (Ctxt.snoc Γ t) u) →
        motive body → motive (Com.var e body)) :
    ∀ {Γ t}, (com : Com d Γ t) → motive com :=
  /- HACK: the obvious definition of `rec'` using the match compiler does not have the
     def-eqs we expect. Thus, we directly use the recursion principle. -/
  Com.rec (motive_1 := fun _  _ _ => PUnit) (motive_2 := fun  _ _ c => motive c)
    (motive_3 := fun _ _ => PUnit) (fun _  _ _ _ _ => ⟨⟩) -- `Expr.mk` case
    (ret) -- `Com.ret` case
    (fun e body _ r => var e body r) -- `Com.var` case
    ⟨⟩ (fun _ _ _ _ => ⟨⟩)

@[simp] lemma Com.rec'_var (e : Expr d Γ t) (body : Com d  _ u)
    {motive} {ret var} :
    (Com.var e body).rec' (motive:=motive) ret var
    = var e body (body.rec' ret var) :=
  rfl

/-!
### `Com` projections and simple conversions
-/

/-- The `outContext` of a program is a context which includes variables for all let-bindings
of the program. That is, it is the context under which the return value is typed -/
def Com.outContext {Γ} : Com d Γ t → Ctxt d.Ty :=
  Com.rec' (motive := fun _ => Ctxt d.Ty)
    (@fun Γ _ _ _ => Γ) -- `Com.ret` case
    (fun _ _ r => r) -- `Com.var` case

/-!
## `denote`
Denote expressions, programs, and sequences of lets
-/
variable [TyDenote d.Ty] [DialectDenote d] [DecidableEq d.Ty] [Monad d.m] [LawfulMonad d.m]

mutual

def HVector.denote : {l : List (Ctxt d.Ty × d.Ty)} → (T : HVector (fun t => Com d t.1 t.2) l) →
    HVector (fun t => t.1.Valuation → toType t.2) l
  | _, .nil => HVector.nil
  | _, .cons v vs => HVector.cons (v.denote) (HVector.denote vs)

def Expr.denote {ty : d.Ty} (e : Expr d Γ ty) (Γv : Valuation Γ) : toType ty :=
  match e with
  | ⟨op, heff, args, regArgs⟩ =>
    EffectKind.liftEffect heff <| DialectDenote.denote op (args.map (fun _ v => Γv v)) regArgs.denote

def Com.denote : Com d Γ ty → (Γv : Valuation Γ) → toType ty
  | .ret e, Γv => pure (Γv e)
  | .var e body, Γv =>
     match eff with
     | .pure => body.denote (Γv.snoc (e.denote Γv))
     | .impure => e.denote Γv >>= fun x => body.denote (Γv.snoc x)
end

def Com.denoteLets : (com : Com d Γ ty) → (Γv : Valuation Γ) →
    com.outContext.Valuation
  | .ret _, V => pure V
  | .var e body, V =>
      e.denote V >>= fun Ve =>
      body.denoteLets (V.snoc Ve) >>= fun V =>
      return V.cast (by simp [Com.outContext])

def Lets.denote [DialectSignature d] [DialectDenote d]
    (lets : Lets d Γ₁ Γ₂) (Γ₁'v : Valuation Γ₁) : Valuation Γ₂ :=
  match lets with
  | .nil => Γ₁'v
  | .var lets' e =>
      lets'.denote Γ₁'v >>= fun Γ₂'v =>
      e.denote Γ₂'v >>= fun v =>
      return (Γ₂'v.snoc v)

#eval Lean.Meta.getEqnsFor? ``Lets.denote
