import SSA.Projects.InstCombine.tests.proofs.gshifthdirectionhinhbithtest_proof
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
section gshifthdirectionhinhbithtest_statements

def t7_twoshifts2_before := [llvm|
{
^0(%arg28 : i32, %arg29 : i32, %arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg29 : i32
  %3 = llvm.shl %arg30, %arg31 : i32
  %4 = llvm.and %3, %2 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def t7_twoshifts2_after := [llvm|
{
^0(%arg28 : i32, %arg29 : i32, %arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg29 overflow<nuw> : i32
  %3 = llvm.shl %arg30, %arg31 : i32
  %4 = llvm.and %3, %2 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t7_twoshifts2_proof : t7_twoshifts2_before ⊑ t7_twoshifts2_after := by
  unfold t7_twoshifts2_before t7_twoshifts2_after
  simp_alive_peephole
  intros
  ---BEGIN t7_twoshifts2
  apply t7_twoshifts2_thm
  ---END t7_twoshifts2



def t8_twoshifts3_before := [llvm|
{
^0(%arg24 : i32, %arg25 : i32, %arg26 : i32, %arg27 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %arg24, %arg25 : i32
  %3 = llvm.shl %0, %arg27 : i32
  %4 = llvm.and %3, %2 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
def t8_twoshifts3_after := [llvm|
{
^0(%arg24 : i32, %arg25 : i32, %arg26 : i32, %arg27 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %arg24, %arg25 : i32
  %3 = llvm.shl %0, %arg27 overflow<nuw> : i32
  %4 = llvm.and %3, %2 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t8_twoshifts3_proof : t8_twoshifts3_before ⊑ t8_twoshifts3_after := by
  unfold t8_twoshifts3_before t8_twoshifts3_after
  simp_alive_peephole
  intros
  ---BEGIN t8_twoshifts3
  apply t8_twoshifts3_thm
  ---END t8_twoshifts3



def t12_shift_of_const0_before := [llvm|
{
^0(%arg12 : i32, %arg13 : i32, %arg14 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg13 : i32
  %3 = llvm.and %2, %arg14 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def t12_shift_of_const0_after := [llvm|
{
^0(%arg12 : i32, %arg13 : i32, %arg14 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg13 overflow<nuw> : i32
  %3 = llvm.and %2, %arg14 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t12_shift_of_const0_proof : t12_shift_of_const0_before ⊑ t12_shift_of_const0_after := by
  unfold t12_shift_of_const0_before t12_shift_of_const0_after
  simp_alive_peephole
  intros
  ---BEGIN t12_shift_of_const0
  apply t12_shift_of_const0_thm
  ---END t12_shift_of_const0



def t14_and_with_const0_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32, %arg8 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %arg6, %arg7 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def t14_and_with_const0_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32, %arg8 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %0, %arg7 : i32
  %3 = llvm.and %arg6, %2 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t14_and_with_const0_proof : t14_and_with_const0_before ⊑ t14_and_with_const0_after := by
  unfold t14_and_with_const0_before t14_and_with_const0_after
  simp_alive_peephole
  intros
  ---BEGIN t14_and_with_const0
  apply t14_and_with_const0_thm
  ---END t14_and_with_const0



def t15_and_with_const1_before := [llvm|
{
^0(%arg3 : i32, %arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg3, %arg4 : i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def t15_and_with_const1_after := [llvm|
{
^0(%arg3 : i32, %arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.shl %0, %arg4 overflow<nuw> : i32
  %3 = llvm.and %arg3, %2 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t15_and_with_const1_proof : t15_and_with_const1_before ⊑ t15_and_with_const1_after := by
  unfold t15_and_with_const1_before t15_and_with_const1_after
  simp_alive_peephole
  intros
  ---BEGIN t15_and_with_const1
  apply t15_and_with_const1_thm
  ---END t15_and_with_const1


