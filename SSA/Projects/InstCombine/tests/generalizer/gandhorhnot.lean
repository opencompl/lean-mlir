import SSA.Projects.InstCombine.tests.proofs.gandhorhnot_proof
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
section gandhorhnot_statements

def and_to_xor1_before := [llvm|
{
^0(%arg119 : i32, %arg120 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg119, %arg120 : i32
  %2 = llvm.and %arg119, %arg120 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_to_xor1_after := [llvm|
{
^0(%arg119 : i32, %arg120 : i32):
  %0 = llvm.xor %arg119, %arg120 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_to_xor1_proof : and_to_xor1_before ⊑ and_to_xor1_after := by
  unfold and_to_xor1_before and_to_xor1_after
  simp_alive_peephole
  intros
  ---BEGIN and_to_xor1
  apply and_to_xor1_thm
  ---END and_to_xor1



def and_to_xor2_before := [llvm|
{
^0(%arg117 : i32, %arg118 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg117, %arg118 : i32
  %2 = llvm.and %arg117, %arg118 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_to_xor2_after := [llvm|
{
^0(%arg117 : i32, %arg118 : i32):
  %0 = llvm.xor %arg117, %arg118 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_to_xor2_proof : and_to_xor2_before ⊑ and_to_xor2_after := by
  unfold and_to_xor2_before and_to_xor2_after
  simp_alive_peephole
  intros
  ---BEGIN and_to_xor2
  apply and_to_xor2_thm
  ---END and_to_xor2



def and_to_xor3_before := [llvm|
{
^0(%arg115 : i32, %arg116 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg115, %arg116 : i32
  %2 = llvm.and %arg116, %arg115 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_to_xor3_after := [llvm|
{
^0(%arg115 : i32, %arg116 : i32):
  %0 = llvm.xor %arg115, %arg116 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_to_xor3_proof : and_to_xor3_before ⊑ and_to_xor3_after := by
  unfold and_to_xor3_before and_to_xor3_after
  simp_alive_peephole
  intros
  ---BEGIN and_to_xor3
  apply and_to_xor3_thm
  ---END and_to_xor3



def and_to_xor4_before := [llvm|
{
^0(%arg113 : i32, %arg114 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg114, %arg113 : i32
  %2 = llvm.and %arg113, %arg114 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def and_to_xor4_after := [llvm|
{
^0(%arg113 : i32, %arg114 : i32):
  %0 = llvm.xor %arg114, %arg113 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_to_xor4_proof : and_to_xor4_before ⊑ and_to_xor4_after := by
  unfold and_to_xor4_before and_to_xor4_after
  simp_alive_peephole
  intros
  ---BEGIN and_to_xor4
  apply and_to_xor4_thm
  ---END and_to_xor4



def or_to_nxor1_before := [llvm|
{
^0(%arg93 : i32, %arg94 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg93, %arg94 : i32
  %2 = llvm.or %arg93, %arg94 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_to_nxor1_after := [llvm|
{
^0(%arg93 : i32, %arg94 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg93, %arg94 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_to_nxor1_proof : or_to_nxor1_before ⊑ or_to_nxor1_after := by
  unfold or_to_nxor1_before or_to_nxor1_after
  simp_alive_peephole
  intros
  ---BEGIN or_to_nxor1
  apply or_to_nxor1_thm
  ---END or_to_nxor1



def or_to_nxor2_before := [llvm|
{
^0(%arg91 : i32, %arg92 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg91, %arg92 : i32
  %2 = llvm.or %arg92, %arg91 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_to_nxor2_after := [llvm|
{
^0(%arg91 : i32, %arg92 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg91, %arg92 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_to_nxor2_proof : or_to_nxor2_before ⊑ or_to_nxor2_after := by
  unfold or_to_nxor2_before or_to_nxor2_after
  simp_alive_peephole
  intros
  ---BEGIN or_to_nxor2
  apply or_to_nxor2_thm
  ---END or_to_nxor2



def or_to_nxor3_before := [llvm|
{
^0(%arg89 : i32, %arg90 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg89, %arg90 : i32
  %2 = llvm.or %arg89, %arg90 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_to_nxor3_after := [llvm|
{
^0(%arg89 : i32, %arg90 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg89, %arg90 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_to_nxor3_proof : or_to_nxor3_before ⊑ or_to_nxor3_after := by
  unfold or_to_nxor3_before or_to_nxor3_after
  simp_alive_peephole
  intros
  ---BEGIN or_to_nxor3
  apply or_to_nxor3_thm
  ---END or_to_nxor3



def or_to_nxor4_before := [llvm|
{
^0(%arg87 : i32, %arg88 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg88, %arg87 : i32
  %2 = llvm.or %arg87, %arg88 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def or_to_nxor4_after := [llvm|
{
^0(%arg87 : i32, %arg88 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg88, %arg87 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_to_nxor4_proof : or_to_nxor4_before ⊑ or_to_nxor4_after := by
  unfold or_to_nxor4_before or_to_nxor4_after
  simp_alive_peephole
  intros
  ---BEGIN or_to_nxor4
  apply or_to_nxor4_thm
  ---END or_to_nxor4



def xor_to_xor1_before := [llvm|
{
^0(%arg85 : i32, %arg86 : i32):
  %0 = llvm.and %arg85, %arg86 : i32
  %1 = llvm.or %arg85, %arg86 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_to_xor1_after := [llvm|
{
^0(%arg85 : i32, %arg86 : i32):
  %0 = llvm.xor %arg85, %arg86 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_to_xor1_proof : xor_to_xor1_before ⊑ xor_to_xor1_after := by
  unfold xor_to_xor1_before xor_to_xor1_after
  simp_alive_peephole
  intros
  ---BEGIN xor_to_xor1
  apply xor_to_xor1_thm
  ---END xor_to_xor1



def xor_to_xor2_before := [llvm|
{
^0(%arg83 : i32, %arg84 : i32):
  %0 = llvm.and %arg83, %arg84 : i32
  %1 = llvm.or %arg84, %arg83 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_to_xor2_after := [llvm|
{
^0(%arg83 : i32, %arg84 : i32):
  %0 = llvm.xor %arg83, %arg84 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_to_xor2_proof : xor_to_xor2_before ⊑ xor_to_xor2_after := by
  unfold xor_to_xor2_before xor_to_xor2_after
  simp_alive_peephole
  intros
  ---BEGIN xor_to_xor2
  apply xor_to_xor2_thm
  ---END xor_to_xor2



def xor_to_xor3_before := [llvm|
{
^0(%arg81 : i32, %arg82 : i32):
  %0 = llvm.or %arg81, %arg82 : i32
  %1 = llvm.and %arg81, %arg82 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_to_xor3_after := [llvm|
{
^0(%arg81 : i32, %arg82 : i32):
  %0 = llvm.xor %arg81, %arg82 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_to_xor3_proof : xor_to_xor3_before ⊑ xor_to_xor3_after := by
  unfold xor_to_xor3_before xor_to_xor3_after
  simp_alive_peephole
  intros
  ---BEGIN xor_to_xor3
  apply xor_to_xor3_thm
  ---END xor_to_xor3



def xor_to_xor4_before := [llvm|
{
^0(%arg79 : i32, %arg80 : i32):
  %0 = llvm.or %arg79, %arg80 : i32
  %1 = llvm.and %arg80, %arg79 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_to_xor4_after := [llvm|
{
^0(%arg79 : i32, %arg80 : i32):
  %0 = llvm.xor %arg80, %arg79 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_to_xor4_proof : xor_to_xor4_before ⊑ xor_to_xor4_after := by
  unfold xor_to_xor4_before xor_to_xor4_after
  simp_alive_peephole
  intros
  ---BEGIN xor_to_xor4
  apply xor_to_xor4_thm
  ---END xor_to_xor4



def PR32830_before := [llvm|
{
^0(%arg60 : i64, %arg61 : i64, %arg62 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.xor %arg60, %0 : i64
  %2 = llvm.xor %arg61, %0 : i64
  %3 = llvm.or %2, %arg60 : i64
  %4 = llvm.or %1, %arg62 : i64
  %5 = llvm.and %3, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
def PR32830_after := [llvm|
{
^0(%arg60 : i64, %arg61 : i64, %arg62 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.xor %arg60, %0 : i64
  %2 = llvm.xor %arg61, %0 : i64
  %3 = llvm.or %arg60, %2 : i64
  %4 = llvm.or %arg62, %1 : i64
  %5 = llvm.and %3, %4 : i64
  "llvm.return"(%5) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR32830_proof : PR32830_before ⊑ PR32830_after := by
  unfold PR32830_before PR32830_after
  simp_alive_peephole
  intros
  ---BEGIN PR32830
  apply PR32830_thm
  ---END PR32830



def or_to_nxor_multiuse_before := [llvm|
{
^0(%arg56 : i32, %arg57 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg56, %arg57 : i32
  %2 = llvm.or %arg56, %arg57 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or %1, %3 : i32
  %5 = llvm.mul %1, %3 : i32
  %6 = llvm.mul %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def or_to_nxor_multiuse_after := [llvm|
{
^0(%arg56 : i32, %arg57 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg56, %arg57 : i32
  %2 = llvm.or %arg56, %arg57 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.or disjoint %1, %3 : i32
  %5 = llvm.mul %1, %3 : i32
  %6 = llvm.mul %5, %4 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_to_nxor_multiuse_proof : or_to_nxor_multiuse_before ⊑ or_to_nxor_multiuse_after := by
  unfold or_to_nxor_multiuse_before or_to_nxor_multiuse_after
  simp_alive_peephole
  intros
  ---BEGIN or_to_nxor_multiuse
  apply or_to_nxor_multiuse_thm
  ---END or_to_nxor_multiuse



def simplify_or_common_op_commute0_before := [llvm|
{
^0(%arg45 : i4, %arg46 : i4, %arg47 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.and %arg45, %arg46 : i4
  %2 = llvm.and %1, %arg47 : i4
  %3 = llvm.xor %2, %0 : i4
  %4 = llvm.or %3, %arg45 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def simplify_or_common_op_commute0_after := [llvm|
{
^0(%arg45 : i4, %arg46 : i4, %arg47 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  "llvm.return"(%0) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem simplify_or_common_op_commute0_proof : simplify_or_common_op_commute0_before ⊑ simplify_or_common_op_commute0_after := by
  unfold simplify_or_common_op_commute0_before simplify_or_common_op_commute0_after
  simp_alive_peephole
  intros
  ---BEGIN simplify_or_common_op_commute0
  apply simplify_or_common_op_commute0_thm
  ---END simplify_or_common_op_commute0



def simplify_or_common_op_commute1_before := [llvm|
{
^0(%arg42 : i4, %arg43 : i4, %arg44 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.and %arg43, %arg42 : i4
  %2 = llvm.and %1, %arg44 : i4
  %3 = llvm.xor %2, %0 : i4
  %4 = llvm.or %3, %arg42 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def simplify_or_common_op_commute1_after := [llvm|
{
^0(%arg42 : i4, %arg43 : i4, %arg44 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  "llvm.return"(%0) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem simplify_or_common_op_commute1_proof : simplify_or_common_op_commute1_before ⊑ simplify_or_common_op_commute1_after := by
  unfold simplify_or_common_op_commute1_before simplify_or_common_op_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN simplify_or_common_op_commute1
  apply simplify_or_common_op_commute1_thm
  ---END simplify_or_common_op_commute1



def simplify_or_common_op_commute2_before := [llvm|
{
^0(%arg38 : i4, %arg39 : i4, %arg40 : i4, %arg41 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.mul %arg40, %arg40 : i4
  %2 = llvm.and %arg38, %arg39 : i4
  %3 = llvm.and %1, %2 : i4
  %4 = llvm.and %3, %arg41 : i4
  %5 = llvm.xor %4, %0 : i4
  %6 = llvm.or %5, %arg38 : i4
  "llvm.return"(%6) : (i4) -> ()
}
]
def simplify_or_common_op_commute2_after := [llvm|
{
^0(%arg38 : i4, %arg39 : i4, %arg40 : i4, %arg41 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  "llvm.return"(%0) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem simplify_or_common_op_commute2_proof : simplify_or_common_op_commute2_before ⊑ simplify_or_common_op_commute2_after := by
  unfold simplify_or_common_op_commute2_before simplify_or_common_op_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN simplify_or_common_op_commute2
  apply simplify_or_common_op_commute2_thm
  ---END simplify_or_common_op_commute2



def simplify_and_common_op_commute1_before := [llvm|
{
^0(%arg29 : i4, %arg30 : i4, %arg31 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.or %arg30, %arg29 : i4
  %2 = llvm.or %1, %arg31 : i4
  %3 = llvm.xor %2, %0 : i4
  %4 = llvm.and %3, %arg29 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def simplify_and_common_op_commute1_after := [llvm|
{
^0(%arg29 : i4, %arg30 : i4, %arg31 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  "llvm.return"(%0) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem simplify_and_common_op_commute1_proof : simplify_and_common_op_commute1_before ⊑ simplify_and_common_op_commute1_after := by
  unfold simplify_and_common_op_commute1_before simplify_and_common_op_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN simplify_and_common_op_commute1
  apply simplify_and_common_op_commute1_thm
  ---END simplify_and_common_op_commute1



def simplify_and_common_op_commute2_before := [llvm|
{
^0(%arg25 : i4, %arg26 : i4, %arg27 : i4, %arg28 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.mul %arg27, %arg27 : i4
  %2 = llvm.or %arg25, %arg26 : i4
  %3 = llvm.or %1, %2 : i4
  %4 = llvm.or %3, %arg28 : i4
  %5 = llvm.xor %4, %0 : i4
  %6 = llvm.and %5, %arg25 : i4
  "llvm.return"(%6) : (i4) -> ()
}
]
def simplify_and_common_op_commute2_after := [llvm|
{
^0(%arg25 : i4, %arg26 : i4, %arg27 : i4, %arg28 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  "llvm.return"(%0) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem simplify_and_common_op_commute2_proof : simplify_and_common_op_commute2_before ⊑ simplify_and_common_op_commute2_after := by
  unfold simplify_and_common_op_commute2_before simplify_and_common_op_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN simplify_and_common_op_commute2
  apply simplify_and_common_op_commute2_thm
  ---END simplify_and_common_op_commute2



def reduce_xor_common_op_commute0_before := [llvm|
{
^0(%arg10 : i4, %arg11 : i4, %arg12 : i4):
  %0 = llvm.xor %arg10, %arg11 : i4
  %1 = llvm.xor %0, %arg12 : i4
  %2 = llvm.or %1, %arg10 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
def reduce_xor_common_op_commute0_after := [llvm|
{
^0(%arg10 : i4, %arg11 : i4, %arg12 : i4):
  %0 = llvm.xor %arg11, %arg12 : i4
  %1 = llvm.or %0, %arg10 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem reduce_xor_common_op_commute0_proof : reduce_xor_common_op_commute0_before ⊑ reduce_xor_common_op_commute0_after := by
  unfold reduce_xor_common_op_commute0_before reduce_xor_common_op_commute0_after
  simp_alive_peephole
  intros
  ---BEGIN reduce_xor_common_op_commute0
  apply reduce_xor_common_op_commute0_thm
  ---END reduce_xor_common_op_commute0



def reduce_xor_common_op_commute1_before := [llvm|
{
^0(%arg7 : i4, %arg8 : i4, %arg9 : i4):
  %0 = llvm.xor %arg8, %arg7 : i4
  %1 = llvm.xor %0, %arg9 : i4
  %2 = llvm.or %1, %arg7 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
def reduce_xor_common_op_commute1_after := [llvm|
{
^0(%arg7 : i4, %arg8 : i4, %arg9 : i4):
  %0 = llvm.xor %arg8, %arg9 : i4
  %1 = llvm.or %0, %arg7 : i4
  "llvm.return"(%1) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem reduce_xor_common_op_commute1_proof : reduce_xor_common_op_commute1_before ⊑ reduce_xor_common_op_commute1_after := by
  unfold reduce_xor_common_op_commute1_before reduce_xor_common_op_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN reduce_xor_common_op_commute1
  apply reduce_xor_common_op_commute1_thm
  ---END reduce_xor_common_op_commute1



def annihilate_xor_common_op_commute2_before := [llvm|
{
^0(%arg3 : i4, %arg4 : i4, %arg5 : i4, %arg6 : i4):
  %0 = llvm.mul %arg5, %arg5 : i4
  %1 = llvm.xor %arg3, %arg4 : i4
  %2 = llvm.xor %0, %1 : i4
  %3 = llvm.xor %2, %arg6 : i4
  %4 = llvm.xor %3, %arg3 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def annihilate_xor_common_op_commute2_after := [llvm|
{
^0(%arg3 : i4, %arg4 : i4, %arg5 : i4, %arg6 : i4):
  %0 = llvm.mul %arg5, %arg5 : i4
  %1 = llvm.xor %arg4, %0 : i4
  %2 = llvm.xor %1, %arg6 : i4
  "llvm.return"(%2) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem annihilate_xor_common_op_commute2_proof : annihilate_xor_common_op_commute2_before ⊑ annihilate_xor_common_op_commute2_after := by
  unfold annihilate_xor_common_op_commute2_before annihilate_xor_common_op_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN annihilate_xor_common_op_commute2
  apply annihilate_xor_common_op_commute2_thm
  ---END annihilate_xor_common_op_commute2


