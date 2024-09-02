import Lean
import Lean.Meta.Basic
import Batteries.Tactic.OpenPrivate
import SSA.Experimental.Bits.Fast.Tactic

open Lean Elab Command Meta Tactic

-- Function to check if a theorem can be solved by `bv_automata`
def checkAutomata (env : Environment) (declName : Name) : TermElabM Bool := do
  match env.find? declName with
    | some const =>
      try
        let type := const.type
        let goal ← mkFreshExprMVar type
        let mvarId := goal.mvarId!
        let (_, mvarId) ← mvarId.intros
        let _marvids ← Term.withDeclName `declName <| Tactic.run mvarId (evalTactic (← `(tactic| bv_automata)))
        let result ← instantiateMVars goal
        return !result.hasMVar
      catch e =>
        logError e.toMessageData
        return false
    | none => throwError "unknown constant"

-- Function to analyze all theorems in the environment
def analyzeTheorems : CommandElabM (Nat × Nat) := do
  let mut solved := 0
  let mut unsolved := 0
  let modules := [
    `SSA.Projects.InstCombine.tests.LLVM.gdemorgan_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gicmphmul_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsdivhexacthbyhpowerhofhtwo_proof,
    `SSA.Projects.InstCombine.tests.LLVM.grem_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gcanonicalizehlshrhshlhtohmasking_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gshifthadd_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gaddnegneg_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gdistribute_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gmul_fold_proof,
    `SSA.Projects.InstCombine.tests.LLVM.ghoisthnegationhouthofhbiashcalculationhwithhconstant_proof,
    `SSA.Projects.InstCombine.tests.LLVM.g2004h02h23hShiftShiftOverflow_proof,
    `SSA.Projects.InstCombine.tests.LLVM.g2008h07h09hSubAndError_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gaddsubhconstanthfolding_proof,
    `SSA.Projects.InstCombine.tests.LLVM.ghoisthxorhbyhconstanthfromhxorhbyhvalue_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsignext_proof,
    `SSA.Projects.InstCombine.tests.LLVM.g2008h07h11hRemAnd_proof,
  ]
  for moduleName in modules do
    let env ← importModules #[{module := moduleName}] {}
    let moduleIdx := Lean.Environment.getModuleIdx? env moduleName
    for (declName, _) in env.constants do
      if Lean.Environment.getModuleIdxFor? env declName == moduleIdx  then
      if ← liftTermElabM  <| checkAutomata env declName then
        solved := solved + 1
      else
        unsolved := unsolved + 1
  return (solved, unsolved)


-- Command to run the analysis
elab "#analyze_theorems" : command => do
  let (solved, unsolved) ← analyzeTheorems
  logInfo s!"Theorems solved by bv_automata: {solved}"
  logInfo s!"Theorems not solved by bv_automata: {unsolved}"

--  run the analysis
#analyze_theorems
