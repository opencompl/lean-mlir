import SSA.Projects.InstCombine.tests.proofs.gaddhshlhsdivhtohsrem_proof
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
section gaddhshlhsdivhtohsrem_statements

def addhshlhsdivhscalar0_before := [llvm|
{
^0(%arg19 : i8):
  %0 = llvm.mlir.constant(-4 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.sdiv %arg19, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  %4 = llvm.add %3, %arg19 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def addhshlhsdivhscalar0_after := [llvm|
{
^0(%arg19 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.srem %arg19, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem addhshlhsdivhscalar0_proof : addhshlhsdivhscalar0_before ⊑ addhshlhsdivhscalar0_after := by
  unfold addhshlhsdivhscalar0_before addhshlhsdivhscalar0_after
  simp_alive_peephole
  intros
  ---BEGIN addhshlhsdivhscalar0
  apply addhshlhsdivhscalar0_thm
  ---END addhshlhsdivhscalar0



def addhshlhsdivhscalar1_before := [llvm|
{
^0(%arg18 : i8):
  %0 = llvm.mlir.constant(-64 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.sdiv %arg18, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  %4 = llvm.add %3, %arg18 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def addhshlhsdivhscalar1_after := [llvm|
{
^0(%arg18 : i8):
  %0 = llvm.mlir.constant(64 : i8) : i8
  %1 = llvm.srem %arg18, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem addhshlhsdivhscalar1_proof : addhshlhsdivhscalar1_before ⊑ addhshlhsdivhscalar1_after := by
  unfold addhshlhsdivhscalar1_before addhshlhsdivhscalar1_after
  simp_alive_peephole
  intros
  ---BEGIN addhshlhsdivhscalar1
  apply addhshlhsdivhscalar1_thm
  ---END addhshlhsdivhscalar1



def addhshlhsdivhscalar2_before := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(-1073741824 : i32) : i32
  %1 = llvm.mlir.constant(30 : i32) : i32
  %2 = llvm.sdiv %arg17, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  %4 = llvm.add %3, %arg17 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def addhshlhsdivhscalar2_after := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(1073741824 : i32) : i32
  %1 = llvm.srem %arg17, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem addhshlhsdivhscalar2_proof : addhshlhsdivhscalar2_before ⊑ addhshlhsdivhscalar2_after := by
  unfold addhshlhsdivhscalar2_before addhshlhsdivhscalar2_after
  simp_alive_peephole
  intros
  ---BEGIN addhshlhsdivhscalar2
  apply addhshlhsdivhscalar2_thm
  ---END addhshlhsdivhscalar2



def addhshlhsdivhnegative0_before := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.sdiv %arg8, %0 : i8
  %3 = llvm.shl %2, %1 : i8
  %4 = llvm.add %3, %arg8 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def addhshlhsdivhnegative0_after := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.sdiv %arg8, %0 : i8
  %3 = llvm.shl %2, %1 overflow<nsw> : i8
  %4 = llvm.add %3, %arg8 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem addhshlhsdivhnegative0_proof : addhshlhsdivhnegative0_before ⊑ addhshlhsdivhnegative0_after := by
  unfold addhshlhsdivhnegative0_before addhshlhsdivhnegative0_after
  simp_alive_peephole
  intros
  ---BEGIN addhshlhsdivhnegative0
  apply addhshlhsdivhnegative0_thm
  ---END addhshlhsdivhnegative0



def addhshlhsdivhnegative1_before := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.sdiv %arg7, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  %4 = llvm.add %3, %arg7 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def addhshlhsdivhnegative1_after := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sub %0, %arg7 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem addhshlhsdivhnegative1_proof : addhshlhsdivhnegative1_before ⊑ addhshlhsdivhnegative1_after := by
  unfold addhshlhsdivhnegative1_before addhshlhsdivhnegative1_after
  simp_alive_peephole
  intros
  ---BEGIN addhshlhsdivhnegative1
  apply addhshlhsdivhnegative1_thm
  ---END addhshlhsdivhnegative1



def addhshlhsdivhnegative2_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.sdiv %arg6, %0 : i32
  %3 = llvm.shl %2, %1 : i32
  %4 = llvm.add %3, %arg6 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def addhshlhsdivhnegative2_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.icmp "eq" %arg6, %0 : i32
  %3 = "llvm.select"(%2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.add %3, %arg6 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem addhshlhsdivhnegative2_proof : addhshlhsdivhnegative2_before ⊑ addhshlhsdivhnegative2_after := by
  unfold addhshlhsdivhnegative2_before addhshlhsdivhnegative2_after
  simp_alive_peephole
  intros
  ---BEGIN addhshlhsdivhnegative2
  apply addhshlhsdivhnegative2_thm
  ---END addhshlhsdivhnegative2


