import SSA.Projects.InstCombine.tests.proofs.gsexthand_proof
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
section gsexthand_statements

def fold_sext_to_and_before := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(-2147483647 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.sext %arg17 : i8 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def fold_sext_to_and_after := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(-127 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.and %arg17, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_sext_to_and_proof : fold_sext_to_and_before ⊑ fold_sext_to_and_after := by
  unfold fold_sext_to_and_before fold_sext_to_and_after
  simp_alive_peephole
  intros
  ---BEGIN fold_sext_to_and
  apply fold_sext_to_and_thm
  ---END fold_sext_to_and



def fold_sext_to_and1_before := [llvm|
{
^0(%arg16 : i8):
  %0 = llvm.mlir.constant(-2147483647 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.sext %arg16 : i8 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def fold_sext_to_and1_after := [llvm|
{
^0(%arg16 : i8):
  %0 = llvm.mlir.constant(-127 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.and %arg16, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_sext_to_and1_proof : fold_sext_to_and1_before ⊑ fold_sext_to_and1_after := by
  unfold fold_sext_to_and1_before fold_sext_to_and1_after
  simp_alive_peephole
  intros
  ---BEGIN fold_sext_to_and1
  apply fold_sext_to_and1_thm
  ---END fold_sext_to_and1



def fold_sext_to_and2_before := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(1073741826 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.sext %arg15 : i8 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def fold_sext_to_and2_after := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(-126 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.and %arg15, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_sext_to_and2_proof : fold_sext_to_and2_before ⊑ fold_sext_to_and2_after := by
  unfold fold_sext_to_and2_before fold_sext_to_and2_after
  simp_alive_peephole
  intros
  ---BEGIN fold_sext_to_and2
  apply fold_sext_to_and2_thm
  ---END fold_sext_to_and2



def fold_sext_to_and3_before := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(1073741826 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.sext %arg14 : i8 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def fold_sext_to_and3_after := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(-126 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.and %arg14, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_sext_to_and3_proof : fold_sext_to_and3_before ⊑ fold_sext_to_and3_after := by
  unfold fold_sext_to_and3_before fold_sext_to_and3_after
  simp_alive_peephole
  intros
  ---BEGIN fold_sext_to_and3
  apply fold_sext_to_and3_thm
  ---END fold_sext_to_and3



def fold_sext_to_and_wrong_before := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(-2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sext %arg9 : i8 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def fold_sext_to_and_wrong_after := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_sext_to_and_wrong_proof : fold_sext_to_and_wrong_before ⊑ fold_sext_to_and_wrong_after := by
  unfold fold_sext_to_and_wrong_before fold_sext_to_and_wrong_after
  simp_alive_peephole
  intros
  ---BEGIN fold_sext_to_and_wrong
  apply fold_sext_to_and_wrong_thm
  ---END fold_sext_to_and_wrong



def fold_sext_to_and_wrong2_before := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(-2147483647 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.sext %arg8 : i8 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def fold_sext_to_and_wrong2_after := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_sext_to_and_wrong2_proof : fold_sext_to_and_wrong2_before ⊑ fold_sext_to_and_wrong2_after := by
  unfold fold_sext_to_and_wrong2_before fold_sext_to_and_wrong2_after
  simp_alive_peephole
  intros
  ---BEGIN fold_sext_to_and_wrong2
  apply fold_sext_to_and_wrong2_thm
  ---END fold_sext_to_and_wrong2



def fold_sext_to_and_wrong3_before := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.sext %arg7 : i8 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def fold_sext_to_and_wrong3_after := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_sext_to_and_wrong3_proof : fold_sext_to_and_wrong3_before ⊑ fold_sext_to_and_wrong3_after := by
  unfold fold_sext_to_and_wrong3_before fold_sext_to_and_wrong3_after
  simp_alive_peephole
  intros
  ---BEGIN fold_sext_to_and_wrong3
  apply fold_sext_to_and_wrong3_thm
  ---END fold_sext_to_and_wrong3



def fold_sext_to_and_wrong4_before := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.sext %arg6 : i8 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def fold_sext_to_and_wrong4_after := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_sext_to_and_wrong4_proof : fold_sext_to_and_wrong4_before ⊑ fold_sext_to_and_wrong4_after := by
  unfold fold_sext_to_and_wrong4_before fold_sext_to_and_wrong4_after
  simp_alive_peephole
  intros
  ---BEGIN fold_sext_to_and_wrong4
  apply fold_sext_to_and_wrong4_thm
  ---END fold_sext_to_and_wrong4



def fold_sext_to_and_wrong5_before := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(-256 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.sext %arg5 : i8 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def fold_sext_to_and_wrong5_after := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_sext_to_and_wrong5_proof : fold_sext_to_and_wrong5_before ⊑ fold_sext_to_and_wrong5_after := by
  unfold fold_sext_to_and_wrong5_before fold_sext_to_and_wrong5_after
  simp_alive_peephole
  intros
  ---BEGIN fold_sext_to_and_wrong5
  apply fold_sext_to_and_wrong5_thm
  ---END fold_sext_to_and_wrong5



def fold_sext_to_and_wrong6_before := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(-2147483647 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.sext %arg4 : i8 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def fold_sext_to_and_wrong6_after := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_sext_to_and_wrong6_proof : fold_sext_to_and_wrong6_before ⊑ fold_sext_to_and_wrong6_after := by
  unfold fold_sext_to_and_wrong6_before fold_sext_to_and_wrong6_after
  simp_alive_peephole
  intros
  ---BEGIN fold_sext_to_and_wrong6
  apply fold_sext_to_and_wrong6_thm
  ---END fold_sext_to_and_wrong6



def fold_sext_to_and_wrong7_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(-2147483647 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.sext %arg3 : i8 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def fold_sext_to_and_wrong7_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_sext_to_and_wrong7_proof : fold_sext_to_and_wrong7_before ⊑ fold_sext_to_and_wrong7_after := by
  unfold fold_sext_to_and_wrong7_before fold_sext_to_and_wrong7_after
  simp_alive_peephole
  intros
  ---BEGIN fold_sext_to_and_wrong7
  apply fold_sext_to_and_wrong7_thm
  ---END fold_sext_to_and_wrong7



def fold_sext_to_and_wrong8_before := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.sext %arg2 : i8 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def fold_sext_to_and_wrong8_after := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_sext_to_and_wrong8_proof : fold_sext_to_and_wrong8_before ⊑ fold_sext_to_and_wrong8_after := by
  unfold fold_sext_to_and_wrong8_before fold_sext_to_and_wrong8_after
  simp_alive_peephole
  intros
  ---BEGIN fold_sext_to_and_wrong8
  apply fold_sext_to_and_wrong8_thm
  ---END fold_sext_to_and_wrong8



def fold_sext_to_and_wrong9_before := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.sext %arg1 : i8 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def fold_sext_to_and_wrong9_after := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_sext_to_and_wrong9_proof : fold_sext_to_and_wrong9_before ⊑ fold_sext_to_and_wrong9_after := by
  unfold fold_sext_to_and_wrong9_before fold_sext_to_and_wrong9_after
  simp_alive_peephole
  intros
  ---BEGIN fold_sext_to_and_wrong9
  apply fold_sext_to_and_wrong9_thm
  ---END fold_sext_to_and_wrong9



def fold_sext_to_and_wrong10_before := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(-256 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.sext %arg0 : i8 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def fold_sext_to_and_wrong10_after := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_sext_to_and_wrong10_proof : fold_sext_to_and_wrong10_before ⊑ fold_sext_to_and_wrong10_after := by
  unfold fold_sext_to_and_wrong10_before fold_sext_to_and_wrong10_after
  simp_alive_peephole
  intros
  ---BEGIN fold_sext_to_and_wrong10
  apply fold_sext_to_and_wrong10_thm
  ---END fold_sext_to_and_wrong10


