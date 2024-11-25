
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
section gselecthicmphand_statements

def test5_before := [llvm|
{
^0(%arg52 : i41):
  %0 = llvm.mlir.constant(32 : i41) : i41
  %1 = llvm.mlir.constant(0 : i41) : i41
  %2 = llvm.and %arg52, %0 : i41
  %3 = llvm.icmp "ne" %2, %1 : i41
  %4 = "llvm.select"(%3, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i41, i41) -> i41
  "llvm.return"(%4) : (i41) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg52 : i41):
  %0 = llvm.mlir.constant(32 : i41) : i41
  %1 = llvm.and %arg52, %0 : i41
  "llvm.return"(%1) : (i41) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  intros
  ---BEGIN test5
  all_goals (try extract_goal ; sorry)
  ---END test5



def test6_before := [llvm|
{
^0(%arg51 : i1023):
  %0 = llvm.mlir.constant(64 : i1023) : i1023
  %1 = llvm.mlir.constant(0 : i1023) : i1023
  %2 = llvm.and %arg51, %0 : i1023
  %3 = llvm.icmp "ne" %2, %1 : i1023
  %4 = "llvm.select"(%3, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1023, i1023) -> i1023
  "llvm.return"(%4) : (i1023) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg51 : i1023):
  %0 = llvm.mlir.constant(64 : i1023) : i1023
  %1 = llvm.and %arg51, %0 : i1023
  "llvm.return"(%1) : (i1023) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test6_proof : test6_before ⊑ test6_after := by
  unfold test6_before test6_after
  simp_alive_peephole
  intros
  ---BEGIN test6
  all_goals (try extract_goal ; sorry)
  ---END test6



def test35_before := [llvm|
{
^0(%arg50 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(60 : i32) : i32
  %2 = llvm.mlir.constant(100 : i32) : i32
  %3 = llvm.icmp "sge" %arg50, %0 : i32
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test35_after := [llvm|
{
^0(%arg50 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(60 : i32) : i32
  %2 = llvm.mlir.constant(100 : i32) : i32
  %3 = llvm.icmp "sgt" %arg50, %0 : i32
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test35_proof : test35_before ⊑ test35_after := by
  unfold test35_before test35_after
  simp_alive_peephole
  intros
  ---BEGIN test35
  all_goals (try extract_goal ; sorry)
  ---END test35



def test35_with_trunc_before := [llvm|
{
^0(%arg48 : i64):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(60 : i32) : i32
  %2 = llvm.mlir.constant(100 : i32) : i32
  %3 = llvm.trunc %arg48 : i64 to i32
  %4 = llvm.icmp "sge" %3, %0 : i32
  %5 = "llvm.select"(%4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test35_with_trunc_after := [llvm|
{
^0(%arg48 : i64):
  %0 = llvm.mlir.constant(2147483648) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.mlir.constant(60 : i32) : i32
  %3 = llvm.mlir.constant(100 : i32) : i32
  %4 = llvm.and %arg48, %0 : i64
  %5 = llvm.icmp "eq" %4, %1 : i64
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test35_with_trunc_proof : test35_with_trunc_before ⊑ test35_with_trunc_after := by
  unfold test35_with_trunc_before test35_with_trunc_after
  simp_alive_peephole
  intros
  ---BEGIN test35_with_trunc
  all_goals (try extract_goal ; sorry)
  ---END test35_with_trunc



def test65_before := [llvm|
{
^0(%arg43 : i64):
  %0 = llvm.mlir.constant(16) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.mlir.constant(40 : i32) : i32
  %3 = llvm.mlir.constant(42 : i32) : i32
  %4 = llvm.and %arg43, %0 : i64
  %5 = llvm.icmp "ne" %4, %1 : i64
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test65_after := [llvm|
{
^0(%arg43 : i64):
  %0 = llvm.mlir.constant(16) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.mlir.constant(42 : i32) : i32
  %3 = llvm.mlir.constant(40 : i32) : i32
  %4 = llvm.and %arg43, %0 : i64
  %5 = llvm.icmp "eq" %4, %1 : i64
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test65_proof : test65_before ⊑ test65_after := by
  unfold test65_before test65_after
  simp_alive_peephole
  intros
  ---BEGIN test65
  all_goals (try extract_goal ; sorry)
  ---END test65



def test66_before := [llvm|
{
^0(%arg41 : i64):
  %0 = llvm.mlir.constant(4294967296) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.mlir.constant(40 : i32) : i32
  %3 = llvm.mlir.constant(42 : i32) : i32
  %4 = llvm.and %arg41, %0 : i64
  %5 = llvm.icmp "ne" %4, %1 : i64
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test66_after := [llvm|
{
^0(%arg41 : i64):
  %0 = llvm.mlir.constant(4294967296) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.mlir.constant(42 : i32) : i32
  %3 = llvm.mlir.constant(40 : i32) : i32
  %4 = llvm.and %arg41, %0 : i64
  %5 = llvm.icmp "eq" %4, %1 : i64
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test66_proof : test66_before ⊑ test66_after := by
  unfold test66_before test66_after
  simp_alive_peephole
  intros
  ---BEGIN test66
  all_goals (try extract_goal ; sorry)
  ---END test66



def test67_before := [llvm|
{
^0(%arg38 : i16):
  %0 = llvm.mlir.constant(4 : i16) : i16
  %1 = llvm.mlir.constant(0 : i16) : i16
  %2 = llvm.mlir.constant(40 : i32) : i32
  %3 = llvm.mlir.constant(42 : i32) : i32
  %4 = llvm.and %arg38, %0 : i16
  %5 = llvm.icmp "ne" %4, %1 : i16
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test67_after := [llvm|
{
^0(%arg38 : i16):
  %0 = llvm.mlir.constant(4 : i16) : i16
  %1 = llvm.mlir.constant(0 : i16) : i16
  %2 = llvm.mlir.constant(42 : i32) : i32
  %3 = llvm.mlir.constant(40 : i32) : i32
  %4 = llvm.and %arg38, %0 : i16
  %5 = llvm.icmp "eq" %4, %1 : i16
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test67_proof : test67_before ⊑ test67_after := by
  unfold test67_before test67_after
  simp_alive_peephole
  intros
  ---BEGIN test67
  all_goals (try extract_goal ; sorry)
  ---END test67



def test71_before := [llvm|
{
^0(%arg36 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(40 : i32) : i32
  %3 = llvm.mlir.constant(42 : i32) : i32
  %4 = llvm.and %arg36, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test71_after := [llvm|
{
^0(%arg36 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(42 : i32) : i32
  %3 = llvm.mlir.constant(40 : i32) : i32
  %4 = llvm.and %arg36, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test71_proof : test71_before ⊑ test71_after := by
  unfold test71_before test71_after
  simp_alive_peephole
  intros
  ---BEGIN test71
  all_goals (try extract_goal ; sorry)
  ---END test71



def test73_before := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(40 : i32) : i32
  %2 = llvm.mlir.constant(42 : i32) : i32
  %3 = llvm.trunc %arg32 : i32 to i8
  %4 = llvm.icmp "sgt" %3, %0 : i8
  %5 = "llvm.select"(%4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test73_after := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(40 : i32) : i32
  %3 = llvm.mlir.constant(42 : i32) : i32
  %4 = llvm.and %arg32, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test73_proof : test73_before ⊑ test73_after := by
  unfold test73_before test73_after
  simp_alive_peephole
  intros
  ---BEGIN test73
  all_goals (try extract_goal ; sorry)
  ---END test73



def test15a_before := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg27, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = "llvm.select"(%3, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test15a_after := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.and %arg27, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test15a_proof : test15a_before ⊑ test15a_after := by
  unfold test15a_before test15a_after
  simp_alive_peephole
  intros
  ---BEGIN test15a
  all_goals (try extract_goal ; sorry)
  ---END test15a



def test15b_before := [llvm|
{
^0(%arg26 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg26, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = "llvm.select"(%3, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test15b_after := [llvm|
{
^0(%arg26 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.and %arg26, %0 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test15b_proof : test15b_before ⊑ test15b_after := by
  unfold test15b_before test15b_after
  simp_alive_peephole
  intros
  ---BEGIN test15b
  all_goals (try extract_goal ; sorry)
  ---END test15b



def test15c_before := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg25, %0 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = "llvm.select"(%3, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test15c_after := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.and %arg25, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test15c_proof : test15c_before ⊑ test15c_after := by
  unfold test15c_before test15c_after
  simp_alive_peephole
  intros
  ---BEGIN test15c
  all_goals (try extract_goal ; sorry)
  ---END test15c



def test15d_before := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg24, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = "llvm.select"(%3, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test15d_after := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.and %arg24, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test15d_proof : test15d_before ⊑ test15d_after := by
  unfold test15d_before test15d_after
  simp_alive_peephole
  intros
  ---BEGIN test15d
  all_goals (try extract_goal ; sorry)
  ---END test15d



def test15e_before := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.and %arg23, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = "llvm.select"(%4, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test15e_after := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(256 : i32) : i32
  %2 = llvm.shl %arg23, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test15e_proof : test15e_before ⊑ test15e_after := by
  unfold test15e_before test15e_after
  simp_alive_peephole
  intros
  ---BEGIN test15e
  all_goals (try extract_goal ; sorry)
  ---END test15e



def test15f_before := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(256 : i32) : i32
  %3 = llvm.and %arg22, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = "llvm.select"(%4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test15f_after := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(256 : i32) : i32
  %2 = llvm.shl %arg22, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.xor %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test15f_proof : test15f_before ⊑ test15f_after := by
  unfold test15f_before test15f_after
  simp_alive_peephole
  intros
  ---BEGIN test15f
  all_goals (try extract_goal ; sorry)
  ---END test15f



def test15g_before := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.mlir.constant(-9 : i32) : i32
  %4 = llvm.and %arg21, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test15g_after := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(-9 : i32) : i32
  %1 = llvm.or %arg21, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test15g_proof : test15g_before ⊑ test15g_after := by
  unfold test15g_before test15g_after
  simp_alive_peephole
  intros
  ---BEGIN test15g
  all_goals (try extract_goal ; sorry)
  ---END test15g



def test15h_before := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(-9 : i32) : i32
  %3 = llvm.mlir.constant(-1 : i32) : i32
  %4 = llvm.and %arg20, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test15h_after := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.and %arg20, %0 : i32
  %3 = llvm.xor %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test15h_proof : test15h_before ⊑ test15h_after := by
  unfold test15h_before test15h_after
  simp_alive_peephole
  intros
  ---BEGIN test15h
  all_goals (try extract_goal ; sorry)
  ---END test15h



def test15i_before := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(577 : i32) : i32
  %3 = llvm.mlir.constant(1089 : i32) : i32
  %4 = llvm.and %arg19, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test15i_after := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1089 : i32) : i32
  %3 = llvm.mlir.constant(577 : i32) : i32
  %4 = llvm.and %arg19, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test15i_proof : test15i_before ⊑ test15i_after := by
  unfold test15i_before test15i_after
  simp_alive_peephole
  intros
  ---BEGIN test15i
  all_goals (try extract_goal ; sorry)
  ---END test15i



def test15j_before := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1089 : i32) : i32
  %3 = llvm.mlir.constant(577 : i32) : i32
  %4 = llvm.and %arg18, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test15j_after := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(577 : i32) : i32
  %3 = llvm.mlir.constant(1089 : i32) : i32
  %4 = llvm.and %arg18, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test15j_proof : test15j_before ⊑ test15j_after := by
  unfold test15j_before test15j_after
  simp_alive_peephole
  intros
  ---BEGIN test15j
  all_goals (try extract_goal ; sorry)
  ---END test15j



def clear_to_set_decomposebittest_before := [llvm|
{
^0(%arg13 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(-125 : i8) : i8
  %2 = llvm.mlir.constant(3 : i8) : i8
  %3 = llvm.icmp "sgt" %arg13, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def clear_to_set_decomposebittest_after := [llvm|
{
^0(%arg13 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(-125 : i8) : i8
  %2 = llvm.and %arg13, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem clear_to_set_decomposebittest_proof : clear_to_set_decomposebittest_before ⊑ clear_to_set_decomposebittest_after := by
  unfold clear_to_set_decomposebittest_before clear_to_set_decomposebittest_after
  simp_alive_peephole
  intros
  ---BEGIN clear_to_set_decomposebittest
  all_goals (try extract_goal ; sorry)
  ---END clear_to_set_decomposebittest



def clear_to_clear_decomposebittest_before := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.mlir.constant(-125 : i8) : i8
  %3 = llvm.icmp "sgt" %arg12, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def clear_to_clear_decomposebittest_after := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.and %arg12, %0 : i8
  %3 = llvm.or disjoint %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem clear_to_clear_decomposebittest_proof : clear_to_clear_decomposebittest_before ⊑ clear_to_clear_decomposebittest_after := by
  unfold clear_to_clear_decomposebittest_before clear_to_clear_decomposebittest_after
  simp_alive_peephole
  intros
  ---BEGIN clear_to_clear_decomposebittest
  all_goals (try extract_goal ; sorry)
  ---END clear_to_clear_decomposebittest



def set_to_set_decomposebittest_before := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-125 : i8) : i8
  %2 = llvm.mlir.constant(3 : i8) : i8
  %3 = llvm.icmp "slt" %arg11, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def set_to_set_decomposebittest_after := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.and %arg11, %0 : i8
  %3 = llvm.or disjoint %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem set_to_set_decomposebittest_proof : set_to_set_decomposebittest_before ⊑ set_to_set_decomposebittest_after := by
  unfold set_to_set_decomposebittest_before set_to_set_decomposebittest_after
  simp_alive_peephole
  intros
  ---BEGIN set_to_set_decomposebittest
  all_goals (try extract_goal ; sorry)
  ---END set_to_set_decomposebittest



def set_to_clear_decomposebittest_before := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.mlir.constant(-125 : i8) : i8
  %3 = llvm.icmp "slt" %arg10, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def set_to_clear_decomposebittest_after := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(-125 : i8) : i8
  %2 = llvm.and %arg10, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem set_to_clear_decomposebittest_proof : set_to_clear_decomposebittest_before ⊑ set_to_clear_decomposebittest_after := by
  unfold set_to_clear_decomposebittest_before set_to_clear_decomposebittest_after
  simp_alive_peephole
  intros
  ---BEGIN set_to_clear_decomposebittest
  all_goals (try extract_goal ; sorry)
  ---END set_to_clear_decomposebittest



def select_bittest_to_add_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(4 : i32) : i32
  %4 = llvm.and %arg5, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_bittest_to_add_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.and %arg5, %0 : i32
  %3 = llvm.add %2, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_bittest_to_add_proof : select_bittest_to_add_before ⊑ select_bittest_to_add_after := by
  unfold select_bittest_to_add_before select_bittest_to_add_after
  simp_alive_peephole
  intros
  ---BEGIN select_bittest_to_add
  all_goals (try extract_goal ; sorry)
  ---END select_bittest_to_add



def select_bittest_to_sub_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(4 : i32) : i32
  %3 = llvm.mlir.constant(3 : i32) : i32
  %4 = llvm.and %arg4, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def select_bittest_to_sub_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(4 : i32) : i32
  %2 = llvm.and %arg4, %0 : i32
  %3 = llvm.sub %1, %2 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_bittest_to_sub_proof : select_bittest_to_sub_before ⊑ select_bittest_to_sub_after := by
  unfold select_bittest_to_sub_before select_bittest_to_sub_after
  simp_alive_peephole
  intros
  ---BEGIN select_bittest_to_sub
  all_goals (try extract_goal ; sorry)
  ---END select_bittest_to_sub



def select_bittest_to_shl_negative_test_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(4 : i32) : i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %7 = llvm.add %6, %2 overflow<nsw,nuw> : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def select_bittest_to_shl_negative_test_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(4 : i32) : i32
  %3 = llvm.mlir.constant(6 : i32) : i32
  %4 = llvm.and %arg0, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_bittest_to_shl_negative_test_proof : select_bittest_to_shl_negative_test_before ⊑ select_bittest_to_shl_negative_test_after := by
  unfold select_bittest_to_shl_negative_test_before select_bittest_to_shl_negative_test_after
  simp_alive_peephole
  intros
  ---BEGIN select_bittest_to_shl_negative_test
  all_goals (try extract_goal ; sorry)
  ---END select_bittest_to_shl_negative_test


