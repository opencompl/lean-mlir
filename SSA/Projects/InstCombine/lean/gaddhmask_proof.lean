
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem add_mask_ashr28_i32_thm (x : _root_.BitVec 32) : (x.sshiftRight 28 &&& 8#32) + x.sshiftRight 28 = x >>> 28 &&& 7#32 := sorry

