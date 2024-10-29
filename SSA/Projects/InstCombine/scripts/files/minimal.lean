
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open LLVM
open BitVec

open MLIR AST
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false


def minimal_bool := [llvm|
{
^0():
  %0 = "llvm.mlir.constant"() <{value = false}> : () -> i1
  %1 = "llvm.mlir.constant"() <{value = true}> : () -> i1
  %2 = llvm.and %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
