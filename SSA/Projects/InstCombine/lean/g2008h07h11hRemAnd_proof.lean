
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem a_thm (x : _root_.BitVec 32) : x + x.sdiv 8#32 * 4294967288#32 &&& 1#32 = x &&& 1#32 := sorry

