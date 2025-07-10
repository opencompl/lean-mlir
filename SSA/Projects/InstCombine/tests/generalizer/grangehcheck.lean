import SSA.Projects.InstCombine.tests.proofs.grangehcheck_proof
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
section grangehcheck_statements

def test_and1_before := [llvm|
{
^0(%arg52 : i32, %arg53 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg53, %0 : i32
  %3 = llvm.icmp "sge" %arg52, %1 : i32
  %4 = llvm.icmp "slt" %arg52, %2 : i32
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_and1_after := [llvm|
{
^0(%arg52 : i32, %arg53 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.and %arg53, %0 : i32
  %2 = llvm.icmp "ult" %arg52, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_and1_proof : test_and1_before ⊑ test_and1_after := by
  unfold test_and1_before test_and1_after
  simp_alive_peephole
  intros
  ---BEGIN test_and1
  apply test_and1_thm
  ---END test_and1



def test_and1_logical_before := [llvm|
{
^0(%arg50 : i32, %arg51 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.and %arg51, %0 : i32
  %4 = llvm.icmp "sge" %arg50, %1 : i32
  %5 = llvm.icmp "slt" %arg50, %3 : i32
  %6 = "llvm.select"(%4, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test_and1_logical_after := [llvm|
{
^0(%arg50 : i32, %arg51 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.and %arg51, %0 : i32
  %4 = llvm.icmp "sgt" %arg50, %1 : i32
  %5 = llvm.icmp "slt" %arg50, %3 : i32
  %6 = "llvm.select"(%4, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_and1_logical_proof : test_and1_logical_before ⊑ test_and1_logical_after := by
  unfold test_and1_logical_before test_and1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test_and1_logical
  apply test_and1_logical_thm
  ---END test_and1_logical



def test_and2_before := [llvm|
{
^0(%arg48 : i32, %arg49 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg49, %0 : i32
  %3 = llvm.icmp "sgt" %arg48, %1 : i32
  %4 = llvm.icmp "sle" %arg48, %2 : i32
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_and2_after := [llvm|
{
^0(%arg48 : i32, %arg49 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.and %arg49, %0 : i32
  %2 = llvm.icmp "ule" %arg48, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_and2_proof : test_and2_before ⊑ test_and2_after := by
  unfold test_and2_before test_and2_after
  simp_alive_peephole
  intros
  ---BEGIN test_and2
  apply test_and2_thm
  ---END test_and2



def test_and3_before := [llvm|
{
^0(%arg44 : i32, %arg45 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg45, %0 : i32
  %3 = llvm.icmp "sgt" %2, %arg44 : i32
  %4 = llvm.icmp "sge" %arg44, %1 : i32
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_and3_after := [llvm|
{
^0(%arg44 : i32, %arg45 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.and %arg45, %0 : i32
  %2 = llvm.icmp "ult" %arg44, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_and3_proof : test_and3_before ⊑ test_and3_after := by
  unfold test_and3_before test_and3_after
  simp_alive_peephole
  intros
  ---BEGIN test_and3
  apply test_and3_thm
  ---END test_and3



def test_and3_logical_before := [llvm|
{
^0(%arg42 : i32, %arg43 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.and %arg43, %0 : i32
  %4 = llvm.icmp "sgt" %3, %arg42 : i32
  %5 = llvm.icmp "sge" %arg42, %1 : i32
  %6 = "llvm.select"(%4, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test_and3_logical_after := [llvm|
{
^0(%arg42 : i32, %arg43 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.and %arg43, %0 : i32
  %2 = llvm.icmp "ult" %arg42, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_and3_logical_proof : test_and3_logical_before ⊑ test_and3_logical_after := by
  unfold test_and3_logical_before test_and3_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test_and3_logical
  apply test_and3_logical_thm
  ---END test_and3_logical



def test_and4_before := [llvm|
{
^0(%arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg41, %0 : i32
  %3 = llvm.icmp "sge" %2, %arg40 : i32
  %4 = llvm.icmp "sge" %arg40, %1 : i32
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_and4_after := [llvm|
{
^0(%arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.and %arg41, %0 : i32
  %2 = llvm.icmp "ule" %arg40, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_and4_proof : test_and4_before ⊑ test_and4_after := by
  unfold test_and4_before test_and4_after
  simp_alive_peephole
  intros
  ---BEGIN test_and4
  apply test_and4_thm
  ---END test_and4



def test_and4_logical_before := [llvm|
{
^0(%arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.and %arg39, %0 : i32
  %4 = llvm.icmp "sge" %3, %arg38 : i32
  %5 = llvm.icmp "sge" %arg38, %1 : i32
  %6 = "llvm.select"(%4, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test_and4_logical_after := [llvm|
{
^0(%arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.and %arg39, %0 : i32
  %2 = llvm.icmp "ule" %arg38, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_and4_logical_proof : test_and4_logical_before ⊑ test_and4_logical_after := by
  unfold test_and4_logical_before test_and4_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test_and4_logical
  apply test_and4_logical_thm
  ---END test_and4_logical



def test_or1_before := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg37, %0 : i32
  %3 = llvm.icmp "slt" %arg36, %1 : i32
  %4 = llvm.icmp "sge" %arg36, %2 : i32
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_or1_after := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.and %arg37, %0 : i32
  %2 = llvm.icmp "uge" %arg36, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_or1_proof : test_or1_before ⊑ test_or1_after := by
  unfold test_or1_before test_or1_after
  simp_alive_peephole
  intros
  ---BEGIN test_or1
  apply test_or1_thm
  ---END test_or1



def test_or2_before := [llvm|
{
^0(%arg32 : i32, %arg33 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg33, %0 : i32
  %3 = llvm.icmp "sle" %arg32, %1 : i32
  %4 = llvm.icmp "sgt" %arg32, %2 : i32
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_or2_after := [llvm|
{
^0(%arg32 : i32, %arg33 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.and %arg33, %0 : i32
  %2 = llvm.icmp "ugt" %arg32, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_or2_proof : test_or2_before ⊑ test_or2_after := by
  unfold test_or2_before test_or2_after
  simp_alive_peephole
  intros
  ---BEGIN test_or2
  apply test_or2_thm
  ---END test_or2



def test_or2_logical_before := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.and %arg31, %0 : i32
  %4 = llvm.icmp "sle" %arg30, %1 : i32
  %5 = llvm.icmp "sgt" %arg30, %3 : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test_or2_logical_after := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.and %arg31, %0 : i32
  %4 = llvm.icmp "slt" %arg30, %1 : i32
  %5 = llvm.icmp "sgt" %arg30, %3 : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_or2_logical_proof : test_or2_logical_before ⊑ test_or2_logical_after := by
  unfold test_or2_logical_before test_or2_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test_or2_logical
  apply test_or2_logical_thm
  ---END test_or2_logical



def test_or3_before := [llvm|
{
^0(%arg28 : i32, %arg29 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg29, %0 : i32
  %3 = llvm.icmp "sle" %2, %arg28 : i32
  %4 = llvm.icmp "slt" %arg28, %1 : i32
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_or3_after := [llvm|
{
^0(%arg28 : i32, %arg29 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.and %arg29, %0 : i32
  %2 = llvm.icmp "uge" %arg28, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_or3_proof : test_or3_before ⊑ test_or3_after := by
  unfold test_or3_before test_or3_after
  simp_alive_peephole
  intros
  ---BEGIN test_or3
  apply test_or3_thm
  ---END test_or3



def test_or3_logical_before := [llvm|
{
^0(%arg26 : i32, %arg27 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.and %arg27, %0 : i32
  %4 = llvm.icmp "sle" %3, %arg26 : i32
  %5 = llvm.icmp "slt" %arg26, %1 : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test_or3_logical_after := [llvm|
{
^0(%arg26 : i32, %arg27 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.and %arg27, %0 : i32
  %2 = llvm.icmp "uge" %arg26, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_or3_logical_proof : test_or3_logical_before ⊑ test_or3_logical_after := by
  unfold test_or3_logical_before test_or3_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test_or3_logical
  apply test_or3_logical_thm
  ---END test_or3_logical



def test_or4_before := [llvm|
{
^0(%arg24 : i32, %arg25 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg25, %0 : i32
  %3 = llvm.icmp "slt" %2, %arg24 : i32
  %4 = llvm.icmp "slt" %arg24, %1 : i32
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test_or4_after := [llvm|
{
^0(%arg24 : i32, %arg25 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.and %arg25, %0 : i32
  %2 = llvm.icmp "ugt" %arg24, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_or4_proof : test_or4_before ⊑ test_or4_after := by
  unfold test_or4_before test_or4_after
  simp_alive_peephole
  intros
  ---BEGIN test_or4
  apply test_or4_thm
  ---END test_or4



def test_or4_logical_before := [llvm|
{
^0(%arg22 : i32, %arg23 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.and %arg23, %0 : i32
  %4 = llvm.icmp "slt" %3, %arg22 : i32
  %5 = llvm.icmp "slt" %arg22, %1 : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test_or4_logical_after := [llvm|
{
^0(%arg22 : i32, %arg23 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.and %arg23, %0 : i32
  %2 = llvm.icmp "ugt" %arg22, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_or4_logical_proof : test_or4_logical_before ⊑ test_or4_logical_after := by
  unfold test_or4_logical_before test_or4_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test_or4_logical
  apply test_or4_logical_thm
  ---END test_or4_logical



def negative1_logical_before := [llvm|
{
^0(%arg18 : i32, %arg19 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.and %arg19, %0 : i32
  %4 = llvm.icmp "slt" %arg18, %3 : i32
  %5 = llvm.icmp "sgt" %arg18, %1 : i32
  %6 = "llvm.select"(%4, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def negative1_logical_after := [llvm|
{
^0(%arg18 : i32, %arg19 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg19, %0 : i32
  %3 = llvm.icmp "slt" %arg18, %2 : i32
  %4 = llvm.icmp "sgt" %arg18, %1 : i32
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative1_logical_proof : negative1_logical_before ⊑ negative1_logical_after := by
  unfold negative1_logical_before negative1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN negative1_logical
  apply negative1_logical_thm
  ---END negative1_logical



def negative2_before := [llvm|
{
^0(%arg16 : i32, %arg17 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg16, %arg17 : i32
  %2 = llvm.icmp "sge" %arg16, %0 : i32
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def negative2_after := [llvm|
{
^0(%arg16 : i32, %arg17 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "slt" %arg16, %arg17 : i32
  %2 = llvm.icmp "sgt" %arg16, %0 : i32
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative2_proof : negative2_before ⊑ negative2_after := by
  unfold negative2_before negative2_after
  simp_alive_peephole
  intros
  ---BEGIN negative2
  apply negative2_thm
  ---END negative2



def negative2_logical_before := [llvm|
{
^0(%arg14 : i32, %arg15 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "slt" %arg14, %arg15 : i32
  %3 = llvm.icmp "sge" %arg14, %0 : i32
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def negative2_logical_after := [llvm|
{
^0(%arg14 : i32, %arg15 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "slt" %arg14, %arg15 : i32
  %2 = llvm.icmp "sgt" %arg14, %0 : i32
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative2_logical_proof : negative2_logical_before ⊑ negative2_logical_after := by
  unfold negative2_logical_before negative2_logical_after
  simp_alive_peephole
  intros
  ---BEGIN negative2_logical
  apply negative2_logical_thm
  ---END negative2_logical



def negative3_before := [llvm|
{
^0(%arg11 : i32, %arg12 : i32, %arg13 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg13, %0 : i32
  %3 = llvm.icmp "slt" %arg11, %2 : i32
  %4 = llvm.icmp "sge" %arg12, %1 : i32
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def negative3_after := [llvm|
{
^0(%arg11 : i32, %arg12 : i32, %arg13 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg13, %0 : i32
  %3 = llvm.icmp "slt" %arg11, %2 : i32
  %4 = llvm.icmp "sgt" %arg12, %1 : i32
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative3_proof : negative3_before ⊑ negative3_after := by
  unfold negative3_before negative3_after
  simp_alive_peephole
  intros
  ---BEGIN negative3
  apply negative3_thm
  ---END negative3



def negative3_logical_before := [llvm|
{
^0(%arg8 : i32, %arg9 : i32, %arg10 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.and %arg10, %0 : i32
  %4 = llvm.icmp "slt" %arg8, %3 : i32
  %5 = llvm.icmp "sge" %arg9, %1 : i32
  %6 = "llvm.select"(%4, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def negative3_logical_after := [llvm|
{
^0(%arg8 : i32, %arg9 : i32, %arg10 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.and %arg10, %0 : i32
  %4 = llvm.icmp "slt" %arg8, %3 : i32
  %5 = llvm.icmp "sgt" %arg9, %1 : i32
  %6 = "llvm.select"(%4, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative3_logical_proof : negative3_logical_before ⊑ negative3_logical_after := by
  unfold negative3_logical_before negative3_logical_after
  simp_alive_peephole
  intros
  ---BEGIN negative3_logical
  apply negative3_logical_thm
  ---END negative3_logical



def negative4_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg7, %0 : i32
  %3 = llvm.icmp "ne" %arg6, %2 : i32
  %4 = llvm.icmp "sge" %arg6, %1 : i32
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def negative4_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg7, %0 : i32
  %3 = llvm.icmp "ne" %arg6, %2 : i32
  %4 = llvm.icmp "sgt" %arg6, %1 : i32
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative4_proof : negative4_before ⊑ negative4_after := by
  unfold negative4_before negative4_after
  simp_alive_peephole
  intros
  ---BEGIN negative4
  apply negative4_thm
  ---END negative4



def negative4_logical_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.and %arg5, %0 : i32
  %4 = llvm.icmp "ne" %arg4, %3 : i32
  %5 = llvm.icmp "sge" %arg4, %1 : i32
  %6 = "llvm.select"(%4, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def negative4_logical_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg5, %0 : i32
  %3 = llvm.icmp "ne" %arg4, %2 : i32
  %4 = llvm.icmp "sgt" %arg4, %1 : i32
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative4_logical_proof : negative4_logical_before ⊑ negative4_logical_after := by
  unfold negative4_logical_before negative4_logical_after
  simp_alive_peephole
  intros
  ---BEGIN negative4_logical
  apply negative4_logical_thm
  ---END negative4_logical



def negative5_before := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg3, %0 : i32
  %3 = llvm.icmp "slt" %arg2, %2 : i32
  %4 = llvm.icmp "sge" %arg2, %1 : i32
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def negative5_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative5_proof : negative5_before ⊑ negative5_after := by
  unfold negative5_before negative5_after
  simp_alive_peephole
  intros
  ---BEGIN negative5
  apply negative5_thm
  ---END negative5



def negative5_logical_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.and %arg1, %0 : i32
  %4 = llvm.icmp "slt" %arg0, %3 : i32
  %5 = llvm.icmp "sge" %arg0, %1 : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def negative5_logical_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative5_logical_proof : negative5_logical_before ⊑ negative5_logical_after := by
  unfold negative5_logical_before negative5_logical_after
  simp_alive_peephole
  intros
  ---BEGIN negative5_logical
  apply negative5_logical_thm
  ---END negative5_logical


