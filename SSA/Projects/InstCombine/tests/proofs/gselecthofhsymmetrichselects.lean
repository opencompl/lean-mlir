import SSA.Projects.InstCombine.tests.proofs.gselecthofhsymmetrichselects_proof
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
section gselecthofhsymmetrichselects_statements

def select_of_symmetric_selects_negative1_before := [llvm|
{
^0(%arg29 : i32, %arg30 : i32, %arg31 : i1, %arg32 : i1):
  %0 = "llvm.select"(%arg31, %arg29, %arg30) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %1 = "llvm.select"(%arg32, %arg30, %arg29) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = "llvm.select"(%arg32, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def select_of_symmetric_selects_negative1_after := [llvm|
{
^0(%arg29 : i32, %arg30 : i32, %arg31 : i1, %arg32 : i1):
  %0 = "llvm.select"(%arg31, %arg29, %arg30) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %1 = "llvm.select"(%arg32, %0, %arg29) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem select_of_symmetric_selects_negative1_proof : select_of_symmetric_selects_negative1_before ⊑ select_of_symmetric_selects_negative1_after := by
  unfold select_of_symmetric_selects_negative1_before select_of_symmetric_selects_negative1_after
  simp_alive_peephole
  ---BEGIN select_of_symmetric_selects_negative1
  apply select_of_symmetric_selects_negative1_thm
  ---END select_of_symmetric_selects_negative1


