
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem lshr_not_nneg2_thm (x : _root_.BitVec 8) : (x ^^^ 255#8) >>> 1 ^^^ 255#8 = x >>> 1 ||| 128#8 := sorry

