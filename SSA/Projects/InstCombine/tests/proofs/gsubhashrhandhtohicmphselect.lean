import SSA.Projects.InstCombine.tests.proofs.gsubhashrhandhtohicmphselect_proof
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
section gsubhashrhandhtohicmphselect_statements

def sub_ashr_and_i8_before := [llvm|
{
^0(%arg31 : i8, %arg32 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.sub %arg32, %arg31 overflow<nsw> : i8
  %2 = llvm.ashr %1, %0 : i8
  %3 = llvm.and %2, %arg31 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def sub_ashr_and_i8_after := [llvm|
{
^0(%arg31 : i8, %arg32 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "slt" %arg32, %arg31 : i8
  %2 = "llvm.select"(%1, %arg31, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_ashr_and_i8_proof : sub_ashr_and_i8_before ⊑ sub_ashr_and_i8_after := by
  unfold sub_ashr_and_i8_before sub_ashr_and_i8_after
  simp_alive_peephole
  intros
  ---BEGIN sub_ashr_and_i8
  apply sub_ashr_and_i8_thm
  ---END sub_ashr_and_i8



def sub_ashr_and_i16_before := [llvm|
{
^0(%arg29 : i16, %arg30 : i16):
  %0 = llvm.mlir.constant(15 : i16) : i16
  %1 = llvm.sub %arg30, %arg29 overflow<nsw> : i16
  %2 = llvm.ashr %1, %0 : i16
  %3 = llvm.and %2, %arg29 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def sub_ashr_and_i16_after := [llvm|
{
^0(%arg29 : i16, %arg30 : i16):
  %0 = llvm.mlir.constant(0 : i16) : i16
  %1 = llvm.icmp "slt" %arg30, %arg29 : i16
  %2 = "llvm.select"(%1, %arg29, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_ashr_and_i16_proof : sub_ashr_and_i16_before ⊑ sub_ashr_and_i16_after := by
  unfold sub_ashr_and_i16_before sub_ashr_and_i16_after
  simp_alive_peephole
  intros
  ---BEGIN sub_ashr_and_i16
  apply sub_ashr_and_i16_thm
  ---END sub_ashr_and_i16



def sub_ashr_and_i32_before := [llvm|
{
^0(%arg27 : i32, %arg28 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.sub %arg28, %arg27 overflow<nsw> : i32
  %2 = llvm.ashr %1, %0 : i32
  %3 = llvm.and %2, %arg27 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sub_ashr_and_i32_after := [llvm|
{
^0(%arg27 : i32, %arg28 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg28, %arg27 : i32
  %2 = "llvm.select"(%1, %arg27, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_ashr_and_i32_proof : sub_ashr_and_i32_before ⊑ sub_ashr_and_i32_after := by
  unfold sub_ashr_and_i32_before sub_ashr_and_i32_after
  simp_alive_peephole
  intros
  ---BEGIN sub_ashr_and_i32
  apply sub_ashr_and_i32_thm
  ---END sub_ashr_and_i32



def sub_ashr_and_i64_before := [llvm|
{
^0(%arg25 : i64, %arg26 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.sub %arg26, %arg25 overflow<nsw> : i64
  %2 = llvm.ashr %1, %0 : i64
  %3 = llvm.and %2, %arg25 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def sub_ashr_and_i64_after := [llvm|
{
^0(%arg25 : i64, %arg26 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.icmp "slt" %arg26, %arg25 : i64
  %2 = "llvm.select"(%1, %arg25, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_ashr_and_i64_proof : sub_ashr_and_i64_before ⊑ sub_ashr_and_i64_after := by
  unfold sub_ashr_and_i64_before sub_ashr_and_i64_after
  simp_alive_peephole
  intros
  ---BEGIN sub_ashr_and_i64
  apply sub_ashr_and_i64_thm
  ---END sub_ashr_and_i64



def sub_ashr_and_i32_nuw_nsw_before := [llvm|
{
^0(%arg23 : i32, %arg24 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.sub %arg24, %arg23 overflow<nsw,nuw> : i32
  %2 = llvm.ashr %1, %0 : i32
  %3 = llvm.and %2, %arg23 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sub_ashr_and_i32_nuw_nsw_after := [llvm|
{
^0(%arg23 : i32, %arg24 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg24, %arg23 : i32
  %2 = "llvm.select"(%1, %arg23, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_ashr_and_i32_nuw_nsw_proof : sub_ashr_and_i32_nuw_nsw_before ⊑ sub_ashr_and_i32_nuw_nsw_after := by
  unfold sub_ashr_and_i32_nuw_nsw_before sub_ashr_and_i32_nuw_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN sub_ashr_and_i32_nuw_nsw
  apply sub_ashr_and_i32_nuw_nsw_thm
  ---END sub_ashr_and_i32_nuw_nsw



def sub_ashr_and_i32_commute_before := [llvm|
{
^0(%arg21 : i32, %arg22 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.sub %arg22, %arg21 overflow<nsw> : i32
  %2 = llvm.ashr %1, %0 : i32
  %3 = llvm.and %arg21, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sub_ashr_and_i32_commute_after := [llvm|
{
^0(%arg21 : i32, %arg22 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg22, %arg21 : i32
  %2 = "llvm.select"(%1, %arg21, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_ashr_and_i32_commute_proof : sub_ashr_and_i32_commute_before ⊑ sub_ashr_and_i32_commute_after := by
  unfold sub_ashr_and_i32_commute_before sub_ashr_and_i32_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sub_ashr_and_i32_commute
  apply sub_ashr_and_i32_commute_thm
  ---END sub_ashr_and_i32_commute


