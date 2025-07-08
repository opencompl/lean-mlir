/-
Copyright (c) 2017 Simon Hudon. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.

Authors: Simon Hudon, Kyle Miller, Damiano Testa

Extracts multiple goals from a theorem.
Adapted from Mathlib's `ExtractGoals` module.
Adaptor: Siddharth Bhat
-/
import Mathlib.Init
import Lean.Elab.Tactic.ElabTerm
import Lean.Meta.Tactic.Cleanup
import Lean.PrettyPrinter
import Lean.Elab.Print
import Batteries.Lean.Meta.Inaccessible
import Lean.Meta.Eqns
import Lean.Util.CollectAxioms
import Lean.Elab.Command


/-!
We reuse implementations from Lean.Elab.Print
to correctly print theorem statements.
The key issue is that `#print` correcly obeys
`pp.analyze` and `pp.analyze.checkInstances`, while `#check` does not.
Thus, we reuse the `printDefLike` and `printAxiomLike`
functions from `Lean.Elab.Print` to print theorems.

Our goals states are complex enough, due to the presence of `HRefinement`,
that we need to use `pp.analyze` to print them correctly.
-/

namespace PrintPrivate
open Lean Meta Elab Command

private def throwUnknownId (id : Name) : MetaM Unit :=
  throwError "unknown identifier '{.ofConstName id}'"

private def levelParamsToMessageData (levelParams : List Name) : MessageData :=
  match levelParams with
  | []    => ""
  | u::us => Id.run do
    let mut m := m!".\{{u}"
    for u in us do
      m := m ++ ", " ++ toMessageData u
    return m ++ "}"

private def mkHeader (kind : String) (id : Name) (levelParams : List Name) (type : Expr) (safety : DefinitionSafety) (sig : Bool := true) : MetaM MessageData := do
  let mut attrs := #[]
  match (← getReducibilityStatus id) with
  | ReducibilityStatus.irreducible =>   attrs := attrs.push m!"irreducible"
  | ReducibilityStatus.reducible =>     attrs := attrs.push m!"reducible"
  | ReducibilityStatus.semireducible => pure ()

  if defeqAttr.hasTag (← getEnv) id then
    attrs := attrs.push m!"defeq"

  let mut m : MessageData := m!""
  unless attrs.isEmpty do
    m := m ++ "@[" ++ MessageData.joinSep attrs.toList ", " ++ "] "

  match safety with
  | DefinitionSafety.unsafe  => m := m ++ "unsafe "
  | DefinitionSafety.partial => m := m ++ "partial "
  | DefinitionSafety.safe    => pure ()

  if isProtected (← getEnv) id then
    m := m ++ "protected "

  let id' ← match privateToUserName? id with
    | some id' =>
      m := m ++ "private "
      pure id'
    | none =>
      pure id

  if sig then
    return m!"{m}{kind} {id'}{levelParamsToMessageData levelParams} : {type}"
  else
    return m!"{m}{kind}"

private def mkOmittedMsg : Option Expr → MessageData
  | none   => "<not imported>"
  | some e => e

private def mkAxiomLikeMessage (kind : String) (id : Name) (levelParams : List Name) (type : Expr) (safety : DefinitionSafety) : MetaM MessageData := do
  mkHeader kind id levelParams type safety

private def mkDefLikeMessage (sigOnly : Bool) (kind : String) (id : Name) (levelParams : List Name) (type : Expr) (value? : Option Expr) (safety := DefinitionSafety.safe) : MetaM MessageData := do
  if sigOnly then
    mkAxiomLikeMessage kind id levelParams type safety
  else
    let m ← mkHeader kind id levelParams type safety
    let m := m ++ " :=" ++ Format.line ++ mkOmittedMsg value?
    return m
end PrintPrivate

/-!
#  `extract_goals`: Format the current goals as a stand-alone example.

-/

syntax (name := extractGoal) "extract_goals" : tactic

open Lean Meta Elab Tactic

/-- set pp.analyze to true so that the extracted goals are
    printed with their type information, and therefore round-trippable. -/
private def setAnalyzeTrue (opts : Options) : Options :=
     (opts.setBool pp.analyze.name true)
     |>.setBool pp.analyze.checkInstances.name true

elab_rules : tactic
  | `(tactic| extract_goals) => do
    let name ← mkAuxDeclName `extracted
    let msgs ← withoutModifyingEnv <| withoutModifyingState <| withOptions setAnalyzeTrue <|  do
      let mut ix := 1
      let mut msgs := #[]
      for g in ← getGoals do
        let name := name ++ Name.mkSimple s!"_{ix}"
        ix := ix + 1
        let (g, _) ← g.renameInaccessibleFVars
        let (_, g) ← g.revert (clearAuxDeclsInsteadOfRevert := true) (← g.getDecl).lctx.getFVarIds
        let ty ← instantiateMVars (← g.getType)
        if ty.hasExprMVar then
          throwError "Extracted goal has metavariables: {ty}"
        let ty ← Term.levelMVarToParam ty
        let seenLevels := collectLevelParams {} ty
        let levels := (← Term.getLevelNames).filter
                        fun u => seenLevels.visitedLevel.contains (.param u)
        let val ← mkSorry ty (synthetic := false)
        let msg ← PrintPrivate.mkDefLikeMessage
          (sigOnly := false)
          "theorem"
          name
          levels
          ty
          val
        msgs := msgs.push <| msg
      pure msgs
    for msg in msgs do
      withOptions setAnalyzeTrue <| logInfo msg


/--
info: theorem _example.extracted_1._1 : ∀ (P Q R : Prop), P :=
sorry
---
info: theorem _example.extracted_1._2 : ∀ (P Q R : Prop), Q :=
sorry
---
info: theorem _example.extracted_1._3 : ∀ (P Q R : Prop), R :=
sorry
---
warning: declaration uses 'sorry'
---
warning: 'extract_goals' tactic does nothing
note: this linter can be disabled with `set_option linter.unusedTactic false`
-/
#guard_msgs in example (P Q R : Prop) : P ∧ Q ∧ R := by
    constructor <;> try constructor
    extract_goals
    all_goals sorry


/--
info: theorem _example.extracted_1._1 : ∀ (P Q : Nat), P + Q = Q + P :=
sorry
---
warning: declaration uses 'sorry'
---
warning: 'extract_goals' tactic does nothing
note: this linter can be disabled with `set_option linter.unusedTactic false`
-/
#guard_msgs in example (P Q : Nat) : P + Q = Q + P := by
    extract_goals
    all_goals sorry
