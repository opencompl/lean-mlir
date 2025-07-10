import SSA.Projects.InstCombine.tests.proofs.gintegerhroundhuphpow2halignment_proof
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
section gintegerhroundhuphpow2halignment_statements

def t0_before := [llvm|
{
^0(%arg32 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(16 : i8) : i8
  %3 = llvm.mlir.constant(-16 : i8) : i8
  %4 = llvm.and %arg32, %0 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  %6 = llvm.add %arg32, %2 : i8
  %7 = llvm.and %6, %3 : i8
  %8 = "llvm.select"(%5, %arg32, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg32 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(-16 : i8) : i8
  %2 = llvm.add %arg32, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
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



def t1_before := [llvm|
{
^0(%arg31 : i8):
  %0 = llvm.mlir.constant(31 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(32 : i8) : i8
  %3 = llvm.mlir.constant(-32 : i8) : i8
  %4 = llvm.and %arg31, %0 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  %6 = llvm.add %arg31, %2 : i8
  %7 = llvm.and %6, %3 : i8
  %8 = "llvm.select"(%5, %arg31, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
def t1_after := [llvm|
{
^0(%arg31 : i8):
  %0 = llvm.mlir.constant(31 : i8) : i8
  %1 = llvm.mlir.constant(-32 : i8) : i8
  %2 = llvm.add %arg31, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_proof : t1_before ⊑ t1_after := by
  unfold t1_before t1_after
  simp_alive_peephole
  intros
  ---BEGIN t1
  apply t1_thm
  ---END t1



def t2_before := [llvm|
{
^0(%arg30 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(-16 : i8) : i8
  %3 = llvm.and %arg30, %0 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  %5 = llvm.add %arg30, %0 : i8
  %6 = llvm.and %5, %2 : i8
  %7 = "llvm.select"(%4, %arg30, %6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%7) : (i8) -> ()
}
]
def t2_after := [llvm|
{
^0(%arg30 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(-16 : i8) : i8
  %2 = llvm.add %arg30, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t2_proof : t2_before ⊑ t2_after := by
  unfold t2_before t2_after
  simp_alive_peephole
  intros
  ---BEGIN t2
  apply t2_thm
  ---END t2



def n9_wrong_x0_before := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(16 : i8) : i8
  %3 = llvm.mlir.constant(-16 : i8) : i8
  %4 = llvm.and %arg16, %0 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  %6 = llvm.add %arg16, %2 : i8
  %7 = llvm.and %6, %3 : i8
  %8 = "llvm.select"(%5, %arg17, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
def n9_wrong_x0_after := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(-16 : i8) : i8
  %3 = llvm.mlir.constant(16 : i8) : i8
  %4 = llvm.and %arg16, %0 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  %6 = llvm.and %arg16, %2 : i8
  %7 = llvm.add %6, %3 : i8
  %8 = "llvm.select"(%5, %arg17, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n9_wrong_x0_proof : n9_wrong_x0_before ⊑ n9_wrong_x0_after := by
  unfold n9_wrong_x0_before n9_wrong_x0_after
  simp_alive_peephole
  intros
  ---BEGIN n9_wrong_x0
  apply n9_wrong_x0_thm
  ---END n9_wrong_x0



def n9_wrong_x1_before := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(16 : i8) : i8
  %3 = llvm.mlir.constant(-16 : i8) : i8
  %4 = llvm.and %arg14, %0 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  %6 = llvm.add %arg15, %2 : i8
  %7 = llvm.and %6, %3 : i8
  %8 = "llvm.select"(%5, %arg14, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
def n9_wrong_x1_after := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(-16 : i8) : i8
  %3 = llvm.mlir.constant(16 : i8) : i8
  %4 = llvm.and %arg14, %0 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  %6 = llvm.and %arg15, %2 : i8
  %7 = llvm.add %6, %3 : i8
  %8 = "llvm.select"(%5, %arg14, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n9_wrong_x1_proof : n9_wrong_x1_before ⊑ n9_wrong_x1_after := by
  unfold n9_wrong_x1_before n9_wrong_x1_after
  simp_alive_peephole
  intros
  ---BEGIN n9_wrong_x1
  apply n9_wrong_x1_thm
  ---END n9_wrong_x1



def n9_wrong_x2_before := [llvm|
{
^0(%arg12 : i8, %arg13 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(16 : i8) : i8
  %3 = llvm.mlir.constant(-16 : i8) : i8
  %4 = llvm.and %arg13, %0 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  %6 = llvm.add %arg12, %2 : i8
  %7 = llvm.and %6, %3 : i8
  %8 = "llvm.select"(%5, %arg12, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
def n9_wrong_x2_after := [llvm|
{
^0(%arg12 : i8, %arg13 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(-16 : i8) : i8
  %3 = llvm.mlir.constant(16 : i8) : i8
  %4 = llvm.and %arg13, %0 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  %6 = llvm.and %arg12, %2 : i8
  %7 = llvm.add %6, %3 : i8
  %8 = "llvm.select"(%5, %arg12, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n9_wrong_x2_proof : n9_wrong_x2_before ⊑ n9_wrong_x2_after := by
  unfold n9_wrong_x2_before n9_wrong_x2_after
  simp_alive_peephole
  intros
  ---BEGIN n9_wrong_x2
  apply n9_wrong_x2_thm
  ---END n9_wrong_x2



def n10_wrong_low_bit_mask_before := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(31 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(16 : i8) : i8
  %3 = llvm.mlir.constant(-16 : i8) : i8
  %4 = llvm.and %arg11, %0 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  %6 = llvm.add %arg11, %2 : i8
  %7 = llvm.and %6, %3 : i8
  %8 = "llvm.select"(%5, %arg11, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
def n10_wrong_low_bit_mask_after := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(31 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(-16 : i8) : i8
  %3 = llvm.mlir.constant(16 : i8) : i8
  %4 = llvm.and %arg11, %0 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  %6 = llvm.and %arg11, %2 : i8
  %7 = llvm.add %6, %3 : i8
  %8 = "llvm.select"(%5, %arg11, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n10_wrong_low_bit_mask_proof : n10_wrong_low_bit_mask_before ⊑ n10_wrong_low_bit_mask_after := by
  unfold n10_wrong_low_bit_mask_before n10_wrong_low_bit_mask_after
  simp_alive_peephole
  intros
  ---BEGIN n10_wrong_low_bit_mask
  apply n10_wrong_low_bit_mask_thm
  ---END n10_wrong_low_bit_mask



def n12_wrong_bias_before := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(32 : i8) : i8
  %3 = llvm.mlir.constant(-16 : i8) : i8
  %4 = llvm.and %arg9, %0 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  %6 = llvm.add %arg9, %2 : i8
  %7 = llvm.and %6, %3 : i8
  %8 = "llvm.select"(%5, %arg9, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
def n12_wrong_bias_after := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(-16 : i8) : i8
  %3 = llvm.mlir.constant(32 : i8) : i8
  %4 = llvm.and %arg9, %0 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  %6 = llvm.and %arg9, %2 : i8
  %7 = llvm.add %6, %3 : i8
  %8 = "llvm.select"(%5, %arg9, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n12_wrong_bias_proof : n12_wrong_bias_before ⊑ n12_wrong_bias_after := by
  unfold n12_wrong_bias_before n12_wrong_bias_after
  simp_alive_peephole
  intros
  ---BEGIN n12_wrong_bias
  apply n12_wrong_bias_thm
  ---END n12_wrong_bias



def n14_wrong_comparison_constant_before := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(16 : i8) : i8
  %3 = llvm.mlir.constant(-16 : i8) : i8
  %4 = llvm.and %arg7, %0 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  %6 = llvm.add %arg7, %2 : i8
  %7 = llvm.and %6, %3 : i8
  %8 = "llvm.select"(%5, %arg7, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
def n14_wrong_comparison_constant_after := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(-16 : i8) : i8
  %3 = llvm.mlir.constant(16 : i8) : i8
  %4 = llvm.and %arg7, %0 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  %6 = llvm.and %arg7, %2 : i8
  %7 = llvm.add %6, %3 : i8
  %8 = "llvm.select"(%5, %arg7, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n14_wrong_comparison_constant_proof : n14_wrong_comparison_constant_before ⊑ n14_wrong_comparison_constant_after := by
  unfold n14_wrong_comparison_constant_before n14_wrong_comparison_constant_after
  simp_alive_peephole
  intros
  ---BEGIN n14_wrong_comparison_constant
  apply n14_wrong_comparison_constant_thm
  ---END n14_wrong_comparison_constant



def n15_wrong_comparison_predicate_and_constant_before := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(15 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(16 : i8) : i8
  %3 = llvm.mlir.constant(-16 : i8) : i8
  %4 = llvm.and %arg6, %0 : i8
  %5 = llvm.icmp "ult" %4, %1 : i8
  %6 = llvm.add %arg6, %2 : i8
  %7 = llvm.and %6, %3 : i8
  %8 = "llvm.select"(%5, %arg6, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
def n15_wrong_comparison_predicate_and_constant_after := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(14 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.mlir.constant(-16 : i8) : i8
  %3 = llvm.mlir.constant(16 : i8) : i8
  %4 = llvm.and %arg6, %0 : i8
  %5 = llvm.icmp "eq" %4, %1 : i8
  %6 = llvm.and %arg6, %2 : i8
  %7 = llvm.add %6, %3 : i8
  %8 = "llvm.select"(%5, %arg6, %7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%8) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n15_wrong_comparison_predicate_and_constant_proof : n15_wrong_comparison_predicate_and_constant_before ⊑ n15_wrong_comparison_predicate_and_constant_after := by
  unfold n15_wrong_comparison_predicate_and_constant_before n15_wrong_comparison_predicate_and_constant_after
  simp_alive_peephole
  intros
  ---BEGIN n15_wrong_comparison_predicate_and_constant
  apply n15_wrong_comparison_predicate_and_constant_thm
  ---END n15_wrong_comparison_predicate_and_constant


