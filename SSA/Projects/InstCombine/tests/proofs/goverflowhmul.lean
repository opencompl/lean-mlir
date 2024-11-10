import SSA.Projects.InstCombine.tests.proofs.goverflowhmul_proof
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
section goverflowhmul_statements

def pr4917_3_before := [llvm|
{
^0(%arg25 : i32, %arg26 : i32):
  %0 = llvm.mlir.constant(4294967295) : i64
  %1 = llvm.mlir.constant(111) : i64
  %2 = llvm.zext %arg25 : i32 to i64
  %3 = llvm.zext %arg26 : i32 to i64
  %4 = llvm.mul %2, %3 : i64
  %5 = llvm.icmp "ugt" %4, %0 : i64
  %6 = "llvm.select"(%5, %4, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def pr4917_3_after := [llvm|
{
^0(%arg25 : i32, %arg26 : i32):
  %0 = llvm.mlir.constant(4294967295) : i64
  %1 = llvm.mlir.constant(111) : i64
  %2 = llvm.zext %arg25 : i32 to i64
  %3 = llvm.zext %arg26 : i32 to i64
  %4 = llvm.mul %2, %3 overflow<nuw> : i64
  %5 = llvm.icmp "ugt" %4, %0 : i64
  %6 = "llvm.select"(%5, %4, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%6) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pr4917_3_proof : pr4917_3_before ⊑ pr4917_3_after := by
  unfold pr4917_3_before pr4917_3_after
  simp_alive_peephole
  intros
  ---BEGIN pr4917_3
  apply pr4917_3_thm
  ---END pr4917_3



def mul_may_overflow_before := [llvm|
{
^0(%arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(4294967295 : i34) : i34
  %1 = llvm.zext %arg8 : i32 to i34
  %2 = llvm.zext %arg9 : i32 to i34
  %3 = llvm.mul %1, %2 : i34
  %4 = llvm.icmp "ule" %3, %0 : i34
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def mul_may_overflow_after := [llvm|
{
^0(%arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(4294967296 : i34) : i34
  %1 = llvm.zext %arg8 : i32 to i34
  %2 = llvm.zext %arg9 : i32 to i34
  %3 = llvm.mul %1, %2 : i34
  %4 = llvm.icmp "ult" %3, %0 : i34
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_may_overflow_proof : mul_may_overflow_before ⊑ mul_may_overflow_after := by
  unfold mul_may_overflow_before mul_may_overflow_after
  simp_alive_peephole
  intros
  ---BEGIN mul_may_overflow
  apply mul_may_overflow_thm
  ---END mul_may_overflow


