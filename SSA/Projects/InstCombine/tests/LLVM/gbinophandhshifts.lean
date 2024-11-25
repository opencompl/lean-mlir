
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
section gbinophandhshifts_statements

def shl_and_and_before := [llvm|
{
^0(%arg172 : i8, %arg173 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(88 : i8) : i8
  %2 = llvm.shl %arg172, %0 : i8
  %3 = llvm.shl %arg173, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.and %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_and_and_after := [llvm|
{
^0(%arg172 : i8, %arg173 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(80 : i8) : i8
  %2 = llvm.and %arg173, %arg172 : i8
  %3 = llvm.shl %2, %0 : i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_and_and_proof : shl_and_and_before ⊑ shl_and_and_after := by
  unfold shl_and_and_before shl_and_and_after
  simp_alive_peephole
  intros
  ---BEGIN shl_and_and
  all_goals (try extract_goal ; sorry)
  ---END shl_and_and



def shl_and_and_fail_before := [llvm|
{
^0(%arg170 : i8, %arg171 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.mlir.constant(88 : i8) : i8
  %3 = llvm.shl %arg170, %0 : i8
  %4 = llvm.shl %arg171, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.and %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def shl_and_and_fail_after := [llvm|
{
^0(%arg170 : i8, %arg171 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.mlir.constant(64 : i8) : i8
  %3 = llvm.shl %arg170, %0 : i8
  %4 = llvm.shl %arg171, %1 : i8
  %5 = llvm.and %4, %2 : i8
  %6 = llvm.and %3, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_and_and_fail_proof : shl_and_and_fail_before ⊑ shl_and_and_fail_after := by
  unfold shl_and_and_fail_before shl_and_and_fail_after
  simp_alive_peephole
  intros
  ---BEGIN shl_and_and_fail
  all_goals (try extract_goal ; sorry)
  ---END shl_and_and_fail



def shl_add_add_before := [llvm|
{
^0(%arg168 : i8, %arg169 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(48 : i8) : i8
  %2 = llvm.shl %arg168, %0 : i8
  %3 = llvm.shl %arg169, %0 : i8
  %4 = llvm.add %3, %1 : i8
  %5 = llvm.add %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_add_add_after := [llvm|
{
^0(%arg168 : i8, %arg169 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(48 : i8) : i8
  %2 = llvm.add %arg169, %arg168 : i8
  %3 = llvm.shl %2, %0 : i8
  %4 = llvm.add %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_add_proof : shl_add_add_before ⊑ shl_add_add_after := by
  unfold shl_add_add_before shl_add_add_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_add
  all_goals (try extract_goal ; sorry)
  ---END shl_add_add



def shl_add_add_fail_before := [llvm|
{
^0(%arg166 : i8, %arg167 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(48 : i8) : i8
  %2 = llvm.lshr %arg166, %0 : i8
  %3 = llvm.lshr %arg167, %0 : i8
  %4 = llvm.add %3, %1 : i8
  %5 = llvm.add %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_add_add_fail_after := [llvm|
{
^0(%arg166 : i8, %arg167 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(48 : i8) : i8
  %2 = llvm.lshr %arg166, %0 : i8
  %3 = llvm.lshr %arg167, %0 : i8
  %4 = llvm.add %3, %1 overflow<nsw,nuw> : i8
  %5 = llvm.add %2, %4 overflow<nuw> : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_add_fail_proof : shl_add_add_fail_before ⊑ shl_add_add_fail_after := by
  unfold shl_add_add_fail_before shl_add_add_fail_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_add_fail
  all_goals (try extract_goal ; sorry)
  ---END shl_add_add_fail



def shl_and_xor_before := [llvm|
{
^0(%arg158 : i8, %arg159 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(20 : i8) : i8
  %2 = llvm.shl %arg158, %0 : i8
  %3 = llvm.shl %arg159, %0 : i8
  %4 = llvm.and %2, %1 : i8
  %5 = llvm.xor %3, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_and_xor_after := [llvm|
{
^0(%arg158 : i8, %arg159 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.and %arg158, %0 : i8
  %3 = llvm.xor %arg159, %2 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_and_xor_proof : shl_and_xor_before ⊑ shl_and_xor_after := by
  unfold shl_and_xor_before shl_and_xor_after
  simp_alive_peephole
  intros
  ---BEGIN shl_and_xor
  all_goals (try extract_goal ; sorry)
  ---END shl_and_xor



def shl_and_add_before := [llvm|
{
^0(%arg156 : i8, %arg157 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(119 : i8) : i8
  %2 = llvm.shl %arg156, %0 : i8
  %3 = llvm.shl %arg157, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.add %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_and_add_after := [llvm|
{
^0(%arg156 : i8, %arg157 : i8):
  %0 = llvm.mlir.constant(59 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.and %arg157, %0 : i8
  %3 = llvm.add %arg156, %2 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_and_add_proof : shl_and_add_before ⊑ shl_and_add_after := by
  unfold shl_and_add_before shl_and_add_after
  simp_alive_peephole
  intros
  ---BEGIN shl_and_add
  all_goals (try extract_goal ; sorry)
  ---END shl_and_add



def lshr_or_and_before := [llvm|
{
^0(%arg152 : i8, %arg153 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(-58 : i8) : i8
  %2 = llvm.lshr %arg152, %0 : i8
  %3 = llvm.lshr %arg153, %0 : i8
  %4 = llvm.or %2, %1 : i8
  %5 = llvm.and %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_or_and_after := [llvm|
{
^0(%arg152 : i8, %arg153 : i8):
  %0 = llvm.mlir.constant(-64 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.or %arg152, %0 : i8
  %3 = llvm.and %arg153, %2 : i8
  %4 = llvm.lshr %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_or_and_proof : lshr_or_and_before ⊑ lshr_or_and_after := by
  unfold lshr_or_and_before lshr_or_and_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_or_and
  all_goals (try extract_goal ; sorry)
  ---END lshr_or_and



def lshr_or_or_fail_before := [llvm|
{
^0(%arg150 : i8, %arg151 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(-58 : i8) : i8
  %2 = llvm.lshr %arg150, %0 : i8
  %3 = llvm.lshr %arg151, %0 : i8
  %4 = llvm.or %3, %1 : i8
  %5 = llvm.or %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_or_or_fail_after := [llvm|
{
^0(%arg150 : i8, %arg151 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(-58 : i8) : i8
  %2 = llvm.or %arg151, %arg150 : i8
  %3 = llvm.lshr %2, %0 : i8
  %4 = llvm.or %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_or_or_fail_proof : lshr_or_or_fail_before ⊑ lshr_or_or_fail_after := by
  unfold lshr_or_or_fail_before lshr_or_or_fail_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_or_or_fail
  all_goals (try extract_goal ; sorry)
  ---END lshr_or_or_fail



def lshr_or_or_no_const_before := [llvm|
{
^0(%arg142 : i8, %arg143 : i8, %arg144 : i8, %arg145 : i8):
  %0 = llvm.lshr %arg142, %arg144 : i8
  %1 = llvm.lshr %arg143, %arg144 : i8
  %2 = llvm.or %1, %arg145 : i8
  %3 = llvm.or %0, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def lshr_or_or_no_const_after := [llvm|
{
^0(%arg142 : i8, %arg143 : i8, %arg144 : i8, %arg145 : i8):
  %0 = llvm.or %arg143, %arg142 : i8
  %1 = llvm.lshr %0, %arg144 : i8
  %2 = llvm.or %1, %arg145 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_or_or_no_const_proof : lshr_or_or_no_const_before ⊑ lshr_or_or_no_const_after := by
  unfold lshr_or_or_no_const_before lshr_or_or_no_const_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_or_or_no_const
  all_goals (try extract_goal ; sorry)
  ---END lshr_or_or_no_const



def shl_xor_xor_no_const_before := [llvm|
{
^0(%arg134 : i8, %arg135 : i8, %arg136 : i8, %arg137 : i8):
  %0 = llvm.shl %arg134, %arg136 : i8
  %1 = llvm.shl %arg135, %arg136 : i8
  %2 = llvm.xor %1, %arg137 : i8
  %3 = llvm.xor %0, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def shl_xor_xor_no_const_after := [llvm|
{
^0(%arg134 : i8, %arg135 : i8, %arg136 : i8, %arg137 : i8):
  %0 = llvm.xor %arg135, %arg134 : i8
  %1 = llvm.shl %0, %arg136 : i8
  %2 = llvm.xor %1, %arg137 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_xor_xor_no_const_proof : shl_xor_xor_no_const_before ⊑ shl_xor_xor_no_const_after := by
  unfold shl_xor_xor_no_const_before shl_xor_xor_no_const_after
  simp_alive_peephole
  intros
  ---BEGIN shl_xor_xor_no_const
  all_goals (try extract_goal ; sorry)
  ---END shl_xor_xor_no_const



def shl_add_add_no_const_before := [llvm|
{
^0(%arg122 : i8, %arg123 : i8, %arg124 : i8, %arg125 : i8):
  %0 = llvm.shl %arg122, %arg124 : i8
  %1 = llvm.shl %arg123, %arg124 : i8
  %2 = llvm.add %1, %arg125 : i8
  %3 = llvm.add %0, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def shl_add_add_no_const_after := [llvm|
{
^0(%arg122 : i8, %arg123 : i8, %arg124 : i8, %arg125 : i8):
  %0 = llvm.add %arg123, %arg122 : i8
  %1 = llvm.shl %0, %arg124 : i8
  %2 = llvm.add %1, %arg125 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_add_no_const_proof : shl_add_add_no_const_before ⊑ shl_add_add_no_const_after := by
  unfold shl_add_add_no_const_before shl_add_add_no_const_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_add_no_const
  all_goals (try extract_goal ; sorry)
  ---END shl_add_add_no_const



def lshr_xor_or_good_mask_before := [llvm|
{
^0(%arg108 : i8, %arg109 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(48 : i8) : i8
  %2 = llvm.lshr %arg108, %0 : i8
  %3 = llvm.lshr %arg109, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_xor_or_good_mask_after := [llvm|
{
^0(%arg108 : i8, %arg109 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(48 : i8) : i8
  %2 = llvm.or %arg109, %arg108 : i8
  %3 = llvm.lshr %2, %0 : i8
  %4 = llvm.or disjoint %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_xor_or_good_mask_proof : lshr_xor_or_good_mask_before ⊑ lshr_xor_or_good_mask_after := by
  unfold lshr_xor_or_good_mask_before lshr_xor_or_good_mask_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_xor_or_good_mask
  all_goals (try extract_goal ; sorry)
  ---END lshr_xor_or_good_mask



def shl_xor_xor_good_mask_before := [llvm|
{
^0(%arg100 : i8, %arg101 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(88 : i8) : i8
  %2 = llvm.shl %arg100, %0 : i8
  %3 = llvm.shl %arg101, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.xor %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_xor_xor_good_mask_after := [llvm|
{
^0(%arg100 : i8, %arg101 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(88 : i8) : i8
  %2 = llvm.xor %arg101, %arg100 : i8
  %3 = llvm.shl %2, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_xor_xor_good_mask_proof : shl_xor_xor_good_mask_before ⊑ shl_xor_xor_good_mask_after := by
  unfold shl_xor_xor_good_mask_before shl_xor_xor_good_mask_after
  simp_alive_peephole
  intros
  ---BEGIN shl_xor_xor_good_mask
  all_goals (try extract_goal ; sorry)
  ---END shl_xor_xor_good_mask



def shl_xor_xor_bad_mask_distribute_before := [llvm|
{
^0(%arg98 : i8, %arg99 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-68 : i8) : i8
  %2 = llvm.shl %arg98, %0 : i8
  %3 = llvm.shl %arg99, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.xor %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_xor_xor_bad_mask_distribute_after := [llvm|
{
^0(%arg98 : i8, %arg99 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-68 : i8) : i8
  %2 = llvm.xor %arg99, %arg98 : i8
  %3 = llvm.shl %2, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_xor_xor_bad_mask_distribute_proof : shl_xor_xor_bad_mask_distribute_before ⊑ shl_xor_xor_bad_mask_distribute_after := by
  unfold shl_xor_xor_bad_mask_distribute_before shl_xor_xor_bad_mask_distribute_after
  simp_alive_peephole
  intros
  ---BEGIN shl_xor_xor_bad_mask_distribute
  all_goals (try extract_goal ; sorry)
  ---END shl_xor_xor_bad_mask_distribute



def shl_add_and_before := [llvm|
{
^0(%arg96 : i8, %arg97 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.shl %arg96, %0 : i8
  %3 = llvm.shl %arg97, %0 : i8
  %4 = llvm.add %3, %1 : i8
  %5 = llvm.and %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_add_and_after := [llvm|
{
^0(%arg96 : i8, %arg97 : i8):
  %0 = llvm.mlir.constant(61 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.add %arg97, %0 : i8
  %3 = llvm.and %arg96, %2 : i8
  %4 = llvm.shl %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_and_proof : shl_add_and_before ⊑ shl_add_and_after := by
  unfold shl_add_and_before shl_add_and_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_and
  all_goals (try extract_goal ; sorry)
  ---END shl_add_and



def lshr_and_add_fail_before := [llvm|
{
^0(%arg94 : i8, %arg95 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.lshr %arg94, %0 : i8
  %3 = llvm.lshr %arg95, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.add %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_and_add_fail_after := [llvm|
{
^0(%arg94 : i8, %arg95 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.lshr %arg94, %0 : i8
  %3 = llvm.lshr %arg95, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.add %2, %4 overflow<nuw> : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_and_add_fail_proof : lshr_and_add_fail_before ⊑ lshr_and_add_fail_after := by
  unfold lshr_and_add_fail_before lshr_and_add_fail_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_and_add_fail
  all_goals (try extract_goal ; sorry)
  ---END lshr_and_add_fail



def lshr_add_or_fail_before := [llvm|
{
^0(%arg92 : i8, %arg93 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.lshr %arg92, %0 : i8
  %3 = llvm.lshr %arg93, %0 : i8
  %4 = llvm.add %3, %1 : i8
  %5 = llvm.or %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_add_or_fail_after := [llvm|
{
^0(%arg92 : i8, %arg93 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.lshr %arg92, %0 : i8
  %3 = llvm.lshr %arg93, %0 : i8
  %4 = llvm.add %3, %1 overflow<nuw> : i8
  %5 = llvm.or %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_add_or_fail_proof : lshr_add_or_fail_before ⊑ lshr_add_or_fail_after := by
  unfold lshr_add_or_fail_before lshr_add_or_fail_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_add_or_fail
  all_goals (try extract_goal ; sorry)
  ---END lshr_add_or_fail



def lshr_add_xor_fail_before := [llvm|
{
^0(%arg90 : i8, %arg91 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.lshr %arg90, %0 : i8
  %3 = llvm.lshr %arg91, %0 : i8
  %4 = llvm.add %3, %1 : i8
  %5 = llvm.xor %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def lshr_add_xor_fail_after := [llvm|
{
^0(%arg90 : i8, %arg91 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.lshr %arg90, %0 : i8
  %3 = llvm.lshr %arg91, %0 : i8
  %4 = llvm.add %3, %1 overflow<nuw> : i8
  %5 = llvm.xor %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_add_xor_fail_proof : lshr_add_xor_fail_before ⊑ lshr_add_xor_fail_after := by
  unfold lshr_add_xor_fail_before lshr_add_xor_fail_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_add_xor_fail
  all_goals (try extract_goal ; sorry)
  ---END lshr_add_xor_fail



def shl_add_and_fail_mismatch_shift_before := [llvm|
{
^0(%arg84 : i8, %arg85 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.shl %arg84, %0 : i8
  %3 = llvm.lshr %arg85, %0 : i8
  %4 = llvm.add %3, %1 : i8
  %5 = llvm.and %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def shl_add_and_fail_mismatch_shift_after := [llvm|
{
^0(%arg84 : i8, %arg85 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(123 : i8) : i8
  %2 = llvm.shl %arg84, %0 : i8
  %3 = llvm.lshr %arg85, %0 : i8
  %4 = llvm.add %3, %1 overflow<nuw> : i8
  %5 = llvm.and %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_add_and_fail_mismatch_shift_proof : shl_add_and_fail_mismatch_shift_before ⊑ shl_add_and_fail_mismatch_shift_after := by
  unfold shl_add_and_fail_mismatch_shift_before shl_add_and_fail_mismatch_shift_after
  simp_alive_peephole
  intros
  ---BEGIN shl_add_and_fail_mismatch_shift
  all_goals (try extract_goal ; sorry)
  ---END shl_add_and_fail_mismatch_shift



def and_ashr_not_before := [llvm|
{
^0(%arg81 : i8, %arg82 : i8, %arg83 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.ashr %arg81, %arg83 : i8
  %2 = llvm.ashr %arg82, %arg83 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.and %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def and_ashr_not_after := [llvm|
{
^0(%arg81 : i8, %arg82 : i8, %arg83 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg82, %0 : i8
  %2 = llvm.and %arg81, %1 : i8
  %3 = llvm.ashr %2, %arg83 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ashr_not_proof : and_ashr_not_before ⊑ and_ashr_not_after := by
  unfold and_ashr_not_before and_ashr_not_after
  simp_alive_peephole
  intros
  ---BEGIN and_ashr_not
  all_goals (try extract_goal ; sorry)
  ---END and_ashr_not



def and_ashr_not_commuted_before := [llvm|
{
^0(%arg78 : i8, %arg79 : i8, %arg80 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.ashr %arg78, %arg80 : i8
  %2 = llvm.ashr %arg79, %arg80 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def and_ashr_not_commuted_after := [llvm|
{
^0(%arg78 : i8, %arg79 : i8, %arg80 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg79, %0 : i8
  %2 = llvm.and %arg78, %1 : i8
  %3 = llvm.ashr %2, %arg80 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem and_ashr_not_commuted_proof : and_ashr_not_commuted_before ⊑ and_ashr_not_commuted_after := by
  unfold and_ashr_not_commuted_before and_ashr_not_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN and_ashr_not_commuted
  all_goals (try extract_goal ; sorry)
  ---END and_ashr_not_commuted



def or_ashr_not_before := [llvm|
{
^0(%arg54 : i8, %arg55 : i8, %arg56 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.ashr %arg54, %arg56 : i8
  %2 = llvm.ashr %arg55, %arg56 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.or %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def or_ashr_not_after := [llvm|
{
^0(%arg54 : i8, %arg55 : i8, %arg56 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg55, %0 : i8
  %2 = llvm.or %arg54, %1 : i8
  %3 = llvm.ashr %2, %arg56 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_ashr_not_proof : or_ashr_not_before ⊑ or_ashr_not_after := by
  unfold or_ashr_not_before or_ashr_not_after
  simp_alive_peephole
  intros
  ---BEGIN or_ashr_not
  all_goals (try extract_goal ; sorry)
  ---END or_ashr_not



def or_ashr_not_commuted_before := [llvm|
{
^0(%arg51 : i8, %arg52 : i8, %arg53 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.ashr %arg51, %arg53 : i8
  %2 = llvm.ashr %arg52, %arg53 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.or %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def or_ashr_not_commuted_after := [llvm|
{
^0(%arg51 : i8, %arg52 : i8, %arg53 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg52, %0 : i8
  %2 = llvm.or %arg51, %1 : i8
  %3 = llvm.ashr %2, %arg53 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem or_ashr_not_commuted_proof : or_ashr_not_commuted_before ⊑ or_ashr_not_commuted_after := by
  unfold or_ashr_not_commuted_before or_ashr_not_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN or_ashr_not_commuted
  all_goals (try extract_goal ; sorry)
  ---END or_ashr_not_commuted



def xor_ashr_not_before := [llvm|
{
^0(%arg27 : i8, %arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.ashr %arg27, %arg29 : i8
  %2 = llvm.ashr %arg28, %arg29 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.xor %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def xor_ashr_not_after := [llvm|
{
^0(%arg27 : i8, %arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg28, %arg27 : i8
  %2 = llvm.ashr %1, %arg29 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_ashr_not_proof : xor_ashr_not_before ⊑ xor_ashr_not_after := by
  unfold xor_ashr_not_before xor_ashr_not_after
  simp_alive_peephole
  intros
  ---BEGIN xor_ashr_not
  all_goals (try extract_goal ; sorry)
  ---END xor_ashr_not



def xor_ashr_not_commuted_before := [llvm|
{
^0(%arg24 : i8, %arg25 : i8, %arg26 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.ashr %arg24, %arg26 : i8
  %2 = llvm.ashr %arg25, %arg26 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.xor %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def xor_ashr_not_commuted_after := [llvm|
{
^0(%arg24 : i8, %arg25 : i8, %arg26 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg25, %arg24 : i8
  %2 = llvm.ashr %1, %arg26 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_ashr_not_commuted_proof : xor_ashr_not_commuted_before ⊑ xor_ashr_not_commuted_after := by
  unfold xor_ashr_not_commuted_before xor_ashr_not_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN xor_ashr_not_commuted
  all_goals (try extract_goal ; sorry)
  ---END xor_ashr_not_commuted



def xor_ashr_not_fail_lshr_ashr_before := [llvm|
{
^0(%arg21 : i8, %arg22 : i8, %arg23 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.lshr %arg21, %arg23 : i8
  %2 = llvm.ashr %arg22, %arg23 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.xor %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def xor_ashr_not_fail_lshr_ashr_after := [llvm|
{
^0(%arg21 : i8, %arg22 : i8, %arg23 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.lshr %arg21, %arg23 : i8
  %2 = llvm.ashr %arg22, %arg23 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.xor %3, %0 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_ashr_not_fail_lshr_ashr_proof : xor_ashr_not_fail_lshr_ashr_before ⊑ xor_ashr_not_fail_lshr_ashr_after := by
  unfold xor_ashr_not_fail_lshr_ashr_before xor_ashr_not_fail_lshr_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN xor_ashr_not_fail_lshr_ashr
  all_goals (try extract_goal ; sorry)
  ---END xor_ashr_not_fail_lshr_ashr



def xor_ashr_not_fail_ashr_lshr_before := [llvm|
{
^0(%arg18 : i8, %arg19 : i8, %arg20 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.ashr %arg18, %arg20 : i8
  %2 = llvm.lshr %arg19, %arg20 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.xor %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def xor_ashr_not_fail_ashr_lshr_after := [llvm|
{
^0(%arg18 : i8, %arg19 : i8, %arg20 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.ashr %arg18, %arg20 : i8
  %2 = llvm.lshr %arg19, %arg20 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.xor %3, %0 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_ashr_not_fail_ashr_lshr_proof : xor_ashr_not_fail_ashr_lshr_before ⊑ xor_ashr_not_fail_ashr_lshr_after := by
  unfold xor_ashr_not_fail_ashr_lshr_before xor_ashr_not_fail_ashr_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN xor_ashr_not_fail_ashr_lshr
  all_goals (try extract_goal ; sorry)
  ---END xor_ashr_not_fail_ashr_lshr



def xor_ashr_not_fail_invalid_xor_constant_before := [llvm|
{
^0(%arg15 : i8, %arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.ashr %arg15, %arg17 : i8
  %2 = llvm.ashr %arg16, %arg17 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.xor %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def xor_ashr_not_fail_invalid_xor_constant_after := [llvm|
{
^0(%arg15 : i8, %arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(-2 : i8) : i8
  %1 = llvm.xor %arg16, %arg15 : i8
  %2 = llvm.ashr %1, %arg17 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_ashr_not_fail_invalid_xor_constant_proof : xor_ashr_not_fail_invalid_xor_constant_before ⊑ xor_ashr_not_fail_invalid_xor_constant_after := by
  unfold xor_ashr_not_fail_invalid_xor_constant_before xor_ashr_not_fail_invalid_xor_constant_after
  simp_alive_peephole
  intros
  ---BEGIN xor_ashr_not_fail_invalid_xor_constant
  all_goals (try extract_goal ; sorry)
  ---END xor_ashr_not_fail_invalid_xor_constant


