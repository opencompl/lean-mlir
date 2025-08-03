import Lean

open Lean Elab Tactic
open Meta.Tactic.TryThis

elab "suffices?" : tactic => do
  let target ← getMainTarget
  let target : Term ← PrettyPrinter.delab target

  let suggestion ← `(tactic|
    suffices $target
    by
      exact $(mkIdent `this)
  )
  addSuggestion (← getRef) {
    suggestion := .tsyntax suggestion
  }
