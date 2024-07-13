
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem t0_thm (x x_1 : _root_.BitVec 32) : (x_1 ^^^ 4294967295#32) + x + 1#32 = x + x_1 * 4294967295#32 := sorry

