/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.TestLLVMOps
import SSA.Projects.InstCombine.LLVM.CLITests
import Cli

open Lean
open InstCombine.LLVM.Ty (bitvec)

-- Note that this application of 4 here doesn't really do anything, parameters not supported for now
@[reducible]
def tests : List ConcreteCliTest := llvmTests!

-- TODO: make poison parseable too
def runTest (test : ConcreteCliTest) (arg : String) : IO Bool := do
    let .some p := test.parseableInputs.parse? arg
      | IO.println s!"Could not parse argument {arg} for test {test.name} : {test.printSignature}";
        return false
    let res ← test.eval (p.map Option.some)
    -- Add the first match to help lean reduce the TyDenote instance
    match test.ty, res with
      | bitvec _, .some val => IO.println s!"result: {val}"
      | bitvec _, .none => IO.println s!"no result (undefined behavior)"
    return true

def listAllTests : IO Unit := do
  IO.println s!"{tests.map (fun t => t.name.toString)}"

def runMainCmd (args : Cli.Parsed) : IO UInt32 := do
  if args.hasFlag "list_tests" then do
    let _ ← listAllTests
    return 0
  match (args.flag? "test") with
    | none => do
      IO.println "Error: no test specified. Use `-t` to specify the test, or `-h` to show this command's help."
      return 1
    | some f =>
      let testName : String := f.as! String
      let test? := tests.find? (·.name.toString == testName)
      match test? with
      | none =>
        IO.println s!"Error: could not find test named {testName}. You can list all available tests with the `--list-tests` flag."
        return 1
      | some test =>
         if (args.hasFlag "signature") then
           IO.println s!"{testName} : {test.printSignature}"
           return 0
         let inputs? := (args.flag? "args" |>.map (Cli.Parsed.Flag.as! · String))
         match inputs? with
           | none =>
             IO.println s!"No arguments supplied for test {testName} : {test.printSignature}."
             return 1
           | some inputs =>
             match (← runTest test inputs) with
             | true => return 0
             | false => return 1

def mainCmd := `[Cli|
    mlirnatural VIA runMainCmd;
    "MLIR♮: Reference Semantics"
    FLAGS:
       s, signature;     "Print the signature of the test"
       t, test: String;  "Name of test"
       a, args: String;  "Test argument to be parsed by lean"
       l, list_tests;    "List all available tests"
    ]

def main (args : List String): IO UInt32 :=
  mainCmd.validate args
