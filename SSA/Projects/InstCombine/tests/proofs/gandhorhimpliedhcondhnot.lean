import SSA.Projects.InstCombine.tests.proofs.gandhorhimpliedhcondhnot_proof
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
section gandhorhimpliedhcondhnot_statements

def test_imply_not2_before := [llvm|
{
^0(%arg3 : i32, %arg4 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "eq" %arg3, %0 : i32
  %4 = "llvm.select"(%3, %arg4, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.xor %3, %2 : i1
  %6 = llvm.or %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test_imply_not2_after := [llvm|
{
^0(%arg3 : i32, %arg4 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ne" %arg3, %0 : i32
  %3 = "llvm.select"(%2, %1, %arg4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_imply_not2_proof : test_imply_not2_before ⊑ test_imply_not2_after := by
  unfold test_imply_not2_before test_imply_not2_after
  simp_alive_peephole
  intros
  ---BEGIN test_imply_not2
  apply test_imply_not2_thm
  ---END test_imply_not2


