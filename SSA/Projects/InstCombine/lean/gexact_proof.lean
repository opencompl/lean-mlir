
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem sdiv2_thm (x : _root_.BitVec 32) : x.sdiv 8#32 = x.sshiftRight 3 := sorry

theorem sdiv4_thm (x : _root_.BitVec 32) : x.sdiv 3#32 * 3#32 = x := sorry

theorem sdiv6_thm (x : _root_.BitVec 32) : x.sdiv 3#32 * 4294967293#32 = x * 4294967295#32 := sorry

theorem mul_of_sdiv_fail_ub_thm (x : _root_.BitVec 8) : x.sdiv 6#8 * 250#8 = x * 255#8 := sorry

