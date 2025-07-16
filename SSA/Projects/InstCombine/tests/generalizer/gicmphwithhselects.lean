import SSA.Projects.InstCombine.tests.proofs.gicmphwithhselects_proof
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
section gicmphwithhselects_statements

def both_sides_fold_slt_before := [llvm|
{
^0(%arg39 : i32, %arg40 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = "llvm.select"(%arg40, %0, %arg39) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = "llvm.select"(%arg40, %1, %arg39) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "slt" %3, %2 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def both_sides_fold_slt_after := [llvm|
{
^0(%arg39 : i32, %arg40 : i1):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem both_sides_fold_slt_proof : both_sides_fold_slt_before ⊑ both_sides_fold_slt_after := by
  unfold both_sides_fold_slt_before both_sides_fold_slt_after
  simp_alive_peephole
  intros
  ---BEGIN both_sides_fold_slt
  apply both_sides_fold_slt_thm
  ---END both_sides_fold_slt



def both_sides_fold_eq_before := [llvm|
{
^0(%arg37 : i32, %arg38 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = "llvm.select"(%arg38, %0, %arg37) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = "llvm.select"(%arg38, %1, %arg37) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.icmp "eq" %3, %2 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def both_sides_fold_eq_after := [llvm|
{
^0(%arg37 : i32, %arg38 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg38, %0 : i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem both_sides_fold_eq_proof : both_sides_fold_eq_before ⊑ both_sides_fold_eq_after := by
  unfold both_sides_fold_eq_before both_sides_fold_eq_after
  simp_alive_peephole
  intros
  ---BEGIN both_sides_fold_eq
  apply both_sides_fold_eq_thm
  ---END both_sides_fold_eq



def one_side_fold_slt_before := [llvm|
{
^0(%arg33 : i32, %arg34 : i32, %arg35 : i32, %arg36 : i1):
  %0 = "llvm.select"(%arg36, %arg33, %arg35) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %1 = "llvm.select"(%arg36, %arg34, %arg35) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "slt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def one_side_fold_slt_after := [llvm|
{
^0(%arg33 : i32, %arg34 : i32, %arg35 : i32, %arg36 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.icmp "slt" %arg34, %arg33 : i32
  %2 = "llvm.select"(%arg36, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem one_side_fold_slt_proof : one_side_fold_slt_before ⊑ one_side_fold_slt_after := by
  unfold one_side_fold_slt_before one_side_fold_slt_after
  simp_alive_peephole
  intros
  ---BEGIN one_side_fold_slt
  apply one_side_fold_slt_thm
  ---END one_side_fold_slt



def one_side_fold_sgt_before := [llvm|
{
^0(%arg29 : i32, %arg30 : i32, %arg31 : i32, %arg32 : i1):
  %0 = "llvm.select"(%arg32, %arg31, %arg29) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %1 = "llvm.select"(%arg32, %arg31, %arg30) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "sgt" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def one_side_fold_sgt_after := [llvm|
{
^0(%arg29 : i32, %arg30 : i32, %arg31 : i32, %arg32 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sgt" %arg30, %arg29 : i32
  %3 = llvm.xor %arg32, %0 : i1
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem one_side_fold_sgt_proof : one_side_fold_sgt_before ⊑ one_side_fold_sgt_after := by
  unfold one_side_fold_sgt_before one_side_fold_sgt_after
  simp_alive_peephole
  intros
  ---BEGIN one_side_fold_sgt
  apply one_side_fold_sgt_thm
  ---END one_side_fold_sgt



def one_side_fold_eq_before := [llvm|
{
^0(%arg25 : i32, %arg26 : i32, %arg27 : i32, %arg28 : i1):
  %0 = "llvm.select"(%arg28, %arg25, %arg27) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %1 = "llvm.select"(%arg28, %arg26, %arg27) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
def one_side_fold_eq_after := [llvm|
{
^0(%arg25 : i32, %arg26 : i32, %arg27 : i32, %arg28 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "eq" %arg26, %arg25 : i32
  %2 = llvm.xor %arg28, %0 : i1
  %3 = "llvm.select"(%2, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem one_side_fold_eq_proof : one_side_fold_eq_before ⊑ one_side_fold_eq_after := by
  unfold one_side_fold_eq_before one_side_fold_eq_after
  simp_alive_peephole
  intros
  ---BEGIN one_side_fold_eq
  apply one_side_fold_eq_thm
  ---END one_side_fold_eq


