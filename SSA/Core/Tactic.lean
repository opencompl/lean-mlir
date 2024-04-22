/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework
import SSA.Core.Util
import SSA.Core.MLIRSyntax.EDSL
import Qq
import Lean.Meta.KAbstract
import Lean.Elab.Tactic.ElabTerm

namespace SSA

open Ctxt (Var Valuation DerivedCtxt)

section

open Lean Meta Elab.Tactic Qq

/-- Given a `V : Valuation Γ`, fully reduce the context `Γ` in the type of `V` -/
elab "change_mlir_context " V:ident : tactic => do
  let V : Name := V.getId
  withMainContext do
    let ctx ← getLCtx
    let Vdecl : LocalDecl ← match ctx.findFromUserName? V with
      | some decl => pure decl
      | none => throwError f!"Failed to find variable `{V}` in the local context"

    -- Assert that the type of `V` is `Ctxt.Valuation ?Γ`
    let Ty ← mkFreshExprMVarQ q(Type)
    let Γ  ← mkFreshExprMVarQ q(Ctxt $Ty)
    let G  ← mkFreshExprMVarQ q(TyDenote $Ty)
    let _  ← assertDefEqQ Vdecl.type q(@Ctxt.Valuation $Ty $G $Γ)

    -- Reduce the context `Γ`
    let Γr ← ctxtNf Γ
    let Γr : Q(Ctxt $Ty) := Γr

    let goal ← getMainGoal
    let newGoal ← goal.changeLocalDecl Vdecl.fvarId q(Valuation $Γr)
    replaceMainGoal [newGoal]

end

open Lean Elab Tactic Meta

/--
Check if an expression is contained in the current goal and fail otherwise.
This tactic does not modify the goal state.
 -/
local elab "contains? " ts:term : tactic => withMainContext do
  let tgt ← getMainTarget
  if (← kabstract tgt (← elabTerm ts none)) == tgt then throwError "pattern not found"

/-- Look for a variable in the context and generalize it, fail otherwise. -/
macro "generalize_or_fail" "at" ll:ident : tactic =>
  `(tactic|
      (
        -- We first check with `contains?` if the term is present in the goal.
        -- This is needed as `generalize` never fails and just introduces a new
        -- metavariable in case no variable is found. `contains?` will instead
        -- fail if the term is not present in the goal.
        contains? ($ll (_ : Var ..))
        generalize ($ll (_ : Var ..)) = e at *;
        simp (config := {failIfUnchanged := false}) only [TyDenote.toType] at e
        revert e
      )
  )

/-- `only_goal $t` runs `$t` on the current goal, but only if there is a goal to be solved.
Essentially, this silences "no goals to be solved" errors -/
macro "only_goal" t:tacticSeq : tactic =>
  `(tactic| first | done | $t)

/--
`simp_peephole at ΓV` simplifies away the framework overhead of denoting expressions/programs,
that are evaluated with the valuation `ΓV`.

In it's bare form, it only simplifies away the core framework definitions (e.g., `Expr.denote`), but
we can also pass it dialect-specific definitions to unfold, as in:
`simp_peephole [foo, bar, baz] at ΓV`

After simplifying, the goal state should only contain occurences of valuation `ΓV` directly applied
to some variable `v : Var Γ ty`. The tactic tries to eliminate the valuation completely,
by introducing a new universally quantified (Lean) variable to the goal for every
(object) variable `v`. -/
macro "simp_peephole" "[" ts: Lean.Parser.Tactic.simpLemma,* "]" "at" Γv:ident : tactic =>
  `(tactic|
      (
      /- First, massage the type of `Γv`.
      Generally, `simp_peephole` is expected to be run with the type of `Γv` a
      (not necessarily reduced) ground-term.
      After `change_mlir_context`, type of `Γv` should then be `[t₁, t₂, ..., tₙ]`, for some
      types `t₁`, `t₂`, etc. -/
      change_mlir_context $Γv

      /- Then, unfold the definition of the denotation of a program -/
      simp (config := {failIfUnchanged := false}) only [
        Int.ofNat_eq_coe, Nat.cast_zero, DerivedCtxt.snoc, DerivedCtxt.ofCtxt,
        DerivedCtxt.ofCtxt_empty, Valuation.snoc_last,
        Com.denote, Expr.denote, HVector.denote, Var.zero_eq_last, Var.succ_eq_toSnoc,
        Ctxt.empty, Ctxt.empty_eq, Ctxt.map_cons, Ctxt.map_nil, Ctxt.snoc, Ctxt.Valuation.nil, Ctxt.Valuation.snoc_last, Ctxt.map,
        Ctxt.Valuation.snoc_eval, Ctxt.ofList, Ctxt.Valuation.snoc_toSnoc,
        HVector.map, HVector.getN, HVector.get, HVector.toSingle, HVector.toPair, HVector.toTuple,
        OpDenote.denote, Expr.op_mk, Expr.args_mk,
        DialectMorphism.mapOp, DialectMorphism.mapTy, List.map, Ctxt.snoc, List.map,
        Function.comp, Valuation.ofPair, Valuation.ofHVector, Function.uncurry,
        List.length_singleton, Fin.zero_eta, List.map_eq_map, List.map_cons, List.map_nil,
        bind_assoc, pairBind,
        $ts,*]

      -- `simp` might close trivial goals, so we use `only_goal` to ensure we only run
      -- more tactics when we still have goals to solve, to avoid 'no goals to be solved' errors.
      only_goal
        simp (config := {failIfUnchanged := false}) only [Ctxt.Var.toSnoc, Ctxt.Var.last]
        repeat (generalize_or_fail at $Γv)
        clear $Γv
      )
   )

/-- `simp_peephole` with no extra user defined theorems. -/
macro "simp_peephole" "at" Γv:ident : tactic => `(tactic| simp_peephole [] at $Γv)

end SSA
