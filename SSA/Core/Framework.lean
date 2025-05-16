/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
-- Investigations on asymptotic behavior of representing programs with large explicit contexts

import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import SSA.Core.Framework.Dialect
import SSA.Core.Framework.Refinement

import Mathlib.Control.Monad.Basic
import Mathlib.Data.List.AList
import Mathlib.Data.Finset.Piecewise

set_option deprecated.oldSectionVars true

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
    (HVector (fun t : Ctxt d.Ty × d.Ty => t.1.Valuation
      → EffectKind.impure.toMonad d.m (toType t.2))
            (DialectSignature.regSig op)) →
    ((DialectSignature.effectKind op).toMonad d.m (toType <| DialectSignature.outTy op))

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


/- # Datastructures -/
section DataStructures

variable (d : Dialect) [DialectSignature d]

mutual
/-- An intrinsically typed expression whose effect is *at most* EffectKind -/
inductive Expr : (Γ : Ctxt d.Ty) → (eff : EffectKind) → (ty : d.Ty) → Type where
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
Note that the `EffectKind` is uniform: if a `Com` is `pure`, then the expression
and its body are pure, and if a `Com` is `impure`, then both the expression and
the body are impure!
-/
inductive Com : Ctxt d.Ty → EffectKind → d.Ty → Type where
  | ret {eff : EffectKind} (v : Var Γ t) : Com Γ eff t
  | var (e : Expr Γ eff α) (body : Com (Γ.snoc α) eff β) : Com Γ eff β
end

/-- `Lets d Γ_in Γ_out` is a sequence of lets which are well-formed under
context `Γ_out` and result in context `Γ_in`. -/
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



/-! ### Repr instance -/
section Repr
open Std (Format)
variable {d} [DialectSignature d] [Repr d.Op] [Repr d.Ty]

/-- Parenthesize and separate with 'separator' if the list is nonempty, and return
the empty string otherwise. -/
private def Format.parenIfNonempty (l : String) (r : String) (separator : Format)
    (xs : List Format) : Format :=
  match xs with
  | [] => ""
  | _  =>  l ++ (Format.joinSep xs separator) ++ r

/-- Format a sequence of types as `(t₁, ..., tₙ)`. Will always display parentheses. -/
private def formatTypeTuple [Repr Ty] (xs : List Ty) : Format :=
  "("  ++ Format.joinSep (xs.map (fun t => Repr.reprPrec t 0)) ", " ++ ")"

/-- Format a tuple of arguments as `a₁, ..., aₙ`. -/
private def formatArgTuple [Repr Ty] {Γ : Ctxt Ty}
    (args : HVector (fun t => Var Γ₂ t) Γ) : Format :=
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

/- # ToString instances for Com and Expr  -/
section ToString
variable {d} [DialectSignature d] [Repr d.Op] [Repr d.Ty] [ToString d.Ty] [ToString d.Op]

/-- Format a list of formal arguments as `(%0 : t₀, %1 : t₁, ... %n : tₙ)` -/
partial def formatFormalArgListTupleStr [ToString Ty] (ts : List Ty) : String :=
  let args := (List.range ts.length).zip ts |>.map
    (fun (i, t) => s!"%{i} : {toString t}")
  "(" ++ String.intercalate ", " args ++ ")"
/--
Converts an expression to its string representation.
Assumes that `toString` instances exist for both the dialect's operations (`d.Op`)
and types (`d.Ty`). The output includes the operation name, argument list,
their types, and the resulting output type.
-/
partial def Expr.toString [ToString d.Op] : Expr d Γ eff t → String
  | Expr.mk (op : d.Op) _ _ args _regArgs =>
    let outTy : d.Ty := DialectSignature.outTy op
    let argTys := DialectSignature.sig op
    s!"{ToString.toString op}{formatArgTuple args} : {formatTypeTuple argTys} → ({ToString.toString outTy})"

/-- This function recursivly converts the body of a `Com` into its string representation.
Each bound variable is printed with its index and corresponding expression. -/
partial def Com.ToStringBody : Com d Γ eff t → String
  | .ret v => s!"return {_root_.repr v } : ({toString t}) → ()"
  | .var e body =>
    s!" %{_root_.repr <|(Γ.length)} = {Expr.toString e }" ++ "\n" ++
    Com.ToStringBody body

/- `Com.toString` implements a toString instance for the type `Com`.  -/
partial def Com.toString (_com : Com d Γ eff t) : String :=
   "{ \n"
  ++ "^entry" ++  ((formatFormalArgListTupleStr Γ)) ++ ":" ++ "\n"
  ++ (Com.ToStringBody com) ++
   "\n }"

instance : ToString (Com d Γ eff t)  where toString := Com.toString
instance : ToString (Expr d Γ eff t) where toString := Expr.toString

end ToString

/-! ### DecidableEq instance -/
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
def Com.denoteImpure :
    Com d Γ eff ty → (Γv : Valuation Γ) → EffectKind.impure.toMonad d.m (toType ty)
  | .ret e, Γv => pure (Γv e)
  | .var e body, Γv => e.denoteImpure Γv >>= fun x => body.denote (Γv.snoc x)

def Lets.denote [DialectSignature d] [DialectDenote d] {Γ₂}
    (lets : Lets d Γ₁ eff Γ₂) (Γ₁'v : Valuation Γ₁) : (eff.toMonad d.m <| Valuation Γ₂) :=
  match lets with
  | .nil => return Γ₁'v
  | .var lets' e =>
      lets'.denote Γ₁'v >>= fun Γ₂'v =>
      e.denote Γ₂'v >>= fun v =>
      return (Γ₂'v.snoc v)

/-- `denotePure` is a specialization of `denote` for pure `Lets`.
Theorems and definitions should always be phrased in terms of the latter.

However, `denotePure` behaves slighly better when it comes to congruences, since `congr` does not
realize that `pure.toMonad d.m (Valuation _)` is just `Valuation _`, and thus a function.
Therefore, if a goalstate is `⊢ lets.denote ... = lets.denote ...`, and `lets` is pure, then to use
the congruence, you can do: `rw [← Lets.denotePure]; congr`
-/
@[simp] abbrev Lets.denotePure [DialectSignature d] [DialectDenote d] :
    Lets d Γ₁ .pure Γ₂ → Valuation Γ₁ → Valuation Γ₂ := Lets.denote

--TODO: figure out if we can write this in terms of `liftM`, too
/-- Denote a `Lets` in an unconditionally impure fashion -/
def Lets.denoteImpure [DialectSignature d] [DialectDenote d] {Γ₂}
    (lets : Lets d Γ₁ eff Γ₂) (Γ₁'v : Valuation Γ₁) :
    (EffectKind.impure.toMonad d.m <| Valuation Γ₂) :=
  match lets with
  | .nil => EffectKind.impure.return Γ₁'v
  | .var lets' e =>
      lets'.denote Γ₁'v  >>= fun Γ₂'v =>
      e.denote Γ₂'v >>= fun v =>
      return (Γ₂'v.snoc v)

/-- The denotation of a zipper is a composition of the denotations of the constituent
`Lets` and `Com` -/
def Zipper.denote (zip : Zipper d Γ_in eff Γ_out ty) (V_in : Valuation Γ_in) :
    eff.toMonad d.m ⟦ty⟧ :=
  (zip.top.denote V_in) >>= zip.bot.denote

section Unfoldings

open EffectKind (liftEffect)

/- Equation lemma to unfold `denote`, which does not unfold correctly due to the presence
  of the coercion `ty_eq` and the mutual definition. -/
theorem Expr.denote_unfold
    (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (eff_le : DialectSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) <| DialectSignature.sig op)
    (regArgs : HVector (fun (t : Ctxt d.Ty × d.Ty) => Com d t.1 .impure t.2)
      (DialectSignature.regSig op))
    (Γv : Γ.Valuation) :
    Expr.denote (Expr.mk op ty_eq eff_le args regArgs) Γv
    = ty_eq ▸ (EffectKind.liftEffect eff_le <|
        DialectDenote.denote op (args.map (fun _ v => Γv v)) regArgs.denote) := by
      subst ty_eq
      simp [denote]

/-- Equation lemma to unfold `denote`, which does not unfold correctly due to the presence
  of the coercion `ty_eq` and the mutual definition. -/
theorem Com.denote_unfold (op : d.Op) (ty_eq : ty = DialectSignature.outTy op)
    (eff_le : DialectSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) <| DialectSignature.sig op)
    (regArgs : HVector (fun (t : Ctxt d.Ty × d.Ty) => Com d t.1 .impure t.2)
      (DialectSignature.regSig op))
    (Γv : Γ.Valuation) :
    Expr.denote (Expr.mk op ty_eq eff_le args regArgs) Γv
    = ty_eq ▸ (liftEffect eff_le <|
        DialectDenote.denote op (args.map (fun _ v => Γv v)) regArgs.denote) := by
      subst ty_eq
      simp [denote, Expr.denote]

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
info: some #[`Com.denote.eq_1, `Com.denote.eq_2, `Com.denote.eq_3]
-/
#guard_msgs in #eval Lean.Meta.getEqnsFor? ``Com.denote

end Unfoldings

/-! simp-lemmas about `denote` functions -/
section Lemmas

@[simp] lemma HVector.denote_nil
    (T : HVector (fun (t : Ctxt d.Ty × d.Ty) => Com d t.1 .impure t.2) []) :
    HVector.denote T = HVector.nil := by
  cases T; simp [HVector.denote]

@[simp] lemma HVector.denote_cons
    (t : Ctxt d.Ty × d.Ty) (ts : List (Ctxt d.Ty × d.Ty))
    (a : Com d t.1 .impure t.2) (as : HVector (fun t => Com d t.1 .impure t.2) ts) :
    HVector.denote (.cons a as) = .cons (a.denote) (as.denote) := by
  simp [HVector.denote]

@[simp] lemma Com.denote_ret {eff : EffectKind} (Γ : Ctxt d.Ty) (x : Γ.Var t) :
    (Com.ret x : Com d Γ eff t).denote = fun Γv => return (Γv x) := by
  funext Γv
  simp [denote]

@[simp] lemma Com.denote_var [LawfulMonad d.m] {e : Expr d Γ eff α} :
    (Com.var e body).denote =
    fun Γv => (e.denote Γv) >>= (fun v => body.denote (Γv.snoc v)) := by
  funext Γv
  cases eff <;> simp [denote]

@[simp] lemma Com.denoteLets_var (e : Expr d Γ eff t) (body : Com d _ eff u) [LawfulMonad d.m] :
    (Com.var e body).denoteLets =
        (fun V => e.denote V >>= fun Ve => body.denoteLets (V.snoc Ve)) := by
  funext V
  cases eff <;> simp [denoteLets, bind_pure]

@[simp] lemma Com.denoteImpure_ret [Monad d.m] [DialectDenote d] {Γ : Ctxt d.Ty} (x : Γ.Var t) :
  (Com.ret (d:=d) (eff := eff) x).denoteImpure = fun Γv => return (Γv x) := rfl

@[simp] lemma Com.denoteImpure_body [Monad d.m] [DialectDenote d] {Γ : Ctxt d.Ty}
    (e : Expr d Γ eff te) (body : Com d (Γ.snoc te) eff tbody) :
  (Com.var e body).denoteImpure =
  fun Γv => e.denoteImpure Γv >>= fun x => body.denote (Γv.snoc x) := rfl

@[simp] lemma Lets.denote_nil {Γ : Ctxt d.Ty} :
    (Lets.nil : Lets d Γ eff Γ).denote = (return ·) := by
  funext; simp [denote]

@[simp] lemma Lets.denote_var {lets : Lets d Γ_in eff Γ_out} {e : Expr d Γ_out eff t} :
    (lets.var e).denote = fun V_in => (do
      let V_out ← lets.denote V_in
      let x ← e.denote V_out
      return V_out.snoc x) := by
  funext V; simp [denote]



@[simp] lemma Lets.denote_addComToEnd
    {lets : Lets d Γ_in eff Γ_out} {com : Com d Γ_out eff t} :
    Lets.denote (lets.addComToEnd com) = fun V => (do
        let Vlets ← lets.denote V
        let Vbody ← com.denoteLets Vlets
        return Vbody
      ) := by
  induction com
  case ret => simp [Lets.denote_var, Com.denoteLets]
  case var ih => simp [addComToEnd, ih, denote_var]

@[simp] lemma Com.denoteLets_ret : (.ret v : Com d Γ eff t).denoteLets = fun V => pure V := by
  funext V; simp [denoteLets]

theorem Com.denoteLets_eq {com : Com d Γ eff t} : com.denoteLets = com.toLets.denote := by
  simp only [toLets]; induction com using Com.rec' <;> simp [Lets.denote_var]

end Lemmas

/-!
## Refinement
-/
section Refinement
variable [DialectHRefinement d d]

/--
An expression `e₁` is refined by an expression `e₂` (of the same dialect) if their
respective denotations under every valuation are in the refinement relation.
-/
instance: Refinement (Expr d Γ eff t) where
  IsRefinedBy e₁ e₂ :=
    ∀ V, e₁.denote V ⊑ e₂.denote V

/--
A program `c₁` is refined by a program `c₂` (of the same dialect) if their
respective denotations under every valuation are in the refinement relation.
-/
instance: Refinement (Com d Γ eff t) where
  IsRefinedBy c₁ c₂ :=
    ∀ V, c₁.denote V ⊑ c₂.denote V

end Refinement

/-!
## `changeVars`
Map a context homomorphism over a `Expr`/`Com`.
That is, substitute variables.
-/

def Expr.changeVars (varsMap : Γ.Hom Γ') :
    {ty : d.Ty} → (e : Expr d Γ eff ty) → Expr d Γ' eff ty
  | _, ⟨op, sig_eq, eff_leq, args, regArgs⟩ =>
     ⟨op, sig_eq, eff_leq, args.map varsMap, regArgs⟩

def Com.changeVars : Com d Γ eff ty →
    (varsMap : Γ.Hom Γ') →
    Com d Γ' eff ty
  |  .ret e => fun varsMap => .ret (varsMap e)
  |  .var e body => fun varsMap => .var (e.changeVars varsMap)
      (body.changeVars (fun _ v => varsMap.snocMap v))

/-! simp-lemmas about `changeVars`-/

@[simp] lemma Expr.denote_changeVars {Γ Γ' : Ctxt d.Ty}
    (varsMap : Γ.Hom Γ')
    (e : Expr d Γ eff ty) :
    (e.changeVars varsMap).denote =
    fun Γ'v => e.denote (Γ'v.comap varsMap) := by
  funext Γ'v
  rcases e with ⟨_, rfl, _⟩
  simp [Expr.denote, Expr.changeVars, HVector.map_map, Valuation.comap]

@[simp] lemma Com.changeVars_ret (v : Var Γ t) :
    (Com.ret (d:=d) (eff := eff) v).changeVars = fun (map : Γ.Hom Δ) => Com.ret (map v) := by
  funext map
  simp [changeVars]

@[simp] lemma Com.changeVars_var (e : Expr d Γ eff t) (body : Com d _ eff u) :
    (Com.var e body).changeVars
    = fun (map : Γ.Hom Δ) => Com.var (e.changeVars map) (body.changeVars map.snocMap) := by
  simp [changeVars]

-- TODO: this is implied by simpler simp-lemmas, do we need it?
@[simp] lemma Com.outContext_changeVars_ret (varsMap : Γ.Hom Γ') (_ : Com d Γ eff ty) :
  ((Com.ret (d:=d) (eff := eff) v).changeVars varsMap).outContext = Γ' := by simp

@[simp] lemma Com.denote_changeVars
    (varsMap : Γ.Hom Γ') (c : Com d Γ eff ty) :
    (c.changeVars varsMap).denote =
    c.denote ∘ (fun V => V.comap varsMap) := by
  funext Γ'v
  simp only [Function.comp_apply]
  induction c using Com.rec' generalizing Γ'v Γ' with
  | ret x => simp [Com.denote, Com.changeVars, Valuation.comap, *]
  | var _ _ ih =>
    unfold denote
    simp only [changeVars_var]
    split <;> simp_all

@[simp] lemma Com.denote_changeVars' (varsMap : Γ.Hom Γ') (c : Com d Γ eff ty) :
    (c.changeVars varsMap).denote = fun V => c.denote (V.comap varsMap) := by
  simp; rfl

@[simp] def Com.outContext_changeVars_hom {map : Γ.Hom Δ} (map_inv : Δ.Hom Γ) :
    {c : Com d Γ eff ty} → Ctxt.Hom (outContext (changeVars c map)) (outContext c)
  | .ret _        => cast (by simp) map_inv
  | .var _ body  => cast (by simp) <|
      Com.outContext_changeVars_hom (map := map.snocMap) map_inv.snocMap (c := body)

@[simp] lemma Com.denoteLets_returnVar_pure (c : Com d Γ .pure ty) (Γv : Valuation Γ) :
    c.denoteLets Γv c.returnVar = c.denote Γv := by
  induction c using Com.recPure <;> simp_all [denoteLets, denote]

@[simp] lemma Expr.changeVars_changeVars (e : Expr d Γ eff ty) (f : Γ.Hom Δ) (g : Δ.Hom Ξ) :
    (e.changeVars f).changeVars g = e.changeVars (f.comp g) := by
  rcases e with ⟨op, ty_eq, eff_le, args, regArgs⟩
  simp only [changeVars, HVector.map_map, mk.injEq, heq_eq_eq, and_true, true_and]
  rfl

/-!
## FlatCom
An alternative representation of a program as a `Lets` with a return `Var`
-/

/-- `FlatCom Γ eff Δ ty` represents a program as a sequence `Lets Γ eff Δ` and a `Var Δ ty`.
This is isomorphic to `Com Γ eff ty`, where `Δ` is `com.outContext` -/
structure FlatCom (d : Dialect) [DialectSignature d]  (Γ_in : Ctxt d.Ty) (eff : EffectKind)
    (Γ_out : Ctxt d.Ty) (ty : d.Ty) where
  lets : Lets d Γ_in eff Γ_out
  ret : Var Γ_out ty

--TODO: should this be a `@[simp] abbrev`, or just nuked altogether?
/-- Denote the Lets of the FlatICom -/
def FlatCom.denoteLets (flatCom : FlatCom d Γ eff Γ_out t) (Γv : Γ.Valuation) :
    eff.toMonad d.m <| Γ_out.Valuation :=
  flatCom.lets.denote Γv

/-- Denote the lets and the ret of the FlatCom. This is equal to denoting the Com -/
@[simp] abbrev FlatCom.denote [DialectDenote d] (flatCom : FlatCom d Γ eff Γ_out t)
    (Γv : Γ.Valuation) : eff.toMonad d.m (toType t) :=
  flatCom.lets.denote Γv >>= fun Γ'v => return (Γ'v flatCom.ret)

theorem FlatCom.denoteLets_eq [DialectDenote d] (flatCom : FlatCom d Γ eff Γ_out t) :
    flatCom.denoteLets = fun Γv => flatCom.lets.denote Γv := by
  funext Γv
  simp [denoteLets]

theorem FlatCom.denote_eq [DialectDenote d] (flatCom : FlatCom d Γ eff Γ_out t) :
    flatCom.denote = fun Γv => flatCom.lets.denote Γv >>= fun Γ'v => return (Γ'v flatCom.ret) := by
  funext Γv
  simp [denote]

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
  Com.rec' (motive := @fun Γ eff t _ => eff ≤ eff₂ → Com d Γ eff₂ t)
    /- ret v -/       (fun v _h               => ret v)
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
def Com.letPure (e : Expr d Γ .pure t) (body : Com d (Γ.snoc t) eff u) : Com d Γ eff u :=
  body.var (e.castPureToEff eff)

/-- `letSup e body` allows us to combine an expression and body with different effects,
by returning a `Com` whose effect is their join/supremum -/
def Com.letSup (e : Expr d Γ eff₁ t) (body : Com d (Γ.snoc t) eff₂ u) :
    Com d Γ (eff₁ ⊔ eff₂) u :=
  Com.var (e.changeEffect <| by simp) (body.changeEffect <| by simp)

section Lemmas

@[simp] lemma Com.castPureToEff_ret : (ret v : Com d Γ .pure ty).castPureToEff eff = ret v := rfl
@[simp] lemma Com.castPureToEff_var {com : Com d _ .pure ty} {e : Expr d Γ _ eTy} :
    (var e com).castPureToEff eff = var (e.castPureToEff eff) (com.castPureToEff eff) := rfl

@[simp] lemma Lets.castPureToEff_nil : (nil : Lets d Γ_in _ _).castPureToEff eff = nil := rfl
@[simp] lemma Lets.castPureToEff_var {lets : Lets d Γ_in .pure Γ_out}
    {e : Expr d Γ_out .pure eTy} :
    (var lets e).castPureToEff eff = var (lets.castPureToEff eff) (e.castPureToEff eff) :=
  rfl

@[simp] lemma Com.outContext_castPureToEff {com : Com d Γ .pure ty} :
    (com.castPureToEff eff).outContext = com.outContext := by
  induction com using Com.recPure <;> simp [*]

/-- `castPureToEff` does not change the size of a `Com` -/
@[simp] lemma Com.size_castPureToEff {com : Com d Γ .pure ty} :
    (com.castPureToEff eff).size = com.size := by
  induction com using Com.recPure <;> simp [*]

@[simp] lemma Lets.addComToEnd_castPureToEff {lets : Lets d Γ_in .pure Γ_out}
    {com : Com d Γ_out .pure ty} :
    (lets.castPureToEff eff).addComToEnd (com.castPureToEff eff)
    = cast (by simp) ((lets.addComToEnd com).castPureToEff eff) := by
  induction com using Com.recPure
  case ret => simp
  case var ih =>
    simp only [Com.castPureToEff_var, Com.outContext_var, addComToEnd_var,
      ← Lets.castPureToEff_var, ih]

@[simp] lemma Com.toLets_castPureToEff {com : Com d Γ .pure ty} :
    (com.castPureToEff eff).toLets = cast (by simp) (com.toLets.castPureToEff eff) := by
  unfold toLets
  rw [show (Lets.nil : Lets d Γ eff Γ) = (Lets.nil.castPureToEff eff) from rfl,
    Lets.addComToEnd_castPureToEff]

@[simp] lemma Com.returnVar_castPureToEff {com : Com d Γ .pure ty} :
    (com.castPureToEff eff).returnVar = com.returnVar.castCtxt (by simp) := by
  induction com using Com.recPure <;> simp_all

/-! denotations of `castPureToEff` -/

@[simp] lemma Expr.denote_castPureToEff {e : Expr d Γ .pure t} :
    denote (e.castPureToEff eff) = fun V => pure (e.denote V) := by
  rcases e with ⟨op, rfl, eff_le, _, _⟩
  cases eff
  case pure => rfl
  case impure =>
    funext V
    simp only [castPureToEff, changeEffect, denote, EffectKind.return_impure_toMonad_eq,
      EffectKind.liftEffect_pure,
      EffectKind.liftEffect_eq_pure_cast (EffectKind.eq_of_le_pure eff_le)]

@[simp] lemma Com.denote_castPureToEff {com : Com d Γ .pure ty} :
    denote (com.castPureToEff eff) = fun V => pure (com.denote V) := by
  funext V; simp only [EffectKind.return_impure_toMonad_eq]
  induction com using Com.recPure <;> simp_all

@[simp] lemma Com.denoteLets_castPureToEff {com : Com d Γ .pure ty} :
    denoteLets (com.castPureToEff eff)
    = fun V => pure (com.denoteLets V |>.comap fun _ v => v.castCtxt (by simp)) := by
  funext V; induction com using Com.recPure <;> simp_all

end Lemmas

/-! ### `Expr.HasPureOp` and `Expr.toPure?` -/
/-- Whether the operation of an expression is pure (which might be evaluated impurely) -/
def Expr.HasPureOp (e : Expr d Γ eff ty) : Prop :=
  DialectSignature.effectKind e.op = .pure

/-- `e.HasPureOp` is decidable -/
instance (e : Expr d Γ eff t) : Decidable (e.HasPureOp) := inferInstanceAs (Decidable <| _ = _)

@[simp] lemma Expr.castPureToEff_pure_eq (e : Expr d Γ .pure t) : e.castPureToEff .pure = e := by
  cases e; simp [castPureToEff, changeEffect]

/-- Attempt to convert a possibly impure expression into a pure expression.
If the expression's operation is impure, return `none` -/
def Expr.toPure? (e : Expr d Γ eff ty) : Option (Expr d Γ .pure ty) :=
  match e with
  | Expr.mk op ty_eq _ args regArgs =>
     match h : DialectSignature.effectKind op with
     | .pure => .some <| Expr.mk op ty_eq (by simp [h]) args regArgs
     | .impure => .none

/-- The operation of a pure expression is necessarily pure -/
theorem Expr.HasPureOp_of_pure : (e : Expr d Γ .pure t) → e.HasPureOp
  | ⟨_, _, eff_le, _, _⟩ => EffectKind.eq_of_le_pure eff_le

/-- Rewrite theorem for an expression with a pure operation (which might be evaluated impurely) -/
theorem Expr.denote_mk_of_pure {op : d.Op} (eff_eq : DialectSignature.effectKind op = .pure)
    (ty_eq : ty = _) (eff_le : DialectSignature.effectKind op ≤ eff₂)
    (args : HVector (Var Γ) (DialectSignature.sig op))
    (regArgs : HVector (fun (t : Ctxt d.Ty × d.Ty) => Com d t.1 EffectKind.impure t.2)
      (DialectSignature.regSig op)) :
    Expr.denote (mk op ty_eq eff_le args regArgs) = (fun (Γv : Valuation Γ) =>
      let d : EffectKind.toMonad .pure d.m ⟦ty⟧ :=
        cast (by rw [eff_eq, ty_eq]) <|
          DialectDenote.denote op (args.map (fun _ v => Γv v)) regArgs.denote
      match eff₂ with
      | .pure => d
      | .impure => return d
    ) := by
  funext Γv
  simp only [denote_unfold, cast_cast, EffectKind.return_impure_toMonad_eq]
  cases eff₂
  · simp only [EffectKind.liftEffect_pure]
    apply eq_of_heq
    trans DialectDenote.denote op (HVector.map (fun x v => Γv v) args) (HVector.denote regArgs)
    · simp
    · symm; simp
  · rw [EffectKind.liftEffect_eq_pure_cast eff_eq]
    simp only [EffectKind.return_impure_toMonad_eq, Pure.pure_cast]
    apply eq_of_heq
    trans (pure (DialectDenote.denote op (HVector.map (fun x v => Γv v) args)
      (HVector.denote regArgs)) : d.m _)
    · simp
    · symm; simp

theorem Expr.denote_of_pure {e : Expr d Γ eff ty} (eff_eq : e.HasPureOp) :
    e.denote = (fun (Γv : Valuation Γ) =>
      let d : EffectKind.toMonad .pure d.m ⟦ty⟧ :=
        cast (by rw [eff_eq, ← e.ty_eq]) <|
          DialectDenote.denote e.op (e.args.map (fun _ v => Γv v)) e.regArgs.denote
      match eff with
      | .pure => d
      | .impure => return d
    ) := by
  rcases e with ⟨op, ty_eq, eff_le, args, regArgs⟩
  simp only [op_mk, EffectKind.toMonad_pure, args_mk, regArgs_mk, EffectKind.toMonad_impure]
  rw [Expr.denote_mk_of_pure (by simpa using eff_eq)]
  cases eff <;> rfl

/-- casting an expr to an impure expr and running it equals running it purely
and returning the value -/
@[simp]
theorem Expr.denote_castPureToEff_impure_eq [LawfulMonad d.m] (e : Expr d Γ .pure t) :
    (e.castPureToEff .impure).denote = fun Γv => return (e.denote Γv) := by
  rcases e with ⟨op, ty_eq, eff_le, args, regArgs⟩
  simp only [castPureToEff, changeEffect, denote_mk_of_pure (EffectKind.eq_of_le_pure eff_le)]

theorem Expr.hasPureOp_of_toPure?_isSome {e : Expr d Γ eff ty} (h : e.toPure?.isSome) :
    e.HasPureOp := by
  rcases e with ⟨op, _, _, _, _⟩
  simp only [Option.isSome, toPure?] at h
  simp only [HasPureOp, op_mk, le_refl, EffectKind.pure_le]
  cases hop : DialectSignature.effectKind op
  · rfl
  · split at h
    next h heq =>
      split at heq
      simp_all; contradiction
    next => contradiction

/-- The denotation of toPure? -/
theorem Expr.denote_toPure? {e : Expr d Γ eff ty} {e': Expr d Γ .pure ty}
    (he : Expr.toPure? e = some e') : e.denote =
    match eff with
    | .pure => e'.denote
    | .impure => pure ∘ e'.denote := by
  funext Γv
  rcases e with ⟨op, ty_eq, eff_le, args, regArgs⟩
  have hasPureOp : DialectSignature.effectKind op = EffectKind.pure := by
    simpa [HasPureOp] using Expr.hasPureOp_of_toPure?_isSome (Option.isSome_iff_exists.mpr ⟨_, he⟩)
  rw [Expr.denote_mk_of_pure hasPureOp]
  have (h) :
      cast h (DialectDenote.denote op (HVector.map (fun x v => Γv v) args) (HVector.denote regArgs))
      = denote e' Γv := by
    unfold denote
    split
    simp only [toPure?] at he
    split at he
    · obtain ⟨rfl, h⟩ := by simpa using he
      obtain ⟨rfl, rfl⟩ := by simpa using h
      simp
    · contradiction
  cases eff <;> simp [this]

/-!
## Combining `Lets` and `Com`

Various machinery to combine `Lets` and `Com`s in various ways.

-/

-- TODO: this doesn't morally fit here, but we can't yoink it up, figure out what to do
/-- Convert a `Com` into a `FlatCom` -/
def Com.toFlatCom {t : d.Ty} (com : Com d Γ .pure t) : FlatCom d Γ .pure com.outContext t :=
  ⟨com.toLets, com.returnVar⟩

/-- Recombine a zipper into a single program by adding the `lets` to the beginning of the `com` -/
def Zipper.toCom (zip : Zipper d Γ_in eff Γ_mid ty) : Com d Γ_in eff ty :=
  go zip.top zip.bot
  where
    go : {Γ_mid : _} → Lets d Γ_in eff Γ_mid → Com d Γ_mid eff ty → Com d Γ_in eff ty
      | _, .nil, com          => com
      | _, .var body e, com  => go body (.var e com)

/-- Add a `Com` directly before the current position of a zipper, while reassigning every
occurence of a given free variable (`v`) of `zip.com` to the output of the new `Com`  -/
def Zipper.insertCom (zip : Zipper d Γ_in eff Γ_mid ty) (v : Var Γ_mid newTy)
    (newCom : Com d Γ_mid eff newTy) : Zipper d Γ_in eff newCom.outContext ty :=
  let newTop := zip.top.addComToEnd newCom
  --  ^^^^^^ The combination of the previous `top` with the `newCom` inserted
  let newBot := zip.bot.changeVars <| newCom.outContextHom.with v newCom.returnVar
  --  ^^^^^^ Adjust variables in `bot` to the intermediate context of the new zipper --- which is
  --         `newCom.outContext` --- while also reassigning `v`
  ⟨newTop, newBot⟩

/-- Add a pure `Com` directly before the current position of a possibly impure
zipper, while r eassigning every occurence of a given free variable (`v`) of
`zip.com` to the output of the new `Com`

This is a wrapper around `insertCom` (which expects `newCom` to have the same effect as `zip`)
and `castPureToEff` -/
def Zipper.insertPureCom (zip : Zipper d Γ_in eff Γ_mid ty) (v : Var Γ_mid newTy)
    (newCom : Com d Γ_mid .pure newTy) : Zipper d Γ_in eff newCom.outContext ty :=
  (by simp : (newCom.castPureToEff eff).outContext = newCom.outContext)
    ▸ zip.insertCom v (newCom.castPureToEff eff)

/-! simp-lemmas -/
section Lemmas

@[simp] lemma Zipper.toCom_nil {com : Com d Γ eff ty} : Zipper.toCom ⟨.nil, com⟩ = com := rfl
@[simp] lemma Zipper.toCom_var {lets : Lets d Γ_in eff Γ_mid} :
    Zipper.toCom ⟨Lets.var lets e, com⟩ = Zipper.toCom ⟨lets, Com.var e com⟩ := rfl

@[simp] theorem Zipper.denote_toCom [LawfulMonad d.m] (zip : Zipper d Γ_in eff Γ_mid ty) :
    zip.toCom.denote = zip.denote := by
  rcases zip with ⟨lets, com⟩
  funext Γv; induction lets <;> simp [Lets.denote, Zipper.denote, *]

@[simp] lemma Zipper.denote_mk {lets : Lets d Γ_in eff Γ_out} {com : Com d Γ_out eff ty} :
    denote ⟨lets, com⟩ = fun V => (lets.denote V) >>= com.denote := rfl

theorem Zipper.denote_insertCom {zip : Zipper d Γ_in eff Γ_mid ty₁}
    {newCom : Com d _ eff newTy} [LawfulMonad d.m] :
    (zip.insertCom v newCom).denote = (fun (V_in : Valuation Γ_in) => do
      let V_mid ← zip.top.denote V_in
      let V_newMid ← newCom.denoteLets V_mid
      zip.bot.denote
        (V_newMid.comap <| newCom.outContextHom.with v newCom.returnVar)
      ) := by
  funext V
  simp [insertCom, Com.denoteLets_eq, Function.comp_def]

/-- Casting the intermediate context is not relevant for the denotation -/
@[simp] lemma Zipper.denoteLets_eqRec_Γ_mid {zip : Zipper d Γ_in eff Γ_mid ty}
    (h : Γ_mid = Γ_mid') :
    denote (h ▸ zip) = zip.denote := by
  subst h; rfl

theorem Zipper.denote_insertPureCom {zip : Zipper d Γ_in eff Γ_mid ty₁}
    {newCom : Com d _ .pure newTy} [LawfulMonad d.m] :
    (zip.insertPureCom v newCom).denote = (fun (V_in : Valuation Γ_in) => do
      let V_mid ← zip.top.denote V_in
      zip.bot.denote
        ((Com.denoteLets newCom V_mid).comap <| newCom.outContextHom.with v newCom.returnVar)
      ) := by
  have (V_mid) (h : Com.outContext (Com.castPureToEff eff newCom) = Com.outContext newCom) :
      ((Com.denoteLets newCom V_mid).comap fun x v => v.castCtxt h).comap
        (newCom.castPureToEff eff).outContextHom
      = (Com.denoteLets newCom V_mid).comap newCom.outContextHom := by
    funext t' ⟨v', hv'⟩
    simp only [Com.outContextHom, Com.outContextDiff, Com.size_castPureToEff]
    rfl
  funext V; simp [insertPureCom, denote_insertCom, Valuation.comap, this]

end Lemmas

/-!
### Semantic preservation of `Zipper.insertPureCom`
Generally, we don't intend for `insertPureCom` to change the semantics of the zipper'd program.
We characterize the condition for this intended property by proving `denote_insertPureCom_eq_of`,
which states that if the reassigned variable `v` in the original `top` of the zipper is semantically
equivalent to the return value of the inserted program `newCom`, then the denotation of the zipper
after insertion agrees with the original zipper. -/
section DenoteInsert

-- @[simp] lemma Valuation.comap_denoteLets_with_outContextHom (com : Com d Γ eff ty)
--     (V : Valuation Γ) :

-- theorem bind_congr_of_supp

/-- Denoting any of the free variables of a program through `Com.denoteLets` just returns the
assignment of that variable in the input valuation -/
@[simp] lemma Com.denoteLets_outContextHom (com : Com d Γ .pure ty) (V : Valuation Γ)
    {vTy} (v : Var Γ vTy) :
    com.denoteLets V (com.outContextHom v) = V v := by
  induction com using Com.recPure
  · simp
  · rw [outContextHom_var]; simp [denoteLets, *]

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
def Lets.getPureExprAux {Γ₁ Γ₂ : Ctxt d.Ty} {t : d.Ty} : Lets d Γ₁ eff Γ₂ → (v : Var Γ₂ t) →
    Option (Expr d (Γ₂.dropUntil v) .pure t)
  | .nil, _ => none
  | .var lets e, v => by
    cases v using Var.casesOn with
      | toSnoc v => exact (Lets.getPureExprAux lets v)
      | last => exact e.toPure?

/-- Get the `Expr` that a var `v` is assigned to in a sequence of `Lets`.
The variables are adjusted so that they are variables in the output context of a lets,
not the local context where the variable appears. -/
def Lets.getPureExpr {Γ₁ Γ₂ : Ctxt d.Ty} (lets : Lets d Γ₁ eff Γ₂) {t : d.Ty} (v : Var Γ₂ t) :
    Option (Expr d Γ₂ .pure t) :=
  Expr.changeVars Ctxt.dropUntilHom <$> getPureExprAux lets v

@[simp] lemma Lets.getPureExpr_nil : getPureExpr (.nil : Lets d Γ eff Γ) v = none := rfl

@[simp] lemma Lets.getPureExpr_var_last (lets : Lets d Γ_in eff Γ_out)
    (e : Expr d Γ_out eff ty) :
    getPureExpr (lets.var e) (Var.last ..)
    = (Expr.changeVars <| Ctxt.Hom.id.snocRight) <$> e.toPure? := by
  rfl
@[simp] lemma Lets.getPureExprAux_var_toSnoc (lets : Lets d Γ_in eff Γ_out)
    (e : Expr d Γ_out eff ty₁) (v : Var Γ_out ty₂) :
    getPureExprAux (lets.var e) (v.toSnoc) = getPureExprAux lets v :=
  rfl

@[simp] lemma Lets.getPureExpr_var_toSnoc (lets : Lets d Γ_in eff Γ_out) (e : Expr d Γ_out _ ty₁)
    (v : Var Γ_out ty₂):
    getPureExpr (lets.var e) (v.toSnoc)
    = (Expr.changeVars <| Ctxt.Hom.id.snocRight) <$> (getPureExpr lets v) := by
  simp only [getPureExpr, Ctxt.dropUntil_toSnoc, Ctxt.dropUntilHom_toSnoc,
    getPureExprAux_var_toSnoc, Option.map_eq_map, Option.map_map, Function.comp_def,
    Expr.changeVars_changeVars];
  rfl

theorem Lets.denote_getPureExprAux [LawfulMonad d.m] {Γ₁ Γ₂ : Ctxt d.Ty} {t : d.Ty}
    {lets : Lets d Γ₁ eff Γ₂} {v : Var Γ₂ t} {ePure : Expr d _ .pure t}
    (he : lets.getPureExprAux v = some ePure)
    (s : Valuation Γ₁)
    (f : Valuation Γ₂ → ⟦t⟧ → eff.toMonad d.m α) :
    (lets.denote s) >>= (fun Γv => f Γv ((ePure.changeVars Ctxt.dropUntilHom).denote Γv))
    = lets.denote s >>= (fun Γv => f Γv (Γv v)) := by
  induction lets
  case nil => simp [getPureExprAux] at he
  case var Γ_out ty body e ih =>
    -- rw [Ctxt.dropUntilHom, Ctxt.Diff.toHom_succ]
    simp only [Expr.denote_changeVars, EffectKind.return_impure_toMonad_eq]
    -- TODO: this seems like there might be a need for a higher level theorem, instead of the cases
    cases v using Var.casesOn with
    | toSnoc v =>
      simp only [getPureExprAux, eq_rec_constant, Var.casesOn_toSnoc, Option.mem_def,
        Option.map_eq_some_iff, Option.bind, Bind.bind] at he
      let f' : Valuation Γ_out → ⟦t⟧ → eff.toMonad d.m α := fun Γv val => do
        let Ve ← e.denote Γv
        let Γv':= (Γv.snoc Ve)
        f Γv' val
      specialize ih he f'
      simp only [Ctxt.Diff.Valid, Ctxt.get?, Expr.denote_changeVars,
        EffectKind.return_impure_toMonad_eq, bind_assoc] at ih
      simp +zetaDelta [denote, ← ih]
    | last =>
      simp only [getPureExprAux, eq_rec_constant, Var.casesOn_last,
        Option.mem_def, Option.some.injEq] at he
      simp only [denote, Expr.denote_toPure? he, EffectKind.toMonad_impure,
        EffectKind.return_impure_toMonad_eq, Ctxt.dropUntil_last, Ctxt.dropUntilHom_last,
        bind_assoc, pure_bind, Valuation.comap_snoc_snocRight, Valuation.comap_id,
        Valuation.snoc_last]
      cases eff <;> simp

theorem Lets.denote_getExpr [LawfulMonad d.m] {Γ₁ Γ₂ : Ctxt d.Ty}
    {lets : Lets d Γ₁ eff Γ₂} {t : d.Ty}
    {v : Var Γ₂ t} {e : Expr d Γ₂ .pure t} (he : lets.getPureExpr v = some e) (s : Valuation Γ₁) :
    (f : Valuation Γ₂ → ⟦t⟧ → eff.toMonad d.m α) →
    (lets.denote s) >>= (fun Γv => f Γv (e.denote Γv))
    = (lets.denote s) >>= (fun Γv => f Γv (Γv v)) := by
  simp only [getPureExpr, Option.map_eq_map, Option.map_eq_some_iff] at he
  rcases he with ⟨e', he, rfl⟩
  apply denote_getPureExprAux
  assumption

/-!
## Mapping
We can map between different dialects
-/

section Map

def RegionSignature.map (f : Ty → Ty') : RegionSignature Ty → RegionSignature Ty' :=
  List.map fun ⟨Γ, ty⟩ => (Γ.map f, f ty)

instance : Functor RegionSignature where
  map := RegionSignature.map

def Signature.map (f : Ty → Ty') : Signature Ty → Signature Ty' :=
  fun sig => {
    sig    := sig.sig.map f
    regSig := sig.regSig.map f
    outTy  := f sig.outTy
  }

instance : Functor Signature where
  map := fun f ⟨sig, regSig, outTy, effKind⟩ =>
    ⟨f <$> sig, f <$> regSig, f outTy, effKind⟩

/-- A dialect morphism consists of a map between operations and a map between types,
such that the signature of operations is respected -/
structure DialectMorphism (d d' : Dialect) [DialectSignature d] [DialectSignature d'] where
  mapOp : d.Op → d'.Op
  mapTy : d.Ty → d'.Ty
  preserves_signature : ∀ op, signature (mapOp op) = mapTy <$> (signature op)

variable {d d' : Dialect} [DialectSignature d] [DialectSignature d'] (f : DialectMorphism d d')

def DialectMorphism.preserves_sig (op : d.Op) :
    DialectSignature.sig (f.mapOp op) = (DialectSignature.sig op).map f.mapTy := by
  simp only [DialectSignature.sig, Function.comp_apply, f.preserves_signature, List.map_eq_map]; rfl

def DialectMorphism.preserves_regSig (op : d.Op) :
    DialectSignature.regSig (f.mapOp op) = (DialectSignature.regSig op).map f.mapTy := by
  simp only [DialectSignature.regSig, Function.comp_apply, f.preserves_signature,
    List.map_eq_map]; rfl

def DialectMorphism.preserves_outTy (op : d.Op) :
    DialectSignature.outTy (f.mapOp op) = f.mapTy (DialectSignature.outTy op) := by
  simp only [DialectSignature.outTy, Function.comp_apply, f.preserves_signature]; rfl

theorem DialectMorphism.preserves_effectKind (op : d.Op) :
    DialectSignature.effectKind (f.mapOp op) = DialectSignature.effectKind op := by
  simp only [DialectSignature.effectKind, Function.comp_apply, f.preserves_signature]; rfl

mutual

-- TODO: `map` is ambiguous, rename it to `changeDialect` (to mirror `changeVars`)
def Com.changeDialect : Com d Γ eff ty → Com d' (f.mapTy <$> Γ) eff (f.mapTy ty)
  | .ret v          => .ret v.toMap
  | .var body rest => .var body.changeDialect rest.changeDialect

def Expr.changeDialect : Expr d Γ eff ty → Expr d' (Γ.map f.mapTy) eff (f.mapTy ty)
  | ⟨op, Eq.refl _, effLe, args, regs⟩ => ⟨
      f.mapOp op,
      (f.preserves_outTy _).symm,
      f.preserves_effectKind _ ▸ effLe,
      f.preserves_sig _ ▸ args.map' f.mapTy fun _ => Var.toMap (f:=f.mapTy),
      f.preserves_regSig _ ▸
        HVector.changeDialect regs
    ⟩

/-- Inline of `HVector.map'` for the termination checker -/
def HVector.changeDialect : ∀ {regSig : RegionSignature d.Ty},
    HVector (fun t => Com d t.fst eff t.snd) regSig
    → HVector (fun t => Com d' t.fst eff t.snd) (f.mapTy <$> regSig : RegionSignature _)
  | _, .nil        => .nil
  | t::_, .cons a as  => .cons a.changeDialect (HVector.changeDialect as)

end

def Lets.changeDialect : Lets d Γ_in eff Γ_out → Lets d' (f.mapTy <$> Γ_in) eff (f.mapTy <$> Γ_out)
  | nil => nil
  | var body e => var (changeDialect body) (e.changeDialect f)

section Lemmas

@[simp] lemma Com.changeDialect_ret (f : DialectMorphism d d') (v : Var Γ t) :
    Com.changeDialect f (Com.ret v : Com d Γ eff t) = Com.ret v.toMap := by
  cases eff <;> simp [changeDialect]

@[simp] lemma Com.changeDialect_var (f : DialectMorphism d d')
    (e : Expr d Γ eff t) (body : Com d _ eff u) :
    (Com.var e body).changeDialect f = Com.var (e.changeDialect f) (body.changeDialect f) := by
  simp only [List.map_eq_map, changeDialect]

@[simp] lemma HVector.changeDialect_nil {eff : EffectKind} (f : DialectMorphism d d') :
    HVector.changeDialect (eff := eff) f nil = nil := by simp [HVector.changeDialect]

end Lemmas

end Map

/-!
## Mapping
-/

--TODO: rename `Mapping` to `PartialHom` and move to the `ErasedContext` file
/-- `Mapping Γ Δ` represents a partial homomorphism from context `Γ` to `Δ`.
It's used to incrementally build a total homorphism -/
abbrev Mapping (Γ Δ : Ctxt d.Ty) : Type :=
  @AList (Σ t, Var Γ t) (fun x => Var Δ x.1)
--^^^^^^ Morally this is `{t : _} → Γ.Var t → Option (Δ.Var t)`
--       We write it as an `AList` for performance reasons

open AList
section AListTheorems

/--
if (k, v) is in s.entries then k is in s.

For mathlib -/ --TODO: upstream this
theorem _root_.AList.mem_of_mem_entries {α : Type _} {β : α → Type _} {s : AList β}
    {k : α} {v : β k} :
    ⟨k, v⟩ ∈ s.entries → k ∈ s := by
  intro h
  rcases s with ⟨entries, nd⟩
  simp only [Membership.mem, keys] at h ⊢
  clear nd
  induction h
  next    => apply List.Mem.head
  next ih => apply List.Mem.tail _ ih

/--
if k is in s, then there is v such that (k, v) is in s.entries.
-/
theorem _root_.AList.mem_entries_of_mem {α : Type _} {β : α → Type _} {s : AList β} {k : α} :
    k ∈ s → ∃ v, ⟨k, v⟩ ∈ s.entries := by
  intro h
  rcases s with ⟨entries, nd⟩
  simp only [Membership.mem, keys, List.keys] at h ⊢
  clear nd;
  induction entries
  next    => contradiction
  next hd tl ih =>
    cases h
    next =>
      use hd.snd
      apply List.Mem.head
    next h =>
      rcases ih h with ⟨v, ih⟩
      exact ⟨v, .tail _ ih⟩
end AListTheorems

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

--TODO: find a name that better encapsulates that it's the *transitive* closure
/-- The free variables of `lets` that are (transitively) referred to by some variable `v`.
Also known as the uses of var. -/
def Lets.vars : Lets d Γ_in eff Γ_out → Var Γ_out t → VarSet Γ_in
  | .nil, v => VarSet.ofVar v
  | .var lets e, v => by
      cases v using Var.casesOn with
      | toSnoc v => exact lets.vars v
      | last => exact (e.args.vars).biUnion (fun v => lets.vars v.2)


/-- `com.vars` is the set of free variables from `Γ` that are (transitively) used by the return
variable of `com` -/
def Com.vars : Com d Γ .pure t → VarSet Γ :=
  fun com => com.toFlatCom.lets.vars com.toFlatCom.ret

theorem Lets.vars_var_eq {lets : Lets d Γ_in eff Γ_out}
  {t: d.Ty} {e : Expr d Γ_out eff t}
  {w : ℕ} {tw : d.Ty} {wh : Ctxt.get? Γ_out w = some tw} :
  Lets.vars (Lets.var lets e) ⟨w + 1, by simpa [Ctxt.snoc] using wh⟩ =
  Lets.vars lets ⟨w, wh⟩ := by simp [Lets.vars]


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

/-!
## Expression Trees
Morally, a pure `Com` can be represented as just a tree of expressions.
We use this intuition to explain what `matchVar` does, but first we give a semi-formal definition
of `ExprTree` and its operations.
-/


mutual
variable (d)

/-- A tree of pure expressions -/
inductive ExprTree (Γ : Ctxt d.Ty) : (ty : d.Ty) → Type
  | mk (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (eff_eq : DialectSignature.effectKind op = .pure)
    (args : ExprTreeBranches Γ <| DialectSignature.sig op)
    --TODO: we should tree-ify the regions as well to make the term model work
    -- /- We don't consider regions to be part of the expression tree, so we keep them as `Com` -/
    -- (regArgs : HVector (fun t : Ctxt d.Ty × d.Ty => Com d t.1 .impure t.2)
    --   (DialectSignature.regSig op))
    : ExprTree Γ ty
  | fvar : Var Γ ty → ExprTree Γ ty

inductive ExprTreeBranches (Γ : Ctxt d.Ty) : List d.Ty → Type
  | nil : ExprTreeBranches Γ []
  | cons : ExprTree Γ t → ExprTreeBranches Γ ts → ExprTreeBranches Γ (t::ts)

end

@[coe]
def ExprTreeBranches.ofHVector : HVector (ExprTree d Γ) ts → ExprTreeBranches d Γ ts
  | .nil        => .nil
  | .cons v vs  => .cons v (ofHVector vs)

mutual

/-- `lets.exprTreeAt v` follows the def-use chain of `v` in `lets` to produce an `ExprTree` whose
free variables are only the free variables of `lets` as a whole -/
def Lets.exprTreeAt : (lets : Lets d Γ_in .pure Γ_out) → (v : Var Γ_out ty) → ExprTree d Γ_in ty
  | .nil, v                       => .fvar v
  | .var body e, ⟨0, Eq.refl _⟩  => e.toExprTree body
  | .var body _, ⟨v+1, h⟩        => body.exprTreeAt ⟨v, h⟩

/-- `e.toExprTree lets` converts a single expression `e` into an expression tree by looking up the
arguments to `e` in `lets` -/
def Expr.toExprTree (lets : Lets d Γ_in .pure Γ_out) (e : Expr d Γ_out .pure ty) :
    ExprTree d Γ_in ty :=
  .mk e.op e.ty_eq (EffectKind.eq_of_le_pure e.eff_le) (argsToBranches e.args)
  where argsToBranches {ts} : HVector (Var Γ_out) ts → ExprTreeBranches d Γ_in ts
    | .nil => .nil
    | .cons v vs => .cons (lets.exprTreeAt v) (argsToBranches vs)

end

/-!
## TermModel
We can syntactically give semantics to any dialect by denoting it with `ExprTrees`
-/

section TermModel

/-- A wrapper around the `Ty` universe of a term model, to prevent the instance of `TyDenote`
leaking to the original type. -/
structure TermModelTy (Ty : Type) where
  ty : Ty

/-- The Term Model of a dialect `d` is a dialect with the exact same operations, types, and
signature as the original dialect `d`, but whose denotation exists of expression trees. -/
def TermModel (d : Dialect) (_Γ : Ctxt d.Ty) : Dialect where
  Op := d.Op
  Ty := TermModelTy d.Ty
  m  := d.m

class PureDialect (d : Dialect) [DialectSignature d] where
  allPure : ∀ (op : d.Op), DialectSignature.effectKind op = .pure

-- trivial instances
instance [Monad d.m] : Monad (TermModel d Γ).m := inferInstanceAs (Monad d.m)

instance : DialectSignature (TermModel d Γ) where
  signature := fun op => TermModelTy.mk <$> signature (d:=d) op

instance : TyDenote (TermModel d Γ).Ty where
  toType := fun ty => ExprTree d Γ ty.1

instance [p : PureDialect d] : DialectDenote (TermModel d Γ) where
  denote := fun op args _regArgs =>
    return .mk op rfl (p.allPure _) (argsToBranches args)
  where
    argsToBranches : {ts : List d.Ty} → HVector _ (TermModelTy.mk <$> ts) → ExprTreeBranches d Γ ts
      | [], .nil          => .nil
      | _::_, .cons a as  => .cons a (argsToBranches as)

variable (d) in
/-- A substitution in context `Γ` maps variables of `Γ` to expression trees in `Δ`,
in a type-preserving manner -/
def Ctxt.Substitution (Γ Δ : Ctxt d.Ty) : Type :=
  {ty : d.Ty} → Γ.Var ty → (ExprTree d Δ ty)

/-- A valuation of the term model w.r.t context `Δ` is exactly a substitution -/
@[coe] def Ctxt.Substitution.ofValuation
    (V : Valuation (Ty:=(TermModel d Δ).Ty) (TermModelTy.mk <$> Γ)) :
    Γ.Substitution d Δ := fun ⟨v, h⟩ =>
  V ⟨v, by simp only [get?] at h; simp [h]⟩

/-- A context homomorphism trivially induces a substitution  -/
@[coe] def Ctxt.Substitution.ofHom {Γ Δ : Ctxt d.Ty} (f : Γ.Hom Δ) : Γ.Substitution d Δ :=
  fun v => .fvar <| f v

def TermModel.morphism : DialectMorphism d (TermModel d Γ) where
  mapOp := id
  mapTy := TermModelTy.mk
  preserves_signature := by intros; rfl

variable [PureDialect d]

/-- `lets.toSubstitution` gives a substitution from each variable in the output context to an
expression tree with variables in the input context by following the def-use chain -/
def Lets.toSubstitution (lets : Lets d Γ_in .pure Γ_out) : Γ_out.Substitution d Γ_in :=
  Ctxt.Substitution.ofValuation <|
    (lets.changeDialect TermModel.morphism).denote fun ⟨ty⟩ ⟨v, h⟩ =>
      ExprTree.fvar ⟨v, by
        simp only [Ctxt.get?, TermModel.morphism, List.map_eq_map,
          List.getElem?_map, Option.map_eq_some_iff] at h
        simp only [Ctxt.get?]
        rcases h with ⟨ty', h_get, h_map⟩
        injection h_map with ty_eq_ty'
        subst ty_eq_ty'
        exact h_get⟩

mutual

/-- `e.applySubstitution σ` replaces occurences of `v` in `e` with `σ v` -/
def ExprTree.applySubstitution (σ : Γ.Substitution d Δ) : ExprTree d Γ ty → ExprTree d Δ ty
  | .fvar v => σ v
  | .mk op (Eq.refl _) eff_eq args => .mk op rfl eff_eq (args.applySubstitution σ)

/-- `es.applySubstitution σ` maps `ExprTree.applySubstution` over `es` -/
def ExprTreeBranches.applySubstitution (σ : Γ.Substitution d Δ) :
    ExprTreeBranches d Γ ty → ExprTreeBranches d Δ ty
  | .nil => .nil
  | .cons a as => .cons (a.applySubstitution σ) (as.applySubstitution σ)

end

end TermModel

/-!
## Matching

-/

mutual

/-- `matchArg lets matchLets args matchArgs map` tries to extends the partial substition `map` by
calling `matchVar lets args[i] matchLets matchArgs[i]` for each pair of corresponding variables,
returning the final partial substiution, or `none` on conflicting assigments -/
def matchArg [DecidableEq d.Op]
    (lets : Lets d Γ_in eff Γ_out) (matchLets : Lets d Δ_in .pure Δ_out) :
    {l : List d.Ty} → HVector (Var Γ_out) l → HVector (Var Δ_out) l →
    Mapping Δ_in Γ_out → Option (Mapping Δ_in Γ_out)
  | _, .nil, .nil, ma => some ma
  | t::l, .cons vₗ vsₗ, .cons vᵣ vsᵣ, ma => do
      let ma ← matchVar (t := t) lets vₗ matchLets vᵣ ma
      matchArg lets matchLets vsₗ vsᵣ ma



/-- `matchVar lets v matchLets w map` tries to extend the partial substition `map`, such that the
transitive expression trees represented by variables `v` and `w` become syntactically equal,
returning the final partial substitution `map'` on success , or `none` on conflicting assignments.

Diagramatically, the contexts are related as follows:
Γ_in --[lets]--> Γ_out <--[map]-- Δ_in --[matchLets]--> Δ_out
                  [v]             [w]

Informally, we want to find a `map` that glues the program `matchLets` to the
end of `lets` such that the expression tree of `v` (in `lets`) is syntactically unified with
the expression tree of `w` (in `matchLets`).

This obeys the hypothetical equation: `(matchLets.exprTreeAt w).changeVars map = lets.exprTreeAt v`
where `exprTreeAt` is a hypothetical definition that gives the expression tree.

NOTE: this only matches on *pure* let bindings in both `matchLets` and `lets`. -/
def matchVar {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty} {t : d.Ty} [DecidableEq d.Op]
    (lets : Lets d Γ_in eff Γ_out) (v : Var Γ_out t) :
    (matchLets : Lets d Δ_in .pure Δ_out) →
    (w : Var Δ_out t) →
    (ma : Mapping Δ_in Γ_out := ∅) →
--   ^^ TODO: find better name for `ma`
    Option (Mapping Δ_in Γ_out)
  /- `matchVar` simultaneously recurses on both `matchLets` and `w`:
    * If the `matchLets` are just `nil`, then the variable `w` is a free variable.
      We update the map with `map[v := w]`, by following the equation:

      (matchLets.exprTreeAt w).changeVars map = lets.exprTreeAt v
      (nil.exprTreeAt w).changeVars map       = lets.exprTreeAt v [matchLets is nil]
      (nil.exprTreeAt w).changeVars map       = lets.exprTreeAt v [w ∈ Δ_out = Δ_in is a free var]
      (w).changeVars map                      = lets.exprTreeAt v [w ∈ Δ_in is a free variable]
      map[w] := v [w ∈ Δ_in is a free variable]

      map : Δ → Γ_out

      (w) : ExprTree Δ
      (w).changeVars (map.toExprTreeMapUsing lets) = lets.exprTreeAt (map w) : ExprTree Γ_in
      lets.exprTreeAt v : ExprTree Γ_in t

    * If `matchLets = .var matchLets' e`, and `w` is `Var.last` (which is to say, `0`), then we
      attempt to unify `e` with `lets.getPureExpr v`.

    * If `matchLets = .var matchLets' e`, and `w` is `w' + 1`, then we recurse and try to
      `matchVar lets v matchLets' w' map` -/
  | .var matchLets _, ⟨w+1, h⟩, ma => -- w† = Var.toSnoc w
      let w := ⟨w, by simp_all[Ctxt.snoc]⟩
      matchVar lets v matchLets w ma
  | @Lets.var _ _ _ _ Δ_out _ matchLets matchExpr , ⟨0, _⟩, ma => do -- w† = Var.last
      let ie ← lets.getPureExpr v
      if hs : ∃ h : ie.op = matchExpr.op, ie.regArgs = (h ▸ matchExpr.regArgs)
      then
        matchArg lets matchLets ie.args (hs.1 ▸ matchExpr.args) ma
      else none
  | .nil, w, ma => -- The match expression is just a free (meta) variable
      match ma.lookup ⟨_, w⟩ with
      | some v₂ =>
        by
          exact if v = v₂
            then some ma
            else none
      | none => some (AList.insert ⟨_, w⟩ v ma)
end

/-- how matchVar behaves on `var` at a successor variable -/
theorem matchVar_var_succ_eq {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty} {t te : d.Ty} [DecidableEq d.Op]
    (lets : Lets d Γ_in eff Γ_out) (v : Var Γ_out t)
    (matchLets : Lets d Δ_in .pure Δ_out)
    (matchE : Expr d Δ_out .pure te)
    (w : ℕ)
    (hw : Ctxt.get? Δ_out w = .some t)
    (ma : Mapping Δ_in Γ_out) :
  matchVar lets v (matchLets := .var matchLets matchE)
    ⟨w + 1, by simp only [Ctxt.get?, Ctxt.snoc, List.getElem?_cons_succ];
               simp only [Ctxt.get?] at hw; apply hw⟩ ma =
  matchVar lets v matchLets ⟨w, hw⟩ ma := by
    conv =>
      lhs
      unfold matchVar

/-- how matchVar behaves on `var` at the last variable. -/
theorem matchVar_var_last_eq {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty} {t : d.Ty} [DecidableEq d.Op]
    (lets : Lets d Γ_in eff Γ_out) (v : Var Γ_out t)
    (matchLets : Lets d Δ_in .pure Δ_out)
    (matchE : Expr d Δ_out .pure t)
    (ma : Mapping Δ_in Γ_out) :
  matchVar lets v (matchLets := .var matchLets matchE) (Var.last _ _) ma =
  (do -- w† = Var.last
    let ie ← lets.getPureExpr v
    if hs : ∃ h : ie.op = matchE.op, ie.regArgs = (h ▸ matchE.regArgs)
    then
      matchArg lets matchLets ie.args (hs.1 ▸ matchE.args) ma
    else none) := by
  conv =>
    lhs
    unfold matchVar

section SubsetEntries

theorem subset_entries (lets : Lets d Γ_in eff Γ_out) [DecidableEq d.Op] :
    (
     ∀  (Δ_out : Ctxt d.Ty)
        (matchLets : Lets d Δ_in EffectKind.pure Δ_out) (l : List d.Ty)
        (argsl : HVector Γ_out.Var l) (argsr : HVector Δ_out.Var l) (ma : Mapping Δ_in Γ_out),
      ∀ varMap ∈ matchArg lets matchLets argsl argsr ma, ma.entries ⊆ varMap.entries
    )
    ∧ (
      ∀ (Δ_out : Ctxt d.Ty) (t : d.Ty) (v : Γ_out.Var t)
        (matchLets : Lets d Δ_in EffectKind.pure Δ_out)
        (w : Var Δ_out t) (ma : Mapping Δ_in Γ_out),
      ∀ varMap ∈ matchVar lets v matchLets w ma, ma.entries ⊆ varMap.entries
    ) := by
  apply matchArg.mutual_induct (d:=d)
  <;> intro Δ_out lets
  · intro ma varMap hvarMap
    simp [matchArg, Option.mem_def, Option.some.injEq] at hvarMap
    subst hvarMap
    exact Set.Subset.refl _

  · intro t inst vl argsl matchLets argsr ma ih_matchVar ih_matchArg varMap hvarMap
    simp only [matchArg, bind, Option.mem_def, Option.bind_eq_some_iff] at hvarMap
    rcases hvarMap with ⟨ma', h1, h2⟩
    have hind : ma'.entries ⊆ _ := ih_matchArg ma' varMap <| by
      simp; exact h2
    have hmut := ih_matchVar ma' <| by simp; exact h1
    apply List.Subset.trans hmut hind

  · intro Δ_out u matchLets matchExpr l h ma
    intro ih_matchVar motive
    intros varMap hvarMap
    simp only [Ctxt.get?, Var.succ_eq_toSnoc, Option.mem_def] at *
    unfold matchVar at hvarMap
    apply motive (varMap := varMap) hvarMap

  · intro Δ_out t_1 matchLets
    intro matchExpr property? ma ih_matchArg varMap ih_matchVar
    simp only [Ctxt.get?, matchVar, bind, Option.bind, Option.mem_def] at *
    split at ih_matchVar
    next     => contradiction
    next e _ =>
      simp only at ih_matchVar
      split_ifs at ih_matchVar with hop
      apply ih_matchArg e hop _ ih_matchVar
  · intro w v₂ b? varMap hvarMap x hx
    simp only [matchVar, Option.mem_def] at *
    split at hvarMap
    case h_1 _p q r _s =>
      split_ifs at hvarMap
      · simp_all
    case h_2 _a _b _c _d e f =>
      simp only [Option.some.injEq] at hvarMap
      subst hvarMap
      rcases x with ⟨x, y⟩
      simp only [← AList.mem_lookup_iff] at *
      by_cases hx : x = ⟨Δ_out, w⟩
      · subst hx; simp_all
      · rwa [AList.lookup_insert_ne hx]
  · intro w ma v₂
    intro b? c? varMap hvarMap
    simp only [Ctxt.get?, Var.succ_eq_toSnoc, Option.mem_def] at *
    unfold matchVar at hvarMap
    split at hvarMap
    split_ifs at hvarMap
    · simp at hvarMap
      simp [hvarMap]
    · simp at hvarMap
      rename_i a b c
      rw [c] at b?
      contradiction
  · intro ma w
    intro b? varMap hvarMap
    simp only [Ctxt.get?, Var.succ_eq_toSnoc, Option.mem_def] at *
    unfold matchVar at hvarMap
    split at hvarMap
    case h_1 _p q r _s =>
      split_ifs at hvarMap
      · simp_all
    case h_2 _a _b _c _d e f =>
      simp only [Option.some.injEq] at hvarMap
      subst hvarMap
      intros x hx
      rcases x with ⟨x, y⟩
      simp only [← AList.mem_lookup_iff] at *
      by_cases hx : x = ⟨Δ_out, w⟩
      · subst hx; simp_all
      · rwa [AList.lookup_insert_ne hx]

theorem subset_entries_matchArg [DecidableEq d.Op]
    {Γ_out Δ_in Δ_out : Ctxt d.Ty}
    {lets : Lets d Γ_in eff Γ_out}
    {matchLets : Lets d Δ_in .pure Δ_out}
    {l : List d.Ty}
    {argsl : HVector (Var Γ_out) l}
    {argsr : HVector (Var Δ_out) l}
    {ma : Mapping Δ_in Γ_out}
    {varMap : Mapping Δ_in Γ_out}
    (hvarMap : varMap ∈ matchArg lets matchLets argsl argsr ma) :
    ma.entries ⊆ varMap.entries :=
  (@subset_entries _ _ _ _ _ _ _ _ _).1 _ _ _ _ _ _ _ hvarMap

/--
matchVar only adds new entries:
  if matchVar lets v matchLets w ma = .some varMap,
  then ma is a subset of varMap.
Said differently, The output mapping of `matchVar` extends the input mapping when it succeeds.
-/
theorem subset_entries_matchVar [DecidableEq d.Op]
    {varMap : Mapping Δ_in Γ_out} {ma : Mapping Δ_in Γ_out}
    {lets : Lets d Γ_in eff Γ_out} {v : Var Γ_out t}
    {matchLets : Lets d Δ_in .pure Δ_out}
    {w : Var Δ_out t}
    (hvarMap : varMap ∈ matchVar lets v matchLets w ma) :
    ma.entries ⊆ varMap.entries :=
  (@subset_entries _ _ _ _ _ _ _ _ _).2 _ _ _ _ _ _ _ hvarMap

end SubsetEntries


-- TODO: this assumption is too strong, we also want to be able to model non-inhabited types
variable [∀ (t : d.Ty), Inhabited (toType t)] [DecidableEq d.Op]

theorem denote_matchVar_matchArg
    {Γ_out Δ_in Δ_out : Ctxt d.Ty} {lets : Lets d Γ_in eff Γ_out}
    {matchLets : Lets d Δ_in .pure Δ_out} :
    {l : List d.Ty} →
    {args₁ : HVector (Var Γ_out) l} →
    {args₂ : HVector (Var Δ_out) l} →
    {ma varMap₁ varMap₂ : Mapping Δ_in Γ_out} →
    (h_sub : varMap₁.entries ⊆ varMap₂.entries) →
    (f₁ : (t : d.Ty) → Var Γ_out t → toType t) →
    (f₂ : (t : d.Ty) → Var Δ_out t → toType t) →
    (hf : ∀ t v₁ v₂ (ma : Mapping Δ_in Γ_out) (ma'),
      (ma ∈ matchVar lets v₁ matchLets v₂ ma') →
      ma.entries ⊆ varMap₂.entries → f₂ t v₂ = f₁ t v₁) →
    (hmatchVar : ∀ vMap (t : d.Ty) (vₗ vᵣ) ma,
      vMap ∈ matchVar (t := t) lets vₗ matchLets vᵣ ma →
      ma.entries ⊆ vMap.entries) →
    (hvarMap : varMap₁ ∈ matchArg lets matchLets args₁ args₂ ma) →
      HVector.map f₂ args₂ = HVector.map f₁ args₁
  | _, .nil, .nil, _, _ => by simp [HVector.map]
  | _, .cons v₁ T₁, .cons v₂ T₂, ma, varMap₁ => by
    intro h_sub f₁ f₂ hf hmatchVar hvarMap
    simp only [HVector.map, HVector.cons.injEq]
    simp only [matchArg, bind, Option.mem_def, Option.bind_eq_some_iff] at hvarMap
    rcases hvarMap with ⟨ma', h₁, h₂⟩
    refine ⟨hf _ _ _ _ _ h₁ (List.Subset.trans ?_ h_sub), ?_⟩
    · apply subset_entries_matchArg (d:=d)
      assumption
    apply denote_matchVar_matchArg (hvarMap := h₂) (hf := hf)
    · exact h_sub
    · exact hmatchVar

variable [LawfulMonad d.m]

section DenoteIntoSubtype

/- TODO: we might not need `denoteIntoSubtype`, if we can prove that `V ∈ supp (lets.denote _)`
implies `lets.getPureExpr v = some e → e.denote V = V v` -/

/-- `e.IsDenotationForPureE Γv x` holds if `x` is the pure value obtained from `e` under valuation
`Γv`, assuming that `e` has a pure operation.
If `e` has an impure operation, the property holds vacuously. -/
abbrev Expr.IsDenotationForPureE (e : Expr d Γ eff ty) (Γv : Valuation Γ) (x : ⟦ty⟧) : Prop :=
  ∀ (ePure : Expr d Γ .pure ty), e.toPure? = some ePure → ePure.denote Γv = x

def Expr.denoteIntoSubtype (e : Expr d Γ_in eff ty) (Γv : Valuation Γ_in) :
    eff.toMonad d.m {x : ⟦ty⟧ // e.IsDenotationForPureE Γv x} :=
  match h_pure : e.toPure? with
    | some ePure => pure ⟨ePure.denote Γv, by simp [IsDenotationForPureE, h_pure]⟩
    | none => (Subtype.mk · (by simp [IsDenotationForPureE, h_pure])) <$> (e.denote Γv)

/-- An alternative version of `Lets.denote`, whose returned type carries a proof that the valuation
agrees with the denotation of every pure expression in `lets`.

Strongly prefer using `Lets.denote` in definitions, but you can use `denoteIntoSubtype` in proofs.
The subtype allows us to carry the property with us when doing congruence proofs inside a bind. -/
def Lets.denoteIntoSubtype (lets : Lets d Γ_in eff Γ_out) (Γv : Valuation Γ_in) :
    eff.toMonad d.m {
      V : Valuation Γ_out // ∀ {t} (v : Var _ t) e, lets.getPureExpr v = some e → e.denote V = V v
    } :=
  match lets with
    | .nil => return ⟨Γv, by simp⟩
    | @Lets.var _ _ _ _ Γ_out eTy body e => do
        let ⟨Vout, h⟩ ← body.denoteIntoSubtype Γv
        let v ← e.denoteIntoSubtype Vout
        return ⟨Vout.snoc v.val, by
          intro t' v'; cases v' using Var.casesOn
          · simpa using h _
          · simpa using v.prop
          ⟩

theorem Expr.denote_eq_denoteIntoSubtype (e : Expr d Γ eff ty) (Γv : Valuation Γ) :
    e.denote Γv = Subtype.val <$> e.denoteIntoSubtype Γv := by
  simp only [denoteIntoSubtype, EffectKind.return_impure_toMonad_eq]
  split
  next h_pure =>
    simp only [denote_toPure? h_pure, map_pure, EffectKind.return_impure_toMonad_eq]
    split <;> rfl
  next => simp

theorem Lets.denote_eq_denoteIntoSubtype (lets : Lets d Γ_in eff Γ_out) (Γv : Valuation Γ_in) :
    lets.denote Γv = Subtype.val <$> (lets.denoteIntoSubtype Γv) := by
  induction lets
  case nil => simp [denoteIntoSubtype]
  case var body e ih =>
    simp [denote, denoteIntoSubtype, ih, Expr.denote_eq_denoteIntoSubtype]


end DenoteIntoSubtype

theorem matchVar_nil {lets : Lets d Γ_in eff Γ_out} :
    matchVar lets v (.nil : Lets d Δ .pure Δ) w ma = some ma' →
    ma'.lookup ⟨_, w⟩ = some v := by
  unfold matchVar
  split
  next h_lookup =>
    split_ifs with v_eq
    · intro h
      injection h with h
      subst v_eq h
      exact h_lookup
    · exact False.elim
  next =>
    intro h
    injection h with h
    simp [← h]

theorem matchVar_var_last {lets : Lets d Γ_in eff Γ_out} {matchLets : Lets d Δ_in .pure Δ_out}
    {matchExpr : Expr d Δ_out .pure ty} :
    matchVar lets v (.var matchLets matchExpr) (Var.last ..) ma = some ma' →
    ∃ args,
      lets.getPureExpr v
        = some ⟨matchExpr.op, matchExpr.ty_eq, matchExpr.eff_le, args, matchExpr.regArgs⟩
      ∧ matchArg lets matchLets args matchExpr.args ma = some ma' := by
  unfold matchVar
  simp only [Option.bind_eq_bind, Option.bind_eq_some_iff, forall_exists_index, and_imp]
  rintro ⟨op', ty_eq', eff_le', args', regArgs'⟩ h_pure h
  rw [h_pure]
  split_ifs at h with regArgs_eq
  simp at regArgs_eq
  rcases regArgs_eq with ⟨rfl, regArgs_eq⟩
  simp at regArgs_eq
  subst regArgs_eq
  simpa using h

@[simp] lemma Lets.denote_var_last_pure (lets : Lets d Γ_in .pure Γ_out)
    (e : Expr d Γ_out .pure ty) (V_in : Valuation Γ_in) :
    Lets.denote (var lets e) V_in (Var.last ..) = e.denote (lets.denote V_in) := by
  simp [Lets.denote]

@[simp] lemma Expr.denote_eq_denote_of {e₁ : Expr d Γ eff ty} {e₂ : Expr d Δ eff ty}
    {Γv : Valuation Γ} {Δv : Valuation Δ}
    (op_eq : e₁.op = e₂.op)
    (h_regArgs : HEq e₁.regArgs e₂.regArgs)
    (h_args : HVector.map (fun _ v => Γv v) (op_eq ▸ e₁.args)
              = HVector.map (fun _ v => Δv v) e₂.args) :
    e₁.denote Γv = e₂.denote Δv := by
  rcases e₁ with ⟨op₁, ty_eq, _, args₁, regArgs₁⟩
  rcases e₂ with ⟨_, _, _, args₂, _⟩
  cases op_eq
  simp_all only [op_mk, regArgs_mk, heq_eq_eq, args_mk]
  subst ty_eq h_regArgs
  rw [denote, denote, h_args]

theorem denote_matchVar2_of_subset
    {lets : Lets d Γ_in eff Γ_out} {v : Var Γ_out t}
    {varMap₁ varMap₂ : Mapping Δ_in Γ_out}
    {s₁ : Valuation Γ_in}
    {ma : Mapping Δ_in Γ_out}
    {matchLets : Lets d Δ_in .pure Δ_out} {w : Var Δ_out t}
    (h_sub : varMap₁.entries ⊆ varMap₂.entries)
    (h_matchVar : varMap₁ ∈ matchVar lets v matchLets w ma)
    (f : Γ_out.Valuation → _ → eff.toMonad d.m α) :
    (lets.denote s₁ >>= (fun Γ_out_lets =>f Γ_out_lets <| (matchLets.denote (fun t' v' =>
        match varMap₂.lookup ⟨t', v'⟩ with
        | .some mappedVar => by exact (Γ_out_lets mappedVar)
        | .none => by exact default)) w))
    = (lets.denote s₁ >>= fun Γ_out_lets => f Γ_out_lets (Γ_out_lets v)) := by
  simp only [lets.denote_eq_denoteIntoSubtype, EffectKind.toMonad_pure, map_eq_pure_bind,
    EffectKind.return_impure_toMonad_eq, bind_assoc, pure_bind]
  congr; funext Vout; congr; next => -- `next` is needed to consume the tags generated by `congr`
  clear s₁ f

  induction matchLets generalizing v ma varMap₁ varMap₂ t
  case nil =>
    simp only [Lets.denote, Id.pure_eq]
    rw [mem_lookup_iff.mpr ?_]
    apply h_sub <| mem_lookup_iff.mp <| matchVar_nil h_matchVar
  case var matchLets matchExpr ih =>
    match w with
    | ⟨w+1, h⟩ =>
      simp only [Option.mem_def, Ctxt.get?, Var.succ_eq_toSnoc, Lets.denote,
        EffectKind.toMonad_pure, Id.pure_eq, Id.bind_eq, Valuation.snoc_toSnoc] at *
      rw [Var.toSnoc, matchVar_var_succ_eq] at h_matchVar
      apply ih h_sub h_matchVar

    | ⟨0, h_w⟩ =>
      obtain rfl : t = _ := by simp only [Ctxt.get?, Ctxt.snoc, List.length_cons, Nat.zero_lt_succ,
        List.getElem?_eq_getElem, List.getElem_cons_zero, Option.some.injEq] at h_w; apply h_w.symm
      have ⟨args, h_pure, h_matchArgs⟩ := matchVar_var_last h_matchVar
      rw [← Vout.property v _ h_pure]
      simp only [Ctxt.get?, Var.zero_eq_last, Lets.denote_var_last_pure]
      apply Expr.denote_eq_denote_of <;> (try rfl)
      simp only [Expr.op_mk, Expr.args_mk]

      apply denote_matchVar_matchArg (hvarMap := h_matchArgs) h_sub
      · intro t v₁ v₂ ma ma' hmem h_ma_sub
        apply ih h_ma_sub hmem
      · exact (fun _ _ _ _ _ h => subset_entries_matchVar h)
/--
if matchVar lets v matchLets w ma = .some varMap,
then informally:

   Γ_in --⟦lets⟧--> Γ_out --comap ma--> Δ_in --⟦matchLets⟧ --> Δ_out --w--> t =
     Γ_in ⟦lets⟧ --> Γ_out --v--> t
-/
theorem denote_matchVar2 {lets : Lets d Γ_in eff Γ_out} {v : Var Γ_out t}
    {varMap : Mapping Δ_in Γ_out}
    {s₁ : Valuation Γ_in}
    {ma : Mapping Δ_in Γ_out}
    {matchLets : Lets d Δ_in .pure Δ_out}
    {w : Var Δ_out t} {f : Γ_out.Valuation → _ → eff.toMonad d.m α} :
    varMap ∈ matchVar lets v matchLets w ma →
    lets.denote s₁ >>= (fun Γvlets =>
          f Γvlets (matchLets.denote (fun t' v' =>
             match varMap.lookup ⟨t', v'⟩ with
             | .some mappedVar => by exact (Γvlets mappedVar)
             | .none => default) w))
    = lets.denote s₁ >>= (fun Γv => f Γv (Γv v)) := by
  apply denote_matchVar2_of_subset (s₁ := s₁) (f := f) (List.Subset.refl _)

--TODO: these simp lemmas should probably be `local`
@[simp] theorem lt_one_add_add (a b : ℕ) : b < 1 + a + b := by
  simp (config := { arith := true })
@[simp] theorem zero_eq_zero : (Zero.zero : ℕ) = 0 := rfl

macro_rules | `(tactic| decreasing_trivial) => `(tactic| simp (config := {arith := true}))


mutual


theorem mem_matchVar_matchArg
    {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty}
    {lets : Lets d Γ_in eff Γ_out}
    {matchLets : Lets d Δ_in .pure Δ_out}
    {l : List d.Ty} {argsₗ : HVector (Var Γ_out) l}
    {argsᵣ : HVector (Var Δ_out) l} {ma : Mapping Δ_in Γ_out}
    {varMap : Mapping Δ_in Γ_out}
    (hvarMap : varMap ∈ matchArg lets matchLets argsₗ argsᵣ ma)
    {t' v'} : ⟨t', v'⟩ ∈ (argsᵣ.vars).biUnion (fun v => matchLets.vars v.2) → ⟨t', v'⟩ ∈ varMap :=
  match l, argsₗ, argsᵣ/- , ma, varMap, hvarMap -/ with
  | .nil, .nil, .nil /- , _, varMap, _ -/ => by simp
  | .cons t ts, .cons vₗ argsₗ, .cons vᵣ args /-, ma, varMap, h -/ => by
    simp only [matchArg, bind, Option.mem_def, Option.bind_eq_some_iff] at hvarMap
    rcases hvarMap with ⟨ma', h₁, h₂⟩
    simp only [HVector.vars_cons, Finset.biUnion_insert, Finset.mem_union,
      Finset.mem_biUnion, Sigma.exists]
    rintro (h | ⟨a, b, hab⟩)
    · exact AList.keys_subset_keys_of_entries_subset_entries
        (subset_entries_matchArg h₂)
        (mem_matchVar (matchLets := matchLets) h₁ h)
    · exact mem_matchVar_matchArg (l := ts) h₂
        (Finset.mem_biUnion.2 ⟨⟨_, _⟩, hab.1, hab.2⟩)

/-- All variables containing in `matchExpr` are assigned by `matchVar`. -/
theorem mem_matchVar
    {varMap : Mapping Δ_in Γ_out} {ma : Mapping Δ_in Γ_out}
    {lets : Lets d Γ_in eff Γ_out} {v : Var Γ_out t} /- : -/
    {matchLets : Lets d Δ_in .pure Δ_out}  {w : Var Δ_out t}
    (hvarMap : varMap ∈ matchVar lets v matchLets w ma)
    {t': _ } {v' : _}
    (hMatchLets : ⟨t', v'⟩ ∈ matchLets.vars w) :
  ⟨t', v'⟩ ∈ varMap :=
  match matchLets, w /- , hvarMap, t', v' -/ with
  | .nil, w /-, h, t', v' -/ => by
    revert hMatchLets
    simp only [Lets.vars, VarSet.ofVar, Finset.mem_singleton, Sigma.mk.inj_iff, and_imp]
    rintro ⟨⟩ ⟨⟩
    simp [matchVar] at hvarMap
    split at hvarMap
    · split_ifs at hvarMap
      · simp at hvarMap
        subst hvarMap
        subst v
        exact AList.lookup_isSome.1 (by simp_all)
    · simp at hvarMap
      subst hvarMap
      simp
-- hl: { fst := x✝¹, snd := x✝ } ∈ HVector.vars (Expr.args matchE)
-- h_v': { fst := t', snd := v' } ∈ Lets.vars matchLets x✝

  | .var matchLets matchE, ⟨w+1, hw'⟩ /-, h, t', v' -/ => by
    have hvar' := matchVar_var_succ_eq
      (lets := lets) (v := v) (matchLets := matchLets) (w := w) (hw := hw')
      (matchE := matchE)
      (ma := ma)
    apply mem_matchVar
      (lets := lets)
      (matchLets := matchLets)
      (w := ⟨w, by simpa[Ctxt.snoc] using hw'⟩)
      (ma := ma)
      (v := v)
      (hMatchLets := by
        have hmatchLets' :=
          Lets.vars_var_eq (lets := matchLets)
            (e := matchE) (w := w) (wh := hw') ▸ hMatchLets
        apply hmatchLets'
      )
    have hvarMap' := hvar' ▸ hvarMap
    apply hvarMap'
  | .var matchLets matchE, ⟨0, hw⟩ /-, h, t', v' -/ => by
    revert hMatchLets
    simp only [Ctxt.get?, Ctxt.snoc, List.getElem?_cons_zero, Option.some.injEq] at hw
    subst hw
    simp only [Lets.vars, Ctxt.get?, Var.zero_eq_last, Var.casesOn_last, Finset.mem_biUnion,
      Sigma.exists, forall_exists_index, and_imp]
    intro _ _ hl h_v'
    obtain ⟨⟨ope, h, args⟩, he₁, he₂⟩ := by
      unfold matchVar at hvarMap
      simp only [bind, Option.mem_def, Option.bind_eq_some_iff] at hvarMap
      simpa [pure, bind] using hvarMap
    subst h
    rw [← Option.dite_none_right_eq_some] at he₂
    split_ifs at he₂ with h
    · dsimp only [Expr.op_mk, Expr.regArgs_mk] at h
      simp only [Expr.op_mk, Expr.args_mk, Option.some.injEq] at he₂
      apply @mem_matchVar_matchArg (matchLets := matchLets) (hvarMap := he₂)
      simp only [Expr.op_mk, Finset.mem_biUnion, Sigma.exists]
      refine ⟨_, _, ?_, h_v'⟩
      rcases matchE  with ⟨_, _, _⟩
      dsimp only [Expr.op_mk, Expr.regArgs_mk] at h
      rcases h with ⟨rfl, _⟩
      exact hl
    exact inferInstance
end

/-- A version of `matchVar` that returns a `Hom` of `Ctxt`s instead of the `AList`,
provided every variable in the context appears as a free variable in `matchExpr`. -/
def matchVarMap {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty} {t : d.Ty}
    (lets : Lets d Γ_in eff Γ_out) (v : Var Γ_out t)
    (matchLets : Lets d Δ_in .pure Δ_out) (w : Var Δ_out t)
    (hvars : ∀ t (v : Var Δ_in t), ⟨t, v⟩ ∈ matchLets.vars w) :
    Option (Δ_in.Hom Γ_out) := do
  match hm : matchVar lets v matchLets w with
  | none => none
  | some m =>
    return fun t v' =>
    match h : m.lookup ⟨t, v'⟩ with
    | some v' => by exact v'
    | none => by
      have := AList.lookup_isSome.2
        (mem_matchVar
            (lets := lets)
            (v := v)
            (w := w)
            (matchLets := matchLets)
            (hvarMap := by simp; apply hm) (hvars t v'))
      simp_all

/-- if matchVarMap lets v matchLets w hvars = .some map,
then ⟦lets; matchLets⟧ = ⟦lets⟧(v)
-/
theorem denote_matchVarMap2 [LawfulMonad d.m] {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty}
    {lets : Lets d Γ_in eff Γ_out}
    {t : d.Ty} {v : Var Γ_out t}
    {matchLets : Lets d Δ_in .pure Δ_out}
    {w : Var Δ_out t}
    {hvars : ∀ t (v : Var Δ_in t), ⟨t, v⟩ ∈ matchLets.vars w}
    {map : Δ_in.Hom Γ_out}
    (hmap : map ∈ matchVarMap lets v matchLets w hvars) (s₁ : Valuation Γ_in)
    (f : Valuation Γ_out → ⟦t⟧ → eff.toMonad d.m α) :
    (lets.denote s₁ >>= (fun Γ_out_v => f Γ_out_v <|
      matchLets.denote (Valuation.comap Γ_out_v map) w))
    = (lets.denote s₁ >>= (fun Γ_out_v => f Γ_out_v <| Γ_out_v v)) := by
  rw [matchVarMap] at hmap
  split at hmap
  next => simp_all
  next hm =>
    rw [← denote_matchVar2 hm]
    simp only [Option.mem_def, Option.some.injEq, pure] at hmap
    subst hmap
    congr
    funext Γ_out_v
    rw [← Lets.denotePure]
    congr
    funext t v
    simp only [Valuation.comap]
    split
    · split <;> simp_all
    · have := AList.lookup_isSome.2 (mem_matchVar hm (hvars _ v))
      simp_all


/-- `splitProgramAtAux pos lets prog`, will return a `Lets` ending
with the `pos`th variable in `prog`, and an `Com` starting with the next variable.
It also returns, the type of this variable and the variable itself as an element
of the output `Ctxt` of the returned `Lets`.  -/
def splitProgramAtAux : (pos : ℕ) → (lets : Lets d Γ₁ eff Γ₂) →
    (prog : Com d Γ₂ eff t) →
    Option (Σ (Γ₃ : Ctxt d.Ty), Lets d Γ₁ eff Γ₃ × Com d Γ₃ eff t × (t' : d.Ty) × Var Γ₃ t')
  | 0, lets, .var e body => some ⟨_, .var lets e, body, _, Var.last _ _⟩
  | _, _, .ret _ => none
  | n+1, lets, .var e body =>
    splitProgramAtAux n (lets.var e) body

theorem denote_splitProgramAtAux [LawfulMonad d.m] : {pos : ℕ} → {lets : Lets d Γ₁ eff Γ₂} →
    {prog : Com d Γ₂ eff t} →
    {res : Σ (Γ₃ : Ctxt d.Ty), Lets d Γ₁ eff Γ₃ × Com d Γ₃ eff t × (t' : d.Ty) × Var Γ₃ t'} →
    (hres : res ∈ splitProgramAtAux pos lets prog) →
    (s : Valuation Γ₁) →
    (res.2.1.denote s) >>= res.2.2.1.denote  = (lets.denote s) >>= prog.denote
  | 0, lets, .var e body, res, hres, s => by
    simp only [splitProgramAtAux, Option.mem_def, Option.some.injEq] at hres
    subst hres
    simp only [Lets.denote, eq_rec_constant, Com.denote]
    simp only [EffectKind.return_impure_toMonad_eq, bind_assoc, pure_bind, Com.denote_var]
  | _+1, _, .ret _, res, hres, s => by
    simp [splitProgramAtAux, Option.mem_def] at hres
  | n+1, lets, .var e body, res, hres, s => by
    rw [splitProgramAtAux] at hres
    cases eff
    case pure =>
      rw [denote_splitProgramAtAux hres s]
      simp [Lets.denote, eq_rec_constant, Ctxt.Valuation.snoc]
    case impure =>
      rw [denote_splitProgramAtAux hres s]
      simp [Lets.denote, eq_rec_constant, Ctxt.Valuation.snoc]

-- TODO: have `splitProgramAt` return a `Zipper`
/-- `splitProgramAt pos prog`, will return a `Lets` ending
with the `pos`th variable in `prog`, and an `Com` starting with the next variable.
It also returns, the type of this variable and the variable itself as an element
of the output `Ctxt` of the returned `Lets`.  -/
def splitProgramAt (pos : ℕ) (prog : Com d Γ₁ eff t) :
    Option (Σ (Γ₂ : Ctxt d.Ty), Lets d Γ₁ eff Γ₂ × Com d Γ₂ eff t × (t' : d.Ty) × Var Γ₂ t') :=
  splitProgramAtAux pos .nil prog

theorem denote_splitProgramAt [LawfulMonad d.m] {pos : ℕ} {prog : Com d Γ₁ eff t}
    {res : Σ (Γ₂ : Ctxt d.Ty), Lets d Γ₁ eff Γ₂ × Com d Γ₂ eff t × (t' : d.Ty) × Var Γ₂ t'}
    (hres : res ∈ splitProgramAt pos prog) (s : Valuation Γ₁) :
     (res.2.1.denote s) >>= res.2.2.1.denote = prog.denote s := by
  rw [denote_splitProgramAtAux hres s]
  cases eff <;> simp

/-
  ## Rewriting
-/

/-- `rewriteAt lhs rhs hlhs pos target`, searches for `lhs` at position `pos` of
`target`. If it can match the variables, it inserts `rhs` into the program
with the correct assignment of variables, and then replaces occurences
of the variable at position `pos` in `target` with the output of `rhs`.  -/
def rewriteAt (lhs rhs : Com d Γ₁ .pure t₁)
    (hlhs : ∀ t (v : Var Γ₁ t), ⟨t, v⟩ ∈ lhs.vars)
    (pos : ℕ) (target : Com d Γ₂ eff t₂) :
    Option (Com d Γ₂ eff t₂) := do
  let ⟨Γ₃, targetLets, target', t', vm⟩ ← splitProgramAt pos target
  if h : t₁ = t'
  then
    let flatLhs := lhs.toFlatCom
    let m ← matchVarMap targetLets vm flatLhs.lets (flatLhs.ret.cast h)
      (by subst h; exact hlhs)
    let zip : Zipper .. := ⟨targetLets, target'⟩;
    let zip := zip.insertPureCom vm (h ▸ rhs.changeVars m)
    return zip.toCom
  else none

@[simp] lemma Com.denote_toFlatCom_lets [LawfulMonad d.m] (com : Com d Γ .pure t) :
    com.toFlatCom.lets.denote = com.denoteLets := by
  funext Γv; simp [toFlatCom, Com.denoteLets_eq]

@[simp] lemma Com.toFlatCom_ret [LawfulMonad d.m] (com : Com d Γ .pure t) :
    com.toFlatCom.ret = com.returnVar := by
  simp [toFlatCom]

theorem denote_rewriteAt [LawfulMonad d.m] (lhs rhs : Com d Γ₁ .pure t₁)
    (hlhs : ∀ t (v : Var Γ₁ t), ⟨t, v⟩ ∈ lhs.vars)
    (pos : ℕ) (target : Com d Γ₂ eff t₂)
    (hl : lhs.denote = rhs.denote)
    (rew : Com d Γ₂ eff t₂)
    (hrew : rew ∈ rewriteAt lhs rhs hlhs pos target) :
    rew.denote = target.denote := by
  funext Γ₂v
  rw [rewriteAt] at hrew
  simp only [bind, pure, Option.bind] at hrew
  split at hrew
  next => simp at hrew
  next a b c hs =>
    simp only [Option.mem_def] at hrew
    split_ifs at hrew
    subst t₁
    split at hrew
    · simp at hrew
    · simp only [Option.some.injEq] at hrew
      subst hrew
      rename_i _ _ h
      simp only [Zipper.denote_toCom, Zipper.denote_insertPureCom, ← hl,
        ← denote_splitProgramAt hs Γ₂v, Valuation.comap_with,
        Valuation.comap_outContextHom_denoteLets, Com.denoteLets_returnVar_pure,
        Com.denote_changeVars, Function.comp_apply]
      have this1 := denote_matchVarMap2 (hmap := h) (s₁ := Γ₂v)
        (f := fun Vtop x =>
            Com.denote c.2.2.1 (Valuation.reassignVar Vtop c.2.2.2.snd x)) -- x : ⟦t'⟧
      simp only [Com.toFlatCom_ret, Var.cast_rfl, Com.denote_toFlatCom_lets,
        Com.denoteLets_returnVar_pure] at this1
      rw [this1]
      congr; funext Γ_out_v; congr
      apply Valuation.reassignVar_eq_of_lookup

variable (d : Dialect) [DialectSignature d] [TyDenote d.Ty] [DialectDenote d] [Monad d.m] in
/--
  Rewrites are indexed with a concrete list of types, rather than an (erased) context, so that
  the required variable checks become decidable
-/
structure PeepholeRewrite (Γ : List d.Ty) (t : d.Ty) where
  lhs : Com d (.ofList Γ) .pure t
  rhs : Com d (.ofList Γ) .pure t
  correct : lhs.denote = rhs.denote

instance {Γ : List d.Ty} {t' : d.Ty} {lhs : Com d (.ofList Γ) .pure t'} :
    Decidable (∀ (t : d.Ty) (v : Var (.ofList Γ) t), ⟨t, v⟩ ∈ lhs.vars) :=
  decidable_of_iff
    (∀ (i : Fin Γ.length),
      let v : Var (.ofList Γ) (Γ.get i) := ⟨i, by simp [List.getElem?_eq_getElem, Ctxt.ofList]⟩
      ⟨_, v⟩ ∈ lhs.vars) <|  by
  constructor
  · intro h t v
    rcases v with ⟨i, hi⟩
    try simp only [Erased.out_mk] at hi
    rcases List.getElem?_eq_some_iff.1 hi with ⟨h', rfl⟩
    simp at h'
    convert h ⟨i, h'⟩
  · intro h i
    apply h

def rewritePeepholeAt (pr : PeepholeRewrite d Γ t)
    (pos : ℕ) (target : Com d Γ₂ eff t₂) :
    (Com d Γ₂ eff t₂) := if hlhs : ∀ t (v : Var (.ofList Γ) t), ⟨_, v⟩ ∈ pr.lhs.vars then
      match rewriteAt pr.lhs pr.rhs hlhs pos target
      with
        | some res => res
        | none => target
      else target


theorem denote_rewritePeepholeAt (pr : PeepholeRewrite d Γ t)
    (pos : ℕ) (target : Com d Γ₂  eff t₂) :
    (rewritePeepholeAt pr pos target).denote = target.denote := by
    simp only [rewritePeepholeAt]
    split_ifs
    case pos h =>
      generalize hrew : rewriteAt pr.lhs pr.rhs h pos target = rew
      cases rew with
        | some res =>
          apply denote_rewriteAt pr.lhs pr.rhs h pos target pr.correct _ hrew
        | none => simp
    case neg h => simp

/-- info: 'denote_rewritePeepholeAt' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms denote_rewritePeepholeAt

/- repeatedly apply peephole on program. -/
section SimpPeepholeApplier

/-- rewrite with `pr` to `target` program, at location `ix` and later, running
at most `fuel` steps. -/
def rewritePeephole_go (fuel : ℕ) (pr : PeepholeRewrite d Γ t)
    (ix : ℕ) (target : Com d Γ₂ eff t₂) : (Com d Γ₂ eff t₂) :=
  match fuel with
  | 0 => target
  | fuel' + 1 =>
     let target' := rewritePeepholeAt pr ix target
     rewritePeephole_go fuel' pr (ix + 1) target'

/-- rewrite with `pr` to `target` program, running at most `fuel` steps. -/
def rewritePeephole (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) (target : Com d Γ₂ eff t₂) : (Com d Γ₂ eff t₂) :=
  rewritePeephole_go fuel pr 0 target

/-- `rewritePeephole_go` preserve semantics -/
theorem denote_rewritePeephole_go (pr : PeepholeRewrite d Γ t)
    (pos : ℕ) (target : Com d Γ₂ eff t₂) :
    (rewritePeephole_go fuel pr pos target).denote = target.denote := by
  induction fuel generalizing pr pos target
  case zero =>
    simp[rewritePeephole_go, denote_rewritePeepholeAt]
  case succ fuel' hfuel =>
    simp[rewritePeephole_go, denote_rewritePeepholeAt, hfuel]

/-- `rewritePeephole` preserves semantics. -/
theorem denote_rewritePeephole (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) (target : Com d Γ₂ eff t₂) :
    (rewritePeephole fuel pr target).denote = target.denote := by
  simp[rewritePeephole, denote_rewritePeephole_go]

/-- info: 'denote_rewritePeephole' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms denote_rewritePeephole

theorem Expr.denote_eq_of_region_denote_eq (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (eff' : DialectSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) (DialectSignature.sig op))
    (regArgs regArgs' : HVector (fun t => Com d t.1 EffectKind.impure t.2)
      (DialectSignature.regSig op))
    (hregArgs' : regArgs'.denote = regArgs.denote) :
  (Expr.mk op ty_eq eff' args regArgs').denote = (Expr.mk op ty_eq eff' args regArgs).denote := by
  funext Γv
  cases eff
  case pure =>
    subst ty_eq
    have heff' : DialectSignature.effectKind op = EffectKind.pure := by simp [eff']
    simp [heff', Expr.denote, hregArgs']
  case impure =>
    subst ty_eq
    simp [Expr.denote, hregArgs']

mutual

def rewritePeepholeRecursivelyRegArgs (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) {ts :  List (Ctxt d.Ty × d.Ty)}
    (args : HVector (fun t => Com d t.1 EffectKind.impure t.2) ts)
    : { out : HVector (fun t => Com d t.1 EffectKind.impure t.2) ts // out.denote = args.denote} :=
  match ts with
  | .nil =>
    match args with
    | .nil => ⟨HVector.nil, rfl⟩
  | .cons .. =>
    match args with
    | .cons com coms =>
      let ⟨com', hcom'⟩ := (rewritePeepholeRecursively fuel pr com)
      let ⟨coms', hcoms'⟩ := (rewritePeepholeRecursivelyRegArgs fuel pr coms)
      ⟨.cons com' coms', by simp [hcom', hcoms']⟩

def rewritePeepholeRecursivelyExpr (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) {ty : d.Ty}
    (e : Expr d Γ₂ eff ty) : { out : Expr d Γ₂ eff ty // out.denote = e.denote } :=
  match e with
  | Expr.mk op ty eff' args regArgs =>
    let ⟨regArgs', hregArgs'⟩ := rewritePeepholeRecursivelyRegArgs fuel pr regArgs
    ⟨Expr.mk op ty eff' args regArgs', by
      apply Expr.denote_eq_of_region_denote_eq op ty eff' args regArgs regArgs' hregArgs'⟩

/-- A peephole rewriter that recurses into regions, allowing
peephole rewriting into nested code. -/
def rewritePeepholeRecursively (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) (target : Com d Γ₂ eff t₂) :
    { out : Com d Γ₂ eff t₂ // out.denote = target.denote } :=
  match fuel with
  | 0 => ⟨target, rfl⟩
  | fuel + 1 =>
    let target' := rewritePeephole fuel pr target
    have htarget'_denote_eq_htarget : target'.denote = target.denote := by
      apply denote_rewritePeephole
    match htarget : target' with
    | .ret v => ⟨target', by
      simp [htarget, htarget'_denote_eq_htarget]⟩
    | .var (α := α) e body =>
      let ⟨e', he'⟩ := rewritePeepholeRecursivelyExpr fuel pr e
      let ⟨body', hbody'⟩ :=
        -- decreases because 'body' is smaller.
        rewritePeepholeRecursively fuel pr body
      ⟨.var e' body', by
        rw [← htarget'_denote_eq_htarget]
        simp [he', hbody']⟩
end

/--
info: 'rewritePeepholeRecursively' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms rewritePeepholeRecursively

end SimpPeepholeApplier

section TypeProjections
variable {d : Dialect} [DialectSignature d] {Γ : Ctxt d.Ty} {eff : EffectKind} {t : d.Ty}

def Com.getTy : Com d Γ eff t → Type := fun _ => d.Ty
def Com.ty : Com d Γ eff t → d.Ty := fun _ => t
def Com.ctxt : Com d Γ eff t → Ctxt d.Ty := fun _ => Γ

def Expr.getTy : Expr d Γ eff t → Type := fun _ => d.Ty
def Expr.ty : Expr d Γ eff t → d.Ty := fun _ => t
def Expr.ctxt : Expr d Γ eff t → Ctxt d.Ty := fun _ => Γ

end TypeProjections
