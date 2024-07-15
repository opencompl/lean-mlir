import SSA.Projects.InstCombine.lean.gpr14365_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def test0_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1431655765 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %3 = llvm.and %arg0, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %4, %2 : i32
  %6 = llvm.add %arg0, %5 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test0_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1431655766 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test0_proof : test0_before ⊑ test0_after := by
  unfold test0_before test0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test0
  apply test0_thm
  ---END test0



def test1_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1431655765 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %3 = llvm.ashr %arg0, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  %6 = llvm.add %5, %0 : i32
  %7 = llvm.add %arg0, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1431655765 : i32}> : () -> i32
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.sub %arg0, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test1
  apply test1_thm
  ---END test1


