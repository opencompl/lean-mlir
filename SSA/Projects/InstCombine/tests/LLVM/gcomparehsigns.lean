
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
section gcomparehsigns_statements

def test1_before := [llvm|
{
^0(%arg27 : i32, %arg28 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.icmp "sgt" %arg27, %0 : i32
  %3 = llvm.icmp "slt" %arg28, %1 : i32
  %4 = llvm.xor %3, %2 : i1
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg27 : i32, %arg28 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg28, %arg27 : i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1



def test2_before := [llvm|
{
^0(%arg25 : i32, %arg26 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.and %arg25, %0 : i32
  %2 = llvm.and %arg26, %0 : i32
  %3 = llvm.icmp "eq" %1, %2 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg25 : i32, %arg26 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.xor %arg25, %arg26 : i32
  %3 = llvm.lshr %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.xor %4, %1 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  intros
  ---BEGIN test2
  all_goals (try extract_goal ; sorry)
  ---END test2



def test3_before := [llvm|
{
^0(%arg23 : i32, %arg24 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.lshr %arg23, %0 : i32
  %2 = llvm.lshr %arg24, %0 : i32
  %3 = llvm.icmp "eq" %1, %2 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg23 : i32, %arg24 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg23, %arg24 : i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  intros
  ---BEGIN test3
  all_goals (try extract_goal ; sorry)
  ---END test3



def test3i_before := [llvm|
{
^0(%arg11 : i32, %arg12 : i32):
  %0 = llvm.mlir.constant(29 : i32) : i32
  %1 = llvm.mlir.constant(35 : i32) : i32
  %2 = llvm.lshr %arg11, %0 : i32
  %3 = llvm.lshr %arg12, %0 : i32
  %4 = llvm.or %2, %1 : i32
  %5 = llvm.or %3, %1 : i32
  %6 = llvm.icmp "eq" %4, %5 : i32
  %7 = llvm.zext %6 : i1 to i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test3i_after := [llvm|
{
^0(%arg11 : i32, %arg12 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg11, %arg12 : i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test3i_proof : test3i_before ⊑ test3i_after := by
  unfold test3i_before test3i_after
  simp_alive_peephole
  intros
  ---BEGIN test3i
  all_goals (try extract_goal ; sorry)
  ---END test3i



def test4a_before := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.ashr %arg10, %0 : i32
  %4 = llvm.sub %1, %arg10 : i32
  %5 = llvm.lshr %4, %0 : i32
  %6 = llvm.or %3, %5 : i32
  %7 = llvm.icmp "slt" %6, %2 : i32
  "llvm.return"(%7) : (i1) -> ()
}
]
def test4a_after := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "slt" %arg10, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test4a_proof : test4a_before ⊑ test4a_after := by
  unfold test4a_before test4a_after
  simp_alive_peephole
  intros
  ---BEGIN test4a
  all_goals (try extract_goal ; sorry)
  ---END test4a



def test4b_before := [llvm|
{
^0(%arg8 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.mlir.constant(1) : i64
  %3 = llvm.ashr %arg8, %0 : i64
  %4 = llvm.sub %1, %arg8 : i64
  %5 = llvm.lshr %4, %0 : i64
  %6 = llvm.or %3, %5 : i64
  %7 = llvm.icmp "slt" %6, %2 : i64
  "llvm.return"(%7) : (i1) -> ()
}
]
def test4b_after := [llvm|
{
^0(%arg8 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.icmp "slt" %arg8, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test4b_proof : test4b_before ⊑ test4b_after := by
  unfold test4b_before test4b_after
  simp_alive_peephole
  intros
  ---BEGIN test4b
  all_goals (try extract_goal ; sorry)
  ---END test4b



def test4c_before := [llvm|
{
^0(%arg7 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.ashr %arg7, %0 : i64
  %4 = llvm.sub %1, %arg7 : i64
  %5 = llvm.lshr %4, %0 : i64
  %6 = llvm.or %3, %5 : i64
  %7 = llvm.trunc %6 : i64 to i32
  %8 = llvm.icmp "slt" %7, %2 : i32
  "llvm.return"(%8) : (i1) -> ()
}
]
def test4c_after := [llvm|
{
^0(%arg7 : i64):
  %0 = llvm.mlir.constant(1) : i64
  %1 = llvm.icmp "slt" %arg7, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test4c_proof : test4c_before ⊑ test4c_after := by
  unfold test4c_before test4c_after
  simp_alive_peephole
  intros
  ---BEGIN test4c
  all_goals (try extract_goal ; sorry)
  ---END test4c



def shift_trunc_signbit_test_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.lshr %arg5, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.icmp "slt" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def shift_trunc_signbit_test_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg5, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shift_trunc_signbit_test_proof : shift_trunc_signbit_test_before ⊑ shift_trunc_signbit_test_after := by
  unfold shift_trunc_signbit_test_before shift_trunc_signbit_test_after
  simp_alive_peephole
  intros
  ---BEGIN shift_trunc_signbit_test
  all_goals (try extract_goal ; sorry)
  ---END shift_trunc_signbit_test



def shift_trunc_wrong_shift_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(23 : i32) : i32
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.lshr %arg1, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.icmp "slt" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def shift_trunc_wrong_shift_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(1073741824 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shift_trunc_wrong_shift_proof : shift_trunc_wrong_shift_before ⊑ shift_trunc_wrong_shift_after := by
  unfold shift_trunc_wrong_shift_before shift_trunc_wrong_shift_after
  simp_alive_peephole
  intros
  ---BEGIN shift_trunc_wrong_shift
  all_goals (try extract_goal ; sorry)
  ---END shift_trunc_wrong_shift



def shift_trunc_wrong_cmp_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.trunc %2 : i32 to i8
  %4 = llvm.icmp "slt" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def shift_trunc_wrong_cmp_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.lshr %arg0, %0 : i32
  %3 = llvm.trunc %2 overflow<nuw> : i32 to i8
  %4 = llvm.icmp "slt" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shift_trunc_wrong_cmp_proof : shift_trunc_wrong_cmp_before ⊑ shift_trunc_wrong_cmp_after := by
  unfold shift_trunc_wrong_cmp_before shift_trunc_wrong_cmp_after
  simp_alive_peephole
  intros
  ---BEGIN shift_trunc_wrong_cmp
  all_goals (try extract_goal ; sorry)
  ---END shift_trunc_wrong_cmp


