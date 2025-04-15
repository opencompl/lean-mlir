/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework.Dialect
import SSA.Core.EffectKind
import SSA.Core.ErasedContext

/-!
## Generic Refinement Relation
-/


/-! ### Syntax -/

/--
The notation typeclass for heterogenous refinement relations.
This enables the notation `a ⊑ b`, where `a : α` and `b : β`.

NOTE: This typeclass is not intended for dialect implementors. Please implement
`DialectRefines` instead, from which appropriate `HIsRefinedBy` instances will
be inferred.
-/
class HIsRefinedBy (α β : Type) where
  /--
  We say that `a` is refined by `b`, written as `a ⊑ b`, when
  every observable behaviour of `b` is allowed by `a`.

  Note that this notation is driven by a typeclass, thus the exact meaning
  is type-dependent.
  -/
  isRefinedBy : α → β → Prop

@[inherit_doc] infix:50 " ⊑ "  => HIsRefinedBy.isRefinedBy

/--
The homogenous version of `HIsRefinedBy`.
This enables the notation `a ⊑ b`, where `a, b : α`.

NOTE: This typeclass is not intended for dialect implementors. Please implement
`DialectRefines` instead.
-/
class IsRefinedBy (α : Type) where
  isRefinedBy : α → α → Prop

instance [IsRefinedBy α] : HIsRefinedBy α α where
  isRefinedBy := IsRefinedBy.isRefinedBy

/-
TODO: Do we actually need `IsRefinedBy`?
We don't expect users to derive instances of `HIsRefinedBy` themselves to begin
with: we expect them to use `DialectRefines` (which might be heterogeneous or homogeneous).
Then, we--the framework authors--write all the various notations derived from the
`DialectRefines` instance, but we do so generically and thus always heterogenously.

So far, I've not written a homogenous `IsRefinedBy` instance, and all the further instances
I can think of right now will be heterogenous also.
-/


/-! ### Dialect Refinement -/

/--
`DialectHRefines` defines an heterogenous refinement relation accross two dialects.

Various instances of the ` ⊑ ` refinement notation will be derived from `DialectHRefines`.
In particular, this class defines refinement for monadic values, from which
refinement of pure values `x, y` is defined as `pure x ⊑ pure y.`
-/
class DialectHRefines (d : Dialect) (d' : Dialect) [TyDenote d.Ty] [TyDenote d'.Ty] where
  /--
  `IsTypeCompatible t u` implies that the semantics of types `t` and `u` are comparable,
  in the sense that it is valid to ask whether an inhabitant of `⟦t⟧` is refined
  by an inhabitant of `⟦u⟧`.

  When using the `· ⊑ ·` refinement notation, the precondition that the relevant
  types are compatible is stated using the `Fact` typeclass.
  Hence, when defining an instance of `DialectHRefines` it is also expected that
  you provide relevant instances of `Fact (IsTypeCompatible _ _)`.
  Do recall that, as per the `Fact` documentation, such instances ought to be
  either `local` or `scoped`!
  -/
  IsTypeCompatible : d.Ty → d'.Ty → Prop
  -- TODO: the following ought to be `IsRefinedBy` by the naming convention.
  isRefinedBy {t u} : IsTypeCompatible t u → d.m ⟦t⟧ → d'.m ⟦u⟧ → Prop
open DialectHRefines

namespace DialectHRefines
variable {d d'} [TyDenote d.Ty] [TyDenote d'.Ty] [DialectHRefines d d']
variable {t : d.Ty} {u : d'.Ty} [h : Fact (IsTypeCompatible t u)]

/-- Refinement for monadic values -/
instance instRefinementMonadic : HIsRefinedBy (d.m ⟦t⟧) (d'.m ⟦u⟧) where
  isRefinedBy := DialectHRefines.isRefinedBy h.out

variable [Pure d.m] [Pure d'.m]

/-- Refinement for pure values -/
instance instRefinementPure : HIsRefinedBy ⟦t⟧ ⟦u⟧ where
  isRefinedBy x y := (pure x : d.m _) ⊑ (pure y : d'.m _)

/-
HACK: `EffectKind.toMonad` is reducible, which causes some issues.
      Namely, trying to synthesize
        `HIsRefinedBy (EffectKind.pure.toMonad ..) _`
      will not find an instance where `eff` is a generic effect:
        `HIsRefinedBy (eff.toMonad ..) _`
      Thus, we locally make `toMonad` irreducible.
TODO: We should consider removing the reducible attribute globally, but I'm a
      bit scared that might break our proof automation (e.g. simp_peephole).
-/
set_option allowUnsafeReducibility true
attribute [local semireducible] EffectKind.toMonad

/-- Refinement for *potentially* monadic values -/
instance instRefinementEffect {eff eff' : EffectKind} :
    HIsRefinedBy (eff.toMonad d.m ⟦t⟧) (eff'.toMonad d'.m ⟦u⟧) where
  isRefinedBy x y := eff.coe_toMonad x ⊑ eff'.coe_toMonad y

section Lemmas

@[simp] theorem toMonad_pure_IsRefinedBy_toMonad_pure_iff
    {x : EffectKind.pure.toMonad d.m ⟦t⟧} {y : EffectKind.pure.toMonad d'.m ⟦u⟧} :
    (x ⊑ y) ↔ (HIsRefinedBy.isRefinedBy (α := ⟦t⟧) (β := ⟦u⟧) x y) := by
  rfl

@[simp] theorem toMonad_impure_IsRefinedBy_toMonad_impure_iff
    {x : EffectKind.impure.toMonad d.m ⟦t⟧} {y : EffectKind.impure.toMonad d'.m ⟦u⟧} :
    (x ⊑ y) ↔ (HIsRefinedBy.isRefinedBy (α := d.m ⟦t⟧) (β := d'.m ⟦u⟧) x y) := by
  rfl

end Lemmas

end DialectHRefines

-- TODO: homogeneous `DialectRefines` convenience class

/--
A lawful homogenous (i.e., within a single dialect) refinement instance is one where
the type compatiblity relation is reflexive.

NOTE: any use of `LawfulDialectRefines` in a bound should likely be followed by
`open LawfulDialectRefines.FactInstances` to make the relevant (scoped) `Fact`
instances available.
-/
class LawfulDialectRefines (d : Dialect) [TyDenote d.Ty] extends DialectHRefines d d where
  isTypeCompatible_rfl : ∀ t, IsTypeCompatible t t

namespace LawfulDialectRefines.FactInstances

/-- See `Fact` documentation for why this must be a scoped instance -/
scoped instance [TyDenote d.Ty] [LawfulDialectRefines d] {t : d.Ty} : Fact (IsTypeCompatible t t) where
  out := LawfulDialectRefines.isTypeCompatible_rfl t

end LawfulDialectRefines.FactInstances
