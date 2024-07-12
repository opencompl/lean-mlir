
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem t0_thm (x : _root_.BitVec 64) : x >>> 63 * 18446744073709551615#64 = x.sshiftRight 63 := sorry

theorem t0_exact_thm (x : _root_.BitVec 64) : x >>> 63 * 18446744073709551615#64 = x.sshiftRight 63 := sorry

theorem t2_thm (x : _root_.BitVec 64) : x.sshiftRight 63 * 18446744073709551615#64 = x >>> 63 := sorry

theorem t3_exact_thm (x : _root_.BitVec 64) : x.sshiftRight 63 * 18446744073709551615#64 = x >>> 63 := sorry

