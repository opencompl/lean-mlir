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
`DialectRefinement` instead, from which appropriate `HRefinement` instances will
be inferred.
-/
class HRefinement (α β : Type) where
  /--
  We say that `a` is refined by `b`, written as `a ⊑ b`, when
  every observable behaviour of `b` is allowed by `a`.

  Note that this notation is driven by a typeclass, thus the exact meaning
  is type-dependent.
  -/
  IsRefinedBy : α → β → Prop

/-!
For now, we define `· ⊑ ·` as a *scoped* notation, meaning you have to write
`open RefinementNotation` to use it. This is an interim solution until we finish
porting the existing LLVM dialect automation to use the generic refinement
typeclass rather than it's own `⊑` notation.
Once that is done, we will make the notation global.
-/
namespace RefinementNotation
@[inherit_doc] scoped infix:50 " ⊑ "  => HRefinement.IsRefinedBy
end RefinementNotation
open RefinementNotation

/--
The homogenous version of `HRefinement`.
This enables the notation `a ⊑ b`, where `a, b : α`.

NOTE: This typeclass is not intended for dialect implementors. Please implement
`DialectRefinement` instead.
-/
class Refinement (α : Type) where
  IsRefinedBy : α → α → Prop

instance [Refinement α] : HRefinement α α where
  IsRefinedBy := Refinement.IsRefinedBy

/-- Equality induces a trivial (homogenous) refinement relation on any type `α`. -/
def Refinement.ofEq : Refinement α where
  IsRefinedBy := Eq

/-! ### Dialect Refinement -/

/--
`DialectHRefinement` defines an heterogenous refinement relation accross two dialects.

Various instances of the ` ⊑ ` refinement notation will be derived from `DialectHRefinement`.
In particular, this class defines refinement for monadic values, from which
refinement of pure values `x, y` is defined as `pure x ⊑ pure y.`
-/
class DialectHRefinement (d : Dialect) (d' : Dialect) [TyDenote d.Ty] [TyDenote d'.Ty] where
  /--
  We say that `a` is refined by `b`, written as `a ⊑ b`, when
  every observable behaviour of `b` is allowed by `a`.
  -/
  IsRefinedBy {t : d.Ty} {u : d'.Ty} : d.m ⟦t⟧ → d'.m ⟦u⟧ → Prop
open DialectHRefinement

namespace DialectHRefinement
variable {d d' : Dialect} [TyDenote d.Ty] [TyDenote d'.Ty] [DialectHRefinement d d']
variable {t : d.Ty} {u : d'.Ty}

/-- Refinement for monadic values -/
instance instRefinementMonadic : HRefinement (d.m ⟦t⟧) (d'.m ⟦u⟧) where
  IsRefinedBy := DialectHRefinement.IsRefinedBy

variable [Pure d.m] [Pure d'.m]

/-- Refinement for pure values -/
instance instRefinementPure : HRefinement ⟦t⟧ ⟦u⟧ where
  IsRefinedBy x y := (pure x : d.m _) ⊑ (pure y : d'.m _)

/-- Refinement for *potentially* monadic values -/
instance instRefinementEffect {eff eff' : EffectKind} :
    HRefinement (eff.toMonad d.m ⟦t⟧) (eff'.toMonad d'.m ⟦u⟧) where
  IsRefinedBy x y := eff.coe_toMonad x ⊑ eff'.coe_toMonad y

section Lemmas

@[simp] theorem toMonad_pure_IsRefinedBy_toMonad_pure_iff
    {x : EffectKind.pure.toMonad d.m ⟦t⟧} {y : EffectKind.pure.toMonad d'.m ⟦u⟧} :
    (x ⊑ y) ↔ (HRefinement.IsRefinedBy (α := ⟦t⟧) (β := ⟦u⟧) x y) := by
  rfl

@[simp] theorem toMonad_impure_IsRefinedBy_toMonad_impure_iff
    {x : EffectKind.impure.toMonad d.m ⟦t⟧} {y : EffectKind.impure.toMonad d'.m ⟦u⟧} :
    (x ⊑ y) ↔ (HRefinement.IsRefinedBy (α := d.m ⟦t⟧) (β := d'.m ⟦u⟧) x y) := by
  rfl

end Lemmas

end DialectHRefinement

/--
A lawful homogenous (i.e., within a single dialect) refinement instance is one
where refinement is reflexive and transitive (i.e., it is a preorder).
-/
class LawfulDialectRefinement (d : Dialect) [TyDenote d.Ty] [DialectHRefinement d d] where
  isRefinedBy_rfl : ∀ {t : d.Ty} (x : d.m ⟦t⟧), x ⊑ x
  isRefinedBy_trans : ∀ {t u v : d.Ty} (x : d.m ⟦t⟧) (y : d.m ⟦u⟧) (z : d.m ⟦v⟧),
    x ⊑ y → y ⊑ z → x ⊑ z


/-!
**How to define refinement on computations?**

So far, when verifying the Alive peephole rewrites, we've used the following
definition of refinement, where `c` and `d` are LLVM programs with the same
context and return type:
```
  ∀ V, c.denote V ⊑ d.denote V
```
Saying that `c` is refined by `d` when for any valuation `V` the denotation of
`c` under `V` is refined by the denotation of `d` under `V`.

Of course, this definition really only makes sense if `c` and `d` can be evaluated
under the exact same contexts. Thus, to generalize this to multiple dialects, we'd
instead write something like
```
  ∀ V₁ V₂, V₁ ⊑ V₂ → c.denote V₁ ⊑ d.denote V₂
```

Now, the second definition is *not* in general equivalent to the first.
However, if we add the following assumption, that the denotation is monotone
w.r.t. refinement, then we can prove that the two definitions are logically
equivalent:
```
  ∀ V₁ V₂, V₁ ⊑ V₂ → c.denote V₁ ⊑ c.denote V₂
```

It's slightly annoying to have this extra proof burden. Then again, semantics
really ought to be monotone in this way, so it might not be bad to force a proof.
In particular, VeLLVM had a bug in it's semantics which meant it was *not* monotone,
but this really was a bug. The intention of LLVM semantics is that they are monotone.

Note that regardless, the statement of this property requires a notion of semantics,
and thus cannot be stated in the current file, unless we re-order the imports,
which might not actually be a bad idea.
-/
