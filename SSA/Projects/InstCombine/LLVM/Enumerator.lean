-- Script that exhaustive enumerates the our LLVM semantics.
import Std.Data.BitVec
import Init.System.IO
-- import Mathlib.Data.BitVec
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Projects.InstCombine.Base

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


def BitVecInputsForWidth (w : Nat) : Array (Option (BitVec w)) := Id.run do
 let mut out := #[Option.none]
 for i  in [0:Nat.pow 2 w] do
   out := out.push (.some <| BitVec.ofNat w i)
 out



def BitVecInputToString : Option (BitVec w) → String
| .none => "poison"
| .some bv => s!"{bv.toNat}"

def BitVecOutputToString : Option (BitVec w) → String 
| .none => "poison"
| .some bv =>
    let iv := BitVec.toInt bv
    if w == 1
    then
      if iv == 0 then "false"
      else if iv == -1 then "true"
      else "<unk_i1>"
    else toString iv


def binopRows (opName : String)
  (f : (w : Nat) → Option (BitVec w) → Option (BitVec w) → Option (BitVec w)) : Array Row := Id.run do
  let mut rows := #[]
  for w in [1:MAXW+1] do
    for i in BitVecInputsForWidth w do
      for j in BitVecInputsForWidth w do
        let retv := f (w := w) i j
        let retv := BitVecOutputToString retv
        let row : Row := {
          opName := opName,
          bitwidth := toString w,
          v1 := BitVecInputToString i,
          v2 := BitVecInputToString j,
          retval := retv
        }
        rows := rows.push row
  rows


def selectRows : Array Row := Id.run do
  sorry
#check System.FilePath

def main : IO Unit := do
  let filename := "generated-ssa-llvm-semantics.csv"
  let handle : Handle ← IO.FS.Handle.mk filename IO.FS.Mode.write
  let stream : Stream := IO.FS.Stream.ofHandle handle
  let allRows := #[rowHeader]
  let allRows := allRows.append (selectRows)
  let allRows := allRows.append (binopRows "and" (fun w a b => InstCombine.Op.denote (InstCombine.Op.and w) (.cons a (.cons b .nil))))
  -- let allRows := allRows.append (binopRows "or" LLVM.or?)
  -- let allRows := allRows.append (binopRows "xor" LLVM.xor?)
  -- let allRows := allRows.append (binopRows "add" LLVM.add?)
  -- let allRows := allRows.append (binopRows "sub" LLVM.sub?)
  -- let allRows := allRows.append (binopRows "mul" LLVM.mul?)
  -- let allRows := allRows.append (binopRows "udiv" LLVM.udiv?)
  -- let allRows := allRows.append (binopRows "sdiv" LLVM.sdiv?)
  -- let allRows := allRows.append (binopRows "urem" LLVM.urem?)
  -- let allRows := allRows.append (binopRows "srem" LLVM.srem?)
  -- let allRows := allRows.append (binopRows "shl" LLVM.shl?)
  -- let allRows := allRows.append (binopRows "lshr" LLVM.lshr?)
  -- let allRows := allRows.append (binopRows "ashr" LLVM.ashr?)
  allRows.toList |>.map toString |> "\n".intercalate |> stream.putStr
  return ()
