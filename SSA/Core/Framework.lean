-- Investigations on asymptotic behavior of representing programs with large explicit contexts

import SSA.Core.ErasedContext
import SSA.Core.HVector
import Mathlib.Control.Monad.Basic
import Mathlib.Data.List.AList
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import SSA.Projects.MLIRSyntax.AST -- TODO post-merge: bring into Core
import SSA.Projects.MLIRSyntax.EDSL -- TODO post-merge: bring into Core

open Ctxt (Var VarSet Valuation)
open Goedel (toType)

/-- Lemma that is useful for simplifying states with '(>>=) x f = (>>=) x g' -/
private lemma congrArg2 (f : α → β → γ) {a : α} {b b' : β} (hb : b = b') :
  f a b = f a b' := congrArg _ hb


/- Kinds of effects, either pure or impure -/
inductive EffectKind
| pure -- pure effects.
| impure -- impure, lives in IO.
deriving Repr, DecidableEq

@[reducible]
def EffectKind.toType2 (e : EffectKind) (m : Type → Type) : Type → Type :=
  match e with
  | pure => Id
  | impure => m

section EffectKind
variable {e : EffectKind} {m : Type → Type}

instance [Functor m] : Functor (e.toType2 m) := by cases e <;> infer_instance
instance [Functor m] [LawfulFunctor m] : LawfulFunctor (e.toType2 m) := by
  cases e <;> infer_instance

-- Why do we need the specializations, if we already have the instance for generic `e` above
instance [Functor m] [LawfulFunctor m] : LawfulFunctor (EffectKind.toType2 .impure m) := inferInstance
instance [Functor m] [LawfulFunctor m] : LawfulFunctor (EffectKind.toType2 .pure m) := inferInstance

instance [SeqLeft m]  : SeqLeft (e.toType2 m)  := by cases e <;> infer_instance
instance [SeqRight m] : SeqRight (e.toType2 m) := by cases e <;> infer_instance
instance [Seq m]      : Seq (e.toType2 m)      := by cases e <;> infer_instance

instance [Applicative m] : Applicative (e.toType2 m) := by cases e <;> infer_instance
instance [Applicative m] [LawfulApplicative m] : LawfulApplicative (e.toType2 m) := by
  cases e <;> infer_instance

-- Why do we need the specializations, if we already have the instance for generic `e` above
instance [Applicative m] [LawfulApplicative m] : LawfulApplicative (EffectKind.toType2 .impure m) := inferInstance
instance [Applicative m] [LawfulApplicative m] : LawfulApplicative (EffectKind.toType2 .pure m) := inferInstance

instance [Bind m] : Bind (e.toType2 m)   := by cases e <;> infer_instance
instance [Monad m] : Monad (e.toType2 m) := by cases e <;> infer_instance
instance [Monad m] [LawfulMonad m] : LawfulMonad (e.toType2 m) := by cases e <;> infer_instance

-- Why do we need the specializations, if we already have the instance for generic `e` above
instance [Monad m] : Monad (EffectKind.toType2 .pure m)   := inferInstance
instance [Monad m] : Monad (EffectKind.toType2 .impure m) := inferInstance

-- Why do we need the specializations, if we already have the instance for generic `e` above
instance [Monad m] [LawfulMonad m] : LawfulMonad (EffectKind.toType2 .impure m) := inferInstance
instance [Monad m] [LawfulMonad m] : LawfulMonad (EffectKind.toType2 .pure m) := inferInstance

end EffectKind

def EffectKind.return [Monad m] (e : EffectKind) (a : α) : e.toType2 m α := return a

@[simp] -- return is normal form.
def EffectKind.return_eq [Monad m] (e : EffectKind) (a : α) : e.return a = (return a : e.toType2 m α) := by rfl

@[simp]
def EffectKind.return_pure_toType2_eq (a : α) : (return a : EffectKind.pure.toType2 m α) = a := rfl

@[simp]
def EffectKind.return_impure_toType2_eq [Monad m] (a : α) : (return a : EffectKind.impure.toType2 m α) = (return a : m α) := rfl

@[simp]
def EffectKind.le : EffectKind → EffectKind → Prop
| .pure, _ => True
| .impure, .impure => True
| _, _ => False

@[simp]
def EffectKind.decLe (e e' : EffectKind) : Decidable (EffectKind.le e e') :=
  match e with
  | .pure => match e' with
    | .pure => isTrue (by simp)
    | .impure => isTrue (by simp)
  | .impure => match e' with
    | .pure => isFalse (by simp)
    | .impure => isTrue (by simp)


instance : LE EffectKind where le := EffectKind.le
instance : DecidableRel (LE.le (α := EffectKind)) := EffectKind.decLe

@[simp]
theorem EffectKind.eq_of_le_pure {e : EffectKind}
    (he : e ≤ EffectKind.pure) : e = EffectKind.pure := by
  cases e <;> simp_all [LE.le]


@[simp] theorem EffectKind.not_impure_le_pure : ¬(EffectKind.impure ≤ EffectKind.pure) := by rintro ⟨⟩
-- @[simp] theorem EffectKind.pure_le_pure : EffectKind.pure ≤ EffectKind.pure := by simp[LE.le]
-- @[simp] theorem EffectKind.pure_le_impure : EffectKind.pure ≤ EffectKind.impure := by simp[LE.le]
-- @[simp] theorem EffectKind.impure_le_impure : EffectKind.impure ≤ EffectKind.impure := by simp[LE.le]
@[simp] theorem EffectKind.pure_le (e : EffectKind) : EffectKind.pure ≤ e := by
  cases e <;> constructor
@[simp] theorem EffectKind.le_impure (e : EffectKind) : e ≤ EffectKind.impure := by
  cases e <;> constructor

@[simp]
theorem EffectKind.le_refl (e : EffectKind) : e ≤ e := by cases e <;> simp [LE.le]

@[simp]
theorem EffectKind.le_trans {e1 e2 e3 : EffectKind} (h12: e1 ≤ e2) (h23: e2 ≤ e3) : e1 ≤ e3 := by
  cases e1 <;> cases e2 <;> cases e3 <;> simp_all

@[simp]
theorem EffectKind.le_antisym {e1 e2 : EffectKind} (h12: e1 ≤ e2) (h21: e2 ≤ e1) : e1 ≤ e2 := by
  cases e1 <;> cases e2 <;> simp_all

theorem EffectKind.le_of_eq {e1 e2 : EffectKind} (h : e1 = e2) : e1 ≤ e2 := by
  subst h
  cases e1 <;> simp

def EffectKind.union : EffectKind → EffectKind → EffectKind
| .pure, .pure => .pure
| _, _ => .impure

@[simp] def EffectKind.pure_union_pure_eq : EffectKind.union .pure .pure = .pure := rfl
@[simp] def EffectKind.impure_union_eq : EffectKind.union .impure e = .impure := rfl
@[simp] def EffectKind.union_impure_eq : EffectKind.union e .impure = .impure := by cases e <;> rfl


/-- Given (e1 ≤ e2), we can get a morphism from e1.toType2 x → e2.toType2 x.
Said differently, this is a functor from the skeletal category of EffectKind to Lean. -/
def EffectKind.toType2_hom [Monad m] {e1 e2 : EffectKind} {α : Type}
    (hle : e1 ≤ e2) (v1 : e1.toType2 m α) : e2.toType2 m α :=
  match e1, e2, hle with
    | .pure, .pure, _ | .impure, .impure, _ => v1
    | .pure, .impure, _ => return v1

-- /-- Any value `v : e.toType2 ..` with effect `e` can be transformed to have the `impure` effect -/
-- def EffectKind.promoteToImpure [Monad m] {α : Type} :
--     (e : EffectKind) → e.toType2 m α → EffectKind.impure.toType2 m α
--   | .pure, v => return v
--   | .impure, v => v

@[simp]
theorem EffectKind.toType2_hom_pure_pure [Monad m] (hle : EffectKind.pure ≤ EffectKind.pure) :
    EffectKind.toType2_hom hle (α := α) (m := m) = id :=
  rfl


@[simp]
theorem EffectKind.toType2_hom_pure_impure [Monad m] (hle : EffectKind.pure ≤ EffectKind.impure) :
    EffectKind.toType2_hom hle (α := α) (m := m) = Pure.pure :=
  rfl

@[simp]
theorem EffectKind.toType2_hom_impure_impure [Monad m] (hle : EffectKind.impure ≤ EffectKind.impure) :
    EffectKind.toType2_hom hle (α := α) (m := m) = id :=
  rfl

@[simp]
theorem Effectkind.toType2_hom_impure [Monad m] {e} (hle : e ≤ EffectKind.impure) :
    EffectKind.toType2_hom hle (α := α) (m := m) = match e with
      | .pure => fun v => return v
      | .impure => id := by
  cases e <;> rfl

/-- toType2 is functorial: it preserves identity. -/
@[simp]
theorem EffectKind.toType2_hom_eq_id (hle : eff ≤ eff) [Monad m] :
    EffectKind.toType2_hom hle (α := α) (m := m) = id  := by
  cases eff <;> rfl

/-- toType2 is functorial: it preserves composition. -/
def EffectKind.toType2_hom_compose {e1 e2 e3 : EffectKind} {α : Type} [Monad m]
    (h12 : e1 ≤ e2)
    (h23: e2 ≤ e3)
    (h13: e1 ≤ e3 := EffectKind.le_trans h12 h23) :
    ((EffectKind.toType2_hom (α := α) h23) ∘ (EffectKind.toType2_hom h12)) = EffectKind.toType2_hom (m := m) h13 := by
  cases e1 <;> cases e2 <;> cases e3 <;> (solve | rfl | contradiction)

instance (eff : EffectKind) {m} [Monad m] : MonadLiftT (eff.toType2 m) m where
  monadLift x := match eff with
    | .pure   => return x
    | .impure => x

/-- Type with no inhabitant -/
inductive Void where
def Void.elim (v : Void) : α := nomatch v


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

class OpSignature (Op : Type) (Ty : outParam (Type)) (m : outParam (Type → Type)) where
  signature : Op → Signature Ty
export OpSignature (signature)

def OpSignature.sig [s: OpSignature Op Ty m]        := Signature.sig ∘ s.signature
def OpSignature.regSig [s: OpSignature Op Ty m]      := Signature.regSig ∘ s.signature
def OpSignature.outTy [s: OpSignature Op Ty m]       := Signature.outTy ∘ s.signature
def OpSignature.effectKind [s: OpSignature Op Ty m]    := Signature.effectKind ∘ s.signature

class OpDenote (Op Ty : Type) (m : Type → Type) [Goedel Ty] [OpSignature Op Ty m] where
  denote : (op : Op) → HVector toType (OpSignature.sig op) →
    (HVector (fun t : Ctxt Ty × Ty => t.1.Valuation → EffectKind.impure.toType2 m (toType t.2))
            (OpSignature.regSig op)) →
    ((OpSignature.effectKind op).toType2 m (toType <| OpSignature.outTy op))

/-
Some considerations about purity:

We want pure operations to be able to be run in an impure context (but not vice versa, of course).

However, the current definition of `OpDenote` forces an expressions regions to be of the same purity
as the operation.
In particular, a pure operation which has regions requires those regions to be available as pure
functions `args → result` to be able call `OpDenote.denote`, whereas an instance of this operation
with impure regions would have them be `args → m result`.

Thus, a change to `OpDenote.denote` is necessary (eventually), but the main question there is:
how can we incorporate effect polymorphism without exposing the possibility that a user might
define semantics for an operation that behave differently when running purely vs when running
impurely.

One option is to generalize `OpDenote` to take an effect, like so
```lean
class OpDenote (Op Ty : Type) (m : Type → Type) [Goedel Ty] [OpSignature Op Ty m] where
  denote (op : Op) {eff : EffectKind} (heff : OpSignature.effectKind op ≤ eff)  :
    HVector toType (OpSignature.sig op) →
    (HVector (fun t : Ctxt Ty × Ty => t.1.Valuation → eff.toType2 m (toType t.2))
            (OpSignature.regSig op)) →
    (eff.toType2 m (toType <| OpSignature.outTy op))
```

But, then we'd have to enforce that the semantics don't change when a pure operation is being run
impurely.
```lean
class LawfulOpDenote (Op Ty : Type) (m : Type → Type)
    [Goedel Ty] [OpSignature Op Ty m] [OpDenote Op Ty m] [Monad m] where
  pure_denote (op : Op) (heff : OpSignature.effectKind op = .pure) (args) (regions) :
      pure (OpDenote.denote op (eff:=.pure) (by simp [heff]) args regions)
      = OpDenote.denote op (eff:=.impure) (by simp) args (regions.map fun _ r V => return r V)
```

Another option, which would be more complicated, but correct by construction, is to have the
`denote` function be run within a specific `OpDenoteM` monad, whose monadic actions are
"eval region $x". Assuming the `op` is pure, `OpDenoteM α` could then be evaluated both purely or
impurely.
-/


/- # Datastructures -/


mutual
variable (Op : Type) {Ty : Type} {m : Type → Type} [OpSignature Op Ty m]
/- An intrinsically typed expression whose effect is *at most* EffectKind -/
inductive Expr : (Γ : Ctxt Ty) → (eff : EffectKind) → (ty : Ty) → Type :=
  | mk {Γ} {ty} (op : Op)
    (ty_eq : ty = OpSignature.outTy op)
    (eff_le : OpSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) <| OpSignature.sig op)
    /- For now, assume that regions are impure.
       We keep it this way to minimize the total amount of disruption in our definitions.
       We shall change this once the rest of the file goes through. -/
    (regArgs : HVector (fun t : Ctxt Ty × Ty => Com t.1 .impure t.2)
      (OpSignature.regSig op)) : Expr Γ eff ty


/-- A very simple intrinsically typed program: a sequence of let bindings.
Note that the `EffectKind` is uniform: if a `Com` is `pure`, then the expression and its body are pure,
and if a `Com` is `impure`, then both the expression and the body are impure!
-/
inductive Com : Ctxt Ty → EffectKind → Ty → Type where
  | ret {eff : EffectKind} (v : Var Γ t) : Com Γ eff t
  | lete (e : Expr Γ eff α) (body : Com (Γ.snoc α) eff β) : Com Γ eff β
end

section Repr
open Std (Format)
variable {Op Ty : Type} [OpSignature Op Ty m] [Repr Op] [Repr Ty]

mutual
  def Expr.repr (prec : Nat) : Expr Op Γ eff t → Format
    | ⟨op, _, _, args, _regArgs⟩ => f!"{repr op}{repr args}"

  def Com.repr (prec : Nat) : Com Op eff Γ t → Format
    | .ret v => .align false ++ f!"return {reprPrec v prec}"
    | .lete e body => (.align false ++ f!"{e.repr prec}") ++ body.repr prec
end

instance : Repr (Expr Op Γ eff t) := ⟨flip Expr.repr⟩
instance : Repr (Com Op Γ eff t) := ⟨flip Com.repr⟩

end Repr

--TODO: this should be derived later on when a derive handler is implemented
mutual -- DecEq

protected instance HVector.decidableEqReg [DecidableEq Op] [DecidableEq Ty] [OpSignature Op Ty m] :
    ∀ {l : List (Ctxt Ty × Ty)}, DecidableEq (HVector (fun t => Com Op t.1 .impure t.2) l)
  | _, .nil, .nil => isTrue rfl
  | _, .cons x₁ v₁, .cons x₂ v₂ =>
    letI := HVector.decidableEqReg v₁ v₂
    letI := Com.decidableEq x₁ x₂
    decidable_of_iff (x₁ = x₂ ∧ v₁ = v₂) (by simp)

protected instance Expr.decidableEq [DecidableEq Op] [DecidableEq Ty] [OpSignature Op Ty m] :
    {Γ : Ctxt Ty} → {ty : Ty} → DecidableEq (Expr Op Γ eff ty)
  | _, _, .mk op₁ rfl heff arg₁ regArgs₁, .mk op₂ eq heff' arg₂ regArgs₂ =>
    if ho : op₁ = op₂
    then by
      subst ho
      letI := HVector.decidableEq arg₁ arg₂
      letI := HVector.decidableEqReg regArgs₁ regArgs₂
      exact decidable_of_iff (arg₁ = arg₂ ∧ regArgs₁ = regArgs₂) (by simp)
    else isFalse (by simp_all)

protected instance Com.decidableEq [DecidableEq Op] [DecidableEq Ty] [OpSignature Op Ty m] :
    {Γ : Ctxt Ty} → {ty : Ty} → {eff : EffectKind} → DecidableEq (Com Op Γ eff ty)
  | _, _, eff, .ret v₁, .ret v₂ => decidable_of_iff (v₁ = v₂) (by simp)
  | _, _, eff, .lete (α := α₁) e₁ body₁, .lete (α := α₂) e₂ body₂ =>
    if heff : True
    then
      if hα : α₁ = α₂
      then by
        -- subst heff
        subst hα
        letI := Expr.decidableEq e₁ e₂
        letI := Com.decidableEq body₁ body₂
        exact decidable_of_iff (e₁ = e₂ ∧ body₁ = body₂) (by simp)
      else isFalse (by simp_all)
    else isFalse (by simp_all)
  | _, _, _, .ret _, .lete _ _ => isFalse (fun h => Com.noConfusion h)
  | _, _, _, .lete _ _, .ret _ => isFalse (fun h => Com.noConfusion h)

end -- decEq

/-- `Lets Op Γ₁ Γ₂` is a sequence of lets which are well-formed under context `Γ₂` and result in
    context `Γ₁`-/
inductive Lets (Op : Type) [OpSignature Op Ty m] : Ctxt Ty → EffectKind → Ctxt Ty → Type where
  | nil {eff : EffectKind} {Γ : Ctxt Ty} : Lets Op Γ eff Γ
  | lete (body : Lets Op Γ₁ eff Γ₂) (e : Expr Op Γ₂ eff t) : Lets Op Γ₁ eff (Γ₂.snoc t)
  deriving Repr

/-
  # Definitions
-/

variable {Op Ty : Type} [OpSignature Op Ty m]

@[elab_as_elim]
def Com.recAux' {motive : ∀ {Γ eff t}, Com Op Γ eff t → Sort u}
    (ret : ∀ {Γ t} {eff : EffectKind}, (v : Var Γ t) → motive (eff := eff) (Com.ret v))
    (lete : ∀ {Γ} {t u : Ty} {eff},
      (e : Expr Op Γ eff t) → (body : Com Op (Ctxt.snoc Γ t) eff u) →
        motive body → motive (Com.lete e body)) :
    ∀ {Γ eff t}, (com : Com Op Γ eff t) → motive com
  | _, _, _, Com.ret v => ret v
  | _, _, _, Com.lete e body => lete e body (Com.recAux' ret lete body)

@[implemented_by Com.recAux', elab_as_elim, eliminator]
-- ^^^^ `Com.rec` is noncomputable, so have a computable version as well
--      See `Com.recAux'_eq` for a theorem that states these definitions are equal
def Com.rec' {motive : ∀ {Γ eff t}, Com Op Γ eff t → Sort u}
    (ret : ∀ {Γ t} {eff : EffectKind}, (v : Var Γ t) → motive (eff := eff) (Com.ret v))
    (lete : ∀ {Γ} {t u : Ty} {eff},
      (e : Expr Op Γ eff t) → (body : Com Op (Ctxt.snoc Γ t) eff u) →
        motive body → motive (Com.lete e body)) :
    ∀ {Γ eff t}, (com : Com Op Γ eff t) → motive com :=
  /- HACK: the obvious definition of `rec'` using the match compiler does not have the
     def-eqs we expect. Thus, we directly use the recursion principle. -/
  Com.rec (motive_1 := fun _ _ _ _ => PUnit) (motive_2 := fun _ _ _ c => motive c)
    (motive_3 := fun _ _ => PUnit) (fun _ _ _ _ _ _ => ⟨⟩) -- `Expr.mk` case
    (ret) -- `Com.ret` case
    (fun e body _ r => lete e body r) -- `Com.lete` case
    ⟨⟩ (fun _ _ _ _ => ⟨⟩)

@[simp] lemma Com.rec'_ret (v : Var Γ t) {motive eff} {ret lete} :
    (Com.ret (Op:=Op) (eff := eff) v).rec' (motive:=motive) ret lete = ret v :=
  rfl

@[simp] lemma Com.rec'_lete (e : Expr Op Γ eff t) (body : Com Op _ _ u)
    {motive} {ret lete} :
    (Com.lete e body).rec' (motive:=motive) ret lete
    = lete e body (body.rec' ret lete) :=
  rfl

theorem Com.recAux'_eq {motive : ∀ {Γ eff t}, Com Op Γ eff t → Sort u} :
    Com.recAux' (motive:=motive) = Com.rec' (motive:=motive) := by
  funext ret lete Γ eff t com
  induction com
  next => simp[recAux']
  next ih => simp [recAux', ih]

def Expr.op {Γ : Ctxt Ty} {ty : Ty} (e : Expr Op Γ eff ty) : Op :=
  Expr.casesOn e (fun op _ _ _ _ => op)

theorem Expr.eff_le {Γ : Ctxt Ty} {ty : Ty} (e : Expr Op Γ eff ty) :
  OpSignature.effectKind e.op ≤ eff :=
  Expr.casesOn e (fun _ _ eff_le _ _ => eff_le)

theorem Expr.ty_eq {Γ : Ctxt Ty} {ty : Ty} (e : Expr Op Γ eff ty) :
    ty = OpSignature.outTy e.op :=
  Expr.casesOn e (fun _ ty_eq _ _ _ => ty_eq)

def Expr.args {Γ : Ctxt Ty} {ty : Ty} (e : Expr Op Γ eff ty) :
    HVector (Var Γ) (OpSignature.sig e.op) :=
  Expr.casesOn e (fun _ _ _ args _ => args)

def Expr.regArgs {Γ : Ctxt Ty} {ty : Ty} (e : Expr Op Γ eff ty) :
    HVector (fun t : Ctxt Ty × Ty => Com Op t.1 .impure t.2) (OpSignature.regSig e.op) :=
  Expr.casesOn e (fun _ _ _ _ regArgs => regArgs)

/-! Projection equations for `Expr` -/
@[simp]
theorem Expr.op_mk {Γ : Ctxt Ty} {ty : Ty} {eff : EffectKind} (op : Op)
    (ty_eq : ty = OpSignature.outTy op)
    (eff_le : OpSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) (OpSignature.sig op)) (regArgs):
    (Expr.mk op ty_eq eff_le args regArgs).op = op := rfl

@[simp]
theorem Expr.args_mk {Γ : Ctxt Ty} {ty : Ty} {eff : EffectKind} (op : Op)
    (ty_eq : ty = OpSignature.outTy op)
    (eff_le : OpSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) (OpSignature.sig op)) (regArgs) :
    (Expr.mk op ty_eq eff_le args regArgs).args = args := rfl

@[simp]
theorem Expr.regArgs_mk {Γ : Ctxt Ty} {ty : Ty} {eff : EffectKind} (op : Op)
    (ty_eq : ty = OpSignature.outTy op)
    (eff_le : OpSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) (OpSignature.sig op)) (regArgs) :
    (Expr.mk op ty_eq eff_le args regArgs).regArgs = regArgs := rfl

/-- The `outContext` of a program is a context which includes variables for all let-bindings
of the program. That is, it is the context under which the return value is typed -/
def Com.outContext {Γ} : Com Op Γ eff t → Ctxt Ty :=
  Com.rec' (motive := fun _ => Ctxt Ty)
    (@fun Γ _ _ _ => Γ) -- `Com.ret` case
    (fun _ _ r => r) -- `Com.lete` case

@[simp] theorem Com.outContext_ret (v : Var Γ t) :
    (Com.ret (Op:=Op) (eff := eff) v).outContext = Γ := by
  simp [outContext]

@[simp] theorem Com.outContext_lete {eff} (e : Expr Op Γ eff t) (body : Com Op (Γ.snoc t) eff u) :
    (Com.lete e body).outContext = body.outContext :=
  rfl


/-- The difference between the context `Γ` under which `com` is typed, and the output context of
that same `com` -/
def Com.outContextDiff : ∀ (com : Com Op Γ eff t), Γ.Diff com.outContext
  | .ret _         => Ctxt.Diff.zero _
  | .lete _ body => body.outContextDiff.unSnoc

/-- The return varible of a program -/
def Com.returnVar : (com : Com Op Γ eff t) → Var com.outContext t
  | .ret v => v
  | .lete _ body => body.returnVar

-- TODO: the following `variable` probably means we include these assumptions also in definitions
-- that might not strictly need them, we can look into making this more fine-grained
variable [Goedel Ty] [OpDenote Op Ty m] [DecidableEq Ty] [Monad m]

mutual

def HVector.denote : {l : List (Ctxt Ty × Ty)} → (T : HVector (fun t => Com Op t.1 .impure t.2) l) →
    HVector (fun t => t.1.Valuation → EffectKind.impure.toType2 m (toType t.2)) l
  | _, .nil => HVector.nil
  | _, .cons v vs => HVector.cons (v.denote) (HVector.denote vs)

def Expr.denote {ty : Ty} :  (e : Expr Op Γ eff ty) → (Γv : Valuation Γ) → eff.toType2 m (toType ty)
  | ⟨op, Eq.refl _, heff, args, regArgs⟩, Γv =>
    EffectKind.toType2_hom heff <| OpDenote.denote op (args.map (fun _ v => Γv v)) regArgs.denote

def Com.denote : Com Op Γ eff ty → (Γv : Valuation Γ) → eff.toType2 m (toType ty)
  | .ret e, Γv => pure (Γv e)
  | .lete e body, Γv =>
     match eff with
     | .pure => body.denote (Γv.snoc (e.denote Γv))
     | .impure => e.denote Γv >>= fun x => body.denote (Γv.snoc x)
end

section Unfoldings

/- Equation lemma to unfold `denote`, which does not unfold correctly due to the presence
  of the coercion `ty_eq` and the mutual definition. -/
theorem Expr.denote_unfold  [OP_SIG : OpSignature Op Ty m] [OP_DENOTE: OpDenote Op Ty m]
    (op : Op)
    (ty_eq : ty = OpSignature.outTy op)
    (eff_le : OpSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) <| OpSignature.sig op)
    (regArgs : HVector (fun (t : Ctxt Ty × Ty) => Com Op t.1 .impure t.2)
      (OP_SIG.regSig op))
  : ∀(Γv : Γ.Valuation),
    Expr.denote (Expr.mk op ty_eq eff_le args regArgs) Γv =
    ty_eq ▸ (EffectKind.toType2_hom eff_le  <| OP_DENOTE.denote op (args.map (fun _ v => Γv v)) regArgs.denote) := by
      subst ty_eq
      simp[denote]

end Unfoldings

/-#
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

@[simp]
theorem Com.denote_ret {eff : EffectKind} (Γ : Ctxt Ty) (x : Γ.Var t) [Monad m] :
    (Com.ret x : Com Op Γ eff t).denote = fun Γv => return (Γv x) := by
  funext Γv
  simp [denote]

def Com.denoteLets : (com : Com Op Γ eff ty) → (Γv : Valuation Γ) →
    eff.toType2 m (com.outContext.Valuation)
  | .ret _, V => pure V
  | .lete e body, V =>
      e.denote V >>= fun Ve =>
      body.denoteLets (V.snoc Ve) >>= fun V =>
      return V.cast (by simp [Com.outContext])

def Com.denoteLetsPure : (com : Com Op Γ .pure ty) → (Γv : Valuation Γ) → (com.outContext.Valuation)
  | .ret _, V => V
  | .lete e body, V =>
      let Ve := e.denote V
      let ebody := body.denoteLets (V.snoc Ve)
      ebody

@[simp]
theorem Com.denoteLets_eq_denoteLetsPure (com : Com Op Γ .pure ty) :
    com.denoteLets = com.denoteLetsPure :=
  match com with
  | .ret _ => rfl
  | .lete e body => by
    funext Γv
    simp [Com.denoteLets, Com.denoteLetsPure]

@[simp] theorem Com.denoteLets_lete (e : Expr Op Γ eff t) (body : Com Op _ eff u) [LawfulMonad m] :
    (Com.lete e body).denoteLets =
        (fun V => e.denote V >>= fun Ve => body.denoteLets (V.snoc Ve)) := by
  funext V
  cases eff <;> simp [denoteLets, bind_pure]

/-- Denote an 'Expr' in an unconditionally impure fashion -/
def Expr.denoteImpure (e : Expr Op Γ eff ty) (Γv : Valuation Γ) : EffectKind.impure.toType2 m (toType ty) :=
  liftM <| e.denote Γv

/-- Show that 'Com.denote lete e body' can be seen as denoting the `e` impurely, and then denoting `body`. -/
theorem Com.denote_lete_eq_of_denoteImpure_expr [LawfulMonad m] {e : Expr Op Γ eff α} :
    (Com.lete e body).denote =
    fun Γv => (liftM <| e.denote (m := m) Γv) >>= (fun v => body.denote (Γv.snoc v)) := by
  funext Γv
  cases eff <;> simp [liftM, monadLift, denote]

@[simp]
theorem Com.denote_lete_eq_of_denoteImpure_expr' [LawfulMonad m] {e : Expr Op Γ eff α} :
    (Com.lete e body).denote = fun Γv => (liftM <| e.denote Γv) >>= (fun v => body.denote (Γv.snoc v)) := by
 apply Com.denote_lete_eq_of_denoteImpure_expr


/-- rewrite `(lete eff e body).denote` in terms of `e.denote` -/
theorem Com.denote_lete_eq_of_denote_expr_eq [LawfulMonad m] {e : Expr Op Γ eff α} {Γv: Valuation Γ} {v : toType α}
    (hv : e.denote Γv = eff.return v) : (Com.lete e body).denote Γv = body.denote (Γv.snoc v) := by
  cases eff
  · simp [denote, hv, EffectKind.return, Applicative.toPure, Pure.pure, pure]
  · simp_all [denote, hv, EffectKind.return, EStateM.bind, Pure.pure, EStateM.pure, Bind.bind]

def Com.denoteImpure : Com Op Γ eff ty → (Γv : Valuation Γ) → EffectKind.impure.toType2 m (toType ty)
  | .ret e, Γv => pure (Γv e)
  | .lete e body, Γv => e.denoteImpure Γv >>= fun x => body.denote (Γv.snoc x)

@[simp]
def Com.denoteImpure_ret [Monad m] [OpDenote Op Ty m] {Γ : Ctxt Ty} (x : Γ.Var t) :
  (Com.ret (Op := Op) (eff := eff) x).denoteImpure = fun Γv => return (Γv x) := rfl

@[simp]
def Com.denoteImpure_body [Monad m] [OpDenote Op Ty m] {Γ : Ctxt Ty}
    (e : Expr Op Γ eff te) (body : Com Op (Γ.snoc te) eff tbody) :
  (Com.lete e body).denoteImpure =
  fun Γv => e.denoteImpure Γv >>= fun x => body.denote (Γv.snoc x) := rfl

/- rewrite `(lete eff e body).denote` in terms of `e.denote` -/
/-
theorem Com.denote_lete_eq_of_denote_expr_eq' {e : Expr Op Γ eff α} {v : toType α}
  (hv : e.denote = fun x => eff.return v) : (Com.lete eff e body).denote = fun Γv => body.denote (Γv.snoc v) := by
  funext Γv
  apply Com.denote_lete_eq_of_denote_expr_eq
  rw [EffectKind.return_eq]
  rw [hv]
  simp
-/

/-
https://leanprover.zulipchat.com/#narrow/stream/270676-lean4/topic/Equational.20Lemmas
Recall that `simp` lazily generates equation lemmas.
Moreover, recall that `simp only` **does not** generate equation lemmas.
*but* if equation lemmas are present, then `simp only` *uses* the equation lemmas.

Hence, we build the equation lemmas by invoking the correct Lean meta magic,
so that `simp only` (which we use in `simp_peephole` can find them!)

This allows `simp only [HVector.denote]` to correctly simplify `HVector.denote`
args, since there now are equation lemmas for it.
-/
#eval Lean.Meta.getEqnsFor? ``HVector.denote
#eval Lean.Meta.getEqnsFor? ``Expr.denote
#eval Lean.Meta.getEqnsFor? ``Com.denote

-- TODO: really, this can be normalized in the free theory of arrows, but who wants that?
def Lets.denote [OpSignature Op Ty m] [OpDenote Op Ty m]
    (lets : Lets Op Γ₁ eff Γ₂) (Γ₁'v : Valuation Γ₁) : (eff.toType2 m <| Valuation Γ₂) :=
  match lets with
  | .nil => return Γ₁'v
  | .lete lets' e =>
      lets'.denote Γ₁'v >>= fun Γ₂'v =>
      e.denote Γ₂'v >>= fun v =>
      return (Γ₂'v.snoc v)


-- TODO: really, this can be normalized in the free theory of arrows, but who wants that?
def Lets.denoteImpure [OpSignature Op Ty m] [OpDenote Op Ty m]
    (lets : Lets Op Γ₁ eff Γ₂) (Γ₁'v : Valuation Γ₁) : (EffectKind.impure.toType2 m <| Valuation Γ₂) :=
  match lets with
  | .nil => EffectKind.impure.return Γ₁'v
  | .lete lets' e =>
      lets'.denote Γ₁'v  >>= fun Γ₂'v =>
      e.denote Γ₂'v >>= fun v =>
      return (Γ₂'v.snoc v)

def Expr.changeVars (varsMap : Γ.Hom Γ') :
    {ty : Ty} → (e : Expr Op Γ eff ty) → Expr Op Γ' eff ty
  | _, ⟨op, sig_eq, eff_leq, args, regArgs⟩ =>
     ⟨op, sig_eq, eff_leq, args.map varsMap, regArgs⟩

@[simp] theorem Lets.denote_nil {Γ : Ctxt Ty} :
    (Lets.nil (Op:=Op) (eff:=eff) (Γ:=Γ)).denote = (return ·) := by
  funext; simp [denote]

@[simp]
theorem Expr.denote_changeVars {Γ Γ' : Ctxt Ty}
    (varsMap : Γ.Hom Γ')
    (e : Expr Op Γ eff ty) :
    (e.changeVars varsMap).denote =
    fun Γ'v => e.denote (fun t v => Γ'v (varsMap v)) := by
  funext Γ'v
  rcases e with ⟨_, rfl, _⟩
  simp [Expr.denote, Expr.changeVars, HVector.map_map]

/-- @alexkeizer: We need this to generate defeqs properly -/
def Com.changeVars : Com Op Γ eff ty →
    (varsMap : Γ.Hom Γ') →
    Com Op Γ' eff ty
  |  .ret e => fun varsMap => .ret (varsMap e)
  |  .lete e body => fun varsMap => .lete (e.changeVars varsMap)
      (body.changeVars (fun t v => varsMap.snocMap v))


@[simp] lemma Com.changeVars_ret (v : Var Γ t) :
    (Com.ret (Op:=Op) (eff := eff) v).changeVars = fun (map : Γ.Hom Δ) => Com.ret (map v) := by
  funext map
  simp [changeVars]

@[simp] lemma Com.changeVars_lete (e : Expr Op Γ eff t) (body : Com Op _ eff u) :
    (Com.lete e body).changeVars
    = fun (map : Γ.Hom Δ) => Com.lete (e.changeVars map) (body.changeVars map.snocMap) := by
  simp [changeVars]


@[simp] theorem Com.outContext_changeVars_ret (varsMap : Γ.Hom Γ') (c : Com Op Γ eff ty) :
  ((Com.ret (Op:=Op) (eff := eff) v).changeVars varsMap).outContext = Γ' := by simp

@[simp]
theorem Com.denote_changeVars
    (varsMap : Γ.Hom Γ') (c : Com Op Γ eff ty) :
    (c.changeVars varsMap).denote =
    c.denote ∘ (fun V t v => V <| varsMap v) := by
  funext Γ'v
  simp only [Function.comp_apply]
  induction c using Com.rec' generalizing Γ'v Γ' with
  | ret x => simp [Com.denote, Com.changeVars, *]
  | lete _ _ ih =>
    rename_i eff _ _ -- get effect
    cases eff
    · rw [changeVars, denote, ih]
      simp [denote]
      apply congrArg2
      funext t v
      simp only [Ctxt.Valuation.snoc, Ctxt.Hom.snocMap, Expr.denote_changeVars, denote]
      cases v using Var.casesOn <;> simp [ih]
    · rw [changeVars, denote]
      simp [Bind.bind, denote]
      apply congrArg2
      funext x
      rw [ih]
      apply congrArg2
      funext t v
      simp only [Ctxt.Valuation.snoc, Ctxt.Hom.snocMap, Expr.denote_changeVars, denote]
      cases v using Var.casesOn <;> simp [ih]

@[simp] theorem Com.denote_changeVars' (varsMap : Γ.Hom Γ') (c : Com Op Γ eff ty) :
    (c.changeVars varsMap).denote = fun V => c.denote (V.comap varsMap) := by
  simp; rfl

/-- The result returned by `addPureComToEndOfLets`
-- TODO: this is now the same as a FlatCom? -/
structure FlatCom (Op : _) {Ty : _} [OpSignature Op Ty m]  (Γ_in : Ctxt Ty) (eff : EffectKind) (Γ_out_new : Ctxt Ty) (ty : Ty) where
  -- /-- The new out context -/
  -- {Γ_out_new : Ctxt Ty}
  /-- The new `lets`, with the program added to it -/
  lets : Lets Op Γ_in eff Γ_out_new
  -- /-- The difference between the old out context and the new out context
  --     This induces a context mapping from `Γ_out` to `Γ_out_new` -/
  -- diff : Ctxt.Diff Γ_out Γ_out_new
  /-- The variable in the new `lets` that represent the return value of the added program -/
  ret : Var Γ_out_new ty


/-- Denote the Lets of the FlatICom -/
def FlatCom.denoteLets (flatCom : FlatCom Op Γ eff Γ_out t) (Γv : Γ.Valuation) :
    eff.toType2 m <| Γ_out.Valuation :=
  flatCom.lets.denote Γv

theorem FlatCom.denoteLets_eq [OpDenote Op Ty m] (flatCom : FlatCom Op Γ eff Γ_out t) :
    flatCom.denoteLets = fun Γv => flatCom.lets.denote Γv := by
  funext Γv
  simp [denoteLets]

/-- Denote the lets and the ret of the FlatCom. This is equal to denoting the Com -/
def FlatCom.denoteLetsRet [OpDenote Op Ty m] (flatCom : FlatCom Op Γ eff Γ_out t) (Γv : Γ.Valuation) :
    eff.toType2 m (toType t) :=
  flatCom.lets.denote Γv >>= fun Γ'v => return (Γ'v flatCom.ret)

theorem FlatCom.denoteLetsRet_eq [OpDenote Op Ty m] (flatCom : FlatCom Op Γ eff Γ_out t) :
    flatCom.denoteLetsRet = fun Γv => flatCom.lets.denote Γv >>= fun Γ'v => return (Γ'v flatCom.ret) := by
  funext Γv
  simp [denoteLetsRet]

@[simp]
abbrev FlatCom.denote [OpDenote Op Ty m] (flatCom : FlatCom Op Γ eff Γ_out t) :=
  FlatCom.denoteLetsRet flatCom

/-- cast a pure Expr into a pure or impure expression -/
def Expr.castPureToEff (eff : EffectKind) : (Expr Op Γ .pure t) → Expr Op Γ eff t
| Expr.mk op ty_eq eff_le args regArgs =>
  have heff : OpSignature.effectKind op ≤ eff := by
    apply EffectKind.le_trans eff_le (EffectKind.pure_le eff)
  Expr.mk op ty_eq heff args regArgs

@[simp]
def Expr.castPureToEff_pure_eq (e : Expr Op Γ .pure t) : e.castPureToEff .pure = e := by
  cases e; simp[castPureToEff]

/-- casting an expr to an impure expr and running it equals running it purely and returning the value -/
@[simp]
def Expr.denote_castPureToEff_impure_eq [LawfulMonad m] (e : Expr Op Γ .pure t) :
    (e.castPureToEff .impure).denote = fun Γv => return (e.denote Γv) := by
  rename_i opsig _goedel _denote _deceq _monad
  unfold Expr.denote
  unfold castPureToEff
  cases opsig
  case mk sig =>
    simp[OpSignature.effectKind, OpSignature.outTy, OpSignature.regSig] at *
    cases e
    case mk op regArgs args eff_le ty_eq => -- ty_eq eff_le args regArgs =>
      subst ty_eq
      funext Γv
      simp [castPureToEff]
      sorry


/-- Add a pure Com to the end of a sequence of lets -/
def addPureComToEndOfLetsAux {Γ_out} {eff} (lets : Lets Op Γ_in eff Γ_out) :
      (com : Com Op Γ_out .pure ty) → FlatCom Op Γ_in eff com.outContext ty
  | Com.ret v => ⟨lets, v⟩
  | Com.lete e body => addPureComToEndOfLetsAux
     (Lets.lete lets (e.castPureToEff eff)) body

/-- Equation lemma for addPureComToEndOfLetsAux -/
@[simp] lemma addPureComToEndOfLetsAux_lete {lets : Lets Op Γ_in eff Γ_out}
    {e : Expr Op Γ_out .pure t} (body : Com Op (Γ_out.snoc t) .pure u) :
    addPureComToEndOfLetsAux lets (Com.lete e body)
    = addPureComToEndOfLetsAux (Lets.lete lets (e.castPureToEff eff)) body := by
  simp [addPureComToEndOfLetsAux]

set_option pp.notation false in
@[simp]
theorem bind_bind_eq [Monad m] [LawfulMonad m] (ma : m a) (f : a → m b) (g : b → m c) :
    (bind (bind ma f) g) = bind ma (f >=> g) := by
  unfold Bind.kleisliRight
  rw [bind_assoc]

@[simp]
theorem denote_addPureComToEndOfLetsAux [LawfulMonad m]
    {lets : Lets Op Γ_in eff Γ_out} {com : Com Op Γ_out .pure t} {V : Γ_in.Valuation} :
    Lets.denote (addPureComToEndOfLetsAux lets com).lets V
    = (do
        let Vlets ← lets.denote V
        let Vbody := com.denoteLetsPure Vlets
        return Vbody
      )
      :=
  match com with
  | .ret v =>  by
    simp [Lets.denote, addPureComToEndOfLetsAux, Com.changeVars, addPureComToEndOfLetsAux, Com.denoteLetsPure]
    cases eff <;> simp
  | .lete e body => by
    simp [Lets.denote, addPureComToEndOfLetsAux, Com.changeVars]
    rw [denote_addPureComToEndOfLetsAux]
    rw [Lets.denote]
    conv =>
      rhs
      simp only [Com.denoteLetsPure]
    cases eff <;> simp

/--
  Add a program to the end of a list of `Lets`,
    given a mapping from variables at the end of `lets`(`Γ_out`) to variables used by the `Com` (`Δ`) returning
  * the new lets
  * a map from variables of the out context of the old lets to the out context of the new lets
  * a variable in the new out context, which is semantically equivalent to the return variable of
    the added program
-/
def addPureComToEndOfLets (lets : Lets Op Γ_in eff Γ_out) (varsMap : Δ.Hom Γ_out) (com : Com Op Δ .pure ty) :
    FlatCom Op Γ_in eff (com.changeVars varsMap).outContext ty :=
  addPureComToEndOfLetsAux lets (com.changeVars varsMap)


/- TODO: this is the exact same as Lets.addProgramAtTop!  -/
def Com.toFlatCom {t : Ty} (com : Com Op Γ .pure t) : FlatCom Op Γ .pure (com.outContext) t :=
  addPureComToEndOfLetsAux  Lets.nil  com

/-
@[simp]
theorem Com.denote_toLets_go (lets : Lets Op Γ_in eff Γ_out) (com : Com Op Γ_out eff t) (s : Valuation Γ_in) :
  (fun Γ_out'v => Γ_out'v <| (toLetsAux lets com).ret) <$> ((toLetsAux lets com).lets.denote s) =
    com.denote =<< (lets.denote s) := sorry
-/
/-
  induction com using Com.rec'
  . rfl
  next ih =>
    -- Was just `simp [toFlatCom.go, denote, ih]`
    rw [toFlatCom.go]
    simp [denote, ih]
    congr
    funext _ v
    cases v using Var.casesOn <;> simp[Lets.denote]
-/

/-
@[simp]
theorem Com.denote_eq_denoteLetsRet_toFlatCom_aux (eff : EffectKind) (heff : eff = .pure) (com : Com Op Γ eff t) :
    com.toFlatCom.denoteLetsRet = com.denote := by
 sorry

@[simp]
theorem Com.denote_eq_denoteLetsRet_toFlatCom (com : Com Op Γ .pure t) :
    com.toFlatCom.denoteLetsRet = com.denote := by
 sorry
 -/

/-
@[simp] lemma addPureComToEndOfLets_lete {lets : Lets Op Γ_in eff Γ_out} {map : Ctxt.Hom Δ Γ_out}
    {e : Expr Op Δ .pure t} {body : Com Op (Δ.snoc t) .pure t'} :
    addPureComToEndOfLets lets map (Com.lete e body)
    = addPureComToEndOfLets (Lets.lete lets ((e.castPureToEff eff).changeVars map)) map.snocMap body :=
  rfl
-/

-- theorem denote_addProgramToLets_lets [LawfulMonad m] (lets : Lets Op Γ_in Γ_out) {map} {com : Com Op Δ t}
--     (V : Valuation Γ_in) ⦃t⦄ (var : Var Γ_out t) :
--   ((com.changeVars varsMap).outContextDiff.toHom var).denote
--   <$> ((addPureComToEndOfLets lets map com).lets.denote V)
--     = (do
--         let Vlets ← lets.denote V;
--         let _ ← com.denote (Vlets.comap map)
--         return Vlets var
--       ) := by
--   simp only
--   induction com using Com.rec' generalizing lets Γ_in Γ_out V var
--   next =>
--     simp [bind_pure_comp, Com.denote]; rfl
--   next e body ih =>
--     rw [addPureComToEndOfLets]
--     simp [Ctxt.Diff.toHom_unSnoc, ih, Lets.denote, Expr.denoteImpure]
--     rfl

-- theorem denote_addProgramToLets_var [LawfulMonad m] {lets : Lets Op Γ_in Γ_out} {map} {com : Com Op Δ t} :
--     ∀ (ll : Valuation Γ_in),
--       (fun Γ_out'v => Γ_out'v <| (addPureComToEndOfLets lets map com).var) <$>
--         ((addPureComToEndOfLets lets map com).lets.denote ll)
--       = (lets.denote ll) >>= (fun Γ_out'v => com.denote (Γ_out'v.comap map)) := by
--   intro ll
--   induction com using Com.rec' generalizing lets Γ_out
--   next =>
--     simp [Com.denote, bind_pure_comp]; rfl
--   next e body ih =>
--     unfold addPureComToEndOfLets addProgramToEndOfLets.go
--     simp [Lets.denote, ih, Com.denote, Expr.denoteImpure]
--     rfl

-- @[simp] lemma addPureComToEndOfLets_lete {lets : Lets Op Γ_in Γ_out} {map : Δ.Hom Γ_out}
--     {eff} {e : Expr Op Δ eff t} {body : Com Op _ t'} :
--     addPureComToEndOfLets lets map (Com.lete eff e body)
--     = let lets := Lets.lete eff lets (e.changeVars varsMap)
--       let l := addPureComToEndOfLets lets (varsMap.snocMap) body
--       ⟨l.lets, l.diff.unSnoc, l.var⟩ := by
--   simp [addPureComToEndOfLets]
--   refine ⟨rfl, ?_⟩

/-- eta contraction for pure -/
@[simp]
theorem pure_applied_eq_pure [LawfulMonad m] : (fun (x : a) => (pure x : m a)) = Pure.pure := rfl

/-- combination of bind_pure and eta contraction for pure -/
@[simp]
theorem bind_pure_applied_eq [LawfulMonad m] (ma : m a) : ma >>= (fun (x : a) => (pure x : m a)) = ma := by
  simp

/-- eta contraction for return -/
@[simp]
theorem return_applied_eq_return [LawfulMonad m] : (fun (x : a) => (return x : m a)) = Pure.pure := rfl

/-- combination of bind_return and eta contraction for return -/
@[simp]
theorem bind_return_applied [LawfulMonad m] (ma : m a) : ma >>= (fun (x : a) => (return x : m a)) = ma := by
  simp

@[simp]
theorem denote_addPureComToEndOfLets [LawfulMonad m]
    {lets : Lets Op Γ_in eff Γ_out} {map : Δ.Hom Γ_out} {com : Com Op Δ .pure t} {V : Γ_in.Valuation} :
    Lets.denote (addPureComToEndOfLets lets map com).lets V
    = (do
        let Vlets ← lets.denote V
        let Vbody := (com.changeVars map).denoteLetsPure Vlets
        return Vbody
      )
      :=
  match com with
  | .ret v =>  by
    simp [Lets.denote, addPureComToEndOfLets, addPureComToEndOfLetsAux, Com.changeVars]
  | .lete e body => by
     -- have hbody := denote_addPureComToEndOfLets (lets := lets) (com := body)
    simp [Lets.denote, addPureComToEndOfLets, addPureComToEndOfLetsAux, Com.changeVars]

/-- Add some `Lets` to the beginning of a program -/
def addLetsAtTop : (lets : Lets Op Γ₁ eff Γ₂) → (inputProg : Com Op Γ₂ eff t₂) → Com Op Γ₁ eff t₂
  | Lets.nil, inputProg => inputProg
  | Lets.lete body e, inputProg =>
    addLetsAtTop body (.lete e inputProg)

@[simp]
theorem denote_addLetsAtTop [LawfulMonad m] :
    (lets : Lets Op Γ₁ eff Γ₂) → (inputProg : Com Op Γ₂ eff t₂) →
    (addLetsAtTop lets inputProg).denote =
      lets.denote >=> inputProg.denote
  | Lets.nil, inputProg => by
     funext Γv
     simp [addLetsAtTop, Lets.denote, Bind.kleisliRight]
     cases eff <;> simp
  | Lets.lete body e, inputProg => by
    rw [addLetsAtTop, denote_addLetsAtTop body]
    funext Γ1'v
    simp [Bind.kleisliRight, Lets.denote, addLetsAtTop]
    cases eff <;> simp

/-- `addPureComInMiddleOfLetCom v map top mid bot` appends the programs
`top`, `mid` and `bot`, in that order, while reassigning `v`, a free variable in
`bot`, to the output of `mid`. It also assigns all free variables
in `mid` to variables available at the end of `top` using `map`. -/
def addPureComInMiddleOfLetCom {Γ₁ Γ₂ Γ₃ : Ctxt Ty} (v : Var Γ₂ t₁) (map : Γ₃.Hom Γ₂)
    (top : Lets Op Γ₁ eff Γ₂) (mid : Com Op Γ₃ .pure t₁) (bot : Com Op Γ₂ eff t₂) :
    Com Op Γ₁ eff t₂ :=
  let topMid := addPureComToEndOfLets top map mid
  addLetsAtTop topMid.lets <| bot.changeVars <|
    (mid.changeVars map).outContextDiff.toHom.with v topMid.ret

/-- Reassion the variable var to value val in context ctxt -/
def Ctxt.Valuation.reassignVar {t : Ty} {Γ : Ctxt Ty}
    (V: Γ.Valuation) (var : Var Γ t) (val: toType t) : Γ.Valuation :=
  fun tneedle vneedle =>
    if h : ∃ h : t = tneedle, h ▸ var = var
    then h.fst ▸ val
    else V vneedle

theorem denote_addPureComInMiddleOfLetCom [LawfulMonad m] {Γ₁ Γ₂ Γ₃ : Ctxt Ty}
    (v : Var Γ₂ t₁) (V : Valuation Γ₁) (map : Γ₃.Hom Γ₂)
    (top : Lets Op Γ₁ eff Γ₂) (mid : Com Op Γ₃ .pure t₁) (bot : Com Op Γ₂ eff t₂) :
    (addPureComInMiddleOfLetCom v map top mid bot).denote = fun V => (do
      let Vtop ← top.denote V
      let Vmid := mid.denote (Vtop.comap map)
      bot.denote <| Vtop.reassignVar v Vmid) := by
  funext V
  simp [addPureComInMiddleOfLetCom, denote_addLetsAtTop, Function.comp_apply, Com.denote_changeVars,
    Bind.kleisliLeft, denote_addPureComToEndOfLets, Bind.kleisliRight, Function.comp, bind_assoc]
  cases eff <;> simp
  case h.pure =>
    congr
    /- TODO: find the right theorem here -/
    unfold Valuation.reassignVar
    funext tneedle vneedle
    split_ifs
    case pos hfound =>
     -- found the needle, exploit equalities
     rcases hfound with ⟨⟨⟩, ⟨⟩⟩
     sorry
    sorry
  case h.impure =>
    sorry
  -- congr
  -- funext t' v'
  -- split_ifs
  -- next h =>
  --   rcases h with ⟨⟨⟩, ⟨⟩⟩
  --   simp [denote_addProgramToLets_var]
  -- next h₁ h₂ =>
  --   rcases h₁ with ⟨⟨⟩, ⟨⟩⟩
  --   simp at h₂
  -- next h₁ h₂ =>
  --   rcases h₂ with ⟨⟨⟩, ⟨⟩⟩
  --   simp at h₁
  -- next =>
  --   apply denote_addProgramToLets_lets


def Expr.toPure? (e : Expr Op Γ eff ty) : Option (Expr Op Γ .pure ty) :=
  match e with
  | Expr.mk op ty_eq _ args regArgs =>
     match h : OpSignature.effectKind op with
     | .pure => .some <| Expr.mk op ty_eq (by simp [h]) args regArgs
     | .impure => .none

/-- The denotatio of toPure? -/
theorem Expr.denote_toPure? {e : Expr Op Γ eff ty} {e': Expr Op Γ .pure ty}
    (he : Expr.toPure? e = some e') : e.denote =
    match eff with
    | .pure => e'.denote
    | .impure => pure ∘ e'.denote := by
  funext Γv
  cases e
  case h.mk a b c d e f g  h=>
    subst h
    unfold OpSignature.effectKind at g
    simp[Function.comp] at g
    simp [denote]
    sorry


/-- Get the `Expr` that a var `v` is assigned to in a sequence of `Lets`,
    without adjusting variables
-/
def Lets.getPureExprAux {Γ₁ Γ₂ : Ctxt Ty} {t : Ty} : Lets Op Γ₁ eff Γ₂ → Var Γ₂ t →
    Option ((Δ : Ctxt Ty) × Expr Op Δ .pure t)
  | .nil, _ => none
  | .lete lets e, v => by
    cases v using Var.casesOn with
      | toSnoc v => exact (Lets.getPureExprAux lets v)
      | last => exact (
          match e.toPure? with
          | .none => .none
          | .some e => some ⟨_, e⟩)

/-- If `getPureExprAux` succeeds,
    then the orignal context `Γ₁` is a prefix of the local context `Δ`, and
    their difference is exactly the value of the requested variable index plus 1
-/
def Lets.getExprAuxDiff {lets : Lets Op Γ₁ eff Γ₂} {v : Var Γ₂ t}
    (h : getPureExprAux lets v = some ⟨Δ, e⟩) :
    Δ.Diff Γ₂ :=
  ⟨v.val + 1, by
    intro i t
    induction lets
    next =>
      simp only [getPureExprAux] at h
    next lets e ih =>
      simp only [getPureExprAux, eq_rec_constant] at h
      cases v using Var.casesOn <;> simp at h
      . intro h'
        simp [Ctxt.get?]
        simp[←ih h h', Ctxt.snoc, Var.toSnoc, List.get?]
      . generalize he: Expr.toPure? e = epure
        simp
        rw [he] at h
        cases epure
        case last.none => contradiction
        case last.some =>
          rcases h with ⟨⟨⟩, ⟨⟩⟩
          intro a
          simp_all only [Ctxt.get?, Var.val_last, zero_add, forall_true_left, implies_true]
          exact a
  ⟩

theorem Lets.denote_getExprAux [LawfulMonad m] {Γ₁ Γ₂ Δ : Ctxt Ty} {t : Ty}
    {lets : Lets Op Γ₁ eff Γ₂} {v : Var Γ₂ t} {e : Expr Op Δ .pure t}
    (he : lets.getPureExprAux v = some ⟨Δ,  e⟩)
    (s : Valuation Γ₁) :
    (lets.denote s) >>=
    (fun Γv => return (e.changeVars (getExprAuxDiff he).toHom).denote Γv) = v.denote <$> (lets.denote s) := by
  rw [getExprAuxDiff]
  induction lets
  case nil => simp [getPureExprAux] at he
  case lete e body ih =>
    simp [Ctxt.Diff.toHom_succ <| getExprAuxDiff.proof_1 he]
    cases v using Var.casesOn with
    | toSnoc v =>
      simp only [getPureExprAux, eq_rec_constant, Var.casesOn_toSnoc, Option.mem_def,
        Option.map_eq_some'] at he
      simp [denote, ←ih he]
      sorry
    | last =>
      simp only [getPureExprAux, eq_rec_constant, Var.casesOn_last,
        Option.mem_def, Option.some.injEq] at he
      sorry
      -- This needs to perform a case distinction on the result of toPure?
      /-
      rcases he with ⟨⟨⟩, ⟨⟩⟩
      simp [denote]
      -/

/-- Get the `Expr` that a var `v` is assigned to in a sequence of `Lets`.
The variables are adjusted so that they are variables in the output context of a lets,
not the local context where the variable appears. -/
def Lets.getPureExpr {Γ₁ Γ₂ : Ctxt Ty} (lets : Lets Op Γ₁ eff Γ₂) {t : Ty} (v : Var Γ₂ t) :
    Option (Expr Op Γ₂ .pure t) :=
  match h : getPureExprAux lets v with
  | none => none
  | some ⟨_,  e⟩ => e.changeVars (getExprAuxDiff h).toHom

theorem Lets.denote_getExpr [LawfulMonad m] {Γ₁ Γ₂ : Ctxt Ty} : {lets : Lets Op Γ₁ eff Γ₂} → {t : Ty} →
    {v : Var Γ₂ t} → {e : Expr Op Γ₂ .pure t} → (he : lets.getPureExpr v = some e) → (s : Valuation Γ₁) →
    (lets.denote s) >>= (fun Γv => return e.denote Γv) = v.denote <$> (lets.denote s) := by
  intros lets _ v e he s
  simp [getPureExpr] at he
  split at he
  . contradiction
  . rw[←Option.some_inj.mp he, denote_getExprAux]

/-
  ## Mapping
  We can map between different dialects
-/

section Map

instance : Functor RegionSignature where
  map f := List.map fun (tys, ty) => (f <$> tys, f ty)

instance : Functor Signature where
  map := fun f ⟨sig, regSig, outTy, effKind⟩ =>
    ⟨f <$> sig, f <$> regSig, f outTy, effKind⟩

/-- A dialect morphism consists of a map between operations and a map between types,
  such that the signature of operations is respected
-/
structure DialectMorphism (Op Op' : Type) {Ty Ty' : Type} [OpSignature Op Ty m] [OpSignature Op' Ty' m] where
  mapOp : Op → Op'
  mapTy : Ty → Ty'
  preserves_signature : ∀ op, signature (mapOp op) = mapTy <$> (signature op)

variable {Op Op' Ty Ty : Type} [OpSignature Op Ty m] [OpSignature Op' Ty' m]
  (f : DialectMorphism Op Op')

def DialectMorphism.preserves_sig (op : Op) :
    OpSignature.sig (f.mapOp op) = f.mapTy <$> (OpSignature.sig op) := by
  simp only [OpSignature.sig, Function.comp_apply, f.preserves_signature, List.map_eq_map]; rfl

def DialectMorphism.preserves_regSig (op : Op) :
    OpSignature.regSig (f.mapOp op) = (OpSignature.regSig op).map (
      fun ⟨a, b⟩ => ⟨f.mapTy <$> a, f.mapTy b⟩
    ) := by
  simp only [OpSignature.regSig, Function.comp_apply, f.preserves_signature, List.map_eq_map]; rfl

def DialectMorphism.preserves_outTy (op : Op) :
    OpSignature.outTy (f.mapOp op) = f.mapTy (OpSignature.outTy op) := by
  simp only [OpSignature.outTy, Function.comp_apply, f.preserves_signature]; rfl

theorem DialectMorphism.preserves_effectKind (op : Op) :
    OpSignature.effectKind (f.mapOp op) = OpSignature.effectKind op := by
  simp only [OpSignature.effectKind, Function.comp_apply, f.preserves_signature]; rfl

mutual
  def Com.map : Com Op Γ eff ty → Com Op' (f.mapTy <$> Γ) eff (f.mapTy ty)
    | .ret v          => .ret v.toMap
    | .lete body rest => .lete body.map rest.map

  def Expr.map : Expr Op (Ty:=Ty) Γ eff ty → Expr Op' (Ty:=Ty') (Γ.map f.mapTy) eff (f.mapTy ty)
    | ⟨op, Eq.refl _, effLe, args, regs⟩ => ⟨
        f.mapOp op,
        (f.preserves_outTy _).symm,
        f.preserves_effectKind _ ▸ effLe,
        f.preserves_sig _ ▸ args.map' f.mapTy fun _ => Var.toMap (f:=f.mapTy),
        f.preserves_regSig _ ▸
          HVector.mapDialectMorphism regs
      ⟩

  /-- Inline of `HVector.map'` for the termination checker -/
  def HVector.mapDialectMorphism : ∀ {regSig : RegionSignature Ty},
      HVector (fun t => Com Op t.fst eff t.snd) regSig
      → HVector (fun t => Com Op' t.fst eff t.snd) (f.mapTy <$> regSig : RegionSignature _)
    | _, .nil        => .nil
    | t::_, .cons a as  => .cons a.map (HVector.mapDialectMorphism as)
end

end Map

/-
  ## Matching
-/

abbrev Mapping (Γ Δ : Ctxt Ty) : Type :=
  @AList (Σ t, Var Γ t) (fun x => Var Δ x.1)

def HVector.toVarSet : {l : List Ty} → (T : HVector (Var Γ) l) → VarSet Γ
  | [], .nil => ∅
  | _::_, .cons v vs => insert ⟨_, v⟩ vs.toVarSet

def HVector.vars {l : List Ty}
    (T : HVector (Var Γ) l) : VarSet Γ :=
  T.foldl (fun _ s a => insert ⟨_, a⟩ s) ∅

@[simp]
theorem HVector.vars_nil :
    (HVector.nil : HVector (Var Γ) ([] : List Ty)).vars = ∅ := by
  simp [HVector.vars, HVector.foldl]

@[simp]
theorem HVector.vars_cons {t  : Ty} {l : List Ty}
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
    simp [Finset.ext_iff, or_comm, or_assoc]

/-- The free variables of `lets` that are (transitively) referred to by some variable `v`.
  Also known as the uses of var.
  TODO: rename to uses.
-/
def Lets.vars : Lets Op Γ_in eff Γ_out → Var Γ_out t → VarSet Γ_in
  | .nil, v => VarSet.ofVar v
  | .lete lets e, v => by
      cases v using Var.casesOn with
      | toSnoc v => exact lets.vars v
      -- this is wrong
      | last => exact (e.args.vars).biUnion (fun v => lets.vars v.2)

theorem HVector.map_eq_of_eq_on_vars {A : Ty → Type*}
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

/--
  Fix a variable v.
  If the two value1, s2, agree on all of values v uses in v's def-use chain,
  then the value of v after denoting the program is also equal.

  This means that we never need to look at the whole context, but only the fragment
  of the context that contains the expression tree of v.
  TODO: unused theorem?
  -/
theorem Lets.denote_eq_of_eq_on_vars [LawfulMonad m] (lets : Lets Op Γ_in eff Γ_out)
    (v : Var Γ_out t)
    {s₁ s₂ : Valuation Γ_in}
    (h : ∀ w, w ∈ lets.vars v → s₁ w.2 = s₂ w.2) :
    (lets.denote s₁) >>= (fun Γv => return v.denote Γv) =
    (lets.denote s₂) >>= (fun Γv => return v.denote Γv) := by
  induction lets generalizing t
  case nil =>
    simp [vars] at h
    simp [denote, h]
    -- | TODO: why does this go out of scope? @alexkeizer
    rename_i _ _ _ _ eff _
    cases eff <;> simp [map_pure, Var.denote, h]
  case lete lets e body ih =>
    rename_i _ _ _ _ effbody _
    cases v using Var.casesOn
    . simp [vars] at h
      simp [denote]
      cases effbody
      case pure =>
        simp_all
        apply ih
        simpa
      case impure =>
        simp_all [map_pure]
        sorry
        -- This needs some thought about side effects. Pretty sure it's true still, but it needs thinking.
        /-
        apply ih
        simpa
        -/
    . rcases e with ⟨op, rfl, args⟩
      sorry
      sorry
      /-
      simp [denote, Expr.denote]
      congr 1
      apply HVector.map_eq_of_eq_on_vars
      intro v h'
      apply ih
      intro v' hv'
      apply h
      rw [vars, Var.casesOn_last]
      simp
      use v.1, v.2
      -/

/-- This gives all the variables the last expression uses -/
def Com.vars : Com Op Γ .pure t → VarSet Γ :=
  fun com => com.toFlatCom.lets.vars com.toFlatCom.ret

mutual

def matchArg [DecidableEq Op]
    (lets : Lets Op Γ_in eff Γ_out)
    (matchLets : Lets Op Δ_in .pure Δ_out)
  : ∀ {l : List Ty}
    (_Tₗ : HVector (Var Γ_out) l) (_Tᵣ :  HVector (Var Δ_out) l),
    Mapping Δ_in Γ_out → Option (Mapping Δ_in Γ_out)
  | _, .nil, .nil, ma => some ma
  | t::l, .cons vₗ vsₗ, .cons vᵣ vsᵣ, ma => do
      let ma ← matchVar (t := t) lets vₗ matchLets vᵣ ma
      matchArg lets matchLets vsₗ vsᵣ ma

/--
  Given two sequences of lets, `lets` and `matchExpr`,
  and variables that indicate an expression, of the same type, in each sequence,
  attempt to assign free variables in `matchExpr` to variables (free or bound) in `lets`, such that
  the original two variables are semantically equivalent.
  If this succeeds, return the mapping.
  NOTE: this only matches on *pure* let bindings in both `matchLets` and `lets`.
-/

def matchVar {Γ_in Γ_out Δ_in Δ_out : Ctxt Ty} {t : Ty} [DecidableEq Op]
    (lets : Lets Op Γ_in eff Γ_out) (v : Var Γ_out t) :
    (matchLets : Lets Op Δ_in .pure Δ_out) →
    (w : Var Δ_out t) →
    (ma : Mapping Δ_in Γ_out := ∅) →
    Option (Mapping Δ_in Γ_out)
  | .lete matchLets _, ⟨w+1, h⟩, ma => -- w† = Var.toSnoc w
      let w := ⟨w, by simp_all[Ctxt.snoc]⟩
      matchVar lets v matchLets w ma
  | @Lets.lete _ _ _ _ _ _ Δ_out _ matchLets matchExpr , ⟨0, _⟩, ma => do -- w† = Var.last
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

open AList

/-- For mathlib -/
theorem _root_.AList.mem_of_mem_entries {α : Type _} {β : α → Type _} {s : AList β}
    {k : α} {v : β k} :
    ⟨k, v⟩ ∈ s.entries → k ∈ s := by
  intro h
  rcases s with ⟨entries, nd⟩
  simp [(· ∈ ·), keys] at h ⊢
  clear nd
  induction h
  next    => apply List.Mem.head
  next ih => apply List.Mem.tail _ ih

theorem _root_.AList.mem_entries_of_mem {α : Type _} {β : α → Type _} {s : AList β} {k : α} :
    k ∈ s → ∃ v, ⟨k, v⟩ ∈ s.entries := by
  intro h
  rcases s with ⟨entries, nd⟩
  simp [(· ∈ ·), keys, List.keys] at h ⊢
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

theorem subset_entries_matchVar_matchArg_aux
    {Γ_out Δ_in Δ_out  : Ctxt Ty}
    {matchVar' : (t : Ty) → Var Γ_out t → Var Δ_out t →
      Mapping Δ_in Γ_out → Option (Mapping Δ_in Γ_out)} :
    {l : List Ty} → {argsₗ : HVector (Var Γ_out) l} →
    {argsᵣ : HVector (Var Δ_out) l} → {ma : Mapping Δ_in Γ_out} →
    {varMap : Mapping Δ_in Γ_out} →
    (hmatchVar : ∀ vMap (t : Ty) (vₗ vᵣ) ma,
        vMap ∈ matchVar' t vₗ vᵣ ma → ma.entries ⊆ vMap.entries) →
    (hvarMap : varMap ∈ matchVar.matchArg Δ_out matchVar' argsₗ argsᵣ ma) →
    ma.entries ⊆ varMap.entries
  | _, .nil, .nil, ma, varMap, _, h => by
    simp only [matchVar.matchArg, Option.mem_def, Option.some.injEq] at h
    subst h
    exact Set.Subset.refl _
  | _, .cons vₗ argsₗ, .cons vᵣ argsᵣ, ma, varMap, hmatchVar, h => by
    simp [matchVar.matchArg, bind, pure] at h
    rcases h with ⟨ma', h₁, h₂⟩
    refine List.Subset.trans ?_
      (subset_entries_matchVar_matchArg_aux hmatchVar h₂)
    exact hmatchVar _ _ _ _ _ h₁

/- TODO: Lean hangs on this proof! -/
/-- The output mapping of `matchVar` extends the input mapping when it succeeds. -/
theorem subset_entries_matchVar [DecidableEq Op]
    {varMap : Mapping Δ_in Γ_out} {ma : Mapping Δ_in Γ_out}
    {lets : Lets Op Γ_in Γ_out} {v : Var Γ_out t} :
    {matchLets : Lets Op Δ_in Δ_out} → {w : Var Δ_out t} →
    (hvarMap : varMap ∈ matchVar lets v matchLets w ma) →
    ma.entries ⊆ varMap.entries
  | _, _ => sorry
/-
  | .nil, w => by
    simp [matchVar]
    intros h x hx
    split at h
    . split_ifs at h
      . simp_all
    . simp only [Option.some.injEq] at h
      subst h
      rcases x with ⟨x, y⟩
      simp only [← AList.mem_lookup_iff] at *
      by_cases hx : x = ⟨t, w⟩
      . subst x; simp_all
      . rwa [AList.lookup_insert_ne hx]

  | .lete matchLets _, ⟨w+1, h⟩ => by
    simp [matchVar]
    apply subset_entries_matchVar

  | .lete matchLets matchExpr, ⟨0, _⟩ => by
    simp [matchVar, Bind.bind, Option.bind]
    intro h
    split at h
    · simp at h
    · rename_i e he
      rcases e with ⟨op, rfl, args⟩
      dsimp at h
      split_ifs at h with hop
      · rcases hop with ⟨rfl, hop⟩
        dsimp at h
        exact subset_entries_matchVar_matchArg_aux
          (fun vMap t vₗ vᵣ ma hvMap => subset_entries_matchVar hvMap) h
-/

theorem subset_entries_matchVar_matchArg [DecidableEq Op]
    {Γ_in Γ_out Δ_in Δ_out : Ctxt Ty} {lets : Lets Op Γ_in Γ_out}
    {matchLets : Lets Op Δ_in Δ_out} :
    {l : List Ty} → {argsₗ : HVector (Var Γ_out) l} →
    {argsᵣ : HVector (Var Δ_out) l} → {ma : Mapping Δ_in Γ_out} →
    {varMap : Mapping Δ_in Γ_out} →
    (hvarMap : varMap ∈ matchVar.matchArg Δ_out
        (fun t vₗ vᵣ ma =>
            matchVar (t := t) lets vₗ matchLets vᵣ ma) argsₗ argsᵣ ma) →
    ma.entries ⊆ varMap.entries :=
  subset_entries_matchVar_matchArg_aux (fun _ _ _ _ _ => subset_entries_matchVar)

-- TODO: this assumption is too strong, we also want to be able to model non-inhabited types
variable [∀ (t : Ty), Inhabited (toType t)] [DecidableEq Op]

theorem denote_matchVar_matchArg [DecidableEq Op]
    {Γ_out Δ_in Δ_out : Ctxt Ty} {lets : Lets Op Γ_in Γ_out}
    {matchLets : Lets Op Δ_in Δ_out} :
    {l : List Ty} →
    {args₁ : HVector (Var Γ_out) l} →
    {args₂ : HVector (Var Δ_out) l} →
    {ma varMap₁ varMap₂ : Mapping Δ_in Γ_out} →
    (h_sub : varMap₁.entries ⊆ varMap₂.entries) →
    (f₁ : (t : Ty) → Var Γ_out t → toType t) →
    (f₂ : (t : Ty) → Var Δ_out t → toType t) →
    (hf : ∀ t v₁ v₂ (ma : Mapping Δ_in Γ_out) (ma'),
      (ma ∈ matchVar lets v₁ matchLets v₂ ma') →
      ma.entries ⊆ varMap₂.entries → f₂ t v₂ = f₁ t v₁) →
    (hmatchVar : ∀ vMap (t : Ty) (vₗ vᵣ) ma,
      vMap ∈ matchVar (t := t) lets vₗ matchLets vᵣ ma →
      ma.entries ⊆ vMap.entries) →
    (hvarMap : varMap₁ ∈ matchVar.matchArg Δ_out
      (fun t vₗ vᵣ ma =>
        matchVar (t := t) lets vₗ matchLets vᵣ ma) args₁ args₂ ma) →
      HVector.map f₂ args₂ = HVector.map f₁ args₁
  | _, .nil, .nil, _, _ => by simp [HVector.map]
  | _, .cons v₁ T₁, .cons v₂ T₂, ma, varMap₁ => by
    intro h_sub f₁ f₂ hf hmatchVar hvarMap
    simp [HVector.map]
    simp [matchVar.matchArg, pure, bind] at hvarMap
    rcases hvarMap with ⟨ma', h₁, h₂⟩
    refine ⟨hf _ _ _ _ _ h₁ (List.Subset.trans ?_ h_sub), ?_⟩
    · refine List.Subset.trans ?_
        (subset_entries_matchVar_matchArg h₂)
      · exact Set.Subset.refl _
    apply denote_matchVar_matchArg (hvarMap := h₂) (hf := hf)
    · exact h_sub
    · exact hmatchVar

/- NOTE: Lean hangs on this proof! -/
theorem denote_matchVar_of_subset
    {lets : Lets Op Γ_in Γ_out} {v : Var Γ_out t}
    {varMap₁ varMap₂ : Mapping Δ_in Γ_out}
    {s₁ : Valuation Γ_in}
    {ma : Mapping Δ_in Γ_out} :
    {matchLets : Lets Op Δ_in Δ_out} → {w : Var Δ_out t} →
    (h_sub : varMap₁.entries ⊆ varMap₂.entries) →
    (h_matchVar : varMap₁ ∈ matchVar lets v matchLets w ma) →
    True := by sorry
/-
      (matchLets.denote <=< (fun t' v' => by
        match varMap₂.lookup ⟨_, v'⟩  with
        | some v' => exact lets.denote s₁ v'
        | none => exact default
        ) w) = lets.denote s₁ v
  | _, _ => sorry
-/
/-
  | .nil, w => by
    simp[Lets.denote, matchVar]
    intro h_sub h_mv
    split at h_mv
    next x v₂ heq =>
      split_ifs at h_mv
      next v_eq_v₂ =>
        subst v_eq_v₂
        injection h_mv with h_mv
        subst h_mv
        rw[mem_lookup_iff.mpr ?_]
        apply h_sub
        apply mem_lookup_iff.mp
        exact heq
    next =>
      rw [mem_lookup_iff.mpr]
      injection h_mv with h_mv
      apply h_sub
      subst h_mv
      simp
  | .lete matchLets _, ⟨w+1, h⟩ => by
    simp [matchVar]
    apply denote_matchVar_of_subset
  | .lete matchLets matchExpr, ⟨0, h_w⟩ => by
    rename_i t'
    have : t = t' := by simp[List.get?] at h_w; apply h_w.symm
    subst this
    simp [matchVar, Bind.bind, Option.bind]
    intro h_sub h_mv
    split at h_mv
    · simp_all
    · rename_i e he
      rcases e with ⟨op₁, rfl, args₁, regArgs₁⟩
      rcases matchExpr with ⟨op₂, h, args₂, regArgs₂⟩
      dsimp at h_mv
      split_ifs at h_mv with hop
      · rcases hop with ⟨rfl, hop⟩
        simp [Lets.denote, Expr.denote]
        rw [← Lets.denote_getExpr he]
        clear he
        simp only [Expr.denote]
        congr 1
        · apply denote_matchVar_matchArg (hvarMap := h_mv) h_sub
          · intro t v₁ v₂ ma ma' hmem hma
            apply denote_matchVar_of_subset hma
            apply hmem
          · exact (fun _ _ _ _ _ h => subset_entries_matchVar h)
        · dsimp at hop
          subst hop
          rfl
-/

theorem denote_matchVar {lets : Lets Op Γ_in Γ_out} {v : Var Γ_out t} {varMap : Mapping Δ_in Γ_out}
    {s₁ : Valuation Γ_in}
    {ma : Mapping Δ_in Γ_out}
    {matchLets : Lets Op Δ_in Δ_out}
    {w : Var Δ_out t} :
    varMap ∈ matchVar lets v matchLets w ma →
    matchLets.denote (fun t' v' => by
        match varMap.lookup ⟨_, v'⟩  with
        | some v' => exact lets.denote s₁ v'
        | none => exact default
        ) w =
      lets.denote s₁ v :=
  denote_matchVar_of_subset (List.Subset.refl _)

theorem lt_one_add_add (a b : ℕ) : b < 1 + a + b := by
  simp (config := { arith := true })

@[simp]
theorem zero_eq_zero : (Zero.zero : ℕ) = 0 := rfl

attribute [simp] lt_one_add_add

macro_rules | `(tactic| decreasing_trivial) => `(tactic| simp (config := {arith := true}))

mutual
/-- NOTE: Lean hands on this proof -/
theorem mem_matchVar_matchArg
    {Γ_in Γ_out Δ_in Δ_out : Ctxt Ty} {lets : Lets Op Γ_in Γ_out}
    {matchLets : Lets Op Δ_in Δ_out} :
    {l : List Ty} → {argsₗ : HVector (Var Γ_out) l} →
    {argsᵣ : HVector (Var Δ_out) l} → {ma : Mapping Δ_in Γ_out} →
    {varMap : Mapping Δ_in Γ_out} →
    (hvarMap : varMap ∈ matchVar.matchArg Δ_out
        (fun t vₗ vᵣ ma =>
            matchVar (t := t) lets vₗ matchLets vᵣ ma) argsₗ argsᵣ ma) →
    ∀ {t' v'}, ⟨t', v'⟩ ∈ (argsᵣ.vars).biUnion (fun v => matchLets.vars v.2) →
      ⟨t', v'⟩ ∈ varMap
  | _, _, _, _, _, _ => sorry
/-
  | _, .nil, .nil, _, varMap, _ => by simp
  | _, .cons vₗ argsₗ, .cons vᵣ argsᵣ, ma, varMap, h => by
    simp [matchVar.matchArg, bind, pure] at h
    rcases h with ⟨ma', h₁, h₂⟩
    simp only [HVector.vars_cons, Finset.biUnion_insert, Finset.mem_union,
      Finset.mem_biUnion, Sigma.exists]
    rintro (h | ⟨a, b, hab⟩)
    · exact AList.keys_subset_keys_of_entries_subset_entries
        (subset_entries_matchVar_matchArg h₂)
        (mem_matchVar h₁ h)
    · exact mem_matchVar_matchArg h₂
        (Finset.mem_biUnion.2 ⟨⟨_, _⟩, hab.1, hab.2⟩)
-/

/- NOTE: Lean hangs on this proof -/
/-- All variables containing in `matchExpr` are assigned by `matchVar`. -/
theorem mem_matchVar
    {varMap : Mapping Δ_in Γ_out} {ma : Mapping Δ_in Γ_out}
    {lets : Lets Op Γ_in Γ_out} {v : Var Γ_out t} :
    {matchLets : Lets Op Δ_in Δ_out} → {w : Var Δ_out t} →
    (hvarMap : varMap ∈ matchVar lets v matchLets w ma) →
    ∀ {t' v'}, ⟨t', v'⟩ ∈ matchLets.vars w → ⟨t', v'⟩ ∈ varMap
  | _, _, _, _, _ => sorry
/-
  | .nil, w, h, t', v' => by
    simp [Lets.vars]
    simp [matchVar] at h
    intro h_mem
    subst h_mem
    intro h; cases h
    split at h
    · split_ifs at h
      · simp at h
        subst h
        subst v
        exact AList.lookup_isSome.1 (by simp_all)
    · simp at h
      subst h
      simp

  | .lete matchLets matchE, w, h, t', v' => by
    cases w using Var.casesOn
    next w =>
      simp [matchVar] at h
      apply mem_matchVar h
    next =>
      simp [Lets.vars]
      intro _ _ hl h_v'
      simp [matchVar, pure, bind] at h
      rcases h with ⟨⟨ope, h, args⟩, he₁, he₂⟩
      subst t
      split_ifs at he₂ with h
      · dsimp at h
        dsimp
        apply @mem_matchVar_matchArg (hvarMap := he₂)
        simp
        refine ⟨_, _, ?_, h_v'⟩
        rcases matchE  with ⟨_, _, _⟩
        dsimp at h
        rcases h with ⟨rfl, _⟩
        exact hl
-/
end
--termination_by
--  mem_matchVar_matchArg _ _ _ _ _ matchLets args _ _ _ _ _ _ _ => (sizeOf matchLets, sizeOf args)
--  mem_matchVar _ _ _ _ matchLets _ _ _ _ => (sizeOf matchLets, 0)

/-- A version of `matchVar` that returns a `Hom` of `Ctxt`s instead of the `AList`,
provided every variable in the context appears as a free variable in `matchExpr`. -/
def matchVarMap {Γ_in Γ_out Δ_in Δ_out : Ctxt Ty} {t : Ty}
    (lets : Lets Op Γ_in eff Γ_out) (v : Var Γ_out t) (matchLets : Lets Op Δ_in .pure Δ_out) (w : Var Δ_out t)
    (hvars : ∀ t (v : Var Δ_in t), ⟨t, v⟩ ∈ matchLets.vars w) :
    Option (Δ_in.Hom Γ_out) := do
  match hm : matchVar lets v matchLets w with
  | none => none
  | some m =>
    return fun t v' =>
    match h : m.lookup ⟨t, v'⟩ with
    | some v' => by exact v'
    | none => by
      have := AList.lookup_isSome.2 (mem_matchVar hm (hvars t v'))
      simp_all

theorem denote_matchVarMap {Γ_in Γ_out Δ_in Δ_out : Ctxt Ty}
    {lets : Lets Op Γ_in eff Γ_out}
    {t : Ty} {v : Var Γ_out t}
    {matchLets : Lets Op Δ_in .pure Δ_out}
    {w : Var Δ_out t}
    {hvars : ∀ t (v : Var Δ_in t), ⟨t, v⟩ ∈ matchLets.vars w}
    {map : Δ_in.Hom Γ_out}
    (hmap : map ∈ matchVarMap lets v matchLets w hvars) (s₁ : Valuation Γ_in) :
    matchLets.denote (fun t' v' => lets.denote s₁ (map v')) w =
      lets.denote s₁ v := by
  rw [matchVarMap] at hmap
  split at hmap
  next => simp_all
  next hm =>
    rw [← denote_matchVar hm]
    simp only [Option.mem_def, Option.some.injEq, pure] at hmap
    subst hmap
    congr
    funext t' v;
    split
    . congr
      dsimp
      split <;> simp_all
    . have := AList.lookup_isSome.2 (mem_matchVar hm (hvars _ v))
      simp_all

/-- `splitProgramAtAux pos lets prog`, will return a `Lets` ending
with the `pos`th variable in `prog`, and an `Com` starting with the next variable.
It also returns, the type of this variable and the variable itself as an element
of the output `Ctxt` of the returned `Lets`.  -/
def splitProgramAtAux : (pos : ℕ) → (lets : Lets Op Γ₁ eff Γ₂) →
    (prog : Com Op Γ₂ eff t) →
    Option (Σ (Γ₃ : Ctxt Ty), Lets Op Γ₁ eff Γ₃ × Com Op Γ₃ eff t × (t' : Ty) × Var Γ₃ t')
  | 0, lets, .lete e body => some ⟨_, .lete lets e, body, _, Var.last _ _⟩
  | _, _, .ret _ => none
  | n+1, lets, .lete e body =>
    splitProgramAtAux n (lets.lete e) body

theorem denote_splitProgramAtAux : {pos : ℕ} → {lets : Lets Op Γ₁ eff Γ₂} →
    {prog : Com Op Γ₂ eff t} →
    {res : Σ (Γ₃ : Ctxt Ty), Lets Op Γ₁ eff Γ₃ × Com Op Γ₃ eff t × (t' : Ty) × Var Γ₃ t'} →
    (hres : res ∈ splitProgramAtAux pos lets prog) →
    (s : Valuation Γ₁) →
    res.2.2.1.denote =<< (res.2.1.denote s) = prog.denote =<< (lets.denote s)
  | 0, lets, .lete e body, res, hres, s => by
    simp only [splitProgramAtAux, Option.mem_def, Option.some.injEq] at hres
    subst hres
    simp only [Lets.denote, eq_rec_constant, Com.denote]
    congr
    sorry
    /-
    funext t v
    cases v using Var.casesOn <;> simp
    -/
  | _+1, _, .ret _, res, hres, s => by
    simp [splitProgramAtAux] at hres
  | n+1, lets, .lete eff e body, res, hres, s => by
    rw [splitProgramAtAux] at hres
    sorry
    /-
    rw [Com.denote, denote_splitProgramAtAux hres s]
    simp only [Lets.denote, eq_rec_constant, Ctxt.Valuation.snoc]
    congr
    funext t v
    cases v using Var.casesOn <;> simp
    -/
/-- `splitProgramAt pos prog`, will return a `Lets` ending
with the `pos`th variable in `prog`, and an `Com` starting with the next variable.
It also returns, the type of this variable and the variable itself as an element
of the output `Ctxt` of the returned `Lets`.  -/
def splitProgramAt (pos : ℕ) (prog : Com Op Γ₁ eff t) :
    Option (Σ (Γ₂ : Ctxt Ty), Lets Op Γ₁ eff Γ₂ × Com Op Γ₂ eff t × (t' : Ty) × Var Γ₂ t') :=
  splitProgramAtAux pos .nil prog

theorem denote_splitProgramAt {pos : ℕ} {prog : Com Op Γ₁ t}
    {res : Σ (Γ₂ : Ctxt Ty), Lets Op Γ₁ Γ₂ × Com Op Γ₂ t × (t' : Ty) × Var Γ₂ t'}
    (hres : res ∈ splitProgramAt pos prog) (s : Valuation Γ₁) :
    res.2.2.1.denote =<< (res.2.1.denote s) = prog.denote s :=
  denote_splitProgramAtAux hres s



/-
  ## Rewriting
-/

/-- `rewriteAt lhs rhs hlhs pos target`, searches for `lhs` at position `pos` of
`target`. If it can match the variables, it inserts `rhs` into the program
with the correct assignment of variables, and then replaces occurences
of the variable at position `pos` in `target` with the output of `rhs`.  -/
def rewriteAt (lhs rhs : Com Op Γ₁ .pure t₁)
    (hlhs : ∀ t (v : Var Γ₁ t), ⟨t, v⟩ ∈ lhs.vars)
    (pos : ℕ) (target : Com Op Γ₂ eff₂ t₂) :
    Option (Com Op Γ₂ eff₂ t₂) := do
  let ⟨Γ₃, targetLets, target', t', vm⟩ ← splitProgramAt pos target
  if h : t₁ = t'
  then
    let flatLhs := lhs.toFlatCom
    let m ← matchVarMap targetLets vm flatLhs.lets (h ▸ flatLhs.ret)
      (by subst h; exact hlhs)
    return addPureComInMiddleOfLetCom vm m targetLets (h ▸ rhs) target'
  else none

theorem denote_rewriteAt (lhs rhs : Com Op Γ₁ .pure t₁)
    (hlhs : ∀ t (v : Var Γ₁ t), ⟨t, v⟩ ∈ lhs.vars)
    (pos : ℕ) (target : Com Op Γ₂ eff t₂)
    (hl : lhs.denote = rhs.denote)
    (rew : Com Op Γ₂ eff t₂)
    (hrew : rew ∈ rewriteAt lhs rhs hlhs pos target) :
    rew.denote = target.denote := by
  ext s
  rw [rewriteAt] at hrew
  simp only [bind, pure, Option.bind] at hrew
  split at hrew
  . simp at hrew
  . rename_i hs
    simp only [Option.mem_def] at hrew
    split_ifs at hrew
    subst t₁
    split at hrew
    . simp at hrew
    . simp only [Option.some.injEq] at hrew
      subst hrew
      rw [denote_addPureComInMiddleOfLetCom, ← hl]
      rename_i _ _ h
      have := denote_matchVarMap h
      simp only [Com.denote_eq_denoteLetsRet_toFlatCom] at this
      simp only [this, ← denote_splitProgramAt hs s]
      congr
      funext t' v'
      simp only [dite_eq_right_iff, forall_exists_index]
      rintro rfl rfl
      simp

variable (Op : _) {Ty : _} [OpSignature Op Ty m] [Goedel Ty] [OpDenote Op Ty m] in
/--
  Rewrites are indexed with a concrete list of types, rather than an (erased) context, so that
  the required variable checks become decidable
-/
structure PeepholeRewrite (Γ : List Ty) (t : Ty) where
  lhs : Com Op (.ofList Γ) .pure t
  rhs : Com Op (.ofList Γ) .pure t
  correct : lhs.denote = rhs.denote

instance {Γ : List Ty} {t' : Ty} {lhs : Com Op (.ofList Γ) .pure t'} :
    Decidable (∀ (t : Ty) (v : Var (.ofList Γ) t), ⟨t, v⟩ ∈ lhs.vars) :=
  decidable_of_iff
    (∀ (i : Fin Γ.length),
      let v : Var (.ofList Γ) (Γ.get i) := ⟨i, by simp [List.get?_eq_get, Ctxt.ofList]⟩
      ⟨_, v⟩ ∈ lhs.vars) <|  by
  constructor
  . intro h t v
    rcases v with ⟨i, hi⟩
    try simp only [Erased.out_mk] at hi
    rcases List.get?_eq_some.1 hi with ⟨h', rfl⟩
    simp at h'
    convert h ⟨i, h'⟩
  . intro h i
    apply h

def rewritePeepholeAt (pr : PeepholeRewrite Op Γ t)
    (pos : ℕ) (target : Com Op Γ₂ eff t₂) :
    (Com Op Γ₂ eff t₂) := if hlhs : ∀ t (v : Var (.ofList Γ) t), ⟨_, v⟩ ∈ pr.lhs.vars then
      match rewriteAt pr.lhs pr.rhs hlhs pos target
      with
        | some res => res
        | none => target
      else target


theorem denote_rewritePeepholeAt (pr : PeepholeRewrite Op Γ t)
    (pos : ℕ) (target : Com Op Γ₂  eff t₂) :
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

/- repeatedly apply peephole on program. -/
section SimpPeepholeApplier

/-- rewrite with `pr` to `target` program, at location `ix` and later, running at most `fuel` steps. -/
def rewritePeephole_go (fuel : ℕ) (pr : PeepholeRewrite Op Γ t)
    (ix : ℕ) (target : Com Op Γ₂ t₂) : (Com Op Γ₂ t₂) :=
  match fuel with
  | 0 => target
  | fuel' + 1 =>
     let target' := rewritePeepholeAt pr ix target
     rewritePeephole_go fuel' pr (ix + 1) target'

/-- rewrite with `pr` to `target` program, running at most `fuel` steps. -/
def rewritePeephole (fuel : ℕ)
    (pr : PeepholeRewrite Op Γ t) (target : Com Op Γ₂ t₂) : (Com Op Γ₂ t₂) :=
  rewritePeephole_go fuel pr 0 target

/-- `rewritePeephole_go` preserve semantics -/
theorem denote_rewritePeephole_go (pr : PeepholeRewrite Op Γ t)
    (pos : ℕ) (target : Com Op Γ₂ t₂) :
    (rewritePeephole_go fuel pr pos target).denote = target.denote := by
  induction fuel generalizing pr pos target
  case zero =>
    simp[rewritePeephole_go, denote_rewritePeepholeAt]
  case succ fuel' hfuel =>
    simp[rewritePeephole_go, denote_rewritePeepholeAt, hfuel]

/-- `rewritePeephole` preserves semantics. -/
theorem denote_rewritePeephole (fuel : ℕ)
    (pr : PeepholeRewrite Op Γ t) (target : Com Op Γ₂ t₂) :
    (rewritePeephole fuel pr target).denote = target.denote := by
  simp[rewritePeephole, denote_rewritePeephole_go]
end SimpPeepholeApplier

/--
`simp_peephole [t1, t2, ... tn]` at Γ simplifies the evaluation of the context Γ,
leaving behind a bare Lean level proposition to be proven.
-/
macro "simp_peephole" "[" ts: Lean.Parser.Tactic.simpLemma,* "]" "at" ll:ident : tactic =>
  `(tactic|
      (
      try simp (config := {decide := false}) only [
        Int.ofNat_eq_coe, Nat.cast_zero, Ctxt.DerivedCtxt.snoc, Ctxt.DerivedCtxt.ofCtxt,
        Ctxt.DerivedCtxt.ofCtxt_empty, Ctxt.Valuation.snoc_last,
        Com.denote, Expr.denote, HVector.denote, Var.zero_eq_last, Var.succ_eq_toSnoc,
        Ctxt.empty, Ctxt.empty_eq, Ctxt.snoc, Ctxt.Valuation.nil, Ctxt.Valuation.snoc_last,
        Ctxt.Valuation.snoc_eval, Ctxt.ofList, Ctxt.Valuation.snoc_toSnoc,
        HVector.map, HVector.toPair, HVector.toTuple, OpDenote.denote, Expr.op_mk, Expr.args_mk,
        DialectMorphism.mapOp, DialectMorphism.mapTy, List.map, Ctxt.snoc, List.map,
        Function.comp, Ctxt.Valuation.ofPair, Ctxt.Valuation.ofHVector, Function.uncurry,
        $ts,*]
      try generalize $ll { val := 0, property := _ } = a;
      try generalize $ll { val := 1, property := _ } = b;
      try generalize $ll { val := 2, property := _ } = c;
      try generalize $ll { val := 3, property := _ } = d;
      try generalize $ll { val := 4, property := _ } = e;
      try generalize $ll { val := 5, property := _ } = f;
      try simp (config := {decide := false}) [Goedel.toType] at a b c d e f;
      try clear f;
      try clear e;
      try clear d;
      try clear c;
      try clear b;
      try clear a;
      try revert f;
      try revert e;
      try revert d;
      try revert c;
      try revert b;
      try revert a;
      try clear $ll;
      )
   )

/-- `simp_peephole` with no extra user defined theorems. -/
macro "simp_peephole" "at" ll:ident : tactic => `(tactic| simp_peephole [] at $ll)

end SimpPeephole


/-
  ## Examples
-/

namespace Examples

/-- A very simple type universe. -/
inductive ExTy
  | nat
  | bool
  deriving DecidableEq, Repr

@[reducible]
instance : Goedel ExTy where
  toType
    | .nat => Nat
    | .bool => Bool

inductive ExOp :  Type
  | add : ExOp
  | beq : ExOp
  | cst : ℕ → ExOp
  deriving DecidableEq, Repr

instance : OpSignature ExOp ExTy where
  signature
    | .add    => Signature.mk [.nat, .nat] [] .nat
    | .beq    => Signature.mk [.nat, .nat] [] .bool
    | .cst _  => Signature.mk [] [] .nat

@[reducible]
instance : OpDenote ExOp ExTy where
  denote
    | .cst n, _, _ => n
    | .add, .cons (a : Nat) (.cons b .nil), _ => a + b
    | .beq, .cons (a : Nat) (.cons b .nil), _ => a == b

def cst {Γ : Ctxt _} (n : ℕ) : Expr ExOp Γ .pure .nat  :=
  Expr.mk
    (op := .cst n)
    (ty_eq := rfl)
    (eff_le := by { simp [OpSignature.effectKind, signature]; })
    (args := .nil)
    (regArgs := .nil)

def add {Γ : Ctxt _} (e₁ e₂ : Var Γ .nat) : Expr ExOp Γ .pure .nat :=
  Expr.mk
    (op := .add)
    (ty_eq := rfl)
    (eff_le := by { simp [OpSignature.effectKind, signature]; })
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := .nil)

attribute [local simp] Ctxt.snoc

def ex1 : Com ExOp ∅ .nat :=
  Com.lete .pure (cst 1) <|
  Com.lete .pure (add ⟨0, by simp [Ctxt.snoc]⟩ ⟨0, by simp [Ctxt.snoc]⟩ ) <|
  Com.ret ⟨0, by simp [Ctxt.snoc]⟩

def ex2 : Com ExOp ∅ .nat :=
  Com.lete .pure (cst 1) <|
  Com.lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
  Com.lete .pure (add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  Com.lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
  Com.lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
  Com.ret ⟨0, by simp⟩

-- a + b => b + a
def m : Com ExOp (.ofList [.nat, .nat]) .nat :=
  .lete .pure (add ⟨0, by simp⟩ ⟨1, by simp⟩) (.ret ⟨0, by simp⟩)
def r : Com ExOp (.ofList [.nat, .nat]) .nat :=
  .lete .pure (add ⟨1, by simp⟩ ⟨0, by simp⟩) (.ret ⟨0, by simp⟩)

def p1 : PeepholeRewrite ExOp [.nat, .nat] .nat:=
  { lhs := m, rhs := r, correct :=
    by
      rw [m, r]
      funext Γv
      simp_peephole [add, cst] at Γv
    }

example : rewritePeepholeAt p1 1 ex1 = (
  Com.lete .pure (cst 1)  <|
     .lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩)  <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩)  <|
     .ret ⟨0, by simp⟩) := by rfl

-- a + b => b + a
example : rewritePeepholeAt p1 0 ex1 = ex1 := by rfl

example : rewritePeepholeAt p1 1 ex2 = (
  Com.lete .pure (cst 1)   <|
     .lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
     .lete .pure (add ⟨2, by simp⟩ ⟨0, by simp⟩) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩ ) <|
     .ret ⟨0, by simp⟩) := by rfl

example : rewritePeepholeAt p1 2 ex2 = (
  Com.lete .pure (cst 1)   <|
     .lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨2, by simp⟩) <|
     .lete .pure (add ⟨2, by simp⟩ ⟨2, by simp⟩) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
     .ret ⟨0, by simp⟩) := by rfl

example : rewritePeepholeAt p1 3 ex2 = (
  Com.lete .pure (cst 1)   <|
     .lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete .pure (add ⟨2, by simp⟩ ⟨2, by simp⟩  ) <|
     .lete .pure (add ⟨2, by simp⟩ ⟨2, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p1 4 ex2 = (
  Com.lete .pure (cst 1)   <|
     .lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete .pure (add ⟨2, by simp⟩ ⟨2, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

def ex2' : Com ExOp ∅ .nat :=
  Com.lete .pure (cst 1) <|
  Com.lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
  Com.lete .pure (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
  Com.lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
  Com.lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
  Com.ret ⟨0, by simp⟩

-- a + b => b + (0 + a)
def r2 : Com ExOp (.ofList [.nat, .nat]) .nat :=
  .lete .pure (cst 0) <|
  .lete .pure (add ⟨0, by simp⟩ ⟨1, by simp⟩) <|
  .lete .pure (add ⟨3, by simp⟩ ⟨0, by simp⟩) <|
  .ret ⟨0, by simp⟩

def p2 : PeepholeRewrite ExOp [.nat, .nat] .nat:=
  { lhs := m, rhs := r2, correct :=
    by
      rw [m, r2]
      funext Γv
      simp_peephole [add, cst] at Γv
      intros a b
      rw [Nat.zero_add]
      rw [Nat.add_comm]
    }

example : rewritePeepholeAt p2 1 ex2' = (
     .lete .pure (cst 1) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (cst 0) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨2, by simp⟩  ) <|
     .lete .pure (add ⟨3, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p2 2 ex2 = (
  Com.lete .pure (cst  1) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (cst  0) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete .pure (add ⟨3, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p2 3 ex2 = (
  Com.lete .pure (cst  1) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete .pure (cst  0) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete .pure (add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p2 4 ex2 = (
  Com.lete .pure (cst  1) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete .pure (cst  0) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete .pure (add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

-- a + b => (0 + a) + b
def r3 : Com ExOp (.ofList [.nat, .nat]) .nat :=
  .lete .pure (cst 0) <|
  .lete .pure (add ⟨0, by simp⟩ ⟨1, by simp⟩) <|
  .lete .pure (add ⟨0, by simp⟩ ⟨3, by simp⟩) <|
  .ret ⟨0, by simp⟩

def p3 : PeepholeRewrite ExOp [.nat, .nat] .nat:=
  { lhs := m, rhs := r3, correct :=
    by
      rw [m, r3]
      funext Γv
      simp_peephole [add, cst] at Γv
      intros a b
      rw [Nat.zero_add]
    }

example : rewritePeepholeAt p3 1 ex2 = (
  Com.lete .pure (cst  1) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (cst  0) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨2, by simp⟩  ) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete .pure (add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p3 2 ex2 = (
  Com.lete .pure (cst  1) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (cst  0) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete .pure (add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p3 3 ex2 = (
  Com.lete .pure (cst  1) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete .pure (cst  0) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨4, by simp⟩  ) <|
     .lete .pure (add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p3 4 ex2 = (
  Com.lete .pure (cst  1) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete .pure (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete .pure (cst  0) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete .pure (add ⟨0, by simp⟩ ⟨4, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

def ex3 : Com ExOp ∅ .nat :=
  .lete .pure (cst 1) <|
  .lete .pure (cst 0) <|
  .lete .pure (cst 2) <|
  .lete .pure (add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  .lete .pure (add ⟨3, by simp⟩ ⟨1, by simp⟩) <|
  .lete .pure (add ⟨1, by simp⟩ ⟨0, by simp⟩) <| --here
  .lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
  .ret ⟨0, by simp⟩

def p4 : PeepholeRewrite ExOp [.nat, .nat] .nat:=
  { lhs := r3, rhs := m, correct :=
    by
      rw [m, r3]
      funext Γv
      simp_peephole [add, cst] at Γv
      intros a b
      rw [Nat.zero_add]
    }

example : rewritePeepholeAt p4 5 ex3 = (
  .lete .pure (cst 1) <|
  .lete .pure (cst 0) <|
  .lete .pure (cst 2) <|
  .lete .pure (add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  .lete .pure (add ⟨3, by simp⟩ ⟨1, by simp⟩) <|
  .lete .pure (add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  .lete .pure (add ⟨3, by simp⟩ ⟨1, by simp⟩) <|
  .lete .pure (add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
  .ret ⟨0, by simp⟩) := rfl

end Examples

namespace RegionExamples

/-- A very simple type universe. -/
inductive ExTy
  | nat
  deriving DecidableEq, Repr

@[reducible]
instance : Goedel ExTy where
  toType
    | .nat => Nat

inductive ExOp :  Type
  | add : ExOp
  | runK : ℕ → ExOp
  deriving DecidableEq, Repr

instance : OpSignature ExOp ExTy where
  signature
  | .add    => Signature.mk [.nat, .nat] [] .nat
  | .runK _ => Signature.mk [.nat] [([.nat], .nat)] .nat


@[reducible]
instance : OpDenote ExOp ExTy where
  denote
    | .add, .cons (a : Nat) (.cons b .nil), _ => a + b
    | .runK (k : Nat), (.cons (v : Nat) .nil), (.cons rgn _nil) =>
      k.iterate (fun val => rgn (fun _ty _var => val)) v

def add {Γ : Ctxt _} (e₁ e₂ : Var Γ .nat) : Expr ExOp Γ .nat :=
  Expr.mk
    (op := .add)
    (ty_eq := rfl)
    (eff_le := by { simp [OpSignature.effectKind, signature]; })
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := .nil)

def rgn {Γ : Ctxt _} (k : Nat) (input : Var Γ .nat) (body : Com ExOp [ExTy.nat] ExTy.nat) : Expr ExOp Γ .nat :=
  Expr.mk
    (op := .runK k)
    (ty_eq := rfl)
    (eff_le := by { simp [OpSignature.effectKind, signature]; })
    (args := .cons input .nil)
    (regArgs := HVector.cons body HVector.nil)

attribute [local simp] Ctxt.snoc

/-- running `f(x) = x + x` 0 times is the identity. -/
def ex1_lhs : Com ExOp [.nat] .nat :=
  Com.lete .pure (rgn (k := 0) ⟨0, by simp[Ctxt.snoc]⟩ (
      Com.lete .pure (add ⟨0, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩) -- fun x => (x + x)
      <| Com.ret ⟨0, by simp[Ctxt.snoc]⟩
  )) <|
  Com.ret ⟨0, by simp[Ctxt.snoc]⟩

def ex1_rhs : Com ExOp [.nat] .nat :=
  Com.ret ⟨0, by simp[Ctxt.snoc]⟩

def p1 : PeepholeRewrite ExOp [.nat] .nat:=
  { lhs := ex1_lhs, rhs := ex1_rhs, correct := by
      rw [ex1_lhs, ex1_rhs]
      funext Γv
      simp_peephole [add, rgn] at Γv
      simp
      done
  }

def p1_run : Com ExOp [.nat] .nat :=
  rewritePeepholeAt p1 0 ex1_lhs

/-
RegionExamples.ExOp.runK 0[[%0]]
return %1
-/
-- #eval p1_run

/-- running `f(x) = x + x` 1 times does return `x + x`. -/
def ex2_lhs : Com ExOp [.nat] .nat :=
  Com.lete (rgn (k := 1) ⟨0, by simp[Ctxt.snoc]⟩ (
      Com.lete (add ⟨0, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩) -- fun x => (x + x)
      <| Com.ret ⟨0, by simp[Ctxt.snoc]⟩
  )) <|
  Com.ret ⟨0, by simp[Ctxt.snoc]⟩

def ex2_rhs : Com ExOp [.nat] .nat :=
    Com.lete (add ⟨0, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩) -- fun x => (x + x)
    <| Com.ret ⟨0, by simp[Ctxt.snoc]⟩

def p2 : PeepholeRewrite ExOp [.nat] .nat:=
  { lhs := ex2_lhs, rhs := ex2_rhs, correct := by
      rw [ex2_lhs, ex2_rhs]
      funext Γv
      simp_peephole [add, rgn] at Γv
      done
  }

end RegionExamples


section TypeProjections

def Com.getTy {Op Ty : Type} [OpSignature Op Ty] {Γ : Ctxt Ty} {t : Ty} : Com Op Γ t → Type := fun _ => Ty
def Com.ty {Op Ty : Type} [OpSignature Op Ty] {Γ : Ctxt Ty} {t : Ty} : Com Op Γ t → Ty := fun _ => t
def Com.ctxt {Op Ty : Type} [OpSignature Op Ty] {Γ : Ctxt Ty} {t : Ty} : Com Op Γ t → Ctxt Ty := fun _ => Γ

def Expr.getTy {Op Ty : Type} [OpSignature Op Ty] {Γ : Ctxt Ty} {t : Ty} : Expr Op Γ t → Type := fun _ => Ty
def Expr.ty {Op Ty : Type} [OpSignature Op Ty] {Γ : Ctxt Ty} {t : Ty} : Expr Op Γ t → Ty := fun _ => t
def Expr.ctxt {Op Ty : Type} [OpSignature Op Ty] {Γ : Ctxt Ty} {t : Ty} : Expr Op Γ t → Ctxt Ty := fun _ => Γ

end TypeProjections
