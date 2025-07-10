import SSA.Projects.InstCombine.tests.proofs.gset_proof
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
section gset_statements

def test3_before := [llvm|
{
^0(%arg51 : i32):
  %0 = llvm.icmp "slt" %arg51, %arg51 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg51 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
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
^0(%arg50 : i32):
  %0 = llvm.icmp "sgt" %arg50, %arg50 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg50 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
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
^0(%arg49 : i32):
  %0 = llvm.icmp "sle" %arg49, %arg49 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg49 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
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



def test6_before := [llvm|
{
^0(%arg48 : i32):
  %0 = llvm.icmp "sge" %arg48, %arg48 : i32
  "llvm.return"(%0) : (i1) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg48 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test6_proof : test6_before ⊑ test6_after := by
  unfold test6_before test6_after
  simp_alive_peephole
  intros
  ---BEGIN test6
  apply test6_thm
  ---END test6



def test7_before := [llvm|
{
^0(%arg47 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "uge" %arg47, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg47 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
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



def test8_before := [llvm|
{
^0(%arg46 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ult" %arg46, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg46 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
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



def test9_before := [llvm|
{
^0(%arg45 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.icmp "ult" %arg45, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg45 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
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
^0(%arg44 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "ugt" %arg44, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg44 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
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



def test11_before := [llvm|
{
^0(%arg43 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "ule" %arg43, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg43 : i1):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
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
^0(%arg42 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.icmp "uge" %arg42, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg42 : i1):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
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
^0(%arg40 : i1, %arg41 : i1):
  %0 = llvm.icmp "uge" %arg40, %arg41 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg40 : i1, %arg41 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg41, %0 : i1
  %2 = llvm.or %arg40, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
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
^0(%arg36 : i1, %arg37 : i1):
  %0 = llvm.icmp "eq" %arg36, %arg37 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
def test14_after := [llvm|
{
^0(%arg36 : i1, %arg37 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg36, %arg37 : i1
  %2 = llvm.xor %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
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



def bool_eq0_before := [llvm|
{
^0(%arg33 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "sgt" %arg33, %0 : i64
  %4 = llvm.icmp "eq" %arg33, %1 : i64
  %5 = llvm.icmp "eq" %4, %2 : i1
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def bool_eq0_after := [llvm|
{
^0(%arg33 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.icmp "sgt" %arg33, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bool_eq0_proof : bool_eq0_before ⊑ bool_eq0_after := by
  unfold bool_eq0_before bool_eq0_after
  simp_alive_peephole
  intros
  ---BEGIN bool_eq0
  apply bool_eq0_thm
  ---END bool_eq0



def bool_eq0_logical_before := [llvm|
{
^0(%arg32 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "sgt" %arg32, %0 : i64
  %4 = llvm.icmp "eq" %arg32, %1 : i64
  %5 = llvm.icmp "eq" %4, %2 : i1
  %6 = "llvm.select"(%3, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def bool_eq0_logical_after := [llvm|
{
^0(%arg32 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.icmp "sgt" %arg32, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bool_eq0_logical_proof : bool_eq0_logical_before ⊑ bool_eq0_logical_after := by
  unfold bool_eq0_logical_before bool_eq0_logical_after
  simp_alive_peephole
  intros
  ---BEGIN bool_eq0_logical
  apply bool_eq0_logical_thm
  ---END bool_eq0_logical



def xor_of_icmps_before := [llvm|
{
^0(%arg31 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = llvm.icmp "sgt" %arg31, %0 : i64
  %3 = llvm.icmp "eq" %arg31, %1 : i64
  %4 = llvm.xor %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_of_icmps_after := [llvm|
{
^0(%arg31 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.icmp "sgt" %arg31, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_of_icmps_proof : xor_of_icmps_before ⊑ xor_of_icmps_after := by
  unfold xor_of_icmps_before xor_of_icmps_after
  simp_alive_peephole
  intros
  ---BEGIN xor_of_icmps
  apply xor_of_icmps_thm
  ---END xor_of_icmps



def xor_of_icmps_commute_before := [llvm|
{
^0(%arg30 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.mlir.constant(1) : i64
  %2 = llvm.icmp "sgt" %arg30, %0 : i64
  %3 = llvm.icmp "eq" %arg30, %1 : i64
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_of_icmps_commute_after := [llvm|
{
^0(%arg30 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.icmp "sgt" %arg30, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_of_icmps_commute_proof : xor_of_icmps_commute_before ⊑ xor_of_icmps_commute_after := by
  unfold xor_of_icmps_commute_before xor_of_icmps_commute_after
  simp_alive_peephole
  intros
  ---BEGIN xor_of_icmps_commute
  apply xor_of_icmps_commute_thm
  ---END xor_of_icmps_commute



def xor_of_icmps_to_ne_before := [llvm|
{
^0(%arg29 : i64):
  %0 = llvm.mlir.constant(4) : i64
  %1 = llvm.mlir.constant(6) : i64
  %2 = llvm.icmp "sgt" %arg29, %0 : i64
  %3 = llvm.icmp "slt" %arg29, %1 : i64
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_of_icmps_to_ne_after := [llvm|
{
^0(%arg29 : i64):
  %0 = llvm.mlir.constant(5) : i64
  %1 = llvm.icmp "ne" %arg29, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_of_icmps_to_ne_proof : xor_of_icmps_to_ne_before ⊑ xor_of_icmps_to_ne_after := by
  unfold xor_of_icmps_to_ne_before xor_of_icmps_to_ne_after
  simp_alive_peephole
  intros
  ---BEGIN xor_of_icmps_to_ne
  apply xor_of_icmps_to_ne_thm
  ---END xor_of_icmps_to_ne



def xor_of_icmps_to_ne_commute_before := [llvm|
{
^0(%arg28 : i64):
  %0 = llvm.mlir.constant(4) : i64
  %1 = llvm.mlir.constant(6) : i64
  %2 = llvm.icmp "sgt" %arg28, %0 : i64
  %3 = llvm.icmp "slt" %arg28, %1 : i64
  %4 = llvm.xor %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_of_icmps_to_ne_commute_after := [llvm|
{
^0(%arg28 : i64):
  %0 = llvm.mlir.constant(5) : i64
  %1 = llvm.icmp "ne" %arg28, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_of_icmps_to_ne_commute_proof : xor_of_icmps_to_ne_commute_before ⊑ xor_of_icmps_to_ne_commute_after := by
  unfold xor_of_icmps_to_ne_commute_before xor_of_icmps_to_ne_commute_after
  simp_alive_peephole
  intros
  ---BEGIN xor_of_icmps_to_ne_commute
  apply xor_of_icmps_to_ne_commute_thm
  ---END xor_of_icmps_to_ne_commute



def xor_of_icmps_neg_to_ne_before := [llvm|
{
^0(%arg27 : i64):
  %0 = llvm.mlir.constant(-6) : i64
  %1 = llvm.mlir.constant(-4) : i64
  %2 = llvm.icmp "sgt" %arg27, %0 : i64
  %3 = llvm.icmp "slt" %arg27, %1 : i64
  %4 = llvm.xor %2, %3 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_of_icmps_neg_to_ne_after := [llvm|
{
^0(%arg27 : i64):
  %0 = llvm.mlir.constant(-5) : i64
  %1 = llvm.icmp "ne" %arg27, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_of_icmps_neg_to_ne_proof : xor_of_icmps_neg_to_ne_before ⊑ xor_of_icmps_neg_to_ne_after := by
  unfold xor_of_icmps_neg_to_ne_before xor_of_icmps_neg_to_ne_after
  simp_alive_peephole
  intros
  ---BEGIN xor_of_icmps_neg_to_ne
  apply xor_of_icmps_neg_to_ne_thm
  ---END xor_of_icmps_neg_to_ne



def xor_of_icmps_to_eq_before := [llvm|
{
^0(%arg21 : i8):
  %0 = llvm.mlir.constant(126 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.icmp "sgt" %arg21, %0 : i8
  %3 = llvm.icmp "slt" %arg21, %1 : i8
  %4 = llvm.xor %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def xor_of_icmps_to_eq_after := [llvm|
{
^0(%arg21 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "eq" %arg21, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_of_icmps_to_eq_proof : xor_of_icmps_to_eq_before ⊑ xor_of_icmps_to_eq_after := by
  unfold xor_of_icmps_to_eq_before xor_of_icmps_to_eq_after
  simp_alive_peephole
  intros
  ---BEGIN xor_of_icmps_to_eq
  apply xor_of_icmps_to_eq_thm
  ---END xor_of_icmps_to_eq



def PR2844_before := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-638208501 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.icmp "eq" %arg20, %0 : i32
  %4 = llvm.icmp "slt" %arg20, %1 : i32
  %5 = llvm.or %3, %4 : i1
  %6 = "llvm.select"(%5, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def PR2844_after := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-638208502 : i32) : i32
  %2 = llvm.icmp "ne" %arg20, %0 : i32
  %3 = llvm.icmp "sgt" %arg20, %1 : i32
  %4 = llvm.and %2, %3 : i1
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR2844_proof : PR2844_before ⊑ PR2844_after := by
  unfold PR2844_before PR2844_after
  simp_alive_peephole
  intros
  ---BEGIN PR2844
  apply PR2844_thm
  ---END PR2844



def PR2844_logical_before := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-638208501 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.icmp "eq" %arg19, %0 : i32
  %5 = llvm.icmp "slt" %arg19, %1 : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = "llvm.select"(%6, %0, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def PR2844_logical_after := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-638208502 : i32) : i32
  %2 = llvm.icmp "ne" %arg19, %0 : i32
  %3 = llvm.icmp "sgt" %arg19, %1 : i32
  %4 = llvm.and %2, %3 : i1
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR2844_logical_proof : PR2844_logical_before ⊑ PR2844_logical_after := by
  unfold PR2844_logical_before PR2844_logical_after
  simp_alive_peephole
  intros
  ---BEGIN PR2844_logical
  apply PR2844_logical_thm
  ---END PR2844_logical



def test16_before := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg18, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test16_proof : test16_before ⊑ test16_after := by
  unfold test16_before test16_after
  simp_alive_peephole
  intros
  ---BEGIN test16
  apply test16_thm
  ---END test16



def test17_before := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.or %arg17, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def test17_after := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test17_proof : test17_before ⊑ test17_after := by
  unfold test17_before test17_after
  simp_alive_peephole
  intros
  ---BEGIN test17
  apply test17_thm
  ---END test17



def test19_before := [llvm|
{
^0(%arg13 : i1, %arg14 : i1):
  %0 = llvm.zext %arg13 : i1 to i32
  %1 = llvm.zext %arg14 : i1 to i32
  %2 = llvm.icmp "eq" %0, %1 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def test19_after := [llvm|
{
^0(%arg13 : i1, %arg14 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg13, %arg14 : i1
  %2 = llvm.xor %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test19_proof : test19_before ⊑ test19_after := by
  unfold test19_before test19_after
  simp_alive_peephole
  intros
  ---BEGIN test19
  apply test19_thm
  ---END test19



def test20_before := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg12, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test20_after := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.and %arg12, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test20_proof : test20_before ⊑ test20_after := by
  unfold test20_before test20_after
  simp_alive_peephole
  intros
  ---BEGIN test20
  apply test20_thm
  ---END test20



def test21_before := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg10, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test21_after := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.lshr %arg10, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test21_proof : test21_before ⊑ test21_after := by
  unfold test21_before test21_after
  simp_alive_peephole
  intros
  ---BEGIN test21
  apply test21_thm
  ---END test21



def test22_before := [llvm|
{
^0(%arg7 : i32, %arg8 : i32):
  %0 = llvm.mlir.constant(100663295 : i32) : i32
  %1 = llvm.mlir.constant(268435456 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(-1 : i32) : i32
  %4 = llvm.and %arg7, %0 : i32
  %5 = llvm.icmp "ult" %4, %1 : i32
  %6 = llvm.and %arg8, %2 : i32
  %7 = llvm.icmp "sgt" %6, %3 : i32
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def test22_after := [llvm|
{
^0(%arg7 : i32, %arg8 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test22_proof : test22_before ⊑ test22_after := by
  unfold test22_before test22_after
  simp_alive_peephole
  intros
  ---BEGIN test22
  apply test22_thm
  ---END test22



def test22_logical_before := [llvm|
{
^0(%arg5 : i32, %arg6 : i32):
  %0 = llvm.mlir.constant(100663295 : i32) : i32
  %1 = llvm.mlir.constant(268435456 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(-1 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.and %arg5, %0 : i32
  %6 = llvm.icmp "ult" %5, %1 : i32
  %7 = llvm.and %arg6, %2 : i32
  %8 = llvm.icmp "sgt" %7, %3 : i32
  %9 = "llvm.select"(%6, %4, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def test22_logical_after := [llvm|
{
^0(%arg5 : i32, %arg6 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test22_logical_proof : test22_logical_before ⊑ test22_logical_after := by
  unfold test22_logical_before test22_logical_after
  simp_alive_peephole
  intros
  ---BEGIN test22_logical
  apply test22_logical_thm
  ---END test22_logical



def test23_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg4, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test23_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.and %arg4, %0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test23_proof : test23_before ⊑ test23_after := by
  unfold test23_before test23_after
  simp_alive_peephole
  intros
  ---BEGIN test23
  apply test23_thm
  ---END test23



def test24_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.and %arg2, %0 : i32
  %4 = llvm.lshr %3, %1 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test24_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.lshr %arg2, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.xor %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test24_proof : test24_before ⊑ test24_after := by
  unfold test24_before test24_after
  simp_alive_peephole
  intros
  ---BEGIN test24
  apply test24_thm
  ---END test24



def test25_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.icmp "ugt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def test25_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test25_proof : test25_before ⊑ test25_after := by
  unfold test25_before test25_after
  simp_alive_peephole
  intros
  ---BEGIN test25
  apply test25_thm
  ---END test25


