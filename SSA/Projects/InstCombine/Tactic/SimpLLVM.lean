/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework.Trace
import SSA.Projects.InstCombine.LLVM.SimpSet
import SSA.Projects.InstCombine.LLVM.Semantics

namespace LLVM

/-!
## LLVM Simplification Tactics
-/

/-!
### Implementation Internal Tactics
These are all scoped tactics, so they won't pollute the global namespace.
If you want to use them elsewhere, first `open LLVM`.
-/
open Lean Meta Elab.Tactic

scoped elab "elim_eq_false_hyp" : tactic => withMainContext do
  let target ← getMainTarget

  -- go target
  -- where
  --   go

/-!
### Main Tactic
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
open Lean Meta Elab.Tactic

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

section RefinesOfParts

namespace SimpLLVM.Bool

theorem eq_false_of_or_eq_false_left {a b : Bool} (h : (a || b) = false) :
    a = false := by
  cases a <;> simp_all
theorem eq_false_of_or_eq_false_right {a b : Bool} (h : (a || b) = false) :
    b = false := by
  cases a <;> simp_all

end SimpLLVM.Bool

/--
Given a *proof* that `b₁ || b₂ || ... || bₙ = false`,
return an array of proofs `hs` s.t. `hs[i] : bᵢ = false`.
-/
def decomposeOrProof (e : Expr) : MetaM (Array Expr) := do
  let type ← inferType e
  let lhs ← mkFreshExprMVar (mkConst ``Bool)
  let expectedType ← mkEq lhs (mkConst ``false)
  unless ← isDefEq type expectedType do
    Elab.Term.throwTypeMismatchError none expectedType type e
  return go #[] e lhs where
    go acc proof type := match type with
    | mkApp2 (.const ``Bool.or _) a b =>
      let leftProof := mkApp3 (mkConst ``SimpLLVM.Bool.eq_false_of_or_eq_false_left) a b proof
      let rightProof := mkApp3 (mkConst ``SimpLLVM.Bool.eq_false_of_or_eq_false_left) a b proof
      let acc := go acc leftProof a
      go acc rightProof b
    | _ => acc.push proof

/-!
TODO: write a simproc that matches for `ofParts isPoison_x x ⊑ ofParts isPoison_y y`,
  checks that `isPoison_y → isPoison_x` and rewrites the goal using
  `ofParts_isRefinedBy_ofParts_iff`.
  Then, it analyzes both `isPoison` conditions, assuming that it's a sequence
  of booleans connected by `||`. For every component, if it is `atom = ...`
  for a free variable `atom`, substitute by this equality. Otherwise, add a separate
  hypothesis for each other element in the sequence.
-/
open PoisonOr in
simproc [simp_llvm_poison] RefinesOfParts ((PoisonOr.ofParts ..) ⊑ (PoisonOr.ofParts ..)) :=
fun origExpr => do
  let_expr HRefinement.IsRefinedBy pα pβ self lhs rhs := origExpr
    | return .continue
  let_expr PoisonOr α := pα | return .continue
  let_expr PoisonOr β := pβ | return .continue

  let_expr PoisonOr.ofParts isPoison_x x := lhs | return .continue
  let_expr PoisonOr.ofParts isPoison_y y := rhs | return .continue

  -- Check `isPoison_y → isPoison_x` using bv_decide
  let isPoisonProof ← mkFreshExprMVar <| some <|
    .forallE .anonymous isPoison_y isPoison_x .default
    -- ^^ `isPoison_y → isPoison_x`
  Elab.Term.TermElabM.run' <| do
    Elab.Term.runTactic isPoisonProof.mvarId! (← `(by bv_decide)) .term
  let isPoisonProof ← instantiateMVars isPoisonProof

  -- Apply `ofParts_isRefinedBy_ofParts_iff`
  let iff ← mkAppM ``ofParts_isRefinedBy_ofParts_iff #[isPoison_x, x, isPoison_y, y]


  /-
  TODO: maybe this would be better as a tactic, rather than a simproc.
  In a simproc, I'd have to prove full iff, but in a tactic it suffices to just
  construct a proof for one direction.
  -/


  return .continue


  -- -- Rewrite using `ofParts_isRefinedBy_ofParts_iff`
  -- let ofPartsIff := mkApp4 (mkConst ``PoisonOr.ofParts_isRefinedBy_ofParts_iff) α β isPoison_x isPoison_y
  -- let rewrittenExpr := mkApp2 ofPartsIff x y
  -- let proof ← mkEqSymm (← mkAppM ``Eq.mp #[ofPartsIff, rewrittenExpr])

  -- -- Analyze `isPoison` conditions
  -- let isPoison_y_disjuncts ← decomposeOr isPoison_y
  -- for disjunct in isPoison_y_disjuncts do
  --   match disjunct with
  --   | Expr.app (Expr.app (Expr.const ``Eq _) atom) rhs _ =>
  -- if atom.isFVar then
  --   -- Substitute `atom = rhs`
  --   let substProof ← mkEqSymm (← mkEqRefl rhs)
  --   addHypothesis atom substProof
  --   | _ =>
  -- -- Add hypothesis for other disjuncts
  -- addHypothesis disjunct (← mkAppM ``id #[disjunct])

  -- return .visit { expr := rewrittenExpr, proof? := some proof }


/--
`substEqFalseHyp` matches on hypotheses of the form `x = false → ...`,
where `x` is a free variable. It substitutes `x` with `false` in the goal
and removes the hypothesis.
-/
simproc [simp_llvm_poison] substEqFalseHyp (_ = false → _) := fun e => do
  let .forallE _ hyp body _ := e
    | return .continue
  let mkApp3 (.const ``Eq _) _ (.fvar x) falsum@(.const ``Bool.false _) := hyp
    | return .continue

  let expr := e.replaceFVarId x falsum
  let proof ← mkFreshExprMVar <| some (← mkEq e expr)
  let _ ← Elab.runTactic proof.mvarId! (← `(by
    bv_decide
  ))
  return .visit { expr, proof? := some proof }
