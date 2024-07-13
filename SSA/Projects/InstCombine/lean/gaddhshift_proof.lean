
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem flip_add_of_shift_neg_thm (x x_1 x_2 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x_1.toNat then none else some ((x_2 * 255#8) <<< x_1)) fun a => some (a + x)) ⊑
    Option.bind (if 8 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a => some (x - a) := sorry

