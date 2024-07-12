
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem t1_thm (x : _root_.BitVec 4) : (x ||| 12#4) ^^^ 10#4 = x &&& 3#4 ^^^ 6#4 := sorry

