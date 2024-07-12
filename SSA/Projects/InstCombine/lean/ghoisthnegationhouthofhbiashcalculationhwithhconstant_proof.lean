
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem t0_thm (x : _root_.BitVec 8) : (x &&& 42#8) + x * 255#8 = (x &&& 213#8) * 255#8 := sorry

theorem n5_thm (x : _root_.BitVec 8) : x + (x &&& 42#8) * 255#8 = x &&& 213#8 := sorry

