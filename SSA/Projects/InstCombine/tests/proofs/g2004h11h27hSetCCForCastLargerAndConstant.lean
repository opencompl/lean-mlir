import SSA.Projects.InstCombine.tests.proofs.g2004h11h27hSetCCForCastLargerAndConstant_proof
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
section g2004h11h27hSetCCForCastLargerAndConstant_statements

def lt_signed_to_large_unsigned_before := [llvm|
{
^0(%arg55 : i8):
  %0 = llvm.mlir.constant(1024 : i32) : i32
  %1 = llvm.sext %arg55 : i8 to i32
  %2 = llvm.icmp "ult" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def lt_signed_to_large_unsigned_after := [llvm|
{
^0(%arg55 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "sgt" %arg55, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lt_signed_to_large_unsigned_proof : lt_signed_to_large_unsigned_before ⊑ lt_signed_to_large_unsigned_after := by
  unfold lt_signed_to_large_unsigned_before lt_signed_to_large_unsigned_after
  simp_alive_peephole
  intros
  ---BEGIN lt_signed_to_large_unsigned
  apply lt_signed_to_large_unsigned_thm
  ---END lt_signed_to_large_unsigned



def lt_signed_to_large_signed_before := [llvm|
{
^0(%arg52 : i8):
  %0 = llvm.mlir.constant(1024 : i32) : i32
  %1 = llvm.sext %arg52 : i8 to i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def lt_signed_to_large_signed_after := [llvm|
{
^0(%arg52 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lt_signed_to_large_signed_proof : lt_signed_to_large_signed_before ⊑ lt_signed_to_large_signed_after := by
  unfold lt_signed_to_large_signed_before lt_signed_to_large_signed_after
  simp_alive_peephole
  intros
  ---BEGIN lt_signed_to_large_signed
  apply lt_signed_to_large_signed_thm
  ---END lt_signed_to_large_signed



def lt_signed_to_large_negative_before := [llvm|
{
^0(%arg51 : i8):
  %0 = llvm.mlir.constant(-1024 : i32) : i32
  %1 = llvm.sext %arg51 : i8 to i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def lt_signed_to_large_negative_after := [llvm|
{
^0(%arg51 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lt_signed_to_large_negative_proof : lt_signed_to_large_negative_before ⊑ lt_signed_to_large_negative_after := by
  unfold lt_signed_to_large_negative_before lt_signed_to_large_negative_after
  simp_alive_peephole
  intros
  ---BEGIN lt_signed_to_large_negative
  apply lt_signed_to_large_negative_thm
  ---END lt_signed_to_large_negative



def lt_signed_to_small_unsigned_before := [llvm|
{
^0(%arg50 : i8):
  %0 = llvm.mlir.constant(17 : i32) : i32
  %1 = llvm.sext %arg50 : i8 to i32
  %2 = llvm.icmp "ult" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def lt_signed_to_small_unsigned_after := [llvm|
{
^0(%arg50 : i8):
  %0 = llvm.mlir.constant(17 : i8) : i8
  %1 = llvm.icmp "ult" %arg50, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lt_signed_to_small_unsigned_proof : lt_signed_to_small_unsigned_before ⊑ lt_signed_to_small_unsigned_after := by
  unfold lt_signed_to_small_unsigned_before lt_signed_to_small_unsigned_after
  simp_alive_peephole
  intros
  ---BEGIN lt_signed_to_small_unsigned
  apply lt_signed_to_small_unsigned_thm
  ---END lt_signed_to_small_unsigned



def lt_signed_to_small_signed_before := [llvm|
{
^0(%arg49 : i8):
  %0 = llvm.mlir.constant(17 : i32) : i32
  %1 = llvm.sext %arg49 : i8 to i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def lt_signed_to_small_signed_after := [llvm|
{
^0(%arg49 : i8):
  %0 = llvm.mlir.constant(17 : i8) : i8
  %1 = llvm.icmp "slt" %arg49, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lt_signed_to_small_signed_proof : lt_signed_to_small_signed_before ⊑ lt_signed_to_small_signed_after := by
  unfold lt_signed_to_small_signed_before lt_signed_to_small_signed_after
  simp_alive_peephole
  intros
  ---BEGIN lt_signed_to_small_signed
  apply lt_signed_to_small_signed_thm
  ---END lt_signed_to_small_signed



def lt_signed_to_small_negative_before := [llvm|
{
^0(%arg48 : i8):
  %0 = llvm.mlir.constant(-17 : i32) : i32
  %1 = llvm.sext %arg48 : i8 to i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def lt_signed_to_small_negative_after := [llvm|
{
^0(%arg48 : i8):
  %0 = llvm.mlir.constant(-17 : i8) : i8
  %1 = llvm.icmp "slt" %arg48, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lt_signed_to_small_negative_proof : lt_signed_to_small_negative_before ⊑ lt_signed_to_small_negative_after := by
  unfold lt_signed_to_small_negative_before lt_signed_to_small_negative_after
  simp_alive_peephole
  intros
  ---BEGIN lt_signed_to_small_negative
  apply lt_signed_to_small_negative_thm
  ---END lt_signed_to_small_negative



def lt_unsigned_to_large_unsigned_before := [llvm|
{
^0(%arg47 : i8):
  %0 = llvm.mlir.constant(1024 : i32) : i32
  %1 = llvm.zext %arg47 : i8 to i32
  %2 = llvm.icmp "ult" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def lt_unsigned_to_large_unsigned_after := [llvm|
{
^0(%arg47 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lt_unsigned_to_large_unsigned_proof : lt_unsigned_to_large_unsigned_before ⊑ lt_unsigned_to_large_unsigned_after := by
  unfold lt_unsigned_to_large_unsigned_before lt_unsigned_to_large_unsigned_after
  simp_alive_peephole
  intros
  ---BEGIN lt_unsigned_to_large_unsigned
  apply lt_unsigned_to_large_unsigned_thm
  ---END lt_unsigned_to_large_unsigned



def lt_unsigned_to_large_signed_before := [llvm|
{
^0(%arg46 : i8):
  %0 = llvm.mlir.constant(1024 : i32) : i32
  %1 = llvm.zext %arg46 : i8 to i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def lt_unsigned_to_large_signed_after := [llvm|
{
^0(%arg46 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lt_unsigned_to_large_signed_proof : lt_unsigned_to_large_signed_before ⊑ lt_unsigned_to_large_signed_after := by
  unfold lt_unsigned_to_large_signed_before lt_unsigned_to_large_signed_after
  simp_alive_peephole
  intros
  ---BEGIN lt_unsigned_to_large_signed
  apply lt_unsigned_to_large_signed_thm
  ---END lt_unsigned_to_large_signed



def lt_unsigned_to_large_negative_before := [llvm|
{
^0(%arg45 : i8):
  %0 = llvm.mlir.constant(-1024 : i32) : i32
  %1 = llvm.zext %arg45 : i8 to i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def lt_unsigned_to_large_negative_after := [llvm|
{
^0(%arg45 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lt_unsigned_to_large_negative_proof : lt_unsigned_to_large_negative_before ⊑ lt_unsigned_to_large_negative_after := by
  unfold lt_unsigned_to_large_negative_before lt_unsigned_to_large_negative_after
  simp_alive_peephole
  intros
  ---BEGIN lt_unsigned_to_large_negative
  apply lt_unsigned_to_large_negative_thm
  ---END lt_unsigned_to_large_negative



def lt_unsigned_to_small_unsigned_before := [llvm|
{
^0(%arg44 : i8):
  %0 = llvm.mlir.constant(17 : i32) : i32
  %1 = llvm.zext %arg44 : i8 to i32
  %2 = llvm.icmp "ult" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def lt_unsigned_to_small_unsigned_after := [llvm|
{
^0(%arg44 : i8):
  %0 = llvm.mlir.constant(17 : i8) : i8
  %1 = llvm.icmp "ult" %arg44, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lt_unsigned_to_small_unsigned_proof : lt_unsigned_to_small_unsigned_before ⊑ lt_unsigned_to_small_unsigned_after := by
  unfold lt_unsigned_to_small_unsigned_before lt_unsigned_to_small_unsigned_after
  simp_alive_peephole
  intros
  ---BEGIN lt_unsigned_to_small_unsigned
  apply lt_unsigned_to_small_unsigned_thm
  ---END lt_unsigned_to_small_unsigned



def lt_unsigned_to_small_signed_before := [llvm|
{
^0(%arg43 : i8):
  %0 = llvm.mlir.constant(17 : i32) : i32
  %1 = llvm.zext %arg43 : i8 to i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def lt_unsigned_to_small_signed_after := [llvm|
{
^0(%arg43 : i8):
  %0 = llvm.mlir.constant(17 : i8) : i8
  %1 = llvm.icmp "ult" %arg43, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lt_unsigned_to_small_signed_proof : lt_unsigned_to_small_signed_before ⊑ lt_unsigned_to_small_signed_after := by
  unfold lt_unsigned_to_small_signed_before lt_unsigned_to_small_signed_after
  simp_alive_peephole
  intros
  ---BEGIN lt_unsigned_to_small_signed
  apply lt_unsigned_to_small_signed_thm
  ---END lt_unsigned_to_small_signed



def lt_unsigned_to_small_negative_before := [llvm|
{
^0(%arg42 : i8):
  %0 = llvm.mlir.constant(-17 : i32) : i32
  %1 = llvm.zext %arg42 : i8 to i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def lt_unsigned_to_small_negative_after := [llvm|
{
^0(%arg42 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lt_unsigned_to_small_negative_proof : lt_unsigned_to_small_negative_before ⊑ lt_unsigned_to_small_negative_after := by
  unfold lt_unsigned_to_small_negative_before lt_unsigned_to_small_negative_after
  simp_alive_peephole
  intros
  ---BEGIN lt_unsigned_to_small_negative
  apply lt_unsigned_to_small_negative_thm
  ---END lt_unsigned_to_small_negative



def gt_signed_to_large_unsigned_before := [llvm|
{
^0(%arg41 : i8):
  %0 = llvm.mlir.constant(1024 : i32) : i32
  %1 = llvm.sext %arg41 : i8 to i32
  %2 = llvm.icmp "ugt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def gt_signed_to_large_unsigned_after := [llvm|
{
^0(%arg41 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "slt" %arg41, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem gt_signed_to_large_unsigned_proof : gt_signed_to_large_unsigned_before ⊑ gt_signed_to_large_unsigned_after := by
  unfold gt_signed_to_large_unsigned_before gt_signed_to_large_unsigned_after
  simp_alive_peephole
  intros
  ---BEGIN gt_signed_to_large_unsigned
  apply gt_signed_to_large_unsigned_thm
  ---END gt_signed_to_large_unsigned



def gt_signed_to_large_signed_before := [llvm|
{
^0(%arg40 : i8):
  %0 = llvm.mlir.constant(1024 : i32) : i32
  %1 = llvm.sext %arg40 : i8 to i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def gt_signed_to_large_signed_after := [llvm|
{
^0(%arg40 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem gt_signed_to_large_signed_proof : gt_signed_to_large_signed_before ⊑ gt_signed_to_large_signed_after := by
  unfold gt_signed_to_large_signed_before gt_signed_to_large_signed_after
  simp_alive_peephole
  intros
  ---BEGIN gt_signed_to_large_signed
  apply gt_signed_to_large_signed_thm
  ---END gt_signed_to_large_signed



def gt_signed_to_large_negative_before := [llvm|
{
^0(%arg39 : i8):
  %0 = llvm.mlir.constant(-1024 : i32) : i32
  %1 = llvm.sext %arg39 : i8 to i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def gt_signed_to_large_negative_after := [llvm|
{
^0(%arg39 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem gt_signed_to_large_negative_proof : gt_signed_to_large_negative_before ⊑ gt_signed_to_large_negative_after := by
  unfold gt_signed_to_large_negative_before gt_signed_to_large_negative_after
  simp_alive_peephole
  intros
  ---BEGIN gt_signed_to_large_negative
  apply gt_signed_to_large_negative_thm
  ---END gt_signed_to_large_negative



def gt_signed_to_small_unsigned_before := [llvm|
{
^0(%arg38 : i8):
  %0 = llvm.mlir.constant(17 : i32) : i32
  %1 = llvm.sext %arg38 : i8 to i32
  %2 = llvm.icmp "ugt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def gt_signed_to_small_unsigned_after := [llvm|
{
^0(%arg38 : i8):
  %0 = llvm.mlir.constant(17 : i8) : i8
  %1 = llvm.icmp "ugt" %arg38, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem gt_signed_to_small_unsigned_proof : gt_signed_to_small_unsigned_before ⊑ gt_signed_to_small_unsigned_after := by
  unfold gt_signed_to_small_unsigned_before gt_signed_to_small_unsigned_after
  simp_alive_peephole
  intros
  ---BEGIN gt_signed_to_small_unsigned
  apply gt_signed_to_small_unsigned_thm
  ---END gt_signed_to_small_unsigned



def gt_signed_to_small_signed_before := [llvm|
{
^0(%arg37 : i8):
  %0 = llvm.mlir.constant(17 : i32) : i32
  %1 = llvm.sext %arg37 : i8 to i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def gt_signed_to_small_signed_after := [llvm|
{
^0(%arg37 : i8):
  %0 = llvm.mlir.constant(17 : i8) : i8
  %1 = llvm.icmp "sgt" %arg37, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem gt_signed_to_small_signed_proof : gt_signed_to_small_signed_before ⊑ gt_signed_to_small_signed_after := by
  unfold gt_signed_to_small_signed_before gt_signed_to_small_signed_after
  simp_alive_peephole
  intros
  ---BEGIN gt_signed_to_small_signed
  apply gt_signed_to_small_signed_thm
  ---END gt_signed_to_small_signed



def gt_signed_to_small_negative_before := [llvm|
{
^0(%arg36 : i8):
  %0 = llvm.mlir.constant(-17 : i32) : i32
  %1 = llvm.sext %arg36 : i8 to i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def gt_signed_to_small_negative_after := [llvm|
{
^0(%arg36 : i8):
  %0 = llvm.mlir.constant(-17 : i8) : i8
  %1 = llvm.icmp "sgt" %arg36, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem gt_signed_to_small_negative_proof : gt_signed_to_small_negative_before ⊑ gt_signed_to_small_negative_after := by
  unfold gt_signed_to_small_negative_before gt_signed_to_small_negative_after
  simp_alive_peephole
  intros
  ---BEGIN gt_signed_to_small_negative
  apply gt_signed_to_small_negative_thm
  ---END gt_signed_to_small_negative



def gt_unsigned_to_large_unsigned_before := [llvm|
{
^0(%arg35 : i8):
  %0 = llvm.mlir.constant(1024 : i32) : i32
  %1 = llvm.zext %arg35 : i8 to i32
  %2 = llvm.icmp "ugt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def gt_unsigned_to_large_unsigned_after := [llvm|
{
^0(%arg35 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem gt_unsigned_to_large_unsigned_proof : gt_unsigned_to_large_unsigned_before ⊑ gt_unsigned_to_large_unsigned_after := by
  unfold gt_unsigned_to_large_unsigned_before gt_unsigned_to_large_unsigned_after
  simp_alive_peephole
  intros
  ---BEGIN gt_unsigned_to_large_unsigned
  apply gt_unsigned_to_large_unsigned_thm
  ---END gt_unsigned_to_large_unsigned



def gt_unsigned_to_large_signed_before := [llvm|
{
^0(%arg34 : i8):
  %0 = llvm.mlir.constant(1024 : i32) : i32
  %1 = llvm.zext %arg34 : i8 to i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def gt_unsigned_to_large_signed_after := [llvm|
{
^0(%arg34 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem gt_unsigned_to_large_signed_proof : gt_unsigned_to_large_signed_before ⊑ gt_unsigned_to_large_signed_after := by
  unfold gt_unsigned_to_large_signed_before gt_unsigned_to_large_signed_after
  simp_alive_peephole
  intros
  ---BEGIN gt_unsigned_to_large_signed
  apply gt_unsigned_to_large_signed_thm
  ---END gt_unsigned_to_large_signed



def gt_unsigned_to_large_negative_before := [llvm|
{
^0(%arg33 : i8):
  %0 = llvm.mlir.constant(-1024 : i32) : i32
  %1 = llvm.zext %arg33 : i8 to i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def gt_unsigned_to_large_negative_after := [llvm|
{
^0(%arg33 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem gt_unsigned_to_large_negative_proof : gt_unsigned_to_large_negative_before ⊑ gt_unsigned_to_large_negative_after := by
  unfold gt_unsigned_to_large_negative_before gt_unsigned_to_large_negative_after
  simp_alive_peephole
  intros
  ---BEGIN gt_unsigned_to_large_negative
  apply gt_unsigned_to_large_negative_thm
  ---END gt_unsigned_to_large_negative



def gt_unsigned_to_small_unsigned_before := [llvm|
{
^0(%arg32 : i8):
  %0 = llvm.mlir.constant(17 : i32) : i32
  %1 = llvm.zext %arg32 : i8 to i32
  %2 = llvm.icmp "ugt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def gt_unsigned_to_small_unsigned_after := [llvm|
{
^0(%arg32 : i8):
  %0 = llvm.mlir.constant(17 : i8) : i8
  %1 = llvm.icmp "ugt" %arg32, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem gt_unsigned_to_small_unsigned_proof : gt_unsigned_to_small_unsigned_before ⊑ gt_unsigned_to_small_unsigned_after := by
  unfold gt_unsigned_to_small_unsigned_before gt_unsigned_to_small_unsigned_after
  simp_alive_peephole
  intros
  ---BEGIN gt_unsigned_to_small_unsigned
  apply gt_unsigned_to_small_unsigned_thm
  ---END gt_unsigned_to_small_unsigned



def gt_unsigned_to_small_signed_before := [llvm|
{
^0(%arg31 : i8):
  %0 = llvm.mlir.constant(17 : i32) : i32
  %1 = llvm.zext %arg31 : i8 to i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def gt_unsigned_to_small_signed_after := [llvm|
{
^0(%arg31 : i8):
  %0 = llvm.mlir.constant(17 : i8) : i8
  %1 = llvm.icmp "ugt" %arg31, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem gt_unsigned_to_small_signed_proof : gt_unsigned_to_small_signed_before ⊑ gt_unsigned_to_small_signed_after := by
  unfold gt_unsigned_to_small_signed_before gt_unsigned_to_small_signed_after
  simp_alive_peephole
  intros
  ---BEGIN gt_unsigned_to_small_signed
  apply gt_unsigned_to_small_signed_thm
  ---END gt_unsigned_to_small_signed



def gt_unsigned_to_small_negative_before := [llvm|
{
^0(%arg30 : i8):
  %0 = llvm.mlir.constant(-17 : i32) : i32
  %1 = llvm.zext %arg30 : i8 to i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def gt_unsigned_to_small_negative_after := [llvm|
{
^0(%arg30 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem gt_unsigned_to_small_negative_proof : gt_unsigned_to_small_negative_before ⊑ gt_unsigned_to_small_negative_after := by
  unfold gt_unsigned_to_small_negative_before gt_unsigned_to_small_negative_after
  simp_alive_peephole
  intros
  ---BEGIN gt_unsigned_to_small_negative
  apply gt_unsigned_to_small_negative_thm
  ---END gt_unsigned_to_small_negative



def different_size_zext_zext_ugt_before := [llvm|
{
^0(%arg28 : i7, %arg29 : i4):
  %0 = llvm.zext %arg28 : i7 to i25
  %1 = llvm.zext %arg29 : i4 to i25
  %2 = llvm.icmp "ugt" %0, %1 : i25
  "llvm.return"(%2) : (i1) -> ()
}
]
def different_size_zext_zext_ugt_after := [llvm|
{
^0(%arg28 : i7, %arg29 : i4):
  %0 = llvm.zext %arg29 : i4 to i7
  %1 = llvm.icmp "ugt" %arg28, %0 : i7
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem different_size_zext_zext_ugt_proof : different_size_zext_zext_ugt_before ⊑ different_size_zext_zext_ugt_after := by
  unfold different_size_zext_zext_ugt_before different_size_zext_zext_ugt_after
  simp_alive_peephole
  intros
  ---BEGIN different_size_zext_zext_ugt
  apply different_size_zext_zext_ugt_thm
  ---END different_size_zext_zext_ugt



def different_size_zext_zext_ult_before := [llvm|
{
^0(%arg24 : i4, %arg25 : i7):
  %0 = llvm.zext %arg24 : i4 to i25
  %1 = llvm.zext %arg25 : i7 to i25
  %2 = llvm.icmp "ult" %0, %1 : i25
  "llvm.return"(%2) : (i1) -> ()
}
]
def different_size_zext_zext_ult_after := [llvm|
{
^0(%arg24 : i4, %arg25 : i7):
  %0 = llvm.zext %arg24 : i4 to i7
  %1 = llvm.icmp "ugt" %arg25, %0 : i7
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem different_size_zext_zext_ult_proof : different_size_zext_zext_ult_before ⊑ different_size_zext_zext_ult_after := by
  unfold different_size_zext_zext_ult_before different_size_zext_zext_ult_after
  simp_alive_peephole
  intros
  ---BEGIN different_size_zext_zext_ult
  apply different_size_zext_zext_ult_thm
  ---END different_size_zext_zext_ult



def different_size_zext_zext_eq_before := [llvm|
{
^0(%arg22 : i4, %arg23 : i7):
  %0 = llvm.zext %arg22 : i4 to i25
  %1 = llvm.zext %arg23 : i7 to i25
  %2 = llvm.icmp "eq" %0, %1 : i25
  "llvm.return"(%2) : (i1) -> ()
}
]
def different_size_zext_zext_eq_after := [llvm|
{
^0(%arg22 : i4, %arg23 : i7):
  %0 = llvm.zext %arg22 : i4 to i7
  %1 = llvm.icmp "eq" %arg23, %0 : i7
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem different_size_zext_zext_eq_proof : different_size_zext_zext_eq_before ⊑ different_size_zext_zext_eq_after := by
  unfold different_size_zext_zext_eq_before different_size_zext_zext_eq_after
  simp_alive_peephole
  intros
  ---BEGIN different_size_zext_zext_eq
  apply different_size_zext_zext_eq_thm
  ---END different_size_zext_zext_eq



def different_size_zext_zext_ne_commute_before := [llvm|
{
^0(%arg20 : i7, %arg21 : i4):
  %0 = llvm.zext %arg20 : i7 to i25
  %1 = llvm.zext %arg21 : i4 to i25
  %2 = llvm.icmp "ne" %0, %1 : i25
  "llvm.return"(%2) : (i1) -> ()
}
]
def different_size_zext_zext_ne_commute_after := [llvm|
{
^0(%arg20 : i7, %arg21 : i4):
  %0 = llvm.zext %arg21 : i4 to i7
  %1 = llvm.icmp "ne" %arg20, %0 : i7
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem different_size_zext_zext_ne_commute_proof : different_size_zext_zext_ne_commute_before ⊑ different_size_zext_zext_ne_commute_after := by
  unfold different_size_zext_zext_ne_commute_before different_size_zext_zext_ne_commute_after
  simp_alive_peephole
  intros
  ---BEGIN different_size_zext_zext_ne_commute
  apply different_size_zext_zext_ne_commute_thm
  ---END different_size_zext_zext_ne_commute



def different_size_zext_zext_slt_before := [llvm|
{
^0(%arg18 : i7, %arg19 : i4):
  %0 = llvm.zext %arg18 : i7 to i25
  %1 = llvm.zext %arg19 : i4 to i25
  %2 = llvm.icmp "slt" %0, %1 : i25
  "llvm.return"(%2) : (i1) -> ()
}
]
def different_size_zext_zext_slt_after := [llvm|
{
^0(%arg18 : i7, %arg19 : i4):
  %0 = llvm.zext %arg19 : i4 to i7
  %1 = llvm.icmp "ult" %arg18, %0 : i7
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem different_size_zext_zext_slt_proof : different_size_zext_zext_slt_before ⊑ different_size_zext_zext_slt_after := by
  unfold different_size_zext_zext_slt_before different_size_zext_zext_slt_after
  simp_alive_peephole
  intros
  ---BEGIN different_size_zext_zext_slt
  apply different_size_zext_zext_slt_thm
  ---END different_size_zext_zext_slt



def different_size_zext_zext_sgt_before := [llvm|
{
^0(%arg16 : i7, %arg17 : i4):
  %0 = llvm.zext %arg16 : i7 to i25
  %1 = llvm.zext %arg17 : i4 to i25
  %2 = llvm.icmp "sgt" %0, %1 : i25
  "llvm.return"(%2) : (i1) -> ()
}
]
def different_size_zext_zext_sgt_after := [llvm|
{
^0(%arg16 : i7, %arg17 : i4):
  %0 = llvm.zext %arg17 : i4 to i7
  %1 = llvm.icmp "ugt" %arg16, %0 : i7
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem different_size_zext_zext_sgt_proof : different_size_zext_zext_sgt_before ⊑ different_size_zext_zext_sgt_after := by
  unfold different_size_zext_zext_sgt_before different_size_zext_zext_sgt_after
  simp_alive_peephole
  intros
  ---BEGIN different_size_zext_zext_sgt
  apply different_size_zext_zext_sgt_thm
  ---END different_size_zext_zext_sgt



def different_size_sext_sext_sgt_before := [llvm|
{
^0(%arg14 : i7, %arg15 : i4):
  %0 = llvm.sext %arg14 : i7 to i25
  %1 = llvm.sext %arg15 : i4 to i25
  %2 = llvm.icmp "sgt" %0, %1 : i25
  "llvm.return"(%2) : (i1) -> ()
}
]
def different_size_sext_sext_sgt_after := [llvm|
{
^0(%arg14 : i7, %arg15 : i4):
  %0 = llvm.sext %arg15 : i4 to i7
  %1 = llvm.icmp "sgt" %arg14, %0 : i7
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem different_size_sext_sext_sgt_proof : different_size_sext_sext_sgt_before ⊑ different_size_sext_sext_sgt_after := by
  unfold different_size_sext_sext_sgt_before different_size_sext_sext_sgt_after
  simp_alive_peephole
  intros
  ---BEGIN different_size_sext_sext_sgt
  apply different_size_sext_sext_sgt_thm
  ---END different_size_sext_sext_sgt



def different_size_sext_sext_sle_before := [llvm|
{
^0(%arg12 : i7, %arg13 : i4):
  %0 = llvm.sext %arg12 : i7 to i25
  %1 = llvm.sext %arg13 : i4 to i25
  %2 = llvm.icmp "sle" %0, %1 : i25
  "llvm.return"(%2) : (i1) -> ()
}
]
def different_size_sext_sext_sle_after := [llvm|
{
^0(%arg12 : i7, %arg13 : i4):
  %0 = llvm.sext %arg13 : i4 to i7
  %1 = llvm.icmp "sle" %arg12, %0 : i7
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem different_size_sext_sext_sle_proof : different_size_sext_sext_sle_before ⊑ different_size_sext_sext_sle_after := by
  unfold different_size_sext_sext_sle_before different_size_sext_sext_sle_after
  simp_alive_peephole
  intros
  ---BEGIN different_size_sext_sext_sle
  apply different_size_sext_sext_sle_thm
  ---END different_size_sext_sext_sle



def different_size_sext_sext_eq_before := [llvm|
{
^0(%arg10 : i7, %arg11 : i4):
  %0 = llvm.sext %arg10 : i7 to i25
  %1 = llvm.sext %arg11 : i4 to i25
  %2 = llvm.icmp "eq" %0, %1 : i25
  "llvm.return"(%2) : (i1) -> ()
}
]
def different_size_sext_sext_eq_after := [llvm|
{
^0(%arg10 : i7, %arg11 : i4):
  %0 = llvm.sext %arg11 : i4 to i7
  %1 = llvm.icmp "eq" %arg10, %0 : i7
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem different_size_sext_sext_eq_proof : different_size_sext_sext_eq_before ⊑ different_size_sext_sext_eq_after := by
  unfold different_size_sext_sext_eq_before different_size_sext_sext_eq_after
  simp_alive_peephole
  intros
  ---BEGIN different_size_sext_sext_eq
  apply different_size_sext_sext_eq_thm
  ---END different_size_sext_sext_eq



def different_size_sext_sext_ule_before := [llvm|
{
^0(%arg8 : i7, %arg9 : i4):
  %0 = llvm.sext %arg8 : i7 to i25
  %1 = llvm.sext %arg9 : i4 to i25
  %2 = llvm.icmp "ule" %0, %1 : i25
  "llvm.return"(%2) : (i1) -> ()
}
]
def different_size_sext_sext_ule_after := [llvm|
{
^0(%arg8 : i7, %arg9 : i4):
  %0 = llvm.sext %arg9 : i4 to i7
  %1 = llvm.icmp "ule" %arg8, %0 : i7
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem different_size_sext_sext_ule_proof : different_size_sext_sext_ule_before ⊑ different_size_sext_sext_ule_after := by
  unfold different_size_sext_sext_ule_before different_size_sext_sext_ule_after
  simp_alive_peephole
  intros
  ---BEGIN different_size_sext_sext_ule
  apply different_size_sext_sext_ule_thm
  ---END different_size_sext_sext_ule


