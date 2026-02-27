/-
Blasewuzla CLI: Parametric bitvector SMT2 solver using k-induction or rIC3.
Authors: Siddharth Bhat
-/
import Blasewuzla
import Blase.MultiWidth.Defs
import Blase.MultiWidth.GoodFSM
import Blase.KInduction.KInduction
import Blase.Fast.Aiger
import Cli
import Lean
import Std

open Lean Elab Meta
open MultiWidth
open ReflectVerif.BvDecide (DecideIfZerosOutput)
open Cli

namespace Blasewuzla

theorem foo :   ∀ (w0 x0 x1 : BitVec 8),
    Eq (instHAndOfAndOp.hAnd (instHAdd.hAdd x0 x1) w0) (instHAndOfAndOp.hAnd (instHAdd.hAdd x1 x0) w0) := by
  bv_decide

-- Exit codes follow the CaDiCaL / HWMCC convention.
def EXIT_UNKNOWN : UInt32 := 0
def EXIT_SAT     : UInt32 := 10
def EXIT_UNSAT   : UInt32 := 20
def EXIT_ERROR   : UInt32 := 1

open Lean Elab Meta
def getSimpData (simpsetName : Name) : MetaM (SimpTheorems × Simprocs) := do
  let some ext ← (getSimpExtension? simpsetName)
    | throwError m!"'{simpsetName}' simp attribute not found!"
  let theorems ← ext.getTheorems
  let some ext ← (Simp.getSimprocExtension? simpsetName)
    | throwError m!"'{simpsetName}' simp attribute not found!"
  let simprocs ← ext.getSimprocs
  return (theorems, simprocs)

open Lean Elab Meta
def runMonoBMCPreprocessing (g : MVarId) : MetaM (Option MVarId) := do
    let mut theorems : Array SimpTheorems := #[]
    let mut simprocs : Array Simprocs := #[]

    for name in [`seval, `bv_normalize] do
      let res ← getSimpData name
      IO.println s!"lemmas: {res.1.lemmaNames.toList.map Origin.key}"
      IO.println s!"simprocs: {res.2.simprocNames.toList}"
      theorems := theorems.push res.1
      simprocs := simprocs.push res.2
    IO.println s!"#theorems: {theorems.size}"
    IO.println s!"#simprocs: {simprocs.size}"

    let config : Simp.Config := { contextual := true }
    let config := { config with failIfUnchanged := false }
    let ctx ← Simp.mkContext (config := config)
      (simpTheorems := theorems)
      (congrTheorems := ← Meta.getSimpCongrTheorems)
    match ← simpTargetStar g ctx (simprocs := simprocs) /- (fvarIdsToSimp := fvars) -/ with
    | (.closed, _stats) => return none
    | (.noChange , _stats) => return some g
    | (.modified gnew , _stats) => return some gnew

/--
Introduce only forall binders and preserve names.
-/
def _root_.Lean.MVarId.introsP (mvarId : MVarId) : MetaM (Array FVarId × MVarId) := do
  let type ← mvarId.getType
  let type ← instantiateMVars type
  let n := getIntrosSize type
  if n == 0 then
    return (#[], mvarId)
  else
    mvarId.introNP n

set_option pp.explicit true in
theorem bar
  (w0 : BitVec 8)
  (x0 : BitVec 8)
  (x1 : BitVec 8)
  (a : Not (Eq (instHAndOfAndOp.hAnd (instHAdd.hAdd x0 x1) w0) (instHAndOfAndOp.hAnd (instHAdd.hAdd x1 x0) w0))) : False :=  by
  bv_decide

-- TODO: rename to checkUnsatAux
open Lean Elab Meta Std Sat AIG Tactic BVDecide Frontend in
def proveGoalByBvDecide (gType : Expr) : MetaM Bool := do
  let mut g := (← mkFreshExprMVar (type? := gType)).mvarId!
  let (_, g') ← g.introsP
  g := g'
  let some g' ← g.falseOrByContra | return true
  g := g'
  g ← g.instantiateGoalMVars
  -- let some g' ← g'.falseOrByContra | return true
  g.withContext do
    for hyp in ← getLCtx do
      IO.println <| ← MessageData.toString <| m!"hyp: {← ppExpr hyp.toExpr} : {hyp.type}"
    let cfg : BVDecideConfig := {}
    IO.FS.withTempFile fun _ lratFile => do
      let cfg ← (BVDecide.Frontend.TacticContext.new lratFile cfg).run' { declName? := `lrat }
      let res ← Tactic.BVDecide.Frontend.bvDecide g cfg
      return res.lratCert.isSome
  -- let .some gnew ← g.withContext do g.byContra?
  --   | throwError "Was unable to convert goal to 'False'."
  -- gnew.withContext do
  --   IO.println (← MessageData.toString m!"Proving {gnew} : {← ppExpr (← gnew.getType'')} by bv_decide...")
  --   let cfg : BVDecideConfig := {}
  --   IO.FS.withTempFile fun _ lratFile => do
  --     let cfg ← (BVDecide.Frontend.TacticContext.new lratFile cfg).run' { declName? := `lrat }
  --     Tactic.BVDecide.Frontend.bvDecide gnew cfg

set_option compiler.extract_closed false in
unsafe def runBlasewuzla (p : Cli.Parsed) : IO UInt32 := do
  let inputPath : String := p.positionalArg! "input" |>.as! String
  let niter : Nat := p.flag! "niter" |>.as! Nat
  let bound : Nat := p.flag! "bound" |>.as! Nat
  let parseOnly : Bool := p.hasFlag "parseOnly"
  let verbose : Bool := p.hasFlag "verbose"
  let backend : String := p.flag! "backend" |>.as! String

  IO.eprintln "DEBUG: entered runBlasewuzla"
  -- Read and parse the SMT2 file
  let contents ← IO.FS.readFile inputPath
  let result ← match Blasewuzla.parseSmt2Query contents with
    | .ok r => pure r
    | .error e => do
      IO.eprintln s!"Parse error: {e}"
      return EXIT_ERROR

  if verbose then
    IO.eprintln s!"Parsed: wcard={result.wcard}, tcard={result.tcard}, bcard={result.bcard}, pcard={result.pcard}"
    IO.eprintln s!"Predicate: {repr result.predicate}"

  if parseOnly then
    IO.println s!"{repr result.predicate}"
    return 0

  -- Build the FSM
  let termFsm := mkTermFsmNondep result.wcard result.tcard result.bcard 0 0 result.pcard result.predicate
  let fsm := termFsm.toFsmZext

  if backend == "ric3" then
    -- rIC3 backend: convert FSM to AIGER and call the external rIC3 solver
    if verbose then
      IO.eprintln s!"Running rIC3..."
    let aig := fsm.toAiger
    let res ← Valaig.External.checkSafety (Valaig.External.rIC3 (timeoutMs := none)) aig
    match res with
    | .error (.timeout _ _) =>
      if verbose then IO.eprintln "rIC3: timed out"
      IO.println "unknown"
      return EXIT_UNKNOWN
    | .error (.external msg) =>
      -- rIC3 (and other HWMCC tools) exit with 0 to signal "unknown/indeterminate"
      if msg.contains "exit code 0" then
        if verbose then IO.eprintln "rIC3: unknown result"
        IO.println "unknown"
        return EXIT_UNKNOWN
      else
        IO.eprintln s!"rIC3 error: {msg}"
        return EXIT_ERROR
    | .ok .counterexample =>
      if verbose then IO.eprintln "rIC3: counterexample found"
      IO.println "sat"
      return EXIT_SAT
    | .ok .proof =>
      if verbose then IO.eprintln "rIC3: proof found"
      IO.println "unsat"
      return EXIT_UNSAT
  else if backend == "kinduction" then
    -- k-induction backend
    if verbose then
      IO.eprintln s!"FSM built. Running k-induction with max {niter} iterations..."

    -- Set up Lean TermElabM environment for the SAT solver
    initSearchPath (← findSysroot)
    let env ← importModules #[`Std.Tactic.BVDecide, `Init] {} 0 (loadExts := true)
    let coreContext : Core.Context := { fileName := "blasewuzla", fileMap := FileMap.ofString "" }
    let coreState : Core.State := { env }
    let ctxMeta : Meta.Context := {}
    let sMeta : Meta.State := {}
    let ctxTerm : Term.Context := { declName? := .some (Name.mkSimple "blasewuzla") }
    let sTerm : Term.State := {}

    let tStart ← IO.monoMsNow
    let ((out, _circuitStats), _coreState, _metaState, _termState) ←
      fsm.decideIfZerosVerified niter |>.toIO coreContext coreState ctxMeta sMeta ctxTerm sTerm
    let tEnd ← IO.monoMsNow

    if verbose then
      IO.eprintln s!"Completed in {tEnd - tStart}ms"

    match out with
    | .provenByKIndCycleBreaking numIters _ _ =>
      if verbose then
        IO.eprintln s!"Proven by k-induction at iteration {numIters}"
      IO.println "unsat"
      return EXIT_UNSAT
    | .safetyFailure iter =>
      if verbose then
        IO.eprintln s!"Counterexample found at iteration {iter}"
      IO.println "sat"
      return EXIT_SAT
    | .exhaustedIterations n =>
      if verbose then
        IO.eprintln s!"Exhausted {n} iterations"
      IO.println "unknown"
      return EXIT_UNKNOWN
  else if backend == "mono_bmc" then
    -- mono_bmc backend: translate to single-width and call bv_decide at a fixed width
    if verbose then
      IO.eprintln s!"Running mono_bmc at width {bound}..."
    let singleWidthTerm := result.predicate.toSingleWidthProp result.wcard result.tcard
    if !singleWidthTerm.isTranslated then
      IO.eprintln "mono_bmc: formula contains unsupported operations"
      return EXIT_UNKNOWN
    IO.eprintln "DEBUG: about to call withImportModules for mono_bmc"
    initSearchPath (← findSysroot)
    enableInitializersExecution
    let env ← importModules #[`Std.Tactic.BVDecide, `Init] {} 0 (loadExts := true)
    let coreContext : Core.Context := { fileName := "blasewuzla", fileMap := default }
    let coreState : Core.State := { env }
    let ctxMeta : Meta.Context := {}
    let sMeta : Meta.State := {}
    let ((proved, _), _,) ← (show MetaM _ from do
      let goalExpr ← singleWidthTerm.toQFBVExpr bound
      IO.println f!"goal: {← ppExpr goalExpr}"
      let solved : Bool ← try do
        let result ← proveGoalByBvDecide goalExpr
        pure result
      catch e =>
        IO.eprintln s!"DEBUG: bv_decide runtime error: {← e.toMessageData.toString}"
        pure false
      pure (solved, ())
    ).toIO coreContext coreState ctxMeta sMeta
    if proved then
      IO.println "unsat"
      return EXIT_UNSAT
    else
      IO.println "unknown"
      return EXIT_UNKNOWN
  else
    IO.eprintln s!"Error: unknown backend '{backend}'. Valid backends: 'kinduction', 'ric3', 'mono_bmc'."
    return EXIT_ERROR

unsafe def blasewuzlaCmd : Cli.Cmd := `[Cli|
  blasewuzla VIA runBlasewuzla; ["0.1.0"]
  "Run Blase's multi-width bitvector SMT2 solver (k-induction or rIC3)."

  FLAGS:
    v, verbose;                "Print verbose output."
    parseOnly;                 "Only parse the file and print the parsed term."
    niter : Nat;               "Maximum number of k-induction iterations (kinduction backend only)."
    bound : Nat;               "Bound width for mono_bmc backend."
    backend : String;          "Backend solver: 'kinduction' (default), 'ric3', or 'mono_bmc'."

  ARGS:
    input : String;            "Path to the .smt2 file."

  EXTENSIONS:
    defaultValues! #[
      ("niter", "30"),
      ("bound", "8"),
      ("backend", "kinduction")
    ]
]

end Blasewuzla

unsafe def main (args : List String) : IO UInt32 := do
  Blasewuzla.blasewuzlaCmd.validate args
