/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework.Trace
import SSA.Projects.InstCombine.LLVM.SimpSet
import SSA.Projects.InstCombine.LLVM.Semantics

/-!
## LLVM Simplification Tactics
-/

/-!
### Tactics
-/

/--
`simp_llvm_ops` unfolds semantic definitions for LLVM dialect operations,
and re-associates monadic `bind`s to a canonical form.

NOTE: This is simply thin wrapper around the `simp_llvm_ops` simpset.
-/
macro "simp_llvm_ops" : tactic => `(tactic| simp only [simp_llvm_ops])

/--
TODO: document this
-/
macro "simp_llvm_poison" : tactic => `(tactic| simp only [simp_llvm_poison])

/--
`simp_llvm` simplifies semantic definitions for LLVM dialect operations into
pure bitvector and Boolean operations.

NOTE: `simp_llvm` is a thin wrapper around `simp_llvm_ops` and `simp_llvm_poison`.
-/
macro "simp_llvm" : tactic => `(tactic| (
  simp only [simp_llvm_ops, simp_llvm_poison, seval]
))

/-!
### Simp Lemmas
-/

attribute [simp_llvm_poison] bind_assoc
/-!
We already re-associate monadic `bind`s in `simp_llvm_ops`, and the simpset
will be extended with unfolding lemmas in `LLVM/Semantics.lean`,
but the simpset is otherwise quite minmal.
-/

/-!
`simp_llvm_poison` is the workhorse of the simplification process.
-/

namespace LLVM.IntW

/--
Replace universal quantifiers `∀ (x : IntW w), ...` with universal
quantifiers over the components `∀ (isPoison : Bool) (x : BitVec w), ...`.
This replaces occurences of `x` in the original goal with `PoisonOr.ofPart`,
and hence will be the start of the simplification process.
-/
theorem forall_iff_forall_ofParts (P : LLVM.IntW w → Prop) :
    (∀ x, P x) ↔ ∀ isPoison x, P (PoisonOr.ofParts isPoison x) := by
  constructor
  · intro h _ _; apply h
  · intro h x; simpa [PoisonOr.ofParts_isPoison_getValue] using h x.isPoison x.getValue
attribute [simp_llvm_poison]
  LLVM.IntW.forall_iff_forall_ofParts

open Lean Meta in
/--
`RefinesIff` matches on refinment expressions `$lhs ⊑ $rhs`, where neither
lhs nor rhs are applications of `PoisonOr.ofParts`.
If so, it rewrites the goal using `PoisonOr.ofParts_isPoison_getValue`.

This simproc tries to ensure we have an application of `PoisonOr.ofParts` at the
top-level of the goal.
-/
simproc [simp_llvm_poison] RefinesIff ((_ : PoisonOr _) ⊑ (_ : PoisonOr _)) := fun origExpr => do
  let_expr HRefinement.IsRefinedBy pα pβ self lhs rhs := origExpr
    | return .continue
  let_expr PoisonOr α := pα | return .continue
  let_expr PoisonOr β := pβ | return .continue

  -- TODO: we could rewrite only the lhs or rhs, if the other is already
  --       an application of `PoisonOr.ofParts`. For now, this works.
  if lhs.isAppOf ``PoisonOr.ofParts || rhs.isAppOf ``PoisonOr.ofParts then
    return .continue
  else
    let inhabited_α ← synthInstance (mkApp (.const ``Inhabited [1]) α)
    let inhabited_β ← synthInstance (mkApp (.const ``Inhabited [1]) β)
    let isRefinedBy := mkApp3 (mkConst ``HRefinement.IsRefinedBy) pα pβ self
    let expr :=
      let ofParts (α inhabited e : Expr) : Expr :=
        mkApp3 (mkConst ``PoisonOr.ofParts) α
          (mkApp2 (mkConst ``PoisonOr.isPoison) α e)
          (mkApp3 (mkConst ``PoisonOr.getValue) α inhabited e)
      let lhs := ofParts α inhabited_α lhs
      let rhs := ofParts β inhabited_β rhs
      mkApp2 isRefinedBy lhs rhs

    let lhsEq := mkApp3 (mkConst ``PoisonOr.ofParts_isPoison_getValue) α inhabited_α lhs
    let rhsEq := mkApp3 (mkConst ``PoisonOr.ofParts_isPoison_getValue) β inhabited_β rhs
    let proof ← mkCongr (←mkCongrArg isRefinedBy lhsEq) rhsEq
    let proof ← mkEqSymm proof
    trace[LeanMLIR.Elab] "type of proof: {← inferType proof}"
    Meta.check proof
    return .visit { expr, proof? := some proof }

/-! First, a set of lemmas to simplify `Bool` or `Prop` connectives,
these generally occur as `if ... then poison else ...`, to state a poison
pre-condition.
-/
attribute [simp_llvm_poison]
  false_and and_false Bool.false_and Bool.and_false
  false_or or_false Bool.false_or Bool.or_false
  reduceIte

/-!
Then, we add a collection of lemmas that are primarily used to simplify
application of `isPoison`.
-/
open PoisonOr in
attribute [simp_llvm_poison]
  -- `bind` lemmas
  pure_def poison_bind value_bind bind_poison
  bind₂_poison_left bind₂_poison_right bind₂_value
  -- `ofParts` lemmas
  ofParts_true ofParts_false
  isPoison_poison isPoison_value getValue_value
  isPoison_ofParts_bind isPoison_ite_poison

/-!
TODO: write a simproc that matches for `ofParts isPoison_x x ⊑ ofParts isPoison_y y`,
      check that `isPoison_y → isPoison_x` and rewrites the goal using
      `ofParts_isRefinedBy_ofParts_iff`.
      Then, it analyzes both `isPoison` conditions, assuming that it's a sequence
      of booleans connected by `||`. For every component, if it is `atom = ...`
      for a fvar `atom`, substitute by this equality. Otherwise, add a separate
      hypothesis for each other element in the sequence.

-/
