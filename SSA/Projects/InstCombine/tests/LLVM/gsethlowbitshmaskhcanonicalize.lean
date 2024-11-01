
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
section gsethlowbitshmaskhcanonicalize_statements

def shl_add_before := [llvm|
{
^0(%arg26 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg26 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_add_after := [llvm|
{
^0(%arg26 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %0, %arg26 overflow<nsw> : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_proof : shl_add_before ⊑ shl_add_after := by
  unfold shl_add_before shl_add_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add
  all_goals (try extract_goal ; sorry)
  ---END shl_add



def shl_add_nsw_before := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg25 : i32
  %3 = llvm.add %2, %1 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_add_nsw_after := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %0, %arg25 overflow<nsw> : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_nsw_proof : shl_add_nsw_before ⊑ shl_add_nsw_after := by
  unfold shl_add_nsw_before shl_add_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_nsw
  all_goals (try extract_goal ; sorry)
  ---END shl_add_nsw



def shl_add_nuw_before := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg24 : i32
  %3 = llvm.add %2, %1 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_add_nuw_after := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_nuw_proof : shl_add_nuw_before ⊑ shl_add_nuw_after := by
  unfold shl_add_nuw_before shl_add_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END shl_add_nuw



def shl_add_nsw_nuw_before := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg23 : i32
  %3 = llvm.add %2, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_add_nsw_nuw_after := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_nsw_nuw_proof : shl_add_nsw_nuw_before ⊑ shl_add_nsw_nuw_after := by
  unfold shl_add_nsw_nuw_before shl_add_nsw_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_nsw_nuw
  all_goals (try extract_goal ; sorry)
  ---END shl_add_nsw_nuw



def shl_nsw_add_before := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg22 overflow<nsw> : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nsw_add_after := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %0, %arg22 overflow<nsw> : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nsw_add_proof : shl_nsw_add_before ⊑ shl_nsw_add_after := by
  unfold shl_nsw_add_before shl_nsw_add_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nsw_add
  all_goals (try extract_goal ; sorry)
  ---END shl_nsw_add



def shl_nsw_add_nsw_before := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg21 overflow<nsw> : i32
  %3 = llvm.add %2, %1 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nsw_add_nsw_after := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %0, %arg21 overflow<nsw> : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nsw_add_nsw_proof : shl_nsw_add_nsw_before ⊑ shl_nsw_add_nsw_after := by
  unfold shl_nsw_add_nsw_before shl_nsw_add_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nsw_add_nsw
  all_goals (try extract_goal ; sorry)
  ---END shl_nsw_add_nsw



def shl_nsw_add_nuw_before := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg20 overflow<nsw> : i32
  %3 = llvm.add %2, %1 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nsw_add_nuw_after := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nsw_add_nuw_proof : shl_nsw_add_nuw_before ⊑ shl_nsw_add_nuw_after := by
  unfold shl_nsw_add_nuw_before shl_nsw_add_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nsw_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END shl_nsw_add_nuw



def shl_nsw_add_nsw_nuw_before := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg19 overflow<nsw> : i32
  %3 = llvm.add %2, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nsw_add_nsw_nuw_after := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nsw_add_nsw_nuw_proof : shl_nsw_add_nsw_nuw_before ⊑ shl_nsw_add_nsw_nuw_after := by
  unfold shl_nsw_add_nsw_nuw_before shl_nsw_add_nsw_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nsw_add_nsw_nuw
  all_goals (try extract_goal ; sorry)
  ---END shl_nsw_add_nsw_nuw



def shl_nuw_add_before := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg18 overflow<nuw> : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nuw_add_after := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %0, %arg18 overflow<nsw> : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nuw_add_proof : shl_nuw_add_before ⊑ shl_nuw_add_after := by
  unfold shl_nuw_add_before shl_nuw_add_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nuw_add
  all_goals (try extract_goal ; sorry)
  ---END shl_nuw_add



def shl_nuw_add_nsw_before := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg17 overflow<nuw> : i32
  %3 = llvm.add %2, %1 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nuw_add_nsw_after := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %0, %arg17 overflow<nsw> : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nuw_add_nsw_proof : shl_nuw_add_nsw_before ⊑ shl_nuw_add_nsw_after := by
  unfold shl_nuw_add_nsw_before shl_nuw_add_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nuw_add_nsw
  all_goals (try extract_goal ; sorry)
  ---END shl_nuw_add_nsw



def shl_nuw_add_nuw_before := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg16 overflow<nuw> : i32
  %3 = llvm.add %2, %1 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nuw_add_nuw_after := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nuw_add_nuw_proof : shl_nuw_add_nuw_before ⊑ shl_nuw_add_nuw_after := by
  unfold shl_nuw_add_nuw_before shl_nuw_add_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nuw_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END shl_nuw_add_nuw



def shl_nuw_add_nsw_nuw_before := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg15 overflow<nuw> : i32
  %3 = llvm.add %2, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nuw_add_nsw_nuw_after := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nuw_add_nsw_nuw_proof : shl_nuw_add_nsw_nuw_before ⊑ shl_nuw_add_nsw_nuw_after := by
  unfold shl_nuw_add_nsw_nuw_before shl_nuw_add_nsw_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nuw_add_nsw_nuw
  all_goals (try extract_goal ; sorry)
  ---END shl_nuw_add_nsw_nuw



def shl_nsw_nuw_add_before := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg14 overflow<nsw,nuw> : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nsw_nuw_add_after := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %0, %arg14 overflow<nsw> : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nsw_nuw_add_proof : shl_nsw_nuw_add_before ⊑ shl_nsw_nuw_add_after := by
  unfold shl_nsw_nuw_add_before shl_nsw_nuw_add_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nsw_nuw_add
  all_goals (try extract_goal ; sorry)
  ---END shl_nsw_nuw_add



def shl_nsw_nuw_add_nsw_before := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg13 overflow<nsw,nuw> : i32
  %3 = llvm.add %2, %1 overflow<nsw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nsw_nuw_add_nsw_after := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.shl %0, %arg13 overflow<nsw> : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nsw_nuw_add_nsw_proof : shl_nsw_nuw_add_nsw_before ⊑ shl_nsw_nuw_add_nsw_after := by
  unfold shl_nsw_nuw_add_nsw_before shl_nsw_nuw_add_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nsw_nuw_add_nsw
  all_goals (try extract_goal ; sorry)
  ---END shl_nsw_nuw_add_nsw



def shl_nsw_nuw_add_nuw_before := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg12 overflow<nsw,nuw> : i32
  %3 = llvm.add %2, %1 overflow<nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nsw_nuw_add_nuw_after := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nsw_nuw_add_nuw_proof : shl_nsw_nuw_add_nuw_before ⊑ shl_nsw_nuw_add_nuw_after := by
  unfold shl_nsw_nuw_add_nuw_before shl_nsw_nuw_add_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nsw_nuw_add_nuw
  all_goals (try extract_goal ; sorry)
  ---END shl_nsw_nuw_add_nuw



def shl_nsw_nuw_add_nsw_nuw_before := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.shl %0, %arg11 overflow<nsw,nuw> : i32
  %3 = llvm.add %2, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_nsw_nuw_add_nsw_nuw_after := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_nsw_nuw_add_nsw_nuw_proof : shl_nsw_nuw_add_nsw_nuw_before ⊑ shl_nsw_nuw_add_nsw_nuw_after := by
  unfold shl_nsw_nuw_add_nsw_nuw_before shl_nsw_nuw_add_nsw_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_nsw_nuw_add_nsw_nuw
  all_goals (try extract_goal ; sorry)
  ---END shl_nsw_nuw_add_nsw_nuw



def bad_add0_before := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg2 : i32
  %2 = llvm.add %1, %arg3 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def bad_add0_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg2 overflow<nuw> : i32
  %2 = llvm.add %1, %arg3 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bad_add0_proof : bad_add0_before ⊑ bad_add0_after := by
  unfold bad_add0_before bad_add0_after
  simp_alive_peephole
  intros
  ---BEGIN bad_add0
  all_goals (try extract_goal ; sorry)
  ---END bad_add0



def bad_add1_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg1 : i32
  %2 = llvm.add %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def bad_add1_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.shl %0, %arg1 overflow<nuw> : i32
  %2 = llvm.add %1, %0 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bad_add1_proof : bad_add1_before ⊑ bad_add1_after := by
  unfold bad_add1_before bad_add1_after
  simp_alive_peephole
  intros
  ---BEGIN bad_add1
  all_goals (try extract_goal ; sorry)
  ---END bad_add1



def bad_add2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.shl %0, %arg0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def bad_add2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.shl %0, %arg0 overflow<nuw> : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bad_add2_proof : bad_add2_before ⊑ bad_add2_after := by
  unfold bad_add2_before bad_add2_after
  simp_alive_peephole
  intros
  ---BEGIN bad_add2
  all_goals (try extract_goal ; sorry)
  ---END bad_add2


