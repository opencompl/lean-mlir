
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem test1_thm (x : _root_.BitVec 177) :
  x * 45671926166590716193865151022383844364247891968#177 = x <<< 155 := sorry

