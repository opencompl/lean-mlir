import SSA.Core.MLIRSyntax.AST
import SSA.Core.MLIRSyntax.EDSL
import SSA.Experimental.ASTPrettyPrinter
import Lean
/- Parse  a raw file into `MLIR.AST.*` constructs. -/
open Lean

variable {ParseOutput : Type} [ToString ParseOutput]

abbrev ParseError := String
abbrev ParseFun : Type := Lean.Environment → String → EIO ParseError ParseOutput

-- We use unification with `isDefEq` to find the synthetic metavariables, and
-- then we synthesize and instantiate them
-- This lets us instantiate arguments like the `Nat` argument to `MLIR.AST.Region`.
-- For more info, see: https://leanprover.zulipchat.com/#narrow/stream/270676-lean4/topic/Calling.20unification.20from.20meta.20to.20remove.20metavariables
unsafe def elabIntoTermTactic {α : Type} (expectedType : Expr) (stx : Lean.Syntax) :
    Elab.Tactic.TacticM α := do
  let expr ← Lean.Elab.Tactic.elabTerm stx none
  let _ ← Meta.isDefEq (← Meta.inferType expr) expectedType
  Elab.Term.synthesizeSyntheticMVarsNoPostponing
  let expr ← instantiateMVars expr
  Meta.evalExpr α expectedType expr

namespace Lean.Elab.Tactic

@[inline] private def TacticM.runCore (x : TacticM α) (ctx : Context) (s : State) :
    TermElabM (α × State) :=
  x ctx |>.run s

@[inline] private def TacticM.runCore' (x : TacticM α) (ctx : Context) (s : State) : TermElabM α :=
  Prod.fst <$> x.runCore ctx s

end Lean.Elab.Tactic

unsafe def elabIntoTermElab {α : Type} (expectedType : Expr) (stx : Lean.Syntax) :
    Elab.Term.TermElabM α := do
  elabIntoTermTactic (α := α) expectedType stx  |>.runCore' { elaborator := `ParserHack} default

unsafe def elabIntoMeta {α : Type} (expectedType : Expr) (stx : Lean.Syntax) : MetaM α :=
  elabIntoTermElab (α := α) expectedType stx |>.run'

unsafe def elabIntoCore {α : Type} (expectedType : Expr) (stx : Lean.Syntax) : CoreM α :=
  elabIntoMeta (α := α) expectedType stx |>.run'

def printException : Except Exception α → IO String
  | Except.ok _ => throw <| IO.userError "printException called on Except.ok"
  | Except.error e => e.toMessageData.toString

unsafe def elabIntoEIO {α : Type} (env : Lean.Environment) (typeName : Lean.Expr)
    (stx : Lean.Syntax) : EIO ParseError α :=
  fun s =>
    let resE : EIO Exception α :=
        elabIntoCore (α := α) typeName stx |>.run'
        {fileName := "parserHack", fileMap := default} {env := env}
    match resE s with
    | .ok a s => .ok a s
    | .error exception s =>
      let errMsgIO : IO String := exception.toMessageData.toString
      match errMsgIO s with
      | .ok errMsg s => .error s!"failed elaboration {stx}. Error: {errMsg}" s
      | .error e s => .error (s!" Failed elaborating {stx}.\n" ++
        s!"Unable to pretty-print exception at 'elabIntoEIO':\n{e}.") s

def region0Expr := (Expr.app (Expr.const `MLIR.AST.Region []) (Expr.const `Nat.zero []))

def op0Expr := (Expr.app (Expr.const `MLIR.AST.Op []) (Expr.const `Nat.zero []))
/--
  Parse `Lean.Syntax` into `MLIR.AST.Region`.

  This runs the Lean frontend stack and adds it to the TCB.
  It should be safe (if we trust the lean parser) since we ensure that the types match: see
  https://leanprover-community.github.io/mathlib4_docs/Std/Util/TermUnsafe.html#Std.TermUnsafe.termUnsafe_
 -/
def elabRegion (env : Lean.Environment) (stx : Lean.Syntax) :
    EIO ParseError (MLIR.AST.Region 0) := do
  let reg ← unsafe elabIntoEIO (α := MLIR.AST.Region 0) env region0Expr stx
  return reg

/--
  Parse `Lean.Syntax` into `MLIR.AST.Op`.

  This runs the Lean frontend stack and adds it to the TCB.
  It should be safe (if we trust the lean parser) since we ensure that the types match: see
  https://leanprover-community.github.io/mathlib4_docs/Std/Util/TermUnsafe.html#Std.TermUnsafe.termUnsafe_
 -/
def elabOp (env : Lean.Environment) (stx : Lean.Syntax) : EIO ParseError (MLIR.AST.Op 0) :=
  unsafe elabIntoEIO (α := MLIR.AST.Op 0) env op0Expr stx

def mkParseFun (syntaxcat : Name)
    (ntparser : Syntax → EIO ParseError ParseOutput)
    (s : String) (env : Environment) : EIO ParseError ParseOutput := do
  match Parser.runParserCategory env syntaxcat s with
    | .error msg => throw msg
    | .ok syn => ntparser syn

private def mkNonTerminalParser (syntaxcat : Name)
    (ntparser : Syntax → EIO ParseError ParseOutput)
    (env : Environment) (s : String) : EIO ParseError ParseOutput :=
  let parseFun := mkParseFun syntaxcat ntparser
  parseFun s env

-- TODO: do we need this copy of the environment, or can I remove it from one of the two?
def regionParser : @ParseFun (MLIR.AST.Region 0) :=
  fun env : Lean.Environment => mkNonTerminalParser `mlir_region (elabRegion env) env

private def parseFile (env: Lean.Environment)
    (parser: @ParseFun ParseOutput)
    (filepath: System.FilePath) : IO (Option ParseOutput) := do
  let lines ← IO.FS.lines filepath
  let fileStr := "\n".intercalate lines.toList
  let parsed ← EIO.toIO' <| parser env fileStr
  match parsed with
  | .ok parseOutput => return parseOutput
  | .error msg => IO.println s!"Error parsing {filepath}:\n{msg}"; return none

private def isFile (p: System.FilePath) : IO Bool := do
  return (← p.metadata).type == IO.FS.FileType.file

def runParser (parser : @ParseFun ParseOutput) (fileName : String) : IO (Option ParseOutput) := do
  /- We expect our parser to run with `lake exec`, which sets `LEAN_PATH` to be a colon separated
    list of package paths.
    We parse the package paths and set the search path accordingly.
    For more, see `lake env help.` -/
  let packagePaths : List String :=
    match (← IO.getEnv "LEAN_PATH") with
    | .none => []
    | .some colonSeparatedPaths => colonSeparatedPaths.splitOn ":"
  if packagePaths.isEmpty then
    throw <| IO.userError ("Expected `LEAN_PATH` environment variable to be set. " ++
    " Are you running via `lake exec opt`?")
  initSearchPath (← Lean.findSysroot) packagePaths
  let modules : Array Import := #[⟨`SSA.Core.MLIRSyntax.EDSL, false, false⟩, ⟨`SSA.Experimental.ASTPrettyPrinter, false, false⟩]
  let env ← importModules (loadExts := true)  modules {}
  let filePath := System.mkFilePath [fileName]
  if !(← isFile filePath) then
    throw <| IO.userError s!"File {fileName} does not exist"
  parseFile env parser filePath

def parseRegionFromFile (fileName : String)
    (regionParseFun : MLIR.AST.Region 0 → Except ParseError α) : IO (Option α)  := do
  let ast ← runParser regionParser fileName
  match Option.map regionParseFun ast with
  | .some (.ok res) => return res
  | .some (.error msg) => throw <| IO.userError s!"Error parsing {fileName}:\n{msg}"; return none
  | .none => return none
