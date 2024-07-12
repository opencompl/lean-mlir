
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem factorize_thm (x : _root_.BitVec 32) : (x ||| 1#32) &&& (x ||| 2#32) = x := sorry

theorem factorize2_thm (x : _root_.BitVec 32) : 3#32 * x + x * 4294967294#32 = x := sorry

theorem factorize4_thm (x x_1 : _root_.BitVec 32) : x_1 <<< 1 * x + x * x_1 * 4294967295#32 = x * x_1 := sorry

theorem factorize5_thm (x x_1 : _root_.BitVec 32) : x_1 * 2#32 * x + x_1 * x * 4294967295#32 = x_1 * x := sorry

theorem expand_thm (x : _root_.BitVec 32) : (x &&& 1#32 ||| 2#32) &&& 1#32 = x &&& 1#32 := sorry

