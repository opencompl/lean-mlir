import SSA.Projects.InstCombine.tests.proofs.gpreventhcmphmerge_proof
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
section gpreventhcmphmerge_statements

def test1_before := [llvm|
{
^0(%arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(10 : i32) : i32
  %2 = llvm.xor %arg8, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.icmp "eq" %2, %arg9 : i32
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = llvm.icmp "eq" %arg8, %0 : i32
  %3 = llvm.xor %arg8, %arg9 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.or %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
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



def test1_logical_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(10 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.xor %arg6, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.icmp "eq" %3, %arg7 : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test1_logical_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "eq" %arg6, %0 : i32
  %4 = llvm.xor %arg6, %arg7 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%3, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_logical_proof : test1_logical_before ⊑ test1_logical_after := by
  unfold test1_logical_before test1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test1_logical
  apply test1_logical_thm
  ---END test1_logical



def test2_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(32 : i32) : i32
  %2 = llvm.xor %arg4, %arg5 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = llvm.icmp "eq" %2, %1 : i32
  %5 = llvm.xor %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.xor %arg4, %arg5 : i32
  %2 = llvm.icmp "eq" %arg4, %arg5 : i32
  %3 = llvm.icmp "eq" %1, %0 : i32
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
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
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.sub %arg2, %arg3 overflow<nsw> : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = llvm.icmp "eq" %2, %1 : i32
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.sub %arg2, %arg3 overflow<nsw> : i32
  %2 = llvm.icmp "eq" %arg2, %arg3 : i32
  %3 = llvm.icmp "eq" %1, %0 : i32
  %4 = llvm.or %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
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



def test3_logical_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.sub %arg0, %arg1 overflow<nsw> : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = llvm.icmp "eq" %3, %1 : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test3_logical_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.sub %arg0, %arg1 overflow<nsw> : i32
  %3 = llvm.icmp "eq" %arg0, %arg1 : i32
  %4 = llvm.icmp "eq" %2, %0 : i32
  %5 = "llvm.select"(%3, %1, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test3_logical_proof : test3_logical_before ⊑ test3_logical_after := by
  unfold test3_logical_before test3_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test3_logical
  apply test3_logical_thm
  ---END test3_logical


