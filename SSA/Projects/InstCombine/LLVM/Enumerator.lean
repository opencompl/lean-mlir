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

open Std in
def binopRows (opName : String) (f : {w : Nat} → BitVec w → BitVec w → Option (BitVec w)) : Array Row := Id.run do
  let mut rows := #[]
  for w in [1:MAXW+1] do
    for i in [0:Nat.pow 2 w] do
      for j in [0:Nat.pow 2 w] do
        let retv :=
          match f (w := w) (BitVec.ofNat w i) (BitVec.ofNat w j) with
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
          opName := opName,
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
  let allRows := allRows.append (binopRows "and" LLVM.and?)
  let allRows := allRows.append (binopRows "or" LLVM.or?)
  let allRows := allRows.append (binopRows "xor" LLVM.xor?)
  let allRows := allRows.append (binopRows "add" LLVM.add?)
  let allRows := allRows.append (binopRows "sub" LLVM.sub?)
  let allRows := allRows.append (binopRows "mul" LLVM.mul?)
  let allRows := allRows.append (binopRows "udiv" LLVM.udiv?)
  let allRows := allRows.append (binopRows "sdiv" LLVM.sdiv?)
  let allRows := allRows.append (binopRows "urem" LLVM.urem?)
  let allRows := allRows.append (binopRows "srem" LLVM.srem?)
  let allRows := allRows.append (binopRows "shl" LLVM.shl?)
  let allRows := allRows.append (binopRows "lshr" LLVM.lshr?)
  let allRows := allRows.append (binopRows "ashr" LLVM.ashr?)
  allRows.toList |>.map toString |> "\n".intercalate |> stream.putStr
  return ()
