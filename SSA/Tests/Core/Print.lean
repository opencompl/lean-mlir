import SSA.Core
import Qq

/-!
# Printing with Multiple return values

This file has tests for printing expressions with multiple (or no) return
values.
-/
namespace LeanMLIR.Tests

/-!
## Setup: Test Dialect
To begin, we need to define a dialect to use in testing
-/

inductive Ty
  | int
  /-- a pair of ints -/
  | int2
  deriving DecidableEq, Lean.ToExpr

inductive Op
  | noop
  | mkPair
  | unPair
  deriving Lean.ToExpr

def TestDialect : Dialect where
  Ty := Ty
  Op := Op

instance : TyDenote TestDialect.Ty where toType
  | .int => Int
  | .int2 => Int × Int

def_signature for TestDialect
  | .noop => () -> []
  | .mkPair => (.int, .int) -> .int2
  | .unPair => (.int2) -> [.int, .int]

def_denote for TestDialect
  | .noop => []ₕ
  | .unPair => fun (x, y) => [x, y]ₕ
  | .mkPair => fun x y => [(x, y)]ₕ

/-! ### Printing -/

instance : DialectPrint TestDialect where
  printOpName
    | .noop => "noop"
    | .unPair => "un_pair"
    | .mkPair => "pair"
  printAttributes _ := ""
  printTy
    | .int => "!int"
    | .int2 => "!int2"
  dialectName := "test"
  printReturn _ := "return"
  printFunc _ := "^entry"

/-! ### Parsing -/

instance : DecidableEq TestDialect.Ty := by unfold TestDialect; infer_instance
instance : DialectParse TestDialect 0 where
  mkTy
    | .undefined "int" => return .int
    | .undefined "int2" => return .int2
    | _ => throw .unsupportedType
  isValidReturn _ stx := return (stx.name == "return")
  mkExpr Γ opStx := do
    let op : TestDialect.Op ← match opStx.name with
      | "noop"     => pure .noop
      | "un_pair"  => pure .unPair
      | "pair"     => pure .mkPair
      | opName => throw <| .unsupportedOp opName
    opStx.mkExprOf Γ op

/-! ### EDSL -/

instance : Lean.ToExpr TestDialect.Op := by unfold TestDialect; infer_instance
instance : Lean.ToExpr TestDialect.Ty := by unfold TestDialect; infer_instance

open Qq in
instance : DialectToExpr TestDialect where
  toExprM := q(Id)
  toExprDialect := q(TestDialect)

elab "[test| "  reg:mlir_region "]" : term => do
  SSA.elabIntoCom' reg TestDialect

/-!
## Test Cases
Now come the actual test cases
-/

-- Test an operation without any results
/--
info:
^entry(%0 : !int):
  "noop"() : () -> ()
  "return"(%0) : (!int) -> ()
-/
#guard_msgs in #eval Com.print [test| {
  ^entry(%0 : !int):
    "noop"() : () -> ()
    "return"(%0) : (!int) -> ()
}]

-- Test an operation with multiple results
-- FIXME: the following test case fails to even parse, but it ought to
-- #guard_msgs in #eval Com.print [test| {
--   ^entry(%0 : !int, %1 : !int):
--     %2 = "pair"(%0, %1) : (!int, !int) -> (!int2)
--     %3, %4 = "unpair"(%2) : (!int2) -> (!int)
--     "return"(%3) : (!int) -> ()
-- }]
