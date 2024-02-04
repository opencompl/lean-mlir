import SSA.Projects.InstCombine.TestLLVMOps
import SSA.Projects.InstCombine.LLVM.CLITests
import Cli

open Lean

-- Note that this application of 4 here doesn't really do anything, parameters not supported for now
@[reducible]
def tests : List ConcreteCliTest := List.map (fun x => x 4) llvmTests!
--#reduce tests.map (fun t => t.name.toString)

def runTest (name : String) (arg : String) : IO Bool := do
  match tests.find? (·.name.toString == name) with
  | .some t => do
    let .some p := t.parseableInputs.parse? arg
      | IO.println s!"Could not parse argument {arg} for test {name}";
        return false
    IO.println s!"{← t.eval p}"
    return true
  | .none =>
    IO.println s!"Test {name} not found"; return false

def runMainCmd (args : Cli.Parsed) : IO UInt32 := do
  let test := args.positionalArg! "test"
  let testArg := args.positionalArg! "arg"
  match (← runTest test.value testArg.value) with
  | true => return 0
  | false => return 1

def mainCmd := `[Cli|
    mlirnatural VIA runMainCmd;
    "MLIR♮: Reference Semantics"
    ARGS:
      test: String; "Name of test"
      arg: String;  "Test argument to be parsed by lean"
    ]

def main (args : List String): IO UInt32 :=
  mainCmd.validate args
