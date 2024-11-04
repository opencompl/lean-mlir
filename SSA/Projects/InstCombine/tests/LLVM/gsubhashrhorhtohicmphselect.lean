
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
section gsubhashrhorhtohicmphselect_statements

def sub_ashr_or_i8_before := [llvm|
{
^0(%arg39 : i8, %arg40 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.sub %arg40, %arg39 overflow<nsw> : i8
  %2 = llvm.ashr %1, %0 : i8
  %3 = llvm.or %2, %arg39 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def sub_ashr_or_i8_after := [llvm|
{
^0(%arg39 : i8, %arg40 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "slt" %arg40, %arg39 : i8
  %2 = "llvm.select"(%1, %0, %arg39) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_ashr_or_i8_proof : sub_ashr_or_i8_before ⊑ sub_ashr_or_i8_after := by
  unfold sub_ashr_or_i8_before sub_ashr_or_i8_after
  simp_alive_peephole
  intros
  ---BEGIN sub_ashr_or_i8
  all_goals (try extract_goal ; sorry)
  ---END sub_ashr_or_i8



def sub_ashr_or_i16_before := [llvm|
{
^0(%arg37 : i16, %arg38 : i16):
  %0 = llvm.mlir.constant(15 : i16) : i16
  %1 = llvm.sub %arg38, %arg37 overflow<nsw> : i16
  %2 = llvm.ashr %1, %0 : i16
  %3 = llvm.or %2, %arg37 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def sub_ashr_or_i16_after := [llvm|
{
^0(%arg37 : i16, %arg38 : i16):
  %0 = llvm.mlir.constant(-1 : i16) : i16
  %1 = llvm.icmp "slt" %arg38, %arg37 : i16
  %2 = "llvm.select"(%1, %0, %arg37) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_ashr_or_i16_proof : sub_ashr_or_i16_before ⊑ sub_ashr_or_i16_after := by
  unfold sub_ashr_or_i16_before sub_ashr_or_i16_after
  simp_alive_peephole
  intros
  ---BEGIN sub_ashr_or_i16
  all_goals (try extract_goal ; sorry)
  ---END sub_ashr_or_i16



def sub_ashr_or_i32_before := [llvm|
{
^0(%arg35 : i32, %arg36 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.sub %arg36, %arg35 overflow<nsw> : i32
  %2 = llvm.ashr %1, %0 : i32
  %3 = llvm.or %2, %arg35 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sub_ashr_or_i32_after := [llvm|
{
^0(%arg35 : i32, %arg36 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "slt" %arg36, %arg35 : i32
  %2 = "llvm.select"(%1, %0, %arg35) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_ashr_or_i32_proof : sub_ashr_or_i32_before ⊑ sub_ashr_or_i32_after := by
  unfold sub_ashr_or_i32_before sub_ashr_or_i32_after
  simp_alive_peephole
  intros
  ---BEGIN sub_ashr_or_i32
  all_goals (try extract_goal ; sorry)
  ---END sub_ashr_or_i32



def sub_ashr_or_i64_before := [llvm|
{
^0(%arg33 : i64, %arg34 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.sub %arg34, %arg33 overflow<nsw> : i64
  %2 = llvm.ashr %1, %0 : i64
  %3 = llvm.or %2, %arg33 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def sub_ashr_or_i64_after := [llvm|
{
^0(%arg33 : i64, %arg34 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.icmp "slt" %arg34, %arg33 : i64
  %2 = "llvm.select"(%1, %0, %arg33) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_ashr_or_i64_proof : sub_ashr_or_i64_before ⊑ sub_ashr_or_i64_after := by
  unfold sub_ashr_or_i64_before sub_ashr_or_i64_after
  simp_alive_peephole
  intros
  ---BEGIN sub_ashr_or_i64
  all_goals (try extract_goal ; sorry)
  ---END sub_ashr_or_i64



def neg_or_ashr_i32_before := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.sub %0, %arg32 : i32
  %3 = llvm.or %2, %arg32 : i32
  %4 = llvm.ashr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def neg_or_ashr_i32_after := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg32, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_or_ashr_i32_proof : neg_or_ashr_i32_before ⊑ neg_or_ashr_i32_after := by
  unfold neg_or_ashr_i32_before neg_or_ashr_i32_after
  simp_alive_peephole
  intros
  ---BEGIN neg_or_ashr_i32
  all_goals (try extract_goal ; sorry)
  ---END neg_or_ashr_i32



def sub_ashr_or_i32_nuw_nsw_before := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.sub %arg31, %arg30 overflow<nsw,nuw> : i32
  %2 = llvm.ashr %1, %0 : i32
  %3 = llvm.or %2, %arg30 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sub_ashr_or_i32_nuw_nsw_after := [llvm|
{
^0(%arg30 : i32, %arg31 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "slt" %arg31, %arg30 : i32
  %2 = "llvm.select"(%1, %0, %arg30) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_ashr_or_i32_nuw_nsw_proof : sub_ashr_or_i32_nuw_nsw_before ⊑ sub_ashr_or_i32_nuw_nsw_after := by
  unfold sub_ashr_or_i32_nuw_nsw_before sub_ashr_or_i32_nuw_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN sub_ashr_or_i32_nuw_nsw
  all_goals (try extract_goal ; sorry)
  ---END sub_ashr_or_i32_nuw_nsw



def sub_ashr_or_i32_commute_before := [llvm|
{
^0(%arg28 : i32, %arg29 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.sub %arg29, %arg28 overflow<nsw> : i32
  %2 = llvm.ashr %1, %0 : i32
  %3 = llvm.or %arg28, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sub_ashr_or_i32_commute_after := [llvm|
{
^0(%arg28 : i32, %arg29 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "slt" %arg29, %arg28 : i32
  %2 = "llvm.select"(%1, %0, %arg28) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_ashr_or_i32_commute_proof : sub_ashr_or_i32_commute_before ⊑ sub_ashr_or_i32_commute_after := by
  unfold sub_ashr_or_i32_commute_before sub_ashr_or_i32_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sub_ashr_or_i32_commute
  all_goals (try extract_goal ; sorry)
  ---END sub_ashr_or_i32_commute



def neg_or_ashr_i32_commute_before := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(31 : i32) : i32
  %3 = llvm.sdiv %0, %arg27 : i32
  %4 = llvm.sub %1, %3 : i32
  %5 = llvm.or %3, %4 : i32
  %6 = llvm.ashr %5, %2 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def neg_or_ashr_i32_commute_after := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.sdiv %0, %arg27 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = llvm.sext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem neg_or_ashr_i32_commute_proof : neg_or_ashr_i32_commute_before ⊑ neg_or_ashr_i32_commute_after := by
  unfold neg_or_ashr_i32_commute_before neg_or_ashr_i32_commute_after
  simp_alive_peephole
  intros
  ---BEGIN neg_or_ashr_i32_commute
  all_goals (try extract_goal ; sorry)
  ---END neg_or_ashr_i32_commute


