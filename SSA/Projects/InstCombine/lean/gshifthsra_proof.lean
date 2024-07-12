
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem ashr_ashr_thm (x : _root_.BitVec 32) : (x.sshiftRight 5).sshiftRight 7 = x.sshiftRight 12 := sorry

theorem ashr_overshift_thm (x : _root_.BitVec 32) : (x.sshiftRight 15).sshiftRight 17 = x.sshiftRight 31 := sorry

