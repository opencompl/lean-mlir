
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem a_thm (x : _root_.BitVec 32) : 8#32 + x * 4294967295#32 &&& 7#32 = x * 4294967295#32 &&& 7#32 := sorry

