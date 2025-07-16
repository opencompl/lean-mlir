import SSA.Projects.InstCombine.tests.proofs.gshifthamounthreassociationhinhbittesthwithhtruncationhlshr_proof
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
section gshifthamounthreassociationhinhbittesthwithhtruncationhlshr_statements

def n0_before := [llvm|
{
^0(%arg48 : i32, %arg49 : i64, %arg50 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-16 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.sub %0, %arg50 : i32
  %4 = llvm.shl %arg48, %3 : i32
  %5 = llvm.add %arg50, %1 : i32
  %6 = llvm.zext %5 : i32 to i64
  %7 = llvm.lshr %arg49, %6 : i64
  %8 = llvm.trunc %7 : i64 to i32
  %9 = llvm.and %4, %8 : i32
  %10 = llvm.icmp "ne" %9, %2 : i32
  "llvm.return"(%10) : (i1) -> ()
}
]
def n0_after := [llvm|
{
^0(%arg48 : i32, %arg49 : i64, %arg50 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-16 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.sub %0, %arg50 : i32
  %4 = llvm.shl %arg48, %3 : i32
  %5 = llvm.add %arg50, %1 : i32
  %6 = llvm.zext nneg %5 : i32 to i64
  %7 = llvm.lshr %arg49, %6 : i64
  %8 = llvm.trunc %7 : i64 to i32
  %9 = llvm.and %4, %8 : i32
  %10 = llvm.icmp "ne" %9, %2 : i32
  "llvm.return"(%10) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n0_proof : n0_before ⊑ n0_after := by
  unfold n0_before n0_after
  simp_alive_peephole
  intros
  ---BEGIN n0
  apply n0_thm
  ---END n0



def t1_before := [llvm|
{
^0(%arg46 : i64, %arg47 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(65535 : i32) : i32
  %2 = llvm.mlir.constant(-16 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.sub %0, %arg47 : i32
  %5 = llvm.shl %1, %4 : i32
  %6 = llvm.add %arg47, %2 : i32
  %7 = llvm.zext %6 : i32 to i64
  %8 = llvm.lshr %arg46, %7 : i64
  %9 = llvm.trunc %8 : i64 to i32
  %10 = llvm.and %5, %9 : i32
  %11 = llvm.icmp "ne" %10, %3 : i32
  "llvm.return"(%11) : (i1) -> ()
}
]
def t1_after := [llvm|
{
^0(%arg46 : i64, %arg47 : i32):
  %0 = llvm.mlir.constant(4294901760) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.and %arg46, %0 : i64
  %3 = llvm.icmp "ne" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_proof : t1_before ⊑ t1_after := by
  unfold t1_before t1_after
  simp_alive_peephole
  intros
  ---BEGIN t1
  apply t1_thm
  ---END t1



def t1_single_bit_before := [llvm|
{
^0(%arg44 : i64, %arg45 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(32768 : i32) : i32
  %2 = llvm.mlir.constant(-16 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.sub %0, %arg45 : i32
  %5 = llvm.shl %1, %4 : i32
  %6 = llvm.add %arg45, %2 : i32
  %7 = llvm.zext %6 : i32 to i64
  %8 = llvm.lshr %arg44, %7 : i64
  %9 = llvm.trunc %8 : i64 to i32
  %10 = llvm.and %5, %9 : i32
  %11 = llvm.icmp "ne" %10, %3 : i32
  "llvm.return"(%11) : (i1) -> ()
}
]
def t1_single_bit_after := [llvm|
{
^0(%arg44 : i64, %arg45 : i32):
  %0 = llvm.mlir.constant(2147483648) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.and %arg44, %0 : i64
  %3 = llvm.icmp "ne" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_single_bit_proof : t1_single_bit_before ⊑ t1_single_bit_after := by
  unfold t1_single_bit_before t1_single_bit_after
  simp_alive_peephole
  intros
  ---BEGIN t1_single_bit
  apply t1_single_bit_thm
  ---END t1_single_bit



def n2_before := [llvm|
{
^0(%arg42 : i64, %arg43 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(131071 : i32) : i32
  %2 = llvm.mlir.constant(-16 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.sub %0, %arg43 : i32
  %5 = llvm.shl %1, %4 : i32
  %6 = llvm.add %arg43, %2 : i32
  %7 = llvm.zext %6 : i32 to i64
  %8 = llvm.lshr %arg42, %7 : i64
  %9 = llvm.trunc %8 : i64 to i32
  %10 = llvm.and %5, %9 : i32
  %11 = llvm.icmp "ne" %10, %3 : i32
  "llvm.return"(%11) : (i1) -> ()
}
]
def n2_after := [llvm|
{
^0(%arg42 : i64, %arg43 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(131071 : i32) : i32
  %2 = llvm.mlir.constant(-16 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.sub %0, %arg43 : i32
  %5 = llvm.shl %1, %4 : i32
  %6 = llvm.add %arg43, %2 : i32
  %7 = llvm.zext nneg %6 : i32 to i64
  %8 = llvm.lshr %arg42, %7 : i64
  %9 = llvm.trunc %8 : i64 to i32
  %10 = llvm.and %5, %9 : i32
  %11 = llvm.icmp "ne" %10, %3 : i32
  "llvm.return"(%11) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n2_proof : n2_before ⊑ n2_after := by
  unfold n2_before n2_after
  simp_alive_peephole
  intros
  ---BEGIN n2
  apply n2_thm
  ---END n2



def t3_before := [llvm|
{
^0(%arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-16 : i32) : i32
  %2 = llvm.mlir.constant(131071) : i64
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.sub %0, %arg41 : i32
  %5 = llvm.shl %arg40, %4 : i32
  %6 = llvm.add %arg41, %1 : i32
  %7 = llvm.zext %6 : i32 to i64
  %8 = llvm.lshr %2, %7 : i64
  %9 = llvm.trunc %8 : i64 to i32
  %10 = llvm.and %5, %9 : i32
  %11 = llvm.icmp "ne" %10, %3 : i32
  "llvm.return"(%11) : (i1) -> ()
}
]
def t3_after := [llvm|
{
^0(%arg40 : i32, %arg41 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg40, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t3_proof : t3_before ⊑ t3_after := by
  unfold t3_before t3_after
  simp_alive_peephole
  intros
  ---BEGIN t3
  apply t3_thm
  ---END t3



def t3_singlebit_before := [llvm|
{
^0(%arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-16 : i32) : i32
  %2 = llvm.mlir.constant(65536) : i64
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.sub %0, %arg39 : i32
  %5 = llvm.shl %arg38, %4 : i32
  %6 = llvm.add %arg39, %1 : i32
  %7 = llvm.zext %6 : i32 to i64
  %8 = llvm.lshr %2, %7 : i64
  %9 = llvm.trunc %8 : i64 to i32
  %10 = llvm.and %5, %9 : i32
  %11 = llvm.icmp "ne" %10, %3 : i32
  "llvm.return"(%11) : (i1) -> ()
}
]
def t3_singlebit_after := [llvm|
{
^0(%arg38 : i32, %arg39 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg38, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t3_singlebit_proof : t3_singlebit_before ⊑ t3_singlebit_after := by
  unfold t3_singlebit_before t3_singlebit_after
  simp_alive_peephole
  intros
  ---BEGIN t3_singlebit
  apply t3_singlebit_thm
  ---END t3_singlebit



def n4_before := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-16 : i32) : i32
  %2 = llvm.mlir.constant(262143) : i64
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.sub %0, %arg37 : i32
  %5 = llvm.shl %arg36, %4 : i32
  %6 = llvm.add %arg37, %1 : i32
  %7 = llvm.zext %6 : i32 to i64
  %8 = llvm.lshr %2, %7 : i64
  %9 = llvm.trunc %8 : i64 to i32
  %10 = llvm.and %5, %9 : i32
  %11 = llvm.icmp "ne" %10, %3 : i32
  "llvm.return"(%11) : (i1) -> ()
}
]
def n4_after := [llvm|
{
^0(%arg36 : i32, %arg37 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-16 : i32) : i32
  %2 = llvm.mlir.constant(262143) : i64
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.sub %0, %arg37 : i32
  %5 = llvm.shl %arg36, %4 : i32
  %6 = llvm.add %arg37, %1 : i32
  %7 = llvm.zext nneg %6 : i32 to i64
  %8 = llvm.lshr %2, %7 : i64
  %9 = llvm.trunc %8 overflow<nsw,nuw> : i64 to i32
  %10 = llvm.and %5, %9 : i32
  %11 = llvm.icmp "ne" %10, %3 : i32
  "llvm.return"(%11) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n4_proof : n4_before ⊑ n4_after := by
  unfold n4_before n4_after
  simp_alive_peephole
  intros
  ---BEGIN n4
  apply n4_thm
  ---END n4



def t9_highest_bit_before := [llvm|
{
^0(%arg25 : i32, %arg26 : i64, %arg27 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.sub %0, %arg27 : i32
  %4 = llvm.shl %arg25, %3 : i32
  %5 = llvm.add %arg27, %1 : i32
  %6 = llvm.zext %5 : i32 to i64
  %7 = llvm.lshr %arg26, %6 : i64
  %8 = llvm.trunc %7 : i64 to i32
  %9 = llvm.and %4, %8 : i32
  %10 = llvm.icmp "ne" %9, %2 : i32
  "llvm.return"(%10) : (i1) -> ()
}
]
def t9_highest_bit_after := [llvm|
{
^0(%arg25 : i32, %arg26 : i64, %arg27 : i32):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.zext %arg25 : i32 to i64
  %3 = llvm.lshr %arg26, %0 : i64
  %4 = llvm.and %3, %2 : i64
  %5 = llvm.icmp "ne" %4, %1 : i64
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t9_highest_bit_proof : t9_highest_bit_before ⊑ t9_highest_bit_after := by
  unfold t9_highest_bit_before t9_highest_bit_after
  simp_alive_peephole
  intros
  ---BEGIN t9_highest_bit
  apply t9_highest_bit_thm
  ---END t9_highest_bit



def t10_almost_highest_bit_before := [llvm|
{
^0(%arg22 : i32, %arg23 : i64, %arg24 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.sub %0, %arg24 : i32
  %4 = llvm.shl %arg22, %3 : i32
  %5 = llvm.add %arg24, %1 : i32
  %6 = llvm.zext %5 : i32 to i64
  %7 = llvm.lshr %arg23, %6 : i64
  %8 = llvm.trunc %7 : i64 to i32
  %9 = llvm.and %4, %8 : i32
  %10 = llvm.icmp "ne" %9, %2 : i32
  "llvm.return"(%10) : (i1) -> ()
}
]
def t10_almost_highest_bit_after := [llvm|
{
^0(%arg22 : i32, %arg23 : i64, %arg24 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.sub %0, %arg24 : i32
  %4 = llvm.shl %arg22, %3 : i32
  %5 = llvm.add %arg24, %1 : i32
  %6 = llvm.zext nneg %5 : i32 to i64
  %7 = llvm.lshr %arg23, %6 : i64
  %8 = llvm.trunc %7 : i64 to i32
  %9 = llvm.and %4, %8 : i32
  %10 = llvm.icmp "ne" %9, %2 : i32
  "llvm.return"(%10) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t10_almost_highest_bit_proof : t10_almost_highest_bit_before ⊑ t10_almost_highest_bit_after := by
  unfold t10_almost_highest_bit_before t10_almost_highest_bit_after
  simp_alive_peephole
  intros
  ---BEGIN t10_almost_highest_bit
  apply t10_almost_highest_bit_thm
  ---END t10_almost_highest_bit



def t11_no_shift_before := [llvm|
{
^0(%arg19 : i32, %arg20 : i64, %arg21 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(-64 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.sub %0, %arg21 : i32
  %4 = llvm.shl %arg19, %3 : i32
  %5 = llvm.add %arg21, %1 : i32
  %6 = llvm.zext %5 : i32 to i64
  %7 = llvm.lshr %arg20, %6 : i64
  %8 = llvm.trunc %7 : i64 to i32
  %9 = llvm.and %4, %8 : i32
  %10 = llvm.icmp "ne" %9, %2 : i32
  "llvm.return"(%10) : (i1) -> ()
}
]
def t11_no_shift_after := [llvm|
{
^0(%arg19 : i32, %arg20 : i64, %arg21 : i32):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.zext %arg19 : i32 to i64
  %2 = llvm.and %arg20, %1 : i64
  %3 = llvm.icmp "ne" %2, %0 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t11_no_shift_proof : t11_no_shift_before ⊑ t11_no_shift_after := by
  unfold t11_no_shift_before t11_no_shift_after
  simp_alive_peephole
  intros
  ---BEGIN t11_no_shift
  apply t11_no_shift_thm
  ---END t11_no_shift



def t10_shift_by_one_before := [llvm|
{
^0(%arg16 : i32, %arg17 : i64, %arg18 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(-63 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.sub %0, %arg18 : i32
  %4 = llvm.shl %arg16, %3 : i32
  %5 = llvm.add %arg18, %1 : i32
  %6 = llvm.zext %5 : i32 to i64
  %7 = llvm.lshr %arg17, %6 : i64
  %8 = llvm.trunc %7 : i64 to i32
  %9 = llvm.and %4, %8 : i32
  %10 = llvm.icmp "ne" %9, %2 : i32
  "llvm.return"(%10) : (i1) -> ()
}
]
def t10_shift_by_one_after := [llvm|
{
^0(%arg16 : i32, %arg17 : i64, %arg18 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(-63 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.sub %0, %arg18 : i32
  %4 = llvm.shl %arg16, %3 : i32
  %5 = llvm.add %arg18, %1 : i32
  %6 = llvm.zext nneg %5 : i32 to i64
  %7 = llvm.lshr %arg17, %6 : i64
  %8 = llvm.trunc %7 : i64 to i32
  %9 = llvm.and %4, %8 : i32
  %10 = llvm.icmp "ne" %9, %2 : i32
  "llvm.return"(%10) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t10_shift_by_one_proof : t10_shift_by_one_before ⊑ t10_shift_by_one_after := by
  unfold t10_shift_by_one_before t10_shift_by_one_after
  simp_alive_peephole
  intros
  ---BEGIN t10_shift_by_one
  apply t10_shift_by_one_thm
  ---END t10_shift_by_one



def t13_x_is_one_before := [llvm|
{
^0(%arg8 : i64, %arg9 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(-16 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.sub %0, %arg9 : i32
  %5 = llvm.shl %1, %4 : i32
  %6 = llvm.add %arg9, %2 : i32
  %7 = llvm.zext %6 : i32 to i64
  %8 = llvm.lshr %arg8, %7 : i64
  %9 = llvm.trunc %8 : i64 to i32
  %10 = llvm.and %5, %9 : i32
  %11 = llvm.icmp "ne" %10, %3 : i32
  "llvm.return"(%11) : (i1) -> ()
}
]
def t13_x_is_one_after := [llvm|
{
^0(%arg8 : i64, %arg9 : i32):
  %0 = llvm.mlir.constant(65536) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.and %arg8, %0 : i64
  %3 = llvm.icmp "ne" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t13_x_is_one_proof : t13_x_is_one_before ⊑ t13_x_is_one_after := by
  unfold t13_x_is_one_before t13_x_is_one_after
  simp_alive_peephole
  intros
  ---BEGIN t13_x_is_one
  apply t13_x_is_one_thm
  ---END t13_x_is_one



def t14_x_is_one_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(-16 : i32) : i32
  %2 = llvm.mlir.constant(1) : i64
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.sub %0, %arg7 : i32
  %5 = llvm.shl %arg6, %4 : i32
  %6 = llvm.add %arg7, %1 : i32
  %7 = llvm.zext %6 : i32 to i64
  %8 = llvm.lshr %2, %7 : i64
  %9 = llvm.trunc %8 : i64 to i32
  %10 = llvm.and %5, %9 : i32
  %11 = llvm.icmp "ne" %10, %3 : i32
  "llvm.return"(%11) : (i1) -> ()
}
]
def t14_x_is_one_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t14_x_is_one_proof : t14_x_is_one_before ⊑ t14_x_is_one_after := by
  unfold t14_x_is_one_before t14_x_is_one_after
  simp_alive_peephole
  intros
  ---BEGIN t14_x_is_one
  apply t14_x_is_one_thm
  ---END t14_x_is_one



def rawspeed_signbit_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.sub %0, %arg1 overflow<nsw> : i32
  %5 = llvm.zext %4 : i32 to i64
  %6 = llvm.lshr %arg0, %5 : i64
  %7 = llvm.trunc %6 : i64 to i32
  %8 = llvm.add %arg1, %1 overflow<nsw> : i32
  %9 = llvm.shl %2, %8 : i32
  %10 = llvm.and %9, %7 : i32
  %11 = llvm.icmp "eq" %10, %3 : i32
  "llvm.return"(%11) : (i1) -> ()
}
]
def rawspeed_signbit_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i32):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.icmp "sgt" %arg0, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem rawspeed_signbit_proof : rawspeed_signbit_before ⊑ rawspeed_signbit_after := by
  unfold rawspeed_signbit_before rawspeed_signbit_after
  simp_alive_peephole
  intros
  ---BEGIN rawspeed_signbit
  apply rawspeed_signbit_thm
  ---END rawspeed_signbit


