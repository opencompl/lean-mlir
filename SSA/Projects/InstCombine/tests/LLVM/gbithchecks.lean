
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
section gbithchecks_statements

def main1_before := [llvm|
{
^0(%arg159 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg159, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %arg159, %2 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %4, %6 : i1
  %8 = "llvm.select"(%7, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def main1_after := [llvm|
{
^0(%arg159 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg159, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = "llvm.select"(%4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main1_proof : main1_before ⊑ main1_after := by
  unfold main1_before main1_after
  simp_alive_peephole
  intros
  ---BEGIN main1
  all_goals (try extract_goal ; sorry)
  ---END main1



def main1_logical_before := [llvm|
{
^0(%arg158 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.and %arg158, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg158, %2 : i32
  %7 = llvm.icmp "ne" %6, %1 : i32
  %8 = "llvm.select"(%5, %7, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %9 = "llvm.select"(%8, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main1_logical_after := [llvm|
{
^0(%arg158 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg158, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = "llvm.select"(%4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main1_logical_proof : main1_logical_before ⊑ main1_logical_after := by
  unfold main1_logical_before main1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main1_logical
  all_goals (try extract_goal ; sorry)
  ---END main1_logical



def main2_before := [llvm|
{
^0(%arg157 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg157, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg157, %2 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.or %4, %6 : i1
  %8 = "llvm.select"(%7, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def main2_after := [llvm|
{
^0(%arg157 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.and %arg157, %0 : i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main2_proof : main2_before ⊑ main2_after := by
  unfold main2_before main2_after
  simp_alive_peephole
  intros
  ---BEGIN main2
  all_goals (try extract_goal ; sorry)
  ---END main2



def main2_logical_before := [llvm|
{
^0(%arg156 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.and %arg156, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg156, %2 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = "llvm.select"(%5, %3, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %9 = "llvm.select"(%8, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main2_logical_after := [llvm|
{
^0(%arg156 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.and %arg156, %0 : i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main2_logical_proof : main2_logical_before ⊑ main2_logical_after := by
  unfold main2_logical_before main2_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main2_logical
  all_goals (try extract_goal ; sorry)
  ---END main2_logical



def main3_before := [llvm|
{
^0(%arg155 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(48 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg155, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg155, %2 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = llvm.and %5, %7 : i1
  %9 = "llvm.select"(%8, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main3_after := [llvm|
{
^0(%arg155 : i32):
  %0 = llvm.mlir.constant(55 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg155, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main3_proof : main3_before ⊑ main3_after := by
  unfold main3_before main3_after
  simp_alive_peephole
  intros
  ---BEGIN main3
  all_goals (try extract_goal ; sorry)
  ---END main3



def main3_logical_before := [llvm|
{
^0(%arg154 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(48 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.and %arg154, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg154, %2 : i32
  %8 = llvm.icmp "eq" %7, %1 : i32
  %9 = "llvm.select"(%6, %8, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %10 = "llvm.select"(%9, %1, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main3_logical_after := [llvm|
{
^0(%arg154 : i32):
  %0 = llvm.mlir.constant(55 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg154, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main3_logical_proof : main3_logical_before ⊑ main3_logical_after := by
  unfold main3_logical_before main3_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main3_logical
  all_goals (try extract_goal ; sorry)
  ---END main3_logical



def main3b_before := [llvm|
{
^0(%arg153 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(16 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg153, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg153, %2 : i32
  %7 = llvm.icmp "ne" %6, %2 : i32
  %8 = llvm.and %5, %7 : i1
  %9 = "llvm.select"(%8, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main3b_after := [llvm|
{
^0(%arg153 : i32):
  %0 = llvm.mlir.constant(23 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg153, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main3b_proof : main3b_before ⊑ main3b_after := by
  unfold main3b_before main3b_after
  simp_alive_peephole
  intros
  ---BEGIN main3b
  all_goals (try extract_goal ; sorry)
  ---END main3b



def main3b_logical_before := [llvm|
{
^0(%arg152 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(16 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.and %arg152, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg152, %2 : i32
  %8 = llvm.icmp "ne" %7, %2 : i32
  %9 = "llvm.select"(%6, %8, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %10 = "llvm.select"(%9, %1, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main3b_logical_after := [llvm|
{
^0(%arg152 : i32):
  %0 = llvm.mlir.constant(23 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg152, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main3b_logical_proof : main3b_logical_before ⊑ main3b_logical_after := by
  unfold main3b_logical_before main3b_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main3b_logical
  all_goals (try extract_goal ; sorry)
  ---END main3b_logical



def main3e_like_before := [llvm|
{
^0(%arg149 : i32, %arg150 : i32, %arg151 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg149, %arg150 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = llvm.and %arg149, %arg151 : i32
  %5 = llvm.icmp "eq" %4, %0 : i32
  %6 = llvm.and %3, %5 : i1
  %7 = "llvm.select"(%6, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def main3e_like_after := [llvm|
{
^0(%arg149 : i32, %arg150 : i32, %arg151 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.or %arg150, %arg151 : i32
  %2 = llvm.and %arg149, %1 : i32
  %3 = llvm.icmp "ne" %2, %0 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main3e_like_proof : main3e_like_before ⊑ main3e_like_after := by
  unfold main3e_like_before main3e_like_after
  simp_alive_peephole
  intros
  ---BEGIN main3e_like
  all_goals (try extract_goal ; sorry)
  ---END main3e_like



def main3e_like_logical_before := [llvm|
{
^0(%arg146 : i32, %arg147 : i32, %arg148 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg146, %arg147 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = llvm.and %arg146, %arg148 : i32
  %6 = llvm.icmp "eq" %5, %0 : i32
  %7 = "llvm.select"(%4, %6, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %8 = "llvm.select"(%7, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def main3e_like_logical_after := [llvm|
{
^0(%arg146 : i32, %arg147 : i32, %arg148 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.and %arg146, %arg147 : i32
  %3 = llvm.icmp "ne" %2, %0 : i32
  %4 = llvm.and %arg146, %arg148 : i32
  %5 = llvm.icmp "ne" %4, %0 : i32
  %6 = "llvm.select"(%3, %1, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = llvm.zext %6 : i1 to i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main3e_like_logical_proof : main3e_like_logical_before ⊑ main3e_like_logical_after := by
  unfold main3e_like_logical_before main3e_like_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main3e_like_logical
  all_goals (try extract_goal ; sorry)
  ---END main3e_like_logical



def main3c_before := [llvm|
{
^0(%arg145 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(48 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg145, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg145, %2 : i32
  %7 = llvm.icmp "ne" %6, %1 : i32
  %8 = llvm.or %5, %7 : i1
  %9 = "llvm.select"(%8, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main3c_after := [llvm|
{
^0(%arg145 : i32):
  %0 = llvm.mlir.constant(55 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg145, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main3c_proof : main3c_before ⊑ main3c_after := by
  unfold main3c_before main3c_after
  simp_alive_peephole
  intros
  ---BEGIN main3c
  all_goals (try extract_goal ; sorry)
  ---END main3c



def main3c_logical_before := [llvm|
{
^0(%arg144 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(48 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.and %arg144, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg144, %2 : i32
  %8 = llvm.icmp "ne" %7, %1 : i32
  %9 = "llvm.select"(%6, %3, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %10 = "llvm.select"(%9, %1, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main3c_logical_after := [llvm|
{
^0(%arg144 : i32):
  %0 = llvm.mlir.constant(55 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg144, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main3c_logical_proof : main3c_logical_before ⊑ main3c_logical_after := by
  unfold main3c_logical_before main3c_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main3c_logical
  all_goals (try extract_goal ; sorry)
  ---END main3c_logical



def main3d_before := [llvm|
{
^0(%arg143 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(16 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg143, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg143, %2 : i32
  %7 = llvm.icmp "eq" %6, %2 : i32
  %8 = llvm.or %5, %7 : i1
  %9 = "llvm.select"(%8, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main3d_after := [llvm|
{
^0(%arg143 : i32):
  %0 = llvm.mlir.constant(23 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg143, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main3d_proof : main3d_before ⊑ main3d_after := by
  unfold main3d_before main3d_after
  simp_alive_peephole
  intros
  ---BEGIN main3d
  all_goals (try extract_goal ; sorry)
  ---END main3d



def main3d_logical_before := [llvm|
{
^0(%arg142 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(16 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.and %arg142, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg142, %2 : i32
  %8 = llvm.icmp "eq" %7, %2 : i32
  %9 = "llvm.select"(%6, %3, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %10 = "llvm.select"(%9, %1, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main3d_logical_after := [llvm|
{
^0(%arg142 : i32):
  %0 = llvm.mlir.constant(23 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg142, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main3d_logical_proof : main3d_logical_before ⊑ main3d_logical_after := by
  unfold main3d_logical_before main3d_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main3d_logical
  all_goals (try extract_goal ; sorry)
  ---END main3d_logical



def main3f_like_before := [llvm|
{
^0(%arg139 : i32, %arg140 : i32, %arg141 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg139, %arg140 : i32
  %3 = llvm.icmp "ne" %2, %0 : i32
  %4 = llvm.and %arg139, %arg141 : i32
  %5 = llvm.icmp "ne" %4, %0 : i32
  %6 = llvm.or %3, %5 : i1
  %7 = "llvm.select"(%6, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def main3f_like_after := [llvm|
{
^0(%arg139 : i32, %arg140 : i32, %arg141 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.or %arg140, %arg141 : i32
  %2 = llvm.and %arg139, %1 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main3f_like_proof : main3f_like_before ⊑ main3f_like_after := by
  unfold main3f_like_before main3f_like_after
  simp_alive_peephole
  intros
  ---BEGIN main3f_like
  all_goals (try extract_goal ; sorry)
  ---END main3f_like



def main3f_like_logical_before := [llvm|
{
^0(%arg136 : i32, %arg137 : i32, %arg138 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg136, %arg137 : i32
  %4 = llvm.icmp "ne" %3, %0 : i32
  %5 = llvm.and %arg136, %arg138 : i32
  %6 = llvm.icmp "ne" %5, %0 : i32
  %7 = "llvm.select"(%4, %1, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %8 = "llvm.select"(%7, %0, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def main3f_like_logical_after := [llvm|
{
^0(%arg136 : i32, %arg137 : i32, %arg138 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.and %arg136, %arg137 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = llvm.and %arg136, %arg138 : i32
  %5 = llvm.icmp "eq" %4, %0 : i32
  %6 = "llvm.select"(%3, %5, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = llvm.zext %6 : i1 to i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main3f_like_logical_proof : main3f_like_logical_before ⊑ main3f_like_logical_after := by
  unfold main3f_like_logical_before main3f_like_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main3f_like_logical
  all_goals (try extract_goal ; sorry)
  ---END main3f_like_logical



def main4_before := [llvm|
{
^0(%arg135 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(48 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg135, %0 : i32
  %5 = llvm.icmp "eq" %4, %0 : i32
  %6 = llvm.and %arg135, %1 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = llvm.and %5, %7 : i1
  %9 = "llvm.select"(%8, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main4_after := [llvm|
{
^0(%arg135 : i32):
  %0 = llvm.mlir.constant(55 : i32) : i32
  %1 = llvm.and %arg135, %0 : i32
  %2 = llvm.icmp "ne" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main4_proof : main4_before ⊑ main4_after := by
  unfold main4_before main4_after
  simp_alive_peephole
  intros
  ---BEGIN main4
  all_goals (try extract_goal ; sorry)
  ---END main4



def main4_logical_before := [llvm|
{
^0(%arg133 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(48 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.and %arg133, %0 : i32
  %6 = llvm.icmp "eq" %5, %0 : i32
  %7 = llvm.and %arg133, %1 : i32
  %8 = llvm.icmp "eq" %7, %1 : i32
  %9 = "llvm.select"(%6, %8, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %10 = "llvm.select"(%9, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main4_logical_after := [llvm|
{
^0(%arg133 : i32):
  %0 = llvm.mlir.constant(55 : i32) : i32
  %1 = llvm.and %arg133, %0 : i32
  %2 = llvm.icmp "ne" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main4_logical_proof : main4_logical_before ⊑ main4_logical_after := by
  unfold main4_logical_before main4_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main4_logical
  all_goals (try extract_goal ; sorry)
  ---END main4_logical



def main4b_before := [llvm|
{
^0(%arg132 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg132, %0 : i32
  %5 = llvm.icmp "eq" %4, %0 : i32
  %6 = llvm.and %arg132, %1 : i32
  %7 = llvm.icmp "ne" %6, %2 : i32
  %8 = llvm.and %5, %7 : i1
  %9 = "llvm.select"(%8, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main4b_after := [llvm|
{
^0(%arg132 : i32):
  %0 = llvm.mlir.constant(23 : i32) : i32
  %1 = llvm.and %arg132, %0 : i32
  %2 = llvm.icmp "ne" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main4b_proof : main4b_before ⊑ main4b_after := by
  unfold main4b_before main4b_after
  simp_alive_peephole
  intros
  ---BEGIN main4b
  all_goals (try extract_goal ; sorry)
  ---END main4b



def main4b_logical_before := [llvm|
{
^0(%arg131 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.and %arg131, %0 : i32
  %6 = llvm.icmp "eq" %5, %0 : i32
  %7 = llvm.and %arg131, %1 : i32
  %8 = llvm.icmp "ne" %7, %2 : i32
  %9 = "llvm.select"(%6, %8, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %10 = "llvm.select"(%9, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main4b_logical_after := [llvm|
{
^0(%arg131 : i32):
  %0 = llvm.mlir.constant(23 : i32) : i32
  %1 = llvm.and %arg131, %0 : i32
  %2 = llvm.icmp "ne" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main4b_logical_proof : main4b_logical_before ⊑ main4b_logical_after := by
  unfold main4b_logical_before main4b_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main4b_logical
  all_goals (try extract_goal ; sorry)
  ---END main4b_logical



def main4e_like_before := [llvm|
{
^0(%arg128 : i32, %arg129 : i32, %arg130 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg128, %arg129 : i32
  %3 = llvm.icmp "eq" %2, %arg129 : i32
  %4 = llvm.and %arg128, %arg130 : i32
  %5 = llvm.icmp "eq" %4, %arg130 : i32
  %6 = llvm.and %3, %5 : i1
  %7 = "llvm.select"(%6, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def main4e_like_after := [llvm|
{
^0(%arg128 : i32, %arg129 : i32, %arg130 : i32):
  %0 = llvm.or %arg129, %arg130 : i32
  %1 = llvm.and %arg128, %0 : i32
  %2 = llvm.icmp "ne" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main4e_like_proof : main4e_like_before ⊑ main4e_like_after := by
  unfold main4e_like_before main4e_like_after
  simp_alive_peephole
  intros
  ---BEGIN main4e_like
  all_goals (try extract_goal ; sorry)
  ---END main4e_like



def main4e_like_logical_before := [llvm|
{
^0(%arg125 : i32, %arg126 : i32, %arg127 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg125, %arg126 : i32
  %4 = llvm.icmp "eq" %3, %arg126 : i32
  %5 = llvm.and %arg125, %arg127 : i32
  %6 = llvm.icmp "eq" %5, %arg127 : i32
  %7 = "llvm.select"(%4, %6, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %8 = "llvm.select"(%7, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def main4e_like_logical_after := [llvm|
{
^0(%arg125 : i32, %arg126 : i32, %arg127 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg125, %arg126 : i32
  %2 = llvm.icmp "ne" %1, %arg126 : i32
  %3 = llvm.and %arg125, %arg127 : i32
  %4 = llvm.icmp "ne" %3, %arg127 : i32
  %5 = "llvm.select"(%2, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main4e_like_logical_proof : main4e_like_logical_before ⊑ main4e_like_logical_after := by
  unfold main4e_like_logical_before main4e_like_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main4e_like_logical
  all_goals (try extract_goal ; sorry)
  ---END main4e_like_logical



def main4c_before := [llvm|
{
^0(%arg124 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(48 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg124, %0 : i32
  %5 = llvm.icmp "ne" %4, %0 : i32
  %6 = llvm.and %arg124, %1 : i32
  %7 = llvm.icmp "ne" %6, %1 : i32
  %8 = llvm.or %5, %7 : i1
  %9 = "llvm.select"(%8, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main4c_after := [llvm|
{
^0(%arg124 : i32):
  %0 = llvm.mlir.constant(55 : i32) : i32
  %1 = llvm.and %arg124, %0 : i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main4c_proof : main4c_before ⊑ main4c_after := by
  unfold main4c_before main4c_after
  simp_alive_peephole
  intros
  ---BEGIN main4c
  all_goals (try extract_goal ; sorry)
  ---END main4c



def main4c_logical_before := [llvm|
{
^0(%arg123 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(48 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.and %arg123, %0 : i32
  %6 = llvm.icmp "ne" %5, %0 : i32
  %7 = llvm.and %arg123, %1 : i32
  %8 = llvm.icmp "ne" %7, %1 : i32
  %9 = "llvm.select"(%6, %2, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %10 = "llvm.select"(%9, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main4c_logical_after := [llvm|
{
^0(%arg123 : i32):
  %0 = llvm.mlir.constant(55 : i32) : i32
  %1 = llvm.and %arg123, %0 : i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main4c_logical_proof : main4c_logical_before ⊑ main4c_logical_after := by
  unfold main4c_logical_before main4c_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main4c_logical
  all_goals (try extract_goal ; sorry)
  ---END main4c_logical



def main4d_before := [llvm|
{
^0(%arg122 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg122, %0 : i32
  %5 = llvm.icmp "ne" %4, %0 : i32
  %6 = llvm.and %arg122, %1 : i32
  %7 = llvm.icmp "eq" %6, %2 : i32
  %8 = llvm.or %5, %7 : i1
  %9 = "llvm.select"(%8, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main4d_after := [llvm|
{
^0(%arg122 : i32):
  %0 = llvm.mlir.constant(23 : i32) : i32
  %1 = llvm.and %arg122, %0 : i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main4d_proof : main4d_before ⊑ main4d_after := by
  unfold main4d_before main4d_after
  simp_alive_peephole
  intros
  ---BEGIN main4d
  all_goals (try extract_goal ; sorry)
  ---END main4d



def main4d_logical_before := [llvm|
{
^0(%arg121 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.and %arg121, %0 : i32
  %6 = llvm.icmp "ne" %5, %0 : i32
  %7 = llvm.and %arg121, %1 : i32
  %8 = llvm.icmp "eq" %7, %2 : i32
  %9 = "llvm.select"(%6, %3, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %10 = "llvm.select"(%9, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main4d_logical_after := [llvm|
{
^0(%arg121 : i32):
  %0 = llvm.mlir.constant(23 : i32) : i32
  %1 = llvm.and %arg121, %0 : i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main4d_logical_proof : main4d_logical_before ⊑ main4d_logical_after := by
  unfold main4d_logical_before main4d_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main4d_logical
  all_goals (try extract_goal ; sorry)
  ---END main4d_logical



def main4f_like_before := [llvm|
{
^0(%arg118 : i32, %arg119 : i32, %arg120 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg118, %arg119 : i32
  %3 = llvm.icmp "ne" %2, %arg119 : i32
  %4 = llvm.and %arg118, %arg120 : i32
  %5 = llvm.icmp "ne" %4, %arg120 : i32
  %6 = llvm.or %3, %5 : i1
  %7 = "llvm.select"(%6, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def main4f_like_after := [llvm|
{
^0(%arg118 : i32, %arg119 : i32, %arg120 : i32):
  %0 = llvm.or %arg119, %arg120 : i32
  %1 = llvm.and %arg118, %0 : i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main4f_like_proof : main4f_like_before ⊑ main4f_like_after := by
  unfold main4f_like_before main4f_like_after
  simp_alive_peephole
  intros
  ---BEGIN main4f_like
  all_goals (try extract_goal ; sorry)
  ---END main4f_like



def main4f_like_logical_before := [llvm|
{
^0(%arg115 : i32, %arg116 : i32, %arg117 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg115, %arg116 : i32
  %4 = llvm.icmp "ne" %3, %arg116 : i32
  %5 = llvm.and %arg115, %arg117 : i32
  %6 = llvm.icmp "ne" %5, %arg117 : i32
  %7 = "llvm.select"(%4, %0, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %8 = "llvm.select"(%7, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def main4f_like_logical_after := [llvm|
{
^0(%arg115 : i32, %arg116 : i32, %arg117 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.and %arg115, %arg116 : i32
  %2 = llvm.icmp "eq" %1, %arg116 : i32
  %3 = llvm.and %arg115, %arg117 : i32
  %4 = llvm.icmp "eq" %3, %arg117 : i32
  %5 = "llvm.select"(%2, %4, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main4f_like_logical_proof : main4f_like_logical_before ⊑ main4f_like_logical_after := by
  unfold main4f_like_logical_before main4f_like_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main4f_like_logical
  all_goals (try extract_goal ; sorry)
  ---END main4f_like_logical



def main5_like_before := [llvm|
{
^0(%arg113 : i32, %arg114 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg113, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = llvm.and %arg114, %0 : i32
  %6 = llvm.icmp "eq" %5, %0 : i32
  %7 = llvm.and %4, %6 : i1
  %8 = "llvm.select"(%7, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def main5_like_after := [llvm|
{
^0(%arg113 : i32, %arg114 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.and %arg113, %arg114 : i32
  %2 = llvm.and %1, %0 : i32
  %3 = llvm.icmp "ne" %2, %0 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main5_like_proof : main5_like_before ⊑ main5_like_after := by
  unfold main5_like_before main5_like_after
  simp_alive_peephole
  intros
  ---BEGIN main5_like
  all_goals (try extract_goal ; sorry)
  ---END main5_like



def main5_like_logical_before := [llvm|
{
^0(%arg111 : i32, %arg112 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg111, %0 : i32
  %5 = llvm.icmp "eq" %4, %0 : i32
  %6 = llvm.and %arg112, %0 : i32
  %7 = llvm.icmp "eq" %6, %0 : i32
  %8 = "llvm.select"(%5, %7, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %9 = "llvm.select"(%8, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main5_like_logical_after := [llvm|
{
^0(%arg111 : i32, %arg112 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.and %arg111, %0 : i32
  %3 = llvm.icmp "ne" %2, %0 : i32
  %4 = llvm.and %arg112, %0 : i32
  %5 = llvm.icmp "ne" %4, %0 : i32
  %6 = "llvm.select"(%3, %1, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = llvm.zext %6 : i1 to i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main5_like_logical_proof : main5_like_logical_before ⊑ main5_like_logical_after := by
  unfold main5_like_logical_before main5_like_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main5_like_logical
  all_goals (try extract_goal ; sorry)
  ---END main5_like_logical



def main5e_like_before := [llvm|
{
^0(%arg108 : i32, %arg109 : i32, %arg110 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg108, %arg109 : i32
  %3 = llvm.icmp "eq" %2, %arg108 : i32
  %4 = llvm.and %arg108, %arg110 : i32
  %5 = llvm.icmp "eq" %4, %arg108 : i32
  %6 = llvm.and %3, %5 : i1
  %7 = "llvm.select"(%6, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def main5e_like_after := [llvm|
{
^0(%arg108 : i32, %arg109 : i32, %arg110 : i32):
  %0 = llvm.and %arg109, %arg110 : i32
  %1 = llvm.and %arg108, %0 : i32
  %2 = llvm.icmp "ne" %1, %arg108 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main5e_like_proof : main5e_like_before ⊑ main5e_like_after := by
  unfold main5e_like_before main5e_like_after
  simp_alive_peephole
  intros
  ---BEGIN main5e_like
  all_goals (try extract_goal ; sorry)
  ---END main5e_like



def main5e_like_logical_before := [llvm|
{
^0(%arg105 : i32, %arg106 : i32, %arg107 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg105, %arg106 : i32
  %4 = llvm.icmp "eq" %3, %arg105 : i32
  %5 = llvm.and %arg105, %arg107 : i32
  %6 = llvm.icmp "eq" %5, %arg105 : i32
  %7 = "llvm.select"(%4, %6, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %8 = "llvm.select"(%7, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def main5e_like_logical_after := [llvm|
{
^0(%arg105 : i32, %arg106 : i32, %arg107 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg105, %arg106 : i32
  %2 = llvm.icmp "ne" %1, %arg105 : i32
  %3 = llvm.and %arg105, %arg107 : i32
  %4 = llvm.icmp "ne" %3, %arg105 : i32
  %5 = "llvm.select"(%2, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main5e_like_logical_proof : main5e_like_logical_before ⊑ main5e_like_logical_after := by
  unfold main5e_like_logical_before main5e_like_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main5e_like_logical
  all_goals (try extract_goal ; sorry)
  ---END main5e_like_logical



def main5c_like_before := [llvm|
{
^0(%arg103 : i32, %arg104 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg103, %0 : i32
  %4 = llvm.icmp "ne" %3, %0 : i32
  %5 = llvm.and %arg104, %0 : i32
  %6 = llvm.icmp "ne" %5, %0 : i32
  %7 = llvm.or %4, %6 : i1
  %8 = "llvm.select"(%7, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def main5c_like_after := [llvm|
{
^0(%arg103 : i32, %arg104 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.and %arg103, %arg104 : i32
  %2 = llvm.and %1, %0 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main5c_like_proof : main5c_like_before ⊑ main5c_like_after := by
  unfold main5c_like_before main5c_like_after
  simp_alive_peephole
  intros
  ---BEGIN main5c_like
  all_goals (try extract_goal ; sorry)
  ---END main5c_like



def main5c_like_logical_before := [llvm|
{
^0(%arg101 : i32, %arg102 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.mlir.constant(0 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg101, %0 : i32
  %5 = llvm.icmp "ne" %4, %0 : i32
  %6 = llvm.and %arg102, %0 : i32
  %7 = llvm.icmp "ne" %6, %0 : i32
  %8 = "llvm.select"(%5, %1, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %9 = "llvm.select"(%8, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main5c_like_logical_after := [llvm|
{
^0(%arg101 : i32, %arg102 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.and %arg101, %0 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = llvm.and %arg102, %0 : i32
  %5 = llvm.icmp "eq" %4, %0 : i32
  %6 = "llvm.select"(%3, %5, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %7 = llvm.zext %6 : i1 to i32
  "llvm.return"(%7) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main5c_like_logical_proof : main5c_like_logical_before ⊑ main5c_like_logical_after := by
  unfold main5c_like_logical_before main5c_like_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main5c_like_logical
  all_goals (try extract_goal ; sorry)
  ---END main5c_like_logical



def main5f_like_before := [llvm|
{
^0(%arg98 : i32, %arg99 : i32, %arg100 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg98, %arg99 : i32
  %3 = llvm.icmp "ne" %2, %arg98 : i32
  %4 = llvm.and %arg98, %arg100 : i32
  %5 = llvm.icmp "ne" %4, %arg98 : i32
  %6 = llvm.or %3, %5 : i1
  %7 = "llvm.select"(%6, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def main5f_like_after := [llvm|
{
^0(%arg98 : i32, %arg99 : i32, %arg100 : i32):
  %0 = llvm.and %arg99, %arg100 : i32
  %1 = llvm.and %arg98, %0 : i32
  %2 = llvm.icmp "eq" %1, %arg98 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main5f_like_proof : main5f_like_before ⊑ main5f_like_after := by
  unfold main5f_like_before main5f_like_after
  simp_alive_peephole
  intros
  ---BEGIN main5f_like
  all_goals (try extract_goal ; sorry)
  ---END main5f_like



def main5f_like_logical_before := [llvm|
{
^0(%arg95 : i32, %arg96 : i32, %arg97 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg95, %arg96 : i32
  %4 = llvm.icmp "ne" %3, %arg95 : i32
  %5 = llvm.and %arg95, %arg97 : i32
  %6 = llvm.icmp "ne" %5, %arg95 : i32
  %7 = "llvm.select"(%4, %0, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %8 = "llvm.select"(%7, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def main5f_like_logical_after := [llvm|
{
^0(%arg95 : i32, %arg96 : i32, %arg97 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.and %arg95, %arg96 : i32
  %2 = llvm.icmp "eq" %1, %arg95 : i32
  %3 = llvm.and %arg95, %arg97 : i32
  %4 = llvm.icmp "eq" %3, %arg95 : i32
  %5 = "llvm.select"(%2, %4, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main5f_like_logical_proof : main5f_like_logical_before ⊑ main5f_like_logical_after := by
  unfold main5f_like_logical_before main5f_like_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main5f_like_logical
  all_goals (try extract_goal ; sorry)
  ---END main5f_like_logical



def main6_before := [llvm|
{
^0(%arg94 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(48 : i32) : i32
  %3 = llvm.mlir.constant(16 : i32) : i32
  %4 = llvm.mlir.constant(0 : i32) : i32
  %5 = llvm.mlir.constant(1 : i32) : i32
  %6 = llvm.and %arg94, %0 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = llvm.and %arg94, %2 : i32
  %9 = llvm.icmp "eq" %8, %3 : i32
  %10 = llvm.and %7, %9 : i1
  %11 = "llvm.select"(%10, %4, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%11) : (i32) -> ()
}
]
def main6_after := [llvm|
{
^0(%arg94 : i32):
  %0 = llvm.mlir.constant(55 : i32) : i32
  %1 = llvm.mlir.constant(19 : i32) : i32
  %2 = llvm.and %arg94, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main6_proof : main6_before ⊑ main6_after := by
  unfold main6_before main6_after
  simp_alive_peephole
  intros
  ---BEGIN main6
  all_goals (try extract_goal ; sorry)
  ---END main6



def main6_logical_before := [llvm|
{
^0(%arg93 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(48 : i32) : i32
  %3 = llvm.mlir.constant(16 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.mlir.constant(0 : i32) : i32
  %6 = llvm.mlir.constant(1 : i32) : i32
  %7 = llvm.and %arg93, %0 : i32
  %8 = llvm.icmp "eq" %7, %1 : i32
  %9 = llvm.and %arg93, %2 : i32
  %10 = llvm.icmp "eq" %9, %3 : i32
  %11 = "llvm.select"(%8, %10, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %12 = "llvm.select"(%11, %5, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%12) : (i32) -> ()
}
]
def main6_logical_after := [llvm|
{
^0(%arg93 : i32):
  %0 = llvm.mlir.constant(55 : i32) : i32
  %1 = llvm.mlir.constant(19 : i32) : i32
  %2 = llvm.and %arg93, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main6_logical_proof : main6_logical_before ⊑ main6_logical_after := by
  unfold main6_logical_before main6_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main6_logical
  all_goals (try extract_goal ; sorry)
  ---END main6_logical



def main6b_before := [llvm|
{
^0(%arg92 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(16 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.and %arg92, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg92, %2 : i32
  %8 = llvm.icmp "ne" %7, %3 : i32
  %9 = llvm.and %6, %8 : i1
  %10 = "llvm.select"(%9, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main6b_after := [llvm|
{
^0(%arg92 : i32):
  %0 = llvm.mlir.constant(23 : i32) : i32
  %1 = llvm.mlir.constant(19 : i32) : i32
  %2 = llvm.and %arg92, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main6b_proof : main6b_before ⊑ main6b_after := by
  unfold main6b_before main6b_after
  simp_alive_peephole
  intros
  ---BEGIN main6b
  all_goals (try extract_goal ; sorry)
  ---END main6b



def main6b_logical_before := [llvm|
{
^0(%arg91 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(16 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.mlir.constant(1 : i32) : i32
  %6 = llvm.and %arg91, %0 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = llvm.and %arg91, %2 : i32
  %9 = llvm.icmp "ne" %8, %3 : i32
  %10 = "llvm.select"(%7, %9, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%10, %3, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%11) : (i32) -> ()
}
]
def main6b_logical_after := [llvm|
{
^0(%arg91 : i32):
  %0 = llvm.mlir.constant(23 : i32) : i32
  %1 = llvm.mlir.constant(19 : i32) : i32
  %2 = llvm.and %arg91, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main6b_logical_proof : main6b_logical_before ⊑ main6b_logical_after := by
  unfold main6b_logical_before main6b_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main6b_logical
  all_goals (try extract_goal ; sorry)
  ---END main6b_logical



def main6c_before := [llvm|
{
^0(%arg90 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(48 : i32) : i32
  %3 = llvm.mlir.constant(16 : i32) : i32
  %4 = llvm.mlir.constant(0 : i32) : i32
  %5 = llvm.mlir.constant(1 : i32) : i32
  %6 = llvm.and %arg90, %0 : i32
  %7 = llvm.icmp "ne" %6, %1 : i32
  %8 = llvm.and %arg90, %2 : i32
  %9 = llvm.icmp "ne" %8, %3 : i32
  %10 = llvm.or %7, %9 : i1
  %11 = "llvm.select"(%10, %4, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%11) : (i32) -> ()
}
]
def main6c_after := [llvm|
{
^0(%arg90 : i32):
  %0 = llvm.mlir.constant(55 : i32) : i32
  %1 = llvm.mlir.constant(19 : i32) : i32
  %2 = llvm.and %arg90, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main6c_proof : main6c_before ⊑ main6c_after := by
  unfold main6c_before main6c_after
  simp_alive_peephole
  intros
  ---BEGIN main6c
  all_goals (try extract_goal ; sorry)
  ---END main6c



def main6c_logical_before := [llvm|
{
^0(%arg89 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(48 : i32) : i32
  %3 = llvm.mlir.constant(16 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.mlir.constant(0 : i32) : i32
  %6 = llvm.mlir.constant(1 : i32) : i32
  %7 = llvm.and %arg89, %0 : i32
  %8 = llvm.icmp "ne" %7, %1 : i32
  %9 = llvm.and %arg89, %2 : i32
  %10 = llvm.icmp "ne" %9, %3 : i32
  %11 = "llvm.select"(%8, %4, %10) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %12 = "llvm.select"(%11, %5, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%12) : (i32) -> ()
}
]
def main6c_logical_after := [llvm|
{
^0(%arg89 : i32):
  %0 = llvm.mlir.constant(55 : i32) : i32
  %1 = llvm.mlir.constant(19 : i32) : i32
  %2 = llvm.and %arg89, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main6c_logical_proof : main6c_logical_before ⊑ main6c_logical_after := by
  unfold main6c_logical_before main6c_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main6c_logical
  all_goals (try extract_goal ; sorry)
  ---END main6c_logical



def main6d_before := [llvm|
{
^0(%arg88 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(16 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.and %arg88, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg88, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  %9 = llvm.or %6, %8 : i1
  %10 = "llvm.select"(%9, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main6d_after := [llvm|
{
^0(%arg88 : i32):
  %0 = llvm.mlir.constant(23 : i32) : i32
  %1 = llvm.mlir.constant(19 : i32) : i32
  %2 = llvm.and %arg88, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main6d_proof : main6d_before ⊑ main6d_after := by
  unfold main6d_before main6d_after
  simp_alive_peephole
  intros
  ---BEGIN main6d
  all_goals (try extract_goal ; sorry)
  ---END main6d



def main6d_logical_before := [llvm|
{
^0(%arg87 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(16 : i32) : i32
  %3 = llvm.mlir.constant(0 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.mlir.constant(1 : i32) : i32
  %6 = llvm.and %arg87, %0 : i32
  %7 = llvm.icmp "ne" %6, %1 : i32
  %8 = llvm.and %arg87, %2 : i32
  %9 = llvm.icmp "eq" %8, %3 : i32
  %10 = "llvm.select"(%7, %4, %9) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%10, %3, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%11) : (i32) -> ()
}
]
def main6d_logical_after := [llvm|
{
^0(%arg87 : i32):
  %0 = llvm.mlir.constant(23 : i32) : i32
  %1 = llvm.mlir.constant(19 : i32) : i32
  %2 = llvm.and %arg87, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main6d_logical_proof : main6d_logical_before ⊑ main6d_logical_after := by
  unfold main6d_logical_before main6d_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main6d_logical
  all_goals (try extract_goal ; sorry)
  ---END main6d_logical



def main7a_before := [llvm|
{
^0(%arg84 : i32, %arg85 : i32, %arg86 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg85, %arg84 : i32
  %3 = llvm.icmp "eq" %2, %arg85 : i32
  %4 = llvm.and %arg86, %arg84 : i32
  %5 = llvm.icmp "eq" %4, %arg86 : i32
  %6 = llvm.and %3, %5 : i1
  %7 = "llvm.select"(%6, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def main7a_after := [llvm|
{
^0(%arg84 : i32, %arg85 : i32, %arg86 : i32):
  %0 = llvm.or %arg85, %arg86 : i32
  %1 = llvm.and %arg84, %0 : i32
  %2 = llvm.icmp "ne" %1, %0 : i32
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main7a_proof : main7a_before ⊑ main7a_after := by
  unfold main7a_before main7a_after
  simp_alive_peephole
  intros
  ---BEGIN main7a
  all_goals (try extract_goal ; sorry)
  ---END main7a



def main7a_logical_before := [llvm|
{
^0(%arg81 : i32, %arg82 : i32, %arg83 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg82, %arg81 : i32
  %4 = llvm.icmp "eq" %3, %arg82 : i32
  %5 = llvm.and %arg83, %arg81 : i32
  %6 = llvm.icmp "eq" %5, %arg83 : i32
  %7 = "llvm.select"(%4, %6, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %8 = "llvm.select"(%7, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def main7a_logical_after := [llvm|
{
^0(%arg81 : i32, %arg82 : i32, %arg83 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg82, %arg81 : i32
  %2 = llvm.icmp "ne" %1, %arg82 : i32
  %3 = llvm.and %arg83, %arg81 : i32
  %4 = llvm.icmp "ne" %3, %arg83 : i32
  %5 = "llvm.select"(%2, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main7a_logical_proof : main7a_logical_before ⊑ main7a_logical_after := by
  unfold main7a_logical_before main7a_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main7a_logical
  all_goals (try extract_goal ; sorry)
  ---END main7a_logical



def main7b_before := [llvm|
{
^0(%arg78 : i32, %arg79 : i32, %arg80 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mul %arg80, %0 : i32
  %4 = llvm.and %arg78, %arg79 : i32
  %5 = llvm.icmp "eq" %arg79, %4 : i32
  %6 = llvm.and %arg78, %3 : i32
  %7 = llvm.icmp "eq" %3, %6 : i32
  %8 = llvm.and %5, %7 : i1
  %9 = "llvm.select"(%8, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main7b_after := [llvm|
{
^0(%arg78 : i32, %arg79 : i32, %arg80 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg80, %0 : i32
  %2 = llvm.or %arg79, %1 : i32
  %3 = llvm.and %arg78, %2 : i32
  %4 = llvm.icmp "ne" %3, %2 : i32
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main7b_proof : main7b_before ⊑ main7b_after := by
  unfold main7b_before main7b_after
  simp_alive_peephole
  intros
  ---BEGIN main7b
  all_goals (try extract_goal ; sorry)
  ---END main7b



def main7b_logical_before := [llvm|
{
^0(%arg75 : i32, %arg76 : i32, %arg77 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg75, %arg76 : i32
  %4 = llvm.icmp "eq" %arg76, %3 : i32
  %5 = llvm.and %arg75, %arg77 : i32
  %6 = llvm.icmp "eq" %arg77, %5 : i32
  %7 = "llvm.select"(%4, %6, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %8 = "llvm.select"(%7, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def main7b_logical_after := [llvm|
{
^0(%arg75 : i32, %arg76 : i32, %arg77 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg75, %arg76 : i32
  %2 = llvm.icmp "ne" %arg76, %1 : i32
  %3 = llvm.and %arg75, %arg77 : i32
  %4 = llvm.icmp "ne" %arg77, %3 : i32
  %5 = "llvm.select"(%2, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main7b_logical_proof : main7b_logical_before ⊑ main7b_logical_after := by
  unfold main7b_logical_before main7b_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main7b_logical
  all_goals (try extract_goal ; sorry)
  ---END main7b_logical



def main7c_before := [llvm|
{
^0(%arg72 : i32, %arg73 : i32, %arg74 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mul %arg74, %0 : i32
  %4 = llvm.and %arg73, %arg72 : i32
  %5 = llvm.icmp "eq" %arg73, %4 : i32
  %6 = llvm.and %3, %arg72 : i32
  %7 = llvm.icmp "eq" %3, %6 : i32
  %8 = llvm.and %5, %7 : i1
  %9 = "llvm.select"(%8, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main7c_after := [llvm|
{
^0(%arg72 : i32, %arg73 : i32, %arg74 : i32):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mul %arg74, %0 : i32
  %2 = llvm.or %arg73, %1 : i32
  %3 = llvm.and %arg72, %2 : i32
  %4 = llvm.icmp "ne" %3, %2 : i32
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main7c_proof : main7c_before ⊑ main7c_after := by
  unfold main7c_before main7c_after
  simp_alive_peephole
  intros
  ---BEGIN main7c
  all_goals (try extract_goal ; sorry)
  ---END main7c



def main7c_logical_before := [llvm|
{
^0(%arg69 : i32, %arg70 : i32, %arg71 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg70, %arg69 : i32
  %4 = llvm.icmp "eq" %arg70, %3 : i32
  %5 = llvm.and %arg71, %arg69 : i32
  %6 = llvm.icmp "eq" %arg71, %5 : i32
  %7 = "llvm.select"(%4, %6, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %8 = "llvm.select"(%7, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def main7c_logical_after := [llvm|
{
^0(%arg69 : i32, %arg70 : i32, %arg71 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg70, %arg69 : i32
  %2 = llvm.icmp "ne" %arg70, %1 : i32
  %3 = llvm.and %arg71, %arg69 : i32
  %4 = llvm.icmp "ne" %arg71, %3 : i32
  %5 = "llvm.select"(%2, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.zext %5 : i1 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main7c_logical_proof : main7c_logical_before ⊑ main7c_logical_after := by
  unfold main7c_logical_before main7c_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main7c_logical
  all_goals (try extract_goal ; sorry)
  ---END main7c_logical



def main7d_before := [llvm|
{
^0(%arg64 : i32, %arg65 : i32, %arg66 : i32, %arg67 : i32, %arg68 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg65, %arg67 : i32
  %3 = llvm.and %arg66, %arg68 : i32
  %4 = llvm.and %arg64, %2 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.and %arg64, %3 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  %9 = "llvm.select"(%8, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main7d_after := [llvm|
{
^0(%arg64 : i32, %arg65 : i32, %arg66 : i32, %arg67 : i32, %arg68 : i32):
  %0 = llvm.and %arg65, %arg67 : i32
  %1 = llvm.and %arg66, %arg68 : i32
  %2 = llvm.or %0, %1 : i32
  %3 = llvm.and %arg64, %2 : i32
  %4 = llvm.icmp "ne" %3, %2 : i32
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main7d_proof : main7d_before ⊑ main7d_after := by
  unfold main7d_before main7d_after
  simp_alive_peephole
  intros
  ---BEGIN main7d
  all_goals (try extract_goal ; sorry)
  ---END main7d



def main7d_logical_before := [llvm|
{
^0(%arg59 : i32, %arg60 : i32, %arg61 : i32, %arg62 : i32, %arg63 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg60, %arg62 : i32
  %4 = llvm.and %arg61, %arg63 : i32
  %5 = llvm.and %arg59, %3 : i32
  %6 = llvm.icmp "eq" %5, %3 : i32
  %7 = llvm.and %arg59, %4 : i32
  %8 = llvm.icmp "eq" %7, %4 : i32
  %9 = "llvm.select"(%6, %8, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %10 = "llvm.select"(%9, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main7d_logical_after := [llvm|
{
^0(%arg59 : i32, %arg60 : i32, %arg61 : i32, %arg62 : i32, %arg63 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg60, %arg62 : i32
  %2 = llvm.and %arg61, %arg63 : i32
  %3 = llvm.and %arg59, %1 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %arg59, %2 : i32
  %6 = llvm.icmp "ne" %5, %2 : i32
  %7 = "llvm.select"(%4, %0, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %8 = llvm.zext %7 : i1 to i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main7d_logical_proof : main7d_logical_before ⊑ main7d_logical_after := by
  unfold main7d_logical_before main7d_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main7d_logical
  all_goals (try extract_goal ; sorry)
  ---END main7d_logical



def main7e_before := [llvm|
{
^0(%arg54 : i32, %arg55 : i32, %arg56 : i32, %arg57 : i32, %arg58 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg55, %arg57 : i32
  %3 = llvm.and %arg56, %arg58 : i32
  %4 = llvm.and %2, %arg54 : i32
  %5 = llvm.icmp "eq" %4, %2 : i32
  %6 = llvm.and %3, %arg54 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  %9 = "llvm.select"(%8, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main7e_after := [llvm|
{
^0(%arg54 : i32, %arg55 : i32, %arg56 : i32, %arg57 : i32, %arg58 : i32):
  %0 = llvm.and %arg55, %arg57 : i32
  %1 = llvm.and %arg56, %arg58 : i32
  %2 = llvm.or %0, %1 : i32
  %3 = llvm.and %arg54, %2 : i32
  %4 = llvm.icmp "ne" %3, %2 : i32
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main7e_proof : main7e_before ⊑ main7e_after := by
  unfold main7e_before main7e_after
  simp_alive_peephole
  intros
  ---BEGIN main7e
  all_goals (try extract_goal ; sorry)
  ---END main7e



def main7e_logical_before := [llvm|
{
^0(%arg49 : i32, %arg50 : i32, %arg51 : i32, %arg52 : i32, %arg53 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg50, %arg52 : i32
  %4 = llvm.and %arg51, %arg53 : i32
  %5 = llvm.and %3, %arg49 : i32
  %6 = llvm.icmp "eq" %5, %3 : i32
  %7 = llvm.and %4, %arg49 : i32
  %8 = llvm.icmp "eq" %7, %4 : i32
  %9 = "llvm.select"(%6, %8, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %10 = "llvm.select"(%9, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main7e_logical_after := [llvm|
{
^0(%arg49 : i32, %arg50 : i32, %arg51 : i32, %arg52 : i32, %arg53 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg50, %arg52 : i32
  %2 = llvm.and %arg51, %arg53 : i32
  %3 = llvm.and %1, %arg49 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %2, %arg49 : i32
  %6 = llvm.icmp "ne" %5, %2 : i32
  %7 = "llvm.select"(%4, %0, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %8 = llvm.zext %7 : i1 to i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main7e_logical_proof : main7e_logical_before ⊑ main7e_logical_after := by
  unfold main7e_logical_before main7e_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main7e_logical
  all_goals (try extract_goal ; sorry)
  ---END main7e_logical



def main7f_before := [llvm|
{
^0(%arg44 : i32, %arg45 : i32, %arg46 : i32, %arg47 : i32, %arg48 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg45, %arg47 : i32
  %3 = llvm.and %arg46, %arg48 : i32
  %4 = llvm.and %arg44, %2 : i32
  %5 = llvm.icmp "eq" %2, %4 : i32
  %6 = llvm.and %arg44, %3 : i32
  %7 = llvm.icmp "eq" %3, %6 : i32
  %8 = llvm.and %5, %7 : i1
  %9 = "llvm.select"(%8, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main7f_after := [llvm|
{
^0(%arg44 : i32, %arg45 : i32, %arg46 : i32, %arg47 : i32, %arg48 : i32):
  %0 = llvm.and %arg45, %arg47 : i32
  %1 = llvm.and %arg46, %arg48 : i32
  %2 = llvm.or %0, %1 : i32
  %3 = llvm.and %arg44, %2 : i32
  %4 = llvm.icmp "ne" %3, %2 : i32
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main7f_proof : main7f_before ⊑ main7f_after := by
  unfold main7f_before main7f_after
  simp_alive_peephole
  intros
  ---BEGIN main7f
  all_goals (try extract_goal ; sorry)
  ---END main7f



def main7f_logical_before := [llvm|
{
^0(%arg39 : i32, %arg40 : i32, %arg41 : i32, %arg42 : i32, %arg43 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg40, %arg42 : i32
  %4 = llvm.and %arg41, %arg43 : i32
  %5 = llvm.and %arg39, %3 : i32
  %6 = llvm.icmp "eq" %3, %5 : i32
  %7 = llvm.and %arg39, %4 : i32
  %8 = llvm.icmp "eq" %4, %7 : i32
  %9 = "llvm.select"(%6, %8, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %10 = "llvm.select"(%9, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main7f_logical_after := [llvm|
{
^0(%arg39 : i32, %arg40 : i32, %arg41 : i32, %arg42 : i32, %arg43 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg40, %arg42 : i32
  %2 = llvm.and %arg41, %arg43 : i32
  %3 = llvm.and %arg39, %1 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.and %arg39, %2 : i32
  %6 = llvm.icmp "ne" %2, %5 : i32
  %7 = "llvm.select"(%4, %0, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %8 = llvm.zext %7 : i1 to i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main7f_logical_proof : main7f_logical_before ⊑ main7f_logical_after := by
  unfold main7f_logical_before main7f_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main7f_logical
  all_goals (try extract_goal ; sorry)
  ---END main7f_logical



def main7g_before := [llvm|
{
^0(%arg34 : i32, %arg35 : i32, %arg36 : i32, %arg37 : i32, %arg38 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.and %arg35, %arg37 : i32
  %3 = llvm.and %arg36, %arg38 : i32
  %4 = llvm.and %2, %arg34 : i32
  %5 = llvm.icmp "eq" %2, %4 : i32
  %6 = llvm.and %3, %arg34 : i32
  %7 = llvm.icmp "eq" %3, %6 : i32
  %8 = llvm.and %5, %7 : i1
  %9 = "llvm.select"(%8, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main7g_after := [llvm|
{
^0(%arg34 : i32, %arg35 : i32, %arg36 : i32, %arg37 : i32, %arg38 : i32):
  %0 = llvm.and %arg35, %arg37 : i32
  %1 = llvm.and %arg36, %arg38 : i32
  %2 = llvm.or %0, %1 : i32
  %3 = llvm.and %arg34, %2 : i32
  %4 = llvm.icmp "ne" %3, %2 : i32
  %5 = llvm.zext %4 : i1 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main7g_proof : main7g_before ⊑ main7g_after := by
  unfold main7g_before main7g_after
  simp_alive_peephole
  intros
  ---BEGIN main7g
  all_goals (try extract_goal ; sorry)
  ---END main7g



def main7g_logical_before := [llvm|
{
^0(%arg29 : i32, %arg30 : i32, %arg31 : i32, %arg32 : i32, %arg33 : i32):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg30, %arg32 : i32
  %4 = llvm.and %arg31, %arg33 : i32
  %5 = llvm.and %3, %arg29 : i32
  %6 = llvm.icmp "eq" %3, %5 : i32
  %7 = llvm.and %4, %arg29 : i32
  %8 = llvm.icmp "eq" %4, %7 : i32
  %9 = "llvm.select"(%6, %8, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %10 = "llvm.select"(%9, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main7g_logical_after := [llvm|
{
^0(%arg29 : i32, %arg30 : i32, %arg31 : i32, %arg32 : i32, %arg33 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg30, %arg32 : i32
  %2 = llvm.and %arg31, %arg33 : i32
  %3 = llvm.and %1, %arg29 : i32
  %4 = llvm.icmp "ne" %1, %3 : i32
  %5 = llvm.and %2, %arg29 : i32
  %6 = llvm.icmp "ne" %2, %5 : i32
  %7 = "llvm.select"(%4, %0, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %8 = llvm.zext %7 : i1 to i32
  "llvm.return"(%8) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main7g_logical_proof : main7g_logical_before ⊑ main7g_logical_after := by
  unfold main7g_logical_before main7g_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main7g_logical
  all_goals (try extract_goal ; sorry)
  ---END main7g_logical



def main8_before := [llvm|
{
^0(%arg28 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(2 : i32) : i32
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.and %arg28, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.trunc %arg28 : i32 to i8
  %8 = llvm.icmp "slt" %7, %2 : i8
  %9 = llvm.or %6, %8 : i1
  %10 = "llvm.select"(%9, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main8_after := [llvm|
{
^0(%arg28 : i32):
  %0 = llvm.mlir.constant(192 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mlir.constant(2 : i32) : i32
  %4 = llvm.and %arg28, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main8_proof : main8_before ⊑ main8_after := by
  unfold main8_before main8_after
  simp_alive_peephole
  intros
  ---BEGIN main8
  all_goals (try extract_goal ; sorry)
  ---END main8



def main8_logical_before := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.mlir.constant(2 : i32) : i32
  %5 = llvm.mlir.constant(1 : i32) : i32
  %6 = llvm.and %arg27, %0 : i32
  %7 = llvm.icmp "ne" %6, %1 : i32
  %8 = llvm.trunc %arg27 : i32 to i8
  %9 = llvm.icmp "slt" %8, %2 : i8
  %10 = "llvm.select"(%7, %3, %9) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%10, %4, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%11) : (i32) -> ()
}
]
def main8_logical_after := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(192 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mlir.constant(2 : i32) : i32
  %4 = llvm.and %arg27, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main8_logical_proof : main8_logical_before ⊑ main8_logical_after := by
  unfold main8_logical_before main8_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main8_logical
  all_goals (try extract_goal ; sorry)
  ---END main8_logical



def main9_before := [llvm|
{
^0(%arg26 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(2 : i32) : i32
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.and %arg26, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.trunc %arg26 : i32 to i8
  %8 = llvm.icmp "slt" %7, %2 : i8
  %9 = llvm.and %6, %8 : i1
  %10 = "llvm.select"(%9, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main9_after := [llvm|
{
^0(%arg26 : i32):
  %0 = llvm.mlir.constant(192 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg26, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = "llvm.select"(%4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main9_proof : main9_before ⊑ main9_after := by
  unfold main9_before main9_after
  simp_alive_peephole
  intros
  ---BEGIN main9
  all_goals (try extract_goal ; sorry)
  ---END main9



def main9_logical_before := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.mlir.constant(2 : i32) : i32
  %5 = llvm.mlir.constant(1 : i32) : i32
  %6 = llvm.and %arg25, %0 : i32
  %7 = llvm.icmp "ne" %6, %1 : i32
  %8 = llvm.trunc %arg25 : i32 to i8
  %9 = llvm.icmp "slt" %8, %2 : i8
  %10 = "llvm.select"(%7, %9, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%10, %4, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%11) : (i32) -> ()
}
]
def main9_logical_after := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(192 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg25, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = "llvm.select"(%4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main9_logical_proof : main9_logical_before ⊑ main9_logical_after := by
  unfold main9_logical_before main9_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main9_logical
  all_goals (try extract_goal ; sorry)
  ---END main9_logical



def main10_before := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(2 : i32) : i32
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.and %arg24, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.trunc %arg24 : i32 to i8
  %8 = llvm.icmp "sge" %7, %2 : i8
  %9 = llvm.and %6, %8 : i1
  %10 = "llvm.select"(%9, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main10_after := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(192 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg24, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main10_proof : main10_before ⊑ main10_after := by
  unfold main10_before main10_after
  simp_alive_peephole
  intros
  ---BEGIN main10
  all_goals (try extract_goal ; sorry)
  ---END main10



def main10_logical_before := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.mlir.constant(2 : i32) : i32
  %5 = llvm.mlir.constant(1 : i32) : i32
  %6 = llvm.and %arg23, %0 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = llvm.trunc %arg23 : i32 to i8
  %9 = llvm.icmp "sge" %8, %2 : i8
  %10 = "llvm.select"(%7, %9, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%10, %4, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%11) : (i32) -> ()
}
]
def main10_logical_after := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(192 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg23, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main10_logical_proof : main10_logical_before ⊑ main10_logical_after := by
  unfold main10_logical_before main10_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main10_logical
  all_goals (try extract_goal ; sorry)
  ---END main10_logical



def main11_before := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(2 : i32) : i32
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.and %arg22, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.trunc %arg22 : i32 to i8
  %8 = llvm.icmp "sge" %7, %2 : i8
  %9 = llvm.or %6, %8 : i1
  %10 = "llvm.select"(%9, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main11_after := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(192 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg22, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = "llvm.select"(%4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main11_proof : main11_before ⊑ main11_after := by
  unfold main11_before main11_after
  simp_alive_peephole
  intros
  ---BEGIN main11
  all_goals (try extract_goal ; sorry)
  ---END main11



def main11_logical_before := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(64 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.mlir.constant(2 : i32) : i32
  %5 = llvm.mlir.constant(1 : i32) : i32
  %6 = llvm.and %arg21, %0 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = llvm.trunc %arg21 : i32 to i8
  %9 = llvm.icmp "sge" %8, %2 : i8
  %10 = "llvm.select"(%7, %3, %9) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %11 = "llvm.select"(%10, %4, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%11) : (i32) -> ()
}
]
def main11_logical_after := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(192 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg21, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = "llvm.select"(%4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main11_logical_proof : main11_logical_before ⊑ main11_logical_after := by
  unfold main11_logical_before main11_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main11_logical
  all_goals (try extract_goal ; sorry)
  ---END main11_logical



def main12_before := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(0 : i16) : i16
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.trunc %arg20 : i32 to i16
  %5 = llvm.icmp "slt" %4, %0 : i16
  %6 = llvm.trunc %arg20 : i32 to i8
  %7 = llvm.icmp "slt" %6, %1 : i8
  %8 = llvm.or %5, %7 : i1
  %9 = "llvm.select"(%8, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main12_after := [llvm|
{
^0(%arg20 : i32):
  %0 = llvm.mlir.constant(32896 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mlir.constant(2 : i32) : i32
  %4 = llvm.and %arg20, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main12_proof : main12_before ⊑ main12_after := by
  unfold main12_before main12_after
  simp_alive_peephole
  intros
  ---BEGIN main12
  all_goals (try extract_goal ; sorry)
  ---END main12



def main12_logical_before := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(0 : i16) : i16
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.mlir.constant(2 : i32) : i32
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.trunc %arg19 : i32 to i16
  %6 = llvm.icmp "slt" %5, %0 : i16
  %7 = llvm.trunc %arg19 : i32 to i8
  %8 = llvm.icmp "slt" %7, %1 : i8
  %9 = "llvm.select"(%6, %2, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %10 = "llvm.select"(%9, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main12_logical_after := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(32896 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.mlir.constant(2 : i32) : i32
  %4 = llvm.and %arg19, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main12_logical_proof : main12_logical_before ⊑ main12_logical_after := by
  unfold main12_logical_before main12_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main12_logical
  all_goals (try extract_goal ; sorry)
  ---END main12_logical



def main13_before := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(0 : i16) : i16
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.trunc %arg18 : i32 to i16
  %5 = llvm.icmp "slt" %4, %0 : i16
  %6 = llvm.trunc %arg18 : i32 to i8
  %7 = llvm.icmp "slt" %6, %1 : i8
  %8 = llvm.and %5, %7 : i1
  %9 = "llvm.select"(%8, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main13_after := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(32896 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg18, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = "llvm.select"(%4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main13_proof : main13_before ⊑ main13_after := by
  unfold main13_before main13_after
  simp_alive_peephole
  intros
  ---BEGIN main13
  all_goals (try extract_goal ; sorry)
  ---END main13



def main13_logical_before := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(0 : i16) : i16
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.mlir.constant(2 : i32) : i32
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.trunc %arg17 : i32 to i16
  %6 = llvm.icmp "slt" %5, %0 : i16
  %7 = llvm.trunc %arg17 : i32 to i8
  %8 = llvm.icmp "slt" %7, %1 : i8
  %9 = "llvm.select"(%6, %8, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %10 = "llvm.select"(%9, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main13_logical_after := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(32896 : i32) : i32
  %1 = llvm.mlir.constant(2 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg17, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = "llvm.select"(%4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main13_logical_proof : main13_logical_before ⊑ main13_logical_after := by
  unfold main13_logical_before main13_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main13_logical
  all_goals (try extract_goal ; sorry)
  ---END main13_logical



def main14_before := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(0 : i16) : i16
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.trunc %arg16 : i32 to i16
  %5 = llvm.icmp "sge" %4, %0 : i16
  %6 = llvm.trunc %arg16 : i32 to i8
  %7 = llvm.icmp "sge" %6, %1 : i8
  %8 = llvm.and %5, %7 : i1
  %9 = "llvm.select"(%8, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main14_after := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(32896 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg16, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main14_proof : main14_before ⊑ main14_after := by
  unfold main14_before main14_after
  simp_alive_peephole
  intros
  ---BEGIN main14
  all_goals (try extract_goal ; sorry)
  ---END main14



def main14_logical_before := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(0 : i16) : i16
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.mlir.constant(2 : i32) : i32
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.trunc %arg15 : i32 to i16
  %6 = llvm.icmp "sge" %5, %0 : i16
  %7 = llvm.trunc %arg15 : i32 to i8
  %8 = llvm.icmp "sge" %7, %1 : i8
  %9 = "llvm.select"(%6, %8, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %10 = "llvm.select"(%9, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main14_logical_after := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(32896 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg15, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main14_logical_proof : main14_logical_before ⊑ main14_logical_after := by
  unfold main14_logical_before main14_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main14_logical
  all_goals (try extract_goal ; sorry)
  ---END main14_logical



def main15_before := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(0 : i16) : i16
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.trunc %arg14 : i32 to i16
  %5 = llvm.icmp "sge" %4, %0 : i16
  %6 = llvm.trunc %arg14 : i32 to i8
  %7 = llvm.icmp "sge" %6, %1 : i8
  %8 = llvm.or %5, %7 : i1
  %9 = "llvm.select"(%8, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%9) : (i32) -> ()
}
]
def main15_after := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(32896 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg14, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = "llvm.select"(%4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main15_proof : main15_before ⊑ main15_after := by
  unfold main15_before main15_after
  simp_alive_peephole
  intros
  ---BEGIN main15
  all_goals (try extract_goal ; sorry)
  ---END main15



def main15_logical_before := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(0 : i16) : i16
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.mlir.constant(2 : i32) : i32
  %4 = llvm.mlir.constant(1 : i32) : i32
  %5 = llvm.trunc %arg13 : i32 to i16
  %6 = llvm.icmp "sge" %5, %0 : i16
  %7 = llvm.trunc %arg13 : i32 to i8
  %8 = llvm.icmp "sge" %7, %1 : i8
  %9 = "llvm.select"(%6, %2, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %10 = "llvm.select"(%9, %3, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%10) : (i32) -> ()
}
]
def main15_logical_after := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(32896 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(2 : i32) : i32
  %3 = llvm.and %arg13, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = "llvm.select"(%4, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem main15_logical_proof : main15_logical_before ⊑ main15_logical_after := by
  unfold main15_logical_before main15_logical_after
  simp_alive_peephole
  intros
  ---BEGIN main15_logical
  all_goals (try extract_goal ; sorry)
  ---END main15_logical



def no_masks_with_logical_or_before := [llvm|
{
^0(%arg10 : i32, %arg11 : i32, %arg12 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(63 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "ne" %arg10, %0 : i32
  %4 = llvm.icmp "ne" %arg11, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.icmp "ne" %arg12, %0 : i32
  %7 = llvm.or %5, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def no_masks_with_logical_or_after := [llvm|
{
^0(%arg10 : i32, %arg11 : i32, %arg12 : i32):
  %0 = llvm.mlir.constant(63 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "ne" %arg11, %0 : i32
  %4 = llvm.or %arg10, %arg12 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_masks_with_logical_or_proof : no_masks_with_logical_or_before ⊑ no_masks_with_logical_or_after := by
  unfold no_masks_with_logical_or_before no_masks_with_logical_or_after
  simp_alive_peephole
  intros
  ---BEGIN no_masks_with_logical_or
  all_goals (try extract_goal ; sorry)
  ---END no_masks_with_logical_or



def no_masks_with_logical_or2_before := [llvm|
{
^0(%arg7 : i32, %arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(63 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "ne" %arg7, %0 : i32
  %4 = llvm.icmp "ne" %arg8, %1 : i32
  %5 = "llvm.select"(%3, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = llvm.icmp "ne" %arg9, %0 : i32
  %7 = llvm.or %5, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def no_masks_with_logical_or2_after := [llvm|
{
^0(%arg7 : i32, %arg8 : i32, %arg9 : i32):
  %0 = llvm.mlir.constant(63 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "ne" %arg8, %0 : i32
  %4 = llvm.and %arg7, %arg9 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = "llvm.select"(%5, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem no_masks_with_logical_or2_proof : no_masks_with_logical_or2_before ⊑ no_masks_with_logical_or2_after := by
  unfold no_masks_with_logical_or2_before no_masks_with_logical_or2_after
  simp_alive_peephole
  intros
  ---BEGIN no_masks_with_logical_or2
  all_goals (try extract_goal ; sorry)
  ---END no_masks_with_logical_or2



def only_one_masked_before := [llvm|
{
^0(%arg0 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.mlir.constant(9223372036854775807) : i64
  %2 = llvm.icmp "ne" %arg0, %0 : i64
  %3 = llvm.and %arg0, %1 : i64
  %4 = llvm.icmp "eq" %3, %0 : i64
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def only_one_masked_after := [llvm|
{
^0(%arg0 : i64):
  %0 = llvm.mlir.constant(-9223372036854775808) : i64
  %1 = llvm.icmp "eq" %arg0, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem only_one_masked_proof : only_one_masked_before ⊑ only_one_masked_after := by
  unfold only_one_masked_before only_one_masked_after
  simp_alive_peephole
  intros
  ---BEGIN only_one_masked
  all_goals (try extract_goal ; sorry)
  ---END only_one_masked


