
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem t0_thm (x x_1 : _root_.BitVec 8) : 255#8 * x + (x_1 * 255#8 &&& x) = 255#8 * (x_1 + 255#8 &&& x) := sorry

theorem n7_thm (x x_1 : _root_.BitVec 8) : x_1 + 255#8 * (x * 255#8 &&& x_1) = x + 255#8 &&& x_1 := sorry

