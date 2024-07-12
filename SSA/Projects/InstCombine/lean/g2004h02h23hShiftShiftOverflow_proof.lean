
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem test_thm (x : _root_.BitVec 32) : (x.sshiftRight 17).sshiftRight 17 = x.sshiftRight 31 := sorry

theorem test2_thm (x : _root_.BitVec 32) : x <<< 34 = 0#32 := sorry

