
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
section gicmphorhofhselecthwithhzero_statements

def src_tv_eq_before := [llvm|
{
^0(%arg53 : i1, %arg54 : i8, %arg55 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.add %arg55, %0 overflow<nuw> : i8
  %3 = "llvm.select"(%arg53, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.or %3, %arg54 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def src_tv_eq_after := [llvm|
{
^0(%arg53 : i1, %arg54 : i8, %arg55 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg54, %0 : i8
  %2 = llvm.and %1, %arg53 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_tv_eq_proof : src_tv_eq_before ⊑ src_tv_eq_after := by
  unfold src_tv_eq_before src_tv_eq_after
  simp_alive_peephole
  intros
  ---BEGIN src_tv_eq
  all_goals (try extract_goal ; sorry)
  ---END src_tv_eq



def src_fv_ne_before := [llvm|
{
^0(%arg44 : i1, %arg45 : i8, %arg46 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.add %arg46, %0 overflow<nuw> : i8
  %3 = "llvm.select"(%arg44, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.or %3, %arg45 : i8
  %5 = llvm.icmp "ne" %4, %1 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def src_fv_ne_after := [llvm|
{
^0(%arg44 : i1, %arg45 : i8, %arg46 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg45, %0 : i8
  %2 = llvm.or %1, %arg44 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_fv_ne_proof : src_fv_ne_before ⊑ src_fv_ne_after := by
  unfold src_fv_ne_before src_fv_ne_after
  simp_alive_peephole
  intros
  ---BEGIN src_fv_ne
  all_goals (try extract_goal ; sorry)
  ---END src_fv_ne



def src_tv_ne_before := [llvm|
{
^0(%arg38 : i1, %arg39 : i8, %arg40 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.add %arg40, %0 overflow<nuw> : i8
  %3 = "llvm.select"(%arg38, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.or %3, %arg39 : i8
  %5 = llvm.icmp "ne" %4, %1 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def src_tv_ne_after := [llvm|
{
^0(%arg38 : i1, %arg39 : i8, %arg40 : i8):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.xor %arg38, %0 : i1
  %3 = llvm.icmp "ne" %arg39, %1 : i8
  %4 = llvm.or %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_tv_ne_proof : src_tv_ne_before ⊑ src_tv_ne_after := by
  unfold src_tv_ne_before src_tv_ne_after
  simp_alive_peephole
  intros
  ---BEGIN src_tv_ne
  all_goals (try extract_goal ; sorry)
  ---END src_tv_ne



def src_fv_eq_before := [llvm|
{
^0(%arg32 : i1, %arg33 : i8, %arg34 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.add %arg34, %0 overflow<nuw> : i8
  %3 = "llvm.select"(%arg32, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %4 = llvm.or %3, %arg33 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def src_fv_eq_after := [llvm|
{
^0(%arg32 : i1, %arg33 : i8, %arg34 : i8):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.xor %arg32, %0 : i1
  %3 = llvm.icmp "eq" %arg33, %1 : i8
  %4 = llvm.and %3, %2 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem src_fv_eq_proof : src_fv_eq_before ⊑ src_fv_eq_after := by
  unfold src_fv_eq_before src_fv_eq_after
  simp_alive_peephole
  intros
  ---BEGIN src_fv_eq
  all_goals (try extract_goal ; sorry)
  ---END src_fv_eq


