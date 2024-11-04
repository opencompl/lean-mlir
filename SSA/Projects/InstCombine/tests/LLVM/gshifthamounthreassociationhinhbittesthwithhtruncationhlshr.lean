
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
  all_goals (try extract_goal ; sorry)
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
  all_goals (try extract_goal ; sorry)
  ---END t1_single_bit



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
  all_goals (try extract_goal ; sorry)
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
  all_goals (try extract_goal ; sorry)
  ---END t3_singlebit



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
  all_goals (try extract_goal ; sorry)
  ---END t9_highest_bit



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
  all_goals (try extract_goal ; sorry)
  ---END t11_no_shift



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
  all_goals (try extract_goal ; sorry)
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
  all_goals (try extract_goal ; sorry)
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
  all_goals (try extract_goal ; sorry)
  ---END rawspeed_signbit


