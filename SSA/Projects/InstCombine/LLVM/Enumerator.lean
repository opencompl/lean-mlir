-- Script that exhaustive enumerates the our LLVM semantics.
import Std.Data.BitVec
import Init.System.IO
-- import Mathlib.Data.BitVec
import SSA.Projects.InstCombine.LLVM.Semantics

open Std
open System
open IO FS

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

def rowHeader : Row := {
 opName := "op",
 bitwidth := "width",
 v1 := "in0",
 v2 := "in1",
 v3 := "in2",
 retval := "retval"
}

def MAXW : Nat := 3

#check Range
def addRows : Array Row := Id.run do
  let mut rows := #[]
  for w in [1:MAXW+1] do
    for i in [0:Nat.pow 2 w] do
      for j in [0:Nat.pow 2 w] do
        let retv :=
          match LLVM.add? (BitVec.ofNat w i) (BitVec.ofNat w j) with
          | .none => "poison"
          | .some bv =>
            let iv := BitVec.toInt bv
            if w == 1
            then
              if iv == 0 then "false"
              else if iv == -1 then "true"
              else "<unk_i1>"
            else toString iv
        let row : Row := {
          opName := "add"
          bitwidth := toString w,
          v1 := toString i,
          v2 := toString j,
          retval := retv
        }
        rows := rows.push row
  rows


#check System.FilePath

def main : IO Unit := do
  let filename := "generated-ssa-llvm-semantics.csv"
  let handle : Handle ← IO.FS.Handle.mk filename IO.FS.Mode.write
  let stream : Stream := IO.FS.Stream.ofHandle handle
  let allRows := #[rowHeader]
  let allRows := allRows.append addRows
  allRows.toList |>.map toString |> "\n".intercalate |> stream.putStr
  return ()
