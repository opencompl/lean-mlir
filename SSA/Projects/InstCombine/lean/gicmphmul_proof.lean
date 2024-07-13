
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem mul_of_pow2s_thm (x x_1 : _root_.BitVec 32) : (x_1 &&& 8#32) * (x &&& 16#32) ||| 128#32 = 128#32 := sorry

