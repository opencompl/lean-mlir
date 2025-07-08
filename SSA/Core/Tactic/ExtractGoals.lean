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
import Batteries.Lean.Meta.Inaccessible

/-!
#  `extract_goals`: Format the current goals as a stand-alone example.

-/

syntax (name := extractGoal) "extract_goals" : tactic

open Lean Meta Elab Tactic in
elab_rules : tactic
  | `(tactic| extract_goals) => do
    let name ← mkAuxDeclName `extracted
    let msgs ← withoutModifyingEnv <| withoutModifyingState do
      let mut ix := 1
      let mut msgs := #[]
      for g in ← getGoals do
        let name := name ++ Name.mkSimple s!"_{ix}"
        ix := ix + 1
        let (g, _) ← g.renameInaccessibleFVars
        let (_, g) ← g.revert (clearAuxDeclsInsteadOfRevert := true) (← g.getDecl).lctx.getFVarIds
        let ty ← instantiateMVars (← g.getType)
        if ty.hasExprMVar then
          -- TODO: turn metavariables into new hypotheses?
          throwError "Extracted goal has metavariables: {ty}"
        let ty ← Term.levelMVarToParam ty
        let seenLevels := collectLevelParams {} ty
        let levels := (← Term.getLevelNames).filter
                        fun u => seenLevels.visitedLevel.contains (.param u)
        addAndCompile <| Declaration.axiomDecl
          { name := name
            levelParams := levels
            isUnsafe := false
            type := ty }
        let sig ← addMessageContext <| MessageData.signature name
        let cmd := if ← Meta.isProp ty then "theorem" else "def"
        msgs := msgs.push <| m!"{cmd} {sig} := sorry"
        logError "xx"
      pure msgs
    for msg in msgs do
      logInfo msg


/--
info: theorem _example.extracted_1._1 (P Q R : Prop) : P := sorry
---
info: theorem _example.extracted_1._2 (P Q R : Prop) : Q := sorry
---
info: theorem _example.extracted_1._3 (P Q R : Prop) : R := sorry
---
warning: declaration uses 'sorry'
-/
#guard_msgs in example (P Q R : Prop) : P ∧ Q ∧ R := by
    constructor <;> try constructor
    extract_goals
    all_goals sorry


