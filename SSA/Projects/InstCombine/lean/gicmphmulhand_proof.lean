
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem pr40493_neg3_thm (x : _root_.BitVec 32) : x * 12#32 &&& 4#32 = x <<< 2 &&& 4#32 := sorry

theorem pr51551_demand3bits_thm (x x_1 : _root_.BitVec 32) : (x_1 &&& 4294967289#32 ||| 1#32) * x &&& 7#32 = x &&& 7#32 := sorry

