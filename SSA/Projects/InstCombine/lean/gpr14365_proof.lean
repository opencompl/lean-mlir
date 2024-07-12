
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem test0_thm (x : _root_.BitVec 32) :
  x + (x &&& 1431655765#32 ^^^ 4294967295#32) + 1#32 = x &&& 2863311530#32 := sorry

theorem test1_thm (x : _root_.BitVec 32) :
  x + (x.sshiftRight 1 &&& 1431655765#32 ^^^ 4294967295#32) + 1#32 =
    x + (x >>> 1 &&& 1431655765#32) * 4294967295#32 := sorry

