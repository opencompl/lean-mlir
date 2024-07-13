
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem neg_mask1_lshr_thm (x : _root_.BitVec 8) : (x >>> 3 &&& 1#8) * 255#8 = (x <<< 4).sshiftRight 7 := sorry

theorem sub_mask1_lshr_thm (x : _root_.BitVec 8) : (x >>> 1 &&& 1#8) * 255#8 = (x <<< 6).sshiftRight 7 := sorry

