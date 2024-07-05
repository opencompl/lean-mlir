/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
-- Investigations on asymptotic behavior of representing programs with large explicit contexts

import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import Mathlib.Control.Monad.Basic
import SSA.Core.Framework.Dialect
import Mathlib.Data.List.AList
import Mathlib.Data.Finset.Piecewise

open Ctxt (Var VarSet Valuation)
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
    (HVector (fun t : Ctxt d.Ty × d.Ty => t.1.Valuation → EffectKind.impure.toMonad d.m (toType t.2))
            (DialectSignature.regSig op)) →
    ((DialectSignature.effectKind op).toMonad d.m (toType <| DialectSignature.outTy op))

/-
Some considerations about purity:

We want pure operations to be able to be run in an impure context (but not vice versa, of course).

However, the current definition of `DialectDenote` forces an expressions regions to be of the same purity
as the operation.
In particular, a pure operation which has regions requires those regions to be available as pure
functions `args → result` to be able call `DialectDenote.denote`, whereas an instance of this operation
with impure regions would have them be `args → d.m result`.

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


/- # Datastructures -/
section DataStructures

variable (d : Dialect) [DialectSignature d]

mutual
/-- An intrinsically typed expression whose effect is *at most* EffectKind -/
inductive Expr : (Γ : Ctxt d.Ty) → (eff : EffectKind) → (ty : d.Ty) → Type :=
  | mk {Γ} {ty} (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (eff_le : DialectSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) <| DialectSignature.sig op)
    /- For now, assume that regions are impure.
       We keep it this way to minimize the total amount of disruption in our definitions.
       We shall change this once the rest of the file goes through. -/
    (regArgs : HVector (fun t : Ctxt d.Ty × d.Ty => Com t.1 .impure t.2)
      (DialectSignature.regSig op)) : Expr Γ eff ty


/-- A very simple intrinsically typed program: a sequence of let bindings.
Note that the `EffectKind` is uniform: if a `Com` is `pure`, then the expression and its body are pure,
and if a `Com` is `impure`, then both the expression and the body are impure!
-/
inductive Com : Ctxt d.Ty → EffectKind → d.Ty → Type where
  | ret {eff : EffectKind} (v : Var Γ t) : Com Γ eff t
  | var (e : Expr Γ eff α) (body : Com (Γ.snoc α) eff β) : Com Γ eff β
end

/-- `Lets d Γ_in Γ_out` is a sequence of lets which are well-formed under context `Γ_out` and result in
    context `Γ_in`-/
inductive Lets (Γ_in : Ctxt d.Ty) (eff : EffectKind) :
    (Γ_out : Ctxt d.Ty) → Type where
  | nil : Lets Γ_in eff Γ_in
  | var (body : Lets Γ_in eff Γ_out) (e : Expr d Γ_out eff t) : Lets Γ_in eff (Γ_out.snoc t)

/-- `Zipper d Γ_in eff Γ_mid ty` represents a particular position in a program, by storing the
`Lets` that come before this position separately from the `Com` that represents the rest.
Thus, `Γ_in` is the context of the program as a whole, while `Γ_mid` is the context at the
current position.

While technically the position is in between two let-bindings, by convention we say that the first
binding of `top : Lets ..` is the current binding of a particular zipper. -/
structure Zipper (Γ_in : Ctxt d.Ty) (eff : EffectKind) (Γ_mid : Ctxt d.Ty) (ty : d.Ty) where
  /-- The let-bindings at the top of the zipper -/
  top : Lets d Γ_in eff Γ_mid
  /-- The program at the bottom of the zipper -/
  bot : Com d Γ_mid eff ty



section Repr
open Std (Format)
variable {d} [DialectSignature d] [Repr d.Op] [Repr d.Ty]

/-- Parenthesize and separate with 'separator' if the list is nonempty, and return
the empty string otherwise. -/
private def Format.parenIfNonempty (l : String) (r : String) (separator : Format) (xs : List Format) : Format :=
  match xs with
  | [] => ""
  | _  =>  l ++ (Format.joinSep xs separator) ++ r

/-- Format a sequence of types as `(t₁, ..., tₙ)`. Will always display parentheses. -/
private def formatTypeTuple [Repr Ty] (xs : List Ty) : Format :=
  "("  ++ Format.joinSep (xs.map (fun t => Repr.reprPrec t 0)) ", " ++ ")"

/-- Format a tuple of arguments as `a₁, ..., aₙ`. -/
private def formatArgTuple [Repr Ty] {Γ : Ctxt Ty} (args : HVector (fun t => Var Γ₂ t) Γ) : Format :=
  Format.parenIfNonempty " (" ")" ", " (formatArgTupleAux args) where
  formatArgTupleAux [Repr Ty] {Γ : Ctxt Ty} (args : HVector (fun t => Var Γ₂ t) Γ) : List Format :=
    match Γ with
    | .nil => []
    | .cons .. =>
      match args with
      | .cons a as => (repr a) :: (formatArgTupleAux as)

/-- Format a list of formal arguments as `(%0 : t₀, %1 : t₁, ... %n : tₙ)` -/
private def formatFormalArgListTuple [Repr Ty] (ts : List Ty) : Format :=
  Format.paren <| Format.joinSep ((List.range ts.length).zip ts |>.map
    (fun it => f!"%{it.fst} : {repr it.snd}")) ", "

mutual
  /-- Convert a HVector of region arguments into a List of format strings. -/
  partial def reprRegArgsAux [Repr d.Ty] {ts : List (Ctxt d.Ty × d.Ty)}
    (regArgs : HVector (fun t => Com d t.1 EffectKind.impure t.2) ts) : List Format :=
    match ts with
    | [] => []
    | _ :: _ =>
      match regArgs with
      | .cons regArg regArgs =>
        let regFmt := Com.repr 0 regArg
        let restFmt := reprRegArgsAux regArgs
        (regFmt :: restFmt)

  partial def Expr.repr (_ : Nat) : Expr d Γ eff t → Format
    | ⟨op, _, _, args, regArgs⟩ =>
        let outTy := DialectSignature.outTy op
        let argTys := DialectSignature.sig op
        let regArgs := Format.parenIfNonempty " (" ")" Format.line (reprRegArgsAux regArgs)
        f!"{repr op}{formatArgTuple args}{regArgs} : {formatTypeTuple argTys} → ({repr outTy})"

  /-- Format string for a Com, with the region parentheses and formal argument list. -/
  partial def Com.repr (prec : Nat) (com : Com d Γ eff t) : Format :=
    f!"\{" ++ Format.nest 2
    (Format.line ++
    "^entry" ++ Format.nest 2 ((formatFormalArgListTuple Γ) ++ f!":" ++ Format.line ++
    (comReprAux prec com))) ++ Format.line ++
    f!"}"

  /-- Format string for sequence of assignments and return in a Com. -/
  partial def comReprAux (prec : Nat) : Com d Γ eff t → Format
    | .ret v => f!"return {reprPrec v prec} : ({repr t}) → ()"
    | .var e body =>
      f!"%{repr <| Γ.length} = {e.repr prec}" ++ Format.line ++
      comReprAux prec body
end

def Lets.repr (prec : Nat) : Lets d eff Γ t → Format
    | .nil => .align false ++ f!";"
    | .var body e => body.repr prec ++ (.align false ++ f!"{e.repr prec}")

instance : Repr (Expr d Γ eff t) := ⟨flip Expr.repr⟩
instance : Repr (Com d Γ eff t) := ⟨flip Com.repr⟩
instance : Repr (Lets d Γ eff t) := ⟨flip Lets.repr⟩

end Repr

--TODO: this should be derived later on when a derive handler is implemented
mutual -- DecEq

variable {d} [DialectSignature d]

protected instance HVector.decidableEqReg [DecidableEq d.Op] [DecidableEq d.Ty] :
    ∀ {l : List (Ctxt d.Ty × d.Ty)}, DecidableEq (HVector (fun t => Com d t.1 .impure t.2) l)
  | _, .nil, .nil => isTrue rfl
  | _, .cons x₁ v₁, .cons x₂ v₂ =>
    letI := HVector.decidableEqReg v₁ v₂
    letI := Com.decidableEq x₁ x₂
    decidable_of_iff (x₁ = x₂ ∧ v₁ = v₂) (by simp)

protected instance Expr.decidableEq [DecidableEq d.Op] [DecidableEq d.Ty] :
    {Γ : Ctxt d.Ty} → {ty : d.Ty} → DecidableEq (Expr d Γ eff ty)
  | _, _, .mk op₁ rfl eff_le₁ arg₁ regArgs₁, .mk op₂ eq eff_le₂ arg₂ regArgs₂ =>
    if ho : op₁ = op₂
    then by
      subst ho
      letI := HVector.decidableEq arg₁ arg₂
      letI := HVector.decidableEqReg regArgs₁ regArgs₂
      exact decidable_of_iff (arg₁ = arg₂ ∧ regArgs₁ = regArgs₂) (by simp)
    else isFalse (by simp_all)

protected instance Com.decidableEq [DecidableEq d.Op] [DecidableEq d.Ty]
    {Γ : Ctxt d.Ty} {eff : EffectKind} {ty : d.Ty} : DecidableEq (Com d Γ eff ty)
  | .ret v₁, .ret v₂ => decidable_of_iff (v₁ = v₂) (by simp)
  | .var (α := α₁) e₁ body₁, .var (α := α₂) e₂ body₂ =>
    if hα : α₁ = α₂
    then by
      subst hα
      letI := Expr.decidableEq e₁ e₂
      letI := Com.decidableEq body₁ body₂
      exact decidable_of_iff (e₁ = e₂ ∧ body₁ = body₂) (by simp)
    else isFalse (by simp_all)
  | .ret _, .var _ _ => isFalse (fun h => Com.noConfusion h)
  | .var _ _, .ret _ => isFalse (fun h => Com.noConfusion h)

end -- decEq

end DataStructures

/-
  # Definitions
-/

variable {d : Dialect} [DialectSignature d]

@[elab_as_elim]
def Com.recAux' {motive : ∀ {Γ eff t}, Com d Γ eff t → Sort u}
    (ret : ∀ {Γ t} {eff : EffectKind}, (v : Var Γ t) → motive (eff := eff) (Com.ret v))
    (var : ∀ {Γ} {t u : d.Ty} {eff},
      (e : Expr d Γ eff t) → (body : Com d (Ctxt.snoc Γ t) eff u) →
        motive body → motive (Com.var e body)) :
    ∀ {Γ eff t}, (com : Com d Γ eff t) → motive com
  | _, _, _, Com.ret v => ret v
  | _, _, _, Com.var e body => var e body (Com.recAux' ret var body)

@[implemented_by Com.recAux', elab_as_elim, induction_eliminator]
-- ^^^^ `Com.rec` is noncomputable, so have a computable version as well
--      See `Com.recAux'_eq` for a theorem that states these definitions are equal
def Com.rec' {motive : ∀ {Γ eff t}, Com d Γ eff t → Sort u}
    (ret : ∀ {Γ t} {eff : EffectKind}, (v : Var Γ t) → motive (eff := eff) (Com.ret v))
    (var : ∀ {Γ} {t u : d.Ty} {eff},
      (e : Expr d Γ eff t) → (body : Com d (Ctxt.snoc Γ t) eff u) →
        motive body → motive (Com.var e body)) :
    ∀ {Γ eff t}, (com : Com d Γ eff t) → motive com :=
  /- HACK: the obvious definition of `rec'` using the match compiler does not have the
     def-eqs we expect. Thus, we directly use the recursion principle. -/
  Com.rec (motive_1 := fun _ _ _ _ => PUnit) (motive_2 := fun _ _ _ c => motive c)
    (motive_3 := fun _ _ => PUnit) (fun _ _ _ _ _ _ => ⟨⟩) -- `Expr.mk` case
    (ret) -- `Com.ret` case
    (fun e body _ r => var e body r) -- `Com.var` case
    ⟨⟩ (fun _ _ _ _ => ⟨⟩)

@[simp] lemma Com.rec'_ret (v : Var Γ t) {motive eff} {ret var} :
    (Com.ret (d:=d) (eff := eff) v).rec' (motive:=motive) ret var = ret v :=
  rfl

@[simp] lemma Com.rec'_var (e : Expr d Γ eff t) (body : Com d _ _ u)
    {motive} {ret var} :
    (Com.var e body).rec' (motive:=motive) ret var
    = var e body (body.rec' ret var) :=
  rfl

theorem Com.recAux'_eq {motive : ∀ {Γ eff t}, Com d Γ eff t → Sort u} :
    Com.recAux' (motive:=motive) = Com.rec' (motive:=motive) := by
  funext ret var Γ eff t com
  induction com
  next => simp[recAux']
  next ih => simp [recAux', ih]

/-- Alternative recursion principle for known-pure `Com`s -/
-- TODO: we should be able to make `Com.rec'` work even for known-pure `Com`s by fiddling with
--       the type of `motive`
@[elab_as_elim]
def Com.recPure {motive : ∀ {Γ t}, Com d Γ .pure t → Sort u}
    (ret : ∀ {Γ t}, (v : Var Γ t) → motive (Com.ret v))
    (var : ∀ {Γ} {t u : d.Ty},
      (e : Expr d Γ .pure t) → (body : Com d (Ctxt.snoc Γ t) .pure u) →
        motive body → motive (Com.var e body))
    {Γ t} (com : Com d Γ .pure t) : motive com :=
  let motive {_Γ eff _t} (com) := match eff with
    | EffectKind.pure => motive com
    | EffectKind.impure => PUnit
  let ret {Γ eff t} (v : Var Γ t) : @motive Γ eff t (Com.ret v) := match eff with
    | .pure => ret v
    | .impure => ⟨⟩
  let var {Γ t u} {eff} (e : Expr d Γ eff t) (body : Com d (Γ.snoc t) eff u) :
      motive body → motive (body.var e) :=
    fun r => match eff with
      | .pure => var _ _ r
      | .impure => ⟨⟩
  com.rec' (motive := @motive) ret var

def Expr.op {Γ : Ctxt d.Ty} {eff : EffectKind} {ty : d.Ty} (e : Expr d Γ eff ty) : d.Op :=
  Expr.casesOn e (fun op _ _ _ _ => op)

theorem Expr.eff_le {Γ : Ctxt d.Ty} {ty : d.Ty} (e : Expr d Γ eff ty) :
  DialectSignature.effectKind e.op ≤ eff :=
  Expr.casesOn e (fun _ _ eff_le _ _ => eff_le)

theorem Expr.ty_eq {Γ : Ctxt d.Ty} {ty : d.Ty} (e : Expr d Γ eff ty) :
    ty = DialectSignature.outTy e.op :=
  Expr.casesOn e (fun _ ty_eq _ _ _ => ty_eq)

def Expr.args {Γ : Ctxt d.Ty} {ty : d.Ty} (e : Expr d Γ eff ty) :
    HVector (Var Γ) (DialectSignature.sig e.op) :=
  Expr.casesOn e (fun _ _ _ args _ => args)

def Expr.regArgs {Γ : Ctxt d.Ty} {ty : d.Ty} (e : Expr d Γ eff ty) :
    HVector (fun t : Ctxt d.Ty × d.Ty => Com d t.1 .impure t.2) (DialectSignature.regSig e.op) :=
  Expr.casesOn e (fun _ _ _ _ regArgs => regArgs)

/-! Projection equations for `Expr` -/
@[simp]
theorem Expr.op_mk {Γ : Ctxt d.Ty} {ty : d.Ty} {eff : EffectKind} (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (eff_le : DialectSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) (DialectSignature.sig op)) (regArgs):
    (Expr.mk op ty_eq eff_le args regArgs).op = op := rfl

@[simp]
theorem Expr.args_mk {Γ : Ctxt d.Ty} {ty : d.Ty} {eff : EffectKind} (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (eff_le : DialectSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) (DialectSignature.sig op)) (regArgs) :
    (Expr.mk op ty_eq eff_le args regArgs).args = args := rfl

@[simp]
theorem Expr.regArgs_mk {Γ : Ctxt d.Ty} {ty : d.Ty} {eff : EffectKind} (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (eff_le : DialectSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) (DialectSignature.sig op)) (regArgs) :
    (Expr.mk op ty_eq eff_le args regArgs).regArgs = regArgs := rfl

/-!
### `size`
-/

/-- The size of a `Com` is given by the number of let-bindings it contains -/
def Com.size : Com d Γ eff t → Nat :=
  Com.rec'
    /- ret _ -/       (fun _ => 0)
    /- var _ body -/ (fun _ _body bodySize => bodySize + 1)

section Lemmas

@[simp] lemma Com.size_ret  : (ret v : Com d Γ eff t).size = 0 := rfl
@[simp] lemma Com.size_var : (var e body : Com d Γ eff t).size = body.size + 1 := rfl

end Lemmas

/-!
### `Com` projections and simple conversions
-/

/-- The `outContext` of a program is a context which includes variables for all let-bindings
of the program. That is, it is the context under which the return value is typed -/
def Com.outContext {Γ} : Com d Γ eff t → Ctxt d.Ty :=
  Com.rec' (motive := fun _ => Ctxt d.Ty)
    (@fun Γ _ _ _ => Γ) -- `Com.ret` case
    (fun _ _ r => r) -- `Com.var` case

/-- The difference between the context `Γ` under which `com` is typed, and the output context of
that same `com` -/
def Com.outContextDiff (com : Com d Γ eff t) : Γ.Diff com.outContext :=
  ⟨com.size, by
    intro i t h;
    unfold outContext
    induction com generalizing i
    case ret => exact h
    case var ih =>
      rw [rec'_var, size_var, ← Nat.add_assoc, Nat.add_comm _ 1, ← Nat.add_assoc, ih]
      simpa [Ctxt.snoc, Nat.add_comm 1 _] using h⟩

/-- `com.outContextHom` is the canonical homorphism from free variables of `com` to those same
variables in the output context of `com` -/
def Com.outContextHom (com : Com d Γ eff t) : Γ.Hom com.outContext :=
  com.outContextDiff.toHom

/-- The return variable of a program -/
def Com.returnVar : (com : Com d Γ eff t) → Var com.outContext t
  | .ret v => v
  | .var _ body => body.returnVar

section Lemmas

@[simp] lemma Com.outContext_ret (v : Var Γ t) : (ret v : Com d Γ eff t).outContext = Γ := rfl
@[simp] lemma Com.outContext_var {eff} (e : Expr d Γ eff t) (body : Com d (Γ.snoc t) eff u) :
    (Com.var e body).outContext = body.outContext := rfl

@[simp] lemma Com.outContextHom_ret (v : Var Γ t) :
    (ret v : Com d Γ eff t).outContextHom = Ctxt.Hom.id := rfl
@[simp] lemma Com.outContextHom_var :
    (var e body : Com d Γ eff t).outContextHom = body.outContextHom.unSnoc := by
  funext t' v'
  simp only [outContext_var, outContextHom, Ctxt.Diff.toHom, Ctxt.Diff.Valid, outContextDiff,
    size_var, Ctxt.Hom.unSnoc, Var.val_toSnoc]
  ac_rfl

@[simp] lemma Com.returnVar_ret : returnVar (ret v : Com d Γ eff t) = v := by simp [returnVar]
@[simp] lemma Com.returnVar_var :
    returnVar (var (d:=d) (eff:=eff) e body) = body.returnVar := by
  simp [returnVar]

end Lemmas

/-!
### `Lets.addComToEnd` and `Com.toLets`
-/

/-- Add a `Com` to the end of a sequence of lets -/
def Lets.addComToEnd {Γ_out} {eff} (lets : Lets d Γ_in eff Γ_out) :
      (com : Com d Γ_out eff ty) → Lets d Γ_in eff com.outContext
  | Com.ret _       => lets
  | Com.var e body => addComToEnd (Lets.var lets e) body

/-- The let-bindings of a program -/
def Com.toLets (com : Com d Γ eff t) : Lets d Γ eff com.outContext :=
  Lets.nil.addComToEnd com

section Lemmas

@[simp] lemma Lets.addComToEnd_ret {lets : Lets d Γ_in eff Γ_out} :
    addComToEnd lets (.ret v : Com d Γ_out eff t) = lets             := by simp [addComToEnd]
@[simp] lemma Lets.addComToEnd_var {lets : Lets d Γ_in eff Γ_out} {com : Com d _ eff t} :
    addComToEnd lets (Com.var e com) = addComToEnd (lets.var e) com := by simp [addComToEnd]

@[simp] lemma Com.toLets_ret : toLets (ret v : Com d Γ eff t) = .nil := by simp [toLets]

end Lemmas

/-!
## `denote`
Denote expressions, programs, and sequences of lets
-/
variable [TyDenote d.Ty] [DialectDenote d] [DecidableEq d.Ty] [Monad d.m] [LawfulMonad d.m]

mutual

def HVector.denote : {l : List (Ctxt d.Ty × d.Ty)} → (T : HVector (fun t => Com d t.1 .impure t.2) l) →
    HVector (fun t => t.1.Valuation → EffectKind.impure.toMonad d.m (toType t.2)) l
  | _, .nil => HVector.nil
  | _, .cons v vs => HVector.cons (v.denote) (HVector.denote vs)

def Expr.denote {ty : d.Ty} (e : Expr d Γ eff ty) (Γv : Valuation Γ) : eff.toMonad d.m (toType ty) :=
  match e with
  | ⟨op, Eq.refl _, heff, args, regArgs⟩ =>
    EffectKind.liftEffect heff <| DialectDenote.denote op (args.map (fun _ v => Γv v)) regArgs.denote

def Com.denote : Com d Γ eff ty → (Γv : Valuation Γ) → eff.toMonad d.m (toType ty)
  | .ret e, Γv => pure (Γv e)
  | .var e body, Γv =>
     match eff with
     | .pure => body.denote (Γv.snoc (e.denote Γv))
     | .impure => e.denote Γv >>= fun x => body.denote (Γv.snoc x)
end

/-- Denote just the let bindings of `com`, transforming a valuation for `Γ` into a valuation for
the output context of `com` -/
def Com.denoteLets : (com : Com d Γ eff ty) → (Γv : Valuation Γ) →
    eff.toMonad d.m (com.outContext.Valuation)
  | .ret _, V => pure V
  | .var e body, V =>
      e.denote V >>= fun Ve =>
      body.denoteLets (V.snoc Ve) >>= fun V =>
      return V.cast (by simp [Com.outContext])

--TODO: this should be an abbrev: the `liftM` is inserted automatically when writing `e.denote`
--      inside of `do`-notation, and we shouldn't have two ways to write the same thing
/-- Denote an `Expr` in an unconditionally impure fashion -/
def Expr.denoteImpure (e : Expr d Γ eff ty) (Γv : Valuation Γ) :
    EffectKind.impure.toMonad d.m (toType ty) :=
  liftM <| e.denote Γv

--TODO: figure out if we can write this in terms of `liftM`, too
/-- Denote a `Com` in an unconditionally impure fashion -/
def Com.denoteImpure : Com d Γ eff ty → (Γv : Valuation Γ) → EffectKind.impure.toMonad d.m (toType ty)
  | .ret e, Γv => pure (Γv e)
  | .var e body, Γv => e.denoteImpure Γv >>= fun x => body.denote (Γv.snoc x)

def Lets.denote [DialectSignature d] [DialectDenote d]
    (lets : Lets d Γ₁ eff Γ₂) (Γ₁'v : Valuation Γ₁) : (eff.toMonad d.m <| Valuation Γ₂) :=
  match lets with
  | .nil => return Γ₁'v
  | .var lets' e =>
      lets'.denote Γ₁'v >>= fun Γ₂'v =>
      e.denote Γ₂'v >>= fun v =>
      return (Γ₂'v.snoc v)

#guard_msgs in #eval Lean.Meta.getEqnsFor? ``Expr.denote
