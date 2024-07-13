
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem test1_thm (x x_1 : _root_.BitVec 17) : (x_1 &&& 7#17 ||| x &&& 8#17) &&& 7#17 = x_1 &&& 7#17 := sorry

theorem test3_thm (x x_1 : _root_.BitVec 49) : (x_1 ||| x <<< 1) &&& 1#49 = x_1 &&& 1#49 := sorry

theorem test4_thm (x x_1 : _root_.BitVec 67) : (x_1 ||| x >>> 66) &&& 2#67 = x_1 &&& 2#67 := sorry

theorem or_test2_thm (x : _root_.BitVec 7) : x <<< 6 ||| 64#7 = 64#7 := sorry

