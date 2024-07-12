
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem test_srem_canonicalize_op0_thm (x x_1 : _root_.BitVec 32) :
  Option.map (fun div => x_1 * 4294967295#32 + div * x * 4294967295#32)
      (if x = 0#32 ∨ x_1 * 4294967295#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none
      else some ((x_1 * 4294967295#32).sdiv x)) ⊑
    (Option.map (fun div => x_1 - div * x)
          (if x = 0#32 ∨ x_1 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some (x_1.sdiv x))).bind
      fun a => some (-a) := sorry

