import SSA.Projects.InstCombine.tests.proofs.gmul_full_64_proof
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
section gmul_full_64_statements

def mullo_before := [llvm|
{
^0(%arg6 : i64, %arg7 : i64):
  %0 = llvm.mlir.constant(4294967295) : i64
  %1 = llvm.mlir.constant(32) : i64
  %2 = llvm.and %arg6, %0 : i64
  %3 = llvm.lshr %arg6, %1 : i64
  %4 = llvm.and %arg7, %0 : i64
  %5 = llvm.lshr %arg7, %1 : i64
  %6 = llvm.mul %4, %2 overflow<nuw> : i64
  %7 = llvm.mul %4, %3 overflow<nuw> : i64
  %8 = llvm.mul %5, %2 overflow<nuw> : i64
  %9 = llvm.and %6, %0 : i64
  %10 = llvm.lshr %6, %1 : i64
  %11 = llvm.add %10, %7 : i64
  %12 = llvm.and %11, %0 : i64
  %13 = llvm.add %12, %8 : i64
  %14 = llvm.shl %13, %1 : i64
  %15 = llvm.or %14, %9 : i64
  "llvm.return"(%15) : (i64) -> ()
}
]
def mullo_after := [llvm|
{
^0(%arg6 : i64, %arg7 : i64):
  %0 = llvm.mlir.constant(4294967295) : i64
  %1 = llvm.mlir.constant(32) : i64
  %2 = llvm.and %arg6, %0 : i64
  %3 = llvm.lshr %arg6, %1 : i64
  %4 = llvm.and %arg7, %0 : i64
  %5 = llvm.lshr %arg7, %1 : i64
  %6 = llvm.mul %4, %2 overflow<nuw> : i64
  %7 = llvm.mul %arg7, %3 : i64
  %8 = llvm.mul %5, %arg6 : i64
  %9 = llvm.and %6, %0 : i64
  %10 = llvm.lshr %6, %1 : i64
  %11 = llvm.add %10, %7 : i64
  %12 = llvm.add %11, %8 : i64
  %13 = llvm.shl %12, %1 : i64
  %14 = llvm.or disjoint %13, %9 : i64
  "llvm.return"(%14) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mullo_proof : mullo_before ⊑ mullo_after := by
  unfold mullo_before mullo_after
  simp_alive_peephole
  intros
  ---BEGIN mullo
  apply mullo_thm
  ---END mullo



def mullo_variant3_before := [llvm|
{
^0(%arg4 : i64, %arg5 : i64):
  %0 = llvm.mlir.constant(4294967295) : i64
  %1 = llvm.mlir.constant(32) : i64
  %2 = llvm.and %arg4, %0 : i64
  %3 = llvm.lshr %arg4, %1 : i64
  %4 = llvm.and %arg5, %0 : i64
  %5 = llvm.lshr %arg5, %1 : i64
  %6 = llvm.mul %4, %2 overflow<nuw> : i64
  %7 = llvm.mul %4, %3 overflow<nuw> : i64
  %8 = llvm.mul %5, %2 overflow<nuw> : i64
  %9 = llvm.add %8, %7 : i64
  %10 = llvm.shl %9, %1 : i64
  %11 = llvm.add %10, %6 : i64
  "llvm.return"(%11) : (i64) -> ()
}
]
def mullo_variant3_after := [llvm|
{
^0(%arg4 : i64, %arg5 : i64):
  %0 = llvm.mul %arg4, %arg5 : i64
  "llvm.return"(%0) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mullo_variant3_proof : mullo_variant3_before ⊑ mullo_variant3_after := by
  unfold mullo_variant3_before mullo_variant3_after
  simp_alive_peephole
  intros
  ---BEGIN mullo_variant3
  apply mullo_variant3_thm
  ---END mullo_variant3


