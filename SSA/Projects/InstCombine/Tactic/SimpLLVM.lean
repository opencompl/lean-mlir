/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework.Trace
import SSA.Projects.InstCombine.ForLean
import SSA.Projects.InstCombine.LLVM.EDSL

open Lean Meta
open Lean.Elab.Tactic

/-! ## `elim_poison_bind`-/

open PoisonOr in
/-- Specialized theorem for use in `elim_poison_bind`.
By specializing it to exactly the shape of goal we need, we both reduce some
boilerplate in its application, and potentially make the proof slightly faster
to check (as the kernel won't need to reduce anything).
-/
theorem LLVM.IntW.bind_isRefinedBy_of {v w : Nat}
    (x : PoisonOr (BitVec v)) (f : BitVec v → PoisonOr (BitVec w))
    (rhs : PoisonOr (BitVec w)) :
    (∀ x', x = value x' → f x' ⊑ rhs) → bind x f ⊑ rhs := by
  cases x <;> simp

open PoisonOr in
theorem LLVM.IntW.bind_isRefinedBy_iff {v w : Nat}
    (x : PoisonOr (BitVec v)) (f : BitVec v → PoisonOr (BitVec w))
    (rhs : PoisonOr (BitVec w)) :
    bind x f ⊑ rhs ↔ (∀ x', x = value x' → f x' ⊑ rhs) := by
  cases x <;> simp

/-!
NOTE:

The strategy for `elimBindIsRefinedBy` works, but sadly it only works when the
refinement is at the top-level of the goal. This is true for *most* goals, except
for those where `select` is involved. For those, we can get an `if` where neither
branch is a trivial poison, and thus which cannot be trivially eliminated.
The only solution in such a case is to rely on `ite_isRefinedBy_iff` to break
up the `if c then x? else y? ⊑ z?` into two separate obligations
  `c → x? ⊑ z?` and `c → y? ⊑ z?`.
We could keep these obligations into a single goal, as `_ ∧ _`, but then there
is no obvious way to keep applyin `elimBindIsRefinedBy`. We'd have to rephrase
this transformation in a way that can apply to sub-expressions, too, e.g., by
turning it into a simproc.

Alternativaly, we can admit that this rewrite is really just `split`ting the goal
and abandon the no-subgoals maxim. At least, we could use subgoals internally,
but collect them in a list, and at the end replace all goals with a single
`_ ∧ _ ∧ ...` conjunction of all subgoals.


-/

/--
Repeatedly (try to) apply `bind_isRefinedBy_of`, such that at the end there
are no more `bind`s to the left of the `⊑`.

Returns an array of all fvars that were introduced into the local context of the
main goal in the process. Note that not all those fvar ids are still valid, as
some may have been eliminated in the process as well!
-/
partial def elimBindIsRefinedBy (introed : Array FVarId) : TacticM (Array FVarId) := do
  withMainContext do
    let m := mkFreshExprMVar none
    let x ← m
    let oldGoal ← getMainGoal
    let newGoals ←
      try
        oldGoal.apply <|
          mkApp5 (mkConst ``LLVM.IntW.bind_isRefinedBy_of) (← m) (← m) x (← m) (← m)
      catch e =>
        trace[LeanMLIR.Elab] e.toMessageData
        return introed

    let x := (← instantiateMVars x).consumeMData
    if !x.isFVar then
      trace[LeanMLIR.Elab] "Expected an fvar, but found: {x}. Aborting..."
      oldGoal.eraseAssignment -- undo the application
      return introed
    let [ goal ] := newGoals
      | throwError "Expected exactly one subgoal, but found: {newGoals}"

    let (x, goal) ← goal.intro (← getUnusedUserName `x)
    replaceMainGoal [goal]
    let introed := introed.push x
    evalTactic <|<- `(tactic| (
      intro h; subst h; -- Eliminate the old variable
      simp -failIfUnchanged -implicitDefEqProofs +contextual only [
        simp_llvm, simp_llvm_case_bash, *]
      -- ^^ simplify
    ))
    match ← getUnsolvedGoals with
    | [] => return introed
    | goal :: _ =>
      let (newIntroed, goal) ← goal.intros
      replaceMainGoal [goal]
      elimBindIsRefinedBy <| introed ++ newIntroed

/--
`simp_alive_case_bash` repeatedly tries to apply `LLVM.IntW.bind_isRefinedBy_if`,
to show that a `PoisonOr`-typed variable *must* be a value (rather than poison).

Whenever the application succeeds, we introduce the new `BitVec` variable using
the same (accessible) name as the `PoisonOr` variable it replaces.
-/
elab "simp_alive_case_bash" : tactic => do
  let (introed, goal) ← (← getMainGoal).intros
  replaceMainGoal [goal]

  let introed ← elimBindIsRefinedBy introed

  if !(← getUnsolvedGoals).isEmpty then
    -- Now revert all introed variables which haven't been eliminated
    let goal ← getMainGoal
    let lctx ← goal.withContext getLCtx
    let introed := introed.filter lctx.contains
    let ⟨_, goal⟩ ← goal.revert introed
    replaceMainGoal [goal]

/-! ## Case Bashing-/

attribute [simp_llvm_case_bash]
  bind_assoc forall_const Nat.cast_one
  PoisonOr.isRefinedBy_self PoisonOr.value_isRefinedBy_value PoisonOr.poison_isRefinedBy
  PoisonOr.poison_bind PoisonOr.bind_poison PoisonOr.value_bind PoisonOr.pure_def

attribute [simp_llvm_split]
  PoisonOr.isRefinedBy_self PoisonOr.value_isRefinedBy_value PoisonOr.poison_isRefinedBy
  PoisonOr.value_bind PoisonOr.poison_bind PoisonOr.bind_poison PoisonOr.pure_def
  PoisonOr.value_inj
  if_if_eq_if_and if_if_eq_if_or
/- `reduceOfInt` and `Nat.cast_one` are somewhat questionable additions to this simp-set.
   They are not needed for the case-bashing to succeed, but they are simp-lemmas that were
   previously being applied in `AliveAutoGenerated`, where they closed a few trivial goals,
   so they've been preserved to not change this existing behaviour of `simp_alive_case_bash` -/

attribute [simp_llvm_option]
  PoisonOr.value_bind PoisonOr.value_isRefinedBy_iff PoisonOr.isRefinedBy_poison_iff
  PoisonOr.value_ne_poison PoisonOr.poison_ne_value

/-- `ensure_only_goal` succeeds, doing nothing, when there is exactly *one* goal.
If there are multiple goals, `ensure_only_goal` fails -/
elab "ensure_only_goal" : tactic =>
  Lean.Elab.Tactic.withMainContext do
    match (← Lean.Elab.Tactic.getGoals) with
    | [_g] => pure ()
    | [] => throwError "expected exactly one goal, found no goals."
    | gs@(_ :: _ :: _) =>
      throwError m!"expected exactly one goal, found multiple goals: '{gs}'."

/--
`simp_alive_case_bash` transforms a goal of the form
  `∀ (x₁ : PoisonOr (BitVec _)) ... (xₙ : PoisonOr (BitVec _)), ...`
into a goal about just `BitVec`s, by doing a case distinction on each `PoisonOr`.

Then, we `simp`lify each goal, following the assumption that the `poison` cases
should generally be trivial, hopefully leaving us with just a single goal:
the one where each option is a `value`. -/
syntax "simp_alive_case_bash'" : tactic
macro_rules
  | `(tactic| simp_alive_case_bash') => `(tactic|
    first
    | fail_if_success (intro (v : PoisonOr (_)))
      -- If there is no variable to introduce, `intro` fails, so the first branch succeeds,
      -- but does nothing. This is similar to `try`, except `first ...` does not swallow any errors
      -- that occur in the later tactics
    | intro (v : PoisonOr (_))  -- Introduce the variable,
      cases' v with x           -- Do the case distinction
      <;> simp (config:={failIfUnchanged := false}) -implicitDefEqProofs only [simp_llvm_case_bash]
      --  ^^^^^^^^^^^^^^^^^^^^^^^^ Simplify, in the hopes that the `poison` case is trivially closed
      <;> simp_alive_case_bash' -- Recurse, to case bash the next variable (if it exists)
      <;> (try revert x)        -- Finally, revert the variable we got in the `value` case, so that
                                --   we are left with a universally quantified goal of the form:
                                --   `∀ (x₁ : BitVec _) ... (xₙ : BitVec _), ...`
    )

/-- Unfold into the `undef' statements and eliminates as much as possible. -/
macro "simp_alive_undef" : tactic =>
  `(tactic|
      (
        simp (config := {failIfUnchanged := false}) only [
            simp_llvm_option,
            bind_assoc,
            Bool.false_eq_true, false_and, reduceIte,
            (BitVec.ofInt_ofNat)
          ]
      )
  )

attribute [simp_llvm]
  pure_bind
  BitVec.ofInt_neg_one

/- Simplify away the `InstCombine` specific semantics. -/
macro "simp_alive_ops" : tactic =>
  `(tactic|(
      simp (config := {failIfUnchanged := false}) only [
          simp_llvm,
          (BitVec.ofInt_ofNat)
        ]
    ))

attribute [simp_llvm]
  -- Poison lemmas
  PoisonOr.not_value_isRefinedBy_poison
  PoisonOr.value_bind
  -- Poison ite lemmas
  PoisonOr.ite_value_value
  PoisonOr.bind_if_then_poison_eq_ite_bind
  PoisonOr.bind_if_else_poison_eq_ite_bind
  PoisonOr.if_then_poison_isRefinedBy_iff
  PoisonOr.if_else_poison_isRefinedBy_iff
  PoisonOr.value_isRefinedBy_if_then_poison_iff
  PoisonOr.value_isRefinedBy_if_else_poison_iff
  -- Prop
  not_false_eq_true not_true_eq_false ne_eq
  true_and and_true false_and and_false
  true_or or_true false_or or_false
  imp_false implies_true
  or_self and_self
  not_or not_and
  -- Bool
  Bool.or_eq_true Bool.and_eq_true
  beq_iff_eq bne_iff_ne
  -- Other general simp lemmas
  reduceIte

attribute [simp_llvm_split(low)]
  PoisonOr.ite_isRefinedBy_iff
  PoisonOr.isRefinedBy_ite_iff

macro "simp_alive_split" : tactic => `(tactic|(
  all_goals
    try intros
    simp -failIfUnchanged -implicitDefEqProofs +contextual only [
      simp_llvm_split, simp_llvm
    ]
    try intros -- introduce any new hypotheses that may have been added
  ))
