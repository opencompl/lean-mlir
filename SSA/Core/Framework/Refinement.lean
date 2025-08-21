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

instance instHRefinementOfRefinement [Refinement α] : HRefinement α α where
  IsRefinedBy := Refinement.IsRefinedBy

@[simp_denote]
def Refinement.ofHRefinement (inst : HRefinement α α) : Refinement α where
  IsRefinedBy x y := x ⊑ y

/-! #### Trivial Refinement -/

section OfEq

/-- Equality induces a trivial (homogenous) refinement relation on any type `α`. -/
def Refinement.ofEq : Refinement α where
  IsRefinedBy := Eq

instance (priority := low) :
    Std.Refl (HRefinement.IsRefinedBy (self := @instHRefinementOfRefinement α .ofEq)) where
  refl _ := rfl
instance (priority := low) :
    IsTrans α (HRefinement.IsRefinedBy (self := @instHRefinementOfRefinement α .ofEq)) where
  trans _ _ _ := Eq.trans
instance (priority := low) [DecidableEq α] :
    Decidable (HRefinement.IsRefinedBy (self := @instHRefinementOfRefinement α .ofEq) x y) :=
  decidable_of_iff (x = y) (by rfl)

end OfEq

/-! ### Id Refinement -/
namespace Id
variable {α β} [inst : HRefinement α β]

instance instRefinement : HRefinement (Id α) (Id β) := inst

@[simp_denote (high)] -- high priority so that this is tried before the `reduceIsRefinedBy` simproc
lemma pure_isRefinedBy_pure (x : α) (y : β) :
  (pure x : Id _) ⊑ (pure y : Id _) ↔ x ⊑ y := by rfl

end Id

/-! ### Dialect Refinement -/
section DialectHRefinement

/--
`DialectHRefinement` defines an heterogenous refinement relation accross two dialects.

Various instances of the ` ⊑ ` refinement notation will be derived from `DialectHRefinement`.
In particular, this class defines refinement for monadic values, from which
refinement of pure values `x, y` is defined as `pure x ⊑ pure y.`
-/
class DialectHRefinement (d : Dialect) (d' : Dialect) [TyDenote d.Ty] [TyDenote d'.Ty] where
  /--
  Define refinement of monadic values (of arbitrary underlying types)
  -/
  MonadIsRefinedBy {α β} [inst : HRefinement α β] : HRefinement (d.m α) (d'.m β) := by
    solve
    | exact @Id.instRefinement
  /--
  We say that `a` is refined by `b`, written as `a ⊑ b`, when
  every observable behaviour of `b` is allowed by `a`.
  -/
  IsRefinedBy {t : d.Ty} {u : d'.Ty} : HRefinement ⟦t⟧ ⟦u⟧

attribute [instance, simp, simp_denote] DialectHRefinement.IsRefinedBy
attribute [instance, simp, simp_denote] DialectHRefinement.MonadIsRefinedBy

end DialectHRefinement

/-! ### EffectKind.toMonad Refinement -/
section EffectKind
open EffectKind (coe_toMonad)
variable {eff₁ eff₂ : EffectKind} {m n : Type → Type} {α β : Type}
          [HRefinement (m α) (n β)] [Pure m] [Pure n]

instance instEffToMonadRefinement :
    HRefinement (eff₁.toMonad m α) (eff₂.toMonad n β) where
  IsRefinedBy x y := coe_toMonad x ⊑ coe_toMonad y

open EffectKind (pure) in
@[simp, simp_denote] lemma effToMonadRefinement_pure (x : pure.toMonad m α) (y : pure.toMonad n β) :
    x ⊑ y ↔ pure (f := m) (@id α x) ⊑ pure (f := n) (@id β y) := by
  rfl

open EffectKind (impure) in
@[simp, simp_denote] lemma effToMonadRefinement_impure (x : impure.toMonad m α) (y : impure.toMonad n β) :
    x ⊑ y ↔ (@id (m α) x) ⊑ (@id (n β) y) := by
  rfl

end EffectKind

/-! ### HVector Refinement -/
namespace HVector
variable {A : α → Type} {B : β → Type} [∀ a b, HRefinement (A a) (B b)]

/--
We say that a vector of values `xs` is refined by another vector `ys` (written
`xs ⊑ ys`) when `xs` and `ys` have the same number of elements, and each element
of `xs` is refined by the corresponding element of `ys` at the same index.
-/
def IsRefinedBy {as} {bs} : HVector A as → HVector B bs → Prop
  | .nil, .nil => True
  | .cons x xs, .cons y ys => x ⊑ y ∧ xs.IsRefinedBy ys
  | _, _ => False

instance  : HRefinement (HVector A as) (HVector B bs) where
  IsRefinedBy := HVector.IsRefinedBy

variable {x : A a} {xs : HVector A as} {y : B b} {ys : HVector B bs}

@[simp, simp_denote] lemma cons_isRefinedBy_cons  : ((x ::ₕ xs) ⊑ (y ::ₕ ys)) ↔ (x ⊑ y ∧ xs ⊑ ys) := by rfl
@[simp, simp_denote] lemma nil_isRefinedBy_nil    : (nil : HVector A _) ⊑ (nil : HVector B _)     := True.intro

@[simp, simp_denote] lemma not_nil_isRefinedBy_cons : ¬((nil : HVector A _) ⊑ (y ::ₕ ys)) := by rintro ⟨⟩
@[simp, simp_denote] lemma not_cons_isRefinedBy_nil : ¬((x ::ₕ xs) ⊑ (nil : HVector B _)) := by rintro ⟨⟩

end HVector


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
open Lean Meta
open Simp (SimpM)

-- TODO: upstream (or drop)
def Array.replicateM [Monad m] (size : Nat) (x : m α) : m (Array α) :=
  replicate size () |>.mapM (fun _ => x)

partial def reduceIsRefinedByAux (α β inst lhs rhs : Expr) : SimpM (Option Expr) := do
  let ⟨instFn, instArgs⟩ := inst.withApp Prod.mk
  trace[LeanMLIR.Elab] "Refinement instance is an application of: {instFn}"
  match instFn.constName with
  | ``instEffToMonadRefinement => simpEffToMonad instArgs
  | ``Id.instRefinement => simpId instArgs
  | ``inferInstance => simpInfer instArgs
  | _ =>
    -- if let .proj `DialectHRefinement projIdx instDialectRef := inst then
    -- if let .proj _ projIdx instDialectRef := instFn then
    --   simpProjDialect projIdx instDialectRef
    -- else
    return none
where
  loop (e : Expr) (returnArgOnFail := true) : SimpM (Option Expr) :=
    let e? := if returnArgOnFail then some e else none
    let_expr HRefinement.IsRefinedBy α β inst a b := e.consumeMData
      | return e?
    withTraceNode `LeanMLIR.Elab (fun _ => pure m!"Simplifying refinement instance: {inst}") <| do
      Meta.check e
      let res? ← reduceIsRefinedByAux α β inst.consumeMData a b
      if let some res := res? then
        trace[LeanMLIR.Elab] "Simplified to: {res}"
      else
        trace[LeanMLIR.Elab] "Failed to simplify"
      return res?.or e?
  throwUnexpectedArgs := do
    Meta.check inst
    throwError "Error: unexpected number of arguments to instance. \
                This could be an internal bug, or expression is mall-formed: {inst}"
  isRefinedByAppN args :=
    loop <| mkAppN (mkConst ``HRefinement.IsRefinedBy) args
  isRefinedByAppOptM args : SimpM _ := do
    let e ← mkAppOptM ``HRefinement.IsRefinedBy args
    loop e
  /--
  Simplifier for `instEffToMonadRefinement`.
  -/
  simpEffToMonad instArgs := do
    let #[eff₁, eff₂, m, n, α, β, instRef, instPureM, instPureN] := instArgs
      | throwUnexpectedArgs
    let mα := mkApp m α
    let nβ := mkApp n β
    let fallback := do
      let lhs' := mkApp5 (mkConst ``EffectKind.coe_toMonad) m α instPureM eff₁ lhs
      let rhs' := mkApp5 (mkConst ``EffectKind.coe_toMonad) n β instPureN eff₂ rhs
      isRefinedByAppN #[mα, nβ, instRef, lhs', rhs']

    -- TODO: do I really need this special casing? I suspect that just using the fallback
    --       defined above for every case is already enough, and would be quite a bit simpler
    let some eff₁ := EffectKind.ofLeanLiteral eff₁ | fallback
    let some eff₂ := EffectKind.ofLeanLiteral eff₂ | fallback
    match eff₁, eff₂ with
      | .impure, .impure =>
        isRefinedByAppN #[mα, nβ, instRef, lhs, rhs]
      | _, _ => fallback
  /--
  Simplifier for `Id.instRefinement`
  -/
  simpId instArgs := do
    trace[LeanMLIR.Elab] "args: {instArgs}"
    let #[_α, _β, _self] := instArgs | throwUnexpectedArgs
    isRefinedByAppN (instArgs ++ #[lhs, rhs])
  /--
  Simplifier for `inferInstance`
  -/
  simpInfer instArgs := do
    let some self := instArgs[1]? | throwUnexpectedArgs
    trace[LeanMLIR.Elab] "actual instance: {self}"
    isRefinedByAppN #[α, β, self, lhs, rhs]

  -- /--
  -- Simplifier for projections of `DialectHRefinement` instances
  -- -/
  -- simpProjDialect projIdx _instDialectRef := do
  --   -- trace[LeanMLIR.Elab] "is a projection: {Lean.checkEmoji}"
  --   -- trace[LeanMLIR.Elab] "raw expression: {toExpr inst}"
  --   if projIdx = 0 then -- MonadIsRefinedBy field
  --     let α ← mkFreshExprMVar (Expr.sort 1)
  --     let β ← mkFreshExprMVar (Expr.sort 1)
  --     let i ← mkFreshExprMVar none
  --     let expected := (mkAppN (mkConst ``instRefinementId) #[α, β, i])
  --     if ← (withTransparency .default <| isDefEq inst expected) then
  --       return visitIsRefinedByAppN #[α, β, i, lhs, rhs]
  --     else
  --       trace[LeanMLIR.Elab] "{Lean.crossEmoji} Failed to unify instance:\n\t{inst}\
  --         \nwith expected:\n\t{expected}"
  -- return .continue
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
  return match ← reduceIsRefinedByAux.loop (returnArgOnFail := false) e with
  | some e => .visit e
  | none => .continue

  -- /-
  --   TODO: we probably only want to simplify these instances if the dialects `d`
  --   and `d'` are concrete. Meaning if `d` and `d'` are not just fvars (although
  --   we probably should allow them to be *contain* fvars, so that, say,
  --   `MetaLLVM φ` is still considered concrete).
  -- -/

  -- match_expr inst with
  -- | instRefinementMonadic d d' tyDenote tyDenote' instRefinement t u =>
  --     let expr := mkAppN (mkConst ``DialectHRefinement.IsRefinedBy)
  --       #[d, d', tyDenote, tyDenote', instRefinement, t, u, a, b]
  --     return .visit expr
  -- | instRefinementPure d d' tyDenote tyDenote' instRefinement t u instPure instPure' =>
  --     let a :=
  --       let Ty := mkApp (mkConst ``Dialect.Ty) d
  --       let m := mkApp (mkConst ``Dialect.m) d
  --       let α := mkApp3 (mkConst ``TyDenote.toType) Ty tyDenote t
  --       mkApp4 (.const ``pure [0, 0]) m instPure α a
  --     let b :=
  --       let Ty := mkApp (mkConst ``Dialect.Ty) d'
  --       let m := mkApp (mkConst ``Dialect.m) d'
  --       let β := mkApp3 (mkConst ``TyDenote.toType) Ty tyDenote u
  --       mkApp4 (.const ``pure [0, 0]) m instPure' β b
  --     let expr := mkAppN (mkConst ``DialectHRefinement.IsRefinedBy)
  --       #[d, d', tyDenote, tyDenote', instRefinement, t, u, a, b]
  --     return .visit expr
  -- | instRefinementEffect d d' tyDenote tyDenote' instRefinement t u instPure instPure' eff eff' =>
  --     let a :=
  --       let Ty := mkApp (mkConst ``Dialect.Ty) d
  --       let m := mkApp (mkConst ``Dialect.m) d
  --       let α := mkApp3 (mkConst ``TyDenote.toType) Ty tyDenote t
  --       mkApp5 (mkConst ``EffectKind.coe_toMonad) m α instPure eff a
  --     let b :=
  --       let Ty := mkApp (mkConst ``Dialect.Ty) d'
  --       let m := mkApp (mkConst ``Dialect.m) d'
  --       let α := mkApp3 (mkConst ``TyDenote.toType) Ty tyDenote' u
  --       mkApp5 (mkConst ``EffectKind.coe_toMonad) m α instPure' eff' b
  --     let expr := mkAppN (mkConst ``DialectHRefinement.IsRefinedBy)
  --       #[d, d', tyDenote, tyDenote', instRefinement, t, u, a, b]
  --     return .visit expr
  -- | instHRefinementOfRefinement α instRefinement =>
  --     match_expr instRefinement with
  --     | Refinement.ofEq _α =>
  --         return .visit <| mkApp3 (.const ``Eq [1]) α a b
  --     | _ => return .continue
  -- | _ => return .continue

end SimpDenote

/-!
## Lawfulness
-/

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

/-!
## Monad Refinement
-/

/-!
## Instances
We provide some generic refinement instances
-/
section Instances

namespace Prod

instance [HRefinement α γ] [HRefinement β δ] : HRefinement (α × β) (γ × δ) where
  IsRefinedBy := fun (a, b) (c, d) => a ⊑ c ∧ b ⊑ d

@[simp]
theorem isRefinedBy_iff [HRefinement α γ] [HRefinement β δ]
    (a : α) (b : β) (c : γ) (d : δ) :
    (a, b) ⊑ (c, d) ↔ a ⊑ c ∧ b ⊑ d := by
  rfl
end Prod

namespace StateT
variable {m n : Type → Type} [HRefinement (m (α × σ)) (n (β × σ))]

instance : HRefinement (StateT σ m α) (StateT σ n β) where
  IsRefinedBy f g := ∀ s, f s ⊑ g s

-- @[simp] -- I'm not sure if this ought to be simp, as it unfolds the monad
theorem isRefinedBy_iff (f : StateT σ m α) (g : StateT σ n β) :
    f ⊑ g ↔ ∀ s, f s ⊑ g s := by
  rfl

end StateT

end Instances
