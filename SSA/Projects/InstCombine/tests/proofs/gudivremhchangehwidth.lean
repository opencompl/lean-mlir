import SSA.Projects.InstCombine.tests.proofs.gudivremhchangehwidth_proof
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
section gudivremhchangehwidth_statements

def udiv_i8_before := [llvm|
{
^0(%arg37 : i8, %arg38 : i8):
  %0 = llvm.zext %arg37 : i8 to i32
  %1 = llvm.zext %arg38 : i8 to i32
  %2 = llvm.udiv %0, %1 : i32
  %3 = llvm.trunc %2 : i32 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def udiv_i8_after := [llvm|
{
^0(%arg37 : i8, %arg38 : i8):
  %0 = llvm.udiv %arg37, %arg38 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_i8_proof : udiv_i8_before ⊑ udiv_i8_after := by
  unfold udiv_i8_before udiv_i8_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_i8
  apply udiv_i8_thm
  ---END udiv_i8



def urem_i8_before := [llvm|
{
^0(%arg33 : i8, %arg34 : i8):
  %0 = llvm.zext %arg33 : i8 to i32
  %1 = llvm.zext %arg34 : i8 to i32
  %2 = llvm.urem %0, %1 : i32
  %3 = llvm.trunc %2 : i32 to i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def urem_i8_after := [llvm|
{
^0(%arg33 : i8, %arg34 : i8):
  %0 = llvm.urem %arg33, %arg34 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem urem_i8_proof : urem_i8_before ⊑ urem_i8_after := by
  unfold urem_i8_before urem_i8_after
  simp_alive_peephole
  intros
  ---BEGIN urem_i8
  apply urem_i8_thm
  ---END urem_i8



def udiv_i32_before := [llvm|
{
^0(%arg29 : i8, %arg30 : i8):
  %0 = llvm.zext %arg29 : i8 to i32
  %1 = llvm.zext %arg30 : i8 to i32
  %2 = llvm.udiv %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def udiv_i32_after := [llvm|
{
^0(%arg29 : i8, %arg30 : i8):
  %0 = llvm.udiv %arg29, %arg30 : i8
  %1 = llvm.zext %0 : i8 to i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_i32_proof : udiv_i32_before ⊑ udiv_i32_after := by
  unfold udiv_i32_before udiv_i32_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_i32
  apply udiv_i32_thm
  ---END udiv_i32



def udiv_i32_multiuse_before := [llvm|
{
^0(%arg25 : i8, %arg26 : i8):
  %0 = llvm.zext %arg25 : i8 to i32
  %1 = llvm.zext %arg26 : i8 to i32
  %2 = llvm.udiv %0, %1 : i32
  %3 = llvm.add %0, %1 : i32
  %4 = llvm.mul %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def udiv_i32_multiuse_after := [llvm|
{
^0(%arg25 : i8, %arg26 : i8):
  %0 = llvm.zext %arg25 : i8 to i32
  %1 = llvm.zext %arg26 : i8 to i32
  %2 = llvm.udiv %0, %1 : i32
  %3 = llvm.add %0, %1 overflow<nsw,nuw> : i32
  %4 = llvm.mul %2, %3 overflow<nsw,nuw> : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_i32_multiuse_proof : udiv_i32_multiuse_before ⊑ udiv_i32_multiuse_after := by
  unfold udiv_i32_multiuse_before udiv_i32_multiuse_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_i32_multiuse
  apply udiv_i32_multiuse_thm
  ---END udiv_i32_multiuse



def udiv_illegal_type_before := [llvm|
{
^0(%arg23 : i9, %arg24 : i9):
  %0 = llvm.zext %arg23 : i9 to i32
  %1 = llvm.zext %arg24 : i9 to i32
  %2 = llvm.udiv %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def udiv_illegal_type_after := [llvm|
{
^0(%arg23 : i9, %arg24 : i9):
  %0 = llvm.udiv %arg23, %arg24 : i9
  %1 = llvm.zext %0 : i9 to i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_illegal_type_proof : udiv_illegal_type_before ⊑ udiv_illegal_type_after := by
  unfold udiv_illegal_type_before udiv_illegal_type_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_illegal_type
  apply udiv_illegal_type_thm
  ---END udiv_illegal_type



def urem_i32_before := [llvm|
{
^0(%arg21 : i8, %arg22 : i8):
  %0 = llvm.zext %arg21 : i8 to i32
  %1 = llvm.zext %arg22 : i8 to i32
  %2 = llvm.urem %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def urem_i32_after := [llvm|
{
^0(%arg21 : i8, %arg22 : i8):
  %0 = llvm.urem %arg21, %arg22 : i8
  %1 = llvm.zext %0 : i8 to i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem urem_i32_proof : urem_i32_before ⊑ urem_i32_after := by
  unfold urem_i32_before urem_i32_after
  simp_alive_peephole
  intros
  ---BEGIN urem_i32
  apply urem_i32_thm
  ---END urem_i32



def urem_i32_multiuse_before := [llvm|
{
^0(%arg17 : i8, %arg18 : i8):
  %0 = llvm.zext %arg17 : i8 to i32
  %1 = llvm.zext %arg18 : i8 to i32
  %2 = llvm.urem %0, %1 : i32
  %3 = llvm.add %0, %1 : i32
  %4 = llvm.mul %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def urem_i32_multiuse_after := [llvm|
{
^0(%arg17 : i8, %arg18 : i8):
  %0 = llvm.zext %arg17 : i8 to i32
  %1 = llvm.zext %arg18 : i8 to i32
  %2 = llvm.urem %0, %1 : i32
  %3 = llvm.add %0, %1 overflow<nsw,nuw> : i32
  %4 = llvm.mul %2, %3 overflow<nsw,nuw> : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem urem_i32_multiuse_proof : urem_i32_multiuse_before ⊑ urem_i32_multiuse_after := by
  unfold urem_i32_multiuse_before urem_i32_multiuse_after
  simp_alive_peephole
  intros
  ---BEGIN urem_i32_multiuse
  apply urem_i32_multiuse_thm
  ---END urem_i32_multiuse



def urem_illegal_type_before := [llvm|
{
^0(%arg15 : i9, %arg16 : i9):
  %0 = llvm.zext %arg15 : i9 to i32
  %1 = llvm.zext %arg16 : i9 to i32
  %2 = llvm.urem %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def urem_illegal_type_after := [llvm|
{
^0(%arg15 : i9, %arg16 : i9):
  %0 = llvm.urem %arg15, %arg16 : i9
  %1 = llvm.zext %0 : i9 to i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem urem_illegal_type_proof : urem_illegal_type_before ⊑ urem_illegal_type_after := by
  unfold urem_illegal_type_before urem_illegal_type_after
  simp_alive_peephole
  intros
  ---BEGIN urem_illegal_type
  apply urem_illegal_type_thm
  ---END urem_illegal_type



def udiv_i32_c_before := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.zext %arg14 : i8 to i32
  %2 = llvm.udiv %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def udiv_i32_c_after := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.udiv %arg14, %0 : i8
  %2 = llvm.zext nneg %1 : i8 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_i32_c_proof : udiv_i32_c_before ⊑ udiv_i32_c_after := by
  unfold udiv_i32_c_before udiv_i32_c_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_i32_c
  apply udiv_i32_c_thm
  ---END udiv_i32_c



def udiv_i32_c_multiuse_before := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.zext %arg12 : i8 to i32
  %2 = llvm.udiv %1, %0 : i32
  %3 = llvm.add %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def udiv_i32_c_multiuse_after := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.zext %arg12 : i8 to i32
  %2 = llvm.udiv %1, %0 : i32
  %3 = llvm.add %2, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_i32_c_multiuse_proof : udiv_i32_c_multiuse_before ⊑ udiv_i32_c_multiuse_after := by
  unfold udiv_i32_c_multiuse_before udiv_i32_c_multiuse_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_i32_c_multiuse
  apply udiv_i32_c_multiuse_thm
  ---END udiv_i32_c_multiuse



def udiv_illegal_type_c_before := [llvm|
{
^0(%arg11 : i9):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.zext %arg11 : i9 to i32
  %2 = llvm.udiv %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def udiv_illegal_type_c_after := [llvm|
{
^0(%arg11 : i9):
  %0 = llvm.mlir.constant(10 : i9) : i9
  %1 = llvm.udiv %arg11, %0 : i9
  %2 = llvm.zext nneg %1 : i9 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_illegal_type_c_proof : udiv_illegal_type_c_before ⊑ udiv_illegal_type_c_after := by
  unfold udiv_illegal_type_c_before udiv_illegal_type_c_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_illegal_type_c
  apply udiv_illegal_type_c_thm
  ---END udiv_illegal_type_c



def urem_i32_c_before := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.zext %arg10 : i8 to i32
  %2 = llvm.urem %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def urem_i32_c_after := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.urem %arg10, %0 : i8
  %2 = llvm.zext nneg %1 : i8 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem urem_i32_c_proof : urem_i32_c_before ⊑ urem_i32_c_after := by
  unfold urem_i32_c_before urem_i32_c_after
  simp_alive_peephole
  intros
  ---BEGIN urem_i32_c
  apply urem_i32_c_thm
  ---END urem_i32_c



def urem_i32_c_multiuse_before := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.zext %arg8 : i8 to i32
  %2 = llvm.urem %1, %0 : i32
  %3 = llvm.add %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def urem_i32_c_multiuse_after := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.zext %arg8 : i8 to i32
  %2 = llvm.urem %1, %0 : i32
  %3 = llvm.add %2, %1 overflow<nsw,nuw> : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem urem_i32_c_multiuse_proof : urem_i32_c_multiuse_before ⊑ urem_i32_c_multiuse_after := by
  unfold urem_i32_c_multiuse_before urem_i32_c_multiuse_after
  simp_alive_peephole
  intros
  ---BEGIN urem_i32_c_multiuse
  apply urem_i32_c_multiuse_thm
  ---END urem_i32_c_multiuse



def urem_illegal_type_c_before := [llvm|
{
^0(%arg7 : i9):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.zext %arg7 : i9 to i32
  %2 = llvm.urem %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def urem_illegal_type_c_after := [llvm|
{
^0(%arg7 : i9):
  %0 = llvm.mlir.constant(10 : i9) : i9
  %1 = llvm.urem %arg7, %0 : i9
  %2 = llvm.zext nneg %1 : i9 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem urem_illegal_type_c_proof : urem_illegal_type_c_before ⊑ urem_illegal_type_c_after := by
  unfold urem_illegal_type_c_before urem_illegal_type_c_after
  simp_alive_peephole
  intros
  ---BEGIN urem_illegal_type_c
  apply urem_illegal_type_c_thm
  ---END urem_illegal_type_c



def udiv_c_i32_before := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.zext %arg6 : i8 to i32
  %2 = llvm.udiv %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def udiv_c_i32_after := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.udiv %0, %arg6 : i8
  %2 = llvm.zext nneg %1 : i8 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_c_i32_proof : udiv_c_i32_before ⊑ udiv_c_i32_after := by
  unfold udiv_c_i32_before udiv_c_i32_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_c_i32
  apply udiv_c_i32_thm
  ---END udiv_c_i32



def urem_c_i32_before := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.zext %arg5 : i8 to i32
  %2 = llvm.urem %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def urem_c_i32_after := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.urem %0, %arg5 : i8
  %2 = llvm.zext nneg %1 : i8 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem urem_c_i32_proof : urem_c_i32_before ⊑ urem_c_i32_after := by
  unfold urem_c_i32_before urem_c_i32_after
  simp_alive_peephole
  intros
  ---BEGIN urem_c_i32
  apply urem_c_i32_thm
  ---END urem_c_i32


