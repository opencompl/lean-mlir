import SSA.Core.WellTypedFramework
import SSA.Projects.InstCombine.Tests
import Cli

open Lean


/-- Parse a triple -/
instance [A : Cli.ParseableType α] [B : Cli.ParseableType β] [C : Cli.ParseableType γ] :
  Cli.ParseableType (α × β × γ) where
    name :=  s!"({A.name} × {B.name} × {C.name})"
    parse? str := do
      let str := str.trim.splitOn ","
      match str with 
      | [a, b, c] => do
        let a ← A.parse? a.trim
        let b ← B.parse? b.trim
        let c ← C.parse? c.trim
        return (a, b, c)
      | _ => .none


/-- test to be run. -/
structure Test where
  name : String
  params : Type
  paramsParseable : Cli.ParseableType params
  testFn : params → IO Bool

def Test.ofFn (name : String) ⦃params : Type⦄ [Cli.ParseableType params]
  (testFn : params → IO Bool) : Test where
  name := name
  params := _
  paramsParseable := inferInstance
  testFn := testFn 


def tests : List Test := [ 
  Test.ofFn "instcombine-test1" InstCombine.test1
]

def runTest (name : String) (arg : String) : IO Bool := do
  match tests.find? (·.name == name) with 
  | .some t => do 
    let .some p := t.paramsParseable.parse? arg
      | IO.println s!"Could not parse argument {arg} for test {name}";
        return False
    t.testFn p
  | .none => 
    IO.println s!"Test {name} not found"; return false

def runMainCmd (args : Cli.Parsed) : IO UInt32 := do
  let testName := args.positionalArg! "testName"
  let testArg := args.positionalArg! "arg"
  match (← runTest testName.value testArg.value) with 
  | true => return 0
  | false => return 1

def mainCmd := `[Cli|
    mlirnat VIA runMainCmd;
    "MLIR♮: Reference Semantics"
    ARGS:
      testName: String; "Name of test"
      arg: String;      "Test argument to be parsed by lean"
    ]

def main (args : List String): IO UInt32 :=
  mainCmd.validate args