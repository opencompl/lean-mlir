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
import Std.Data.Iterators
import Lean.Elab.Tactic.BVDecide.Frontend.BVDecide.SatAtBVLogical
import Lean.Elab.Tactic.BVDecide.Frontend.Normalize
import Lean.Elab.Tactic.BVDecide.Frontend.LRAT

open Lean Elab Meta
open MultiWidth
open ReflectVerif.BvDecide (DecideIfZerosOutput)

open Cli

namespace Blasewuzla

inductive SolverExitCode
| unknown
| sat
| unsat
| error (errStr : String := "")
deriving Repr, Inhabited, DecidableEq

def SolverExitCode.toUInt32 : SolverExitCode → UInt32
| .unknown => 0
| .sat => 10
| .unsat => 20
| .error _ => 1

def SolverExitCode.toString : SolverExitCode → String
| .unknown => "unknown"
| .sat => "sat"
| .unsat => "unsat"
| .error errStr => s!"error: {errStr}"

open Std Tactic Sat AIG BVDecide  Lean Elab Meta Std Sat AIG Tactic BVDecide Frontend in
def checkBVLogicalExprIsUnsat (e : BVLogicalExpr) : MetaM Bool := do
  let entry := e.bitblast
  let (entry, _map) := entry.relabelNat'
  let cnf := AIG.toCNF entry
  let cfg : BVDecideConfig := {}
  IO.FS.withTempFile fun _ lratFile => do
  let ctx ← (BVDecide.Frontend.TacticContext.new lratFile cfg).run' { declName? := `lrat }
  let res ← Lean.Elab.Tactic.BVDecide.Frontend.runExternal cnf ctx.solver ctx.lratPath ctx.config.trimProofs ctx.config.timeout ctx.config.binaryProofs
  match res with
  | .ok _cert => return true
  | .error _assignment => return false

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

structure Config where
  backend : String
  verbose : Bool
  parseOnly : Bool
  niter : Nat
  bound : Nat

structure Solver where
  name : String
  run : Config → ParseResult → MetaM SolverExitCode

unsafe def runMetaMAsIO (m : MetaM α) : IO α := do
  initSearchPath (← findSysroot)
  enableInitializersExecution
  let env ← importModules #[`Std.Tactic.BVDecide, `Init, `Std] {} 0 (loadExts := true)
  let coreContext : Core.Context := { fileName := "blasewuzla", fileMap := default }
  let coreState : Core.State := { env }
  let ctxMeta : Meta.Context := {}
  let sMeta : Meta.State := {}
  let (a, _coreState, _state) ← m.toIO coreContext coreState ctxMeta sMeta
  return a

unsafe def monoBMC : Solver where
  name := "monobmc"
  run (config : Config) (result : ParseResult) : MetaM SolverExitCode := do
    -- monobmc backend: translate to single-width and call bv_decide at a fixed width
    if config.verbose then
      IO.eprintln s!"Running {monoBMC.name} at width {config.bound}..."

    let (singleWidthTerm, success?) := result.predicate.toSingleWidthNondepTerm (.const config.bound)

     if ! success? then
      IO.eprintln s!"{monoBMC.name}: Unable to translate term to single-width.\ninput:\n{repr result.predicate}\noutput:\n{repr singleWidthTerm}"
      return .unknown
    else
      IO.eprintln s!"{monoBMC.name}: Successfully translated term to single-width.\ninput:\n{repr result.predicate}\noutput:\n{repr singleWidthTerm}"

    let (singleWidthNegated, success?) := singleWidthTerm.pnegate
    if ! success? then
      IO.eprintln s!"{monoBMC.name}: Unable to negate single-width term.\ninput:\n{repr singleWidthTerm}\nnegation failed."
      return .unknown

    let (qfbv, true) := singleWidthNegated.toBVLogicalExpr #[]
      | return .error s!"formula contains unsupported operation for QF_BV translation.\n{repr result.predicate}"

    if config.verbose then
      IO.eprintln s!"qfbv formula to be checked for UNSAT:\n{qfbv.toString}"

    if ← checkBVLogicalExprIsUnsat qfbv then
      return .unsat
    else
      return .sat

/--
Enumerate all tuples [0..bound] x [0..bound] x ... x [0..bound] (n times).
-/
def cartesianProductRange (bound : Nat) (n : Nat) : Array (Array Nat) := Id.run do
  match n with
  | 0 => #[#[]]
  | n + 1 =>
    let mut out := #[]
    let smaller := cartesianProductRange bound n
    for ws in smaller do
      for w in [0:bound] do
        out := out.push (ws.push w)
    out


def naiveBMC : Solver where
  name := "naivebmc"
  run (config : Config) (result : ParseResult) : MetaM SolverExitCode := do

    let (negatedPredicate, true) := result.predicate.pnegate
      | throwError "unable to negate predicate. {repr result.predicate}"
    -- naivebmc backend: translate to single-width and call bv_decide at a fixed width
    if config.verbose then
      IO.eprintln s!"Running naivebmc at width {config.bound}..."
    for widths in cartesianProductRange config.bound result.wcard do
      let (qfbv, success?) : Std.Tactic.BVDecide.BVLogicalExpr × Bool := negatedPredicate.toBVLogicalExpr widths

      if !success? then
        return .error s!"formula contains unsupported operation, unable to translate into QF_BV.\n{repr negatedPredicate}"

      if config.verbose then
        IO.eprintln s!"{qfbv.toString}"
      if ← checkBVLogicalExprIsUnsat qfbv then
        if config.verbose then
          IO.eprintln s!"⟨{widths.toList}⟩ ✓"
        continue
      else
        if config.verbose then
          IO.eprintln s!"⟨{widths.toList}⟩ ✗"
        return .sat
    return .unsat

def IC3 : Solver where
  name := "rIC3"
  run (config : Config) (result : ParseResult) : MetaM SolverExitCode := do
    let termFsm := mkTermFsmNondep result.wcard result.tcard result.bcard 0 0 result.pcard result.predicate
    let fsm := termFsm.toFsmZext

    if config.verbose then
      IO.eprintln s!"Running rIC3..."
    let aig := fsm.toAiger
    let res ← Valaig.External.checkSafety (Valaig.External.rIC3 (timeoutMs := none)) aig
    match res with
    | .error msg =>
        IO.eprintln s!"rIC3 error: {msg}"
        return .error
    | .ok .counterexample =>
      if !result.predicate.isAutomtaDecidable then
        IO.eprintln "rIC3: potential counterexample found, but formula contains non-automata-decidable operations (overapproximation). Countermodel reconstruction needed to validate."
        return .unknown
      if config.verbose then IO.eprintln "rIC3: counterexample found"
      return .sat
    | .ok .proof =>
      if config.verbose then IO.eprintln "rIC3: proof found"
      return .unsat

def kinduction : Solver where
  name := "k-induction"
  run (config : Config) (result : ParseResult) : MetaM SolverExitCode := do
    -- k-induction backend
    if config.verbose then
      IO.eprintln s!"FSM built. Running k-induction with max {config.niter} iterations..."

    let termFsm := mkTermFsmNondep result.wcard result.tcard result.bcard 0 0 result.pcard result.predicate
    let fsm := termFsm.toFsmZext

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
      fsm.decideIfZerosVerified config.niter |>.toIO coreContext coreState ctxMeta sMeta ctxTerm sTerm
    let tEnd ← IO.monoMsNow

    if config.verbose then
      IO.eprintln s!"Completed in {tEnd - tStart}ms"

    match out with
    | .provenByKIndCycleBreaking numIters _ _ =>
      if config.verbose then
        IO.eprintln s!"Proven by k-induction at iteration {numIters}"
      return .unsat
    | .safetyFailure iter =>
      if !result.predicate.isAutomtaDecidable then
        IO.eprintln s!"k-induction: potential counterexample at iteration {iter}, but formula contains non-automata-decidable operations (overapproximation). Countermodel reconstruction needed to validate."
        return .unknown
      if config.verbose then
        IO.eprintln s!"Counterexample found at iteration {iter}"
      return .sat
    | .exhaustedIterations n =>
      if config.verbose then
        IO.eprintln s!"Exhausted {n} iterations"
      return .unknown


def solverErrorUknown : Solver where
  name := "error_unknown"
  run (_config : Config) (_result : ParseResult) : MetaM SolverExitCode := do
    return .error "Uknown solver backend choice."


/-- List of all solvers we support. -/
unsafe def allSolvers : Std.HashMap String Solver :=
  let solvers := #[kinduction, IC3, monoBMC, naiveBMC]
  solvers.foldl (fun m s => m.insert s.name s) ∅

set_option compiler.extract_closed false in
unsafe def runBlasewuzla (p : Cli.Parsed) : IO UInt32 := do
  let inputPath : String := p.positionalArg! "input" |>.as! String
  let niter : Nat := p.flag! "niter" |>.as! Nat
  let bound : Nat := p.flag! "bound" |>.as! Nat
  let parseOnly : Bool := p.hasFlag "parseOnly"
  let verbose : Bool := p.hasFlag "verbose"
  let backend : String := p.flag! "backend" |>.as! String

  let config : Config := {
    verbose,
    backend,
    parseOnly,
    niter,
    bound
  }
  -- Read and parse the SMT2 file
  let contents ← IO.FS.readFile inputPath
  let result ← match Blasewuzla.parseSmt2Query contents with
    | .ok r => pure r
    | .error e => do
      IO.eprintln s!"Parse error: {e}"
      return SolverExitCode.toUInt32 .error

  if verbose then
    IO.eprintln s!"Parsed: wcard={result.wcard}, tcard={result.tcard}, bcard={result.bcard}, pcard={result.pcard}"
    IO.eprintln s!"Predicate: {repr result.predicate}"

  if parseOnly then
    IO.println s!"{repr result.predicate}"
    return 0

  let solver : Solver :=
    allSolvers.get? backend |>.getD solverErrorUknown
  let timeStart ← IO.monoMsNow
  let out ← runMetaMAsIO <| solver.run config result
  let timeEnd ← IO.monoMsNow

  IO.println s!"Time elapsed: {timeEnd - timeStart} ms"
  IO.println s!"Result: {out.toString}"
  return out.toUInt32

unsafe def blasewuzlaCmd : Cli.Cmd := `[Cli|
  blasewuzla VIA runBlasewuzla; ["0.1.0"]
  "Run Blase's multi-width bitvector SMT2 solver (k-induction or rIC3)."

  FLAGS:
    v, verbose;                "Print verbose output."
    parseOnly;                 "Only parse the file and print the parsed term."
    niter : Nat;               "Maximum number of k-induction iterations (kinduction backend only)."
    bound : Nat;               "Bound width for monobmc backend."
    backend : String;          "Backend solver: 'kinduction' (default), 'ric3', 'monobmc', or 'naivebmc'."

  ARGS:
    input : String;            "Path to the .smt2 file."

  EXTENSIONS:
    defaultValues! #[
      ("niter", "30"),
      ("bound", "8"),
      ("backend", kinduction.name)
    ]
]

end Blasewuzla

unsafe def main (args : List String) : IO UInt32 := do
  Blasewuzla.blasewuzlaCmd.validate args
