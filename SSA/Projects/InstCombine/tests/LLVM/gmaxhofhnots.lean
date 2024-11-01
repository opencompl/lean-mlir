
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
section gmaxhofhnots_statements

def max_of_min_before := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.xor %arg22, %0 : i32
  %3 = llvm.icmp "sgt" %arg22, %1 : i32
  %4 = "llvm.select"(%3, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.icmp "sgt" %4, %0 : i32
  %6 = "llvm.select"(%5, %4, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def max_of_min_after := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem max_of_min_proof : max_of_min_before ⊑ max_of_min_after := by
  unfold max_of_min_before max_of_min_after
  simp_alive_peephole
  intros
  ---BEGIN max_of_min
  all_goals (try extract_goal ; sorry)
  ---END max_of_min



def max_of_min_swap_before := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.xor %arg21, %0 : i32
  %3 = llvm.icmp "slt" %arg21, %1 : i32
  %4 = "llvm.select"(%3, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.icmp "sgt" %4, %0 : i32
  %6 = "llvm.select"(%5, %4, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def max_of_min_swap_after := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem max_of_min_swap_proof : max_of_min_swap_before ⊑ max_of_min_swap_after := by
  unfold max_of_min_swap_before max_of_min_swap_after
  simp_alive_peephole
  intros
  ---BEGIN max_of_min_swap
  all_goals (try extract_goal ; sorry)
  ---END max_of_min_swap



def min_of_max_before := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.xor %arg20, %0 : i32
  %3 = llvm.icmp "slt" %arg20, %1 : i32
  %4 = "llvm.select"(%3, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.icmp "slt" %4, %0 : i32
  %6 = "llvm.select"(%5, %4, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def min_of_max_after := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem min_of_max_proof : min_of_max_before ⊑ min_of_max_after := by
  unfold min_of_max_before min_of_max_after
  simp_alive_peephole
  intros
  ---BEGIN min_of_max
  all_goals (try extract_goal ; sorry)
  ---END min_of_max



def min_of_max_swap_before := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.xor %arg19, %0 : i32
  %3 = llvm.icmp "sgt" %arg19, %1 : i32
  %4 = "llvm.select"(%3, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.icmp "slt" %4, %0 : i32
  %6 = "llvm.select"(%5, %4, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def min_of_max_swap_after := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem min_of_max_swap_proof : min_of_max_swap_before ⊑ min_of_max_swap_after := by
  unfold min_of_max_swap_before min_of_max_swap_after
  simp_alive_peephole
  intros
  ---BEGIN min_of_max_swap
  all_goals (try extract_goal ; sorry)
  ---END min_of_max_swap


