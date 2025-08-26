/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
-- Investigations on asymptotic behavior of representing programs with large explicit contexts

import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import SSA.Core.Framework.Dialect

import Mathlib.Control.Monad.Basic
import Mathlib.Data.Finset.Piecewise

set_option deprecated.oldSectionVars true

theorem Id.pure_eq' (a : α) : (pure a : Id α) = a := rfl
theorem Id.map_eq' (x : Id α) (f : α → β) : f <$> x = f x := rfl
theorem Id.bind_eq' (x : Id α) (f : α → id β) : x >>= f = f x := rfl

open Ctxt (Var VarSet Valuation Hom)
open TyDenote (toType)

/-!
NOTE: Monadic Code Needs Pointfree Theorems
-------------------------------------------

It is always best to write theorems in *unapplied* fashion, since a monadic function
is often used in chains of binds.

A theorem of the form 'f1 x = f2 x'cannot be used in a context 'f1 >>= g', but a
pointfree theorem of the form 'f = g'permits rewriting everywhere, even in 'f1 >>= g'.

This is not a problem in pure code, since we rarely use poinfree style with (f ∘ g),
but this is much more pervasive in monadic code, where 'f >>= g' is common.

Thus, the rule is that ALL rewrite rules are written pointfree in the last argument.
-/


/-!
NOTE: Normal form for monadic code
----------------------------------

We never use functor and applicative instances. Rather, we *always* write definitions
in terms of monadic code, using 'non-canonical' haskell code such as
    mv >>= (fun v => return (g v))
rather than writing the more natural
    g <$> mv
since it is much easier to design simp sets and tactics that consistenty simplify
monadic bind, instead of a combination of: <$>, <*>, return, pure, >>=.

Furthermore, consistent use of >>= simplifes reasoning about information flow,
where left-to-right order clearly implies the direction of information flow.
-/

--TODO: upstream this?
theorem _root_.Pure.pure_cast {f} [inst : Pure f] (b : β) (h : β = α) :
    (pure (cast h b) : f α) = cast (by rw[h]) (pure b : f β) := by
  apply eq_of_heq;
  apply HEq.trans (b:=pure b) ?_ (cast_heq _ _).symm
  congr
  · symm; assumption
  · exact cast_heq ..


/- # Classes -/

abbrev RegionSignature Ty := List (Ctxt Ty × List Ty)

structure Signature (Ty : Type) where
  mkEffectful ::
  sig         : List Ty
  regSig      : RegionSignature Ty
  returnTypes : List Ty
  effectKind  : EffectKind := .pure

abbrev Signature.mk (sig : List Ty) (regSig : RegionSignature Ty) (returnTypes : List Ty) : Signature Ty :=
 { sig, regSig, returnTypes }

class DialectSignature (d : Dialect) where
  signature : d.Op → Signature d.Ty
export DialectSignature (signature)

namespace DialectSignature
variable {d} [s : DialectSignature d]

def sig          := Signature.sig ∘ s.signature
def regSig       := Signature.regSig ∘ s.signature
def returnTypes  := Signature.returnTypes ∘ s.signature
def effectKind   := Signature.effectKind ∘ s.signature

end DialectSignature

class DialectDenote (d : Dialect) [TyDenote d.Ty] [DialectSignature d] where
  denote : (op : d.Op) → HVector toType (DialectSignature.sig op) →
    (HVector (fun t : Ctxt d.Ty × List d.Ty =>
      t.1.Valuation
      → EffectKind.impure.toMonad d.m (HVector toType t.2))
            (DialectSignature.regSig op)) →
    ((DialectSignature.effectKind op).toMonad d.m
      (HVector toType <| DialectSignature.returnTypes op))

/-
Some considerations about purity:

We want pure operations to be able to be run in an impure context (but not vice versa, of course).

However, the current definition of `DialectDenote` forces an expressions regions
to be of the same purity as the operation.  In particular, a pure operation
which has regions requires those regions to be available as pure functions `args
→ result` to be able call `DialectDenote.denote`, whereas an instance of this
operation with impure regions would have them be `args → d.m result`.

Thus, a change to `DialectDenote.denote` is necessary (eventually), but the main question there is:
how can we incorporate effect polymorphism without exposing the possibility that a user might
define semantics for an operation that behave differently when running purely vs when running
impurely.

One option is to generalize `DialectDenote` to take an effect, like so
```lean
class DialectDenote (d) [Goedel Ty] [DialectSignature d] where
  denote (op : Op) {eff : EffectKind} (heff : DialectSignature.effectKind op ≤ eff)  :
    HVector toType (DialectSignature.sig op) →
    (HVector (fun t : Ctxt d.Ty × Ty => t.1.Valuation → eff.toMonad d.m (toType t.2))
            (DialectSignature.regSig op)) →
    (eff.toMonad d.m (toType <| DialectSignature.outTy op))
```

But, then we'd have to enforce that the semantics don't change when a pure operation is being run
impurely.
```lean
class LawfulOpDenote (Op Ty : Type) (m : Type → Type)
    [Goedel Ty] [DialectSignature d] [DialectDenote d] [Monad d.m] where
  pure_denote (op : Op) (heff : DialectSignature.effectKind op = .pure) (args) (regions) :
      pure (DialectDenote.denote op (eff:=.pure) (by simp [heff]) args regions)
      = DialectDenote.denote op (eff:=.impure) (by simp) args (regions.map fun _ r V => return r V)
```

Another option, which would be more complicated, but correct by construction, is to have the
`denote` function be run within a specific `OpDenoteM` monad, whose monadic actions are
"eval region $x". Assuming the `op` is pure, `OpDenoteM α` could then be evaluated both purely or
impurely.
-/

/--
ToPrint includes the functions to print the components of a dialect.
-/
class ToPrint (d : Dialect) where
  /-- Prints the operation in the dialect. -/
  printOpName : d.Op → String
  /-- Prints the type in the dialect. -/
  printTy : d.Ty → String
  /-- Prints the attributes of the operation. -/
  printAttributes : d.Op → String
  /-- Prints the name of the dialect. -/
  printDialect : String
  /-- Prints the return instruction of the dialect. -/
  printReturn : List d.Ty → String
  /-- Prints the function header of the dialect. -/
  printFunc : List d.Ty → String

/- # Datastructures -/
section DataStructures

variable (d : Dialect) [DialectSignature d]

mutual
/-- An intrinsically typed expression whose effect is *at most* EffectKind -/
inductive Expr : (Γ : Ctxt d.Ty) → (eff : EffectKind) → (ty : List d.Ty) → Type where
  | mk {Γ} {ty} (op : d.Op)
    (ty_eq : ty = DialectSignature.returnTypes op)
    (eff_le : DialectSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) <| DialectSignature.sig op)
    /- For now, assume that regions are impure.
       We keep it this way to minimize the total amount of disruption in our definitions.
       We shall change this once the rest of the file goes through. -/
    (regArgs : HVector (fun t : Ctxt d.Ty × List d.Ty => Com t.1 .impure t.2)
      (DialectSignature.regSig op)) : Expr Γ eff ty

/-- A very simple intrinsically typed program: a sequence of let bindings.
Note that the `EffectKind` is uniform: if a `Com` is `pure`, then the expression
and its body are pure, and if a `Com` is `impure`, then both the expression and
the body are impure!
-/
inductive Com : Ctxt d.Ty → EffectKind → List d.Ty → Type where
  | rets {Γ} {tys} {eff : EffectKind} (vs : HVector Γ.Var tys) : Com Γ eff tys
  | var (e : Expr Γ eff ty) (body : Com (Γ ++ ty) eff β) : Com Γ eff β
end

/-! ### `Expr` output context -/
/-- The context immediately *after* this expression. -/
abbrev Expr.outContext (_ : Expr d Γ eff ts) : Ctxt d.Ty :=
  Γ ++ ts

/-! ### Regions -/
abbrev Regions (regSig : RegionSignature d.Ty) : Type :=
  HVector (fun t => Com d t.1 .impure t.2) regSig

/-! ### Lets -/

/-- `Lets d Γ_in Γ_out` is a sequence of lets which are well-formed under
context `Γ_out` and result in context `Γ_in`. -/
inductive Lets (Γ_in : Ctxt d.Ty) (eff : EffectKind) :
    (Γ_out : Ctxt d.Ty) → Type where
  | nil : Lets Γ_in eff Γ_in
  | var (body : Lets Γ_in eff Γ_out) (e : Expr d Γ_out eff t) : Lets Γ_in eff e.outContext

/-! ### DecidableEq instance -/
--TODO: this should be derived later on when a derive handler is implemented
mutual -- DecEq

variable {d} [DialectSignature d]

protected instance HVector.decidableEqReg [DecidableEq d.Op] [DecidableEq d.Ty] :
    ∀ {l : RegionSignature d.Ty}, DecidableEq (HVector (fun t => Com d t.1 .impure t.2) l)
  | _, .nil, .nil => isTrue rfl
  | _, .cons x₁ v₁, .cons x₂ v₂ =>
    letI := HVector.decidableEqReg v₁ v₂
    letI := Com.decidableEq x₁ x₂
    decidable_of_iff (x₁ = x₂ ∧ v₁ = v₂) (by simp)

protected instance Expr.decidableEq [DecidableEq d.Op] [DecidableEq d.Ty] :
    {Γ : Ctxt d.Ty} → {ty : List d.Ty} → DecidableEq (Expr d Γ eff ty)
  | Γ, _, .mk op₁ rfl eff_le₁ arg₁ regArgs₁, .mk op₂ eq eff_le₂ arg₂ regArgs₂ =>
    if ho : op₁ = op₂ then by
      subst ho
      letI := HVector.decidableEq arg₁ arg₂
      letI := HVector.decidableEqReg regArgs₁ regArgs₂
      exact decidable_of_iff (arg₁ = arg₂ ∧ regArgs₁ = regArgs₂) (by simp)
    else isFalse (by simp_all)

protected instance Com.decidableEq [DecidableEq d.Op] [DecidableEq d.Ty]
    {Γ : Ctxt d.Ty} {eff : EffectKind} {tys : List d.Ty} : DecidableEq (Com d Γ eff tys)
  | .rets v₁, .rets v₂ => decidable_of_iff (v₁ = v₂) (by simp)
  | .var (ty := ty₁) e₁ body₁, .var (ty := ty₂) e₂ body₂ =>
    if hα : ty₁ = ty₂
    then by
      subst hα
      letI := Expr.decidableEq e₁ e₂
      letI := Com.decidableEq body₁ body₂
      exact decidable_of_iff (e₁ = e₂ ∧ body₁ = body₂) (by simp)
    else isFalse (by simp_all)
  | .rets _, .var _ _ => isFalse (fun h => Com.noConfusion h)
  | .var _ _, .rets _ => isFalse (fun h => Com.noConfusion h)

end -- decEq

end DataStructures

/-
  # Definitions
-/

variable {d : Dialect} [DialectSignature d]

/-!
### Com recursors
-/

section Rec
variable {eff t} {motive : ∀ {Γ}, Com d Γ eff t → Sort u}
          (rets : ∀ {Γ : Ctxt _} , (v : HVector Γ.Var t) → motive (Com.rets v))
          (var : ∀ {Γ} {u},
            (e : Expr d Γ eff u) → (body : Com d e.outContext eff t) →
              motive body → motive (Com.var e body))

@[elab_as_elim]
def Com.recAux' {Γ} : (com : Com d Γ eff t) → motive com
  | Com.rets v => rets v
  | Com.var e body => var e body (Com.recAux' body)

/--
`Com.rec'` is a simple recursor for `Com` -- meaning it does not facilitate
mutual recursion on the contained expressions or regions. In return, it has
nicer def-eqs than a pattern-match based definition would.
-/
@[implemented_by Com.recAux', elab_as_elim, induction_eliminator]
-- ^^^^ `Com.rec` is noncomputable, so have a computable version as well
--      See `Com.recAux'_eq` for a theorem that states these definitions are equal
def Com.rec' {Γ} (com : Com d Γ eff t) : motive com :=
  /- HACK: the obvious definition of `rec'` using the match compiler does not have the
     def-eqs we expect. Thus, we directly use the recursion principle. -/
  Com.rec
    (motive_1 := fun _ _ _ _ => PUnit)
    (motive_2 := fun _ eff' t' c =>
      (h₁ : eff = eff') → (h₂ : t = t') → motive (h₁ ▸ h₂ ▸ c))
    (motive_3 := fun _ _ => PUnit)
    (fun _ _ _ _ _ _ => ⟨⟩) -- `Expr.mk` case
    (fun v h₁ h₂ => -- `Com.rets` case
      cast (by subst h₁ h₂; rfl) <| rets (h₂ ▸ v))
    (fun e' body' _ r' h₁ h₂ => -- `Com.var` case
      let e := h₁ ▸ e'
      let body : Com _ _ eff t := cast (by simp_all) body'
      let r : motive body := cast (by subst h₁ h₂; rfl) (r' h₁ h₂)
      cast (by subst h₁ h₂; rfl) <| var e body r)
    ⟨⟩
    (fun _ _ _ _ => ⟨⟩)
    com
    rfl
    rfl

variable {rets} {var} {Γ : Ctxt _}

@[simp] lemma Com.rec'_rets (v : HVector Γ.Var t) :
    (Com.rets (d:=d) (eff := eff) v).rec' (motive:=motive) rets var = rets v :=
  rfl

@[simp] lemma Com.rec'_var (e : Expr d Γ eff u) (body : Com d _ _ t) :
    (Com.var e body).rec' (motive:=motive) rets var
    = var e body (body.rec' (motive:=motive) rets var) :=
  rfl

omit rets var in
theorem Com.recAux'_eq :
    Com.recAux' (motive:=motive) = Com.rec' (motive:=motive) := by
  funext rets var Γ com
  induction com <;> simp [recAux', *]

end Rec

def Expr.op {Γ : Ctxt d.Ty} {eff : EffectKind} {ty} (e : Expr d Γ eff ty) : d.Op :=
  Expr.casesOn e (fun op _ _ _ _ => op)

theorem Expr.eff_le {Γ : Ctxt d.Ty} {ty} (e : Expr d Γ eff ty) :
  DialectSignature.effectKind e.op ≤ eff :=
  Expr.casesOn e (fun _ _ eff_le _ _ => eff_le)

theorem Expr.ty_eq {Γ : Ctxt d.Ty} {tys : List d.Ty} (e : Expr d Γ eff tys) :
    tys = DialectSignature.returnTypes e.op :=
  Expr.casesOn e (fun _ ty_eq _ _ _ => ty_eq)

def Expr.args {Γ ts} (e : Expr d Γ eff ts) :
    HVector (Var Γ) (DialectSignature.sig e.op) :=
  Expr.casesOn e (fun _ _ _ args _ => args)

def Expr.regArgs {Γ ts} (e : Expr d Γ eff ts) :
    Regions d (DialectSignature.regSig e.op) :=
  Expr.casesOn e (fun _ _ _ _ regArgs => regArgs)

-- TODO: I don't think `returnVar` is used, remove it
/-- `e.returnVar` is the variable in `e.outContext` which is bound by `e`. -/
def Expr.returnVar (e : Expr d Γ eff [ty]) : e.outContext.Var ty :=
  Var.last _ _

/-- `e.returnVars` is the vector of variables in `e.outContext` which are bound by `e`. -/
def Expr.returnVars (e : Expr d Γ eff tys) : HVector e.outContext.Var tys :=
  .ofFn _ _ <| fun i => (Var.ofFin i).appendInr

/-! Projection equations for `Expr` -/
@[simp]
theorem Expr.op_mk {Γ : Ctxt d.Ty} {ty} {eff : EffectKind} (op : d.Op)
    (ty_eq : ty = DialectSignature.returnTypes op)
    (eff_le : DialectSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) (DialectSignature.sig op))
    (regArgs) :
    (Expr.mk op ty_eq eff_le args regArgs).op = op := rfl

@[simp]
theorem Expr.args_mk {Γ : Ctxt d.Ty} {ty eff op}
    (ty_eq : ty = DialectSignature.returnTypes op)
    (eff_le : DialectSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) (DialectSignature.sig op)) (regArgs) :
    (Expr.mk op ty_eq eff_le args regArgs).args = args := rfl

@[simp]
theorem Expr.regArgs_mk {Γ : Ctxt d.Ty} {ty eff op}
    (ty_eq : ty = DialectSignature.returnTypes op)
    (eff_le : DialectSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) (DialectSignature.sig op)) (regArgs) :
    (Expr.mk op ty_eq eff_le args regArgs).regArgs = regArgs := rfl

/-!
### `size`
-/

/-- The size of a `Com` is given by the number of let-bindings it contains -/
def Com.size : Com d Γ eff t → Nat :=
  Com.rec'
    /- rets _ -/       (fun _ => 0)
    /- var _ body -/ (fun _ _body bodySize => bodySize + 1)

@[simp, grind=] def Expr.bvars (e : Expr d Γ eff Δ) : Nat :=
  (DialectSignature.returnTypes e.op).length

/-- The number of variables bound in a `Com`. This is related to the `size`, but
will differ in the presence of let-bindings with multiple return variables.

NOTE: this ignores any regions. -/
def Com.bvars : Com d Γ eff t → Nat :=
  Com.rec'
    /- rets _ -/      (fun _ => 0)
    /- var e body -/ (fun e _body bodySize => e.bvars + bodySize)

section Lemmas
namespace Com

@[simp] lemma size_rets  : (rets v : Com d Γ eff t).size = 0 := rfl
@[simp] lemma size_var : (var e body : Com d Γ eff t).size = body.size + 1 := rfl

@[simp] lemma bvars_rets  : (rets v : Com d Γ eff t).bvars = 0 := rfl
@[simp] lemma bvars_var  :
  (var e body : Com d Γ eff t).bvars = e.bvars + body.bvars := rfl

end Com

@[simp] lemma Ctxt.get_add_bvars (e : Expr d Γ eff ts) (i : Nat) :
    e.outContext[i + e.bvars]? = Γ[i]? := by
  rcases e with ⟨op, rfl, _, _⟩
  rcases Γ
  simp only [ofList_append, Expr.bvars, Expr.op_mk, getElem?_ofList]
  rw [List.getElem?_append_right (by simp)]
  grind

end Lemmas

/-!
### `Com` Output context and return variables
-/

/-- The `outContext` of a program is a context which includes variables for all let-bindings
of the program. That is, it is the context under which the return value is typed -/
def Com.outContext {Γ} : Com d Γ eff ts → Ctxt d.Ty :=
  Com.rec' (motive := fun _ => Ctxt d.Ty)
    (@fun Γ _ => Γ) -- `Com.rets` case
    (fun _ _ r => r) -- `Com.var` case

/-- The difference between the context `Γ` under which `com` is typed, and the output context of
that same `com` -/
def Com.outContextDiff (com : Com d Γ eff ts) : Γ.Diff com.outContext :=
  ⟨com.bvars, by
    intro i t h;
    unfold outContext
    induction com generalizing i
    case rets => exact h
    case var e _ ih =>
      simp only [rec'_var, bvars_var]
      rw [← Nat.add_assoc]
      apply ih
      rw [Ctxt.get_add_bvars e, h]⟩

/-- `com.outContextHom` is the canonical homorphism from free variables of `com` to those same
variables in the output context of `com` -/
def Com.outContextHom (com : Com d Γ eff t) : Γ.Hom com.outContext :=
  com.outContextDiff.toHom

/-- The return variables of a program -/
def Com.returnVars : (com : Com d Γ eff ts) → HVector (Var com.outContext) ts
  | .rets vs => vs
  | .var _ body => body.returnVars

/-- The return variable of a program with exactly one return. -/
def Com.returnVar (com : Com d Γ eff [t]) : Var com.outContext t :=
  com.returnVars.get (0 : Fin 1)

abbrev Expr.contextHom (e : Expr d Γ eff ts) : Γ.Hom e.outContext :=
  Hom.id.appendCodomain

section Lemmas

@[simp] lemma Com.outContext_rets (vs : HVector Γ.Var t) : (rets vs : Com d Γ eff t).outContext = Γ := rfl
@[simp] lemma Com.outContext_var {eff} (e : Expr d Γ eff t) (body : Com d e.outContext eff u) :
    (Com.var e body).outContext = body.outContext := rfl

@[simp] lemma Com.outContextHom_rets (v : HVector Γ.Var t) :
    (rets v : Com d Γ eff t).outContextHom = Ctxt.Hom.id := rfl
@[simp] lemma Com.outContextHom_var :
    (var e body : Com d Γ eff t).outContextHom
    = e.contextHom.comp body.outContextHom := by
  funext t v
  apply Subtype.eq
  simp [outContextHom, outContextDiff, Expr.contextHom, Ctxt.Hom.comp, Expr.bvars,
    e.ty_eq]
  omega

@[simp] lemma Com.returnVars_rets : returnVars (rets vs : Com d Γ eff t) = vs := rfl
@[simp] lemma Com.returnVars_var :
    returnVars (var (d:=d) (eff:=eff) e body) = body.returnVars := rfl

@[simp] lemma Com.returnVar_rets :
    returnVar (rets v : Com d Γ eff [t]) = v.get (0 : Fin 1) := rfl
@[simp] lemma Com.returnVar_var :
    returnVar (var (d:=d) (eff:=eff) e body) = body.returnVar := rfl

end Lemmas

/-!
## `denote`
Denote expressions, programs, and sequences of lets
-/
variable [TyDenote d.Ty] [DialectDenote d] [DecidableEq d.Ty] [Monad d.m] [LawfulMonad d.m]

mutual

def HVector.denote :
    {l : RegionSignature d.Ty} → (T : HVector (fun t => Com d t.1 .impure t.2) l) →
    HVector (fun t => t.1.Valuation → EffectKind.impure.toMonad d.m (HVector toType t.2)) l
  | _, .nil => HVector.nil
  | _, .cons v vs => HVector.cons (v.denote) (HVector.denote vs)

def Expr.denote {ty} (e : Expr d Γ eff ty) (V : Valuation Γ) :
    eff.toMonad d.m (e.outContext.Valuation) :=
  match e with
  | ⟨op, ty_eq, heff, args, regArgs⟩ => do
      let argsDenote := args.map V
      let val ← EffectKind.liftEffect heff <| DialectDenote.denote op argsDenote regArgs.denote
      return (V ++ val).cast (by rw [← ty_eq])

def Com.denote : Com d Γ eff ty → (Γv : Valuation Γ) →
    eff.toMonad d.m (HVector toType ty)
  | .rets vs, Γv     => pure (vs.map Γv)
  | .var e body, V => e.denote V >>= body.denote
end

/-- Denote just the let bindings of `com`, transforming a valuation for `Γ` into a valuation for
the output context of `com` -/
def Com.denoteLets : (com : Com d Γ eff ty) → (Γv : Valuation Γ) →
    eff.toMonad d.m (com.outContext.Valuation)
  | .rets _, V => pure V
  | .var e body, V =>
      e.denote V >>= body.denoteLets >>= fun V =>
        return V.cast (by simp [Com.outContext])

def Lets.denote [DialectSignature d] [DialectDenote d] {Γ₂}
    (lets : Lets d Γ₁ eff Γ₂) (V : Valuation Γ₁) : (eff.toMonad d.m <| Valuation Γ₂) :=
  match lets with
  | .nil          => return V
  | .var lets' e  => lets'.denote V >>= e.denote

section Unfoldings

open EffectKind (liftEffect)

omit [LawfulMonad d.m] in
/-- Returns only the result of the current expression. -/
def Expr.denoteOp (e : Expr d Γ eff ty) (V : Γ.Valuation) :
    eff.toMonad d.m (HVector toType ty) :=
  EffectKind.liftEffect e.eff_le <| cast (by rw [← e.ty_eq]) <|
    DialectDenote.denote e.op (e.args.map V) e.regArgs.denote

omit [LawfulMonad d.m] in
/--
Unfold `Expr.denote` in terms of the field projections and `Expr.denoteOp`.

NOTE: this allows the unfolding of `Expr.denote` applied to arbitrary expressions,
whereas the built-in unfold lemma only applies when the argument is an application of
`Expr.mk`.

Unfortunately, if we define `Expr.denote` in terms of the projections directly,
the termination checker fails to prove termination. Hence, this workaround.
-/
theorem Expr.denote_unfold (e : Expr d Γ eff ty) :
    e.denote = fun V => (V ++ ·) <$> (e.denoteOp V) := by
  rcases e with ⟨op, rfl, _⟩
  simp [denote, denoteOp]

@[simp] lemma Expr.denoteOp_eq_denoteOp_of {e₁ : Expr d Γ eff ty} {e₂ : Expr d Δ eff ty}
    {Γv : Valuation Γ} {Δv : Valuation Δ}
    (op_eq : e₁.op = e₂.op)
    (h_args : HVector.map Γv (op_eq ▸ e₁.args)
              = HVector.map Δv e₂.args)
    (h_regArgs : HEq e₁.regArgs.denote e₂.regArgs.denote) :
    e₁.denoteOp Γv = e₂.denoteOp Δv := by
  rcases e₁ with ⟨op₁, rfl, _, args₁, regArgs₁⟩
  rcases e₂ with ⟨op₂, _, _, args₂, _⟩
  obtain rfl : op₁ = op₂ := op_eq
  simp_all [op_mk, regArgs_mk, heq_eq_eq, args_mk, denoteOp]

/-
https://leanprover.zulipchat.com/#narrow/stream/270676-lean4/topic/Equational.20Lemmas
Recall that `simp` lazily generates equation lemmas.
Moreover, recall that `simp only` **does not** generate equation lemmas.
*but* if equation lemmas are present, then `simp only` *uses* the equation lemmas.

Hence, we build the equation lemmas by invoking the correct Lean meta magic,
so that `simp only` (which we use in `simp_peephole`) can find them!

This allows `simp only [HVector.denote]` to correctly simplify `HVector.denote`
args, since there now are equation lemmas for it.
-/
/--
info: some #[`HVector.denote.eq_1, `HVector.denote.eq_2]
-/
#guard_msgs in #eval Lean.Meta.getEqnsFor? ``HVector.denote
/--
info: some #[`Expr.denote.eq_1]
-/
#guard_msgs in #eval Lean.Meta.getEqnsFor? ``Expr.denote
/--
info: some #[`Com.denote.eq_1, `Com.denote.eq_2]
-/
#guard_msgs in #eval Lean.Meta.getEqnsFor? ``Com.denote

end Unfoldings

/-! ### Pure Denote -/

/-- `denotePure` is a specialization of `denote` for pure `Lets`.
Theorems and definitions should always be phrased in terms of the latter.

However, `denotePure` behaves slighly better when it comes to congruences, since `congr` does not
realize that `pure.toMonad d.m (Valuation _)` is just `Valuation _`, and thus a function.
Therefore, if a goalstate is `⊢ lets.denote ... = lets.denote ...`, and `lets` is pure, then to use
the congruence, you can do: `rw [← Lets.denotePure]; congr`
-/
@[simp] abbrev Lets.denotePure [DialectSignature d] [DialectDenote d] :
    Lets d Γ₁ .pure Γ₂ → Valuation Γ₁ → Valuation Γ₂ := Lets.denote

/-- Alias of `denoteOp` for pure expressions. -/
@[simp] abbrev Expr.pdenoteOp :
    Expr d Γ .pure ty → Γ.Valuation → (HVector toType ty) :=
  Expr.denoteOp

/-- Alias of `denoteOp` for pure expressions. -/
@[simp] abbrev Com.pdenote :
    Com d Γ .pure ty → Γ.Valuation → (HVector toType ty) :=
  Com.denote

/-! ### simp-lemmas about `denote` functions -/
section Lemmas

@[simp] lemma Expr.comap_denote_snocRight (e : Expr d Γ .pure ty) (V : Γ.Valuation) :
    (Valuation.comap (e.denote V) e.contextHom) = V := by
  funext t v; simp [Expr.denote_unfold, Id.map_eq']

@[simp] lemma HVector.denote_nil
    (T : HVector (fun (t : Ctxt d.Ty × List d.Ty) => Com d t.1 .impure t.2) []) :
    HVector.denote T = HVector.nil := by
  cases T; rfl

@[simp] lemma HVector.denote_cons
    {t : _ × _} {ts : RegionSignature _}
    (a : Com d t.1 .impure t.2) (as : Regions _ ts) :
    HVector.denote (.cons a as) = .cons (a.denote) (as.denote) :=
  rfl

@[simp] lemma Com.denote_rets {eff : EffectKind} (Γ : Ctxt d.Ty) (vs : HVector Γ.Var ts) :
    (Com.rets (eff := eff) vs).denote = fun V => pure (vs.map V) :=
  rfl

@[simp] lemma Com.denote_var [LawfulMonad d.m] {e : Expr d Γ eff α} :
    (Com.var e body).denote =
    fun Γv => (e.denote Γv) >>= body.denote := by
  cases eff <;> rfl

@[simp] lemma Com.denoteLets_var (e : Expr d Γ eff t) (body : Com d _ eff u) [LawfulMonad d.m] :
    (Com.var e body).denoteLets =
        fun V => e.denote V >>= body.denoteLets := by
  cases eff
  · rfl
  · simp [denoteLets, bind_pure]

@[simp] lemma Lets.denote_nil {Γ : Ctxt d.Ty} :
    (Lets.nil : Lets d Γ eff Γ).denote = (return ·) := by
  funext; simp [denote]

@[simp] lemma Lets.denote_var {lets : Lets d Γ_in eff Γ_out} {e : Expr d Γ_out eff t} :
    (lets.var e).denote = fun V_in => lets.denote V_in >>= e.denote :=
  rfl

end Lemmas

/-!
## `changeVars`
Map a context homomorphism over a `Expr`/`Com`.
That is, substitute variables.
-/

def Expr.changeVars (varsMap : Γ.Hom Γ') {ty} (e : Expr d Γ eff ty) :
    Expr d Γ' eff ty :=
  ⟨e.op, e.ty_eq, e.eff_le, e.args.map varsMap, e.regArgs⟩

def Com.changeVars : Com d Γ eff ty →
    (varsMap : Γ.Hom Γ') →
    Com d Γ' eff ty
  |  .rets e => fun varsMap => .rets (e.map varsMap)
  |  .var e body => fun varsMap => .var (e.changeVars varsMap)
      (body.changeVars (fun _ v => varsMap.append v))

/-! simp-lemmas about `changeVars`-/
section Lemmas
variable {Γ Γ' : Ctxt d.Ty} {t} (f : Γ.Hom Γ') (e : Expr d Γ eff t) (V : Γ'.Valuation)

@[simp] lemma op_changeVars : (e.changeVars f).op = e.op := rfl
@[simp] lemma regArgs_changeVars : (e.changeVars f).regArgs = e.regArgs := rfl
@[simp] lemma args_changeVars : (e.changeVars f).args = e.args.map f := rfl

@[simp] lemma Expr.denoteOp_changeVars  :
    (e.changeVars f).denoteOp V = e.denoteOp (V.comap f) := by
  simp [denoteOp, HVector.map_map]; rfl

@[simp] lemma Expr.denote_changeVars {Γ Γ' : Ctxt d.Ty}
    (varsMap : Γ.Hom Γ')
    (e : Expr d Γ eff Δ)
    (V : Γ'.Valuation)
    (f : e.outContext.Valuation → eff.toMonad d.m α) :
    (Expr.changeVars varsMap e).denote V
      >>= (f <| Valuation.comap · varsMap.append)
    = e.denote (V.comap varsMap) >>= f := by
  simp [denote_unfold]

end Lemmas

@[simp] lemma Com.changeVars_rets :
    (Com.rets (d:=d) (Γ:=Γ) (eff := eff) vs).changeVars
    = fun (map : Γ.Hom Δ) => Com.rets (vs.map map) := by
  funext map
  simp [changeVars]

@[simp] lemma Com.changeVars_var (e : Expr d Γ eff t) (body : Com d _ eff u) :
    (Com.var e body).changeVars
    = fun (map : Γ.Hom Δ) => Com.var (e.changeVars map) (body.changeVars map.append) := by
  simp [changeVars]

-- TODO: this is implied by simpler simp-lemmas, do we need it?
@[simp] lemma Com.outContext_changeVars_rets (varsMap : Γ.Hom Γ') (_ : Com d Γ eff ty) :
  ((Com.rets (d:=d) (eff := eff) v).changeVars varsMap).outContext = Γ' := by simp

@[simp] lemma Com.denote_changeVars
    (varsMap : Γ.Hom Γ') (c : Com d Γ eff ty) :
    (c.changeVars varsMap).denote =
    fun V => c.denote (V.comap varsMap) := by
  induction c using Com.rec' generalizing Γ' with
  | rets x      => simp [HVector.map_map]; rfl
  | var _ _ ih => simp [denote, ih]

@[simp] lemma Com.denote_changeVars' (varsMap : Γ.Hom Γ') (c : Com d Γ eff ty) :
    (c.changeVars varsMap).denote = fun V => c.denote (V.comap varsMap) := by
  simp

@[simp] def Com.outContext_changeVars_hom {map : Γ.Hom Δ} (map_inv : Δ.Hom Γ) :
    {c : Com d Γ eff ty} → Ctxt.Hom (outContext (changeVars c map)) (outContext c)
  | .rets _        => cast (by simp) map_inv
  | .var _ body  => cast (by simp) <|
      Com.outContext_changeVars_hom (map := map.append) map_inv.append (c := body)

@[simp] lemma Com.denoteLets_returnVars (c : Com d Γ .pure tys) (V : Valuation Γ) :
    c.returnVars.map (c.denoteLets V) = c.denote V := by
  induction c using Com.rec'
  case rets v  => rfl
  case var ih => simp [denoteLets, Id.pure_eq', Id.bind_eq', ih, denote]

@[simp] lemma Expr.changeVars_changeVars (e : Expr d Γ eff ty) (f : Γ.Hom Δ) (g : Δ.Hom Ξ) :
    (e.changeVars f).changeVars g = e.changeVars (f.comp g) := by
  simp [changeVars, HVector.map_map]; rfl

/-! ### ChangeVars & Specific Morphisms -/

lemma Expr.changeVars_castCodomain (e : Expr d Γ eff t)
    (f : Hom Γ Δ) (h : Δ = Δ') :
    e.changeVars (f.castCodomain h) = cast (by simp [h]) (e.changeVars f) := by
  subst h; rfl

@[simp] lemma HVector.changeVars_id {Γ : Ctxt d.Ty} (vs : HVector Γ.Var ts) :
    vs.map Hom.id = vs := by
  induction vs <;> simp [map, *]

@[simp] lemma Expr.changeVars_id (e : Expr d Γ eff t) :
    e.changeVars .id = e := by
  cases e; simp [changeVars]

@[simp] lemma Com.changeVars_id (c : Com d Γ eff t) :
    c.changeVars .id = c := by
  induction c
  · simp
  · simpa

/-!
## FlatCom
An alternative representation of a program as a `Lets` with a return `Var`
-/

/-- `FlatCom Γ eff Δ ty` represents a program as a sequence `Lets Γ eff Δ` and a `Var Δ ty`.
This is isomorphic to `Com Γ eff ty`, where `Δ` is `com.outContext` -/
structure FlatCom (d : Dialect) [DialectSignature d]  (Γ_in : Ctxt d.Ty) (eff : EffectKind)
    (Γ_out : Ctxt d.Ty) (ts : List d.Ty) where
  lets : Lets d Γ_in eff Γ_out
  rets : HVector Γ_out.Var ts

--TODO: should this be a `@[simp] abbrev`, or just nuked altogether?
/-- Denote the Lets of the FlatICom -/
def FlatCom.denoteLets (flatCom : FlatCom d Γ eff Γ_out t) (Γv : Γ.Valuation) :
    eff.toMonad d.m <| Γ_out.Valuation :=
  flatCom.lets.denote Γv

/-- Denote the lets and the rets of the FlatCom. This is equal to denoting the Com -/
@[simp] abbrev FlatCom.denote [DialectDenote d]
    (flatCom : FlatCom d Γ eff Γ_out ts)
    (V : Γ.Valuation) : eff.toMonad d.m (HVector toType ts) :=
  flatCom.lets.denote V >>= (return flatCom.rets.map ·)

theorem FlatCom.denoteLets_eq [DialectDenote d] (flatCom : FlatCom d Γ eff Γ_out t) :
    flatCom.denoteLets = fun Γv => flatCom.lets.denote Γv := by
  funext Γv
  simp [denoteLets]

-- theorem FlatCom.denote_eq [DialectDenote d] (flatCom : FlatCom d Γ eff Γ_out ts) :
--     flatCom.denote = fun Γv => flatCom.lets.denote Γv >>= fun Γ'v => return (Γ'v flatCom.rets) := by
--   funext Γv
--   simp [denote]

/-!
## casting of expressions and purity
-/
--TODO: organize this, this seems like it should be somewhere else

/-! ### `castPureToEff` -/

/-- Change the effect of an expression into another effect that is "higher" in the hierarchy.
Generally used to change a pure expression into an impure one, but it is useful to have this
phrased more generically -/
def Expr.changeEffect {eff₁ eff₂ : EffectKind} (h : eff₁ ≤ eff₂) :
    Expr d Γ eff₁ t → Expr d Γ eff₂ t
  | Expr.mk op ty_eq eff_le args regArgs =>
    have heff : DialectSignature.effectKind op ≤ eff₂ := by
      apply EffectKind.le_trans eff_le h
    Expr.mk op ty_eq heff args regArgs

/-- Change the effect of a program into another effect that is "higher" in the hierarchy.
Generally used to change a pure program into an impure one, but it is useful to have this
phrased more generically -/
def Com.changeEffect {eff₁ eff₂ : EffectKind} (h : eff₁ ≤ eff₂) :
    Com d Γ eff₁ t → Com d Γ eff₂ t := fun com =>
  Com.rec' (motive := @fun Γ _ => eff₁ ≤ eff₂ → Com d Γ eff₂ t)
    /- rets v -/       (fun v _h               => rets v)
    /- var e body -/ (fun e _body castBody h => var (e.changeEffect h) (castBody h))
    com h

/-- Change the effect of a sequence of lets into another effect that is "higher" in the hierarchy.
Generally used to change pure into impure, but it is useful to have this phrased more generically -/
def Lets.changeEffect {eff₁ eff₂ : EffectKind} (h : eff₁ ≤ eff₂) :
    Lets d Γ_in eff₁ Γ_out → Lets d Γ_in eff₂ Γ_out
  | .nil => .nil
  | .var body e => .var (body.changeEffect h) (e.changeEffect h)

/-- cast a pure Expr into a possibly impure expression -/
def Expr.castPureToEff (eff : EffectKind) : Expr d Γ .pure t → Expr d Γ eff t :=
  changeEffect (EffectKind.pure_le eff)

def Com.castPureToEff (eff : EffectKind) : Com d Γ .pure t → Com d Γ eff t :=
  changeEffect (EffectKind.pure_le eff)

def Lets.castPureToEff (eff : EffectKind) : Lets d Γ_in .pure Γ_out → Lets d Γ_in eff Γ_out
  | .nil => .nil
  | .var body e => .var (body.castPureToEff eff) (e.castPureToEff eff)
/-
NOTE: `Lets.castPureToEff` seems like it could easily be defined in terms of `Lets.changeEffect`,
but for some reason doing so causes `Lets.castPureToEff_var` to no longer be def-eq (i.e.,
  it is no longer provable by `rfl`) -/


/-- A wrapper around `Com.var` that allows for a pure expression to be added to an otherwise
impure program, using `Expr.castPureToEff` -/
def Com.letPure (e : Expr d Γ .pure t) (body : Com d (e.outContext) eff u) : Com d Γ eff u :=
  body.var (e.castPureToEff eff)

/-- `letSup e body` allows us to combine an expression and body with different effects,
by returning a `Com` whose effect is their join/supremum -/
def Com.letSup (e : Expr d Γ eff₁ t) (body : Com d (e.outContext) eff₂ u) :
    Com d Γ (eff₁ ⊔ eff₂) u :=
  Com.var (e.changeEffect <| by simp) (body.changeEffect <| by simp)

section Lemmas

@[simp] lemma Expr.op_castPureToEff (e : Expr d Γ .pure t) : (e.castPureToEff eff).op = e.op := by
  cases e; cases eff <;> rfl
@[simp] lemma Expr.args_castPureToEff (e : Expr d Γ .pure t) :
    (e.castPureToEff eff).args = cast (by simp) e.args := by
  cases e; cases eff <;> rfl

@[simp] lemma Com.castPureToEff_rets : (rets v : Com d Γ .pure ty).castPureToEff eff = rets v := rfl
@[simp] lemma Com.castPureToEff_var {com : Com d _ .pure ty} {e : Expr d Γ _ eTy} :
    (var e com).castPureToEff eff = var (e.castPureToEff eff) (com.castPureToEff eff) := rfl

@[simp] lemma Lets.castPureToEff_nil : (nil : Lets d Γ_in _ _).castPureToEff eff = nil := rfl
@[simp] lemma Lets.castPureToEff_var {lets : Lets d Γ_in .pure Γ_out}
    {e : Expr d Γ_out .pure eTy} :
    (var lets e).castPureToEff eff = var (lets.castPureToEff eff) (e.castPureToEff eff) :=
  rfl

@[simp] lemma Com.outContext_castPureToEff {com : Com d Γ .pure ty} :
    (com.castPureToEff eff).outContext = com.outContext := by
  induction com <;> simp [*]

/-- `castPureToEff` does not change the size of a `Com` -/
@[simp] lemma Com.size_castPureToEff {com : Com d Γ .pure ty} :
    (com.castPureToEff eff).size = com.size := by
  induction com <;> simp [*]

/-- `castPureToEff` does not change the number of bvars of a `Com` -/
@[simp] lemma Com.bvars_castPureToEff {com : Com d Γ .pure ty} :
    (com.castPureToEff eff).bvars = com.bvars := by
  induction com <;> simp [*]

@[simp] lemma Com.returnVars_castPureToEff (eff : _) (com : Com d Γ .pure tys) :
    (com.castPureToEff eff).returnVars = com.returnVars.map (fun _ v => v.castCtxt (by simp)) := by
  induction com <;> simp_all

@[simp] lemma Com.returnVar_castPureToEff {com : Com d Γ .pure [ty]} :
    (com.castPureToEff eff).returnVar = com.returnVar.castCtxt (by simp) := by
  simp [returnVar]

/-! denotations of `castPureToEff` -/

@[simp] lemma Expr.denote_castPureToEff {e : Expr d Γ .pure t} :
    denote (e.castPureToEff eff) = fun V => pure (e.denote V) := by
  rcases e with ⟨op, rfl, eff_le, _, _⟩
  cases eff
  case pure => rfl
  case impure =>
    funext V
    simp only [castPureToEff, changeEffect, denote_unfold, denoteOp, op_mk, args_mk, regArgs_mk,
      EffectKind.pure_map, EffectKind.pure_liftEffect]

@[simp] lemma Com.denote_castPureToEff {com : Com d Γ .pure ty} :
    denote (com.castPureToEff eff) = fun V => pure (com.denote V) := by
  funext V
  induction com using Com.rec'
  · rfl
  · simp [*]; rfl

end Lemmas

/-! ### `Expr.HasPureOp` and `Expr.toPure?` -/
/-- Whether the operation of an expression is pure (which might be evaluated impurely) -/
def Expr.HasPureOp (e : Expr d Γ eff ty) : Prop :=
  DialectSignature.effectKind e.op = .pure

/-- `e.HasPureOp` is decidable -/
instance (e : Expr d Γ eff t) : Decidable (e.HasPureOp) := inferInstanceAs (Decidable <| _ = _)

@[simp] lemma Expr.castPureToEff_pure_eq (e : Expr d Γ .pure t) : e.castPureToEff .pure = e := by
  cases e; simp [castPureToEff, changeEffect]

/-- Convert an arbitrary expression into a statically known
pure expression, given a proof of purity. -/
def Expr.toPure (e : Expr d Γ eff ty) (h : e.HasPureOp) : Expr d Γ .pure ty :=
  ⟨e.op, e.ty_eq, EffectKind.le_of_eq h, e.args, e.regArgs⟩

/-- Attempt to convert a possibly impure expression into a pure expression.
If the expression's operation is impure, return `none` -/
def Expr.toPure? (e : Expr d Γ eff ty) : Option (Expr d Γ .pure ty) :=
  if h : e.HasPureOp then
    some <| e.toPure h
  else
    none

/-- The operation of a pure expression is necessarily pure -/
theorem Expr.HasPureOp_of_pure : (e : Expr d Γ .pure t) → e.HasPureOp
  | ⟨_, _, eff_le, _, _⟩ => EffectKind.eq_of_le_pure eff_le

section toPureLemmas
variable {Γ eff ty} {e : Expr d Γ eff ty} (h : e.HasPureOp)

@[simp] lemma Expr.op_toPure       : (e.toPure h).op = e.op := rfl
@[simp] lemma Expr.args_toPure     : (e.toPure h).args = e.args := rfl
@[simp] lemma Expr.regArgs_toPure  : (e.toPure h).regArgs = e.regArgs := rfl

end toPureLemmas

theorem Expr.denote_pure {e : Expr d Γ .pure ty} :
    e.denote = fun (V : Valuation Γ) =>
      return ((V ++ · : HVector _ _ → _) <| e.denoteOp V) := by
  funext V t v
  simp [denote_unfold]; rfl

@[simp]
theorem Expr.pure_denoteOp_toPure (e : Expr d Γ eff ty) (h : e.HasPureOp) :
    pure ((e.toPure h).denoteOp V) = (e.denoteOp V) := by
  simp [denoteOp]

/-- The denotation of toPure? -/
theorem Expr.denote_toPure? {e : Expr d Γ eff ty} {e': Expr d Γ .pure ty}
    (he : Expr.toPure? e = some e') : e.denote = fun V => pure (e'.denote V) := by
  funext V
  obtain ⟨h_pure, rfl⟩ : ∃ (h : e.HasPureOp), e.toPure h = e' := by
    simpa [toPure?] using he
  rw [denote_pure, EffectKind.pure_pure, ← map_pure, Expr.pure_denoteOp_toPure, denote_unfold]

/-!
### Semantic preservation of `Zipper.insertPureCom`
Generally, we don't intend for `insertPureCom` to change the semantics of the zipper'd program.
We characterize the condition for this intended property by proving `denote_insertPureCom_eq_of`,
which states that if the reassigned variable `v` in the original `top` of the zipper is semantically
equivalent to the return value of the inserted program `newCom`, then the denotation of the zipper
after insertion agrees with the original zipper. -/
section DenoteInsert

@[simp] lemma Expr.denote_appendInl (e : Expr d Γ .pure t) (V : Γ.Valuation) (v : Γ.Var u) :
    e.denote V v.appendInl = V v := by
  simp [denote_unfold, Id.map_eq']

/-- Denoting any of the free variables of a program through `Com.denoteLets` just returns the
assignment of that variable in the input valuation -/
@[simp] lemma Com.denoteLets_outContextHom (com : Com d Γ .pure ty) (V : Valuation Γ)
    {vTy} (v : Var Γ vTy) :
    com.denoteLets V (com.outContextHom v) = V v := by
  induction com using Com.rec'
  · simp; rfl
  case var e body ih =>
    rw [outContextHom_var]
    simp [Id.bind_eq', Hom.comp, ih]

@[simp] lemma Ctxt.Valuation.comap_outContextHom_denoteLets {com : Com d Γ .pure ty} {V} :
    Valuation.comap (com.denoteLets V) com.outContextHom = V := by
  unfold comap; simp

-- TODO: This theorem is currently not used yet. The hope is that it might replace/simplify the
--       subtype reasoning (`denoteIntoSubtype`) currently used when reasoning about `matchVar`
-- theorem Zipper.denote_insertPureCom_eq_of {zip : Zipper d Γ_in eff Γ_mid ty₁}
--     {newCom : Com d _ _ newTy} {V_in : Valuation Γ_in} [LawfulMonad d.m]
--     (h : ∀ V_mid ∈ Functor.supp (zip.top.denote V_in),
--             newCom.denote V_mid = V_mid v) :
--     (zip.insertPureCom v newCom).denote V_in = zip.denote V_in := by
--   rcases zip with ⟨lets, com⟩
--   simp only [denote_insertPureCom, Valuation.comap_with,
--   Valuation.comap_outContextHom_denoteLets, Com.denoteLets_returnVar_pure,
--   denote_mk]
--   unfold Valuation.reassignVar
--   congr; funext V_mid; congr
--   funext t' v'
--   simp only [dite_eq_right_iff, forall_exists_index]
--   rintro rfl rfl
--   simpa using h _ (sorry : V_mid ∈ Functor.supp (lets.denote V_in))

end DenoteInsert

/-!
### Inserting multiple programs with `Zipper.foldInsert`
-/

-- def Zipper.foldInsert

/-!
## Random Access for `Lets`
Get the let-binding that correponds to a given variable `v`,
so long as the binding's operation is pure
-/

/-- Get the `Expr` that a var `v` is assigned to in a sequence of `Lets`,
without adjusting variables, assuming that this expression has a pure operation.
If the expression has an impure operation, or there is no binding corresponding to `v`
(i.e., `v` comes from `Γ_in`), return `none` -/
def Lets.getPureExprAux {Γ₁ Γ₂ : Ctxt d.Ty} {t} : Lets d Γ₁ eff Γ₂ → (v : Var Γ₂ t) →
    Option (Σ ts, (Var ⟨ts⟩ t) × Expr d (Γ₂.dropUntil v) .pure ts)
  | .nil, _ => none
  | .var (Γ_out := Γ_out) (t := t) lets e, v => by
    cases v using Var.appendCases with
    | left v =>
        apply cast ?_ <| Lets.getPureExprAux lets v
        simp
    | right v =>
        have h : Γ_out ++ (t.drop <| v.1 + 1) = e.outContext.dropUntil v.appendInr := by simp
        let f := Hom.castCodomain h <| .appendCodomain .id
        exact e.toPure?.map (fun e => ⟨_, v, e.changeVars f⟩)

/-- Get the `Expr` that a var `v` is assigned to in a sequence of `Lets`.
The variables are adjusted so that they are variables in the output context of a lets,
not the local context where the variable appears. -/
def Lets.getPureExpr {Γ₁ Γ₂ : Ctxt d.Ty} (lets : Lets d Γ₁ eff Γ₂) {t : d.Ty} (v : Var Γ₂ t) :
    Option (Σ ts, (Var ⟨ts⟩ t) × Expr d Γ₂ .pure ts) :=
  (getPureExprAux lets v).map fun ⟨_, v, e⟩ =>
    ⟨_, v, e.changeVars Ctxt.dropUntilHom⟩

@[simp] lemma Lets.getPureExpr_nil : getPureExpr (.nil : Lets d Γ eff Γ) v = none := rfl

@[simp] lemma Lets.getPureExpr_var_appendInr (lets : Lets d Γ_in eff Γ_out)
    (e : Expr d Γ_out eff ty) (v : Var ⟨ty⟩ u) :
    getPureExpr (lets.var e) v.appendInr
    = e.toPure?.map (fun e => ⟨_, v, e.changeVars <| e.contextHom⟩) := by
  simp only [getPureExpr, getPureExprAux, Ctxt.getElem?_ofList, Var.appendCases_appendInr,
    Option.map_map]
  congr 1
  funext e
  simp only [Expr.changeVars_changeVars, Function.comp]
  congr 3
  funext _ v'
  apply Subtype.eq
  have := v.val_lt
  simp; grind

-- TODO: not sure if we actually need this, if not drop it
@[simp] lemma Lets.getPureExpr_var_last (lets : Lets d Γ_in eff Γ_out)
    (e : Expr d Γ_out eff [ty]) :
    getPureExpr (lets.var e) (Var.last _ _)
    = e.toPure?.map (fun e => ⟨_, Var.last _ _, e.changeVars <| e.contextHom⟩) := by
  show getPureExpr _ (Var.last ⟨[]⟩ ty).appendInr = _
  exact getPureExpr_var_appendInr ..

@[simp] lemma Lets.getPureExprAux_var_appendInl (lets : Lets d Γ_in eff Γ_out)
    (e : Expr d Γ_out eff ty₁) (v : Var Γ_out ty₂) :
    getPureExprAux (lets.var e) v.appendInl
    = (getPureExprAux lets v).map fun ⟨_, w, e⟩ =>
        ⟨_, w, e.changeVars <| Hom.id.castCodomain (by simp)⟩ := by
  simp [getPureExprAux]
  match lets.getPureExprAux v with
  | none =>
    simp only [Option.map_none, cast_eq_iff_heq]
    congr
    simp
  | some ⟨_, _, e⟩ =>
    simp only [Option.map_some, cast_eq_iff_heq]
    congr 3 <;> simp [Expr.changeVars_castCodomain]

-- @[simp] lemma Lets.getPureExprAux_var_toSnoc (lets : Lets d Γ_in eff Γ_out)
--     (e : Expr d Γ_out eff ty₁) (v : Var Γ_out ty₂) :
--     getPureExprAux (lets.var e) (v.toSnoc) = getPureExprAux lets v :=
--   rfl

@[simp] lemma Lets.getPureExpr_var_appendInl (lets : Lets d Γ_in eff Γ_out) (e : Expr d Γ_out _ ty₁)
    (v : Var Γ_out ty₂):
    getPureExpr (lets.var e) (v.appendInl)
    = (fun ⟨_, w, e'⟩ => ⟨_, w,  e'.changeVars <| e.contextHom⟩) <$> (getPureExpr lets v) := by
  simp only [getPureExpr, getPureExprAux_var_appendInl, Option.map_eq_map, Option.map_map]
  congr 1
  funext ⟨_, e⟩
  simp only [Function.comp_apply, Expr.changeVars_changeVars, Sigma.mk.injEq, heq_eq_eq, true_and]
  congr 2
  funext t v
  apply Subtype.eq
  simp [Hom.castCodomain, Hom.comp, Ctxt.dropUntilHom, Ctxt.dropUntilDiff, Ctxt.Diff.toHom, Var.appendInl]
  omega

/-!
## Mapping
We can map between different dialects
-/

section Map

def RegionSignature.map (f : Ty → Ty') : RegionSignature Ty → RegionSignature Ty' :=
  List.map fun ⟨Γ, ty⟩ => (Γ.map f, ty.map f)

instance : Functor RegionSignature where
  map := RegionSignature.map

def Signature.map (f : Ty → Ty') : Signature Ty → Signature Ty' :=
  fun sig => {
    sig         := sig.sig.map f
    regSig      := sig.regSig.map f
    returnTypes := sig.returnTypes.map f
  }

instance : Functor Signature where
  map := fun f ⟨sig, regSig, returnTypes, effKind⟩ =>
    ⟨f <$> sig, f <$> regSig, f <$> returnTypes, effKind⟩

/-- A dialect morphism consists of a map between operations and a map between types,
such that the signature of operations is respected -/
structure DialectMorphism (d d' : Dialect) [DialectSignature d] [DialectSignature d'] where
  mapOp : d.Op → d'.Op
  mapTy : d.Ty → d'.Ty
  preserves_signature : ∀ op, signature (mapOp op) = mapTy <$> (signature op)

variable {d d' : Dialect} [DialectSignature d] [DialectSignature d'] (f : DialectMorphism d d')

def DialectMorphism.preserves_sig (op : d.Op) :
    DialectSignature.sig (f.mapOp op) = (DialectSignature.sig op).map f.mapTy := by
  simp only [DialectSignature.sig, Function.comp_apply, f.preserves_signature]; rfl

def DialectMorphism.preserves_regSig (op : d.Op) :
    DialectSignature.regSig (f.mapOp op) = (DialectSignature.regSig op).map f.mapTy := by
  simp only [DialectSignature.regSig, Function.comp_apply, f.preserves_signature]; rfl

def DialectMorphism.preserves_returnTypes (op : d.Op) :
    DialectSignature.returnTypes (f.mapOp op) = (DialectSignature.returnTypes op).map f.mapTy := by
  simp only [DialectSignature.returnTypes, Function.comp_apply, f.preserves_signature]; rfl

theorem DialectMorphism.preserves_effectKind (op : d.Op) :
    DialectSignature.effectKind (f.mapOp op) = DialectSignature.effectKind op := by
  simp only [DialectSignature.effectKind, Function.comp_apply, f.preserves_signature]; rfl

mutual

def Com.changeDialect : Com d Γ eff ty → Com d' (f.mapTy <$> Γ) eff (f.mapTy <$> ty)
  | .rets vs        => .rets <| vs.map' f.mapTy (fun _ v => v.toMap)
  | .var body rest =>
      let rest :=
        rest.changeDialect.changeVars <|
          Hom.id.castCodomain (by simp)
      .var body.changeDialect rest
termination_by com => sizeOf com

def Expr.changeDialect : Expr d Γ eff ty → Expr d' (Γ.map f.mapTy) eff (f.mapTy <$> ty)
  | ⟨op, Eq.refl _, effLe, args, regs⟩ => ⟨
      f.mapOp op,
      (f.preserves_returnTypes _).symm,
      f.preserves_effectKind _ ▸ effLe,
      f.preserves_sig _ ▸ args.map' f.mapTy fun _ => Var.toMap (f:=f.mapTy),
      f.preserves_regSig _ ▸
        HVector.changeDialect regs
    ⟩
termination_by e => sizeOf e

/-- Inline of `HVector.map'` for the termination checker -/
def HVector.changeDialect : ∀ {regSig : RegionSignature d.Ty},
    HVector (fun t => Com d t.fst eff t.snd) regSig
    → HVector (fun t => Com d' t.fst eff t.snd) (f.mapTy <$> regSig : RegionSignature _)
  | _, .nil        => .nil
  | t::_, .cons a as  => .cons a.changeDialect (HVector.changeDialect as)
termination_by _ vs => sizeOf vs

end

-- @[simp] lemma Expr.outContext_changeDialect :
--

def Lets.changeDialect : Lets d Γ_in eff Γ_out → Lets d' (f.mapTy <$> Γ_in) eff (f.mapTy <$> Γ_out)
  | nil => nil
  | var body e =>
      cast (by simp) <| var (changeDialect body) (e.changeDialect f)

section Lemmas

@[simp] lemma Com.changeDialect_rets (f : DialectMorphism d d') (vs) :
    Com.changeDialect f (Com.rets vs : Com d Γ eff t)
    = Com.rets (vs.map' f.mapTy (fun _ v => v.toMap)) := by
  cases eff <;> simp [changeDialect]

@[simp] lemma Com.changeDialect_var (f : DialectMorphism d d')
    (e : Expr d Γ eff t) (body : Com d _ eff u) :
    (Com.var e body).changeDialect f
    = have h := by simp
      Com.var (e.changeDialect f)
      <| (body.changeDialect f).changeVars (Hom.id.castCodomain h) := by
  simp only [changeDialect]

@[simp] lemma HVector.changeDialect_nil {eff : EffectKind} (f : DialectMorphism d d') :
    HVector.changeDialect (eff := eff) f nil = nil := by simp [HVector.changeDialect]

end Lemmas

end Map

/-!
## `Lets.addComToEnd`, `Com.toLets` and `Com.toFlatCom`
-/

/-- Add a `Com` to the end of a sequence of lets -/
def Lets.addComToEnd {Γ_out} {eff} (lets : Lets d Γ_in eff Γ_out) :
      (com : Com d Γ_out eff ty) → Lets d Γ_in eff com.outContext
  | Com.rets _       => lets
  | Com.var e body => addComToEnd (Lets.var lets e) body

/-- The let-bindings of a program -/
def Com.toLets (com : Com d Γ eff t) : Lets d Γ eff com.outContext :=
  Lets.nil.addComToEnd com

/-- Convert a `Com` into a `FlatCom` -/
def Com.toFlatCom {ts} (com : Com d Γ .pure ts) : FlatCom d Γ .pure com.outContext ts :=
  ⟨com.toLets, com.returnVars⟩

section Lemmas

/-! #### Basic Lemmas -/

@[simp] lemma Lets.addComToEnd_rets {lets : Lets d Γ_in eff Γ_out} :
    addComToEnd lets (.rets v : Com d Γ_out eff t) = lets             := by simp [addComToEnd]
@[simp] lemma Lets.addComToEnd_var {lets : Lets d Γ_in eff Γ_out} {com : Com d _ eff t} :
    addComToEnd lets (Com.var e com) = addComToEnd (lets.var e) com := by simp [addComToEnd]

@[simp] lemma Com.toLets_rets : toLets (rets v : Com d Γ eff t) = .nil := by simp [toLets]

/-! ### castPureToEff -/

@[simp] lemma Lets.addComToEnd_castPureToEff {lets : Lets d Γ_in .pure Γ_out}
    {com : Com d Γ_out .pure ty} :
    (lets.castPureToEff eff).addComToEnd (com.castPureToEff eff)
    = cast (by simp) ((lets.addComToEnd com).castPureToEff eff) := by
  induction com using Com.rec'
  case rets => simp
  case var ih =>
    simp only [Com.castPureToEff_var, Com.outContext_var, addComToEnd_var,
      ← Lets.castPureToEff_var, ih]

@[simp] lemma Com.toLets_castPureToEff {com : Com d Γ .pure ty} :
    (com.castPureToEff eff).toLets = cast (by simp) (com.toLets.castPureToEff eff) := by
  unfold toLets
  rw [show (Lets.nil : Lets d Γ eff Γ) = (Lets.nil.castPureToEff eff) from rfl,
    Lets.addComToEnd_castPureToEff]

/-! ### Denotation Lemmas-/

@[simp] lemma Lets.denote_addComToEnd
    {lets : Lets d Γ_in eff Γ_out} {com : Com d Γ_out eff t} :
    Lets.denote (lets.addComToEnd com) = fun V => (do
        let Vlets ← lets.denote V
        let Vbody ← com.denoteLets Vlets
        return Vbody
      ) := by
  induction com
  case rets => simp [Com.denoteLets]
  case var ih => simp [addComToEnd, ih, denote_var]

@[simp] lemma Com.denoteLets_rets : (.rets v : Com d Γ eff t).denoteLets = fun V => pure V := by
  funext V; simp [denoteLets]

theorem Com.denoteLets_eq {com : Com d Γ eff t} : com.denoteLets = com.toLets.denote := by
  simp only [toLets]; induction com using Com.rec' <;> simp [Lets.denote_var]

@[simp] lemma Com.denoteLets_castPureToEff {com : Com d Γ .pure ty} :
    denoteLets (com.castPureToEff eff)
    = fun V => pure (com.denoteLets V |>.comap fun _ v => v.castCtxt (by simp)) := by
  funext V
  induction com using Com.rec'
  · simp
  · simp [*]; rfl

end Lemmas

/-!
## Free Variables
-/

/-- Convert a heterogenous vector of variables into a homogeneous `VarSet` -/
def HVector.toVarSet : {l : List d.Ty} → (T : HVector (Var Γ) l) → VarSet Γ
  | [], .nil => ∅
  | _::_, .cons v vs => insert ⟨_, v⟩ vs.toVarSet

-- TODO: `HVector.toVarSet` and `HVector.vars` do the same thing, deduplicate
def HVector.vars {l : List d.Ty} (T : HVector (Var Γ) l) : VarSet Γ :=
  T.foldl (fun _ s a => insert ⟨_, a⟩ s) ∅

mutual

--TODO: find a name that better encapsulates that it's the *transitive* closure
/-- The free variables of `lets` that are (transitively) referred to by some variable `v`.
Also known as the uses of var. -/
def Lets.vars : Lets d Γ_in eff Γ_out → Var Γ_out t → VarSet Γ_in
  | .nil, v => VarSet.ofVar v
  | .var lets e, v => by
      cases v using Var.appendCases with
      | left v => exact lets.vars v
      | right _ => exact lets.varsOfVec e.args

def Lets.varsOfVec (lets : Lets d Γ_in eff Γ_out) (vs : HVector Γ_out.Var ts) :
    VarSet Γ_in :=
  (vs.vars).biUnion (fun v => lets.vars v.2)

end

/-- `com.vars` is the set of free variables from `Γ` that are (transitively) used by the return
variable of `com` -/
def Com.vars (com : Com d Γ eff ts) : VarSet Γ :=
  com.toLets.varsOfVec com.returnVars

section Lemmas

@[simp] lemma Com.vars_toLets (com : Com d Γ eff t) :
    com.toLets.varsOfVec com.returnVars = com.vars := rfl

@[simp] lemma Lets.vars_var {lets : Lets d Γ_in eff Γ_out}
    {t} {e : Expr d Γ_out eff t} {w : Γ_out.Var u} :
    Lets.vars (Lets.var lets e) w.appendInl
    = Lets.vars lets w := by
  simp [Lets.vars]

@[simp] lemma HVector.vars_nil :
    (HVector.nil : HVector (Var Γ) ([] : List d.Ty)).vars = ∅ := by
  simp [HVector.vars, HVector.foldl]

@[simp] lemma HVector.vars_cons {t  : d.Ty} {l : List d.Ty}
    (v : Var Γ t) (T : HVector (Var Γ) l) :
    (HVector.cons v T).vars = insert ⟨_, v⟩ T.vars := by
  rw [HVector.vars, HVector.vars]
  generalize hs : (∅ : VarSet Γ) = s
  clear hs
  induction T generalizing s t v with
  | nil => simp [foldl]
  | cons v' T ih =>
    rename_i t2 _
    conv_rhs => rw [foldl]
    rw [← ih]
    rw [foldl,foldl, foldl]
    congr 1
    simp [Finset.ext_iff, or_comm, or_assoc, Sigma.forall]

/-- For a vector of variables T,
  let s₁ and s₂ be two maps from variables to A t.
  If s₁ and s₂ agree on all variables in T (which is a VarSet),
  then T.map s₁ = T.map s₂ -/
theorem HVector.map_eq_of_eq_on_vars {A : d.Ty → Type*}
    {T : HVector (Var Γ) l}
    {s₁ s₂ : ∀ (t), Var Γ t → A t}
    (h : ∀ v, v ∈ T.vars → s₁ _ v.2 = s₂ _ v.2) :
    T.map s₁ = T.map s₂ := by
  induction T with
  | nil => simp [HVector.map]
  | cons v T ih =>
    rw [HVector.map, HVector.map, ih]
    · congr
      apply h ⟨_, v⟩
      simp
    · intro v hv
      apply h
      simp_all

end Lemmas

/-!
## Misc
-/
section TypeProjections
variable {d : Dialect} [DialectSignature d] {Γ : Ctxt d.Ty} {eff : EffectKind} {t : d.Ty}

def Com.getTy : Com d Γ eff [t] → Type := fun _ => d.Ty
def Com.ty : Com d Γ eff [t] → d.Ty := fun _ => t
def Com.ctxt : Com d Γ eff [t] → Ctxt d.Ty := fun _ => Γ

def Expr.getTy : Expr d Γ eff [t] → Type := fun _ => d.Ty
def Expr.ty : Expr d Γ eff [t] → d.Ty := fun _ => t
def Expr.ctxt : Expr d Γ eff [t] → Ctxt d.Ty := fun _ => Γ

end TypeProjections

/-!
## Compatibility Namespaces
-/
section Compat

def Com.ret {Γ : Ctxt d.Ty} {ty : d.Ty} {eff : EffectKind} : Γ.Var ty → Com d Γ eff [ty] :=
  (Com.rets [·]ₕ)

/-!
`open LeanMLIR.SingleReturnCompat` will bring an alias for `Com` & `Expr` into
scope which has only a single return type.
-/
namespace LeanMLIR.SingleReturnCompat
variable (d) [DialectSignature d]

nonrec abbrev Com  : Ctxt d.Ty → EffectKind → d.Ty → Type := (Com d · · [·])
nonrec abbrev Expr : Ctxt d.Ty → EffectKind → d.Ty → Type := (Expr d · · [·])

variable {d} {Γ : Ctxt d.Ty} {eff : EffectKind} {t : d.Ty}

nonrec abbrev Com.var : Expr d Γ eff t → Com d (Γ.snoc t) eff β → Com d Γ eff β :=
  (Com.var · ·)

end LeanMLIR.SingleReturnCompat

end Compat
