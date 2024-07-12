
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem foo4_thm (x x_1 : _root_.BitVec 1) : (if x = 0#1 then none else some (x_1.sdiv x)) ⊑ some x_1 := sorry

