import SSA.Projects.InstCombine.tests.proofs.gselecthicmphxor_proof
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
section gselecthicmphxor_statements

def select_icmp_eq_pow2_before := [llvm|
{
^0(%arg13 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg13, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  %4 = llvm.xor %arg13, %0 : i8
  %5 = "llvm.select"(%3, %arg13, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def select_icmp_eq_pow2_after := [llvm|
{
^0(%arg13 : i8):
  %0 = llvm.mlir.constant(-5 : i8) : i8
  %1 = llvm.and %arg13, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_eq_pow2_proof : select_icmp_eq_pow2_before ⊑ select_icmp_eq_pow2_after := by
  unfold select_icmp_eq_pow2_before select_icmp_eq_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_eq_pow2
  apply select_icmp_eq_pow2_thm
  ---END select_icmp_eq_pow2



def select_icmp_eq_pow2_flipped_before := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg12, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  %4 = llvm.xor %arg12, %0 : i8
  %5 = "llvm.select"(%3, %4, %arg12) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def select_icmp_eq_pow2_flipped_after := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.or %arg12, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_eq_pow2_flipped_proof : select_icmp_eq_pow2_flipped_before ⊑ select_icmp_eq_pow2_flipped_after := by
  unfold select_icmp_eq_pow2_flipped_before select_icmp_eq_pow2_flipped_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_eq_pow2_flipped
  apply select_icmp_eq_pow2_flipped_thm
  ---END select_icmp_eq_pow2_flipped



def select_icmp_ne_pow2_before := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg10, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  %4 = llvm.xor %arg10, %0 : i8
  %5 = "llvm.select"(%3, %4, %arg10) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def select_icmp_ne_pow2_after := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(-5 : i8) : i8
  %1 = llvm.and %arg10, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_pow2_proof : select_icmp_ne_pow2_before ⊑ select_icmp_ne_pow2_after := by
  unfold select_icmp_ne_pow2_before select_icmp_ne_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_pow2
  apply select_icmp_ne_pow2_thm
  ---END select_icmp_ne_pow2



def select_icmp_ne_pow2_flipped_before := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg9, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  %4 = llvm.xor %arg9, %0 : i8
  %5 = "llvm.select"(%3, %arg9, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def select_icmp_ne_pow2_flipped_after := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.or %arg9, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_pow2_flipped_proof : select_icmp_ne_pow2_flipped_before ⊑ select_icmp_ne_pow2_flipped_after := by
  unfold select_icmp_ne_pow2_flipped_before select_icmp_ne_pow2_flipped_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_pow2_flipped
  apply select_icmp_ne_pow2_flipped_thm
  ---END select_icmp_ne_pow2_flipped



def select_icmp_ne_not_pow2_before := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg8, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  %4 = llvm.xor %arg8, %0 : i8
  %5 = "llvm.select"(%3, %4, %arg8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def select_icmp_ne_not_pow2_after := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg8, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  %4 = llvm.xor %arg8, %0 : i8
  %5 = "llvm.select"(%3, %arg8, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_ne_not_pow2_proof : select_icmp_ne_not_pow2_before ⊑ select_icmp_ne_not_pow2_after := by
  unfold select_icmp_ne_not_pow2_before select_icmp_ne_not_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_ne_not_pow2
  apply select_icmp_ne_not_pow2_thm
  ---END select_icmp_ne_not_pow2



def select_icmp_slt_zero_smin_before := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.icmp "slt" %arg7, %0 : i8
  %3 = llvm.xor %arg7, %1 : i8
  %4 = "llvm.select"(%2, %arg7, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def select_icmp_slt_zero_smin_after := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.or %arg7, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_slt_zero_smin_proof : select_icmp_slt_zero_smin_before ⊑ select_icmp_slt_zero_smin_after := by
  unfold select_icmp_slt_zero_smin_before select_icmp_slt_zero_smin_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_slt_zero_smin
  apply select_icmp_slt_zero_smin_thm
  ---END select_icmp_slt_zero_smin



def select_icmp_slt_zero_smin_flipped_before := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.icmp "slt" %arg6, %0 : i8
  %3 = llvm.xor %arg6, %1 : i8
  %4 = "llvm.select"(%2, %3, %arg6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def select_icmp_slt_zero_smin_flipped_after := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.and %arg6, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_slt_zero_smin_flipped_proof : select_icmp_slt_zero_smin_flipped_before ⊑ select_icmp_slt_zero_smin_flipped_after := by
  unfold select_icmp_slt_zero_smin_flipped_before select_icmp_slt_zero_smin_flipped_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_slt_zero_smin_flipped
  apply select_icmp_slt_zero_smin_flipped_thm
  ---END select_icmp_slt_zero_smin_flipped



def select_icmp_sgt_allones_smin_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.icmp "sgt" %arg3, %0 : i8
  %3 = llvm.xor %arg3, %1 : i8
  %4 = "llvm.select"(%2, %arg3, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def select_icmp_sgt_allones_smin_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.and %arg3, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_sgt_allones_smin_proof : select_icmp_sgt_allones_smin_before ⊑ select_icmp_sgt_allones_smin_after := by
  unfold select_icmp_sgt_allones_smin_before select_icmp_sgt_allones_smin_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_sgt_allones_smin
  apply select_icmp_sgt_allones_smin_thm
  ---END select_icmp_sgt_allones_smin



def select_icmp_sgt_allones_smin_flipped_before := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.icmp "sgt" %arg2, %0 : i8
  %3 = llvm.xor %arg2, %1 : i8
  %4 = "llvm.select"(%2, %3, %arg2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def select_icmp_sgt_allones_smin_flipped_after := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.or %arg2, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_sgt_allones_smin_flipped_proof : select_icmp_sgt_allones_smin_flipped_before ⊑ select_icmp_sgt_allones_smin_flipped_after := by
  unfold select_icmp_sgt_allones_smin_flipped_before select_icmp_sgt_allones_smin_flipped_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_sgt_allones_smin_flipped
  apply select_icmp_sgt_allones_smin_flipped_thm
  ---END select_icmp_sgt_allones_smin_flipped



def select_icmp_sgt_not_smin_before := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(-127 : i8) : i8
  %2 = llvm.icmp "sgt" %arg0, %0 : i8
  %3 = llvm.xor %arg0, %1 : i8
  %4 = "llvm.select"(%2, %arg0, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def select_icmp_sgt_not_smin_after := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(-127 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.xor %arg0, %0 : i8
  %3 = llvm.icmp "slt" %arg0, %1 : i8
  %4 = "llvm.select"(%3, %2, %arg0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select_icmp_sgt_not_smin_proof : select_icmp_sgt_not_smin_before ⊑ select_icmp_sgt_not_smin_after := by
  unfold select_icmp_sgt_not_smin_before select_icmp_sgt_not_smin_after
  simp_alive_peephole
  intros
  ---BEGIN select_icmp_sgt_not_smin
  apply select_icmp_sgt_not_smin_thm
  ---END select_icmp_sgt_not_smin


