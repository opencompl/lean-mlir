import SSA.Projects.InstCombine.tests.proofs.gadd_or_sub_proof
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
section gadd_or_sub_statements

def add_or_sub_comb_i32_commuted1_nuw_before := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sub %0, %arg16 : i32
  %2 = llvm.or %1, %arg16 : i32
  %3 = llvm.add %2, %arg16 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_or_sub_comb_i32_commuted1_nuw_after := [llvm|
{
^0(%arg16 : i32):
  "llvm.return"(%arg16) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_or_sub_comb_i32_commuted1_nuw_proof : add_or_sub_comb_i32_commuted1_nuw_before ⊑ add_or_sub_comb_i32_commuted1_nuw_after := by
  unfold add_or_sub_comb_i32_commuted1_nuw_before add_or_sub_comb_i32_commuted1_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN add_or_sub_comb_i32_commuted1_nuw
  apply add_or_sub_comb_i32_commuted1_nuw_thm
  ---END add_or_sub_comb_i32_commuted1_nuw



def add_or_sub_comb_i8_commuted2_nsw_before := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mul %arg15, %arg15 : i8
  %2 = llvm.sub %0, %1 : i8
  %3 = llvm.or %2, %1 : i8
  %4 = llvm.add %1, %3 overflow<nsw> : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def add_or_sub_comb_i8_commuted2_nsw_after := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mul %arg15, %arg15 : i8
  %2 = llvm.add %1, %0 overflow<nsw> : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_or_sub_comb_i8_commuted2_nsw_proof : add_or_sub_comb_i8_commuted2_nsw_before ⊑ add_or_sub_comb_i8_commuted2_nsw_after := by
  unfold add_or_sub_comb_i8_commuted2_nsw_before add_or_sub_comb_i8_commuted2_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN add_or_sub_comb_i8_commuted2_nsw
  apply add_or_sub_comb_i8_commuted2_nsw_thm
  ---END add_or_sub_comb_i8_commuted2_nsw



def add_or_sub_comb_i128_commuted3_nuw_nsw_before := [llvm|
{
^0(%arg14 : i128):
  %0 = llvm.mlir.constant(0 : i128) : i128
  %1 = llvm.mul %arg14, %arg14 : i128
  %2 = llvm.sub %0, %1 : i128
  %3 = llvm.or %1, %2 : i128
  %4 = llvm.add %3, %1 overflow<nsw,nuw> : i128
  "llvm.return"(%4) : (i128) -> ()
}
]
def add_or_sub_comb_i128_commuted3_nuw_nsw_after := [llvm|
{
^0(%arg14 : i128):
  %0 = llvm.mul %arg14, %arg14 : i128
  "llvm.return"(%0) : (i128) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_or_sub_comb_i128_commuted3_nuw_nsw_proof : add_or_sub_comb_i128_commuted3_nuw_nsw_before ⊑ add_or_sub_comb_i128_commuted3_nuw_nsw_after := by
  unfold add_or_sub_comb_i128_commuted3_nuw_nsw_before add_or_sub_comb_i128_commuted3_nuw_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN add_or_sub_comb_i128_commuted3_nuw_nsw
  apply add_or_sub_comb_i128_commuted3_nuw_nsw_thm
  ---END add_or_sub_comb_i128_commuted3_nuw_nsw



def add_or_sub_comb_i64_commuted4_before := [llvm|
{
^0(%arg13 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.mul %arg13, %arg13 : i64
  %2 = llvm.sub %0, %1 : i64
  %3 = llvm.or %1, %2 : i64
  %4 = llvm.add %1, %3 : i64
  "llvm.return"(%4) : (i64) -> ()
}
]
def add_or_sub_comb_i64_commuted4_after := [llvm|
{
^0(%arg13 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.mul %arg13, %arg13 : i64
  %2 = llvm.add %1, %0 : i64
  %3 = llvm.and %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_or_sub_comb_i64_commuted4_proof : add_or_sub_comb_i64_commuted4_before ⊑ add_or_sub_comb_i64_commuted4_after := by
  unfold add_or_sub_comb_i64_commuted4_before add_or_sub_comb_i64_commuted4_after
  simp_alive_peephole
  intros
  ---BEGIN add_or_sub_comb_i64_commuted4
  apply add_or_sub_comb_i64_commuted4_thm
  ---END add_or_sub_comb_i64_commuted4



def add_or_sub_comb_i8_negative_y_sub_before := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg9 : i8
  %2 = llvm.or %1, %arg8 : i8
  %3 = llvm.add %2, %arg8 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_or_sub_comb_i8_negative_y_sub_after := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg9 : i8
  %2 = llvm.or %arg8, %1 : i8
  %3 = llvm.add %2, %arg8 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_or_sub_comb_i8_negative_y_sub_proof : add_or_sub_comb_i8_negative_y_sub_before ⊑ add_or_sub_comb_i8_negative_y_sub_after := by
  unfold add_or_sub_comb_i8_negative_y_sub_before add_or_sub_comb_i8_negative_y_sub_after
  simp_alive_peephole
  intros
  ---BEGIN add_or_sub_comb_i8_negative_y_sub
  apply add_or_sub_comb_i8_negative_y_sub_thm
  ---END add_or_sub_comb_i8_negative_y_sub



def add_or_sub_comb_i8_negative_y_or_before := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg6 : i8
  %2 = llvm.or %1, %arg7 : i8
  %3 = llvm.add %2, %arg6 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_or_sub_comb_i8_negative_y_or_after := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg6 : i8
  %2 = llvm.or %arg7, %1 : i8
  %3 = llvm.add %2, %arg6 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_or_sub_comb_i8_negative_y_or_proof : add_or_sub_comb_i8_negative_y_or_before ⊑ add_or_sub_comb_i8_negative_y_or_after := by
  unfold add_or_sub_comb_i8_negative_y_or_before add_or_sub_comb_i8_negative_y_or_after
  simp_alive_peephole
  intros
  ---BEGIN add_or_sub_comb_i8_negative_y_or
  apply add_or_sub_comb_i8_negative_y_or_thm
  ---END add_or_sub_comb_i8_negative_y_or



def add_or_sub_comb_i8_negative_y_add_before := [llvm|
{
^0(%arg4 : i8, %arg5 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg4 : i8
  %2 = llvm.or %1, %arg4 : i8
  %3 = llvm.add %2, %arg5 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_or_sub_comb_i8_negative_y_add_after := [llvm|
{
^0(%arg4 : i8, %arg5 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg4 : i8
  %2 = llvm.or %arg4, %1 : i8
  %3 = llvm.add %2, %arg5 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_or_sub_comb_i8_negative_y_add_proof : add_or_sub_comb_i8_negative_y_add_before ⊑ add_or_sub_comb_i8_negative_y_add_after := by
  unfold add_or_sub_comb_i8_negative_y_add_before add_or_sub_comb_i8_negative_y_add_after
  simp_alive_peephole
  intros
  ---BEGIN add_or_sub_comb_i8_negative_y_add
  apply add_or_sub_comb_i8_negative_y_add_thm
  ---END add_or_sub_comb_i8_negative_y_add



def add_or_sub_comb_i8_negative_xor_instead_or_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg3 : i8
  %2 = llvm.xor %1, %arg3 : i8
  %3 = llvm.add %2, %arg3 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_or_sub_comb_i8_negative_xor_instead_or_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg3 : i8
  %2 = llvm.xor %arg3, %1 : i8
  %3 = llvm.add %2, %arg3 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_or_sub_comb_i8_negative_xor_instead_or_proof : add_or_sub_comb_i8_negative_xor_instead_or_before ⊑ add_or_sub_comb_i8_negative_xor_instead_or_after := by
  unfold add_or_sub_comb_i8_negative_xor_instead_or_before add_or_sub_comb_i8_negative_xor_instead_or_after
  simp_alive_peephole
  intros
  ---BEGIN add_or_sub_comb_i8_negative_xor_instead_or
  apply add_or_sub_comb_i8_negative_xor_instead_or_thm
  ---END add_or_sub_comb_i8_negative_xor_instead_or


