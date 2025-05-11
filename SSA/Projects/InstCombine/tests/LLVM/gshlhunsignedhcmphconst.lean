
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
section gshlhunsignedhcmphconst_statements

def scalar_i8_shl_ult_const_1_before := [llvm|
{
^0(%arg19 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(64 : i8) : i8
  %2 = llvm.shl %arg19, %0 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i8_shl_ult_const_1_after := [llvm|
{
^0(%arg19 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg19, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i8_shl_ult_const_1_proof : scalar_i8_shl_ult_const_1_before ⊑ scalar_i8_shl_ult_const_1_after := by
  unfold scalar_i8_shl_ult_const_1_before scalar_i8_shl_ult_const_1_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i8_shl_ult_const_1
  all_goals (try extract_goal ; sorry)
  ---END scalar_i8_shl_ult_const_1



def scalar_i8_shl_ult_const_2_before := [llvm|
{
^0(%arg18 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(64 : i8) : i8
  %2 = llvm.shl %arg18, %0 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i8_shl_ult_const_2_after := [llvm|
{
^0(%arg18 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg18, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i8_shl_ult_const_2_proof : scalar_i8_shl_ult_const_2_before ⊑ scalar_i8_shl_ult_const_2_after := by
  unfold scalar_i8_shl_ult_const_2_before scalar_i8_shl_ult_const_2_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i8_shl_ult_const_2
  all_goals (try extract_goal ; sorry)
  ---END scalar_i8_shl_ult_const_2



def scalar_i8_shl_ult_const_3_before := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(64 : i8) : i8
  %2 = llvm.shl %arg17, %0 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i8_shl_ult_const_3_after := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg17, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i8_shl_ult_const_3_proof : scalar_i8_shl_ult_const_3_before ⊑ scalar_i8_shl_ult_const_3_after := by
  unfold scalar_i8_shl_ult_const_3_before scalar_i8_shl_ult_const_3_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i8_shl_ult_const_3
  all_goals (try extract_goal ; sorry)
  ---END scalar_i8_shl_ult_const_3



def scalar_i16_shl_ult_const_before := [llvm|
{
^0(%arg16 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.mlir.constant(1024 : i16) : i16
  %2 = llvm.shl %arg16, %0 : i16
  %3 = llvm.icmp "ult" %2, %1 : i16
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i16_shl_ult_const_after := [llvm|
{
^0(%arg16 : i16):
  %0 = llvm.mlir.constant(252 : i16) : i16
  %1 = llvm.mlir.constant(0 : i16) : i16
  %2 = llvm.and %arg16, %0 : i16
  %3 = llvm.icmp "eq" %2, %1 : i16
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i16_shl_ult_const_proof : scalar_i16_shl_ult_const_before ⊑ scalar_i16_shl_ult_const_after := by
  unfold scalar_i16_shl_ult_const_before scalar_i16_shl_ult_const_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i16_shl_ult_const
  all_goals (try extract_goal ; sorry)
  ---END scalar_i16_shl_ult_const



def scalar_i32_shl_ult_const_before := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(11 : i32) : i32
  %1 = llvm.mlir.constant(131072 : i32) : i32
  %2 = llvm.shl %arg15, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i32_shl_ult_const_after := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(2097088 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg15, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i32_shl_ult_const_proof : scalar_i32_shl_ult_const_before ⊑ scalar_i32_shl_ult_const_after := by
  unfold scalar_i32_shl_ult_const_before scalar_i32_shl_ult_const_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i32_shl_ult_const
  all_goals (try extract_goal ; sorry)
  ---END scalar_i32_shl_ult_const



def scalar_i64_shl_ult_const_before := [llvm|
{
^0(%arg14 : i64):
  %0 = llvm.mlir.constant(25) : i64
  %1 = llvm.mlir.constant(8589934592) : i64
  %2 = llvm.shl %arg14, %0 : i64
  %3 = llvm.icmp "ult" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i64_shl_ult_const_after := [llvm|
{
^0(%arg14 : i64):
  %0 = llvm.mlir.constant(549755813632) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.and %arg14, %0 : i64
  %3 = llvm.icmp "eq" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i64_shl_ult_const_proof : scalar_i64_shl_ult_const_before ⊑ scalar_i64_shl_ult_const_after := by
  unfold scalar_i64_shl_ult_const_before scalar_i64_shl_ult_const_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i64_shl_ult_const
  all_goals (try extract_goal ; sorry)
  ---END scalar_i64_shl_ult_const



def scalar_i8_shl_uge_const_before := [llvm|
{
^0(%arg13 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(64 : i8) : i8
  %2 = llvm.shl %arg13, %0 : i8
  %3 = llvm.icmp "uge" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i8_shl_uge_const_after := [llvm|
{
^0(%arg13 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg13, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i8_shl_uge_const_proof : scalar_i8_shl_uge_const_before ⊑ scalar_i8_shl_uge_const_after := by
  unfold scalar_i8_shl_uge_const_before scalar_i8_shl_uge_const_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i8_shl_uge_const
  all_goals (try extract_goal ; sorry)
  ---END scalar_i8_shl_uge_const



def scalar_i8_shl_ule_const_before := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(63 : i8) : i8
  %2 = llvm.shl %arg12, %0 : i8
  %3 = llvm.icmp "ule" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i8_shl_ule_const_after := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg12, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i8_shl_ule_const_proof : scalar_i8_shl_ule_const_before ⊑ scalar_i8_shl_ule_const_after := by
  unfold scalar_i8_shl_ule_const_before scalar_i8_shl_ule_const_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i8_shl_ule_const
  all_goals (try extract_goal ; sorry)
  ---END scalar_i8_shl_ule_const



def scalar_i8_shl_ugt_const_before := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(63 : i8) : i8
  %2 = llvm.shl %arg11, %0 : i8
  %3 = llvm.icmp "ugt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def scalar_i8_shl_ugt_const_after := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg11, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem scalar_i8_shl_ugt_const_proof : scalar_i8_shl_ugt_const_before ⊑ scalar_i8_shl_ugt_const_after := by
  unfold scalar_i8_shl_ugt_const_before scalar_i8_shl_ugt_const_after
  simp_alive_peephole
  intros
  ---BEGIN scalar_i8_shl_ugt_const
  all_goals (try extract_goal ; sorry)
  ---END scalar_i8_shl_ugt_const


