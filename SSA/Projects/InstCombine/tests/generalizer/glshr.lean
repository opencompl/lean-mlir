import SSA.Projects.InstCombine.tests.proofs.glshr_proof
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
section glshr_statements

def lshr_exact_before := [llvm|
{
^0(%arg183 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.shl %arg183, %0 : i8
  %3 = llvm.add %2, %1 : i8
  %4 = llvm.lshr %3, %0 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def lshr_exact_after := [llvm|
{
^0(%arg183 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(63 : i8) : i8
  %2 = llvm.add %arg183, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_exact_proof : lshr_exact_before ⊑ lshr_exact_after := by
  unfold lshr_exact_before lshr_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_exact
  apply lshr_exact_thm
  ---END lshr_exact



def shl_add_before := [llvm|
{
^0(%arg179 : i8, %arg180 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.shl %arg179, %0 : i8
  %2 = llvm.add %1, %arg180 : i8
  %3 = llvm.lshr %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def shl_add_after := [llvm|
{
^0(%arg179 : i8, %arg180 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(63 : i8) : i8
  %2 = llvm.lshr %arg180, %0 : i8
  %3 = llvm.add %2, %arg179 : i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_proof : shl_add_before ⊑ shl_add_after := by
  unfold shl_add_before shl_add_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add
  apply shl_add_thm
  ---END shl_add



def bool_zext_before := [llvm|
{
^0(%arg172 : i1):
  %0 = llvm.mlir.constant(15 : i16) : i16
  %1 = llvm.sext %arg172 : i1 to i16
  %2 = llvm.lshr %1, %0 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def bool_zext_after := [llvm|
{
^0(%arg172 : i1):
  %0 = llvm.zext %arg172 : i1 to i16
  "llvm.return"(%0) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bool_zext_proof : bool_zext_before ⊑ bool_zext_after := by
  unfold bool_zext_before bool_zext_after
  simp_alive_peephole
  intros
  ---BEGIN bool_zext
  apply bool_zext_thm
  ---END bool_zext



def smear_sign_and_widen_before := [llvm|
{
^0(%arg169 : i8):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.sext %arg169 : i8 to i32
  %2 = llvm.lshr %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def smear_sign_and_widen_after := [llvm|
{
^0(%arg169 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.ashr %arg169, %0 : i8
  %2 = llvm.zext %1 : i8 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem smear_sign_and_widen_proof : smear_sign_and_widen_before ⊑ smear_sign_and_widen_after := by
  unfold smear_sign_and_widen_before smear_sign_and_widen_after
  simp_alive_peephole
  intros
  ---BEGIN smear_sign_and_widen
  apply smear_sign_and_widen_thm
  ---END smear_sign_and_widen



def fake_sext_before := [llvm|
{
^0(%arg166 : i3):
  %0 = llvm.mlir.constant(17 : i18) : i18
  %1 = llvm.sext %arg166 : i3 to i18
  %2 = llvm.lshr %1, %0 : i18
  "llvm.return"(%2) : (i18) -> ()
}
]
def fake_sext_after := [llvm|
{
^0(%arg166 : i3):
  %0 = llvm.mlir.constant(2 : i3) : i3
  %1 = llvm.lshr %arg166, %0 : i3
  %2 = llvm.zext nneg %1 : i3 to i18
  "llvm.return"(%2) : (i18) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fake_sext_proof : fake_sext_before ⊑ fake_sext_after := by
  unfold fake_sext_before fake_sext_after
  simp_alive_peephole
  intros
  ---BEGIN fake_sext
  apply fake_sext_thm
  ---END fake_sext



def mul_splat_fold_before := [llvm|
{
^0(%arg161 : i32):
  %0 = llvm.mlir.constant(65537 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mul %arg161, %0 overflow<nuw> : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def mul_splat_fold_after := [llvm|
{
^0(%arg161 : i32):
  "llvm.return"(%arg161) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_splat_fold_proof : mul_splat_fold_before ⊑ mul_splat_fold_after := by
  unfold mul_splat_fold_before mul_splat_fold_after
  simp_alive_peephole
  intros
  ---BEGIN mul_splat_fold
  apply mul_splat_fold_thm
  ---END mul_splat_fold



def shl_add_lshr_flag_preservation_before := [llvm|
{
^0(%arg157 : i32, %arg158 : i32, %arg159 : i32):
  %0 = llvm.shl %arg157, %arg158 overflow<nuw> : i32
  %1 = llvm.add %0, %arg159 overflow<nsw,nuw> : i32
  %2 = llvm.lshr exact %1, %arg158 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_add_lshr_flag_preservation_after := [llvm|
{
^0(%arg157 : i32, %arg158 : i32, %arg159 : i32):
  %0 = llvm.lshr exact %arg159, %arg158 : i32
  %1 = llvm.add %0, %arg157 overflow<nsw,nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_lshr_flag_preservation_proof : shl_add_lshr_flag_preservation_before ⊑ shl_add_lshr_flag_preservation_after := by
  unfold shl_add_lshr_flag_preservation_before shl_add_lshr_flag_preservation_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_lshr_flag_preservation
  apply shl_add_lshr_flag_preservation_thm
  ---END shl_add_lshr_flag_preservation



def shl_add_lshr_before := [llvm|
{
^0(%arg154 : i32, %arg155 : i32, %arg156 : i32):
  %0 = llvm.shl %arg154, %arg155 overflow<nuw> : i32
  %1 = llvm.add %0, %arg156 overflow<nuw> : i32
  %2 = llvm.lshr %1, %arg155 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_add_lshr_after := [llvm|
{
^0(%arg154 : i32, %arg155 : i32, %arg156 : i32):
  %0 = llvm.lshr %arg156, %arg155 : i32
  %1 = llvm.add %0, %arg154 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_lshr_proof : shl_add_lshr_before ⊑ shl_add_lshr_after := by
  unfold shl_add_lshr_before shl_add_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_lshr
  apply shl_add_lshr_thm
  ---END shl_add_lshr



def shl_add_lshr_comm_before := [llvm|
{
^0(%arg151 : i32, %arg152 : i32, %arg153 : i32):
  %0 = llvm.shl %arg151, %arg152 overflow<nuw> : i32
  %1 = llvm.mul %arg153, %arg153 : i32
  %2 = llvm.add %1, %0 overflow<nuw> : i32
  %3 = llvm.lshr %2, %arg152 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def shl_add_lshr_comm_after := [llvm|
{
^0(%arg151 : i32, %arg152 : i32, %arg153 : i32):
  %0 = llvm.mul %arg153, %arg153 : i32
  %1 = llvm.lshr %0, %arg152 : i32
  %2 = llvm.add %1, %arg151 overflow<nuw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_lshr_comm_proof : shl_add_lshr_comm_before ⊑ shl_add_lshr_comm_after := by
  unfold shl_add_lshr_comm_before shl_add_lshr_comm_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_lshr_comm
  apply shl_add_lshr_comm_thm
  ---END shl_add_lshr_comm



def shl_sub_lshr_before := [llvm|
{
^0(%arg139 : i32, %arg140 : i32, %arg141 : i32):
  %0 = llvm.shl %arg139, %arg140 overflow<nuw> : i32
  %1 = llvm.sub %0, %arg141 overflow<nsw,nuw> : i32
  %2 = llvm.lshr exact %1, %arg140 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_sub_lshr_after := [llvm|
{
^0(%arg139 : i32, %arg140 : i32, %arg141 : i32):
  %0 = llvm.lshr exact %arg141, %arg140 : i32
  %1 = llvm.sub %arg139, %0 overflow<nsw,nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_sub_lshr_proof : shl_sub_lshr_before ⊑ shl_sub_lshr_after := by
  unfold shl_sub_lshr_before shl_sub_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN shl_sub_lshr
  apply shl_sub_lshr_thm
  ---END shl_sub_lshr



def shl_sub_lshr_reverse_before := [llvm|
{
^0(%arg136 : i32, %arg137 : i32, %arg138 : i32):
  %0 = llvm.shl %arg136, %arg137 overflow<nuw> : i32
  %1 = llvm.sub %arg138, %0 overflow<nsw,nuw> : i32
  %2 = llvm.lshr exact %1, %arg137 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_sub_lshr_reverse_after := [llvm|
{
^0(%arg136 : i32, %arg137 : i32, %arg138 : i32):
  %0 = llvm.lshr exact %arg138, %arg137 : i32
  %1 = llvm.sub %0, %arg136 overflow<nsw,nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_sub_lshr_reverse_proof : shl_sub_lshr_reverse_before ⊑ shl_sub_lshr_reverse_after := by
  unfold shl_sub_lshr_reverse_before shl_sub_lshr_reverse_after
  simp_alive_peephole
  intros
  ---BEGIN shl_sub_lshr_reverse
  apply shl_sub_lshr_reverse_thm
  ---END shl_sub_lshr_reverse



def shl_sub_lshr_reverse_no_nsw_before := [llvm|
{
^0(%arg133 : i32, %arg134 : i32, %arg135 : i32):
  %0 = llvm.shl %arg133, %arg134 overflow<nuw> : i32
  %1 = llvm.sub %arg135, %0 overflow<nuw> : i32
  %2 = llvm.lshr exact %1, %arg134 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_sub_lshr_reverse_no_nsw_after := [llvm|
{
^0(%arg133 : i32, %arg134 : i32, %arg135 : i32):
  %0 = llvm.lshr exact %arg135, %arg134 : i32
  %1 = llvm.sub %0, %arg133 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_sub_lshr_reverse_no_nsw_proof : shl_sub_lshr_reverse_no_nsw_before ⊑ shl_sub_lshr_reverse_no_nsw_after := by
  unfold shl_sub_lshr_reverse_no_nsw_before shl_sub_lshr_reverse_no_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN shl_sub_lshr_reverse_no_nsw
  apply shl_sub_lshr_reverse_no_nsw_thm
  ---END shl_sub_lshr_reverse_no_nsw



def shl_sub_lshr_reverse_nsw_on_op1_before := [llvm|
{
^0(%arg130 : i32, %arg131 : i32, %arg132 : i32):
  %0 = llvm.shl %arg130, %arg131 overflow<nsw,nuw> : i32
  %1 = llvm.sub %arg132, %0 overflow<nuw> : i32
  %2 = llvm.lshr exact %1, %arg131 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_sub_lshr_reverse_nsw_on_op1_after := [llvm|
{
^0(%arg130 : i32, %arg131 : i32, %arg132 : i32):
  %0 = llvm.lshr exact %arg132, %arg131 : i32
  %1 = llvm.sub %0, %arg130 overflow<nuw> : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_sub_lshr_reverse_nsw_on_op1_proof : shl_sub_lshr_reverse_nsw_on_op1_before ⊑ shl_sub_lshr_reverse_nsw_on_op1_after := by
  unfold shl_sub_lshr_reverse_nsw_on_op1_before shl_sub_lshr_reverse_nsw_on_op1_after
  simp_alive_peephole
  intros
  ---BEGIN shl_sub_lshr_reverse_nsw_on_op1
  apply shl_sub_lshr_reverse_nsw_on_op1_thm
  ---END shl_sub_lshr_reverse_nsw_on_op1



def shl_or_lshr_before := [llvm|
{
^0(%arg112 : i32, %arg113 : i32, %arg114 : i32):
  %0 = llvm.shl %arg112, %arg113 overflow<nuw> : i32
  %1 = llvm.or %0, %arg114 : i32
  %2 = llvm.lshr %1, %arg113 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_or_lshr_after := [llvm|
{
^0(%arg112 : i32, %arg113 : i32, %arg114 : i32):
  %0 = llvm.lshr %arg114, %arg113 : i32
  %1 = llvm.or %0, %arg112 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_or_lshr_proof : shl_or_lshr_before ⊑ shl_or_lshr_after := by
  unfold shl_or_lshr_before shl_or_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN shl_or_lshr
  apply shl_or_lshr_thm
  ---END shl_or_lshr



def shl_or_disjoint_lshr_before := [llvm|
{
^0(%arg109 : i32, %arg110 : i32, %arg111 : i32):
  %0 = llvm.shl %arg109, %arg110 overflow<nuw> : i32
  %1 = llvm.or disjoint %0, %arg111 : i32
  %2 = llvm.lshr %1, %arg110 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_or_disjoint_lshr_after := [llvm|
{
^0(%arg109 : i32, %arg110 : i32, %arg111 : i32):
  %0 = llvm.lshr %arg111, %arg110 : i32
  %1 = llvm.or disjoint %0, %arg109 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_or_disjoint_lshr_proof : shl_or_disjoint_lshr_before ⊑ shl_or_disjoint_lshr_after := by
  unfold shl_or_disjoint_lshr_before shl_or_disjoint_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN shl_or_disjoint_lshr
  apply shl_or_disjoint_lshr_thm
  ---END shl_or_disjoint_lshr



def shl_or_lshr_comm_before := [llvm|
{
^0(%arg106 : i32, %arg107 : i32, %arg108 : i32):
  %0 = llvm.shl %arg106, %arg107 overflow<nuw> : i32
  %1 = llvm.or %arg108, %0 : i32
  %2 = llvm.lshr %1, %arg107 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_or_lshr_comm_after := [llvm|
{
^0(%arg106 : i32, %arg107 : i32, %arg108 : i32):
  %0 = llvm.lshr %arg108, %arg107 : i32
  %1 = llvm.or %0, %arg106 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_or_lshr_comm_proof : shl_or_lshr_comm_before ⊑ shl_or_lshr_comm_after := by
  unfold shl_or_lshr_comm_before shl_or_lshr_comm_after
  simp_alive_peephole
  intros
  ---BEGIN shl_or_lshr_comm
  apply shl_or_lshr_comm_thm
  ---END shl_or_lshr_comm



def shl_or_disjoint_lshr_comm_before := [llvm|
{
^0(%arg103 : i32, %arg104 : i32, %arg105 : i32):
  %0 = llvm.shl %arg103, %arg104 overflow<nuw> : i32
  %1 = llvm.or disjoint %arg105, %0 : i32
  %2 = llvm.lshr %1, %arg104 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_or_disjoint_lshr_comm_after := [llvm|
{
^0(%arg103 : i32, %arg104 : i32, %arg105 : i32):
  %0 = llvm.lshr %arg105, %arg104 : i32
  %1 = llvm.or disjoint %0, %arg103 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_or_disjoint_lshr_comm_proof : shl_or_disjoint_lshr_comm_before ⊑ shl_or_disjoint_lshr_comm_after := by
  unfold shl_or_disjoint_lshr_comm_before shl_or_disjoint_lshr_comm_after
  simp_alive_peephole
  intros
  ---BEGIN shl_or_disjoint_lshr_comm
  apply shl_or_disjoint_lshr_comm_thm
  ---END shl_or_disjoint_lshr_comm



def shl_xor_lshr_before := [llvm|
{
^0(%arg100 : i32, %arg101 : i32, %arg102 : i32):
  %0 = llvm.shl %arg100, %arg101 overflow<nuw> : i32
  %1 = llvm.xor %0, %arg102 : i32
  %2 = llvm.lshr %1, %arg101 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_xor_lshr_after := [llvm|
{
^0(%arg100 : i32, %arg101 : i32, %arg102 : i32):
  %0 = llvm.lshr %arg102, %arg101 : i32
  %1 = llvm.xor %0, %arg100 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_xor_lshr_proof : shl_xor_lshr_before ⊑ shl_xor_lshr_after := by
  unfold shl_xor_lshr_before shl_xor_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN shl_xor_lshr
  apply shl_xor_lshr_thm
  ---END shl_xor_lshr



def shl_xor_lshr_comm_before := [llvm|
{
^0(%arg97 : i32, %arg98 : i32, %arg99 : i32):
  %0 = llvm.shl %arg97, %arg98 overflow<nuw> : i32
  %1 = llvm.xor %arg99, %0 : i32
  %2 = llvm.lshr %1, %arg98 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_xor_lshr_comm_after := [llvm|
{
^0(%arg97 : i32, %arg98 : i32, %arg99 : i32):
  %0 = llvm.lshr %arg99, %arg98 : i32
  %1 = llvm.xor %0, %arg97 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_xor_lshr_comm_proof : shl_xor_lshr_comm_before ⊑ shl_xor_lshr_comm_after := by
  unfold shl_xor_lshr_comm_before shl_xor_lshr_comm_after
  simp_alive_peephole
  intros
  ---BEGIN shl_xor_lshr_comm
  apply shl_xor_lshr_comm_thm
  ---END shl_xor_lshr_comm



def shl_and_lshr_before := [llvm|
{
^0(%arg94 : i32, %arg95 : i32, %arg96 : i32):
  %0 = llvm.shl %arg94, %arg95 overflow<nuw> : i32
  %1 = llvm.and %0, %arg96 : i32
  %2 = llvm.lshr %1, %arg95 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_and_lshr_after := [llvm|
{
^0(%arg94 : i32, %arg95 : i32, %arg96 : i32):
  %0 = llvm.lshr %arg96, %arg95 : i32
  %1 = llvm.and %0, %arg94 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_and_lshr_proof : shl_and_lshr_before ⊑ shl_and_lshr_after := by
  unfold shl_and_lshr_before shl_and_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN shl_and_lshr
  apply shl_and_lshr_thm
  ---END shl_and_lshr



def shl_and_lshr_comm_before := [llvm|
{
^0(%arg91 : i32, %arg92 : i32, %arg93 : i32):
  %0 = llvm.shl %arg91, %arg92 overflow<nuw> : i32
  %1 = llvm.and %arg93, %0 : i32
  %2 = llvm.lshr %1, %arg92 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_and_lshr_comm_after := [llvm|
{
^0(%arg91 : i32, %arg92 : i32, %arg93 : i32):
  %0 = llvm.lshr %arg93, %arg92 : i32
  %1 = llvm.and %0, %arg91 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_and_lshr_comm_proof : shl_and_lshr_comm_before ⊑ shl_and_lshr_comm_after := by
  unfold shl_and_lshr_comm_before shl_and_lshr_comm_after
  simp_alive_peephole
  intros
  ---BEGIN shl_and_lshr_comm
  apply shl_and_lshr_comm_thm
  ---END shl_and_lshr_comm



def shl_lshr_and_exact_before := [llvm|
{
^0(%arg88 : i32, %arg89 : i32, %arg90 : i32):
  %0 = llvm.shl %arg88, %arg89 overflow<nuw> : i32
  %1 = llvm.and %0, %arg90 : i32
  %2 = llvm.lshr exact %1, %arg89 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_lshr_and_exact_after := [llvm|
{
^0(%arg88 : i32, %arg89 : i32, %arg90 : i32):
  %0 = llvm.lshr %arg90, %arg89 : i32
  %1 = llvm.and %0, %arg88 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_lshr_and_exact_proof : shl_lshr_and_exact_before ⊑ shl_lshr_and_exact_after := by
  unfold shl_lshr_and_exact_before shl_lshr_and_exact_after
  simp_alive_peephole
  intros
  ---BEGIN shl_lshr_and_exact
  apply shl_lshr_and_exact_thm
  ---END shl_lshr_and_exact



def mul_splat_fold_no_nuw_before := [llvm|
{
^0(%arg79 : i32):
  %0 = llvm.mlir.constant(65537 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mul %arg79, %0 overflow<nsw> : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def mul_splat_fold_no_nuw_after := [llvm|
{
^0(%arg79 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.lshr %arg79, %0 : i32
  %2 = llvm.add %arg79, %1 overflow<nsw> : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_splat_fold_no_nuw_proof : mul_splat_fold_no_nuw_before ⊑ mul_splat_fold_no_nuw_after := by
  unfold mul_splat_fold_no_nuw_before mul_splat_fold_no_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN mul_splat_fold_no_nuw
  apply mul_splat_fold_no_nuw_thm
  ---END mul_splat_fold_no_nuw



def mul_splat_fold_too_narrow_before := [llvm|
{
^0(%arg77 : i2):
  %0 = llvm.mlir.constant(-2 : i2) : i2
  %1 = llvm.mlir.constant(1 : i2) : i2
  %2 = llvm.mul %arg77, %0 overflow<nuw> : i2
  %3 = llvm.lshr %2, %1 : i2
  "llvm.return"(%3) : (i2) -> ()
}
]
def mul_splat_fold_too_narrow_after := [llvm|
{
^0(%arg77 : i2):
  "llvm.return"(%arg77) : (i2) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_splat_fold_too_narrow_proof : mul_splat_fold_too_narrow_before ⊑ mul_splat_fold_too_narrow_after := by
  unfold mul_splat_fold_too_narrow_before mul_splat_fold_too_narrow_after
  simp_alive_peephole
  intros
  ---BEGIN mul_splat_fold_too_narrow
  apply mul_splat_fold_too_narrow_thm
  ---END mul_splat_fold_too_narrow



def negative_and_odd_before := [llvm|
{
^0(%arg76 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.srem %arg76, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def negative_and_odd_after := [llvm|
{
^0(%arg76 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.lshr %arg76, %0 : i32
  %2 = llvm.and %1, %arg76 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negative_and_odd_proof : negative_and_odd_before ⊑ negative_and_odd_after := by
  unfold negative_and_odd_before negative_and_odd_after
  simp_alive_peephole
  intros
  ---BEGIN negative_and_odd
  apply negative_and_odd_thm
  ---END negative_and_odd



def trunc_sandwich_before := [llvm|
{
^0(%arg70 : i32):
  %0 = llvm.mlir.constant(28 : i32) : i32
  %1 = llvm.mlir.constant(2 : i12) : i12
  %2 = llvm.lshr %arg70, %0 : i32
  %3 = llvm.trunc %2 : i32 to i12
  %4 = llvm.lshr %3, %1 : i12
  "llvm.return"(%4) : (i12) -> ()
}
]
def trunc_sandwich_after := [llvm|
{
^0(%arg70 : i32):
  %0 = llvm.mlir.constant(30 : i32) : i32
  %1 = llvm.lshr %arg70, %0 : i32
  %2 = llvm.trunc %1 overflow<nsw,nuw> : i32 to i12
  "llvm.return"(%2) : (i12) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_sandwich_proof : trunc_sandwich_before ⊑ trunc_sandwich_after := by
  unfold trunc_sandwich_before trunc_sandwich_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_sandwich
  apply trunc_sandwich_thm
  ---END trunc_sandwich



def trunc_sandwich_min_shift1_before := [llvm|
{
^0(%arg68 : i32):
  %0 = llvm.mlir.constant(20 : i32) : i32
  %1 = llvm.mlir.constant(1 : i12) : i12
  %2 = llvm.lshr %arg68, %0 : i32
  %3 = llvm.trunc %2 : i32 to i12
  %4 = llvm.lshr %3, %1 : i12
  "llvm.return"(%4) : (i12) -> ()
}
]
def trunc_sandwich_min_shift1_after := [llvm|
{
^0(%arg68 : i32):
  %0 = llvm.mlir.constant(21 : i32) : i32
  %1 = llvm.lshr %arg68, %0 : i32
  %2 = llvm.trunc %1 overflow<nsw,nuw> : i32 to i12
  "llvm.return"(%2) : (i12) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_sandwich_min_shift1_proof : trunc_sandwich_min_shift1_before ⊑ trunc_sandwich_min_shift1_after := by
  unfold trunc_sandwich_min_shift1_before trunc_sandwich_min_shift1_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_sandwich_min_shift1
  apply trunc_sandwich_min_shift1_thm
  ---END trunc_sandwich_min_shift1



def trunc_sandwich_small_shift1_before := [llvm|
{
^0(%arg67 : i32):
  %0 = llvm.mlir.constant(19 : i32) : i32
  %1 = llvm.mlir.constant(1 : i12) : i12
  %2 = llvm.lshr %arg67, %0 : i32
  %3 = llvm.trunc %2 : i32 to i12
  %4 = llvm.lshr %3, %1 : i12
  "llvm.return"(%4) : (i12) -> ()
}
]
def trunc_sandwich_small_shift1_after := [llvm|
{
^0(%arg67 : i32):
  %0 = llvm.mlir.constant(20 : i32) : i32
  %1 = llvm.mlir.constant(2047 : i12) : i12
  %2 = llvm.lshr %arg67, %0 : i32
  %3 = llvm.trunc %2 overflow<nuw> : i32 to i12
  %4 = llvm.and %3, %1 : i12
  "llvm.return"(%4) : (i12) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_sandwich_small_shift1_proof : trunc_sandwich_small_shift1_before ⊑ trunc_sandwich_small_shift1_after := by
  unfold trunc_sandwich_small_shift1_before trunc_sandwich_small_shift1_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_sandwich_small_shift1
  apply trunc_sandwich_small_shift1_thm
  ---END trunc_sandwich_small_shift1



def trunc_sandwich_max_sum_shift_before := [llvm|
{
^0(%arg66 : i32):
  %0 = llvm.mlir.constant(20 : i32) : i32
  %1 = llvm.mlir.constant(11 : i12) : i12
  %2 = llvm.lshr %arg66, %0 : i32
  %3 = llvm.trunc %2 : i32 to i12
  %4 = llvm.lshr %3, %1 : i12
  "llvm.return"(%4) : (i12) -> ()
}
]
def trunc_sandwich_max_sum_shift_after := [llvm|
{
^0(%arg66 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.lshr %arg66, %0 : i32
  %2 = llvm.trunc %1 overflow<nsw,nuw> : i32 to i12
  "llvm.return"(%2) : (i12) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_sandwich_max_sum_shift_proof : trunc_sandwich_max_sum_shift_before ⊑ trunc_sandwich_max_sum_shift_after := by
  unfold trunc_sandwich_max_sum_shift_before trunc_sandwich_max_sum_shift_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_sandwich_max_sum_shift
  apply trunc_sandwich_max_sum_shift_thm
  ---END trunc_sandwich_max_sum_shift



def trunc_sandwich_max_sum_shift2_before := [llvm|
{
^0(%arg65 : i32):
  %0 = llvm.mlir.constant(30 : i32) : i32
  %1 = llvm.mlir.constant(1 : i12) : i12
  %2 = llvm.lshr %arg65, %0 : i32
  %3 = llvm.trunc %2 : i32 to i12
  %4 = llvm.lshr %3, %1 : i12
  "llvm.return"(%4) : (i12) -> ()
}
]
def trunc_sandwich_max_sum_shift2_after := [llvm|
{
^0(%arg65 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.lshr %arg65, %0 : i32
  %2 = llvm.trunc %1 overflow<nsw,nuw> : i32 to i12
  "llvm.return"(%2) : (i12) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_sandwich_max_sum_shift2_proof : trunc_sandwich_max_sum_shift2_before ⊑ trunc_sandwich_max_sum_shift2_after := by
  unfold trunc_sandwich_max_sum_shift2_before trunc_sandwich_max_sum_shift2_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_sandwich_max_sum_shift2
  apply trunc_sandwich_max_sum_shift2_thm
  ---END trunc_sandwich_max_sum_shift2



def trunc_sandwich_big_sum_shift1_before := [llvm|
{
^0(%arg64 : i32):
  %0 = llvm.mlir.constant(21 : i32) : i32
  %1 = llvm.mlir.constant(11 : i12) : i12
  %2 = llvm.lshr %arg64, %0 : i32
  %3 = llvm.trunc %2 : i32 to i12
  %4 = llvm.lshr %3, %1 : i12
  "llvm.return"(%4) : (i12) -> ()
}
]
def trunc_sandwich_big_sum_shift1_after := [llvm|
{
^0(%arg64 : i32):
  %0 = llvm.mlir.constant(0 : i12) : i12
  "llvm.return"(%0) : (i12) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_sandwich_big_sum_shift1_proof : trunc_sandwich_big_sum_shift1_before ⊑ trunc_sandwich_big_sum_shift1_after := by
  unfold trunc_sandwich_big_sum_shift1_before trunc_sandwich_big_sum_shift1_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_sandwich_big_sum_shift1
  apply trunc_sandwich_big_sum_shift1_thm
  ---END trunc_sandwich_big_sum_shift1



def trunc_sandwich_big_sum_shift2_before := [llvm|
{
^0(%arg63 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(1 : i12) : i12
  %2 = llvm.lshr %arg63, %0 : i32
  %3 = llvm.trunc %2 : i32 to i12
  %4 = llvm.lshr %3, %1 : i12
  "llvm.return"(%4) : (i12) -> ()
}
]
def trunc_sandwich_big_sum_shift2_after := [llvm|
{
^0(%arg63 : i32):
  %0 = llvm.mlir.constant(0 : i12) : i12
  "llvm.return"(%0) : (i12) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_sandwich_big_sum_shift2_proof : trunc_sandwich_big_sum_shift2_before ⊑ trunc_sandwich_big_sum_shift2_after := by
  unfold trunc_sandwich_big_sum_shift2_before trunc_sandwich_big_sum_shift2_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_sandwich_big_sum_shift2
  apply trunc_sandwich_big_sum_shift2_thm
  ---END trunc_sandwich_big_sum_shift2



def lshr_sext_i1_to_i16_before := [llvm|
{
^0(%arg54 : i1):
  %0 = llvm.mlir.constant(4 : i16) : i16
  %1 = llvm.sext %arg54 : i1 to i16
  %2 = llvm.lshr %1, %0 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def lshr_sext_i1_to_i16_after := [llvm|
{
^0(%arg54 : i1):
  %0 = llvm.mlir.constant(4095 : i16) : i16
  %1 = llvm.mlir.constant(0 : i16) : i16
  %2 = "llvm.select"(%arg54, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_sext_i1_to_i16_proof : lshr_sext_i1_to_i16_before ⊑ lshr_sext_i1_to_i16_after := by
  unfold lshr_sext_i1_to_i16_before lshr_sext_i1_to_i16_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_sext_i1_to_i16
  apply lshr_sext_i1_to_i16_thm
  ---END lshr_sext_i1_to_i16



def lshr_sext_i1_to_i128_before := [llvm|
{
^0(%arg53 : i1):
  %0 = llvm.mlir.constant(42 : i128) : i128
  %1 = llvm.sext %arg53 : i1 to i128
  %2 = llvm.lshr %1, %0 : i128
  "llvm.return"(%2) : (i128) -> ()
}
]
def lshr_sext_i1_to_i128_after := [llvm|
{
^0(%arg53 : i1):
  %0 = llvm.mlir.constant(77371252455336267181195263 : i128) : i128
  %1 = llvm.mlir.constant(0 : i128) : i128
  %2 = "llvm.select"(%arg53, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i128, i128) -> i128
  "llvm.return"(%2) : (i128) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_sext_i1_to_i128_proof : lshr_sext_i1_to_i128_before ⊑ lshr_sext_i1_to_i128_after := by
  unfold lshr_sext_i1_to_i128_before lshr_sext_i1_to_i128_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_sext_i1_to_i128
  apply lshr_sext_i1_to_i128_thm
  ---END lshr_sext_i1_to_i128



def icmp_ule_before := [llvm|
{
^0(%arg49 : i32, %arg50 : i32):
  %0 = llvm.lshr %arg49, %arg50 : i32
  %1 = llvm.icmp "ule" %0, %arg49 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
def icmp_ule_after := [llvm|
{
^0(%arg49 : i32, %arg50 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ule_proof : icmp_ule_before ⊑ icmp_ule_after := by
  unfold icmp_ule_before icmp_ule_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ule
  apply icmp_ule_thm
  ---END icmp_ule



def icmp_ugt_before := [llvm|
{
^0(%arg41 : i32, %arg42 : i32):
  %0 = llvm.lshr %arg41, %arg42 : i32
  %1 = llvm.icmp "ugt" %0, %arg41 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
def icmp_ugt_after := [llvm|
{
^0(%arg41 : i32, %arg42 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem icmp_ugt_proof : icmp_ugt_before ⊑ icmp_ugt_after := by
  unfold icmp_ugt_before icmp_ugt_after
  simp_alive_peephole
  intros
  ---BEGIN icmp_ugt
  apply icmp_ugt_thm
  ---END icmp_ugt



def not_signbit_before := [llvm|
{
^0(%arg22 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.xor %arg22, %0 : i8
  %3 = llvm.lshr %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def not_signbit_after := [llvm|
{
^0(%arg22 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "sgt" %arg22, %0 : i8
  %2 = llvm.zext %1 : i1 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_signbit_proof : not_signbit_before ⊑ not_signbit_after := by
  unfold not_signbit_before not_signbit_after
  simp_alive_peephole
  intros
  ---BEGIN not_signbit
  apply not_signbit_thm
  ---END not_signbit



def not_signbit_alt_xor_before := [llvm|
{
^0(%arg20 : i8):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.xor %arg20, %0 : i8
  %3 = llvm.lshr %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def not_signbit_alt_xor_after := [llvm|
{
^0(%arg20 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "sgt" %arg20, %0 : i8
  %2 = llvm.zext %1 : i1 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_signbit_alt_xor_proof : not_signbit_alt_xor_before ⊑ not_signbit_alt_xor_after := by
  unfold not_signbit_alt_xor_before not_signbit_alt_xor_after
  simp_alive_peephole
  intros
  ---BEGIN not_signbit_alt_xor
  apply not_signbit_alt_xor_thm
  ---END not_signbit_alt_xor



def not_signbit_zext_before := [llvm|
{
^0(%arg17 : i16):
  %0 = llvm.mlir.constant(-1 : i16) : i16
  %1 = llvm.mlir.constant(15 : i16) : i16
  %2 = llvm.xor %arg17, %0 : i16
  %3 = llvm.lshr %2, %1 : i16
  %4 = llvm.zext %3 : i16 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def not_signbit_zext_after := [llvm|
{
^0(%arg17 : i16):
  %0 = llvm.mlir.constant(-1 : i16) : i16
  %1 = llvm.icmp "sgt" %arg17, %0 : i16
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_signbit_zext_proof : not_signbit_zext_before ⊑ not_signbit_zext_after := by
  unfold not_signbit_zext_before not_signbit_zext_after
  simp_alive_peephole
  intros
  ---BEGIN not_signbit_zext
  apply not_signbit_zext_thm
  ---END not_signbit_zext



def not_signbit_trunc_before := [llvm|
{
^0(%arg16 : i16):
  %0 = llvm.mlir.constant(-1 : i16) : i16
  %1 = llvm.mlir.constant(15 : i16) : i16
  %2 = llvm.xor %arg16, %0 : i16
  %3 = llvm.lshr %2, %1 : i16
  %4 = llvm.trunc %3 : i16 to i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def not_signbit_trunc_after := [llvm|
{
^0(%arg16 : i16):
  %0 = llvm.mlir.constant(-1 : i16) : i16
  %1 = llvm.icmp "sgt" %arg16, %0 : i16
  %2 = llvm.zext %1 : i1 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_signbit_trunc_proof : not_signbit_trunc_before ⊑ not_signbit_trunc_after := by
  unfold not_signbit_trunc_before not_signbit_trunc_after
  simp_alive_peephole
  intros
  ---BEGIN not_signbit_trunc
  apply not_signbit_trunc_thm
  ---END not_signbit_trunc



def bool_add_lshr_before := [llvm|
{
^0(%arg14 : i1, %arg15 : i1):
  %0 = llvm.mlir.constant(1 : i2) : i2
  %1 = llvm.zext %arg14 : i1 to i2
  %2 = llvm.zext %arg15 : i1 to i2
  %3 = llvm.add %1, %2 : i2
  %4 = llvm.lshr %3, %0 : i2
  "llvm.return"(%4) : (i2) -> ()
}
]
def bool_add_lshr_after := [llvm|
{
^0(%arg14 : i1, %arg15 : i1):
  %0 = llvm.and %arg14, %arg15 : i1
  %1 = llvm.zext %0 : i1 to i2
  "llvm.return"(%1) : (i2) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bool_add_lshr_proof : bool_add_lshr_before ⊑ bool_add_lshr_after := by
  unfold bool_add_lshr_before bool_add_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN bool_add_lshr
  apply bool_add_lshr_thm
  ---END bool_add_lshr



def not_bool_add_lshr_before := [llvm|
{
^0(%arg12 : i2, %arg13 : i2):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.zext %arg12 : i2 to i4
  %2 = llvm.zext %arg13 : i2 to i4
  %3 = llvm.add %1, %2 : i4
  %4 = llvm.lshr %3, %0 : i4
  "llvm.return"(%4) : (i4) -> ()
}
]
def not_bool_add_lshr_after := [llvm|
{
^0(%arg12 : i2, %arg13 : i2):
  %0 = llvm.mlir.constant(-1 : i2) : i2
  %1 = llvm.xor %arg12, %0 : i2
  %2 = llvm.icmp "ugt" %arg13, %1 : i2
  %3 = llvm.zext %2 : i1 to i4
  "llvm.return"(%3) : (i4) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_bool_add_lshr_proof : not_bool_add_lshr_before ⊑ not_bool_add_lshr_after := by
  unfold not_bool_add_lshr_before not_bool_add_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN not_bool_add_lshr
  apply not_bool_add_lshr_thm
  ---END not_bool_add_lshr



def bool_add_ashr_before := [llvm|
{
^0(%arg10 : i1, %arg11 : i1):
  %0 = llvm.mlir.constant(1 : i2) : i2
  %1 = llvm.zext %arg10 : i1 to i2
  %2 = llvm.zext %arg11 : i1 to i2
  %3 = llvm.add %1, %2 : i2
  %4 = llvm.ashr %3, %0 : i2
  "llvm.return"(%4) : (i2) -> ()
}
]
def bool_add_ashr_after := [llvm|
{
^0(%arg10 : i1, %arg11 : i1):
  %0 = llvm.mlir.constant(1 : i2) : i2
  %1 = llvm.zext %arg10 : i1 to i2
  %2 = llvm.zext %arg11 : i1 to i2
  %3 = llvm.add %1, %2 overflow<nuw> : i2
  %4 = llvm.ashr %3, %0 : i2
  "llvm.return"(%4) : (i2) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bool_add_ashr_proof : bool_add_ashr_before ⊑ bool_add_ashr_after := by
  unfold bool_add_ashr_before bool_add_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN bool_add_ashr
  apply bool_add_ashr_thm
  ---END bool_add_ashr


