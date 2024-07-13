
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem test6_thm (x : _root_.BitVec 55) : x <<< 1 * 3#55 = x * 6#55 := sorry

theorem test6a_thm (x : _root_.BitVec 55) : (x * 3#55) <<< 1 = x * 6#55 := sorry

theorem test9_thm (x : _root_.BitVec 17) : x <<< 16 >>> 16 = x &&& 1#17 := sorry

