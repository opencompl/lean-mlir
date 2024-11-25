import SSA.Projects.InstCombine.tests.proofs.gsubhfromhsub_proof
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
section gsubhfromhsub_statements

def t0_before := [llvm|
{
^0(%arg51 : i8, %arg52 : i8, %arg53 : i8):
  %0 = llvm.sub %arg51, %arg52 : i8
  %1 = llvm.sub %0, %arg53 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg51 : i8, %arg52 : i8, %arg53 : i8):
  %0 = llvm.add %arg52, %arg53 : i8
  %1 = llvm.sub %arg51, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  intros
  ---BEGIN t0
  apply t0_thm
  ---END t0



def t1_flags_before := [llvm|
{
^0(%arg48 : i8, %arg49 : i8, %arg50 : i8):
  %0 = llvm.sub %arg48, %arg49 overflow<nsw,nuw> : i8
  %1 = llvm.sub %0, %arg50 overflow<nsw,nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_after := [llvm|
{
^0(%arg48 : i8, %arg49 : i8, %arg50 : i8):
  %0 = llvm.add %arg49, %arg50 overflow<nsw,nuw> : i8
  %1 = llvm.sub %arg48, %0 overflow<nsw,nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_flags_proof : t1_flags_before ⊑ t1_flags_after := by
  unfold t1_flags_before t1_flags_after
  simp_alive_peephole
  intros
  ---BEGIN t1_flags
  apply t1_flags_thm
  ---END t1_flags



def t1_flags_nuw_only_before := [llvm|
{
^0(%arg45 : i8, %arg46 : i8, %arg47 : i8):
  %0 = llvm.sub %arg45, %arg46 overflow<nuw> : i8
  %1 = llvm.sub %0, %arg47 overflow<nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_nuw_only_after := [llvm|
{
^0(%arg45 : i8, %arg46 : i8, %arg47 : i8):
  %0 = llvm.add %arg46, %arg47 overflow<nuw> : i8
  %1 = llvm.sub %arg45, %0 overflow<nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_flags_nuw_only_proof : t1_flags_nuw_only_before ⊑ t1_flags_nuw_only_after := by
  unfold t1_flags_nuw_only_before t1_flags_nuw_only_after
  simp_alive_peephole
  intros
  ---BEGIN t1_flags_nuw_only
  apply t1_flags_nuw_only_thm
  ---END t1_flags_nuw_only



def t1_flags_sub_nsw_sub_before := [llvm|
{
^0(%arg42 : i8, %arg43 : i8, %arg44 : i8):
  %0 = llvm.sub %arg42, %arg43 overflow<nsw> : i8
  %1 = llvm.sub %0, %arg44 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_sub_nsw_sub_after := [llvm|
{
^0(%arg42 : i8, %arg43 : i8, %arg44 : i8):
  %0 = llvm.add %arg43, %arg44 : i8
  %1 = llvm.sub %arg42, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_flags_sub_nsw_sub_proof : t1_flags_sub_nsw_sub_before ⊑ t1_flags_sub_nsw_sub_after := by
  unfold t1_flags_sub_nsw_sub_before t1_flags_sub_nsw_sub_after
  simp_alive_peephole
  intros
  ---BEGIN t1_flags_sub_nsw_sub
  apply t1_flags_sub_nsw_sub_thm
  ---END t1_flags_sub_nsw_sub



def t1_flags_nuw_first_before := [llvm|
{
^0(%arg39 : i8, %arg40 : i8, %arg41 : i8):
  %0 = llvm.sub %arg39, %arg40 overflow<nuw> : i8
  %1 = llvm.sub %0, %arg41 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_nuw_first_after := [llvm|
{
^0(%arg39 : i8, %arg40 : i8, %arg41 : i8):
  %0 = llvm.add %arg40, %arg41 : i8
  %1 = llvm.sub %arg39, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_flags_nuw_first_proof : t1_flags_nuw_first_before ⊑ t1_flags_nuw_first_after := by
  unfold t1_flags_nuw_first_before t1_flags_nuw_first_after
  simp_alive_peephole
  intros
  ---BEGIN t1_flags_nuw_first
  apply t1_flags_nuw_first_thm
  ---END t1_flags_nuw_first



def t1_flags_nuw_second_before := [llvm|
{
^0(%arg36 : i8, %arg37 : i8, %arg38 : i8):
  %0 = llvm.sub %arg36, %arg37 : i8
  %1 = llvm.sub %0, %arg38 overflow<nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_nuw_second_after := [llvm|
{
^0(%arg36 : i8, %arg37 : i8, %arg38 : i8):
  %0 = llvm.add %arg37, %arg38 : i8
  %1 = llvm.sub %arg36, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_flags_nuw_second_proof : t1_flags_nuw_second_before ⊑ t1_flags_nuw_second_after := by
  unfold t1_flags_nuw_second_before t1_flags_nuw_second_after
  simp_alive_peephole
  intros
  ---BEGIN t1_flags_nuw_second
  apply t1_flags_nuw_second_thm
  ---END t1_flags_nuw_second



def t1_flags_nuw_nsw_first_before := [llvm|
{
^0(%arg33 : i8, %arg34 : i8, %arg35 : i8):
  %0 = llvm.sub %arg33, %arg34 overflow<nsw,nuw> : i8
  %1 = llvm.sub %0, %arg35 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_nuw_nsw_first_after := [llvm|
{
^0(%arg33 : i8, %arg34 : i8, %arg35 : i8):
  %0 = llvm.add %arg34, %arg35 : i8
  %1 = llvm.sub %arg33, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_flags_nuw_nsw_first_proof : t1_flags_nuw_nsw_first_before ⊑ t1_flags_nuw_nsw_first_after := by
  unfold t1_flags_nuw_nsw_first_before t1_flags_nuw_nsw_first_after
  simp_alive_peephole
  intros
  ---BEGIN t1_flags_nuw_nsw_first
  apply t1_flags_nuw_nsw_first_thm
  ---END t1_flags_nuw_nsw_first



def t1_flags_nuw_nsw_second_before := [llvm|
{
^0(%arg30 : i8, %arg31 : i8, %arg32 : i8):
  %0 = llvm.sub %arg30, %arg31 : i8
  %1 = llvm.sub %0, %arg32 overflow<nsw,nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t1_flags_nuw_nsw_second_after := [llvm|
{
^0(%arg30 : i8, %arg31 : i8, %arg32 : i8):
  %0 = llvm.add %arg31, %arg32 : i8
  %1 = llvm.sub %arg30, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_flags_nuw_nsw_second_proof : t1_flags_nuw_nsw_second_before ⊑ t1_flags_nuw_nsw_second_after := by
  unfold t1_flags_nuw_nsw_second_before t1_flags_nuw_nsw_second_after
  simp_alive_peephole
  intros
  ---BEGIN t1_flags_nuw_nsw_second
  apply t1_flags_nuw_nsw_second_thm
  ---END t1_flags_nuw_nsw_second



def t3_c0_before := [llvm|
{
^0(%arg25 : i8, %arg26 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.sub %0, %arg25 : i8
  %2 = llvm.sub %1, %arg26 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t3_c0_after := [llvm|
{
^0(%arg25 : i8, %arg26 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.add %arg25, %arg26 : i8
  %2 = llvm.sub %0, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t3_c0_proof : t3_c0_before ⊑ t3_c0_after := by
  unfold t3_c0_before t3_c0_after
  simp_alive_peephole
  intros
  ---BEGIN t3_c0
  apply t3_c0_thm
  ---END t3_c0



def t4_c1_before := [llvm|
{
^0(%arg23 : i8, %arg24 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.sub %arg23, %0 : i8
  %2 = llvm.sub %1, %arg24 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t4_c1_after := [llvm|
{
^0(%arg23 : i8, %arg24 : i8):
  %0 = llvm.mlir.constant(-42 : i8) : i8
  %1 = llvm.add %arg23, %0 : i8
  %2 = llvm.sub %1, %arg24 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t4_c1_proof : t4_c1_before ⊑ t4_c1_after := by
  unfold t4_c1_before t4_c1_after
  simp_alive_peephole
  intros
  ---BEGIN t4_c1
  apply t4_c1_thm
  ---END t4_c1



def t5_c2_before := [llvm|
{
^0(%arg21 : i8, %arg22 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.sub %arg21, %arg22 : i8
  %2 = llvm.sub %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t5_c2_after := [llvm|
{
^0(%arg21 : i8, %arg22 : i8):
  %0 = llvm.mlir.constant(-42 : i8) : i8
  %1 = llvm.sub %arg21, %arg22 : i8
  %2 = llvm.add %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t5_c2_proof : t5_c2_before ⊑ t5_c2_after := by
  unfold t5_c2_before t5_c2_after
  simp_alive_peephole
  intros
  ---BEGIN t5_c2
  apply t5_c2_thm
  ---END t5_c2



def t9_c0_c2_before := [llvm|
{
^0(%arg13 : i8, %arg14 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(24 : i8) : i8
  %2 = llvm.sub %0, %arg13 : i8
  %3 = llvm.sub %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def t9_c0_c2_after := [llvm|
{
^0(%arg13 : i8, %arg14 : i8):
  %0 = llvm.mlir.constant(18 : i8) : i8
  %1 = llvm.sub %0, %arg13 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t9_c0_c2_proof : t9_c0_c2_before ⊑ t9_c0_c2_after := by
  unfold t9_c0_c2_before t9_c0_c2_after
  simp_alive_peephole
  intros
  ---BEGIN t9_c0_c2
  apply t9_c0_c2_thm
  ---END t9_c0_c2



def t10_c1_c2_before := [llvm|
{
^0(%arg11 : i8, %arg12 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(24 : i8) : i8
  %2 = llvm.sub %arg11, %0 : i8
  %3 = llvm.sub %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def t10_c1_c2_after := [llvm|
{
^0(%arg11 : i8, %arg12 : i8):
  %0 = llvm.mlir.constant(-66 : i8) : i8
  %1 = llvm.add %arg11, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t10_c1_c2_proof : t10_c1_c2_before ⊑ t10_c1_c2_after := by
  unfold t10_c1_c2_before t10_c1_c2_after
  simp_alive_peephole
  intros
  ---BEGIN t10_c1_c2
  apply t10_c1_c2_thm
  ---END t10_c1_c2


