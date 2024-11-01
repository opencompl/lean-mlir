
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
section gicmphlogical_statements

def masked_and_notallzeroes_before := [llvm|
{
^0(%arg134 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(39 : i32) : i32
  %3 = llvm.and %arg134, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %arg134, %2 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_and_notallzeroes_after := [llvm|
{
^0(%arg134 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg134, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_and_notallzeroes_proof : masked_and_notallzeroes_before ⊑ masked_and_notallzeroes_after := by
  unfold masked_and_notallzeroes_before masked_and_notallzeroes_after
  simp_alive_peephole
  intros
  ---BEGIN masked_and_notallzeroes
  all_goals (try extract_goal ; sorry)
  ---END masked_and_notallzeroes



def masked_and_notallzeroes_logical_before := [llvm|
{
^0(%arg132 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(39 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.and %arg132, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg132, %2 : i32
  %7 = llvm.icmp "ne" %6, %1 : i32
  %8 = "llvm.select"(%5, %7, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_and_notallzeroes_logical_after := [llvm|
{
^0(%arg132 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg132, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_and_notallzeroes_logical_proof : masked_and_notallzeroes_logical_before ⊑ masked_and_notallzeroes_logical_after := by
  unfold masked_and_notallzeroes_logical_before masked_and_notallzeroes_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_and_notallzeroes_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_and_notallzeroes_logical



def masked_or_allzeroes_before := [llvm|
{
^0(%arg131 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(39 : i32) : i32
  %3 = llvm.and %arg131, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg131, %2 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_or_allzeroes_after := [llvm|
{
^0(%arg131 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg131, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_or_allzeroes_proof : masked_or_allzeroes_before ⊑ masked_or_allzeroes_after := by
  unfold masked_or_allzeroes_before masked_or_allzeroes_after
  simp_alive_peephole
  intros
  ---BEGIN masked_or_allzeroes
  all_goals (try extract_goal ; sorry)
  ---END masked_or_allzeroes



def masked_or_allzeroes_logical_before := [llvm|
{
^0(%arg130 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(39 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.and %arg130, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg130, %2 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = "llvm.select"(%5, %3, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_or_allzeroes_logical_after := [llvm|
{
^0(%arg130 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg130, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_or_allzeroes_logical_proof : masked_or_allzeroes_logical_before ⊑ masked_or_allzeroes_logical_after := by
  unfold masked_or_allzeroes_logical_before masked_or_allzeroes_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_or_allzeroes_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_or_allzeroes_logical



def masked_and_notallones_before := [llvm|
{
^0(%arg129 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(39 : i32) : i32
  %2 = llvm.and %arg129, %0 : i32
  %3 = llvm.icmp "ne" %2, %0 : i32
  %4 = llvm.and %arg129, %1 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def masked_and_notallones_after := [llvm|
{
^0(%arg129 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.and %arg129, %0 : i32
  %2 = llvm.icmp "ne" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_and_notallones_proof : masked_and_notallones_before ⊑ masked_and_notallones_after := by
  unfold masked_and_notallones_before masked_and_notallones_after
  simp_alive_peephole
  intros
  ---BEGIN masked_and_notallones
  all_goals (try extract_goal ; sorry)
  ---END masked_and_notallones



def masked_and_notallones_logical_before := [llvm|
{
^0(%arg128 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(39 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.and %arg128, %0 : i32
  %4 = llvm.icmp "ne" %3, %0 : i32
  %5 = llvm.and %arg128, %1 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = "llvm.select"(%4, %6, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_and_notallones_logical_after := [llvm|
{
^0(%arg128 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.and %arg128, %0 : i32
  %2 = llvm.icmp "ne" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_and_notallones_logical_proof : masked_and_notallones_logical_before ⊑ masked_and_notallones_logical_after := by
  unfold masked_and_notallones_logical_before masked_and_notallones_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_and_notallones_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_and_notallones_logical



def masked_or_allones_before := [llvm|
{
^0(%arg127 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(39 : i32) : i32
  %2 = llvm.and %arg127, %0 : i32
  %3 = llvm.icmp "eq" %2, %0 : i32
  %4 = llvm.and %arg127, %1 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.or %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def masked_or_allones_after := [llvm|
{
^0(%arg127 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.and %arg127, %0 : i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_or_allones_proof : masked_or_allones_before ⊑ masked_or_allones_after := by
  unfold masked_or_allones_before masked_or_allones_after
  simp_alive_peephole
  intros
  ---BEGIN masked_or_allones
  all_goals (try extract_goal ; sorry)
  ---END masked_or_allones



def masked_or_allones_logical_before := [llvm|
{
^0(%arg126 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(39 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.and %arg126, %0 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = llvm.and %arg126, %1 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = "llvm.select"(%4, %2, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_or_allones_logical_after := [llvm|
{
^0(%arg126 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.and %arg126, %0 : i32
  %2 = llvm.icmp "eq" %1, %0 : i32
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_or_allones_logical_proof : masked_or_allones_logical_before ⊑ masked_or_allones_logical_after := by
  unfold masked_or_allones_logical_before masked_or_allones_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_or_allones_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_or_allones_logical



def masked_and_notA_before := [llvm|
{
^0(%arg125 : i32):
  %0 = llvm.mlir.constant(14 : i32) : i32
  %1 = llvm.mlir.constant(78 : i32) : i32
  %2 = llvm.and %arg125, %0 : i32
  %3 = llvm.icmp "ne" %2, %arg125 : i32
  %4 = llvm.and %arg125, %1 : i32
  %5 = llvm.icmp "ne" %4, %arg125 : i32
  %6 = llvm.and %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def masked_and_notA_after := [llvm|
{
^0(%arg125 : i32):
  %0 = llvm.mlir.constant(-79 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg125, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_and_notA_proof : masked_and_notA_before ⊑ masked_and_notA_after := by
  unfold masked_and_notA_before masked_and_notA_after
  simp_alive_peephole
  intros
  ---BEGIN masked_and_notA
  all_goals (try extract_goal ; sorry)
  ---END masked_and_notA



def masked_and_notA_logical_before := [llvm|
{
^0(%arg124 : i32):
  %0 = llvm.mlir.constant(14 : i32) : i32
  %1 = llvm.mlir.constant(78 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.and %arg124, %0 : i32
  %4 = llvm.icmp "ne" %3, %arg124 : i32
  %5 = llvm.and %arg124, %1 : i32
  %6 = llvm.icmp "ne" %5, %arg124 : i32
  %7 = "llvm.select"(%4, %6, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_and_notA_logical_after := [llvm|
{
^0(%arg124 : i32):
  %0 = llvm.mlir.constant(-79 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg124, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_and_notA_logical_proof : masked_and_notA_logical_before ⊑ masked_and_notA_logical_after := by
  unfold masked_and_notA_logical_before masked_and_notA_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_and_notA_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_and_notA_logical



def masked_and_notA_slightly_optimized_before := [llvm|
{
^0(%arg123 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(39 : i32) : i32
  %2 = llvm.icmp "uge" %arg123, %0 : i32
  %3 = llvm.and %arg123, %1 : i32
  %4 = llvm.icmp "ne" %3, %arg123 : i32
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def masked_and_notA_slightly_optimized_after := [llvm|
{
^0(%arg123 : i32):
  %0 = llvm.mlir.constant(-40 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg123, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_and_notA_slightly_optimized_proof : masked_and_notA_slightly_optimized_before ⊑ masked_and_notA_slightly_optimized_after := by
  unfold masked_and_notA_slightly_optimized_before masked_and_notA_slightly_optimized_after
  simp_alive_peephole
  intros
  ---BEGIN masked_and_notA_slightly_optimized
  all_goals (try extract_goal ; sorry)
  ---END masked_and_notA_slightly_optimized



def masked_and_notA_slightly_optimized_logical_before := [llvm|
{
^0(%arg122 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(39 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "uge" %arg122, %0 : i32
  %4 = llvm.and %arg122, %1 : i32
  %5 = llvm.icmp "ne" %4, %arg122 : i32
  %6 = "llvm.select"(%3, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def masked_and_notA_slightly_optimized_logical_after := [llvm|
{
^0(%arg122 : i32):
  %0 = llvm.mlir.constant(-40 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg122, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_and_notA_slightly_optimized_logical_proof : masked_and_notA_slightly_optimized_logical_before ⊑ masked_and_notA_slightly_optimized_logical_after := by
  unfold masked_and_notA_slightly_optimized_logical_before masked_and_notA_slightly_optimized_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_and_notA_slightly_optimized_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_and_notA_slightly_optimized_logical



def masked_or_A_before := [llvm|
{
^0(%arg121 : i32):
  %0 = llvm.mlir.constant(14 : i32) : i32
  %1 = llvm.mlir.constant(78 : i32) : i32
  %2 = llvm.and %arg121, %0 : i32
  %3 = llvm.icmp "eq" %2, %arg121 : i32
  %4 = llvm.and %arg121, %1 : i32
  %5 = llvm.icmp "eq" %4, %arg121 : i32
  %6 = llvm.or %3, %5 : i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def masked_or_A_after := [llvm|
{
^0(%arg121 : i32):
  %0 = llvm.mlir.constant(-79 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg121, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_or_A_proof : masked_or_A_before ⊑ masked_or_A_after := by
  unfold masked_or_A_before masked_or_A_after
  simp_alive_peephole
  intros
  ---BEGIN masked_or_A
  all_goals (try extract_goal ; sorry)
  ---END masked_or_A



def masked_or_A_logical_before := [llvm|
{
^0(%arg120 : i32):
  %0 = llvm.mlir.constant(14 : i32) : i32
  %1 = llvm.mlir.constant(78 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.and %arg120, %0 : i32
  %4 = llvm.icmp "eq" %3, %arg120 : i32
  %5 = llvm.and %arg120, %1 : i32
  %6 = llvm.icmp "eq" %5, %arg120 : i32
  %7 = "llvm.select"(%4, %2, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_or_A_logical_after := [llvm|
{
^0(%arg120 : i32):
  %0 = llvm.mlir.constant(-79 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg120, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_or_A_logical_proof : masked_or_A_logical_before ⊑ masked_or_A_logical_after := by
  unfold masked_or_A_logical_before masked_or_A_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_or_A_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_or_A_logical



def masked_or_A_slightly_optimized_before := [llvm|
{
^0(%arg119 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(39 : i32) : i32
  %2 = llvm.icmp "ult" %arg119, %0 : i32
  %3 = llvm.and %arg119, %1 : i32
  %4 = llvm.icmp "eq" %3, %arg119 : i32
  %5 = llvm.or %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def masked_or_A_slightly_optimized_after := [llvm|
{
^0(%arg119 : i32):
  %0 = llvm.mlir.constant(-40 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg119, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_or_A_slightly_optimized_proof : masked_or_A_slightly_optimized_before ⊑ masked_or_A_slightly_optimized_after := by
  unfold masked_or_A_slightly_optimized_before masked_or_A_slightly_optimized_after
  simp_alive_peephole
  intros
  ---BEGIN masked_or_A_slightly_optimized
  all_goals (try extract_goal ; sorry)
  ---END masked_or_A_slightly_optimized



def masked_or_A_slightly_optimized_logical_before := [llvm|
{
^0(%arg118 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(39 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "ult" %arg118, %0 : i32
  %4 = llvm.and %arg118, %1 : i32
  %5 = llvm.icmp "eq" %4, %arg118 : i32
  %6 = "llvm.select"(%3, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def masked_or_A_slightly_optimized_logical_after := [llvm|
{
^0(%arg118 : i32):
  %0 = llvm.mlir.constant(-40 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg118, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_or_A_slightly_optimized_logical_proof : masked_or_A_slightly_optimized_logical_before ⊑ masked_or_A_slightly_optimized_logical_after := by
  unfold masked_or_A_slightly_optimized_logical_before masked_or_A_slightly_optimized_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_or_A_slightly_optimized_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_or_A_slightly_optimized_logical



def masked_or_allzeroes_notoptimised_logical_before := [llvm|
{
^0(%arg116 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(39 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.and %arg116, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg116, %2 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = "llvm.select"(%5, %3, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_or_allzeroes_notoptimised_logical_after := [llvm|
{
^0(%arg116 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(39 : i32) : i32
  %3 = llvm.and %arg116, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg116, %2 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_or_allzeroes_notoptimised_logical_proof : masked_or_allzeroes_notoptimised_logical_before ⊑ masked_or_allzeroes_notoptimised_logical_after := by
  unfold masked_or_allzeroes_notoptimised_logical_before masked_or_allzeroes_notoptimised_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_or_allzeroes_notoptimised_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_or_allzeroes_notoptimised_logical



def nomask_lhs_before := [llvm|
{
^0(%arg115 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.icmp "eq" %arg115, %0 : i32
  %3 = llvm.and %arg115, %1 : i32
  %4 = llvm.icmp "eq" %3, %0 : i32
  %5 = llvm.or %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def nomask_lhs_after := [llvm|
{
^0(%arg115 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg115, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nomask_lhs_proof : nomask_lhs_before ⊑ nomask_lhs_after := by
  unfold nomask_lhs_before nomask_lhs_after
  simp_alive_peephole
  intros
  ---BEGIN nomask_lhs
  all_goals (try extract_goal ; sorry)
  ---END nomask_lhs



def nomask_lhs_logical_before := [llvm|
{
^0(%arg114 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.mlir.constant(1 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "eq" %arg114, %0 : i32
  %4 = llvm.and %arg114, %1 : i32
  %5 = llvm.icmp "eq" %4, %0 : i32
  %6 = "llvm.select"(%3, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def nomask_lhs_logical_after := [llvm|
{
^0(%arg114 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg114, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nomask_lhs_logical_proof : nomask_lhs_logical_before ⊑ nomask_lhs_logical_after := by
  unfold nomask_lhs_logical_before nomask_lhs_logical_after
  simp_alive_peephole
  intros
  ---BEGIN nomask_lhs_logical
  all_goals (try extract_goal ; sorry)
  ---END nomask_lhs_logical



def nomask_rhs_before := [llvm|
{
^0(%arg113 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg113, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.icmp "eq" %arg113, %1 : i32
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def nomask_rhs_after := [llvm|
{
^0(%arg113 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg113, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nomask_rhs_proof : nomask_rhs_before ⊑ nomask_rhs_after := by
  unfold nomask_rhs_before nomask_rhs_after
  simp_alive_peephole
  intros
  ---BEGIN nomask_rhs
  all_goals (try extract_goal ; sorry)
  ---END nomask_rhs



def nomask_rhs_logical_before := [llvm|
{
^0(%arg112 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.and %arg112, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.icmp "eq" %arg112, %1 : i32
  %6 = "llvm.select"(%4, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def nomask_rhs_logical_after := [llvm|
{
^0(%arg112 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg112, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem nomask_rhs_logical_proof : nomask_rhs_logical_before ⊑ nomask_rhs_logical_after := by
  unfold nomask_rhs_logical_before nomask_rhs_logical_after
  simp_alive_peephole
  intros
  ---BEGIN nomask_rhs_logical
  all_goals (try extract_goal ; sorry)
  ---END nomask_rhs_logical



def fold_mask_cmps_to_false_before := [llvm|
{
^0(%arg111 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg111, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  %4 = llvm.icmp "eq" %arg111, %0 : i32
  %5 = llvm.and %4, %3 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def fold_mask_cmps_to_false_after := [llvm|
{
^0(%arg111 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_mask_cmps_to_false_proof : fold_mask_cmps_to_false_before ⊑ fold_mask_cmps_to_false_after := by
  unfold fold_mask_cmps_to_false_before fold_mask_cmps_to_false_after
  simp_alive_peephole
  intros
  ---BEGIN fold_mask_cmps_to_false
  all_goals (try extract_goal ; sorry)
  ---END fold_mask_cmps_to_false



def fold_mask_cmps_to_false_logical_before := [llvm|
{
^0(%arg110 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.and %arg110, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.icmp "eq" %arg110, %0 : i32
  %6 = "llvm.select"(%5, %4, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def fold_mask_cmps_to_false_logical_after := [llvm|
{
^0(%arg110 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_mask_cmps_to_false_logical_proof : fold_mask_cmps_to_false_logical_before ⊑ fold_mask_cmps_to_false_logical_after := by
  unfold fold_mask_cmps_to_false_logical_before fold_mask_cmps_to_false_logical_after
  simp_alive_peephole
  intros
  ---BEGIN fold_mask_cmps_to_false_logical
  all_goals (try extract_goal ; sorry)
  ---END fold_mask_cmps_to_false_logical



def fold_mask_cmps_to_true_before := [llvm|
{
^0(%arg109 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.and %arg109, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  %4 = llvm.icmp "ne" %arg109, %0 : i32
  %5 = llvm.or %4, %3 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def fold_mask_cmps_to_true_after := [llvm|
{
^0(%arg109 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_mask_cmps_to_true_proof : fold_mask_cmps_to_true_before ⊑ fold_mask_cmps_to_true_after := by
  unfold fold_mask_cmps_to_true_before fold_mask_cmps_to_true_after
  simp_alive_peephole
  intros
  ---BEGIN fold_mask_cmps_to_true
  all_goals (try extract_goal ; sorry)
  ---END fold_mask_cmps_to_true



def fold_mask_cmps_to_true_logical_before := [llvm|
{
^0(%arg108 : i32):
  %0 = llvm.mlir.constant(2147483647 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.and %arg108, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.icmp "ne" %arg108, %0 : i32
  %6 = "llvm.select"(%5, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def fold_mask_cmps_to_true_logical_after := [llvm|
{
^0(%arg108 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem fold_mask_cmps_to_true_logical_proof : fold_mask_cmps_to_true_logical_before ⊑ fold_mask_cmps_to_true_logical_after := by
  unfold fold_mask_cmps_to_true_logical_before fold_mask_cmps_to_true_logical_after
  simp_alive_peephole
  intros
  ---BEGIN fold_mask_cmps_to_true_logical
  all_goals (try extract_goal ; sorry)
  ---END fold_mask_cmps_to_true_logical



def cmpeq_bitwise_before := [llvm|
{
^0(%arg102 : i8, %arg103 : i8, %arg104 : i8, %arg105 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.xor %arg102, %arg103 : i8
  %2 = llvm.xor %arg104, %arg105 : i8
  %3 = llvm.or %1, %2 : i8
  %4 = llvm.icmp "eq" %3, %0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def cmpeq_bitwise_after := [llvm|
{
^0(%arg102 : i8, %arg103 : i8, %arg104 : i8, %arg105 : i8):
  %0 = llvm.icmp "eq" %arg102, %arg103 : i8
  %1 = llvm.icmp "eq" %arg104, %arg105 : i8
  %2 = llvm.and %0, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem cmpeq_bitwise_proof : cmpeq_bitwise_before ⊑ cmpeq_bitwise_after := by
  unfold cmpeq_bitwise_before cmpeq_bitwise_after
  simp_alive_peephole
  intros
  ---BEGIN cmpeq_bitwise
  all_goals (try extract_goal ; sorry)
  ---END cmpeq_bitwise



def masked_icmps_mask_notallzeros_bmask_mixed_0_logical_before := [llvm|
{
^0(%arg96 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg96, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg96, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  %9 = "llvm.select"(%6, %8, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_0_logical_after := [llvm|
{
^0(%arg96 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg96, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg96, %2 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_0_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_0_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_0_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_0_logical_before masked_icmps_mask_notallzeros_bmask_mixed_0_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_0_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_0_logical



def masked_icmps_mask_notallzeros_bmask_mixed_1_before := [llvm|
{
^0(%arg95 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg95, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg95, %2 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_1_after := [llvm|
{
^0(%arg95 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.and %arg95, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_1_proof : masked_icmps_mask_notallzeros_bmask_mixed_1_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_1_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_1_before masked_icmps_mask_notallzeros_bmask_mixed_1_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_1
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_1



def masked_icmps_mask_notallzeros_bmask_mixed_1_logical_before := [llvm|
{
^0(%arg93 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg93, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg93, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  %9 = "llvm.select"(%6, %8, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_1_logical_after := [llvm|
{
^0(%arg93 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.and %arg93, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_1_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_1_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_1_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_1_logical_before masked_icmps_mask_notallzeros_bmask_mixed_1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_1_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_1_logical



def masked_icmps_mask_notallzeros_bmask_mixed_1b_logical_before := [llvm|
{
^0(%arg91 : i32):
  %0 = llvm.mlir.constant(14 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg91, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg91, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  %9 = "llvm.select"(%6, %8, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_1b_logical_after := [llvm|
{
^0(%arg91 : i32):
  %0 = llvm.mlir.constant(14 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg91, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg91, %2 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_1b_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_1b_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_1b_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_1b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_1b_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_1b_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_1b_logical



def masked_icmps_mask_notallzeros_bmask_mixed_2_before := [llvm|
{
^0(%arg90 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.and %arg90, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %arg90, %2 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_2_after := [llvm|
{
^0(%arg90 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_2_proof : masked_icmps_mask_notallzeros_bmask_mixed_2_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_2_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_2_before masked_icmps_mask_notallzeros_bmask_mixed_2_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_2
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_2



def masked_icmps_mask_notallzeros_bmask_mixed_2_logical_before := [llvm|
{
^0(%arg89 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.and %arg89, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg89, %2 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = "llvm.select"(%5, %7, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_2_logical_after := [llvm|
{
^0(%arg89 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_2_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_2_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_2_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_2_logical_before masked_icmps_mask_notallzeros_bmask_mixed_2_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_2_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_2_logical



def masked_icmps_mask_notallzeros_bmask_mixed_3_before := [llvm|
{
^0(%arg88 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.and %arg88, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %arg88, %2 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_3_after := [llvm|
{
^0(%arg88 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg88, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_3_proof : masked_icmps_mask_notallzeros_bmask_mixed_3_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_3_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_3_before masked_icmps_mask_notallzeros_bmask_mixed_3_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_3
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_3



def masked_icmps_mask_notallzeros_bmask_mixed_3_logical_before := [llvm|
{
^0(%arg87 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.and %arg87, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg87, %2 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = "llvm.select"(%5, %7, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_3_logical_after := [llvm|
{
^0(%arg87 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg87, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_3_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_3_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_3_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_3_logical_before masked_icmps_mask_notallzeros_bmask_mixed_3_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_3_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_3_logical



def masked_icmps_mask_notallzeros_bmask_mixed_3b_logical_before := [llvm|
{
^0(%arg85 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.and %arg85, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg85, %2 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = "llvm.select"(%5, %7, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_3b_logical_after := [llvm|
{
^0(%arg85 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.and %arg85, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %arg85, %2 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_3b_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_3b_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_3b_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_3b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_3b_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_3b_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_3b_logical



def masked_icmps_mask_notallzeros_bmask_mixed_4_before := [llvm|
{
^0(%arg84 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.and %arg84, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg84, %2 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_4_after := [llvm|
{
^0(%arg84 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg84, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_4_proof : masked_icmps_mask_notallzeros_bmask_mixed_4_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_4_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_4_before masked_icmps_mask_notallzeros_bmask_mixed_4_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_4
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_4



def masked_icmps_mask_notallzeros_bmask_mixed_4_logical_before := [llvm|
{
^0(%arg83 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg83, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg83, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  %9 = "llvm.select"(%6, %8, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_4_logical_after := [llvm|
{
^0(%arg83 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg83, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_4_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_4_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_4_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_4_logical_before masked_icmps_mask_notallzeros_bmask_mixed_4_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_4_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_4_logical



def masked_icmps_mask_notallzeros_bmask_mixed_5_before := [llvm|
{
^0(%arg82 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.and %arg82, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %arg82, %0 : i32
  %6 = llvm.icmp "eq" %5, %2 : i32
  %7 = llvm.and %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_5_after := [llvm|
{
^0(%arg82 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg82, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_5_proof : masked_icmps_mask_notallzeros_bmask_mixed_5_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_5_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_5_before masked_icmps_mask_notallzeros_bmask_mixed_5_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_5
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_5



def masked_icmps_mask_notallzeros_bmask_mixed_5_logical_before := [llvm|
{
^0(%arg81 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.and %arg81, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg81, %0 : i32
  %7 = llvm.icmp "eq" %6, %2 : i32
  %8 = "llvm.select"(%5, %7, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_5_logical_after := [llvm|
{
^0(%arg81 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg81, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_5_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_5_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_5_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_5_logical_before masked_icmps_mask_notallzeros_bmask_mixed_5_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_5_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_5_logical



def masked_icmps_mask_notallzeros_bmask_mixed_6_before := [llvm|
{
^0(%arg80 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.and %arg80, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg80, %2 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_6_after := [llvm|
{
^0(%arg80 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg80, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_6_proof : masked_icmps_mask_notallzeros_bmask_mixed_6_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_6_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_6_before masked_icmps_mask_notallzeros_bmask_mixed_6_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_6
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_6



def masked_icmps_mask_notallzeros_bmask_mixed_6_logical_before := [llvm|
{
^0(%arg79 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg79, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg79, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  %9 = "llvm.select"(%6, %8, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_6_logical_after := [llvm|
{
^0(%arg79 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg79, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_6_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_6_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_6_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_6_logical_before masked_icmps_mask_notallzeros_bmask_mixed_6_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_6_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_6_logical



def masked_icmps_mask_notallzeros_bmask_mixed_7_before := [llvm|
{
^0(%arg78 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.and %arg78, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg78, %2 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_7_after := [llvm|
{
^0(%arg78 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_7_proof : masked_icmps_mask_notallzeros_bmask_mixed_7_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_7_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_7_before masked_icmps_mask_notallzeros_bmask_mixed_7_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_7
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_7



def masked_icmps_mask_notallzeros_bmask_mixed_7_logical_before := [llvm|
{
^0(%arg77 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg77, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg77, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  %9 = "llvm.select"(%6, %8, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_7_logical_after := [llvm|
{
^0(%arg77 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_7_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_7_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_7_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_7_logical_before masked_icmps_mask_notallzeros_bmask_mixed_7_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_7_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_7_logical



def masked_icmps_mask_notallzeros_bmask_mixed_7b_before := [llvm|
{
^0(%arg76 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.and %arg76, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg76, %2 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_7b_after := [llvm|
{
^0(%arg76 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_7b_proof : masked_icmps_mask_notallzeros_bmask_mixed_7b_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_7b_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_7b_before masked_icmps_mask_notallzeros_bmask_mixed_7b_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_7b
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_7b



def masked_icmps_mask_notallzeros_bmask_mixed_7b_logical_before := [llvm|
{
^0(%arg75 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg75, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg75, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  %9 = "llvm.select"(%6, %8, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_7b_logical_after := [llvm|
{
^0(%arg75 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_7b_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_7b_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_7b_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_7b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_7b_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_7b_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_7b_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical_before := [llvm|
{
^0(%arg73 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.and %arg73, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg73, %2 : i32
  %8 = llvm.icmp "ne" %7, %3 : i32
  %9 = "llvm.select"(%6, %4, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical_after := [llvm|
{
^0(%arg73 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg73, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg73, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_0_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_1_before := [llvm|
{
^0(%arg72 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg72, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg72, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_1_after := [llvm|
{
^0(%arg72 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.and %arg72, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_1_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_1_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_1_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_1_before masked_icmps_mask_notallzeros_bmask_mixed_negated_1_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_1
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_1



def masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical_before := [llvm|
{
^0(%arg71 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.and %arg71, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg71, %2 : i32
  %8 = llvm.icmp "ne" %7, %3 : i32
  %9 = "llvm.select"(%6, %4, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical_after := [llvm|
{
^0(%arg71 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.and %arg71, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_1_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical_before := [llvm|
{
^0(%arg69 : i32):
  %0 = llvm.mlir.constant(14 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.and %arg69, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg69, %2 : i32
  %8 = llvm.icmp "ne" %7, %3 : i32
  %9 = "llvm.select"(%6, %4, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical_after := [llvm|
{
^0(%arg69 : i32):
  %0 = llvm.mlir.constant(14 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg69, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg69, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_1b_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_2_before := [llvm|
{
^0(%arg68 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.and %arg68, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg68, %2 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_2_after := [llvm|
{
^0(%arg68 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_2_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_2_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_2_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_2_before masked_icmps_mask_notallzeros_bmask_mixed_negated_2_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_2
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_2



def masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical_before := [llvm|
{
^0(%arg67 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.and %arg67, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg67, %2 : i32
  %7 = llvm.icmp "ne" %6, %1 : i32
  %8 = "llvm.select"(%5, %3, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical_after := [llvm|
{
^0(%arg67 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_2_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_3_before := [llvm|
{
^0(%arg66 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.and %arg66, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg66, %2 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_3_after := [llvm|
{
^0(%arg66 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg66, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_3_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_3_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_3_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_3_before masked_icmps_mask_notallzeros_bmask_mixed_negated_3_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_3
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_3



def masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical_before := [llvm|
{
^0(%arg65 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.and %arg65, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg65, %2 : i32
  %7 = llvm.icmp "ne" %6, %1 : i32
  %8 = "llvm.select"(%5, %3, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical_after := [llvm|
{
^0(%arg65 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg65, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_3_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical_before := [llvm|
{
^0(%arg63 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.and %arg63, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg63, %2 : i32
  %7 = llvm.icmp "ne" %6, %1 : i32
  %8 = "llvm.select"(%5, %3, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical_after := [llvm|
{
^0(%arg63 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.and %arg63, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg63, %2 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_3b_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_4_before := [llvm|
{
^0(%arg62 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.and %arg62, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg62, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_4_after := [llvm|
{
^0(%arg62 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg62, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_4_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_4_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_4_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_4_before masked_icmps_mask_notallzeros_bmask_mixed_negated_4_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_4
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_4



def masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical_before := [llvm|
{
^0(%arg61 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.and %arg61, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg61, %2 : i32
  %8 = llvm.icmp "ne" %7, %3 : i32
  %9 = "llvm.select"(%6, %4, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical_after := [llvm|
{
^0(%arg61 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg61, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_4_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_5_before := [llvm|
{
^0(%arg60 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.and %arg60, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg60, %0 : i32
  %6 = llvm.icmp "ne" %5, %2 : i32
  %7 = llvm.or %4, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_5_after := [llvm|
{
^0(%arg60 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg60, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_5_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_5_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_5_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_5_before masked_icmps_mask_notallzeros_bmask_mixed_negated_5_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_5
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_5



def masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical_before := [llvm|
{
^0(%arg59 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.and %arg59, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg59, %0 : i32
  %7 = llvm.icmp "ne" %6, %2 : i32
  %8 = "llvm.select"(%5, %3, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical_after := [llvm|
{
^0(%arg59 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg59, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_5_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_6_before := [llvm|
{
^0(%arg58 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.and %arg58, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg58, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_6_after := [llvm|
{
^0(%arg58 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg58, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_6_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_6_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_6_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_6_before masked_icmps_mask_notallzeros_bmask_mixed_negated_6_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_6
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_6



def masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical_before := [llvm|
{
^0(%arg57 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.and %arg57, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg57, %2 : i32
  %8 = llvm.icmp "ne" %7, %3 : i32
  %9 = "llvm.select"(%6, %4, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical_after := [llvm|
{
^0(%arg57 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg57, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_6_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_7_before := [llvm|
{
^0(%arg56 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.and %arg56, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg56, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_7_after := [llvm|
{
^0(%arg56 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_7_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_7_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_7_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_7_before masked_icmps_mask_notallzeros_bmask_mixed_negated_7_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_7
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_7



def masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical_before := [llvm|
{
^0(%arg55 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.and %arg55, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg55, %2 : i32
  %8 = llvm.icmp "ne" %7, %3 : i32
  %9 = "llvm.select"(%6, %4, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical_after := [llvm|
{
^0(%arg55 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_7_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_before := [llvm|
{
^0(%arg54 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.and %arg54, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg54, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_after := [llvm|
{
^0(%arg54 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_before masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_7b
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_7b



def masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical_before := [llvm|
{
^0(%arg53 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.and %arg53, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg53, %2 : i32
  %8 = llvm.icmp "ne" %7, %3 : i32
  %9 = "llvm.select"(%6, %4, %8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical_after := [llvm|
{
^0(%arg53 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_7b_logical



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical_before := [llvm|
{
^0(%arg51 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg51, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg51, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  %9 = "llvm.select"(%8, %6, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical_after := [llvm|
{
^0(%arg51 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg51, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg51, %2 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.and %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_0_logical



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_before := [llvm|
{
^0(%arg50 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg50, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg50, %2 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.and %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_after := [llvm|
{
^0(%arg50 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.and %arg50, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_1
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_1



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical_before := [llvm|
{
^0(%arg49 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg49, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg49, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  %9 = "llvm.select"(%8, %6, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical_after := [llvm|
{
^0(%arg49 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.and %arg49, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_1_logical



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical_before := [llvm|
{
^0(%arg47 : i32):
  %0 = llvm.mlir.constant(14 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg47, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg47, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  %9 = "llvm.select"(%8, %6, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical_after := [llvm|
{
^0(%arg47 : i32):
  %0 = llvm.mlir.constant(14 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg47, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg47, %2 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.and %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_1b_logical



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_before := [llvm|
{
^0(%arg46 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.and %arg46, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %arg46, %2 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %6, %4 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_after := [llvm|
{
^0(%arg46 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_2
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_2



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical_before := [llvm|
{
^0(%arg45 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.and %arg45, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg45, %2 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = "llvm.select"(%7, %5, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical_after := [llvm|
{
^0(%arg45 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_2_logical



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_before := [llvm|
{
^0(%arg44 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.and %arg44, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %arg44, %2 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %6, %4 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_after := [llvm|
{
^0(%arg44 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg44, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_3
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_3



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical_before := [llvm|
{
^0(%arg43 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.and %arg43, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg43, %2 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = "llvm.select"(%7, %5, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical_after := [llvm|
{
^0(%arg43 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg43, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_3_logical



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical_before := [llvm|
{
^0(%arg41 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.and %arg41, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg41, %2 : i32
  %7 = llvm.icmp "eq" %6, %1 : i32
  %8 = "llvm.select"(%7, %5, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical_after := [llvm|
{
^0(%arg41 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.and %arg41, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %arg41, %2 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %6, %4 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_3b_logical



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_before := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.and %arg40, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg40, %2 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.and %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_after := [llvm|
{
^0(%arg40 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg40, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_4
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_4



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical_before := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg39, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg39, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  %9 = "llvm.select"(%8, %6, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical_after := [llvm|
{
^0(%arg39 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg39, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_4_logical



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_before := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.and %arg38, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  %5 = llvm.and %arg38, %0 : i32
  %6 = llvm.icmp "eq" %5, %2 : i32
  %7 = llvm.and %6, %4 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_after := [llvm|
{
^0(%arg38 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg38, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_5
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_5



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical_before := [llvm|
{
^0(%arg37 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.mlir.constant(false) : i1
  %4 = llvm.and %arg37, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg37, %0 : i32
  %7 = llvm.icmp "eq" %6, %2 : i32
  %8 = "llvm.select"(%7, %5, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical_after := [llvm|
{
^0(%arg37 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg37, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_5_logical



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_before := [llvm|
{
^0(%arg36 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.and %arg36, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg36, %2 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.and %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_after := [llvm|
{
^0(%arg36 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg36, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_6
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_6



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical_before := [llvm|
{
^0(%arg35 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg35, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg35, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  %9 = "llvm.select"(%8, %6, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical_after := [llvm|
{
^0(%arg35 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg35, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_6_logical



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_before := [llvm|
{
^0(%arg34 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.and %arg34, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg34, %2 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.and %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_after := [llvm|
{
^0(%arg34 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_7
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_7



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical_before := [llvm|
{
^0(%arg33 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg33, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg33, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  %9 = "llvm.select"(%8, %6, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical_after := [llvm|
{
^0(%arg33 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_7_logical



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_before := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.and %arg32, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg32, %2 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.and %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_after := [llvm|
{
^0(%arg32 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b



def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical_before := [llvm|
{
^0(%arg31 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.mlir.constant(false) : i1
  %5 = llvm.and %arg31, %0 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.and %arg31, %2 : i32
  %8 = llvm.icmp "eq" %7, %3 : i32
  %9 = "llvm.select"(%8, %6, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical_after := [llvm|
{
^0(%arg31 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_swapped_7b_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical_before := [llvm|
{
^0(%arg29 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.and %arg29, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg29, %2 : i32
  %8 = llvm.icmp "ne" %7, %3 : i32
  %9 = "llvm.select"(%8, %4, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical_after := [llvm|
{
^0(%arg29 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg29, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg29, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.or %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_0_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_before := [llvm|
{
^0(%arg28 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg28, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg28, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.or %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_after := [llvm|
{
^0(%arg28 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.and %arg28, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical_before := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.and %arg27, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg27, %2 : i32
  %8 = llvm.icmp "ne" %7, %3 : i32
  %9 = "llvm.select"(%8, %4, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical_after := [llvm|
{
^0(%arg27 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(9 : i32) : i32
  %2 = llvm.and %arg27, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical_before := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(14 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.and %arg25, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg25, %2 : i32
  %8 = llvm.icmp "ne" %7, %3 : i32
  %9 = "llvm.select"(%8, %4, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical_after := [llvm|
{
^0(%arg25 : i32):
  %0 = llvm.mlir.constant(14 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(1 : i32) : i32
  %4 = llvm.and %arg25, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg25, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.or %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_1b_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_before := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.and %arg24, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg24, %2 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.or %6, %4 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_after := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical_before := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.and %arg23, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg23, %2 : i32
  %7 = llvm.icmp "ne" %6, %1 : i32
  %8 = "llvm.select"(%7, %3, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical_after := [llvm|
{
^0(%arg23 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_2_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_before := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.and %arg22, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg22, %2 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.or %6, %4 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_after := [llvm|
{
^0(%arg22 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg22, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical_before := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(7 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.and %arg21, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg21, %2 : i32
  %7 = llvm.icmp "ne" %6, %1 : i32
  %8 = "llvm.select"(%7, %3, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical_after := [llvm|
{
^0(%arg21 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg21, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical_before := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.and %arg19, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg19, %2 : i32
  %7 = llvm.icmp "ne" %6, %1 : i32
  %8 = "llvm.select"(%7, %3, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical_after := [llvm|
{
^0(%arg19 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(3 : i32) : i32
  %3 = llvm.and %arg19, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg19, %2 : i32
  %6 = llvm.icmp "ne" %5, %1 : i32
  %7 = llvm.or %6, %4 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_3b_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_before := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.and %arg18, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg18, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.or %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_after := [llvm|
{
^0(%arg18 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg18, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical_before := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.and %arg17, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg17, %2 : i32
  %8 = llvm.icmp "ne" %7, %3 : i32
  %9 = "llvm.select"(%8, %4, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical_after := [llvm|
{
^0(%arg17 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg17, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_4_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_before := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.and %arg16, %0 : i32
  %4 = llvm.icmp "eq" %3, %1 : i32
  %5 = llvm.and %arg16, %0 : i32
  %6 = llvm.icmp "ne" %5, %2 : i32
  %7 = llvm.or %6, %4 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_after := [llvm|
{
^0(%arg16 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg16, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical_before := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(8 : i32) : i32
  %3 = llvm.mlir.constant(true) : i1
  %4 = llvm.and %arg15, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg15, %0 : i32
  %7 = llvm.icmp "ne" %6, %2 : i32
  %8 = "llvm.select"(%7, %3, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical_after := [llvm|
{
^0(%arg15 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg15, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_5_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_before := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.and %arg14, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg14, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.or %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_after := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg14, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical_before := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.and %arg13, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg13, %2 : i32
  %8 = llvm.icmp "ne" %7, %3 : i32
  %9 = "llvm.select"(%8, %4, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical_after := [llvm|
{
^0(%arg13 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg13, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_6_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_before := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.and %arg12, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg12, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.or %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_after := [llvm|
{
^0(%arg12 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical_before := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.and %arg11, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg11, %2 : i32
  %8 = llvm.icmp "ne" %7, %3 : i32
  %9 = "llvm.select"(%8, %4, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical_after := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7_logical



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_before := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.and %arg10, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg10, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.or %7, %5 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_after := [llvm|
{
^0(%arg10 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b



def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical_before := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(6 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.mlir.constant(15 : i32) : i32
  %3 = llvm.mlir.constant(8 : i32) : i32
  %4 = llvm.mlir.constant(true) : i1
  %5 = llvm.and %arg9, %0 : i32
  %6 = llvm.icmp "eq" %5, %1 : i32
  %7 = llvm.and %arg9, %2 : i32
  %8 = llvm.icmp "ne" %7, %3 : i32
  %9 = "llvm.select"(%8, %4, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%9) : (i1) -> ()
}
]
def masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical_after := [llvm|
{
^0(%arg9 : i32):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical_proof : masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical_before ⊑ masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical_after := by
  unfold masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical_before masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_mask_notallzeros_bmask_mixed_negated_swapped_7b_logical



def masked_icmps_bmask_notmixed_or_before := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(255 : i32) : i32
  %3 = llvm.mlir.constant(243 : i32) : i32
  %4 = llvm.and %arg8, %0 : i32
  %5 = llvm.icmp "eq" %4, %1 : i32
  %6 = llvm.and %arg8, %2 : i32
  %7 = llvm.icmp "eq" %6, %3 : i32
  %8 = llvm.or %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_bmask_notmixed_or_after := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.and %arg8, %0 : i32
  %3 = llvm.icmp "eq" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_bmask_notmixed_or_proof : masked_icmps_bmask_notmixed_or_before ⊑ masked_icmps_bmask_notmixed_or_after := by
  unfold masked_icmps_bmask_notmixed_or_before masked_icmps_bmask_notmixed_or_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_bmask_notmixed_or
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_bmask_notmixed_or



def masked_icmps_bmask_notmixed_and_before := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.mlir.constant(255 : i32) : i32
  %3 = llvm.mlir.constant(243 : i32) : i32
  %4 = llvm.and %arg3, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg3, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_bmask_notmixed_and_after := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.and %arg3, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_bmask_notmixed_and_proof : masked_icmps_bmask_notmixed_and_before ⊑ masked_icmps_bmask_notmixed_and_after := by
  unfold masked_icmps_bmask_notmixed_and_before masked_icmps_bmask_notmixed_and_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_bmask_notmixed_and
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_bmask_notmixed_and



def masked_icmps_bmask_notmixed_and_expected_false_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.mlir.constant(15 : i32) : i32
  %2 = llvm.mlir.constant(255 : i32) : i32
  %3 = llvm.mlir.constant(242 : i32) : i32
  %4 = llvm.and %arg1, %0 : i32
  %5 = llvm.icmp "ne" %4, %1 : i32
  %6 = llvm.and %arg1, %2 : i32
  %7 = llvm.icmp "ne" %6, %3 : i32
  %8 = llvm.and %5, %7 : i1
  "llvm.return"(%8) : (i1) -> ()
}
]
def masked_icmps_bmask_notmixed_and_expected_false_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(242 : i32) : i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem masked_icmps_bmask_notmixed_and_expected_false_proof : masked_icmps_bmask_notmixed_and_expected_false_before ⊑ masked_icmps_bmask_notmixed_and_expected_false_after := by
  unfold masked_icmps_bmask_notmixed_and_expected_false_before masked_icmps_bmask_notmixed_and_expected_false_after
  simp_alive_peephole
  intros
  ---BEGIN masked_icmps_bmask_notmixed_and_expected_false
  all_goals (try extract_goal ; sorry)
  ---END masked_icmps_bmask_notmixed_and_expected_false


