
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem test1_thm (x x_1 : _root_.BitVec 47) :
  x_1 &&& 70368744177664#47 ^^^ x &&& 70368744177661#47 = x_1 &&& 70368744177664#47 ||| x &&& 70368744177661#47 := sorry

theorem test5_thm (x : _root_.BitVec 7) : (x ||| 23#7) ^^^ 23#7 = x &&& 104#7 := sorry

theorem test7_thm (x : _root_.BitVec 47) :
  (x ||| 70368744177663#47) ^^^ 703687463#47 = x &&& 70368744177664#47 ||| 70368040490200#47 := sorry

