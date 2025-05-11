
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
section gicmphandhlowbithmask_statements

def src_is_mask_zext_before := [llvm|
{
^0(%arg131 : i16, %arg132 : i8):
  %0 = llvm.mlir.constant(123 : i16) : i16
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.xor %arg131, %0 : i16
  %3 = llvm.lshr %1, %arg132 : i8
  %4 = llvm.zext %3 : i8 to i16
  %5 = llvm.and %2, %4 : i16
  %6 = llvm.icmp "eq" %5, %2 : i16
  "llvm.return"(%6) : (i1) -> ()
}
]
def src_is_mask_zext_after := [llvm|
{
^0(%arg131 : i16, %arg132 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i16) : i16
  %2 = llvm.lshr %0, %arg132 : i8
  %3 = llvm.zext %2 : i8 to i16
  %4 = llvm.xor %arg131, %1 : i16
  %5 = llvm.icmp "ule" %4, %3 : i16
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_zext_proof : src_is_mask_zext_before ⊑ src_is_mask_zext_after := by
  unfold src_is_mask_zext_before src_is_mask_zext_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_zext
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_zext



def src_is_mask_zext_fail_not_mask_before := [llvm|
{
^0(%arg129 : i16, %arg130 : i8):
  %0 = llvm.mlir.constant(123 : i16) : i16
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.xor %arg129, %0 : i16
  %3 = llvm.lshr %1, %arg130 : i8
  %4 = llvm.zext %3 : i8 to i16
  %5 = llvm.and %2, %4 : i16
  %6 = llvm.icmp "eq" %5, %2 : i16
  "llvm.return"(%6) : (i1) -> ()
}
]
def src_is_mask_zext_fail_not_mask_after := [llvm|
{
^0(%arg129 : i16, %arg130 : i8):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.mlir.constant(-124 : i16) : i16
  %2 = llvm.mlir.constant(-1 : i16) : i16
  %3 = llvm.lshr %0, %arg130 : i8
  %4 = llvm.zext %3 : i8 to i16
  %5 = llvm.xor %arg129, %1 : i16
  %6 = llvm.or %5, %4 : i16
  %7 = llvm.icmp "eq" %6, %2 : i16
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_zext_fail_not_mask_proof : src_is_mask_zext_fail_not_mask_before ⊑ src_is_mask_zext_fail_not_mask_after := by
  unfold src_is_mask_zext_fail_not_mask_before src_is_mask_zext_fail_not_mask_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_zext_fail_not_mask
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_zext_fail_not_mask



def src_is_mask_sext_before := [llvm|
{
^0(%arg127 : i16, %arg128 : i8):
  %0 = llvm.mlir.constant(123 : i16) : i16
  %1 = llvm.mlir.constant(31 : i8) : i8
  %2 = llvm.mlir.constant(-1 : i16) : i16
  %3 = llvm.mlir.constant(0 : i16) : i16
  %4 = llvm.xor %arg127, %0 : i16
  %5 = llvm.lshr %1, %arg128 : i8
  %6 = llvm.sext %5 : i8 to i16
  %7 = llvm.xor %6, %2 : i16
  %8 = llvm.and %7, %4 : i16
  %9 = llvm.icmp "eq" %8, %3 : i16
  "llvm.return"(%9) : (i1) -> ()
}
]
def src_is_mask_sext_after := [llvm|
{
^0(%arg127 : i16, %arg128 : i8):
  %0 = llvm.mlir.constant(123 : i16) : i16
  %1 = llvm.mlir.constant(31 : i8) : i8
  %2 = llvm.xor %arg127, %0 : i16
  %3 = llvm.lshr %1, %arg128 : i8
  %4 = llvm.zext nneg %3 : i8 to i16
  %5 = llvm.icmp "ule" %2, %4 : i16
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_sext_proof : src_is_mask_sext_before ⊑ src_is_mask_sext_after := by
  unfold src_is_mask_sext_before src_is_mask_sext_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_sext
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_sext



def src_is_mask_and_before := [llvm|
{
^0(%arg122 : i8, %arg123 : i8, %arg124 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.mlir.constant(-1 : i8) : i8
  %3 = llvm.xor %arg122, %0 : i8
  %4 = llvm.ashr %1, %arg123 : i8
  %5 = llvm.lshr %2, %arg124 : i8
  %6 = llvm.and %4, %5 : i8
  %7 = llvm.and %3, %6 : i8
  %8 = llvm.icmp "eq" %3, %7 : i8
  "llvm.return"(%8) : (i1) -> ()
}
]
def src_is_mask_and_after := [llvm|
{
^0(%arg122 : i8, %arg123 : i8, %arg124 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(123 : i8) : i8
  %3 = llvm.lshr %0, %arg123 : i8
  %4 = llvm.lshr %1, %arg124 : i8
  %5 = llvm.and %3, %4 : i8
  %6 = llvm.xor %arg122, %2 : i8
  %7 = llvm.icmp "ule" %6, %5 : i8
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_and_proof : src_is_mask_and_before ⊑ src_is_mask_and_after := by
  unfold src_is_mask_and_before src_is_mask_and_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_and
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_and



def src_is_mask_and_fail_mixed_before := [llvm|
{
^0(%arg119 : i8, %arg120 : i8, %arg121 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(-8 : i8) : i8
  %2 = llvm.mlir.constant(-1 : i8) : i8
  %3 = llvm.xor %arg119, %0 : i8
  %4 = llvm.ashr %1, %arg120 : i8
  %5 = llvm.lshr %2, %arg121 : i8
  %6 = llvm.and %4, %5 : i8
  %7 = llvm.and %3, %6 : i8
  %8 = llvm.icmp "eq" %3, %7 : i8
  "llvm.return"(%8) : (i1) -> ()
}
]
def src_is_mask_and_fail_mixed_after := [llvm|
{
^0(%arg119 : i8, %arg120 : i8, %arg121 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(-124 : i8) : i8
  %3 = llvm.ashr %0, %arg120 : i8
  %4 = llvm.lshr %1, %arg121 : i8
  %5 = llvm.and %3, %4 : i8
  %6 = llvm.xor %arg119, %2 : i8
  %7 = llvm.or %5, %6 : i8
  %8 = llvm.icmp "eq" %7, %1 : i8
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_and_fail_mixed_proof : src_is_mask_and_fail_mixed_before ⊑ src_is_mask_and_fail_mixed_after := by
  unfold src_is_mask_and_fail_mixed_before src_is_mask_and_fail_mixed_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_and_fail_mixed
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_and_fail_mixed



def src_is_mask_or_before := [llvm|
{
^0(%arg117 : i8, %arg118 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(7 : i8) : i8
  %3 = llvm.xor %arg117, %0 : i8
  %4 = llvm.lshr %1, %arg118 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.and %5, %3 : i8
  %7 = llvm.icmp "eq" %3, %6 : i8
  "llvm.return"(%7) : (i1) -> ()
}
]
def src_is_mask_or_after := [llvm|
{
^0(%arg117 : i8, %arg118 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.mlir.constant(123 : i8) : i8
  %3 = llvm.lshr %0, %arg118 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.xor %arg117, %2 : i8
  %6 = llvm.icmp "ule" %5, %4 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_or_proof : src_is_mask_or_before ⊑ src_is_mask_or_after := by
  unfold src_is_mask_or_before src_is_mask_or_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_or
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_or



def src_is_mask_xor_before := [llvm|
{
^0(%arg115 : i8, %arg116 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.xor %arg115, %0 : i8
  %3 = llvm.add %arg116, %1 : i8
  %4 = llvm.xor %arg116, %3 : i8
  %5 = llvm.and %2, %4 : i8
  %6 = llvm.icmp "ne" %5, %2 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def src_is_mask_xor_after := [llvm|
{
^0(%arg115 : i8, %arg116 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.add %arg116, %0 : i8
  %3 = llvm.xor %arg116, %2 : i8
  %4 = llvm.xor %arg115, %1 : i8
  %5 = llvm.icmp "ugt" %4, %3 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_xor_proof : src_is_mask_xor_before ⊑ src_is_mask_xor_after := by
  unfold src_is_mask_xor_before src_is_mask_xor_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_xor
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_xor



def src_is_mask_xor_fail_notmask_before := [llvm|
{
^0(%arg113 : i8, %arg114 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.xor %arg113, %0 : i8
  %3 = llvm.add %arg114, %1 : i8
  %4 = llvm.xor %arg114, %3 : i8
  %5 = llvm.xor %4, %1 : i8
  %6 = llvm.and %2, %5 : i8
  %7 = llvm.icmp "ne" %6, %2 : i8
  "llvm.return"(%7) : (i1) -> ()
}
]
def src_is_mask_xor_fail_notmask_after := [llvm|
{
^0(%arg113 : i8, %arg114 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-124 : i8) : i8
  %2 = llvm.mlir.constant(-1 : i8) : i8
  %3 = llvm.sub %0, %arg114 : i8
  %4 = llvm.xor %arg114, %3 : i8
  %5 = llvm.xor %arg113, %1 : i8
  %6 = llvm.or %4, %5 : i8
  %7 = llvm.icmp "ne" %6, %2 : i8
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_xor_fail_notmask_proof : src_is_mask_xor_fail_notmask_before ⊑ src_is_mask_xor_fail_notmask_after := by
  unfold src_is_mask_xor_fail_notmask_before src_is_mask_xor_fail_notmask_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_xor_fail_notmask
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_xor_fail_notmask



def src_is_mask_select_before := [llvm|
{
^0(%arg110 : i8, %arg111 : i8, %arg112 : i1):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(15 : i8) : i8
  %3 = llvm.xor %arg110, %0 : i8
  %4 = llvm.add %arg111, %1 : i8
  %5 = llvm.xor %arg111, %4 : i8
  %6 = "llvm.select"(%arg112, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %7 = llvm.and %6, %3 : i8
  %8 = llvm.icmp "ne" %7, %3 : i8
  "llvm.return"(%8) : (i1) -> ()
}
]
def src_is_mask_select_after := [llvm|
{
^0(%arg110 : i8, %arg111 : i8, %arg112 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(15 : i8) : i8
  %2 = llvm.mlir.constant(123 : i8) : i8
  %3 = llvm.add %arg111, %0 : i8
  %4 = llvm.xor %arg111, %3 : i8
  %5 = "llvm.select"(%arg112, %4, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %6 = llvm.xor %arg110, %2 : i8
  %7 = llvm.icmp "ugt" %6, %5 : i8
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_select_proof : src_is_mask_select_before ⊑ src_is_mask_select_after := by
  unfold src_is_mask_select_before src_is_mask_select_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_select
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_select



def src_is_mask_shl_lshr_before := [llvm|
{
^0(%arg103 : i8, %arg104 : i8, %arg105 : i1):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.xor %arg103, %0 : i8
  %4 = llvm.shl %1, %arg104 : i8
  %5 = llvm.lshr %4, %arg104 : i8
  %6 = llvm.xor %5, %1 : i8
  %7 = llvm.and %3, %6 : i8
  %8 = llvm.icmp "ne" %2, %7 : i8
  "llvm.return"(%8) : (i1) -> ()
}
]
def src_is_mask_shl_lshr_after := [llvm|
{
^0(%arg103 : i8, %arg104 : i8, %arg105 : i1):
  %0 = llvm.mlir.constant(122 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.xor %arg103, %0 : i8
  %3 = llvm.lshr %1, %arg104 : i8
  %4 = llvm.icmp "ugt" %2, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_shl_lshr_proof : src_is_mask_shl_lshr_before ⊑ src_is_mask_shl_lshr_after := by
  unfold src_is_mask_shl_lshr_before src_is_mask_shl_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_shl_lshr
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_shl_lshr



def src_is_mask_shl_lshr_fail_not_allones_before := [llvm|
{
^0(%arg100 : i8, %arg101 : i8, %arg102 : i1):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.mlir.constant(-1 : i8) : i8
  %3 = llvm.mlir.constant(0 : i8) : i8
  %4 = llvm.xor %arg100, %0 : i8
  %5 = llvm.shl %1, %arg101 : i8
  %6 = llvm.lshr %5, %arg101 : i8
  %7 = llvm.xor %6, %2 : i8
  %8 = llvm.and %4, %7 : i8
  %9 = llvm.icmp "ne" %3, %8 : i8
  "llvm.return"(%9) : (i1) -> ()
}
]
def src_is_mask_shl_lshr_fail_not_allones_after := [llvm|
{
^0(%arg100 : i8, %arg101 : i8, %arg102 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.mlir.constant(-124 : i8) : i8
  %3 = llvm.lshr %0, %arg101 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.xor %arg100, %2 : i8
  %6 = llvm.or %5, %4 : i8
  %7 = llvm.icmp "ne" %6, %0 : i8
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_shl_lshr_fail_not_allones_proof : src_is_mask_shl_lshr_fail_not_allones_before ⊑ src_is_mask_shl_lshr_fail_not_allones_after := by
  unfold src_is_mask_shl_lshr_fail_not_allones_before src_is_mask_shl_lshr_fail_not_allones_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_shl_lshr_fail_not_allones
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_shl_lshr_fail_not_allones



def src_is_mask_lshr_before := [llvm|
{
^0(%arg96 : i8, %arg97 : i8, %arg98 : i8, %arg99 : i1):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(15 : i8) : i8
  %3 = llvm.xor %arg96, %0 : i8
  %4 = llvm.add %arg97, %1 : i8
  %5 = llvm.xor %arg97, %4 : i8
  %6 = "llvm.select"(%arg99, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %7 = llvm.lshr %6, %arg98 : i8
  %8 = llvm.and %7, %3 : i8
  %9 = llvm.icmp "ne" %3, %8 : i8
  "llvm.return"(%9) : (i1) -> ()
}
]
def src_is_mask_lshr_after := [llvm|
{
^0(%arg96 : i8, %arg97 : i8, %arg98 : i8, %arg99 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(15 : i8) : i8
  %2 = llvm.mlir.constant(123 : i8) : i8
  %3 = llvm.add %arg97, %0 : i8
  %4 = llvm.xor %arg97, %3 : i8
  %5 = "llvm.select"(%arg99, %4, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %6 = llvm.lshr %5, %arg98 : i8
  %7 = llvm.xor %arg96, %2 : i8
  %8 = llvm.icmp "ugt" %7, %6 : i8
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_lshr_proof : src_is_mask_lshr_before ⊑ src_is_mask_lshr_after := by
  unfold src_is_mask_lshr_before src_is_mask_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_lshr
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_lshr



def src_is_mask_ashr_before := [llvm|
{
^0(%arg92 : i8, %arg93 : i8, %arg94 : i8, %arg95 : i1):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(15 : i8) : i8
  %3 = llvm.xor %arg92, %0 : i8
  %4 = llvm.add %arg93, %1 : i8
  %5 = llvm.xor %arg93, %4 : i8
  %6 = "llvm.select"(%arg95, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %7 = llvm.ashr %6, %arg94 : i8
  %8 = llvm.and %3, %7 : i8
  %9 = llvm.icmp "ult" %8, %3 : i8
  "llvm.return"(%9) : (i1) -> ()
}
]
def src_is_mask_ashr_after := [llvm|
{
^0(%arg92 : i8, %arg93 : i8, %arg94 : i8, %arg95 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(15 : i8) : i8
  %2 = llvm.mlir.constant(123 : i8) : i8
  %3 = llvm.add %arg93, %0 : i8
  %4 = llvm.xor %arg93, %3 : i8
  %5 = "llvm.select"(%arg95, %4, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %6 = llvm.ashr %5, %arg94 : i8
  %7 = llvm.xor %arg92, %2 : i8
  %8 = llvm.icmp "ugt" %7, %6 : i8
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_ashr_proof : src_is_mask_ashr_before ⊑ src_is_mask_ashr_after := by
  unfold src_is_mask_ashr_before src_is_mask_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_ashr
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_ashr



def src_is_mask_p2_m1_before := [llvm|
{
^0(%arg90 : i8, %arg91 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(-1 : i8) : i8
  %3 = llvm.xor %arg90, %0 : i8
  %4 = llvm.shl %1, %arg91 : i8
  %5 = llvm.add %4, %2 : i8
  %6 = llvm.and %5, %3 : i8
  %7 = llvm.icmp "ult" %6, %3 : i8
  "llvm.return"(%7) : (i1) -> ()
}
]
def src_is_mask_p2_m1_after := [llvm|
{
^0(%arg90 : i8, %arg91 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(123 : i8) : i8
  %3 = llvm.shl %0, %arg91 : i8
  %4 = llvm.add %3, %1 : i8
  %5 = llvm.xor %arg90, %2 : i8
  %6 = llvm.icmp "ugt" %5, %4 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_p2_m1_proof : src_is_mask_p2_m1_before ⊑ src_is_mask_p2_m1_after := by
  unfold src_is_mask_p2_m1_before src_is_mask_p2_m1_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_p2_m1
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_p2_m1



def src_is_notmask_sext_before := [llvm|
{
^0(%arg75 : i16, %arg76 : i8):
  %0 = llvm.mlir.constant(123 : i16) : i16
  %1 = llvm.mlir.constant(-8 : i8) : i8
  %2 = llvm.mlir.constant(-1 : i16) : i16
  %3 = llvm.xor %arg75, %0 : i16
  %4 = llvm.shl %1, %arg76 : i8
  %5 = llvm.sext %4 : i8 to i16
  %6 = llvm.xor %5, %2 : i16
  %7 = llvm.and %6, %3 : i16
  %8 = llvm.icmp "ule" %3, %7 : i16
  "llvm.return"(%8) : (i1) -> ()
}
]
def src_is_notmask_sext_after := [llvm|
{
^0(%arg75 : i16, %arg76 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i16) : i16
  %2 = llvm.shl %0, %arg76 : i8
  %3 = llvm.xor %arg75, %1 : i16
  %4 = llvm.sext %2 : i8 to i16
  %5 = llvm.icmp "uge" %3, %4 : i16
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_notmask_sext_proof : src_is_notmask_sext_before ⊑ src_is_notmask_sext_after := by
  unfold src_is_notmask_sext_before src_is_notmask_sext_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_notmask_sext
  all_goals (try extract_goal ; sorry)
  ---END src_is_notmask_sext



def src_is_notmask_x_xor_neg_x_before := [llvm|
{
^0(%arg69 : i8, %arg70 : i8, %arg71 : i1):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(-8 : i8) : i8
  %3 = llvm.xor %arg69, %0 : i8
  %4 = llvm.sub %1, %arg70 : i8
  %5 = llvm.xor %arg70, %4 : i8
  %6 = "llvm.select"(%arg71, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %7 = llvm.and %3, %6 : i8
  %8 = llvm.icmp "eq" %7, %1 : i8
  "llvm.return"(%8) : (i1) -> ()
}
]
def src_is_notmask_x_xor_neg_x_after := [llvm|
{
^0(%arg69 : i8, %arg70 : i8, %arg71 : i1):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(7 : i8) : i8
  %3 = llvm.xor %arg69, %0 : i8
  %4 = llvm.add %arg70, %1 : i8
  %5 = llvm.xor %arg70, %4 : i8
  %6 = "llvm.select"(%arg71, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %7 = llvm.icmp "ule" %3, %6 : i8
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_notmask_x_xor_neg_x_proof : src_is_notmask_x_xor_neg_x_before ⊑ src_is_notmask_x_xor_neg_x_after := by
  unfold src_is_notmask_x_xor_neg_x_before src_is_notmask_x_xor_neg_x_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_notmask_x_xor_neg_x
  all_goals (try extract_goal ; sorry)
  ---END src_is_notmask_x_xor_neg_x



def src_is_notmask_x_xor_neg_x_inv_before := [llvm|
{
^0(%arg66 : i8, %arg67 : i8, %arg68 : i1):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(-8 : i8) : i8
  %3 = llvm.xor %arg66, %0 : i8
  %4 = llvm.sub %1, %arg67 : i8
  %5 = llvm.xor %arg67, %4 : i8
  %6 = "llvm.select"(%arg68, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %7 = llvm.and %6, %3 : i8
  %8 = llvm.icmp "eq" %7, %1 : i8
  "llvm.return"(%8) : (i1) -> ()
}
]
def src_is_notmask_x_xor_neg_x_inv_after := [llvm|
{
^0(%arg66 : i8, %arg67 : i8, %arg68 : i1):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.mlir.constant(7 : i8) : i8
  %3 = llvm.xor %arg66, %0 : i8
  %4 = llvm.add %arg67, %1 : i8
  %5 = llvm.xor %arg67, %4 : i8
  %6 = "llvm.select"(%arg68, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %7 = llvm.icmp "ule" %3, %6 : i8
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_notmask_x_xor_neg_x_inv_proof : src_is_notmask_x_xor_neg_x_inv_before ⊑ src_is_notmask_x_xor_neg_x_inv_after := by
  unfold src_is_notmask_x_xor_neg_x_inv_before src_is_notmask_x_xor_neg_x_inv_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_notmask_x_xor_neg_x_inv
  all_goals (try extract_goal ; sorry)
  ---END src_is_notmask_x_xor_neg_x_inv



def src_is_notmask_lshr_shl_before := [llvm|
{
^0(%arg61 : i8, %arg62 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.xor %arg61, %0 : i8
  %3 = llvm.lshr %1, %arg62 : i8
  %4 = llvm.shl %3, %arg62 : i8
  %5 = llvm.xor %4, %1 : i8
  %6 = llvm.and %5, %2 : i8
  %7 = llvm.icmp "eq" %6, %2 : i8
  "llvm.return"(%7) : (i1) -> ()
}
]
def src_is_notmask_lshr_shl_after := [llvm|
{
^0(%arg61 : i8, %arg62 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(-124 : i8) : i8
  %2 = llvm.shl %0, %arg62 overflow<nsw> : i8
  %3 = llvm.xor %arg61, %1 : i8
  %4 = llvm.icmp "uge" %3, %2 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_notmask_lshr_shl_proof : src_is_notmask_lshr_shl_before ⊑ src_is_notmask_lshr_shl_after := by
  unfold src_is_notmask_lshr_shl_before src_is_notmask_lshr_shl_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_notmask_lshr_shl
  all_goals (try extract_goal ; sorry)
  ---END src_is_notmask_lshr_shl



def src_is_notmask_lshr_shl_fail_mismatch_shifts_before := [llvm|
{
^0(%arg58 : i8, %arg59 : i8, %arg60 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.xor %arg58, %0 : i8
  %3 = llvm.lshr %1, %arg59 : i8
  %4 = llvm.shl %3, %arg60 : i8
  %5 = llvm.xor %4, %1 : i8
  %6 = llvm.and %5, %2 : i8
  %7 = llvm.icmp "eq" %6, %2 : i8
  "llvm.return"(%7) : (i1) -> ()
}
]
def src_is_notmask_lshr_shl_fail_mismatch_shifts_after := [llvm|
{
^0(%arg58 : i8, %arg59 : i8, %arg60 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.lshr %0, %arg59 : i8
  %4 = llvm.shl %3, %arg60 : i8
  %5 = llvm.xor %arg58, %1 : i8
  %6 = llvm.and %5, %4 : i8
  %7 = llvm.icmp "eq" %6, %2 : i8
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_notmask_lshr_shl_fail_mismatch_shifts_proof : src_is_notmask_lshr_shl_fail_mismatch_shifts_before ⊑ src_is_notmask_lshr_shl_fail_mismatch_shifts_after := by
  unfold src_is_notmask_lshr_shl_fail_mismatch_shifts_before src_is_notmask_lshr_shl_fail_mismatch_shifts_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_notmask_lshr_shl_fail_mismatch_shifts
  all_goals (try extract_goal ; sorry)
  ---END src_is_notmask_lshr_shl_fail_mismatch_shifts



def src_is_notmask_ashr_before := [llvm|
{
^0(%arg55 : i16, %arg56 : i8, %arg57 : i16):
  %0 = llvm.mlir.constant(123 : i16) : i16
  %1 = llvm.mlir.constant(-32 : i8) : i8
  %2 = llvm.mlir.constant(-1 : i16) : i16
  %3 = llvm.xor %arg55, %0 : i16
  %4 = llvm.shl %1, %arg56 : i8
  %5 = llvm.sext %4 : i8 to i16
  %6 = llvm.ashr %5, %arg57 : i16
  %7 = llvm.xor %6, %2 : i16
  %8 = llvm.and %3, %7 : i16
  %9 = llvm.icmp "eq" %3, %8 : i16
  "llvm.return"(%9) : (i1) -> ()
}
]
def src_is_notmask_ashr_after := [llvm|
{
^0(%arg55 : i16, %arg56 : i8, %arg57 : i16):
  %0 = llvm.mlir.constant(-32 : i8) : i8
  %1 = llvm.mlir.constant(-124 : i16) : i16
  %2 = llvm.shl %0, %arg56 : i8
  %3 = llvm.sext %2 : i8 to i16
  %4 = llvm.ashr %3, %arg57 : i16
  %5 = llvm.xor %arg55, %1 : i16
  %6 = llvm.icmp "uge" %5, %4 : i16
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_notmask_ashr_proof : src_is_notmask_ashr_before ⊑ src_is_notmask_ashr_after := by
  unfold src_is_notmask_ashr_before src_is_notmask_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_notmask_ashr
  all_goals (try extract_goal ; sorry)
  ---END src_is_notmask_ashr



def src_is_notmask_neg_p2_fail_not_invertable_before := [llvm|
{
^0(%arg51 : i8, %arg52 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.xor %arg51, %0 : i8
  %3 = llvm.sub %1, %arg52 : i8
  %4 = llvm.and %3, %arg52 : i8
  %5 = llvm.sub %1, %4 : i8
  %6 = llvm.and %5, %2 : i8
  %7 = llvm.icmp "eq" %1, %6 : i8
  "llvm.return"(%7) : (i1) -> ()
}
]
def src_is_notmask_neg_p2_fail_not_invertable_after := [llvm|
{
^0(%arg51 : i8, %arg52 : i8):
  %0 = llvm.mlir.constant(-124 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.xor %arg51, %0 : i8
  %3 = llvm.sub %1, %arg52 : i8
  %4 = llvm.or %arg52, %3 : i8
  %5 = llvm.icmp "uge" %2, %4 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_notmask_neg_p2_fail_not_invertable_proof : src_is_notmask_neg_p2_fail_not_invertable_before ⊑ src_is_notmask_neg_p2_fail_not_invertable_after := by
  unfold src_is_notmask_neg_p2_fail_not_invertable_before src_is_notmask_neg_p2_fail_not_invertable_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_notmask_neg_p2_fail_not_invertable
  all_goals (try extract_goal ; sorry)
  ---END src_is_notmask_neg_p2_fail_not_invertable



def src_is_mask_const_slt_before := [llvm|
{
^0(%arg48 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.xor %arg48, %0 : i8
  %3 = llvm.and %2, %1 : i8
  %4 = llvm.icmp "slt" %2, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def src_is_mask_const_slt_after := [llvm|
{
^0(%arg48 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "slt" %arg48, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_const_slt_proof : src_is_mask_const_slt_before ⊑ src_is_mask_const_slt_after := by
  unfold src_is_mask_const_slt_before src_is_mask_const_slt_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_const_slt
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_const_slt



def src_is_mask_const_sgt_before := [llvm|
{
^0(%arg47 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.xor %arg47, %0 : i8
  %3 = llvm.and %2, %1 : i8
  %4 = llvm.icmp "sgt" %2, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def src_is_mask_const_sgt_after := [llvm|
{
^0(%arg47 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.xor %arg47, %0 : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_const_sgt_proof : src_is_mask_const_sgt_before ⊑ src_is_mask_const_sgt_after := by
  unfold src_is_mask_const_sgt_before src_is_mask_const_sgt_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_const_sgt
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_const_sgt



def src_is_mask_const_sle_before := [llvm|
{
^0(%arg46 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(31 : i8) : i8
  %2 = llvm.xor %arg46, %0 : i8
  %3 = llvm.and %2, %1 : i8
  %4 = llvm.icmp "sle" %3, %2 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def src_is_mask_const_sle_after := [llvm|
{
^0(%arg46 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "sgt" %arg46, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_const_sle_proof : src_is_mask_const_sle_before ⊑ src_is_mask_const_sle_after := by
  unfold src_is_mask_const_sle_before src_is_mask_const_sle_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_const_sle
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_const_sle



def src_is_mask_const_sge_before := [llvm|
{
^0(%arg45 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(31 : i8) : i8
  %2 = llvm.xor %arg45, %0 : i8
  %3 = llvm.and %2, %1 : i8
  %4 = llvm.icmp "sge" %3, %2 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def src_is_mask_const_sge_after := [llvm|
{
^0(%arg45 : i8):
  %0 = llvm.mlir.constant(123 : i8) : i8
  %1 = llvm.mlir.constant(32 : i8) : i8
  %2 = llvm.xor %arg45, %0 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_is_mask_const_sge_proof : src_is_mask_const_sge_before ⊑ src_is_mask_const_sge_after := by
  unfold src_is_mask_const_sge_before src_is_mask_const_sge_after
  simp_alive_peephole
  intros
  ---BEGIN src_is_mask_const_sge
  all_goals (try extract_goal ; sorry)
  ---END src_is_mask_const_sge



def src_x_and_nmask_eq_before := [llvm|
{
^0(%arg30 : i8, %arg31 : i8, %arg32 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.shl %0, %arg31 : i8
  %3 = "llvm.select"(%arg32, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %arg30, %3 : i8
  %5 = llvm.icmp "eq" %3, %4 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def src_x_and_nmask_eq_after := [llvm|
{
^0(%arg30 : i8, %arg31 : i8, %arg32 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.shl %0, %arg31 overflow<nsw> : i8
  %3 = llvm.icmp "ule" %2, %arg30 : i8
  %4 = llvm.xor %arg32, %1 : i1
  %5 = "llvm.select"(%4, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_x_and_nmask_eq_proof : src_x_and_nmask_eq_before ⊑ src_x_and_nmask_eq_after := by
  unfold src_x_and_nmask_eq_before src_x_and_nmask_eq_after
  simp_alive_peephole
  intros
  ---BEGIN src_x_and_nmask_eq
  all_goals (try extract_goal ; sorry)
  ---END src_x_and_nmask_eq



def src_x_and_nmask_ne_before := [llvm|
{
^0(%arg27 : i8, %arg28 : i8, %arg29 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.shl %0, %arg28 : i8
  %3 = "llvm.select"(%arg29, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %arg27, %3 : i8
  %5 = llvm.icmp "ne" %4, %3 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def src_x_and_nmask_ne_after := [llvm|
{
^0(%arg27 : i8, %arg28 : i8, %arg29 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.shl %0, %arg28 overflow<nsw> : i8
  %3 = llvm.icmp "ugt" %2, %arg27 : i8
  %4 = "llvm.select"(%arg29, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_x_and_nmask_ne_proof : src_x_and_nmask_ne_before ⊑ src_x_and_nmask_ne_after := by
  unfold src_x_and_nmask_ne_before src_x_and_nmask_ne_after
  simp_alive_peephole
  intros
  ---BEGIN src_x_and_nmask_ne
  all_goals (try extract_goal ; sorry)
  ---END src_x_and_nmask_ne



def src_x_and_nmask_ult_before := [llvm|
{
^0(%arg24 : i8, %arg25 : i8, %arg26 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.shl %0, %arg25 : i8
  %3 = "llvm.select"(%arg26, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %arg24, %3 : i8
  %5 = llvm.icmp "ult" %4, %3 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def src_x_and_nmask_ult_after := [llvm|
{
^0(%arg24 : i8, %arg25 : i8, %arg26 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.shl %0, %arg25 overflow<nsw> : i8
  %3 = llvm.icmp "ugt" %2, %arg24 : i8
  %4 = "llvm.select"(%arg26, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_x_and_nmask_ult_proof : src_x_and_nmask_ult_before ⊑ src_x_and_nmask_ult_after := by
  unfold src_x_and_nmask_ult_before src_x_and_nmask_ult_after
  simp_alive_peephole
  intros
  ---BEGIN src_x_and_nmask_ult
  all_goals (try extract_goal ; sorry)
  ---END src_x_and_nmask_ult



def src_x_and_nmask_uge_before := [llvm|
{
^0(%arg21 : i8, %arg22 : i8, %arg23 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.shl %0, %arg22 : i8
  %3 = "llvm.select"(%arg23, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %arg21, %3 : i8
  %5 = llvm.icmp "uge" %4, %3 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def src_x_and_nmask_uge_after := [llvm|
{
^0(%arg21 : i8, %arg22 : i8, %arg23 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.shl %0, %arg22 overflow<nsw> : i8
  %3 = llvm.icmp "ule" %2, %arg21 : i8
  %4 = llvm.xor %arg23, %1 : i1
  %5 = "llvm.select"(%4, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_x_and_nmask_uge_proof : src_x_and_nmask_uge_before ⊑ src_x_and_nmask_uge_after := by
  unfold src_x_and_nmask_uge_before src_x_and_nmask_uge_after
  simp_alive_peephole
  intros
  ---BEGIN src_x_and_nmask_uge
  all_goals (try extract_goal ; sorry)
  ---END src_x_and_nmask_uge



def src_x_and_nmask_slt_before := [llvm|
{
^0(%arg19 : i8, %arg20 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg20 : i8
  %2 = llvm.and %arg19, %1 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def src_x_and_nmask_slt_after := [llvm|
{
^0(%arg19 : i8, %arg20 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg20 overflow<nsw> : i8
  %2 = llvm.icmp "sgt" %1, %arg19 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_x_and_nmask_slt_proof : src_x_and_nmask_slt_before ⊑ src_x_and_nmask_slt_after := by
  unfold src_x_and_nmask_slt_before src_x_and_nmask_slt_after
  simp_alive_peephole
  intros
  ---BEGIN src_x_and_nmask_slt
  all_goals (try extract_goal ; sorry)
  ---END src_x_and_nmask_slt



def src_x_and_nmask_sge_before := [llvm|
{
^0(%arg17 : i8, %arg18 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg18 : i8
  %2 = llvm.and %arg17, %1 : i8
  %3 = llvm.icmp "sge" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def src_x_and_nmask_sge_after := [llvm|
{
^0(%arg17 : i8, %arg18 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg18 overflow<nsw> : i8
  %2 = llvm.icmp "sle" %1, %arg17 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_x_and_nmask_sge_proof : src_x_and_nmask_sge_before ⊑ src_x_and_nmask_sge_after := by
  unfold src_x_and_nmask_sge_before src_x_and_nmask_sge_after
  simp_alive_peephole
  intros
  ---BEGIN src_x_and_nmask_sge
  all_goals (try extract_goal ; sorry)
  ---END src_x_and_nmask_sge



def src_x_and_nmask_slt_fail_maybe_z_before := [llvm|
{
^0(%arg14 : i8, %arg15 : i8, %arg16 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.shl %0, %arg15 : i8
  %3 = "llvm.select"(%arg16, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %arg14, %3 : i8
  %5 = llvm.icmp "slt" %4, %3 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def src_x_and_nmask_slt_fail_maybe_z_after := [llvm|
{
^0(%arg14 : i8, %arg15 : i8, %arg16 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.shl %0, %arg15 overflow<nsw> : i8
  %3 = "llvm.select"(%arg16, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %arg14, %3 : i8
  %5 = llvm.icmp "slt" %4, %3 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_x_and_nmask_slt_fail_maybe_z_proof : src_x_and_nmask_slt_fail_maybe_z_before ⊑ src_x_and_nmask_slt_fail_maybe_z_after := by
  unfold src_x_and_nmask_slt_fail_maybe_z_before src_x_and_nmask_slt_fail_maybe_z_after
  simp_alive_peephole
  intros
  ---BEGIN src_x_and_nmask_slt_fail_maybe_z
  all_goals (try extract_goal ; sorry)
  ---END src_x_and_nmask_slt_fail_maybe_z



def src_x_and_nmask_sge_fail_maybe_z_before := [llvm|
{
^0(%arg11 : i8, %arg12 : i8, %arg13 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.shl %0, %arg12 : i8
  %3 = "llvm.select"(%arg13, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %arg11, %3 : i8
  %5 = llvm.icmp "sge" %4, %3 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def src_x_and_nmask_sge_fail_maybe_z_after := [llvm|
{
^0(%arg11 : i8, %arg12 : i8, %arg13 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.shl %0, %arg12 overflow<nsw> : i8
  %3 = "llvm.select"(%arg13, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.and %arg11, %3 : i8
  %5 = llvm.icmp "sge" %4, %3 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_x_and_nmask_sge_fail_maybe_z_proof : src_x_and_nmask_sge_fail_maybe_z_before ⊑ src_x_and_nmask_sge_fail_maybe_z_after := by
  unfold src_x_and_nmask_sge_fail_maybe_z_before src_x_and_nmask_sge_fail_maybe_z_after
  simp_alive_peephole
  intros
  ---BEGIN src_x_and_nmask_sge_fail_maybe_z
  all_goals (try extract_goal ; sorry)
  ---END src_x_and_nmask_sge_fail_maybe_z



def src_x_or_mask_ne_before := [llvm|
{
^0(%arg3 : i8, %arg4 : i8, %arg5 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.lshr %0, %arg4 : i8
  %3 = "llvm.select"(%arg5, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.xor %arg3, %0 : i8
  %5 = llvm.or %3, %4 : i8
  %6 = llvm.icmp "ne" %5, %0 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def src_x_or_mask_ne_after := [llvm|
{
^0(%arg3 : i8, %arg4 : i8, %arg5 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.lshr %0, %arg4 : i8
  %3 = "llvm.select"(%arg5, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.icmp "ugt" %arg3, %3 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_x_or_mask_ne_proof : src_x_or_mask_ne_before ⊑ src_x_or_mask_ne_after := by
  unfold src_x_or_mask_ne_before src_x_or_mask_ne_after
  simp_alive_peephole
  intros
  ---BEGIN src_x_or_mask_ne
  all_goals (try extract_goal ; sorry)
  ---END src_x_or_mask_ne


