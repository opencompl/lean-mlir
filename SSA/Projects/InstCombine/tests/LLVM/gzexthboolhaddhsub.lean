
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
section gzexthboolhaddhsub_statements

def a_before := [llvm|
{
^0(%arg48 : i1, %arg49 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.zext %arg48 : i1 to i32
  %3 = llvm.zext %arg49 : i1 to i32
  %4 = llvm.sub %0, %3 : i32
  %5 = llvm.add %2, %1 : i32
  %6 = llvm.add %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def a_after := [llvm|
{
^0(%arg48 : i1, %arg49 : i1):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.sext %arg49 : i1 to i32
  %3 = "llvm.select"(%arg48, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.add %3, %2 overflow<nsw> : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_proof : a_before ⊑ a_after := by
  unfold a_before a_after
  simp_alive_peephole
  intros
  ---BEGIN a
  all_goals (try extract_goal ; sorry)
  ---END a



def PR30273_three_bools_before := [llvm|
{
^0(%arg41 : i1, %arg42 : i1, %arg43 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.zext %arg41 : i1 to i32
  %2 = llvm.add %1, %0 overflow<nsw> : i32
  %3 = "llvm.select"(%arg42, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.add %3, %0 overflow<nsw> : i32
  %5 = "llvm.select"(%arg43, %4, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def PR30273_three_bools_after := [llvm|
{
^0(%arg41 : i1, %arg42 : i1, %arg43 : i1):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.zext %arg41 : i1 to i32
  %3 = "llvm.select"(%arg41, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = "llvm.select"(%arg42, %3, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.zext %arg43 : i1 to i32
  %6 = llvm.add %4, %5 overflow<nsw,nuw> : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR30273_three_bools_proof : PR30273_three_bools_before ⊑ PR30273_three_bools_after := by
  unfold PR30273_three_bools_before PR30273_three_bools_after
  simp_alive_peephole
  intros
  ---BEGIN PR30273_three_bools
  all_goals (try extract_goal ; sorry)
  ---END PR30273_three_bools



def zext_add_scalar_before := [llvm|
{
^0(%arg40 : i1):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.zext %arg40 : i1 to i32
  %2 = llvm.add %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def zext_add_scalar_after := [llvm|
{
^0(%arg40 : i1):
  %0 = llvm.mlir.constant(43 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = "llvm.select"(%arg40, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_add_scalar_proof : zext_add_scalar_before ⊑ zext_add_scalar_after := by
  unfold zext_add_scalar_before zext_add_scalar_after
  simp_alive_peephole
  intros
  ---BEGIN zext_add_scalar
  all_goals (try extract_goal ; sorry)
  ---END zext_add_scalar



def zext_negate_before := [llvm|
{
^0(%arg37 : i1):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.zext %arg37 : i1 to i64
  %2 = llvm.sub %0, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def zext_negate_after := [llvm|
{
^0(%arg37 : i1):
  %0 = llvm.sext %arg37 : i1 to i64
  "llvm.return"(%0) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_negate_proof : zext_negate_before ⊑ zext_negate_after := by
  unfold zext_negate_before zext_negate_after
  simp_alive_peephole
  intros
  ---BEGIN zext_negate
  all_goals (try extract_goal ; sorry)
  ---END zext_negate



def zext_sub_const_before := [llvm|
{
^0(%arg33 : i1):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.zext %arg33 : i1 to i64
  %2 = llvm.sub %0, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def zext_sub_const_after := [llvm|
{
^0(%arg33 : i1):
  %0 = llvm.mlir.constant(41) : i64
  %1 = llvm.mlir.constant(42) : i64
  %2 = "llvm.select"(%arg33, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sub_const_proof : zext_sub_const_before ⊑ zext_sub_const_after := by
  unfold zext_sub_const_before zext_sub_const_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sub_const
  all_goals (try extract_goal ; sorry)
  ---END zext_sub_const



def sext_negate_before := [llvm|
{
^0(%arg29 : i1):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.sext %arg29 : i1 to i64
  %2 = llvm.sub %0, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def sext_negate_after := [llvm|
{
^0(%arg29 : i1):
  %0 = llvm.zext %arg29 : i1 to i64
  "llvm.return"(%0) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_negate_proof : sext_negate_before ⊑ sext_negate_after := by
  unfold sext_negate_before sext_negate_after
  simp_alive_peephole
  intros
  ---BEGIN sext_negate
  all_goals (try extract_goal ; sorry)
  ---END sext_negate



def sext_sub_const_before := [llvm|
{
^0(%arg25 : i1):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.sext %arg25 : i1 to i64
  %2 = llvm.sub %0, %1 : i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def sext_sub_const_after := [llvm|
{
^0(%arg25 : i1):
  %0 = llvm.mlir.constant(43) : i64
  %1 = llvm.mlir.constant(42) : i64
  %2 = "llvm.select"(%arg25, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_sub_const_proof : sext_sub_const_before ⊑ sext_sub_const_after := by
  unfold sext_sub_const_before sext_sub_const_after
  simp_alive_peephole
  intros
  ---BEGIN sext_sub_const
  all_goals (try extract_goal ; sorry)
  ---END sext_sub_const



def sext_sub_before := [llvm|
{
^0(%arg20 : i8, %arg21 : i1):
  %0 = llvm.sext %arg21 : i1 to i8
  %1 = llvm.sub %arg20, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def sext_sub_after := [llvm|
{
^0(%arg20 : i8, %arg21 : i1):
  %0 = llvm.zext %arg21 : i1 to i8
  %1 = llvm.add %arg20, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_sub_proof : sext_sub_before ⊑ sext_sub_after := by
  unfold sext_sub_before sext_sub_after
  simp_alive_peephole
  intros
  ---BEGIN sext_sub
  all_goals (try extract_goal ; sorry)
  ---END sext_sub



def sext_sub_nuw_before := [llvm|
{
^0(%arg14 : i8, %arg15 : i1):
  %0 = llvm.sext %arg15 : i1 to i8
  %1 = llvm.sub %arg14, %0 overflow<nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def sext_sub_nuw_after := [llvm|
{
^0(%arg14 : i8, %arg15 : i1):
  %0 = llvm.zext %arg15 : i1 to i8
  %1 = llvm.add %arg14, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_sub_nuw_proof : sext_sub_nuw_before ⊑ sext_sub_nuw_after := by
  unfold sext_sub_nuw_before sext_sub_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN sext_sub_nuw
  all_goals (try extract_goal ; sorry)
  ---END sext_sub_nuw



def sextbool_add_before := [llvm|
{
^0(%arg12 : i1, %arg13 : i32):
  %0 = llvm.sext %arg12 : i1 to i32
  %1 = llvm.add %0, %arg13 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def sextbool_add_after := [llvm|
{
^0(%arg12 : i1, %arg13 : i32):
  %0 = llvm.sext %arg12 : i1 to i32
  %1 = llvm.add %arg13, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sextbool_add_proof : sextbool_add_before ⊑ sextbool_add_after := by
  unfold sextbool_add_before sextbool_add_after
  simp_alive_peephole
  intros
  ---BEGIN sextbool_add
  all_goals (try extract_goal ; sorry)
  ---END sextbool_add



def sextbool_add_commute_before := [llvm|
{
^0(%arg10 : i1, %arg11 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.urem %arg11, %0 : i32
  %2 = llvm.sext %arg10 : i1 to i32
  %3 = llvm.add %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sextbool_add_commute_after := [llvm|
{
^0(%arg10 : i1, %arg11 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.urem %arg11, %0 : i32
  %2 = llvm.sext %arg10 : i1 to i32
  %3 = llvm.add %1, %2 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sextbool_add_commute_proof : sextbool_add_commute_before ⊑ sextbool_add_commute_after := by
  unfold sextbool_add_commute_before sextbool_add_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sextbool_add_commute
  all_goals (try extract_goal ; sorry)
  ---END sextbool_add_commute


