import SSA.Projects.InstCombine.tests.proofs.gpr49688_proof
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
section gpr49688_statements

def f_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(7 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "slt" %arg2, %0 : i32
  %4 = llvm.ashr %1, %arg2 : i32
  %5 = llvm.icmp "sgt" %arg2, %4 : i32
  %6 = "llvm.select"(%3, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def f_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(7 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "slt" %arg2, %0 : i32
  %4 = llvm.lshr %1, %arg2 : i32
  %5 = llvm.icmp "sgt" %arg2, %4 : i32
  %6 = "llvm.select"(%3, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem f_proof : f_before ⊑ f_after := by
  unfold f_before f_after
  simp_alive_peephole
  intros
  ---BEGIN f
  apply f_thm
  ---END f



def f2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(7 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "slt" %arg0, %0 : i32
  %4 = llvm.ashr %1, %arg1 : i32
  %5 = llvm.icmp "sgt" %arg0, %4 : i32
  %6 = "llvm.select"(%3, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = llvm.zext %6 : i1 to i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def f2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(7 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "slt" %arg0, %0 : i32
  %4 = llvm.lshr %1, %arg1 : i32
  %5 = llvm.icmp "sgt" %arg0, %4 : i32
  %6 = "llvm.select"(%3, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = llvm.zext %6 : i1 to i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem f2_proof : f2_before ⊑ f2_after := by
  unfold f2_before f2_after
  simp_alive_peephole
  intros
  ---BEGIN f2
  apply f2_thm
  ---END f2


