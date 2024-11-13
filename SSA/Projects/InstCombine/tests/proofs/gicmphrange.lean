import SSA.Projects.InstCombine.tests.proofs.gicmphrange_proof
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
section gicmphrange_statements

def ugt_zext_before := [llvm|
{
^0(%arg174 : i1, %arg175 : i8):
  %0 = llvm.zext %arg174 : i1 to i8
  %1 = llvm.icmp "ugt" %0, %arg175 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def ugt_zext_after := [llvm|
{
^0(%arg174 : i1, %arg175 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg175, %0 : i8
  %2 = llvm.and %1, %arg174 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_zext_proof : ugt_zext_before ⊑ ugt_zext_after := by
  unfold ugt_zext_before ugt_zext_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_zext
  apply ugt_zext_thm
  ---END ugt_zext



def uge_zext_before := [llvm|
{
^0(%arg170 : i1, %arg171 : i8):
  %0 = llvm.zext %arg170 : i1 to i8
  %1 = llvm.icmp "uge" %0, %arg171 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def uge_zext_after := [llvm|
{
^0(%arg170 : i1, %arg171 : i8):
  %0 = llvm.zext %arg170 : i1 to i8
  %1 = llvm.icmp "ule" %arg171, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_zext_proof : uge_zext_before ⊑ uge_zext_after := by
  unfold uge_zext_before uge_zext_after
  simp_alive_peephole
  intros
  ---BEGIN uge_zext
  apply uge_zext_thm
  ---END uge_zext



def sub_ult_zext_before := [llvm|
{
^0(%arg161 : i1, %arg162 : i8, %arg163 : i8):
  %0 = llvm.zext %arg161 : i1 to i8
  %1 = llvm.sub %arg162, %arg163 : i8
  %2 = llvm.icmp "ult" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def sub_ult_zext_after := [llvm|
{
^0(%arg161 : i1, %arg162 : i8, %arg163 : i8):
  %0 = llvm.icmp "eq" %arg162, %arg163 : i8
  %1 = llvm.and %0, %arg161 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_ult_zext_proof : sub_ult_zext_before ⊑ sub_ult_zext_after := by
  unfold sub_ult_zext_before sub_ult_zext_after
  simp_alive_peephole
  intros
  ---BEGIN sub_ult_zext
  apply sub_ult_zext_thm
  ---END sub_ult_zext



def zext_ult_zext_before := [llvm|
{
^0(%arg159 : i1, %arg160 : i8):
  %0 = llvm.mul %arg160, %arg160 : i8
  %1 = llvm.zext %arg159 : i1 to i16
  %2 = llvm.zext %0 : i8 to i16
  %3 = llvm.icmp "ult" %2, %1 : i16
  "llvm.return"(%3) : (i1) -> ()
}
]
def zext_ult_zext_after := [llvm|
{
^0(%arg159 : i1, %arg160 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mul %arg160, %arg160 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  %3 = llvm.and %2, %arg159 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_ult_zext_proof : zext_ult_zext_before ⊑ zext_ult_zext_after := by
  unfold zext_ult_zext_before zext_ult_zext_after
  simp_alive_peephole
  intros
  ---BEGIN zext_ult_zext
  apply zext_ult_zext_thm
  ---END zext_ult_zext



def uge_sext_before := [llvm|
{
^0(%arg134 : i1, %arg135 : i8):
  %0 = llvm.sext %arg134 : i1 to i8
  %1 = llvm.icmp "uge" %0, %arg135 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def uge_sext_after := [llvm|
{
^0(%arg134 : i1, %arg135 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg135, %0 : i8
  %2 = llvm.or %1, %arg134 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_sext_proof : uge_sext_before ⊑ uge_sext_after := by
  unfold uge_sext_before uge_sext_after
  simp_alive_peephole
  intros
  ---BEGIN uge_sext
  apply uge_sext_thm
  ---END uge_sext



def ugt_sext_before := [llvm|
{
^0(%arg130 : i1, %arg131 : i8):
  %0 = llvm.sext %arg130 : i1 to i8
  %1 = llvm.icmp "ugt" %0, %arg131 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
def ugt_sext_after := [llvm|
{
^0(%arg130 : i1, %arg131 : i8):
  %0 = llvm.sext %arg130 : i1 to i8
  %1 = llvm.icmp "ult" %arg131, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_sext_proof : ugt_sext_before ⊑ ugt_sext_after := by
  unfold ugt_sext_before ugt_sext_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_sext
  apply ugt_sext_thm
  ---END ugt_sext



def sub_ule_sext_before := [llvm|
{
^0(%arg121 : i1, %arg122 : i8, %arg123 : i8):
  %0 = llvm.sext %arg121 : i1 to i8
  %1 = llvm.sub %arg122, %arg123 : i8
  %2 = llvm.icmp "ule" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def sub_ule_sext_after := [llvm|
{
^0(%arg121 : i1, %arg122 : i8, %arg123 : i8):
  %0 = llvm.icmp "eq" %arg122, %arg123 : i8
  %1 = llvm.or %0, %arg121 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_ule_sext_proof : sub_ule_sext_before ⊑ sub_ule_sext_after := by
  unfold sub_ule_sext_before sub_ule_sext_after
  simp_alive_peephole
  intros
  ---BEGIN sub_ule_sext
  apply sub_ule_sext_thm
  ---END sub_ule_sext



def sext_ule_sext_before := [llvm|
{
^0(%arg119 : i1, %arg120 : i8):
  %0 = llvm.mul %arg120, %arg120 : i8
  %1 = llvm.sext %arg119 : i1 to i16
  %2 = llvm.sext %0 : i8 to i16
  %3 = llvm.icmp "ule" %2, %1 : i16
  "llvm.return"(%3) : (i1) -> ()
}
]
def sext_ule_sext_after := [llvm|
{
^0(%arg119 : i1, %arg120 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mul %arg120, %arg120 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  %3 = llvm.or %2, %arg119 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_ule_sext_proof : sext_ule_sext_before ⊑ sext_ule_sext_after := by
  unfold sext_ule_sext_before sext_ule_sext_after
  simp_alive_peephole
  intros
  ---BEGIN sext_ule_sext
  apply sext_ule_sext_thm
  ---END sext_ule_sext



def zext_sext_add_icmp_slt_minus1_before := [llvm|
{
^0(%arg94 : i1, %arg95 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.zext %arg94 : i1 to i8
  %2 = llvm.sext %arg95 : i1 to i8
  %3 = llvm.add %1, %2 : i8
  %4 = llvm.icmp "slt" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_add_icmp_slt_minus1_after := [llvm|
{
^0(%arg94 : i1, %arg95 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_slt_minus1_proof : zext_sext_add_icmp_slt_minus1_before ⊑ zext_sext_add_icmp_slt_minus1_after := by
  unfold zext_sext_add_icmp_slt_minus1_before zext_sext_add_icmp_slt_minus1_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_slt_minus1
  apply zext_sext_add_icmp_slt_minus1_thm
  ---END zext_sext_add_icmp_slt_minus1



def zext_sext_add_icmp_sgt_1_before := [llvm|
{
^0(%arg92 : i1, %arg93 : i1):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.zext %arg92 : i1 to i8
  %2 = llvm.sext %arg93 : i1 to i8
  %3 = llvm.add %1, %2 : i8
  %4 = llvm.icmp "sgt" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_add_icmp_sgt_1_after := [llvm|
{
^0(%arg92 : i1, %arg93 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_sgt_1_proof : zext_sext_add_icmp_sgt_1_before ⊑ zext_sext_add_icmp_sgt_1_after := by
  unfold zext_sext_add_icmp_sgt_1_before zext_sext_add_icmp_sgt_1_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_sgt_1
  apply zext_sext_add_icmp_sgt_1_thm
  ---END zext_sext_add_icmp_sgt_1



def zext_sext_add_icmp_sgt_minus2_before := [llvm|
{
^0(%arg90 : i1, %arg91 : i1):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.zext %arg90 : i1 to i8
  %2 = llvm.sext %arg91 : i1 to i8
  %3 = llvm.add %1, %2 : i8
  %4 = llvm.icmp "sgt" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_add_icmp_sgt_minus2_after := [llvm|
{
^0(%arg90 : i1, %arg91 : i1):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_sgt_minus2_proof : zext_sext_add_icmp_sgt_minus2_before ⊑ zext_sext_add_icmp_sgt_minus2_after := by
  unfold zext_sext_add_icmp_sgt_minus2_before zext_sext_add_icmp_sgt_minus2_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_sgt_minus2
  apply zext_sext_add_icmp_sgt_minus2_thm
  ---END zext_sext_add_icmp_sgt_minus2



def zext_sext_add_icmp_slt_2_before := [llvm|
{
^0(%arg88 : i1, %arg89 : i1):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.zext %arg88 : i1 to i8
  %2 = llvm.sext %arg89 : i1 to i8
  %3 = llvm.add %1, %2 : i8
  %4 = llvm.icmp "slt" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_add_icmp_slt_2_after := [llvm|
{
^0(%arg88 : i1, %arg89 : i1):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_slt_2_proof : zext_sext_add_icmp_slt_2_before ⊑ zext_sext_add_icmp_slt_2_after := by
  unfold zext_sext_add_icmp_slt_2_before zext_sext_add_icmp_slt_2_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_slt_2
  apply zext_sext_add_icmp_slt_2_thm
  ---END zext_sext_add_icmp_slt_2



def zext_sext_add_icmp_i128_before := [llvm|
{
^0(%arg86 : i1, %arg87 : i1):
  %0 = llvm.mlir.constant(9223372036854775808 : i128) : i128
  %1 = llvm.zext %arg86 : i1 to i128
  %2 = llvm.sext %arg87 : i1 to i128
  %3 = llvm.add %1, %2 : i128
  %4 = llvm.icmp "sgt" %3, %0 : i128
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_add_icmp_i128_after := [llvm|
{
^0(%arg86 : i1, %arg87 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_i128_proof : zext_sext_add_icmp_i128_before ⊑ zext_sext_add_icmp_i128_after := by
  unfold zext_sext_add_icmp_i128_before zext_sext_add_icmp_i128_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_i128
  apply zext_sext_add_icmp_i128_thm
  ---END zext_sext_add_icmp_i128



def zext_sext_add_icmp_eq_minus1_before := [llvm|
{
^0(%arg84 : i1, %arg85 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.zext %arg84 : i1 to i8
  %2 = llvm.sext %arg85 : i1 to i8
  %3 = llvm.add %1, %2 : i8
  %4 = llvm.icmp "eq" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_add_icmp_eq_minus1_after := [llvm|
{
^0(%arg84 : i1, %arg85 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg84, %0 : i1
  %2 = llvm.and %arg85, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_eq_minus1_proof : zext_sext_add_icmp_eq_minus1_before ⊑ zext_sext_add_icmp_eq_minus1_after := by
  unfold zext_sext_add_icmp_eq_minus1_before zext_sext_add_icmp_eq_minus1_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_eq_minus1
  apply zext_sext_add_icmp_eq_minus1_thm
  ---END zext_sext_add_icmp_eq_minus1



def zext_sext_add_icmp_ne_minus1_before := [llvm|
{
^0(%arg82 : i1, %arg83 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.zext %arg82 : i1 to i8
  %2 = llvm.sext %arg83 : i1 to i8
  %3 = llvm.add %1, %2 : i8
  %4 = llvm.icmp "ne" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_add_icmp_ne_minus1_after := [llvm|
{
^0(%arg82 : i1, %arg83 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg83, %0 : i1
  %2 = llvm.or %arg82, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_ne_minus1_proof : zext_sext_add_icmp_ne_minus1_before ⊑ zext_sext_add_icmp_ne_minus1_after := by
  unfold zext_sext_add_icmp_ne_minus1_before zext_sext_add_icmp_ne_minus1_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_ne_minus1
  apply zext_sext_add_icmp_ne_minus1_thm
  ---END zext_sext_add_icmp_ne_minus1



def zext_sext_add_icmp_sgt_minus1_before := [llvm|
{
^0(%arg80 : i1, %arg81 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.zext %arg80 : i1 to i8
  %2 = llvm.sext %arg81 : i1 to i8
  %3 = llvm.add %1, %2 : i8
  %4 = llvm.icmp "sgt" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_add_icmp_sgt_minus1_after := [llvm|
{
^0(%arg80 : i1, %arg81 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg81, %0 : i1
  %2 = llvm.or %arg80, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_sgt_minus1_proof : zext_sext_add_icmp_sgt_minus1_before ⊑ zext_sext_add_icmp_sgt_minus1_after := by
  unfold zext_sext_add_icmp_sgt_minus1_before zext_sext_add_icmp_sgt_minus1_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_sgt_minus1
  apply zext_sext_add_icmp_sgt_minus1_thm
  ---END zext_sext_add_icmp_sgt_minus1



def zext_sext_add_icmp_ult_minus1_before := [llvm|
{
^0(%arg78 : i1, %arg79 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.zext %arg78 : i1 to i8
  %2 = llvm.sext %arg79 : i1 to i8
  %3 = llvm.add %1, %2 : i8
  %4 = llvm.icmp "ult" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_add_icmp_ult_minus1_after := [llvm|
{
^0(%arg78 : i1, %arg79 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg79, %0 : i1
  %2 = llvm.or %arg78, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_ult_minus1_proof : zext_sext_add_icmp_ult_minus1_before ⊑ zext_sext_add_icmp_ult_minus1_after := by
  unfold zext_sext_add_icmp_ult_minus1_before zext_sext_add_icmp_ult_minus1_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_ult_minus1
  apply zext_sext_add_icmp_ult_minus1_thm
  ---END zext_sext_add_icmp_ult_minus1



def zext_sext_add_icmp_sgt_0_before := [llvm|
{
^0(%arg76 : i1, %arg77 : i1):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.zext %arg76 : i1 to i8
  %2 = llvm.sext %arg77 : i1 to i8
  %3 = llvm.add %1, %2 : i8
  %4 = llvm.icmp "sgt" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_add_icmp_sgt_0_after := [llvm|
{
^0(%arg76 : i1, %arg77 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg77, %0 : i1
  %2 = llvm.and %arg76, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_sgt_0_proof : zext_sext_add_icmp_sgt_0_before ⊑ zext_sext_add_icmp_sgt_0_after := by
  unfold zext_sext_add_icmp_sgt_0_before zext_sext_add_icmp_sgt_0_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_sgt_0
  apply zext_sext_add_icmp_sgt_0_thm
  ---END zext_sext_add_icmp_sgt_0



def zext_sext_add_icmp_slt_0_before := [llvm|
{
^0(%arg74 : i1, %arg75 : i1):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.zext %arg74 : i1 to i8
  %2 = llvm.sext %arg75 : i1 to i8
  %3 = llvm.add %1, %2 : i8
  %4 = llvm.icmp "slt" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_add_icmp_slt_0_after := [llvm|
{
^0(%arg74 : i1, %arg75 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg74, %0 : i1
  %2 = llvm.and %arg75, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_slt_0_proof : zext_sext_add_icmp_slt_0_before ⊑ zext_sext_add_icmp_slt_0_after := by
  unfold zext_sext_add_icmp_slt_0_before zext_sext_add_icmp_slt_0_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_slt_0
  apply zext_sext_add_icmp_slt_0_thm
  ---END zext_sext_add_icmp_slt_0



def zext_sext_add_icmp_eq_1_before := [llvm|
{
^0(%arg72 : i1, %arg73 : i1):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.zext %arg72 : i1 to i8
  %2 = llvm.sext %arg73 : i1 to i8
  %3 = llvm.add %1, %2 : i8
  %4 = llvm.icmp "eq" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_add_icmp_eq_1_after := [llvm|
{
^0(%arg72 : i1, %arg73 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg73, %0 : i1
  %2 = llvm.and %arg72, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_eq_1_proof : zext_sext_add_icmp_eq_1_before ⊑ zext_sext_add_icmp_eq_1_after := by
  unfold zext_sext_add_icmp_eq_1_before zext_sext_add_icmp_eq_1_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_eq_1
  apply zext_sext_add_icmp_eq_1_thm
  ---END zext_sext_add_icmp_eq_1



def zext_sext_add_icmp_ne_1_before := [llvm|
{
^0(%arg70 : i1, %arg71 : i1):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.zext %arg70 : i1 to i8
  %2 = llvm.sext %arg71 : i1 to i8
  %3 = llvm.add %1, %2 : i8
  %4 = llvm.icmp "ne" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_add_icmp_ne_1_after := [llvm|
{
^0(%arg70 : i1, %arg71 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg70, %0 : i1
  %2 = llvm.or %arg71, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_ne_1_proof : zext_sext_add_icmp_ne_1_before ⊑ zext_sext_add_icmp_ne_1_after := by
  unfold zext_sext_add_icmp_ne_1_before zext_sext_add_icmp_ne_1_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_ne_1
  apply zext_sext_add_icmp_ne_1_thm
  ---END zext_sext_add_icmp_ne_1



def zext_sext_add_icmp_slt_1_before := [llvm|
{
^0(%arg68 : i1, %arg69 : i1):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.zext %arg68 : i1 to i8
  %2 = llvm.sext %arg69 : i1 to i8
  %3 = llvm.add %1, %2 : i8
  %4 = llvm.icmp "slt" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_add_icmp_slt_1_after := [llvm|
{
^0(%arg68 : i1, %arg69 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg68, %0 : i1
  %2 = llvm.or %arg69, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_slt_1_proof : zext_sext_add_icmp_slt_1_before ⊑ zext_sext_add_icmp_slt_1_after := by
  unfold zext_sext_add_icmp_slt_1_before zext_sext_add_icmp_slt_1_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_slt_1
  apply zext_sext_add_icmp_slt_1_thm
  ---END zext_sext_add_icmp_slt_1



def zext_sext_add_icmp_ugt_1_before := [llvm|
{
^0(%arg66 : i1, %arg67 : i1):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.zext %arg66 : i1 to i8
  %2 = llvm.sext %arg67 : i1 to i8
  %3 = llvm.add %1, %2 : i8
  %4 = llvm.icmp "ugt" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_add_icmp_ugt_1_after := [llvm|
{
^0(%arg66 : i1, %arg67 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg66, %0 : i1
  %2 = llvm.and %arg67, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_ugt_1_proof : zext_sext_add_icmp_ugt_1_before ⊑ zext_sext_add_icmp_ugt_1_after := by
  unfold zext_sext_add_icmp_ugt_1_before zext_sext_add_icmp_ugt_1_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_ugt_1
  apply zext_sext_add_icmp_ugt_1_thm
  ---END zext_sext_add_icmp_ugt_1



def zext_sext_add_icmp_slt_1_rhs_not_const_before := [llvm|
{
^0(%arg49 : i1, %arg50 : i1, %arg51 : i8):
  %0 = llvm.zext %arg49 : i1 to i8
  %1 = llvm.sext %arg50 : i1 to i8
  %2 = llvm.add %0, %1 : i8
  %3 = llvm.icmp "slt" %2, %arg51 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def zext_sext_add_icmp_slt_1_rhs_not_const_after := [llvm|
{
^0(%arg49 : i1, %arg50 : i1, %arg51 : i8):
  %0 = llvm.zext %arg49 : i1 to i8
  %1 = llvm.sext %arg50 : i1 to i8
  %2 = llvm.add %0, %1 overflow<nsw> : i8
  %3 = llvm.icmp "slt" %2, %arg51 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_slt_1_rhs_not_const_proof : zext_sext_add_icmp_slt_1_rhs_not_const_before ⊑ zext_sext_add_icmp_slt_1_rhs_not_const_after := by
  unfold zext_sext_add_icmp_slt_1_rhs_not_const_before zext_sext_add_icmp_slt_1_rhs_not_const_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_slt_1_rhs_not_const
  apply zext_sext_add_icmp_slt_1_rhs_not_const_thm
  ---END zext_sext_add_icmp_slt_1_rhs_not_const



def zext_sext_add_icmp_slt_1_type_not_i1_before := [llvm|
{
^0(%arg47 : i2, %arg48 : i1):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.zext %arg47 : i2 to i8
  %2 = llvm.sext %arg48 : i1 to i8
  %3 = llvm.add %1, %2 : i8
  %4 = llvm.icmp "slt" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def zext_sext_add_icmp_slt_1_type_not_i1_after := [llvm|
{
^0(%arg47 : i2, %arg48 : i1):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.zext %arg47 : i2 to i8
  %2 = llvm.sext %arg48 : i1 to i8
  %3 = llvm.add %1, %2 overflow<nsw> : i8
  %4 = llvm.icmp "slt" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sext_add_icmp_slt_1_type_not_i1_proof : zext_sext_add_icmp_slt_1_type_not_i1_before ⊑ zext_sext_add_icmp_slt_1_type_not_i1_after := by
  unfold zext_sext_add_icmp_slt_1_type_not_i1_before zext_sext_add_icmp_slt_1_type_not_i1_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sext_add_icmp_slt_1_type_not_i1
  apply zext_sext_add_icmp_slt_1_type_not_i1_thm
  ---END zext_sext_add_icmp_slt_1_type_not_i1



def icmp_ne_zext_eq_zero_before := [llvm|
{
^0(%arg42 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg42, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.icmp "ne" %2, %arg42 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_zext_eq_zero_after := [llvm|
{
^0(%arg42 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_zext_eq_zero_proof : icmp_ne_zext_eq_zero_before ⊑ icmp_ne_zext_eq_zero_after := by
  unfold icmp_ne_zext_eq_zero_before icmp_ne_zext_eq_zero_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_zext_eq_zero
  apply icmp_ne_zext_eq_zero_thm
  ---END icmp_ne_zext_eq_zero



def icmp_ne_zext_ne_zero_before := [llvm|
{
^0(%arg41 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg41, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.icmp "ne" %2, %arg41 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_zext_ne_zero_after := [llvm|
{
^0(%arg41 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "ugt" %arg41, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_zext_ne_zero_proof : icmp_ne_zext_ne_zero_before ⊑ icmp_ne_zext_ne_zero_after := by
  unfold icmp_ne_zext_ne_zero_before icmp_ne_zext_ne_zero_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_zext_ne_zero
  apply icmp_ne_zext_ne_zero_thm
  ---END icmp_ne_zext_ne_zero



def icmp_eq_zext_eq_zero_before := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg40, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.icmp "eq" %2, %arg40 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_zext_eq_zero_after := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_zext_eq_zero_proof : icmp_eq_zext_eq_zero_before ⊑ icmp_eq_zext_eq_zero_after := by
  unfold icmp_eq_zext_eq_zero_before icmp_eq_zext_eq_zero_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_zext_eq_zero
  apply icmp_eq_zext_eq_zero_thm
  ---END icmp_eq_zext_eq_zero



def icmp_eq_zext_ne_zero_before := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg39, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.icmp "eq" %2, %arg39 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_zext_ne_zero_after := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ult" %arg39, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_zext_ne_zero_proof : icmp_eq_zext_ne_zero_before ⊑ icmp_eq_zext_ne_zero_after := by
  unfold icmp_eq_zext_ne_zero_before icmp_eq_zext_ne_zero_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_zext_ne_zero
  apply icmp_eq_zext_ne_zero_thm
  ---END icmp_eq_zext_ne_zero



def icmp_ne_zext_eq_one_before := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg38, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.icmp "ne" %2, %arg38 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_zext_eq_one_after := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "ugt" %arg38, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_zext_eq_one_proof : icmp_ne_zext_eq_one_before ⊑ icmp_ne_zext_eq_one_after := by
  unfold icmp_ne_zext_eq_one_before icmp_ne_zext_eq_one_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_zext_eq_one
  apply icmp_ne_zext_eq_one_thm
  ---END icmp_ne_zext_eq_one



def icmp_ne_zext_ne_one_before := [llvm|
{
^0(%arg37 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "ne" %arg37, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.icmp "ne" %2, %arg37 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_zext_ne_one_after := [llvm|
{
^0(%arg37 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_zext_ne_one_proof : icmp_ne_zext_ne_one_before ⊑ icmp_ne_zext_ne_one_after := by
  unfold icmp_ne_zext_ne_one_before icmp_ne_zext_ne_one_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_zext_ne_one
  apply icmp_ne_zext_ne_one_thm
  ---END icmp_ne_zext_ne_one



def icmp_eq_zext_eq_one_before := [llvm|
{
^0(%arg36 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg36, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.icmp "eq" %2, %arg36 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_zext_eq_one_after := [llvm|
{
^0(%arg36 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ult" %arg36, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_zext_eq_one_proof : icmp_eq_zext_eq_one_before ⊑ icmp_eq_zext_eq_one_after := by
  unfold icmp_eq_zext_eq_one_before icmp_eq_zext_eq_one_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_zext_eq_one
  apply icmp_eq_zext_eq_one_thm
  ---END icmp_eq_zext_eq_one



def icmp_eq_zext_ne_one_before := [llvm|
{
^0(%arg35 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "ne" %arg35, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.icmp "eq" %2, %arg35 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_zext_ne_one_after := [llvm|
{
^0(%arg35 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_zext_ne_one_proof : icmp_eq_zext_ne_one_before ⊑ icmp_eq_zext_ne_one_after := by
  unfold icmp_eq_zext_ne_one_before icmp_eq_zext_ne_one_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_zext_ne_one
  apply icmp_eq_zext_ne_one_thm
  ---END icmp_eq_zext_ne_one



def icmp_ne_zext_eq_non_boolean_before := [llvm|
{
^0(%arg34 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "eq" %arg34, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.icmp "ne" %2, %arg34 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_zext_eq_non_boolean_after := [llvm|
{
^0(%arg34 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg34, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_zext_eq_non_boolean_proof : icmp_ne_zext_eq_non_boolean_before ⊑ icmp_ne_zext_eq_non_boolean_after := by
  unfold icmp_ne_zext_eq_non_boolean_before icmp_ne_zext_eq_non_boolean_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_zext_eq_non_boolean
  apply icmp_ne_zext_eq_non_boolean_thm
  ---END icmp_ne_zext_eq_non_boolean



def icmp_ne_zext_ne_non_boolean_before := [llvm|
{
^0(%arg33 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ne" %arg33, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.icmp "ne" %2, %arg33 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_zext_ne_non_boolean_after := [llvm|
{
^0(%arg33 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "ne" %arg33, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_zext_ne_non_boolean_proof : icmp_ne_zext_ne_non_boolean_before ⊑ icmp_ne_zext_ne_non_boolean_after := by
  unfold icmp_ne_zext_ne_non_boolean_before icmp_ne_zext_ne_non_boolean_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_zext_ne_non_boolean
  apply icmp_ne_zext_ne_non_boolean_thm
  ---END icmp_ne_zext_ne_non_boolean



def icmp_eq_zext_eq_non_boolean_before := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "eq" %arg32, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.icmp "eq" %2, %arg32 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_zext_eq_non_boolean_after := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg32, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_zext_eq_non_boolean_proof : icmp_eq_zext_eq_non_boolean_before ⊑ icmp_eq_zext_eq_non_boolean_after := by
  unfold icmp_eq_zext_eq_non_boolean_before icmp_eq_zext_eq_non_boolean_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_zext_eq_non_boolean
  apply icmp_eq_zext_eq_non_boolean_thm
  ---END icmp_eq_zext_eq_non_boolean



def icmp_eq_zext_ne_non_boolean_before := [llvm|
{
^0(%arg31 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ne" %arg31, %0 : i32
  %2 = llvm.zext %1 : i1 to i32
  %3 = llvm.icmp "eq" %2, %arg31 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_zext_ne_non_boolean_after := [llvm|
{
^0(%arg31 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.icmp "eq" %arg31, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_zext_ne_non_boolean_proof : icmp_eq_zext_ne_non_boolean_before ⊑ icmp_eq_zext_ne_non_boolean_after := by
  unfold icmp_eq_zext_ne_non_boolean_before icmp_eq_zext_ne_non_boolean_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_zext_ne_non_boolean
  apply icmp_eq_zext_ne_non_boolean_thm
  ---END icmp_eq_zext_ne_non_boolean



def icmp_ne_sext_eq_zero_before := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg25, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "ne" %2, %arg25 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_sext_eq_zero_after := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_sext_eq_zero_proof : icmp_ne_sext_eq_zero_before ⊑ icmp_ne_sext_eq_zero_after := by
  unfold icmp_ne_sext_eq_zero_before icmp_ne_sext_eq_zero_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_sext_eq_zero
  apply icmp_ne_sext_eq_zero_thm
  ---END icmp_ne_sext_eq_zero



def icmp_ne_sext_ne_zero_before := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg24, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "ne" %2, %arg24 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_sext_ne_zero_after := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.add %arg24, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_sext_ne_zero_proof : icmp_ne_sext_ne_zero_before ⊑ icmp_ne_sext_ne_zero_after := by
  unfold icmp_ne_sext_ne_zero_before icmp_ne_sext_ne_zero_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_sext_ne_zero
  apply icmp_ne_sext_ne_zero_thm
  ---END icmp_ne_sext_ne_zero



def icmp_eq_sext_eq_zero_before := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg23, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "eq" %2, %arg23 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_sext_eq_zero_after := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_sext_eq_zero_proof : icmp_eq_sext_eq_zero_before ⊑ icmp_eq_sext_eq_zero_after := by
  unfold icmp_eq_sext_eq_zero_before icmp_eq_sext_eq_zero_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_sext_eq_zero
  apply icmp_eq_sext_eq_zero_thm
  ---END icmp_eq_sext_eq_zero



def icmp_eq_sext_ne_zero_before := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg22, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "eq" %2, %arg22 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_sext_ne_zero_after := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.add %arg22, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_sext_ne_zero_proof : icmp_eq_sext_ne_zero_before ⊑ icmp_eq_sext_ne_zero_after := by
  unfold icmp_eq_sext_ne_zero_before icmp_eq_sext_ne_zero_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_sext_ne_zero
  apply icmp_eq_sext_ne_zero_thm
  ---END icmp_eq_sext_ne_zero



def icmp_ne_sext_eq_allones_before := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "eq" %arg21, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "ne" %2, %arg21 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_sext_eq_allones_after := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.add %arg21, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_sext_eq_allones_proof : icmp_ne_sext_eq_allones_before ⊑ icmp_ne_sext_eq_allones_after := by
  unfold icmp_ne_sext_eq_allones_before icmp_ne_sext_eq_allones_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_sext_eq_allones
  apply icmp_ne_sext_eq_allones_thm
  ---END icmp_ne_sext_eq_allones



def icmp_ne_sext_ne_allones_before := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "ne" %arg20, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "ne" %2, %arg20 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_sext_ne_allones_after := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_sext_ne_allones_proof : icmp_ne_sext_ne_allones_before ⊑ icmp_ne_sext_ne_allones_after := by
  unfold icmp_ne_sext_ne_allones_before icmp_ne_sext_ne_allones_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_sext_ne_allones
  apply icmp_ne_sext_ne_allones_thm
  ---END icmp_ne_sext_ne_allones



def icmp_eq_sext_eq_allones_before := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "eq" %arg19, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "eq" %2, %arg19 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_sext_eq_allones_after := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.add %arg19, %0 : i32
  %3 = llvm.icmp "ult" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_sext_eq_allones_proof : icmp_eq_sext_eq_allones_before ⊑ icmp_eq_sext_eq_allones_after := by
  unfold icmp_eq_sext_eq_allones_before icmp_eq_sext_eq_allones_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_sext_eq_allones
  apply icmp_eq_sext_eq_allones_thm
  ---END icmp_eq_sext_eq_allones



def icmp_eq_sext_ne_allones_before := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "ne" %arg18, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "eq" %2, %arg18 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_sext_ne_allones_after := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_sext_ne_allones_proof : icmp_eq_sext_ne_allones_before ⊑ icmp_eq_sext_ne_allones_after := by
  unfold icmp_eq_sext_ne_allones_before icmp_eq_sext_ne_allones_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_sext_ne_allones
  apply icmp_eq_sext_ne_allones_thm
  ---END icmp_eq_sext_ne_allones



def icmp_ne_sext_eq_otherwise_before := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "eq" %arg17, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "ne" %2, %arg17 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_sext_eq_otherwise_after := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg17, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_sext_eq_otherwise_proof : icmp_ne_sext_eq_otherwise_before ⊑ icmp_ne_sext_eq_otherwise_after := by
  unfold icmp_ne_sext_eq_otherwise_before icmp_ne_sext_eq_otherwise_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_sext_eq_otherwise
  apply icmp_ne_sext_eq_otherwise_thm
  ---END icmp_ne_sext_eq_otherwise



def icmp_ne_sext_ne_otherwise_before := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ne" %arg16, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "ne" %2, %arg16 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_sext_ne_otherwise_after := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "ne" %arg16, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_sext_ne_otherwise_proof : icmp_ne_sext_ne_otherwise_before ⊑ icmp_ne_sext_ne_otherwise_after := by
  unfold icmp_ne_sext_ne_otherwise_before icmp_ne_sext_ne_otherwise_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_sext_ne_otherwise
  apply icmp_ne_sext_ne_otherwise_thm
  ---END icmp_ne_sext_ne_otherwise



def icmp_eq_sext_eq_otherwise_before := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "eq" %arg15, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "eq" %2, %arg15 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_sext_eq_otherwise_after := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg15, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_sext_eq_otherwise_proof : icmp_eq_sext_eq_otherwise_before ⊑ icmp_eq_sext_eq_otherwise_after := by
  unfold icmp_eq_sext_eq_otherwise_before icmp_eq_sext_eq_otherwise_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_sext_eq_otherwise
  apply icmp_eq_sext_eq_otherwise_thm
  ---END icmp_eq_sext_eq_otherwise



def icmp_eq_sext_ne_otherwise_before := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ne" %arg14, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "eq" %2, %arg14 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_eq_sext_ne_otherwise_after := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "eq" %arg14, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_eq_sext_ne_otherwise_proof : icmp_eq_sext_ne_otherwise_before ⊑ icmp_eq_sext_ne_otherwise_after := by
  unfold icmp_eq_sext_ne_otherwise_before icmp_eq_sext_ne_otherwise_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_eq_sext_ne_otherwise
  apply icmp_eq_sext_ne_otherwise_thm
  ---END icmp_eq_sext_ne_otherwise



def icmp_ne_sext_ne_zero_i128_before := [llvm|
{
^0(%arg8 : i128):
  %0 = llvm.mlir.constant(0 : i128) : i128
  %1 = llvm.icmp "ne" %arg8, %0 : i128
  %2 = llvm.sext %1 : i1 to i128
  %3 = llvm.icmp "ne" %2, %arg8 : i128
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_sext_ne_zero_i128_after := [llvm|
{
^0(%arg8 : i128):
  %0 = llvm.mlir.constant(-1 : i128) : i128
  %1 = llvm.mlir.constant(-2 : i128) : i128
  %2 = llvm.add %arg8, %0 : i128
  %3 = llvm.icmp "ult" %2, %1 : i128
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_sext_ne_zero_i128_proof : icmp_ne_sext_ne_zero_i128_before ⊑ icmp_ne_sext_ne_zero_i128_after := by
  unfold icmp_ne_sext_ne_zero_i128_before icmp_ne_sext_ne_zero_i128_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_sext_ne_zero_i128
  apply icmp_ne_sext_ne_zero_i128_thm
  ---END icmp_ne_sext_ne_zero_i128



def icmp_ne_sext_ne_otherwise_i128_before := [llvm|
{
^0(%arg7 : i128):
  %0 = llvm.mlir.constant(2 : i128) : i128
  %1 = llvm.icmp "ne" %arg7, %0 : i128
  %2 = llvm.sext %1 : i1 to i128
  %3 = llvm.icmp "ne" %2, %arg7 : i128
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_sext_ne_otherwise_i128_after := [llvm|
{
^0(%arg7 : i128):
  %0 = llvm.mlir.constant(-1 : i128) : i128
  %1 = llvm.icmp "ne" %arg7, %0 : i128
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_sext_ne_otherwise_i128_proof : icmp_ne_sext_ne_otherwise_i128_before ⊑ icmp_ne_sext_ne_otherwise_i128_after := by
  unfold icmp_ne_sext_ne_otherwise_i128_before icmp_ne_sext_ne_otherwise_i128_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_sext_ne_otherwise_i128
  apply icmp_ne_sext_ne_otherwise_i128_thm
  ---END icmp_ne_sext_ne_otherwise_i128



def icmp_ne_sext_sgt_zero_nofold_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "sgt" %arg6, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "ne" %2, %arg6 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_sext_sgt_zero_nofold_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "sgt" %arg6, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "ne" %arg6, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_sext_sgt_zero_nofold_proof : icmp_ne_sext_sgt_zero_nofold_before ⊑ icmp_ne_sext_sgt_zero_nofold_after := by
  unfold icmp_ne_sext_sgt_zero_nofold_before icmp_ne_sext_sgt_zero_nofold_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_sext_sgt_zero_nofold
  apply icmp_ne_sext_sgt_zero_nofold_thm
  ---END icmp_ne_sext_sgt_zero_nofold



def icmp_slt_sext_ne_zero_nofold_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg5, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "slt" %2, %arg5 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_slt_sext_ne_zero_nofold_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "ne" %arg5, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "sgt" %arg5, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_sext_ne_zero_nofold_proof : icmp_slt_sext_ne_zero_nofold_before ⊑ icmp_slt_sext_ne_zero_nofold_after := by
  unfold icmp_slt_sext_ne_zero_nofold_before icmp_slt_sext_ne_zero_nofold_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_sext_ne_zero_nofold
  apply icmp_slt_sext_ne_zero_nofold_thm
  ---END icmp_slt_sext_ne_zero_nofold



def icmp_ne_sext_slt_allones_nofold_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "slt" %arg4, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "ne" %2, %arg4 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_sext_slt_allones_nofold_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "slt" %arg4, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "ne" %arg4, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_sext_slt_allones_nofold_proof : icmp_ne_sext_slt_allones_nofold_before ⊑ icmp_ne_sext_slt_allones_nofold_after := by
  unfold icmp_ne_sext_slt_allones_nofold_before icmp_ne_sext_slt_allones_nofold_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_sext_slt_allones_nofold
  apply icmp_ne_sext_slt_allones_nofold_thm
  ---END icmp_ne_sext_slt_allones_nofold



def icmp_slt_sext_ne_allones_nofold_before := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "ne" %arg3, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "slt" %2, %arg3 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_slt_sext_ne_allones_nofold_after := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.icmp "ne" %arg3, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "sgt" %arg3, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_sext_ne_allones_nofold_proof : icmp_slt_sext_ne_allones_nofold_before ⊑ icmp_slt_sext_ne_allones_nofold_after := by
  unfold icmp_slt_sext_ne_allones_nofold_before icmp_slt_sext_ne_allones_nofold_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_sext_ne_allones_nofold
  apply icmp_slt_sext_ne_allones_nofold_thm
  ---END icmp_slt_sext_ne_allones_nofold



def icmp_ne_sext_slt_otherwise_nofold_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "slt" %arg2, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "ne" %2, %arg2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_ne_sext_slt_otherwise_nofold_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "slt" %arg2, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "ne" %arg2, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ne_sext_slt_otherwise_nofold_proof : icmp_ne_sext_slt_otherwise_nofold_before ⊑ icmp_ne_sext_slt_otherwise_nofold_after := by
  unfold icmp_ne_sext_slt_otherwise_nofold_before icmp_ne_sext_slt_otherwise_nofold_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ne_sext_slt_otherwise_nofold
  apply icmp_ne_sext_slt_otherwise_nofold_thm
  ---END icmp_ne_sext_slt_otherwise_nofold



def icmp_slt_sext_ne_otherwise_nofold_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ne" %arg1, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "slt" %2, %arg1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def icmp_slt_sext_ne_otherwise_nofold_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.icmp "ne" %arg1, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "sgt" %arg1, %2 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_slt_sext_ne_otherwise_nofold_proof : icmp_slt_sext_ne_otherwise_nofold_before ⊑ icmp_slt_sext_ne_otherwise_nofold_after := by
  unfold icmp_slt_sext_ne_otherwise_nofold_before icmp_slt_sext_ne_otherwise_nofold_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_slt_sext_ne_otherwise_nofold
  apply icmp_slt_sext_ne_otherwise_nofold_thm
  ---END icmp_slt_sext_ne_otherwise_nofold


