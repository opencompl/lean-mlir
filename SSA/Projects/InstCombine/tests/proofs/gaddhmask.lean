import SSA.Projects.InstCombine.tests.proofs.gaddhmask_proof
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
section gaddhmask_statements

def add_mask_sign_i32_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.ashr %arg6, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.add %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add_mask_sign_i32_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(7 : i32) : i32
  %2 = llvm.icmp "slt" %arg6, %0 : i32
  %3 = "llvm.select"(%2, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_mask_sign_i32_proof : add_mask_sign_i32_before ⊑ add_mask_sign_i32_after := by
  unfold add_mask_sign_i32_before add_mask_sign_i32_after
  simp_alive_peephole
  intros
  ---BEGIN add_mask_sign_i32
  apply add_mask_sign_i32_thm
  ---END add_mask_sign_i32



def add_mask_sign_commute_i32_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.ashr %arg5, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.add %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add_mask_sign_commute_i32_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(7 : i32) : i32
  %2 = llvm.icmp "slt" %arg5, %0 : i32
  %3 = "llvm.select"(%2, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_mask_sign_commute_i32_proof : add_mask_sign_commute_i32_before ⊑ add_mask_sign_commute_i32_after := by
  unfold add_mask_sign_commute_i32_before add_mask_sign_commute_i32_after
  simp_alive_peephole
  intros
  ---BEGIN add_mask_sign_commute_i32
  apply add_mask_sign_commute_i32_thm
  ---END add_mask_sign_commute_i32



def add_mask_ashr28_i32_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(28 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.ashr %arg2, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.add %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add_mask_ashr28_i32_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(28 : i32) : i32
  %1 = llvm.mlir.constant(7 : i32) : i32
  %2 = llvm.lshr %arg2, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_mask_ashr28_i32_proof : add_mask_ashr28_i32_before ⊑ add_mask_ashr28_i32_after := by
  unfold add_mask_ashr28_i32_before add_mask_ashr28_i32_after
  simp_alive_peephole
  intros
  ---BEGIN add_mask_ashr28_i32
  apply add_mask_ashr28_i32_thm
  ---END add_mask_ashr28_i32



def add_mask_ashr28_non_pow2_i32_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(28 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.ashr %arg1, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.add %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add_mask_ashr28_non_pow2_i32_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(28 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.ashr %arg1, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.add %3, %2 overflow<nsw> : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_mask_ashr28_non_pow2_i32_proof : add_mask_ashr28_non_pow2_i32_before ⊑ add_mask_ashr28_non_pow2_i32_after := by
  unfold add_mask_ashr28_non_pow2_i32_before add_mask_ashr28_non_pow2_i32_after
  simp_alive_peephole
  intros
  ---BEGIN add_mask_ashr28_non_pow2_i32
  apply add_mask_ashr28_non_pow2_i32_thm
  ---END add_mask_ashr28_non_pow2_i32



def add_mask_ashr27_i32_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(27 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.ashr %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.add %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def add_mask_ashr27_i32_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(27 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.ashr %arg0, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.add %3, %2 overflow<nsw> : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem add_mask_ashr27_i32_proof : add_mask_ashr27_i32_before ⊑ add_mask_ashr27_i32_after := by
  unfold add_mask_ashr27_i32_before add_mask_ashr27_i32_after
  simp_alive_peephole
  intros
  ---BEGIN add_mask_ashr27_i32
  apply add_mask_ashr27_i32_thm
  ---END add_mask_ashr27_i32


