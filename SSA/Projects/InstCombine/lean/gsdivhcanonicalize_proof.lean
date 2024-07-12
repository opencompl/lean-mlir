
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem test_sdiv_canonicalize_op0_thm (x x_1 : _root_.BitVec 32) :
  (if x = 0#32 ∨ x_1 * 4294967295#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none
    else some ((x_1 * 4294967295#32).sdiv x)) ⊑
    Option.bind (if x = 0#32 ∨ x_1 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some (x_1.sdiv x)) fun a =>
      some (4294967295#32 * a) := sorry

theorem test_sdiv_canonicalize_op0_exact_thm (x x_1 : _root_.BitVec 32) :
  (if x = 0#32 ∨ x_1 * 4294967295#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none
    else some ((x_1 * 4294967295#32).sdiv x)) ⊑
    Option.bind (if x = 0#32 ∨ x_1 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some (x_1.sdiv x)) fun a =>
      some (4294967295#32 * a) := sorry

