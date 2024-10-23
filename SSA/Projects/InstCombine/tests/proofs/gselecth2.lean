import SSA.Projects.InstCombine.tests.proofs.gselecth2_proof
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
section gselecth2_statements

def ashr_exact_poison_constant_fold_before := [llvm|
{
^0(%arg10 : i1, %arg11 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = "llvm.select"(%arg10, %arg11, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.ashr %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def ashr_exact_poison_constant_fold_after := [llvm|
{
^0(%arg10 : i1, %arg11 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 5 : i8}> : () -> i8
  %2 = llvm.ashr %arg11, %0 : i8
  %3 = "llvm.select"(%arg10, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem ashr_exact_poison_constant_fold_proof : ashr_exact_poison_constant_fold_before ⊑ ashr_exact_poison_constant_fold_after := by
  unfold ashr_exact_poison_constant_fold_before ashr_exact_poison_constant_fold_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN ashr_exact_poison_constant_fold
  apply ashr_exact_poison_constant_fold_thm
  ---END ashr_exact_poison_constant_fold



def ashr_exact_before := [llvm|
{
^0(%arg8 : i1, %arg9 : i8):
  %0 = "llvm.mlir.constant"() <{value = 16 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %2 = "llvm.select"(%arg8, %arg9, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.ashr %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def ashr_exact_after := [llvm|
{
^0(%arg8 : i1, %arg9 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %2 = llvm.ashr %arg9, %0 : i8
  %3 = "llvm.select"(%arg8, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem ashr_exact_proof : ashr_exact_before ⊑ ashr_exact_after := by
  unfold ashr_exact_before ashr_exact_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN ashr_exact
  apply ashr_exact_thm
  ---END ashr_exact



def shl_nsw_nuw_poison_constant_fold_before := [llvm|
{
^0(%arg6 : i1, %arg7 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 16 : i8}> : () -> i8
  %2 = "llvm.select"(%arg6, %0, %arg7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.shl %1, %2 overflow<nsw,nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def shl_nsw_nuw_poison_constant_fold_after := [llvm|
{
^0(%arg6 : i1, %arg7 : i8):
  %0 = "llvm.mlir.constant"() <{value = 16 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -128 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg7 overflow<nsw,nuw> : i8
  %3 = "llvm.select"(%arg6, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem shl_nsw_nuw_poison_constant_fold_proof : shl_nsw_nuw_poison_constant_fold_before ⊑ shl_nsw_nuw_poison_constant_fold_after := by
  unfold shl_nsw_nuw_poison_constant_fold_before shl_nsw_nuw_poison_constant_fold_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN shl_nsw_nuw_poison_constant_fold
  apply shl_nsw_nuw_poison_constant_fold_thm
  ---END shl_nsw_nuw_poison_constant_fold



def shl_nsw_nuw_before := [llvm|
{
^0(%arg4 : i1, %arg5 : i8):
  %0 = "llvm.mlir.constant"() <{value = 3 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %2 = "llvm.select"(%arg4, %0, %arg5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.shl %1, %2 overflow<nsw,nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def shl_nsw_nuw_after := [llvm|
{
^0(%arg4 : i1, %arg5 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 56 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg5 overflow<nsw,nuw> : i8
  %3 = "llvm.select"(%arg4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem shl_nsw_nuw_proof : shl_nsw_nuw_before ⊑ shl_nsw_nuw_after := by
  unfold shl_nsw_nuw_before shl_nsw_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN shl_nsw_nuw
  apply shl_nsw_nuw_thm
  ---END shl_nsw_nuw



def add_nsw_poison_constant_fold_before := [llvm|
{
^0(%arg2 : i1, %arg3 : i8):
  %0 = "llvm.mlir.constant"() <{value = 65 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 64 : i8}> : () -> i8
  %2 = "llvm.select"(%arg2, %arg3, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.add %2, %1 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_nsw_poison_constant_fold_after := [llvm|
{
^0(%arg2 : i1, %arg3 : i8):
  %0 = "llvm.mlir.constant"() <{value = 64 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -127 : i8}> : () -> i8
  %2 = llvm.add %arg3, %0 overflow<nsw> : i8
  %3 = "llvm.select"(%arg2, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem add_nsw_poison_constant_fold_proof : add_nsw_poison_constant_fold_before ⊑ add_nsw_poison_constant_fold_after := by
  unfold add_nsw_poison_constant_fold_before add_nsw_poison_constant_fold_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN add_nsw_poison_constant_fold
  apply add_nsw_poison_constant_fold_thm
  ---END add_nsw_poison_constant_fold



def add_nsw_before := [llvm|
{
^0(%arg0 : i1, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 64 : i8}> : () -> i8
  %2 = "llvm.select"(%arg0, %arg1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.add %2, %1 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def add_nsw_after := [llvm|
{
^0(%arg0 : i1, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 64 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 71 : i8}> : () -> i8
  %2 = llvm.add %arg1, %0 overflow<nsw> : i8
  %3 = "llvm.select"(%arg0, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem add_nsw_proof : add_nsw_before ⊑ add_nsw_after := by
  unfold add_nsw_before add_nsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN add_nsw
  apply add_nsw_thm
  ---END add_nsw


