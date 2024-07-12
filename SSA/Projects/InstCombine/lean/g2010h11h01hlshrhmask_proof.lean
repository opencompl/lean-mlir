
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem foo_thm (x x_1 : _root_.BitVec 8) :
  (x_1 <<< 7 ^^^ x &&& 138#8) >>> 7 <<< 5 ^^^
      (x &&& 33#8 ||| 168#8 + (x &&& 84#8) * 255#8 &&& 84#8 ||| x_1 <<< 7 ^^^ x &&& 138#8) =
    (x_1 <<< 7 ^^^ x &&& 138#8) >>> 2 &&& 32#8 ^^^
      (x &&& 33#8 ||| (x &&& 84#8) * 255#8 + 40#8 &&& 84#8 ||| x_1 <<< 7 ^^^ x &&& 138#8) := sorry

