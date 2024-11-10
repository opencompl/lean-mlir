import SSA.Projects.InstCombine.tests.proofs.gsdivhexacthbyhpowerhofhtwo_proof
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
section gsdivhexacthbyhpowerhofhtwo_statements

def t0_before := [llvm|
{
^0(%arg22 : i8):
  %0 = llvm.mlir.constant(32 : i8) : i8
  %1 = llvm.sdiv exact %arg22, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg22 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.ashr exact %arg22, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  intros
  ---BEGIN t0
  apply t0_thm
  ---END t0



def n2_before := [llvm|
{
^0(%arg20 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.sdiv %arg20, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
def n2_after := [llvm|
{
^0(%arg20 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "eq" %arg20, %0 : i8
  %2 = llvm.zext %1 : i1 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n2_proof : n2_before ⊑ n2_after := by
  unfold n2_before n2_after
  simp_alive_peephole
  intros
  ---BEGIN n2
  apply n2_thm
  ---END n2



def shl1_nsw_before := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %0, %arg15 overflow<nsw> : i8
  %2 = llvm.sdiv exact %arg14, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def shl1_nsw_after := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.ashr exact %arg14, %arg15 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl1_nsw_proof : shl1_nsw_before ⊑ shl1_nsw_after := by
  unfold shl1_nsw_before shl1_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN shl1_nsw
  apply shl1_nsw_thm
  ---END shl1_nsw



def shl1_nsw_not_exact_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %0, %arg11 overflow<nsw> : i8
  %2 = llvm.sdiv %arg10, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def shl1_nsw_not_exact_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.shl %0, %arg11 overflow<nsw,nuw> : i8
  %2 = llvm.sdiv %arg10, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl1_nsw_not_exact_proof : shl1_nsw_not_exact_before ⊑ shl1_nsw_not_exact_after := by
  unfold shl1_nsw_not_exact_before shl1_nsw_not_exact_after
  simp_alive_peephole
  intros
  ---BEGIN shl1_nsw_not_exact
  apply shl1_nsw_not_exact_thm
  ---END shl1_nsw_not_exact



def prove_exact_with_high_mask_before := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.mlir.constant(4 : i8) : i8
  %2 = llvm.and %arg8, %0 : i8
  %3 = llvm.sdiv %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def prove_exact_with_high_mask_after := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.ashr %arg8, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem prove_exact_with_high_mask_proof : prove_exact_with_high_mask_before ⊑ prove_exact_with_high_mask_after := by
  unfold prove_exact_with_high_mask_before prove_exact_with_high_mask_after
  simp_alive_peephole
  intros
  ---BEGIN prove_exact_with_high_mask
  apply prove_exact_with_high_mask_thm
  ---END prove_exact_with_high_mask



def prove_exact_with_high_mask_limit_before := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.mlir.constant(8 : i8) : i8
  %2 = llvm.and %arg6, %0 : i8
  %3 = llvm.sdiv %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def prove_exact_with_high_mask_limit_after := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.ashr %arg6, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem prove_exact_with_high_mask_limit_proof : prove_exact_with_high_mask_limit_before ⊑ prove_exact_with_high_mask_limit_after := by
  unfold prove_exact_with_high_mask_limit_before prove_exact_with_high_mask_limit_after
  simp_alive_peephole
  intros
  ---BEGIN prove_exact_with_high_mask_limit
  apply prove_exact_with_high_mask_limit_thm
  ---END prove_exact_with_high_mask_limit


