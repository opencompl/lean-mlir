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
`DialectRefines` instance.

For now, we've used the homogeneous `IsRefinedBy` to define refinement of `Expr`s
and `Coms` in a single dialect.

However, in future we'll likely want to generalize this instance to refinement of
`Com`s and `Expr`s accross two dialects (the definition of which could then be
specialized to the case where `d₁ = d₂` to recover the homogenous version).
It's unclear whether we'll still need `IsRefinedBy` then.

Then again, the homogenous refinement relation will likely involve quantification
over *two* valuations, plus an assumption of some form of refinement between
those valuations. It's very possible that the specialization of this definition
to the case where the dialects are the same is considerably less nice to work
with than the current homogenous definition (and it's certainly unlikely to be
logically equivalent, in general). So, we might want to have separate homo- and
heterogenous instances (where the former should have a high-priority annotation).
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

/-!
**IsTypeCompatible Rationale**:

The above definition has the base assumption that in the homogenous case, it only
makes sense to ask whether `x` is refined by `y` (`x ⊑ y`) when `x` and `y` are
of the same type (i.e., `x, y : ⟦t⟧` for the same `t : d.Ty`; ignoring monadic
effects for now). Under this assumption, it wouldn't make sense to ask whether
`x` is refined by `y` when `y` is a different type, so we would simply define
only instances of `IsRefinedBy ⟦t⟧`, making it impossible to even write
`x ⊑ y` in the latter case.

Of course, there is no simple notion of "the same type" when working accross
dialects, thus we have to make the refinement instance heterogenous. To still
make it impossible to write `x ⊑ y` in "nonsensical" cases, we thus introduce
the `IsTypeCompatible` relation.

However, I now believe this rationale to be potentially flawed in two aspects.

Firstly, it is not the case that we'd only want to compare values of the same type
even within a single dialect. Consider a hypothetical LLVM+RiscV hybrid dialect
used as an intermediary step in instruction lowering: this dialect would have both
LLVM (potentially poisoned) generic-width bitvectors and Risc-V always-concrete,
fixed-width bitvectors. To phrase instruction lowering as a peephole rewrite in
the hybrid dialect, we'd have to be able to state the "correctness" of a rewrite
where the original and rewritten types are not exactly the same.

Of course, adding such capabilities to the rewriter does raise some more questions:
we'd likely have to incorporate some form of casting from the new type to the original,
to ensure the rewritten program is still well-typed. We might have to encode the
meaning of such casts as part of the `DialectHRefines` typeclass, which *might*
actually be easier with an explicit `IsTypeCompatible` relation, rather than
implicitly encoding type compatibility as part of the refinement definition.
It is exactly between compatible types that we should be allowed to implicitly
insert casts (in either direction). Then again, we could always recover the
compatibility relation as "types `t` and `u` are compatible if there exist some
`x : ⟦t⟧` and `y : ⟦u⟧` s.t. `x ⊑ y`".

Secondly, if we forget about any future musings of implicit casts, there is no
harm in allowing `x ⊑ y` to be stated, but defined to be false, whenever `x` and
`y` have compatible types. In fact, it would be somewhat simpler if we just bundle
in the compatibility assumption. If we wanted to state some generic property in
the current phrasing, we'd have to write:
```
∀ {t u} (h : IsTypeCompatible t u) (x : ⟦t⟧) (y : ⟦u⟧), x ⊑ y
```
In the bundled version, we could shorten that to simply:
```
∀ {t u} (x : ⟦t⟧) (y : ⟦u⟧), x ⊑ y
```
-/

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
