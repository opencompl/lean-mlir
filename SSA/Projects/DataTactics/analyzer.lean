import Lean
import Lean.Meta.Basic
import Batteries.Tactic.OpenPrivate
-- import SSA.Projects.DataTactics.theorems
-- import SSA.Projects.DataTactics.all_proof
import SSA.Experimental.Bits.Fast.Tactic
open Lean.Meta

open Lean Meta

open Lean Elab Command Meta
open Lean Meta Elab Tactic

open Lean Meta Elab Tactic

open Lean Elab Command Meta Tactic
-- Function to check if a theorem can be solved by `rfl`
def checkRfl (env : Environment) (declName : Name) : TermElabM Bool := do
  -- try
  match env.find? declName with
    | some const =>
      try
        let (_, _, type) ← forallMetaTelescope const.type
        let goal ← mkFreshExprMVar type
        let mvarId := goal.mvarId!
        let _ ← Tactic.run mvarId do
          evalTactic (← `(tactic| bv_automata)
          )
        let result ← instantiateMVars goal
        return !result.hasMVar
      catch _ =>
        return false
    | none      => throwError "unknown constant"

  -- let const ← getConstInfo declName
  -- return false
  -- withNewMCtxDepth do

  -- catch e =>
  --   logInfo (e.toMessageData)
  --   return false


-- Function to analyze all theorems in the environment
def analyzeTheorems : CommandElabM (Nat × Nat) := do
  -- let env ← getEnv
  -- let moduleName := `SSA.Projects.DataTactics.theorems
  let mut solved := 0
  let mut unsolved := 0
  let modules := [
    `SSA.Projects.InstCombine.tests.LLVM.gicmphmul_proof
  ]
  for moduleName in modules do
    let env ← importModules #[{module := moduleName}] {}
    let moduleIdx := Lean.Environment.getModuleIdx?  env moduleName

    for (declName, _) in env.constants do
      if Lean.Environment.getModuleIdxFor? env declName == moduleIdx  then
      logInfo declName
      if ← liftTermElabM  <| checkRfl env declName then
        solved := solved + 1
      else
        unsolved := unsolved + 1
  return (solved, unsolved)


-- Command to run the analysis
elab "#analyze_theorems" : command => do
  let (solved, unsolved) ← analyzeTheorems
  logInfo s!"Theorems solved by rfl: {solved}"
  logInfo s!"Theorems not solved by rfl: {unsolved}"

-- Import the theorems file and run the analysis

#analyze_theorems
