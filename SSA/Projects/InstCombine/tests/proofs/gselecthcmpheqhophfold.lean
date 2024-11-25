import SSA.Projects.InstCombine.tests.proofs.gselecthcmpheqhophfold_proof
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
section gselecthcmpheqhophfold_statements

def replace_with_y_noundef_before := [llvm|
{
^0(%arg39 : i8, %arg40 : i8, %arg41 : i8):
  %0 = llvm.icmp "eq" %arg39, %arg40 : i8
  %1 = llvm.and %arg39, %arg40 : i8
  %2 = "llvm.select"(%0, %1, %arg41) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def replace_with_y_noundef_after := [llvm|
{
^0(%arg39 : i8, %arg40 : i8, %arg41 : i8):
  %0 = llvm.icmp "eq" %arg39, %arg40 : i8
  %1 = "llvm.select"(%0, %arg40, %arg41) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem replace_with_y_noundef_proof : replace_with_y_noundef_before ⊑ replace_with_y_noundef_after := by
  unfold replace_with_y_noundef_before replace_with_y_noundef_after
  simp_alive_peephole
  intros
  ---BEGIN replace_with_y_noundef
  apply replace_with_y_noundef_thm
  ---END replace_with_y_noundef


