
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem PR75692_1_thm (x : _root_.BitVec 32) : (x ^^^ 4#32) &&& (x ^^^ 4294967291#32) = 0#32 := sorry

