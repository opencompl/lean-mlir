import SSA.Projects.InstCombine.tests.proofs.gdemand_shrink_nsw_proof
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
section gdemand_shrink_nsw_statements

def foo_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(223 : i32) : i32
  %1 = llvm.mlir.constant(29 : i32) : i32
  %2 = llvm.mlir.constant(-784568073 : i32) : i32
  %3 = llvm.mlir.constant(1874836915 : i32) : i32
  %4 = llvm.mlir.constant(221 : i32) : i32
  %5 = llvm.mlir.constant(1 : i32) : i32
  %6 = llvm.mlir.constant(1533579450 : i32) : i32
  %7 = llvm.mlir.constant(-2147483648 : i32) : i32
  %8 = llvm.mlir.constant(749011377 : i32) : i32
  %9 = llvm.and %arg0, %0 : i32
  %10 = llvm.xor %9, %1 : i32
  %11 = llvm.add %10, %2 overflow<nuw> : i32
  %12 = llvm.or %10, %3 : i32
  %13 = llvm.and %10, %4 : i32
  %14 = llvm.xor %13, %3 : i32
  %15 = llvm.xor %12, %14 : i32
  %16 = llvm.shl %15, %5 overflow<nsw,nuw> : i32
  %17 = llvm.sub %11, %16 : i32
  %18 = llvm.add %17, %6 overflow<nsw> : i32
  %19 = llvm.or %18, %7 : i32
  %20 = llvm.xor %19, %8 : i32
  "llvm.return"(%20) : (i32) -> ()
}
]
def foo_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(223 : i32) : i32
  %1 = llvm.mlir.constant(29 : i32) : i32
  %2 = llvm.mlir.constant(1362915575 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.mlir.constant(290 : i32) : i32
  %5 = llvm.mlir.constant(1533579450 : i32) : i32
  %6 = llvm.mlir.constant(749011377 : i32) : i32
  %7 = llvm.and %arg0, %0 : i32
  %8 = llvm.xor %7, %1 : i32
  %9 = llvm.add %8, %2 overflow<nsw,nuw> : i32
  %10 = llvm.shl %8, %3 overflow<nsw,nuw> : i32
  %11 = llvm.and %10, %4 : i32
  %12 = llvm.sub %9, %11 overflow<nsw,nuw> : i32
  %13 = llvm.add %12, %5 overflow<nuw> : i32
  %14 = llvm.xor %13, %6 : i32
  "llvm.return"(%14) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo_proof : foo_before ⊑ foo_after := by
  unfold foo_before foo_after
  simp_alive_peephole
  intros
  ---BEGIN foo
  apply foo_thm
  ---END foo


