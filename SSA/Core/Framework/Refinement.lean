/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework.Dialect
import SSA.Core.EffectKind
import SSA.Core.ErasedContext
import SSA.Core.Tactic.SimpSet

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

@[inherit_doc] infix:50 " ⊑ "  => HRefinement.IsRefinedBy

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

/-!
## Normal Forms

In a concrete dialect, we expect to have a kind of waterfall of refinement
instances. Take, for example, the LLVM dialect:
* Firstly, there is the `PoisonOr _` type, which has a refinement relation.
* Then, there is the `LLVM.IntW w` type, which is a (semireducible!) alias for
  `PoisonOr (BitVec w)`. Because it is not reducible, it has its own refinement
  instance.
* Using the latter, there is the `DialectHRefinement` instance for the LLVM
  dialect.
* This `DialectHRefinement` instance implies refinement instances for both
  monadic value `LLVM.m ⟦t⟧` and pure values `⟦t⟧`.

Recall, however, that LLVM is a *pure* dialect (that is, `LLVM.m` is `Id`).
Suppose we had a `MemLLVM` dialect, which also captures memory side effects,
then we'd expect the following refinement instances:
* We still start with `PoisonOr _` and `LLVM.IntW _`, and their refinement.
* Then, we expect some `EffectM` monad, which will have a refinement instance
  for `EffectM α`, with `α` being some generic type with a refinement instance.
* Using both of the above, we then define the `DialectHRefinement` instance,
  which implies the same refinement instances as before.

Note that in either case, the semantics content is defined at the top of the
list, with the instances after `DialectHRefinement` simply being ways to express
this refinement for alternative spellings of the same type.

Thus, although a rewrite like `toMonad_pure_IsRefinedBy_toMonad_pure_iff`
*in general* seems like a good idea (the rhs is a simpler expression, after all),
for a concrete dialect this rewrite is actually hiding the semantic content by
going *down* this list of instances.

Luckily, we have a dedicated simpset intended for concrete rewrites, `simp_denote`.
Thus, we add set of lemmas to this simpset which rewrite the derived instances
in terms of the original `DialectHRefinement` instance.

We expect dialect implementors to then add their dialect-specific simplemmas to
`simp_denote`, to go all the way up the list of instances.
-/

section SimpDenote

open Lean Meta in
/--
`reduceIsRefinedBy` simplifies `HRefinement` instances that are derived by an `DialectHRefinement`
instance into an application of `DialectHRefinement.IsRefinedBy`.

NOTE: this simproc matches on *all* occurences of `HRefinement.IsRefinedBy`, which could potentially
be expensive. Ideally, we'd include the specific instances we're searching for in the discrtree key.
Furthermore, we have a tendency to rewrite `toType t` into the underlying type,
so we do *not* want `toType`, or `Dialect.m` or similar methods to be part of the index.

For example, this could be one of the rewrites that are expressed by this simproc:
```
theorem monadic_isRefinedBy_iff (x : d.m ⟦t⟧) (y : d'.m ⟦u⟧) :
    @HRefinement.IsRefinedBy (no_index _) (no_index _) (instRefinementMonadic) x y
    ↔ DialectHRefinement.IsRefinedBy x y := by rfl
```
However, even if we write these rewrites as simp-lemmas: the instances are *not*
part of the discrtree key indexing, so the above will *also* match against all
occurences of `HRefinement.IsRefinedBy`.
-/
dsimproc [simp_denote] reduceIsRefinedBy (_ ⊑ _) := fun e => do
  let_expr HRefinement.IsRefinedBy _α _β inst a b := e
    | return .continue

  /-
    TODO: we probably only want to simplify these instances if the dialects `d`
    and `d'` are concrete. Meaning if `d` and `d'` are not just fvars (although
    we probably should allow them to be *contain* fvars, so that, say,
    `MetaLLVM φ` is still considered concrete).
  -/

  match_expr inst with
  | instRefinementMonadic d d' tyDenote tyDenote' instRefinement t u =>
      let expr := mkAppN (mkConst ``DialectHRefinement.IsRefinedBy)
        #[d, d', tyDenote, tyDenote', instRefinement, t, u, a, b]
      return .visit expr
  | instRefinementEffect d d' tyDenote tyDenote' instRefinement t u instPure instPure' eff eff' =>
      let a :=
        let Ty := mkApp (mkConst ``Dialect.Ty) d
        let m := mkApp (mkConst ``Dialect.m) d
        let α := mkApp3 (mkConst ``TyDenote.toType) Ty tyDenote t
        mkApp5 (mkConst ``EffectKind.coe_toMonad) m α instPure eff a
      let b :=
        let Ty := mkApp (mkConst ``Dialect.Ty) d'
        let m := mkApp (mkConst ``Dialect.m) d'
        let α := mkApp3 (mkConst ``TyDenote.toType) Ty tyDenote' u
        mkApp5 (mkConst ``EffectKind.coe_toMonad) m α instPure' eff' b
      let expr := mkAppN (mkConst ``DialectHRefinement.IsRefinedBy)
        #[d, d', tyDenote, tyDenote', instRefinement, t, u, a, b]
      return .visit expr
  | _ => return .continue

end SimpDenote

end DialectHRefinement

/--
A lawful homogenous (i.e., within a single dialect) refinement instance is one
where refinement is reflexive and transitive (i.e., it is a preorder).
-/
class PreorderDialectRefinement (d : Dialect) [TyDenote d.Ty] [DialectHRefinement d d] where
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
