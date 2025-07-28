/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework

variable {d : Dialect} [DialectSignature d] [Monad d.m]
open Ctxt (Var)

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
  | .var (t := ty') body e, v  =>
      match v with
      | ⟨0, h⟩ =>
          have h : ty' = ty := by simpa using h
          Expr.toExprTree body (h ▸ e)
      | ⟨v+1, h⟩ => body.exprTreeAt ⟨v, h⟩
termination_by (Γ_out.length, 1)

/-- `e.toExprTree lets` converts a single expression `e` into an expression tree by looking up the
arguments to `e` in `lets` -/
def Expr.toExprTree (lets : Lets d Γ_in .pure Γ_out) (e : Expr d Γ_out .pure ty) :
    ExprTree d Γ_in ty :=
  .mk e.op e.ty_eq (EffectKind.eq_of_le_pure e.eff_le) (argsToBranches e.args)
termination_by (Γ_out.length + 1, 0)
  where argsToBranches {ts} : HVector (Var Γ_out) ts → ExprTreeBranches d Γ_in ts
    | .nil => .nil
    | .cons v vs => .cons (lets.exprTreeAt v) (argsToBranches vs)
  termination_by (Γ_out.length, ts.length + 2)

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
        obtain ⟨ty', h_get, h_map⟩ :
            ∃ a, Γ_in[v]? = some a ∧ TermModel.morphism.mapTy a = { ty := ty } := by
          simpa using h
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
