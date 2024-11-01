import SSA.Projects.InstCombine.tests.proofs.gaddsubhconstanthfolding_proof
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
section gaddsubhconstanthfolding_statements

def add_const_add_const_before := [llvm|
{
^0(%arg71 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.add %arg71, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_const_add_const_after := [llvm|
{
^0(%arg71 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.add %arg71, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_const_add_const_proof : add_const_add_const_before ⊑ add_const_add_const_after := by
  unfold add_const_add_const_before add_const_add_const_after
  simp_alive_peephole
  intros
  ---BEGIN add_const_add_const
  apply add_const_add_const_thm
  ---END add_const_add_const



def add_const_sub_const_before := [llvm|
{
^0(%arg66 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.add %arg66, %0 : i32
  %3 = llvm.sub %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_const_sub_const_after := [llvm|
{
^0(%arg66 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.add %arg66, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_const_sub_const_proof : add_const_sub_const_before ⊑ add_const_sub_const_after := by
  unfold add_const_sub_const_before add_const_sub_const_after
  simp_alive_peephole
  intros
  ---BEGIN add_const_sub_const
  apply add_const_sub_const_thm
  ---END add_const_sub_const



def add_const_const_sub_before := [llvm|
{
^0(%arg61 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.add %arg61, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def add_const_const_sub_after := [llvm|
{
^0(%arg61 : i32):
  %0 = llvm.mlir.constant(-6 : i32) : i32
  %1 = llvm.sub %0, %arg61 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_const_const_sub_proof : add_const_const_sub_before ⊑ add_const_const_sub_after := by
  unfold add_const_const_sub_before add_const_const_sub_after
  simp_alive_peephole
  intros
  ---BEGIN add_const_const_sub
  apply add_const_const_sub_thm
  ---END add_const_const_sub



def add_nsw_const_const_sub_nsw_before := [llvm|
{
^0(%arg60 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-127 : i8) : i8
  %2 = llvm.add %arg60, %0 overflow<nsw> : i8
  %3 = llvm.sub %1, %2 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_nsw_const_const_sub_nsw_after := [llvm|
{
^0(%arg60 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.sub %0, %arg60 overflow<nsw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_nsw_const_const_sub_nsw_proof : add_nsw_const_const_sub_nsw_before ⊑ add_nsw_const_const_sub_nsw_after := by
  unfold add_nsw_const_const_sub_nsw_before add_nsw_const_const_sub_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN add_nsw_const_const_sub_nsw
  apply add_nsw_const_const_sub_nsw_thm
  ---END add_nsw_const_const_sub_nsw



def add_nsw_const_const_sub_before := [llvm|
{
^0(%arg59 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-127 : i8) : i8
  %2 = llvm.add %arg59, %0 overflow<nsw> : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_nsw_const_const_sub_after := [llvm|
{
^0(%arg59 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.sub %0, %arg59 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_nsw_const_const_sub_proof : add_nsw_const_const_sub_before ⊑ add_nsw_const_const_sub_after := by
  unfold add_nsw_const_const_sub_before add_nsw_const_const_sub_after
  simp_alive_peephole
  intros
  ---BEGIN add_nsw_const_const_sub
  apply add_nsw_const_const_sub_thm
  ---END add_nsw_const_const_sub



def add_const_const_sub_nsw_before := [llvm|
{
^0(%arg58 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-127 : i8) : i8
  %2 = llvm.add %arg58, %0 : i8
  %3 = llvm.sub %1, %2 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_const_const_sub_nsw_after := [llvm|
{
^0(%arg58 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.sub %0, %arg58 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_const_const_sub_nsw_proof : add_const_const_sub_nsw_before ⊑ add_const_const_sub_nsw_after := by
  unfold add_const_const_sub_nsw_before add_const_const_sub_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN add_const_const_sub_nsw
  apply add_const_const_sub_nsw_thm
  ---END add_const_const_sub_nsw



def add_nsw_const_const_sub_nsw_ov_before := [llvm|
{
^0(%arg57 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(-127 : i8) : i8
  %2 = llvm.add %arg57, %0 overflow<nsw> : i8
  %3 = llvm.sub %1, %2 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_nsw_const_const_sub_nsw_ov_after := [llvm|
{
^0(%arg57 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.sub %0, %arg57 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_nsw_const_const_sub_nsw_ov_proof : add_nsw_const_const_sub_nsw_ov_before ⊑ add_nsw_const_const_sub_nsw_ov_after := by
  unfold add_nsw_const_const_sub_nsw_ov_before add_nsw_const_const_sub_nsw_ov_after
  simp_alive_peephole
  intros
  ---BEGIN add_nsw_const_const_sub_nsw_ov
  apply add_nsw_const_const_sub_nsw_ov_thm
  ---END add_nsw_const_const_sub_nsw_ov



def add_nuw_const_const_sub_nuw_before := [llvm|
{
^0(%arg56 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-127 : i8) : i8
  %2 = llvm.add %arg56, %0 overflow<nuw> : i8
  %3 = llvm.sub %1, %2 overflow<nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_nuw_const_const_sub_nuw_after := [llvm|
{
^0(%arg56 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.sub %0, %arg56 overflow<nuw> : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_nuw_const_const_sub_nuw_proof : add_nuw_const_const_sub_nuw_before ⊑ add_nuw_const_const_sub_nuw_after := by
  unfold add_nuw_const_const_sub_nuw_before add_nuw_const_const_sub_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN add_nuw_const_const_sub_nuw
  apply add_nuw_const_const_sub_nuw_thm
  ---END add_nuw_const_const_sub_nuw



def add_nuw_const_const_sub_before := [llvm|
{
^0(%arg55 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-127 : i8) : i8
  %2 = llvm.add %arg55, %0 overflow<nuw> : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_nuw_const_const_sub_after := [llvm|
{
^0(%arg55 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.sub %0, %arg55 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_nuw_const_const_sub_proof : add_nuw_const_const_sub_before ⊑ add_nuw_const_const_sub_after := by
  unfold add_nuw_const_const_sub_before add_nuw_const_const_sub_after
  simp_alive_peephole
  intros
  ---BEGIN add_nuw_const_const_sub
  apply add_nuw_const_const_sub_thm
  ---END add_nuw_const_const_sub



def add_const_const_sub_nuw_before := [llvm|
{
^0(%arg54 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-127 : i8) : i8
  %2 = llvm.add %arg54, %0 : i8
  %3 = llvm.sub %1, %2 overflow<nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_const_const_sub_nuw_after := [llvm|
{
^0(%arg54 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.sub %0, %arg54 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_const_const_sub_nuw_proof : add_const_const_sub_nuw_before ⊑ add_const_const_sub_nuw_after := by
  unfold add_const_const_sub_nuw_before add_const_const_sub_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN add_const_const_sub_nuw
  apply add_const_const_sub_nuw_thm
  ---END add_const_const_sub_nuw



def sub_const_add_const_before := [llvm|
{
^0(%arg45 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.sub %arg45, %0 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sub_const_add_const_after := [llvm|
{
^0(%arg45 : i32):
  %0 = llvm.mlir.constant(-6 : i32) : i32
  %1 = llvm.add %arg45, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_const_add_const_proof : sub_const_add_const_before ⊑ sub_const_add_const_after := by
  unfold sub_const_add_const_before sub_const_add_const_after
  simp_alive_peephole
  intros
  ---BEGIN sub_const_add_const
  apply sub_const_add_const_thm
  ---END sub_const_add_const



def sub_const_sub_const_before := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.sub %arg40, %0 : i32
  %3 = llvm.sub %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sub_const_sub_const_after := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(-10 : i32) : i32
  %1 = llvm.add %arg40, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_const_sub_const_proof : sub_const_sub_const_before ⊑ sub_const_sub_const_after := by
  unfold sub_const_sub_const_before sub_const_sub_const_after
  simp_alive_peephole
  intros
  ---BEGIN sub_const_sub_const
  apply sub_const_sub_const_thm
  ---END sub_const_sub_const



def sub_const_const_sub_before := [llvm|
{
^0(%arg35 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.sub %arg35, %0 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sub_const_const_sub_after := [llvm|
{
^0(%arg35 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.sub %0, %arg35 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_const_const_sub_proof : sub_const_const_sub_before ⊑ sub_const_const_sub_after := by
  unfold sub_const_const_sub_before sub_const_const_sub_after
  simp_alive_peephole
  intros
  ---BEGIN sub_const_const_sub
  apply sub_const_const_sub_thm
  ---END sub_const_const_sub



def const_sub_add_const_before := [llvm|
{
^0(%arg30 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.sub %0, %arg30 : i32
  %3 = llvm.add %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def const_sub_add_const_after := [llvm|
{
^0(%arg30 : i32):
  %0 = llvm.mlir.constant(10 : i32) : i32
  %1 = llvm.sub %0, %arg30 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem const_sub_add_const_proof : const_sub_add_const_before ⊑ const_sub_add_const_after := by
  unfold const_sub_add_const_before const_sub_add_const_after
  simp_alive_peephole
  intros
  ---BEGIN const_sub_add_const
  apply const_sub_add_const_thm
  ---END const_sub_add_const



def const_sub_sub_const_before := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.sub %0, %arg25 : i32
  %3 = llvm.sub %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def const_sub_sub_const_after := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.sub %0, %arg25 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem const_sub_sub_const_proof : const_sub_sub_const_before ⊑ const_sub_sub_const_after := by
  unfold const_sub_sub_const_before const_sub_sub_const_after
  simp_alive_peephole
  intros
  ---BEGIN const_sub_sub_const
  apply const_sub_sub_const_thm
  ---END const_sub_sub_const



def const_sub_const_sub_before := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.sub %0, %arg20 : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def const_sub_const_sub_after := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(-6 : i32) : i32
  %1 = llvm.add %arg20, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem const_sub_const_sub_proof : const_sub_const_sub_before ⊑ const_sub_const_sub_after := by
  unfold const_sub_const_sub_before const_sub_const_sub_after
  simp_alive_peephole
  intros
  ---BEGIN const_sub_const_sub
  apply const_sub_const_sub_thm
  ---END const_sub_const_sub



def addsub_combine_constants_before := [llvm|
{
^0(%arg14 : i7, %arg15 : i7):
  %0 = llvm.mlir.constant(42 : i7) : i7
  %1 = llvm.mlir.constant(10 : i7) : i7
  %2 = llvm.add %arg14, %0 : i7
  %3 = llvm.sub %1, %arg15 : i7
  %4 = llvm.add %2, %3 overflow<nsw> : i7
  "llvm.return"(%4) : (i7) -> ()
}
]
def addsub_combine_constants_after := [llvm|
{
^0(%arg14 : i7, %arg15 : i7):
  %0 = llvm.mlir.constant(52 : i7) : i7
  %1 = llvm.sub %arg14, %arg15 : i7
  %2 = llvm.add %1, %0 : i7
  "llvm.return"(%2) : (i7) -> ()
}
]
set_option debug.skipKernelTC true in
theorem addsub_combine_constants_proof : addsub_combine_constants_before ⊑ addsub_combine_constants_after := by
  unfold addsub_combine_constants_before addsub_combine_constants_after
  simp_alive_peephole
  intros
  ---BEGIN addsub_combine_constants
  apply addsub_combine_constants_thm
  ---END addsub_combine_constants



def sub_from_constant_before := [llvm|
{
^0(%arg6 : i5, %arg7 : i5):
  %0 = llvm.mlir.constant(10 : i5) : i5
  %1 = llvm.sub %0, %arg6 : i5
  %2 = llvm.add %1, %arg7 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
def sub_from_constant_after := [llvm|
{
^0(%arg6 : i5, %arg7 : i5):
  %0 = llvm.mlir.constant(10 : i5) : i5
  %1 = llvm.sub %arg7, %arg6 : i5
  %2 = llvm.add %1, %0 : i5
  "llvm.return"(%2) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_from_constant_proof : sub_from_constant_before ⊑ sub_from_constant_after := by
  unfold sub_from_constant_before sub_from_constant_after
  simp_alive_peephole
  intros
  ---BEGIN sub_from_constant
  apply sub_from_constant_thm
  ---END sub_from_constant



def sub_from_constant_commute_before := [llvm|
{
^0(%arg4 : i5, %arg5 : i5):
  %0 = llvm.mlir.constant(10 : i5) : i5
  %1 = llvm.mul %arg5, %arg5 : i5
  %2 = llvm.sub %0, %arg4 overflow<nsw> : i5
  %3 = llvm.add %1, %2 overflow<nsw> : i5
  "llvm.return"(%3) : (i5) -> ()
}
]
def sub_from_constant_commute_after := [llvm|
{
^0(%arg4 : i5, %arg5 : i5):
  %0 = llvm.mlir.constant(10 : i5) : i5
  %1 = llvm.mul %arg5, %arg5 : i5
  %2 = llvm.sub %1, %arg4 : i5
  %3 = llvm.add %2, %0 : i5
  "llvm.return"(%3) : (i5) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sub_from_constant_commute_proof : sub_from_constant_commute_before ⊑ sub_from_constant_commute_after := by
  unfold sub_from_constant_commute_before sub_from_constant_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sub_from_constant_commute
  apply sub_from_constant_commute_thm
  ---END sub_from_constant_commute


