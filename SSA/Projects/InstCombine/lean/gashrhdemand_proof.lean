
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem srem2_ashr_mask_thm (x : _root_.BitVec 32) :
  (x + x.sdiv 2#32 * 4294967294#32).sshiftRight 31 &&& 2#32 = x + x.sdiv 2#32 * 4294967294#32 &&& 2#32 := sorry

