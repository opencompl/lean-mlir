/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
-- Script that exhaustive enumerates the our LLVM semantics.
import Init.System.IO
import LeanMLIR.Util
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Projects.InstCombine.TestLLVMOps
import SSA.Projects.InstCombine.LLVM.CLITests
import SSA.Projects.InstCombine.Base

open System
open IO FS

/-- A row of CSV data. -/
structure Row where
  opName : String
  bitwidth : String
  v1 : String
  v2 : String
  v3 : String := "<none>"
  retval : String

instance : ToString Row where
  toString r :=
    s!"{r.opName}, {r.bitwidth}, {r.v1}, {r.v2}, {r.v3}, {r.retval}"

/-- CSV header row. -/
def rowHeader : Row := {
 opName := "op",
 bitwidth := "width",
 v1 := "in1",
 v2 := "in2",
 v3 := "in3",
 retval := "retval"
}

/-- Maximum width we bruteforce (inclusive). -/
def MAXW : Nat := 4

/-- List of bitvector inputs for a given bitwidth. Produces 'poison' and `[0..2^w)`. -/
def BitVec.inputsForWidth (w : Nat) : Array (Option (BitVec w)) := Id.run do
 let mut out := #[Option.none]
 for i  in [0:Nat.pow 2 w] do
   out := out.push (.some <| BitVec.ofNat w i)
 out

/-- Render the inputs as a string. These are guaranteed to always be natural numbers. -/
def BitVec.inputToString : Option (BitVec w) → String
| .none => "poison"
| .some bv => s!"{bv.toNat}"

/-- Render optional inputs in a test as strings. -/
def ConcreteCliTest.inputToString (test : ConcreteCliTest) : Nat → Array (Option ℤ) → String
  | i, arr =>
    let tys : List (InstCombine.MTy 0) := test.context.reverse -- reverse because context is a stack
    match tys[i]? with
    | .none => "<none>"
    | .some (.bitvec (.concrete w)) =>
        BitVec.inputToString <| Option.map (BitVec.ofInt w) arr[i]!

/-- Render the output as a string. These are more complex, as i1 are printed as true/false, and outputs are printed as integers. -/
def BitVec.outputToString : Option (BitVec w) → String
| .none => "poison"
| .some bv =>
    let iv := BitVec.toInt bv
    if w == 1
    then
      if iv == 0 then "false"
      else if iv == -1 then "true"
      else "<unk_i1>"
    else toString iv

/-- Produce CSV rows for a binary operation given by 'f' -/
def binopRows (opName : String)
  (f : (w : Nat) → Option (BitVec w) → Option (BitVec w) → Option (BitVec w)) : Array Row := Id.run do
  let mut rows := #[]
  for w in [1:MAXW+1] do
    for i in BitVec.inputsForWidth w do
      for j in BitVec.inputsForWidth w do
        let retv := f (w := w) i j
        let retv := BitVec.outputToString retv
        let row : Row := {
          opName := opName,
          bitwidth := toString w,
          v1 := BitVec.inputToString i,
          v2 := BitVec.inputToString j,
          retval := retv
        }
        rows := rows.push row
  rows

/-- Produce CSV rows for 'llvm.select' -/
def selectRows : Array Row := Id.run do
  let mut rows := #[]
  for w in [1:MAXW+1] do
    for i in BitVec.inputsForWidth 1 do
      for j in BitVec.inputsForWidth w do
        for k in BitVec.inputsForWidth w do
            let retv := InstCombine.Op.denote (.select w) (.cons i <| .cons j <| .cons k .nil)
            let retv := BitVec.outputToString retv
            let row : Row := {
              opName := "select",
              bitwidth := toString w,
              v1 := BitVec.inputToString i,
              v2 := BitVec.inputToString j,
              v3 := BitVec.inputToString k,
              retval := retv
            }
            rows := rows.push row
  rows

/-- Produce CSV rows for 'llvm.icmp <pred> -/
def icmpRows (pred : LLVM.IntPredicate) : Array Row := Id.run do
  let mut rows := #[]
  for w in [1:MAXW+1] do
    for i in BitVec.inputsForWidth w do
      for j in BitVec.inputsForWidth w do
        let retv := InstCombine.Op.denote (.icmp pred w) (.cons i <| .cons j <| .nil)
        let retv := BitVec.outputToString retv
        let row : Row := {
          opName := s!"icmp.{pred}",
          bitwidth := toString w,
          v1 := BitVec.inputToString i,
          v2 := BitVec.inputToString j,
          retval := retv
        }
        rows := rows.push row
  rows


def testNameToRowName : String → String
  | testName => match testName.splitOn "_" with
    | [_,name] => name
    | [_,name, op] => s!"{name}.{op}"
    | _ => "Error"

/-- Produce rows for a `ConcreteCliTest` -/
def concreteCliTestRows (test : ConcreteCliTest) : IO <| Array Row := do
  let mut rows := #[]
  let argTys : List test.code.getTy := test.context.reverse -- reverse because context is stack
  let mut args : Array (Array (Option ℤ)) := #[]
  for ty in argTys do
    match ty with
      | .bitvec (.concrete w) => args := args.push <| (BitVec.inputsForWidth w).map (Option.map BitVec.toInt)
  let argvecs := productsArr args
  for arg in argvecs do
    let evalRes ← test.eval? arg
    match evalRes with
      | Except.ok retv =>
        let ty : InstCombine.MTy 0 := test.ty
        match hty : ty with
          | .bitvec (.concrete w) =>
              let h : TyDenote.toType ty = Option (BitVec w) := by simp [hty, TyDenote.toType, LLVM.IntW]
              let retv' : Option (BitVec w) := h ▸ retv
              let retv := BitVec.outputToString retv'
              let row : Row := {
                opName := s!"{testNameToRowName test.name.toString}",
                bitwidth := "4", -- right now only hard-coded
                v1 := test.inputToString 0 arg,
                v2 := test.inputToString 1 arg,
                v3 := test.inputToString 2 arg,
                retval := retv
              }
              rows := rows.push row
      | Except.error e => IO.println e
  return rows

def icmpPredicates := [ LLVM.IntPredicate.eq, LLVM.IntPredicate.ne, LLVM.IntPredicate.ugt,
  LLVM.IntPredicate.uge, LLVM.IntPredicate.ult, LLVM.IntPredicate.ule, LLVM.IntPredicate.sgt,
  LLVM.IntPredicate.sge, LLVM.IntPredicate.slt, LLVM.IntPredicate.sle]

def generateRawSemantics : IO Unit := do
  let filename := "generated-ssa-llvm-semantics.csv"
  let handle : Handle ← IO.FS.Handle.mk filename IO.FS.Mode.write
  let stream : Stream := IO.FS.Stream.ofHandle handle
  let mut rows := #[rowHeader]
  rows := rows.append (selectRows)
  --
  for pred in icmpPredicates do
    rows := rows.append (icmpRows pred)
  --
  rows := rows.append (binopRows "and"  (fun w a b => InstCombine.Op.denote (.and w)  [a,b]ₕ))
  rows := rows.append (binopRows "or"   (fun w a b => InstCombine.Op.denote (.or w)   [a,b]ₕ))
  rows := rows.append (binopRows "xor"  (fun w a b => InstCombine.Op.denote (.xor w)  [a,b]ₕ))
  rows := rows.append (binopRows "add"  (fun w a b => InstCombine.Op.denote (.add w)  [a,b]ₕ))
  rows := rows.append (binopRows "sub"  (fun w a b => InstCombine.Op.denote (.sub w)  [a,b]ₕ))
  rows := rows.append (binopRows "mul"  (fun w a b => InstCombine.Op.denote (.mul w)  [a,b]ₕ))
  rows := rows.append (binopRows "udiv" (fun w a b => InstCombine.Op.denote (.udiv w) [a,b]ₕ))
  rows := rows.append (binopRows "sdiv" (fun w a b => InstCombine.Op.denote (.sdiv w) [a,b]ₕ))
  rows := rows.append (binopRows "urem" (fun w a b => InstCombine.Op.denote (.urem w) [a,b]ₕ))
  rows := rows.append (binopRows "srem" (fun w a b => InstCombine.Op.denote (.srem w) [a,b]ₕ))
  rows := rows.append (binopRows "shl"  (fun w a b => InstCombine.Op.denote (.shl w)  [a,b]ₕ))
  rows := rows.append (binopRows "lshr" (fun w a b => InstCombine.Op.denote (.lshr w) [a,b]ₕ))
  rows := rows.append (binopRows "ashr" (fun w a b => InstCombine.Op.denote (.ashr w) [a,b]ₕ))
  rows.toList |>.map toString |> "\n".intercalate |> stream.putStr
  return ()

def generateTestSemantics : IO Unit := do
  let filename := "generated-ssa-llvm-syntax-and-semantics.csv"
  let handle : Handle ← IO.FS.Handle.mk filename IO.FS.Mode.write
  let stream : Stream := IO.FS.Stream.ofHandle handle
  let mut rows := #[rowHeader]
  for test in llvmTests! do
    rows := rows.append (← concreteCliTestRows test)
  rows.toList |>.map toString |> "\n".intercalate |> stream.putStr
  return ()

def main : IO Unit := do
  generateRawSemantics
  generateTestSemantics
