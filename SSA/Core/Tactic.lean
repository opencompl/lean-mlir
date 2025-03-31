/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework
import SSA.Core.Util
import SSA.Core.MLIRSyntax.EDSL
import SSA.Core.Tactic.TacBench
import Qq
import Lean.Meta.KAbstract
import Lean.Elab.Tactic.ElabTerm

namespace SSA

open Ctxt (Var Valuation DerivedCtxt)

open Lean Elab Tactic Meta

/--
Check if an expression is contained in the current goal and fail otherwise.
This tactic does not modify the goal state.
 -/
local elab "contains? " ts:term : tactic => withMainContext do
  let tgt ← getMainTarget
  if (← kabstract tgt (← elabTerm ts none)) == tgt then throwError "pattern not found"

/-- Look for a variable in the context and generalize it, fail otherwise. -/
local macro "generalize_or_fail" "at" ll:ident : tactic =>
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


-- TODO: it's unclear how much of this is actually necessary, as just `simp [DialectDenote.denote]`
--        already seems to do a pretty good job of simplifying.
/--
Simplify an application of `DialectDenote.denote`, assuming the corresponding
semantics have been defined using `def_denote` (or has the same structure as
  if it were defined using `def_denote`).
-/
simproc [simp] denote_op (DialectDenote.denote _ _ _) := fun e => do
  let mkApp2 denoteOp args regArgs := e
    | return .continue
  withTraceNode `LeanMLIR.Elab (fun _ => pure m!"Simplifying: {e}") (collapsed := false) <| do
    let some args ← HVector.toElemExprs args
      | trace[LeanMLIR.Elab] "{crossEmoji} Failed to reflect: {← whnf args}"
        return .continue
    trace[LeanMLIR.Elab] "{checkEmoji} Succesfully reflected arguments: {args}"
    let some regArgs ← HVector.toElemExprs regArgs
      | trace[LeanMLIR.Elab] "{crossEmoji} Failed to reflect: {regArgs}"
        return .continue
    trace[LeanMLIR.Elab] "{checkEmoji} Succesfully reflected regions: {regArgs}"
    /- We reduce `denoteOp` with `whnfD`, keeping in mind that if the semantics
    were defined with `def_denote`, then the unfolded, uncurried expression
    always starts with two lambdas, and lambdas block reduction of their body.
    Hence, we're guaranteed *not* to reduce the clean, curried, semantic expression.
    -/
    let denoteOp ← whnfD denoteOp

    trace[LeanMLIR.Elab] "Reduced to: {denoteOp}"
    lambdaBoundedTelescope denoteOp 2 <| fun fvars body => do
      -- Assert that we indeed have those two lambdas
      if fvars.size != 2 then return .continue

      let semantics := body.getBoundedAppFn (args.size + regArgs.size)
      let semantics := mkAppN semantics (args.map Prod.snd)
      -- let semantics := mkAppN semantics regArgs -- TODO: properly apply regArgs (which involves currying)
      return .visit { expr := semantics }

/--
`simp_peephole` simplifies away the framework overhead of denoting expressions/programs.

In it's bare form, it only simplifies away the core framework definitions (e.g., `Expr.denote`), but
we can also pass it dialect-specific definitions to unfold, as in:
`simp_peephole [foo, bar, baz]` -/
macro "simp_peephole" "[" ts: Lean.Parser.Tactic.simpLemma,* "]" : tactic =>
  `(tactic|
      (
      /- Then, unfold the definition of the denotation of a program -/
      simp (config := {failIfUnchanged := false}) only [
        Int.ofNat_eq_coe, Nat.cast_zero, DerivedCtxt.snoc, DerivedCtxt.ofCtxt,
        DerivedCtxt.ofCtxt_empty, Valuation.snoc_last,
        Var.zero_eq_last, Var.succ_eq_toSnoc,
        Ctxt.empty, Ctxt.empty_eq, Ctxt.snoc, Ctxt.Valuation.nil,
        Ctxt.Valuation.snoc_last, Ctxt.map,
        Ctxt.Valuation.snoc_eval, Ctxt.ofList, Ctxt.Valuation.snoc_toSnoc,
        HVector.map, HVector.getN, HVector.get, HVector.toSingle, HVector.toPair, HVector.toTuple,
        DialectDenote.denote, Expr.op_mk, Expr.args_mk,
        DialectMorphism.mapOp, DialectMorphism.mapTy, List.map, Ctxt.snoc, List.map,
        Function.comp, Valuation.ofPair, Valuation.ofHVector, Function.uncurry,
        List.length_singleton, Fin.zero_eta, List.map_eq_map, List.map_cons, List.map_nil,
        bind_assoc, pairBind,
        /- `castPureToEff` -/
        Com.letPure, Expr.denote_castPureToEff,
        /- Unfold denotation -/
        Com.denote_var, Com.denote_ret, Expr.denote_unfold, HVector.denote,
        /- Effect massaging -/
        EffectKind.toMonad_pure, EffectKind.toMonad_impure,
        EffectKind.liftEffect_rfl,
        Id.pure_eq, Id.bind_eq, id_eq,
        /-
        NOTE (Here Be Dragons 🐉): the parenthesis in `(HVector.denote_cons)` are significant!
        `HVector.denote` has a typeclass assumption `TyDenote (Dialect.Ty d)`, where `d : Dialect`.
        However, we tend to define `d` as an `abbrev`, so that our goal statement might have
        `HVector.denote` where the concrete instance is `instTyDenote : TyDenote Ty`,
          and `Ty` is the expression that `d` was defined with.

        We've observed `simp [HVector.denote]` not working in such situations.
          Even more surprising, `rw [HVector.denote]` *did* succeed in rewriting.
        According to Zulip (https://leanprover.zulipchat.com/#narrow/stream/270676-lean4/topic/simp.20.5BX.5D.20fails.2C.20rw.20.5BX.5D.20works/near/358861409):
        > simp [(X)] is a standard trick to fix simp [X] not working

        By default, it seems that `simp` will synthesize typeclass arguments of a lemma, and then
        use the *default* instance to determine whether a simp-lemma applies to the current goal.
        Writing `simp [(X)]`, on the other hand, is equivalent to writing `simp [@X _ _ _]`
          (for as many underscores as `X` takes arguments, implicit or explicit).
        The parentheses seems to enable `simp` to unify typeclass arguments as well, and thus the
          simp-lemma applies even for non-standard instances.

        One caveat: `simp [(X)]` only works if `X` is a lemma, *not* if `X` is a definition to be
        unfolded. Thus, we replace `HVector.denote` with its equation lemmas
          `(HVector.denote_cons)` and `(HVector.denote_nil)` -/
        (HVector.denote_cons), (HVector.denote_nil),
        $ts,*]
    ))

/--
`simp_peephole at ΓV` simplifies away the framework overhead of denoting expressions/programs,
that are evaluated with the valuation `ΓV`.

The actual simplification happens in the `simp_peephole` tactic defined above.
After simplifying, the goal state should only contain occurences of valuation `ΓV` directly applied
to some variable `v : Var Γ ty`.
The present tactic tries to eliminate the valuation completely,
by introducing a new universally quantified (Lean) variable to the goal for every
(object) variable `v`.
-/
macro "simp_peephole" "[" ts: Lean.Parser.Tactic.simpLemma,* "]" "at" Γv:ident : tactic =>
  `(tactic|(
      simp_peephole [$ts,*]
      -- `simp_peephole` might close trivial goals, so we use `only_goal` to ensure we only run
      -- more tactics when we still have goals to solve, to avoid 'no goals to be solved' errors.
      only_goal
        simp (config := {failIfUnchanged := false}) only [Ctxt.Var.toSnoc, Ctxt.Var.last]
        repeat (generalize_or_fail at $Γv)
        clear $Γv
  ))

/-- `simp_peephole` with no extra user defined theorems. -/
macro "simp_peephole" "at" Γv:ident : tactic => `(tactic| simp_peephole [] at $Γv)
macro "simp_peephole"               : tactic => `(tactic| simp_peephole [])

end SSA
