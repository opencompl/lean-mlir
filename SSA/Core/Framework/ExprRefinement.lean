import SSA.Core.Framework
import SSA.Core.Framework.Refinement

/-!
## Refinement instances for core datatypes
-/
namespace LeanMLIR
variable {d} [TyDenote d.Ty] [DialectHRefinement d d] [DialectSignature d] [DialectDenote d] [Monad d.m]

/-
TODO: do we need refinement of expressions? If we do, we need to start by
defining refinement of (monadic!) Valuations, which will require some more reworking.
-/

-- /--
-- An expression `e₁` is refined by an expression `e₂` (of the same dialect) if their
-- respective denotations under every valuation are in the refinement relation.
-- -/
-- instance: HRefinement (Expr d Γ eff₁ t) (Expr d Γ eff₂ t) where
--   IsRefinedBy e₁ e₂ :=
--     ∀ V, e₁.denote V ⊑ e₂.denote V

/--
A program `c₁` is refined by a program `c₂` (of the same dialect) if their
respective denotations under every valuation are in the refinement relation.
-/
instance : HRefinement (Com d Γ eff₁ t) (Com d Γ eff₂ t) where
  IsRefinedBy c₁ c₂ :=
    ∀ V, c₁.denote V ⊑ c₂.denote V
