/-
Toplevel test runner for MLIRNatural.
Authors: Andres Goens, Siddharth Bhat
-/
import SSA.Core.WellTypedFramework
-- import SSA.Core.IR
-- import SSA.Projects.InstCombine
import Cli

/--
mapping of test names to tests. 
This allows us to test different IRs and their 
associated semantics.
-/
-- def Tests : HashMap String Nat := {} 

structure ExecConfig where
--   (dialect : Dialect)
--   (test : dialect.testType)
--   (params : List Nat)
--   (args : (test.codes params).inputType.toType)

def parseArgs (args : Cli.Parsed) : Except String ExecConfig := do 
  throw s!"unknown IR 'foo'"
-- fun args => do
--   let dialect ← match args.flag? "dialect" with
--       | none => Except.ok Inhabited.default
--       | some d => match Dialect.fromString (d.as! $ String) with
--         | some d => pure d
--         | none => throw s!"unknown dialect: {d}"
--   let test ← match args.positionalArg? "test" with
--       | none => throw "no test specified"
--       | some t => match dialect.getTest (t.as! $ String) with
--         | some t => pure t
--         | none => throw s!"unknown test: {t}"
--   let params ← match args.flag? "params" with
--       | none => pure []
--       | some p => pure (p.as! $ Array Nat).toList
--   match args.flag? "args" with
--      -- TODO: this is very clumsy to make sure things typecheck. 
--      -- Can we make it more generic?
--       | none => if h : (test.codes params).inputType = SSA.UserType.unit then 
--                   return {dialect := dialect, test := test, 
--                           args := (by simp [h]; exact PUnit.unit),
--                           params := params}
--                 else throw "Unsupported input type"    
--       | _ => throw "Unsupported input type"


def runMainCmd (args : Cli.Parsed) : IO UInt32 := do
  let cfg ← match parseArgs args with
    | Except.ok cfg => pure cfg
    | Except.error e => IO.println s!"Error: {e}"; return 1
  -- IO.println $ cfg.test.codes cfg.params |>.code cfg.args; return 0
  return 0

def mainCmd := `[Cli|
    mlirnat VIA runMainCmd;
    "MLIR♮: Reference Semantics"
    FLAGS:
      D, "dialect" : String;             "Dialect/Semantics to use (default: InstCombine)"
      a, "args" : String;                "Arguments to pass to the test"
      p, "params" : Array Nat;           "Parameters for the test"
    ARGS:
      test : String;      "Test to run"
    ]

def main (args : List String): IO UInt32 :=
  mainCmd.validate args