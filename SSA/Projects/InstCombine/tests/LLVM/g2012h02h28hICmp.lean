
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
section g2012h02h28hICmp_statements

def f1_logical_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(16711680 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.trunc %arg0 : i32 to i8
  %5 = llvm.icmp "ne" %4, %0 : i8
  %6 = llvm.and %arg0, %1 : i32
  %7 = llvm.icmp "ne" %6, %2 : i32
  %8 = "llvm.select"(%5, %7, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def f1_logical_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(16711680 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.trunc %arg0 : i32 to i8
  %4 = llvm.icmp "ne" %3, %0 : i8
  %5 = llvm.and %arg0, %1 : i32
  %6 = llvm.icmp "ne" %5, %2 : i32
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem f1_logical_proof : f1_logical_before ⊑ f1_logical_after := by
  unfold f1_logical_before f1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN f1_logical
  all_goals (try extract_goal ; sorry)
  ---END f1_logical


