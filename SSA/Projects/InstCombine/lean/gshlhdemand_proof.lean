
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem set_shl_mask_thm (x x_1 : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some ((x_1 ||| 196609#32) <<< x)) fun a => some (a &&& 65536#32)) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some ((x_1 ||| 65537#32) <<< x)) fun a => some (a &&& 65536#32) := sorry

