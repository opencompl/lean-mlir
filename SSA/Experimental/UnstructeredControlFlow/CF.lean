import SSA.Core

open Ctxt (Var Valuation)

/- # Datastructures -/
section DataStructures

variable (d : Dialect) [DialectSignature d]

inductive Terminator (ℓ : Type) (Γ : Ctxt d.Ty) (L : ℓ → d.Ty) : (t : d.Ty) → Type
  | ret (v : Γ.Var t) : Terminator ℓ Γ L t
  | goto (l : ℓ) : Terminator ℓ Γ L (L l)

mutual

inductive Region : (Γ : Ctxt d.Ty) → (ty : d.Ty) → Type
  | mk
      (ℓ : Set String)
      (entry : ℓ)
      (L : ℓ → d.Ty)
      (blocks : (l : ℓ) → Block Γ (L l))
      : Region Γ (L entry)

inductive Regions : (ρ : RegionSignature d.Ty) → Type
  | mk : HVector (fun r => Region r.1 r.2) ρ → Regions ρ

/-- An intrinsically typed instruction whose effect is *at most* EffectKind -/
inductive Inst : (Γ : Ctxt d.Ty) → (ty : d.Ty) → Type where
  | mk {Γ} {ty} (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (eff_le : DialectSignature.effectKind op = .pure)
    (args : HVector (Var Γ) <| DialectSignature.sig op)
    /- For now, assume that regions are impure.
       We keep it this way to minimize the total amount of disruption in our definitions.
       We shall change this once the rest of the file goes through. -/
    (regArgs : Regions <| DialectSignature.regSig op) : Inst Γ ty


/-- A very simple intrinsically typed program: a sequence of let bindings.
Note that the `EffectKind` is uniform: if a `Com` is `pure`, then the expression
and its body are pure, and if a `Com` is `impure`, then both the expression and
the body are impure!
-/
inductive Block : (ℓ : Type) → (Γ : Ctxt d.Ty) → (L : ℓ → d.Ty) (t : d.Ty) → Type where
  | term : Terminator  →  Block Γ t
  | var (e : Inst Γ α) (body : Block (Γ.snoc α) β) : Block Γ β
end


/-!

## Semantics

-/

variable [TyDenote d.Ty] [DialectDenote d] [DecidableEq d.Ty] [Monad d.m] [LawfulMonad d.m]

mutual

def HVector.denote :
    {l : List (Ctxt d.Ty × d.Ty)} → (T : HVector (fun t => Com d t.1 .impure t.2) l) →
    HVector (fun t => t.1.Valuation → EffectKind.impure.toMonad d.m (toType t.2)) l
  | _, .nil => HVector.nil
  | _, .cons v vs => HVector.cons (v.denote) (HVector.denote vs)

def Expr.denote {ty : d.Ty} (e : Expr d Γ eff ty) (Γv : Valuation Γ) :
    eff.toMonad d.m (toType ty) :=
  match e with
  | ⟨op, Eq.refl _, heff, args, regArgs⟩ =>
    EffectKind.liftEffect heff <| DialectDenote.denote op
      (args.map (fun _ v => Γv v)) regArgs.denote

def Com.denote : Com d Γ eff ty → (Γv : Valuation Γ) → eff.toMonad d.m (toType ty)
  | .ret e, Γv => pure (Γv e)
  | .var e body, Γv =>
     match eff with
     | .pure => body.denote (Γv.snoc (e.denote Γv))
     | .impure => e.denote Γv >>= fun x => body.denote (Γv.snoc x)
end
