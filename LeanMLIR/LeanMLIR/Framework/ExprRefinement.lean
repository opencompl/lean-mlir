import LeanMLIR.Framework
import LeanMLIR.Framework.Refinement

/-!
## Refinement instances for core datatypes
-/
namespace LeanMLIR
variable {d} [TyDenote d.Ty] [DialectHRefinement d d] [DialectSignature d] [DialectDenote d] [Monad d.m]

/--
A valuation `V₁` is refined by another valuation `V₂` (in the same context) when
the values for each variable `v` in the respective valuations are in refinement.
-/
instance {Γ : Ctxt d.Ty} : Refinement Γ.Valuation where
  IsRefinedBy V₁ V₂ := ∀ t (v : Γ.Var t), V₁ v ⊑ V₂ v

/--
An expression `e₁` is refined by an expression `e₂` (of the same dialect) if their
respective denotations under every valuation are in the refinement relation.
-/
instance: HRefinement (Expr d Γ eff₁ t) (Expr d Γ eff₂ t) where
  IsRefinedBy e₁ e₂ :=
    ∀ V, e₁.denote V ⊑ e₂.denote V

/--
A program `c₁` is refined by a program `c₂` (of the same dialect) if their
respective denotations under every valuation are in the refinement relation.
-/
instance : HRefinement (Com d Γ eff₁ t) (Com d Γ eff₂ t) where
  IsRefinedBy c₁ c₂ :=
    ∀ V, c₁.denote V ⊑ c₂.denote V


/-!
TODO: We could add a LawfulDenotation class here, which asserts that the semantics
      are monotone w.r.t. the refinement relation. For example:
      ```lean
      class LawfulDenotation (d : Dialect) ... where
        monotone : ∀ {Γ eff t} (e : Expr d Γ eff t) (V₁ V₂ : Γ.Valuation),
                        V₁ ⊑ V₂ → e.denote V₁ ⊑ e.denote V₂
      ```
-/
