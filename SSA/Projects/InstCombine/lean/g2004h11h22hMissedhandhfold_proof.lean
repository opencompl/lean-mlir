
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem test21_thm (x : _root_.BitVec 8) : x.sshiftRight 7 &&& 1#8 = x >>> 7 := sorry

