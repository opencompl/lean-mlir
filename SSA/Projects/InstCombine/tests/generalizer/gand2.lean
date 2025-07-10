import SSA.Projects.InstCombine.tests.proofs.gand2_proof
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
section gand2_statements

def test2_before := [llvm|
{
^0(%arg30 : i1, %arg31 : i1):
  %0 = llvm.and %arg30, %arg31 : i1
  %1 = llvm.and %0, %arg30 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg30 : i1, %arg31 : i1):
  %0 = llvm.and %arg30, %arg31 : i1
  "llvm.return"(%0) : (i1) -> ()
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



def test2_logical_before := [llvm|
{
^0(%arg28 : i1, %arg29 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg28, %arg29, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = "llvm.select"(%1, %arg28, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def test2_logical_after := [llvm|
{
^0(%arg28 : i1, %arg29 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg28, %arg29, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test2_logical_proof : test2_logical_before ⊑ test2_logical_after := by
  unfold test2_logical_before test2_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test2_logical
  apply test2_logical_thm
  ---END test2_logical



def test3_before := [llvm|
{
^0(%arg26 : i32, %arg27 : i32):
  %0 = llvm.and %arg26, %arg27 : i32
  %1 = llvm.and %arg27, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg26 : i32, %arg27 : i32):
  %0 = llvm.and %arg26, %arg27 : i32
  "llvm.return"(%0) : (i32) -> ()
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



def test7_before := [llvm|
{
^0(%arg24 : i32, %arg25 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.icmp "slt" %arg24, %0 : i32
  %3 = llvm.icmp "sgt" %arg24, %1 : i32
  %4 = llvm.and %2, %arg25 : i1
  %5 = llvm.and %4, %3 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg24 : i32, %arg25 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg24, %0 : i32
  %2 = llvm.and %1, %arg25 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test7_proof : test7_before ⊑ test7_after := by
  unfold test7_before test7_after
  simp_alive_peephole
  intros
  ---BEGIN test7
  apply test7_thm
  ---END test7



def test7_logical_before := [llvm|
{
^0(%arg22 : i32, %arg23 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "slt" %arg22, %0 : i32
  %4 = llvm.icmp "sgt" %arg22, %1 : i32
  %5 = "llvm.select"(%3, %arg23, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = "llvm.select"(%5, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def test7_logical_after := [llvm|
{
^0(%arg22 : i32, %arg23 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "eq" %arg22, %0 : i32
  %3 = "llvm.select"(%2, %arg23, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test7_logical_proof : test7_logical_before ⊑ test7_logical_after := by
  unfold test7_logical_before test7_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test7_logical
  apply test7_logical_thm
  ---END test7_logical



def test8_before := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(14 : i32) : i32
  %2 = llvm.icmp "ne" %arg21, %0 : i32
  %3 = llvm.icmp "ult" %arg21, %1 : i32
  %4 = llvm.and %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(13 : i32) : i32
  %2 = llvm.add %arg21, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test8_proof : test8_before ⊑ test8_after := by
  unfold test8_before test8_after
  simp_alive_peephole
  intros
  ---BEGIN test8
  apply test8_thm
  ---END test8



def test8_logical_before := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(14 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "ne" %arg20, %0 : i32
  %4 = llvm.icmp "ult" %arg20, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def test8_logical_after := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(13 : i32) : i32
  %2 = llvm.add %arg20, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test8_logical_proof : test8_logical_before ⊑ test8_logical_after := by
  unfold test8_logical_before test8_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test8_logical
  apply test8_logical_thm
  ---END test8_logical



def test9_before := [llvm|
{
^0(%arg18 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = llvm.sub %0, %arg18 overflow<nsw> : i64
  %3 = llvm.and %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg18 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.and %arg18, %0 : i64
  "llvm.return"(%1) : (i64) -> ()
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



def test10_before := [llvm|
{
^0(%arg16 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = llvm.sub %0, %arg16 overflow<nsw> : i64
  %3 = llvm.and %2, %1 : i64
  %4 = llvm.add %2, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg16 : i64):
  %0 = llvm.mlir.constant(-2) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.and %arg16, %0 : i64
  %3 = llvm.sub %1, %2 : i64
  "llvm.return"(%3) : (i64) -> ()
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



def and1_shl1_is_cmp_eq_0_before := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %0, %arg15 : i8
  %2 = llvm.and %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def and1_shl1_is_cmp_eq_0_after := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg15, %0 : i8
  %2 = llvm.zext %1 : i1 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and1_shl1_is_cmp_eq_0_proof : and1_shl1_is_cmp_eq_0_before ⊑ and1_shl1_is_cmp_eq_0_after := by
  unfold and1_shl1_is_cmp_eq_0_before and1_shl1_is_cmp_eq_0_after
  simp_alive_peephole
  intros
  ---BEGIN and1_shl1_is_cmp_eq_0
  apply and1_shl1_is_cmp_eq_0_thm
  ---END and1_shl1_is_cmp_eq_0



def and1_shl1_is_cmp_eq_0_multiuse_before := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %0, %arg14 : i8
  %2 = llvm.and %1, %0 : i8
  %3 = llvm.add %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def and1_shl1_is_cmp_eq_0_multiuse_after := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %0, %arg14 overflow<nuw> : i8
  %2 = llvm.and %1, %0 : i8
  %3 = llvm.add %1, %2 overflow<nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and1_shl1_is_cmp_eq_0_multiuse_proof : and1_shl1_is_cmp_eq_0_multiuse_before ⊑ and1_shl1_is_cmp_eq_0_multiuse_after := by
  unfold and1_shl1_is_cmp_eq_0_multiuse_before and1_shl1_is_cmp_eq_0_multiuse_after
  simp_alive_peephole
  intros
  ---BEGIN and1_shl1_is_cmp_eq_0_multiuse
  apply and1_shl1_is_cmp_eq_0_multiuse_thm
  ---END and1_shl1_is_cmp_eq_0_multiuse



def and1_lshr1_is_cmp_eq_0_before := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.lshr %0, %arg11 : i8
  %2 = llvm.and %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def and1_lshr1_is_cmp_eq_0_after := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.lshr %0, %arg11 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and1_lshr1_is_cmp_eq_0_proof : and1_lshr1_is_cmp_eq_0_before ⊑ and1_lshr1_is_cmp_eq_0_after := by
  unfold and1_lshr1_is_cmp_eq_0_before and1_lshr1_is_cmp_eq_0_after
  simp_alive_peephole
  intros
  ---BEGIN and1_lshr1_is_cmp_eq_0
  apply and1_lshr1_is_cmp_eq_0_thm
  ---END and1_lshr1_is_cmp_eq_0



def and1_lshr1_is_cmp_eq_0_multiuse_before := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.lshr %0, %arg10 : i8
  %2 = llvm.and %1, %0 : i8
  %3 = llvm.add %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def and1_lshr1_is_cmp_eq_0_multiuse_after := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.lshr %0, %arg10 : i8
  %2 = llvm.shl %1, %0 overflow<nsw,nuw> : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and1_lshr1_is_cmp_eq_0_multiuse_proof : and1_lshr1_is_cmp_eq_0_multiuse_before ⊑ and1_lshr1_is_cmp_eq_0_multiuse_after := by
  unfold and1_lshr1_is_cmp_eq_0_multiuse_before and1_lshr1_is_cmp_eq_0_multiuse_after
  simp_alive_peephole
  intros
  ---BEGIN and1_lshr1_is_cmp_eq_0_multiuse
  apply and1_lshr1_is_cmp_eq_0_multiuse_thm
  ---END and1_lshr1_is_cmp_eq_0_multiuse



def test11_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.shl %arg6, %0 : i32
  %3 = llvm.add %2, %arg7 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.mul %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.shl %arg6, %0 : i32
  %3 = llvm.and %arg7, %1 : i32
  %4 = llvm.mul %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
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



def test12_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.shl %arg4, %0 : i32
  %3 = llvm.add %arg5, %2 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.mul %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.shl %arg4, %0 : i32
  %3 = llvm.and %arg5, %1 : i32
  %4 = llvm.mul %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test12_proof : test12_before ⊑ test12_after := by
  unfold test12_before test12_after
  simp_alive_peephole
  intros
  ---BEGIN test12
  apply test12_thm
  ---END test12



def test13_before := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.shl %arg2, %0 : i32
  %3 = llvm.sub %arg3, %2 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.mul %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.shl %arg2, %0 : i32
  %3 = llvm.and %arg3, %1 : i32
  %4 = llvm.mul %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test13_proof : test13_before ⊑ test13_after := by
  unfold test13_before test13_after
  simp_alive_peephole
  intros
  ---BEGIN test13
  apply test13_thm
  ---END test13



def test14_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.sub %2, %arg1 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.mul %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(128 : i32) : i32
  %3 = llvm.shl %arg0, %0 : i32
  %4 = llvm.sub %1, %arg1 : i32
  %5 = llvm.and %4, %2 : i32
  %6 = llvm.mul %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test14_proof : test14_before ⊑ test14_after := by
  unfold test14_before test14_after
  simp_alive_peephole
  intros
  ---BEGIN test14
  apply test14_thm
  ---END test14


