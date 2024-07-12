
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem reassoc_x2_add_nuw_thm (x x_1 : _root_.BitVec 32) : x_1 + 4#32 + x + 8#32 = x_1 + x + 12#32 := sorry

theorem reassoc_x2_mul_nuw_thm (x x_1 : _root_.BitVec 32) : x_1 * 5#32 * x * 9#32 = x_1 * x * 45#32 := sorry

theorem tryFactorization_add_nuw_mul_nuw_thm (x : _root_.BitVec 32) : x + x * 3#32 = x <<< 2 := sorry

theorem tryFactorization_add_nuw_mul_nuw_int_max_thm (x : _root_.BitVec 32) : x + x * 2147483647#32 = x <<< 31 := sorry

theorem tryFactorization_add_mul_nuw_thm (x : _root_.BitVec 32) : x + x * 3#32 = x <<< 2 := sorry

theorem tryFactorization_add_nuw_mul_thm (x : _root_.BitVec 32) : x + x * 3#32 = x <<< 2 := sorry

