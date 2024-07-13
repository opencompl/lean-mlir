
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem i_thm (x : _root_.BitVec 8) : (x.sdiv 253#8).sdiv 253#8 = x.sdiv 9#8 := sorry

