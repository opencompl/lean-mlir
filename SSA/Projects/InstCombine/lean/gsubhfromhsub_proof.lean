
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem t9_c0_c2_thm (x : _root_.BitVec 8) : 42#8 + x * 255#8 + 232#8 = x * 255#8 + 18#8 := sorry

