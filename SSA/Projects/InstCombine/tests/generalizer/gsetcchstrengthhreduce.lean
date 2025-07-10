import SSA.Projects.InstCombine.tests.proofs.gsetcchstrengthhreduce_proof
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
section gsetcchstrengthhreduce_statements

def test1_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "uge" %arg4, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg4, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  apply test1_thm
  ---END test1



def test2_before := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ugt" %arg3, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg3, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  intros
  ---BEGIN test2
  apply test2_thm
  ---END test2



def test3_before := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(-127 : i8) : i8
  %1 = llvm.icmp "sge" %arg2, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "ne" %arg2, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  intros
  ---BEGIN test3
  apply test3_thm
  ---END test3



def test4_before := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(126 : i8) : i8
  %1 = llvm.icmp "sle" %arg1, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "ne" %arg1, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  intros
  ---BEGIN test4
  apply test4_thm
  ---END test4



def test5_before := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "slt" %arg0, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "ne" %arg0, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  intros
  ---BEGIN test5
  apply test5_thm
  ---END test5


