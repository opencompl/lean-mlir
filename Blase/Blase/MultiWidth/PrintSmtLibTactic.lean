import Mathlib.Data.Fintype.Defs
import Blase.MultiWidth.Defs
import Blase.MultiWidth.GoodFSM
import Blase.MultiWidth.Preprocessing
import Blase.KInduction.KInduction
import Blase.AutoStructs.FormulaToAuto
import Blase.ReflectMap
import Blase.MultiWidth.Tactic


namespace MultiWidth
namespace Tactic

open Lean Meta Elab Tactic

def printSmtLib (g : MVarId) : SolverM Unit := do
  let g ← revertPropHyps g
  let .some g ← g.withContext (Normalize.runPreprocessing g)
    | do
        debugLog m!"Preprocessing automatically closed goal."
  g.withContext do
    debugLog m!"goal after preprocessing: {indentD g}"

  g.withContext do 
    forallTelescope (← g.getType) fun _xs gTy => do
      debugLog m!"goal type after foralls: {indentD gTy}"
      let collect : CollectState := {}
      let (p, _collect) ← collectBVPredicateAux collect gTy
      debugLog m!"collected predicate: '{repr p}'"
      throwError (p.toSexpr |> format)

syntax (name := bvPrintSmtLib) "bv_multi_width_print_smt_lib" : tactic
@[tactic bvPrintSmtLib]
def evalBvPrintSmtLib : Tactic := fun
| `(tactic| bv_multi_width_print_smt_lib) => do
  let g ← getMainGoal
  g.withContext do
    let ctx : Context := {}
    SolverM.run (ctx := ctx) <| printSmtLib g
| _ => throwUnsupportedSyntax

end Tactic
end MultiWidth
