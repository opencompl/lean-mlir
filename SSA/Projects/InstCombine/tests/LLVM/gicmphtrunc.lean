
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
section gicmphtrunc_statements

def ult_2_before := [llvm|
{
^0(%arg56 : i32):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.trunc %arg56 : i32 to i8
  %2 = llvm.icmp "ult" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def ult_2_after := [llvm|
{
^0(%arg56 : i32):
  %0 = llvm.mlir.constant(254 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg56, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_2_proof : ult_2_before ⊑ ult_2_after := by
  unfold ult_2_before ult_2_after
  simp_alive_peephole
  intros
  ---BEGIN ult_2
  all_goals (try extract_goal ; sorry)
  ---END ult_2



def ult_192_before := [llvm|
{
^0(%arg51 : i32):
  %0 = llvm.mlir.constant(-64 : i8) : i8
  %1 = llvm.trunc %arg51 : i32 to i8
  %2 = llvm.icmp "ult" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def ult_192_after := [llvm|
{
^0(%arg51 : i32):
  %0 = llvm.mlir.constant(192 : i32) : i32
  %1 = llvm.and %arg51, %0 : i32
  %2 = llvm.icmp "ne" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_192_proof : ult_192_before ⊑ ult_192_after := by
  unfold ult_192_before ult_192_after
  simp_alive_peephole
  intros
  ---BEGIN ult_192
  all_goals (try extract_goal ; sorry)
  ---END ult_192



def ugt_3_before := [llvm|
{
^0(%arg47 : i32):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.trunc %arg47 : i32 to i8
  %2 = llvm.icmp "ugt" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def ugt_3_after := [llvm|
{
^0(%arg47 : i32):
  %0 = llvm.mlir.constant(252 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg47, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_3_proof : ugt_3_before ⊑ ugt_3_after := by
  unfold ugt_3_before ugt_3_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_3
  all_goals (try extract_goal ; sorry)
  ---END ugt_3



def ugt_253_before := [llvm|
{
^0(%arg43 : i32):
  %0 = llvm.mlir.constant(-3 : i8) : i8
  %1 = llvm.trunc %arg43 : i32 to i8
  %2 = llvm.icmp "ugt" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def ugt_253_after := [llvm|
{
^0(%arg43 : i32):
  %0 = llvm.mlir.constant(254 : i32) : i32
  %1 = llvm.and %arg43, %0 : i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_253_proof : ugt_253_before ⊑ ugt_253_after := by
  unfold ugt_253_before ugt_253_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_253
  all_goals (try extract_goal ; sorry)
  ---END ugt_253



def slt_0_before := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.trunc %arg39 : i32 to i8
  %2 = llvm.icmp "slt" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def slt_0_after := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg39, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_0_proof : slt_0_before ⊑ slt_0_after := by
  unfold slt_0_before slt_0_after
  simp_alive_peephole
  intros
  ---BEGIN slt_0
  all_goals (try extract_goal ; sorry)
  ---END slt_0



def sgt_n1_before := [llvm|
{
^0(%arg35 : i32):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.trunc %arg35 : i32 to i8
  %2 = llvm.icmp "sgt" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def sgt_n1_after := [llvm|
{
^0(%arg35 : i32):
  %0 = llvm.mlir.constant(128 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg35, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_n1_proof : sgt_n1_before ⊑ sgt_n1_after := by
  unfold sgt_n1_before sgt_n1_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_n1
  all_goals (try extract_goal ; sorry)
  ---END sgt_n1



def shl1_trunc_eq0_before := [llvm|
{
^0(%arg28 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i16) : i16
  %2 = llvm.shl %0, %arg28 : i32
  %3 = llvm.trunc %2 : i32 to i16
  %4 = llvm.icmp "eq" %3, %1 : i16
  "llvm.return"(%4) : (i1) -> ()
}
]
def shl1_trunc_eq0_after := [llvm|
{
^0(%arg28 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.icmp "ugt" %arg28, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl1_trunc_eq0_proof : shl1_trunc_eq0_before ⊑ shl1_trunc_eq0_after := by
  unfold shl1_trunc_eq0_before shl1_trunc_eq0_after
  simp_alive_peephole
  intros
  ---BEGIN shl1_trunc_eq0
  all_goals (try extract_goal ; sorry)
  ---END shl1_trunc_eq0



def shl1_trunc_sgt0_before := [llvm|
{
^0(%arg20 : i9):
  %0 = llvm.mlir.constant(1 : i9) : i9
  %1 = llvm.mlir.constant(0 : i6) : i6
  %2 = llvm.shl %0, %arg20 : i9
  %3 = llvm.trunc %2 : i9 to i6
  %4 = llvm.icmp "sgt" %3, %1 : i6
  "llvm.return"(%4) : (i1) -> ()
}
]
def shl1_trunc_sgt0_after := [llvm|
{
^0(%arg20 : i9):
  %0 = llvm.mlir.constant(1 : i9) : i9
  %1 = llvm.mlir.constant(0 : i6) : i6
  %2 = llvm.shl %0, %arg20 overflow<nuw> : i9
  %3 = llvm.trunc %2 : i9 to i6
  %4 = llvm.icmp "sgt" %3, %1 : i6
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl1_trunc_sgt0_proof : shl1_trunc_sgt0_before ⊑ shl1_trunc_sgt0_after := by
  unfold shl1_trunc_sgt0_before shl1_trunc_sgt0_after
  simp_alive_peephole
  intros
  ---BEGIN shl1_trunc_sgt0
  all_goals (try extract_goal ; sorry)
  ---END shl1_trunc_sgt0



def shl1_trunc_sgt4_before := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(4 : i16) : i16
  %2 = llvm.shl %0, %arg15 : i32
  %3 = llvm.trunc %2 : i32 to i16
  %4 = llvm.icmp "sgt" %3, %1 : i16
  "llvm.return"(%4) : (i1) -> ()
}
]
def shl1_trunc_sgt4_after := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(4 : i16) : i16
  %2 = llvm.shl %0, %arg15 overflow<nuw> : i32
  %3 = llvm.trunc %2 : i32 to i16
  %4 = llvm.icmp "sgt" %3, %1 : i16
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl1_trunc_sgt4_proof : shl1_trunc_sgt4_before ⊑ shl1_trunc_sgt4_after := by
  unfold shl1_trunc_sgt4_before shl1_trunc_sgt4_after
  simp_alive_peephole
  intros
  ---BEGIN shl1_trunc_sgt4
  all_goals (try extract_goal ; sorry)
  ---END shl1_trunc_sgt4


