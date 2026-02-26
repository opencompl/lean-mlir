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

open Lean Elab Meta
open MultiWidth
open ReflectVerif.BvDecide (DecideIfZerosOutput)
open Cli

set_option compiler.extract_closed false in
unsafe def runBlasewuzla (p : Cli.Parsed) : IO UInt32 := do
  let inputPath : String := p.positionalArg! "input" |>.as! String
  let niter : Nat := p.flag! "niter" |>.as! Nat
  let parseOnly : Bool := p.hasFlag "parseOnly"
  let verbose : Bool := p.hasFlag "verbose"
  let backend : String := p.flag! "backend" |>.as! String

  -- Read and parse the SMT2 file
  let contents ← IO.FS.readFile inputPath
  let result ← match Blasewuzla.parseSmt2Query contents with
    | .ok r => pure r
    | .error e => do
      IO.eprintln s!"Parse error: {e}"
      return 1

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
    | .error err =>
      IO.eprintln s!"rIC3 error: {err}"
      return 1
    | .ok .counterexample =>
      if verbose then IO.eprintln "rIC3: counterexample found"
      IO.println "sat"
      return 0
    | .ok .proof =>
      if verbose then IO.eprintln "rIC3: proof found"
      IO.println "unsat"
      return 0
  else
    -- k-induction backend (default)
    if verbose then
      IO.eprintln s!"FSM built. Running k-induction with max {niter} iterations..."

    -- Set up Lean TermElabM environment for the SAT solver
    initSearchPath (← findSysroot)
    Lean.withImportModules #[{ module := `Lean.Elab.Tactic.BVDecide }, { module := `Std.Tactic.BVDecide }]
        (opts := {}) (trustLevel := 0) fun env => do
      let ctxCore : Core.Context := { fileName := "blasewuzla", fileMap := FileMap.ofString "" }
      let sCore : Core.State := { env }
      let ctxMeta : Meta.Context := {}
      let sMeta : Meta.State := {}
      let ctxTerm : Term.Context := { declName? := .some (Name.mkSimple "blasewuzla") }
      let sTerm : Term.State := {}

      let tStart ← IO.monoMsNow
      let ((out, _circuitStats), _coreState, _metaState, _termState) ←
        fsm.decideIfZerosVerified niter |>.toIO ctxCore sCore ctxMeta sMeta ctxTerm sTerm
      let tEnd ← IO.monoMsNow

      if verbose then
        IO.eprintln s!"Completed in {tEnd - tStart}ms"

      match out with
      | .provenByKIndCycleBreaking numIters _ _ =>
        if verbose then
          IO.eprintln s!"Proven by k-induction at iteration {numIters}"
        IO.println "unsat"
        return 0
      | .safetyFailure iter =>
        if verbose then
          IO.eprintln s!"Safety failure at iteration {iter}"
        IO.println "unknown"
        return 0
      | .exhaustedIterations n =>
        if verbose then
          IO.eprintln s!"Exhausted {n} iterations"
        IO.println "unknown"
        return 0

unsafe def blasewuzlaCmd : Cli.Cmd := `[Cli|
  blasewuzla VIA runBlasewuzla; ["0.1.0"]
  "Run Blase's multi-width bitvector SMT2 solver (k-induction or rIC3)."

  FLAGS:
    v, verbose;                "Print verbose output."
    parseOnly;                 "Only parse the file and print the parsed term."
    niter : Nat;               "Maximum number of k-induction iterations (kinduction backend only)."
    backend : String;          "Backend solver: 'kinduction' (default) or 'ric3'."

  ARGS:
    input : String;            "Path to the .smt2 file."

  EXTENSIONS:
    defaultValues! #[
      ("niter", "30"),
      ("backend", "kinduction")
    ]
]

unsafe def main (args : List String) : IO UInt32 := do
  blasewuzlaCmd.validate args
