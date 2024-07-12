
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem t0_thm (x x_1 : _root_.BitVec 8) :
  (if 8 ≤ x.toNat then none else some ((x_1 ^^^ 255#8).sshiftRight x.toNat)) ⊑
    Option.bind (if 8 ≤ x.toNat then none else some (x_1.sshiftRight x.toNat)) fun a => some (a ^^^ 255#8) := sorry

theorem t1_thm (x x_1 : _root_.BitVec 8) :
  (if 8 ≤ x.toNat then none else some ((x_1 ^^^ 255#8).sshiftRight x.toNat)) ⊑
    Option.bind (if 8 ≤ x.toNat then none else some (x_1.sshiftRight x.toNat)) fun a => some (a ^^^ 255#8) := sorry

