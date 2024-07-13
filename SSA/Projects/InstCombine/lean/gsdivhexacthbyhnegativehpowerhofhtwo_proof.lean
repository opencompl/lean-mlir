
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem t0_thm (x : _root_.BitVec 8) : x.sdiv 224#8 = x.sshiftRight 5 * 255#8 := sorry

theorem prove_exact_with_high_mask_thm (x : _root_.BitVec 8) : (x &&& 224#8).sdiv 252#8 = (x.sshiftRight 2 &&& 248#8) * 255#8 := sorry

theorem prove_exact_with_high_mask_limit_thm (x : _root_.BitVec 8) : (x &&& 224#8).sdiv 224#8 = x.sshiftRight 5 * 255#8 := sorry

