import SSA.Projects.InstCombine.lean.g2004h02h23hShiftShiftOverflow_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open MLIR AST
open Std (BitVec)
open Ctxt (Var)


set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false

def test_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 17 : i32}> : () -> i32
  %1 = llvm.ashr %arg0, %0 : i32
  %2 = llvm.ashr %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %1 = llvm.ashr %arg0, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test_proof : test_before ⊑ test_after := by
  unfold test_before test_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test
  apply test_thm
  ---END test



def test2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 17 : i32}> : () -> i32
  %1 = llvm.shl %arg0, %0 : i32
  %2 = llvm.shl %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN test2
  apply test2_thm
  ---END test2
