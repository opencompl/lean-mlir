import SSA.Projects.InstCombine.tests.LLVM.g2010h11h01hlshrhmask_proof
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
section g2010h11h01hlshrhmask_statements
                                                    
def foo_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 84 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = -118 : i8}> : () -> i8
  %3 = "llvm.mlir.constant"() <{value = 33 : i8}> : () -> i8
  %4 = "llvm.mlir.constant"() <{value = -88 : i8}> : () -> i8
  %5 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %6 = llvm.shl %arg0, %0 : i8
  %7 = llvm.and %arg1, %1 : i8
  %8 = llvm.and %arg1, %2 : i8
  %9 = llvm.and %arg1, %3 : i8
  %10 = llvm.sub %4, %7 : i8
  %11 = llvm.and %10, %1 : i8
  %12 = llvm.or %9, %11 : i8
  %13 = llvm.xor %6, %8 : i8
  %14 = llvm.or %12, %13 : i8
  %15 = llvm.lshr %13, %0 : i8
  %16 = llvm.shl %15, %5 : i8
  %17 = llvm.xor %16, %14 : i8
  "llvm.return"(%17) : (i8) -> ()
}
]
def foo_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 84 : i8}> : () -> i8
  %2 = "llvm.mlir.constant"() <{value = -118 : i8}> : () -> i8
  %3 = "llvm.mlir.constant"() <{value = 33 : i8}> : () -> i8
  %4 = "llvm.mlir.constant"() <{value = 40 : i8}> : () -> i8
  %5 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %6 = "llvm.mlir.constant"() <{value = 32 : i8}> : () -> i8
  %7 = llvm.shl %arg0, %0 : i8
  %8 = llvm.and %arg1, %1 : i8
  %9 = llvm.and %arg1, %2 : i8
  %10 = llvm.and %arg1, %3 : i8
  %11 = llvm.sub %4, %8 : i8
  %12 = llvm.and %11, %1 : i8
  %13 = llvm.or %10, %12 : i8
  %14 = llvm.xor %7, %9 : i8
  %15 = llvm.or %13, %14 : i8
  %16 = llvm.lshr %14, %5 : i8
  %17 = llvm.and %16, %6 : i8
  %18 = llvm.xor %17, %15 : i8
  "llvm.return"(%18) : (i8) -> ()
}
]
theorem foo_proof : foo_before ⊑ foo_after := by
  unfold foo_before foo_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN foo
  apply foo_thm
  ---END foo


