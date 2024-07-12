
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import Batteries.Data.BitVec

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)
theorem foo_thm (x : _root_.BitVec 32) :
  ((x &&& 223#32 ^^^ 29#32) + 3510399223#32 +
            ((x &&& 223#32 ^^^ 29#32 ||| 1874836915#32) ^^^ ((x &&& 223#32 ^^^ 29#32) &&& 221#32 ^^^ 1874836915#32)) <<<
                1 *
              4294967295#32 +
          1533579450#32 |||
        2147483648#32) ^^^
      749011377#32 =
    (x &&& 223#32 ^^^ 29#32) + 4294967295#32 * ((x &&& 223#32 ^^^ 29#32) <<< 1 &&& 290#32) + 2896495025#32 ^^^
      749011377#32 := sorry

