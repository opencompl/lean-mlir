import SSA.Projects.InstCombine.tests.proofs.gsignhtesthandhor_proof
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
section gsignhtesthandhor_statements

def test1_before := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg30, %0 : i32
  %2 = llvm.icmp "slt" %arg31, %0 : i32
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.or %arg30, %arg31 : i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
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
^0(%arg24 : i32, %arg25 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "sgt" %arg24, %0 : i32
  %2 = llvm.icmp "sgt" %arg25, %0 : i32
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg24 : i32, %arg25 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg24, %arg25 : i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
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
^0(%arg20 : i32, %arg21 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg20, %0 : i32
  %2 = llvm.icmp "slt" %arg21, %0 : i32
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg20 : i32, %arg21 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.and %arg20, %arg21 : i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
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
^0(%arg16 : i32, %arg17 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "sgt" %arg16, %0 : i32
  %2 = llvm.icmp "sgt" %arg17, %0 : i32
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg16 : i32, %arg17 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg16, %arg17 : i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
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



def test9_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(1073741824 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.and %arg5, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.icmp "sgt" %arg5, %2 : i32
  %6 = llvm.and %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(-1073741824 : i32) : i32
  %1 = llvm.mlir.constant(1073741824 : i32) : i32
  %2 = llvm.and %arg5, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test9_proof : test9_before ⊑ test9_after := by
  unfold test9_before test9_after
  simp_alive_peephole
  intros
  ---BEGIN test9
  apply test9_thm
  ---END test9



def test9_logical_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(1073741824 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.and %arg4, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.icmp "sgt" %arg4, %2 : i32
  %7 = "llvm.select"(%5, %6, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def test9_logical_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(-1073741824 : i32) : i32
  %1 = llvm.mlir.constant(1073741824 : i32) : i32
  %2 = llvm.and %arg4, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test9_logical_proof : test9_logical_before ⊑ test9_logical_after := by
  unfold test9_logical_before test9_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test9_logical
  apply test9_logical_thm
  ---END test9_logical



def test10_before := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(4 : i32) : i32
  %3 = llvm.and %arg3, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.icmp "ult" %arg3, %2 : i32
  %6 = llvm.and %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ult" %arg3, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test10_proof : test10_before ⊑ test10_after := by
  unfold test10_before test10_after
  simp_alive_peephole
  intros
  ---BEGIN test10
  apply test10_thm
  ---END test10



def test10_logical_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(4 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.and %arg2, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.icmp "ult" %arg2, %2 : i32
  %7 = "llvm.select"(%5, %6, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def test10_logical_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ult" %arg2, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test10_logical_proof : test10_logical_before ⊑ test10_logical_after := by
  unfold test10_logical_before test10_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test10_logical
  apply test10_logical_thm
  ---END test10_logical



def test11_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.and %arg1, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.icmp "ugt" %arg1, %2 : i32
  %6 = llvm.or %4, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "ugt" %arg1, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test11_proof : test11_before ⊑ test11_after := by
  unfold test11_before test11_after
  simp_alive_peephole
  intros
  ---BEGIN test11
  apply test11_thm
  ---END test11



def test11_logical_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.and %arg0, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.icmp "ugt" %arg0, %2 : i32
  %7 = "llvm.select"(%5, %3, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def test11_logical_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "ugt" %arg0, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test11_logical_proof : test11_logical_before ⊑ test11_logical_after := by
  unfold test11_logical_before test11_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test11_logical
  apply test11_logical_thm
  ---END test11_logical


