
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
section gunsigned_saturated_sub_statements

def max_sub_ugt_c0_before := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.icmp "ugt" %arg10, %0 : i32
  %3 = llvm.add %arg10, %1 : i32
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def max_sub_ugt_c0_after := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem max_sub_ugt_c0_proof : max_sub_ugt_c0_before ⊑ max_sub_ugt_c0_after := by
  unfold max_sub_ugt_c0_before max_sub_ugt_c0_after
  simp_alive_peephole
  intros
  ---BEGIN max_sub_ugt_c0
  all_goals (try extract_goal ; sorry)
  ---END max_sub_ugt_c0



def max_sub_ult_c1_before := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.icmp "ult" %arg8, %0 : i32
  %4 = llvm.add %arg8, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def max_sub_ult_c1_after := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "eq" %arg8, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem max_sub_ult_c1_proof : max_sub_ult_c1_before ⊑ max_sub_ult_c1_after := by
  unfold max_sub_ult_c1_before max_sub_ult_c1_after
  simp_alive_peephole
  intros
  ---BEGIN max_sub_ult_c1
  all_goals (try extract_goal ; sorry)
  ---END max_sub_ult_c1



def max_sub_ugt_c32_before := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.icmp "ugt" %0, %arg3 : i32
  %4 = llvm.add %arg3, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def max_sub_ugt_c32_after := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.icmp "ult" %arg3, %0 : i32
  %4 = llvm.add %arg3, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem max_sub_ugt_c32_proof : max_sub_ugt_c32_before ⊑ max_sub_ugt_c32_after := by
  unfold max_sub_ugt_c32_before max_sub_ugt_c32_after
  simp_alive_peephole
  intros
  ---BEGIN max_sub_ugt_c32
  all_goals (try extract_goal ; sorry)
  ---END max_sub_ugt_c32



def max_sub_uge_c32_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.icmp "uge" %0, %arg2 : i32
  %4 = llvm.add %arg2, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def max_sub_uge_c32_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.icmp "ult" %arg2, %0 : i32
  %4 = llvm.add %arg2, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem max_sub_uge_c32_proof : max_sub_uge_c32_before ⊑ max_sub_uge_c32_after := by
  unfold max_sub_uge_c32_before max_sub_uge_c32_after
  simp_alive_peephole
  intros
  ---BEGIN max_sub_uge_c32
  all_goals (try extract_goal ; sorry)
  ---END max_sub_uge_c32



def max_sub_ult_c12_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.icmp "ult" %arg1, %0 : i32
  %4 = llvm.add %arg1, %1 : i32
  %5 = "llvm.select"(%3, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def max_sub_ult_c12_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-2 : i32) : i32
  %2 = llvm.icmp "eq" %arg1, %0 : i32
  %3 = "llvm.select"(%2, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem max_sub_ult_c12_proof : max_sub_ult_c12_before ⊑ max_sub_ult_c12_after := by
  unfold max_sub_ult_c12_before max_sub_ult_c12_after
  simp_alive_peephole
  intros
  ---BEGIN max_sub_ult_c12
  all_goals (try extract_goal ; sorry)
  ---END max_sub_ult_c12



def max_sub_ult_c0_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.icmp "ult" %arg0, %0 : i32
  %3 = llvm.add %arg0, %1 : i32
  %4 = "llvm.select"(%2, %3, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def max_sub_ult_c0_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem max_sub_ult_c0_proof : max_sub_ult_c0_before ⊑ max_sub_ult_c0_after := by
  unfold max_sub_ult_c0_before max_sub_ult_c0_after
  simp_alive_peephole
  intros
  ---BEGIN max_sub_ult_c0
  all_goals (try extract_goal ; sorry)
  ---END max_sub_ult_c0


