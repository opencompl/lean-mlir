import SSA.Projects.InstCombine.tests.proofs.gandhorhicmphminhmax_proof
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
section gandhorhicmphminhmax_statements

def slt_and_max_before := [llvm|
{
^0(%arg382 : i8, %arg383 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "slt" %arg382, %arg383 : i8
  %2 = llvm.icmp "eq" %arg382, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_and_max_after := [llvm|
{
^0(%arg382 : i8, %arg383 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_and_max_proof : slt_and_max_before ⊑ slt_and_max_after := by
  unfold slt_and_max_before slt_and_max_after
  simp_alive_peephole
  intros
  ---BEGIN slt_and_max
  apply slt_and_max_thm
  ---END slt_and_max



def slt_and_max_logical_before := [llvm|
{
^0(%arg380 : i8, %arg381 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "slt" %arg380, %arg381 : i8
  %3 = llvm.icmp "eq" %arg380, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def slt_and_max_logical_after := [llvm|
{
^0(%arg380 : i8, %arg381 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_and_max_logical_proof : slt_and_max_logical_before ⊑ slt_and_max_logical_after := by
  unfold slt_and_max_logical_before slt_and_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN slt_and_max_logical
  apply slt_and_max_logical_thm
  ---END slt_and_max_logical



def slt_swap_and_max_before := [llvm|
{
^0(%arg376 : i8, %arg377 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sgt" %arg377, %arg376 : i8
  %2 = llvm.icmp "eq" %arg376, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_swap_and_max_after := [llvm|
{
^0(%arg376 : i8, %arg377 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_swap_and_max_proof : slt_swap_and_max_before ⊑ slt_swap_and_max_after := by
  unfold slt_swap_and_max_before slt_swap_and_max_after
  simp_alive_peephole
  intros
  ---BEGIN slt_swap_and_max
  apply slt_swap_and_max_thm
  ---END slt_swap_and_max



def slt_swap_and_max_logical_before := [llvm|
{
^0(%arg374 : i8, %arg375 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sgt" %arg375, %arg374 : i8
  %3 = llvm.icmp "eq" %arg374, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def slt_swap_and_max_logical_after := [llvm|
{
^0(%arg374 : i8, %arg375 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_swap_and_max_logical_proof : slt_swap_and_max_logical_before ⊑ slt_swap_and_max_logical_after := by
  unfold slt_swap_and_max_logical_before slt_swap_and_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN slt_swap_and_max_logical
  apply slt_swap_and_max_logical_thm
  ---END slt_swap_and_max_logical



def slt_swap_and_max_commute_before := [llvm|
{
^0(%arg372 : i8, %arg373 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sgt" %arg373, %arg372 : i8
  %2 = llvm.icmp "eq" %arg372, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_swap_and_max_commute_after := [llvm|
{
^0(%arg372 : i8, %arg373 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_swap_and_max_commute_proof : slt_swap_and_max_commute_before ⊑ slt_swap_and_max_commute_after := by
  unfold slt_swap_and_max_commute_before slt_swap_and_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN slt_swap_and_max_commute
  apply slt_swap_and_max_commute_thm
  ---END slt_swap_and_max_commute



def slt_swap_and_max_commute_logical_before := [llvm|
{
^0(%arg370 : i8, %arg371 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sgt" %arg371, %arg370 : i8
  %3 = llvm.icmp "eq" %arg370, %0 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def slt_swap_and_max_commute_logical_after := [llvm|
{
^0(%arg370 : i8, %arg371 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_swap_and_max_commute_logical_proof : slt_swap_and_max_commute_logical_before ⊑ slt_swap_and_max_commute_logical_after := by
  unfold slt_swap_and_max_commute_logical_before slt_swap_and_max_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN slt_swap_and_max_commute_logical
  apply slt_swap_and_max_commute_logical_thm
  ---END slt_swap_and_max_commute_logical



def ult_and_max_before := [llvm|
{
^0(%arg368 : i8, %arg369 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ult" %arg368, %arg369 : i8
  %2 = llvm.icmp "eq" %arg368, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_and_max_after := [llvm|
{
^0(%arg368 : i8, %arg369 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_and_max_proof : ult_and_max_before ⊑ ult_and_max_after := by
  unfold ult_and_max_before ult_and_max_after
  simp_alive_peephole
  intros
  ---BEGIN ult_and_max
  apply ult_and_max_thm
  ---END ult_and_max



def ult_and_max_logical_before := [llvm|
{
^0(%arg366 : i8, %arg367 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ult" %arg366, %arg367 : i8
  %3 = llvm.icmp "eq" %arg366, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ult_and_max_logical_after := [llvm|
{
^0(%arg366 : i8, %arg367 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_and_max_logical_proof : ult_and_max_logical_before ⊑ ult_and_max_logical_after := by
  unfold ult_and_max_logical_before ult_and_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ult_and_max_logical
  apply ult_and_max_logical_thm
  ---END ult_and_max_logical



def ult_and_max_commute_before := [llvm|
{
^0(%arg364 : i8, %arg365 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ult" %arg364, %arg365 : i8
  %2 = llvm.icmp "eq" %arg364, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_and_max_commute_after := [llvm|
{
^0(%arg364 : i8, %arg365 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_and_max_commute_proof : ult_and_max_commute_before ⊑ ult_and_max_commute_after := by
  unfold ult_and_max_commute_before ult_and_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ult_and_max_commute
  apply ult_and_max_commute_thm
  ---END ult_and_max_commute



def ult_and_max_commute_logical_before := [llvm|
{
^0(%arg362 : i8, %arg363 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ult" %arg362, %arg363 : i8
  %3 = llvm.icmp "eq" %arg362, %0 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ult_and_max_commute_logical_after := [llvm|
{
^0(%arg362 : i8, %arg363 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_and_max_commute_logical_proof : ult_and_max_commute_logical_before ⊑ ult_and_max_commute_logical_after := by
  unfold ult_and_max_commute_logical_before ult_and_max_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ult_and_max_commute_logical
  apply ult_and_max_commute_logical_thm
  ---END ult_and_max_commute_logical



def ult_swap_and_max_before := [llvm|
{
^0(%arg360 : i8, %arg361 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ugt" %arg361, %arg360 : i8
  %2 = llvm.icmp "eq" %arg360, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_swap_and_max_after := [llvm|
{
^0(%arg360 : i8, %arg361 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_swap_and_max_proof : ult_swap_and_max_before ⊑ ult_swap_and_max_after := by
  unfold ult_swap_and_max_before ult_swap_and_max_after
  simp_alive_peephole
  intros
  ---BEGIN ult_swap_and_max
  apply ult_swap_and_max_thm
  ---END ult_swap_and_max



def ult_swap_and_max_logical_before := [llvm|
{
^0(%arg358 : i8, %arg359 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ugt" %arg359, %arg358 : i8
  %3 = llvm.icmp "eq" %arg358, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ult_swap_and_max_logical_after := [llvm|
{
^0(%arg358 : i8, %arg359 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_swap_and_max_logical_proof : ult_swap_and_max_logical_before ⊑ ult_swap_and_max_logical_after := by
  unfold ult_swap_and_max_logical_before ult_swap_and_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ult_swap_and_max_logical
  apply ult_swap_and_max_logical_thm
  ---END ult_swap_and_max_logical



def ult_swap_and_max_commute_before := [llvm|
{
^0(%arg356 : i8, %arg357 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ugt" %arg357, %arg356 : i8
  %2 = llvm.icmp "eq" %arg356, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_swap_and_max_commute_after := [llvm|
{
^0(%arg356 : i8, %arg357 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_swap_and_max_commute_proof : ult_swap_and_max_commute_before ⊑ ult_swap_and_max_commute_after := by
  unfold ult_swap_and_max_commute_before ult_swap_and_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ult_swap_and_max_commute
  apply ult_swap_and_max_commute_thm
  ---END ult_swap_and_max_commute



def ult_swap_and_max_commute_logical_before := [llvm|
{
^0(%arg354 : i8, %arg355 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ugt" %arg355, %arg354 : i8
  %3 = llvm.icmp "eq" %arg354, %0 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ult_swap_and_max_commute_logical_after := [llvm|
{
^0(%arg354 : i8, %arg355 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_swap_and_max_commute_logical_proof : ult_swap_and_max_commute_logical_before ⊑ ult_swap_and_max_commute_logical_after := by
  unfold ult_swap_and_max_commute_logical_before ult_swap_and_max_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ult_swap_and_max_commute_logical
  apply ult_swap_and_max_commute_logical_thm
  ---END ult_swap_and_max_commute_logical



def sgt_and_min_before := [llvm|
{
^0(%arg352 : i9, %arg353 : i9):
  %0 = llvm.mlir.constant(-256 : i9) : i9
  %1 = llvm.icmp "sgt" %arg352, %arg353 : i9
  %2 = llvm.icmp "eq" %arg352, %0 : i9
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_and_min_after := [llvm|
{
^0(%arg352 : i9, %arg353 : i9):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_and_min_proof : sgt_and_min_before ⊑ sgt_and_min_after := by
  unfold sgt_and_min_before sgt_and_min_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_and_min
  apply sgt_and_min_thm
  ---END sgt_and_min



def sgt_and_min_logical_before := [llvm|
{
^0(%arg350 : i9, %arg351 : i9):
  %0 = llvm.mlir.constant(-256 : i9) : i9
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sgt" %arg350, %arg351 : i9
  %3 = llvm.icmp "eq" %arg350, %0 : i9
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sgt_and_min_logical_after := [llvm|
{
^0(%arg350 : i9, %arg351 : i9):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_and_min_logical_proof : sgt_and_min_logical_before ⊑ sgt_and_min_logical_after := by
  unfold sgt_and_min_logical_before sgt_and_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_and_min_logical
  apply sgt_and_min_logical_thm
  ---END sgt_and_min_logical



def sgt_and_min_commute_before := [llvm|
{
^0(%arg348 : i8, %arg349 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sgt" %arg348, %arg349 : i8
  %2 = llvm.icmp "eq" %arg348, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_and_min_commute_after := [llvm|
{
^0(%arg348 : i8, %arg349 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_and_min_commute_proof : sgt_and_min_commute_before ⊑ sgt_and_min_commute_after := by
  unfold sgt_and_min_commute_before sgt_and_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_and_min_commute
  apply sgt_and_min_commute_thm
  ---END sgt_and_min_commute



def sgt_and_min_commute_logical_before := [llvm|
{
^0(%arg346 : i8, %arg347 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sgt" %arg346, %arg347 : i8
  %3 = llvm.icmp "eq" %arg346, %0 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sgt_and_min_commute_logical_after := [llvm|
{
^0(%arg346 : i8, %arg347 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_and_min_commute_logical_proof : sgt_and_min_commute_logical_before ⊑ sgt_and_min_commute_logical_after := by
  unfold sgt_and_min_commute_logical_before sgt_and_min_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_and_min_commute_logical
  apply sgt_and_min_commute_logical_thm
  ---END sgt_and_min_commute_logical



def sgt_swap_and_min_before := [llvm|
{
^0(%arg344 : i8, %arg345 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "slt" %arg345, %arg344 : i8
  %2 = llvm.icmp "eq" %arg344, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_swap_and_min_after := [llvm|
{
^0(%arg344 : i8, %arg345 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_swap_and_min_proof : sgt_swap_and_min_before ⊑ sgt_swap_and_min_after := by
  unfold sgt_swap_and_min_before sgt_swap_and_min_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_swap_and_min
  apply sgt_swap_and_min_thm
  ---END sgt_swap_and_min



def sgt_swap_and_min_logical_before := [llvm|
{
^0(%arg342 : i8, %arg343 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "slt" %arg343, %arg342 : i8
  %3 = llvm.icmp "eq" %arg342, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sgt_swap_and_min_logical_after := [llvm|
{
^0(%arg342 : i8, %arg343 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_swap_and_min_logical_proof : sgt_swap_and_min_logical_before ⊑ sgt_swap_and_min_logical_after := by
  unfold sgt_swap_and_min_logical_before sgt_swap_and_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_swap_and_min_logical
  apply sgt_swap_and_min_logical_thm
  ---END sgt_swap_and_min_logical



def sgt_swap_and_min_commute_before := [llvm|
{
^0(%arg340 : i8, %arg341 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "slt" %arg341, %arg340 : i8
  %2 = llvm.icmp "eq" %arg340, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_swap_and_min_commute_after := [llvm|
{
^0(%arg340 : i8, %arg341 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_swap_and_min_commute_proof : sgt_swap_and_min_commute_before ⊑ sgt_swap_and_min_commute_after := by
  unfold sgt_swap_and_min_commute_before sgt_swap_and_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_swap_and_min_commute
  apply sgt_swap_and_min_commute_thm
  ---END sgt_swap_and_min_commute



def sgt_swap_and_min_commute_logical_before := [llvm|
{
^0(%arg338 : i8, %arg339 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "slt" %arg339, %arg338 : i8
  %3 = llvm.icmp "eq" %arg338, %0 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sgt_swap_and_min_commute_logical_after := [llvm|
{
^0(%arg338 : i8, %arg339 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_swap_and_min_commute_logical_proof : sgt_swap_and_min_commute_logical_before ⊑ sgt_swap_and_min_commute_logical_after := by
  unfold sgt_swap_and_min_commute_logical_before sgt_swap_and_min_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_swap_and_min_commute_logical
  apply sgt_swap_and_min_commute_logical_thm
  ---END sgt_swap_and_min_commute_logical



def ugt_and_min_before := [llvm|
{
^0(%arg336 : i8, %arg337 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ugt" %arg336, %arg337 : i8
  %2 = llvm.icmp "eq" %arg336, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_and_min_after := [llvm|
{
^0(%arg336 : i8, %arg337 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_and_min_proof : ugt_and_min_before ⊑ ugt_and_min_after := by
  unfold ugt_and_min_before ugt_and_min_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_and_min
  apply ugt_and_min_thm
  ---END ugt_and_min



def ugt_and_min_logical_before := [llvm|
{
^0(%arg334 : i8, %arg335 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ugt" %arg334, %arg335 : i8
  %3 = llvm.icmp "eq" %arg334, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ugt_and_min_logical_after := [llvm|
{
^0(%arg334 : i8, %arg335 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_and_min_logical_proof : ugt_and_min_logical_before ⊑ ugt_and_min_logical_after := by
  unfold ugt_and_min_logical_before ugt_and_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_and_min_logical
  apply ugt_and_min_logical_thm
  ---END ugt_and_min_logical



def ugt_and_min_commute_before := [llvm|
{
^0(%arg332 : i8, %arg333 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ugt" %arg332, %arg333 : i8
  %2 = llvm.icmp "eq" %arg332, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_and_min_commute_after := [llvm|
{
^0(%arg332 : i8, %arg333 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_and_min_commute_proof : ugt_and_min_commute_before ⊑ ugt_and_min_commute_after := by
  unfold ugt_and_min_commute_before ugt_and_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_and_min_commute
  apply ugt_and_min_commute_thm
  ---END ugt_and_min_commute



def ugt_and_min_commute_logical_before := [llvm|
{
^0(%arg330 : i8, %arg331 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ugt" %arg330, %arg331 : i8
  %3 = llvm.icmp "eq" %arg330, %0 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ugt_and_min_commute_logical_after := [llvm|
{
^0(%arg330 : i8, %arg331 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_and_min_commute_logical_proof : ugt_and_min_commute_logical_before ⊑ ugt_and_min_commute_logical_after := by
  unfold ugt_and_min_commute_logical_before ugt_and_min_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_and_min_commute_logical
  apply ugt_and_min_commute_logical_thm
  ---END ugt_and_min_commute_logical



def ugt_swap_and_min_before := [llvm|
{
^0(%arg328 : i8, %arg329 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ult" %arg329, %arg328 : i8
  %2 = llvm.icmp "eq" %arg328, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_swap_and_min_after := [llvm|
{
^0(%arg328 : i8, %arg329 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_swap_and_min_proof : ugt_swap_and_min_before ⊑ ugt_swap_and_min_after := by
  unfold ugt_swap_and_min_before ugt_swap_and_min_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_swap_and_min
  apply ugt_swap_and_min_thm
  ---END ugt_swap_and_min



def ugt_swap_and_min_logical_before := [llvm|
{
^0(%arg326 : i8, %arg327 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ult" %arg327, %arg326 : i8
  %3 = llvm.icmp "eq" %arg326, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ugt_swap_and_min_logical_after := [llvm|
{
^0(%arg326 : i8, %arg327 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_swap_and_min_logical_proof : ugt_swap_and_min_logical_before ⊑ ugt_swap_and_min_logical_after := by
  unfold ugt_swap_and_min_logical_before ugt_swap_and_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_swap_and_min_logical
  apply ugt_swap_and_min_logical_thm
  ---END ugt_swap_and_min_logical



def ugt_swap_and_min_commute_before := [llvm|
{
^0(%arg324 : i8, %arg325 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ult" %arg325, %arg324 : i8
  %2 = llvm.icmp "eq" %arg324, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_swap_and_min_commute_after := [llvm|
{
^0(%arg324 : i8, %arg325 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_swap_and_min_commute_proof : ugt_swap_and_min_commute_before ⊑ ugt_swap_and_min_commute_after := by
  unfold ugt_swap_and_min_commute_before ugt_swap_and_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_swap_and_min_commute
  apply ugt_swap_and_min_commute_thm
  ---END ugt_swap_and_min_commute



def ugt_swap_and_min_commute_logical_before := [llvm|
{
^0(%arg322 : i8, %arg323 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ult" %arg323, %arg322 : i8
  %3 = llvm.icmp "eq" %arg322, %0 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ugt_swap_and_min_commute_logical_after := [llvm|
{
^0(%arg322 : i8, %arg323 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_swap_and_min_commute_logical_proof : ugt_swap_and_min_commute_logical_before ⊑ ugt_swap_and_min_commute_logical_after := by
  unfold ugt_swap_and_min_commute_logical_before ugt_swap_and_min_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_swap_and_min_commute_logical
  apply ugt_swap_and_min_commute_logical_thm
  ---END ugt_swap_and_min_commute_logical



def sge_or_not_max_before := [llvm|
{
^0(%arg320 : i8, %arg321 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sge" %arg320, %arg321 : i8
  %2 = llvm.icmp "ne" %arg320, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_or_not_max_after := [llvm|
{
^0(%arg320 : i8, %arg321 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_or_not_max_proof : sge_or_not_max_before ⊑ sge_or_not_max_after := by
  unfold sge_or_not_max_before sge_or_not_max_after
  simp_alive_peephole
  intros
  ---BEGIN sge_or_not_max
  apply sge_or_not_max_thm
  ---END sge_or_not_max



def sge_or_not_max_logical_before := [llvm|
{
^0(%arg318 : i8, %arg319 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sge" %arg318, %arg319 : i8
  %3 = llvm.icmp "ne" %arg318, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sge_or_not_max_logical_after := [llvm|
{
^0(%arg318 : i8, %arg319 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_or_not_max_logical_proof : sge_or_not_max_logical_before ⊑ sge_or_not_max_logical_after := by
  unfold sge_or_not_max_logical_before sge_or_not_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sge_or_not_max_logical
  apply sge_or_not_max_logical_thm
  ---END sge_or_not_max_logical



def sge_or_not_max_commute_before := [llvm|
{
^0(%arg316 : i8, %arg317 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sge" %arg316, %arg317 : i8
  %2 = llvm.icmp "ne" %arg316, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_or_not_max_commute_after := [llvm|
{
^0(%arg316 : i8, %arg317 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_or_not_max_commute_proof : sge_or_not_max_commute_before ⊑ sge_or_not_max_commute_after := by
  unfold sge_or_not_max_commute_before sge_or_not_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sge_or_not_max_commute
  apply sge_or_not_max_commute_thm
  ---END sge_or_not_max_commute



def sge_or_not_max_commute_logical_before := [llvm|
{
^0(%arg314 : i8, %arg315 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sge" %arg314, %arg315 : i8
  %3 = llvm.icmp "ne" %arg314, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sge_or_not_max_commute_logical_after := [llvm|
{
^0(%arg314 : i8, %arg315 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_or_not_max_commute_logical_proof : sge_or_not_max_commute_logical_before ⊑ sge_or_not_max_commute_logical_after := by
  unfold sge_or_not_max_commute_logical_before sge_or_not_max_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sge_or_not_max_commute_logical
  apply sge_or_not_max_commute_logical_thm
  ---END sge_or_not_max_commute_logical



def sge_swap_or_not_max_before := [llvm|
{
^0(%arg312 : i8, %arg313 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sle" %arg313, %arg312 : i8
  %2 = llvm.icmp "ne" %arg312, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_swap_or_not_max_after := [llvm|
{
^0(%arg312 : i8, %arg313 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_swap_or_not_max_proof : sge_swap_or_not_max_before ⊑ sge_swap_or_not_max_after := by
  unfold sge_swap_or_not_max_before sge_swap_or_not_max_after
  simp_alive_peephole
  intros
  ---BEGIN sge_swap_or_not_max
  apply sge_swap_or_not_max_thm
  ---END sge_swap_or_not_max



def sge_swap_or_not_max_logical_before := [llvm|
{
^0(%arg310 : i8, %arg311 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sle" %arg311, %arg310 : i8
  %3 = llvm.icmp "ne" %arg310, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sge_swap_or_not_max_logical_after := [llvm|
{
^0(%arg310 : i8, %arg311 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_swap_or_not_max_logical_proof : sge_swap_or_not_max_logical_before ⊑ sge_swap_or_not_max_logical_after := by
  unfold sge_swap_or_not_max_logical_before sge_swap_or_not_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sge_swap_or_not_max_logical
  apply sge_swap_or_not_max_logical_thm
  ---END sge_swap_or_not_max_logical



def sge_swap_or_not_max_commute_before := [llvm|
{
^0(%arg308 : i8, %arg309 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sle" %arg309, %arg308 : i8
  %2 = llvm.icmp "ne" %arg308, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_swap_or_not_max_commute_after := [llvm|
{
^0(%arg308 : i8, %arg309 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_swap_or_not_max_commute_proof : sge_swap_or_not_max_commute_before ⊑ sge_swap_or_not_max_commute_after := by
  unfold sge_swap_or_not_max_commute_before sge_swap_or_not_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sge_swap_or_not_max_commute
  apply sge_swap_or_not_max_commute_thm
  ---END sge_swap_or_not_max_commute



def sge_swap_or_not_max_commute_logical_before := [llvm|
{
^0(%arg306 : i8, %arg307 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sle" %arg307, %arg306 : i8
  %3 = llvm.icmp "ne" %arg306, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sge_swap_or_not_max_commute_logical_after := [llvm|
{
^0(%arg306 : i8, %arg307 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_swap_or_not_max_commute_logical_proof : sge_swap_or_not_max_commute_logical_before ⊑ sge_swap_or_not_max_commute_logical_after := by
  unfold sge_swap_or_not_max_commute_logical_before sge_swap_or_not_max_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sge_swap_or_not_max_commute_logical
  apply sge_swap_or_not_max_commute_logical_thm
  ---END sge_swap_or_not_max_commute_logical



def uge_or_not_max_before := [llvm|
{
^0(%arg304 : i8, %arg305 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "uge" %arg304, %arg305 : i8
  %2 = llvm.icmp "ne" %arg304, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_or_not_max_after := [llvm|
{
^0(%arg304 : i8, %arg305 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_or_not_max_proof : uge_or_not_max_before ⊑ uge_or_not_max_after := by
  unfold uge_or_not_max_before uge_or_not_max_after
  simp_alive_peephole
  intros
  ---BEGIN uge_or_not_max
  apply uge_or_not_max_thm
  ---END uge_or_not_max



def uge_or_not_max_logical_before := [llvm|
{
^0(%arg302 : i8, %arg303 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "uge" %arg302, %arg303 : i8
  %3 = llvm.icmp "ne" %arg302, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def uge_or_not_max_logical_after := [llvm|
{
^0(%arg302 : i8, %arg303 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_or_not_max_logical_proof : uge_or_not_max_logical_before ⊑ uge_or_not_max_logical_after := by
  unfold uge_or_not_max_logical_before uge_or_not_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN uge_or_not_max_logical
  apply uge_or_not_max_logical_thm
  ---END uge_or_not_max_logical



def uge_or_not_max_commute_before := [llvm|
{
^0(%arg300 : i8, %arg301 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "uge" %arg300, %arg301 : i8
  %2 = llvm.icmp "ne" %arg300, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_or_not_max_commute_after := [llvm|
{
^0(%arg300 : i8, %arg301 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_or_not_max_commute_proof : uge_or_not_max_commute_before ⊑ uge_or_not_max_commute_after := by
  unfold uge_or_not_max_commute_before uge_or_not_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN uge_or_not_max_commute
  apply uge_or_not_max_commute_thm
  ---END uge_or_not_max_commute



def uge_or_not_max_commute_logical_before := [llvm|
{
^0(%arg298 : i8, %arg299 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "uge" %arg298, %arg299 : i8
  %3 = llvm.icmp "ne" %arg298, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def uge_or_not_max_commute_logical_after := [llvm|
{
^0(%arg298 : i8, %arg299 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_or_not_max_commute_logical_proof : uge_or_not_max_commute_logical_before ⊑ uge_or_not_max_commute_logical_after := by
  unfold uge_or_not_max_commute_logical_before uge_or_not_max_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN uge_or_not_max_commute_logical
  apply uge_or_not_max_commute_logical_thm
  ---END uge_or_not_max_commute_logical



def uge_swap_or_not_max_before := [llvm|
{
^0(%arg296 : i8, %arg297 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ule" %arg297, %arg296 : i8
  %2 = llvm.icmp "ne" %arg296, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_swap_or_not_max_after := [llvm|
{
^0(%arg296 : i8, %arg297 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_swap_or_not_max_proof : uge_swap_or_not_max_before ⊑ uge_swap_or_not_max_after := by
  unfold uge_swap_or_not_max_before uge_swap_or_not_max_after
  simp_alive_peephole
  intros
  ---BEGIN uge_swap_or_not_max
  apply uge_swap_or_not_max_thm
  ---END uge_swap_or_not_max



def uge_swap_or_not_max_logical_before := [llvm|
{
^0(%arg294 : i8, %arg295 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ule" %arg295, %arg294 : i8
  %3 = llvm.icmp "ne" %arg294, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def uge_swap_or_not_max_logical_after := [llvm|
{
^0(%arg294 : i8, %arg295 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_swap_or_not_max_logical_proof : uge_swap_or_not_max_logical_before ⊑ uge_swap_or_not_max_logical_after := by
  unfold uge_swap_or_not_max_logical_before uge_swap_or_not_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN uge_swap_or_not_max_logical
  apply uge_swap_or_not_max_logical_thm
  ---END uge_swap_or_not_max_logical



def uge_swap_or_not_max_commute_before := [llvm|
{
^0(%arg292 : i8, %arg293 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ule" %arg293, %arg292 : i8
  %2 = llvm.icmp "ne" %arg292, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_swap_or_not_max_commute_after := [llvm|
{
^0(%arg292 : i8, %arg293 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_swap_or_not_max_commute_proof : uge_swap_or_not_max_commute_before ⊑ uge_swap_or_not_max_commute_after := by
  unfold uge_swap_or_not_max_commute_before uge_swap_or_not_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN uge_swap_or_not_max_commute
  apply uge_swap_or_not_max_commute_thm
  ---END uge_swap_or_not_max_commute



def uge_swap_or_not_max_commute_logical_before := [llvm|
{
^0(%arg290 : i8, %arg291 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ule" %arg291, %arg290 : i8
  %3 = llvm.icmp "ne" %arg290, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def uge_swap_or_not_max_commute_logical_after := [llvm|
{
^0(%arg290 : i8, %arg291 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_swap_or_not_max_commute_logical_proof : uge_swap_or_not_max_commute_logical_before ⊑ uge_swap_or_not_max_commute_logical_after := by
  unfold uge_swap_or_not_max_commute_logical_before uge_swap_or_not_max_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN uge_swap_or_not_max_commute_logical
  apply uge_swap_or_not_max_commute_logical_thm
  ---END uge_swap_or_not_max_commute_logical



def sle_or_not_min_before := [llvm|
{
^0(%arg288 : i8, %arg289 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sle" %arg288, %arg289 : i8
  %2 = llvm.icmp "ne" %arg288, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_or_not_min_after := [llvm|
{
^0(%arg288 : i8, %arg289 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_or_not_min_proof : sle_or_not_min_before ⊑ sle_or_not_min_after := by
  unfold sle_or_not_min_before sle_or_not_min_after
  simp_alive_peephole
  intros
  ---BEGIN sle_or_not_min
  apply sle_or_not_min_thm
  ---END sle_or_not_min



def sle_or_not_min_logical_before := [llvm|
{
^0(%arg286 : i8, %arg287 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sle" %arg286, %arg287 : i8
  %3 = llvm.icmp "ne" %arg286, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sle_or_not_min_logical_after := [llvm|
{
^0(%arg286 : i8, %arg287 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_or_not_min_logical_proof : sle_or_not_min_logical_before ⊑ sle_or_not_min_logical_after := by
  unfold sle_or_not_min_logical_before sle_or_not_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sle_or_not_min_logical
  apply sle_or_not_min_logical_thm
  ---END sle_or_not_min_logical



def sle_or_not_min_commute_before := [llvm|
{
^0(%arg284 : i8, %arg285 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sle" %arg284, %arg285 : i8
  %2 = llvm.icmp "ne" %arg284, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_or_not_min_commute_after := [llvm|
{
^0(%arg284 : i8, %arg285 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_or_not_min_commute_proof : sle_or_not_min_commute_before ⊑ sle_or_not_min_commute_after := by
  unfold sle_or_not_min_commute_before sle_or_not_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sle_or_not_min_commute
  apply sle_or_not_min_commute_thm
  ---END sle_or_not_min_commute



def sle_or_not_min_commute_logical_before := [llvm|
{
^0(%arg282 : i8, %arg283 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sle" %arg282, %arg283 : i8
  %3 = llvm.icmp "ne" %arg282, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sle_or_not_min_commute_logical_after := [llvm|
{
^0(%arg282 : i8, %arg283 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_or_not_min_commute_logical_proof : sle_or_not_min_commute_logical_before ⊑ sle_or_not_min_commute_logical_after := by
  unfold sle_or_not_min_commute_logical_before sle_or_not_min_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sle_or_not_min_commute_logical
  apply sle_or_not_min_commute_logical_thm
  ---END sle_or_not_min_commute_logical



def sle_swap_or_not_min_before := [llvm|
{
^0(%arg280 : i8, %arg281 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sge" %arg281, %arg280 : i8
  %2 = llvm.icmp "ne" %arg280, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_swap_or_not_min_after := [llvm|
{
^0(%arg280 : i8, %arg281 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_swap_or_not_min_proof : sle_swap_or_not_min_before ⊑ sle_swap_or_not_min_after := by
  unfold sle_swap_or_not_min_before sle_swap_or_not_min_after
  simp_alive_peephole
  intros
  ---BEGIN sle_swap_or_not_min
  apply sle_swap_or_not_min_thm
  ---END sle_swap_or_not_min



def sle_swap_or_not_min_logical_before := [llvm|
{
^0(%arg278 : i8, %arg279 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sge" %arg279, %arg278 : i8
  %3 = llvm.icmp "ne" %arg278, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sle_swap_or_not_min_logical_after := [llvm|
{
^0(%arg278 : i8, %arg279 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_swap_or_not_min_logical_proof : sle_swap_or_not_min_logical_before ⊑ sle_swap_or_not_min_logical_after := by
  unfold sle_swap_or_not_min_logical_before sle_swap_or_not_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sle_swap_or_not_min_logical
  apply sle_swap_or_not_min_logical_thm
  ---END sle_swap_or_not_min_logical



def sle_swap_or_not_min_commute_before := [llvm|
{
^0(%arg276 : i8, %arg277 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sge" %arg277, %arg276 : i8
  %2 = llvm.icmp "ne" %arg276, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_swap_or_not_min_commute_after := [llvm|
{
^0(%arg276 : i8, %arg277 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_swap_or_not_min_commute_proof : sle_swap_or_not_min_commute_before ⊑ sle_swap_or_not_min_commute_after := by
  unfold sle_swap_or_not_min_commute_before sle_swap_or_not_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sle_swap_or_not_min_commute
  apply sle_swap_or_not_min_commute_thm
  ---END sle_swap_or_not_min_commute



def sle_swap_or_not_min_commute_logical_before := [llvm|
{
^0(%arg274 : i8, %arg275 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sge" %arg275, %arg274 : i8
  %3 = llvm.icmp "ne" %arg274, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sle_swap_or_not_min_commute_logical_after := [llvm|
{
^0(%arg274 : i8, %arg275 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_swap_or_not_min_commute_logical_proof : sle_swap_or_not_min_commute_logical_before ⊑ sle_swap_or_not_min_commute_logical_after := by
  unfold sle_swap_or_not_min_commute_logical_before sle_swap_or_not_min_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sle_swap_or_not_min_commute_logical
  apply sle_swap_or_not_min_commute_logical_thm
  ---END sle_swap_or_not_min_commute_logical



def ule_or_not_min_before := [llvm|
{
^0(%arg272 : i427, %arg273 : i427):
  %0 = llvm.mlir.constant(0 : i427) : i427
  %1 = llvm.icmp "ule" %arg272, %arg273 : i427
  %2 = llvm.icmp "ne" %arg272, %0 : i427
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_or_not_min_after := [llvm|
{
^0(%arg272 : i427, %arg273 : i427):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_or_not_min_proof : ule_or_not_min_before ⊑ ule_or_not_min_after := by
  unfold ule_or_not_min_before ule_or_not_min_after
  simp_alive_peephole
  intros
  ---BEGIN ule_or_not_min
  apply ule_or_not_min_thm
  ---END ule_or_not_min



def ule_or_not_min_logical_before := [llvm|
{
^0(%arg270 : i427, %arg271 : i427):
  %0 = llvm.mlir.constant(0 : i427) : i427
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ule" %arg270, %arg271 : i427
  %3 = llvm.icmp "ne" %arg270, %0 : i427
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ule_or_not_min_logical_after := [llvm|
{
^0(%arg270 : i427, %arg271 : i427):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_or_not_min_logical_proof : ule_or_not_min_logical_before ⊑ ule_or_not_min_logical_after := by
  unfold ule_or_not_min_logical_before ule_or_not_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ule_or_not_min_logical
  apply ule_or_not_min_logical_thm
  ---END ule_or_not_min_logical



def ule_or_not_min_commute_before := [llvm|
{
^0(%arg268 : i8, %arg269 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ule" %arg268, %arg269 : i8
  %2 = llvm.icmp "ne" %arg268, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_or_not_min_commute_after := [llvm|
{
^0(%arg268 : i8, %arg269 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_or_not_min_commute_proof : ule_or_not_min_commute_before ⊑ ule_or_not_min_commute_after := by
  unfold ule_or_not_min_commute_before ule_or_not_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ule_or_not_min_commute
  apply ule_or_not_min_commute_thm
  ---END ule_or_not_min_commute



def ule_or_not_min_commute_logical_before := [llvm|
{
^0(%arg266 : i8, %arg267 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ule" %arg266, %arg267 : i8
  %3 = llvm.icmp "ne" %arg266, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ule_or_not_min_commute_logical_after := [llvm|
{
^0(%arg266 : i8, %arg267 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_or_not_min_commute_logical_proof : ule_or_not_min_commute_logical_before ⊑ ule_or_not_min_commute_logical_after := by
  unfold ule_or_not_min_commute_logical_before ule_or_not_min_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ule_or_not_min_commute_logical
  apply ule_or_not_min_commute_logical_thm
  ---END ule_or_not_min_commute_logical



def ule_swap_or_not_min_before := [llvm|
{
^0(%arg264 : i8, %arg265 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "uge" %arg265, %arg264 : i8
  %2 = llvm.icmp "ne" %arg264, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_swap_or_not_min_after := [llvm|
{
^0(%arg264 : i8, %arg265 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_swap_or_not_min_proof : ule_swap_or_not_min_before ⊑ ule_swap_or_not_min_after := by
  unfold ule_swap_or_not_min_before ule_swap_or_not_min_after
  simp_alive_peephole
  intros
  ---BEGIN ule_swap_or_not_min
  apply ule_swap_or_not_min_thm
  ---END ule_swap_or_not_min



def ule_swap_or_not_min_logical_before := [llvm|
{
^0(%arg262 : i8, %arg263 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "uge" %arg263, %arg262 : i8
  %3 = llvm.icmp "ne" %arg262, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ule_swap_or_not_min_logical_after := [llvm|
{
^0(%arg262 : i8, %arg263 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_swap_or_not_min_logical_proof : ule_swap_or_not_min_logical_before ⊑ ule_swap_or_not_min_logical_after := by
  unfold ule_swap_or_not_min_logical_before ule_swap_or_not_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ule_swap_or_not_min_logical
  apply ule_swap_or_not_min_logical_thm
  ---END ule_swap_or_not_min_logical



def ule_swap_or_not_min_commute_before := [llvm|
{
^0(%arg260 : i8, %arg261 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "uge" %arg261, %arg260 : i8
  %2 = llvm.icmp "ne" %arg260, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_swap_or_not_min_commute_after := [llvm|
{
^0(%arg260 : i8, %arg261 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_swap_or_not_min_commute_proof : ule_swap_or_not_min_commute_before ⊑ ule_swap_or_not_min_commute_after := by
  unfold ule_swap_or_not_min_commute_before ule_swap_or_not_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ule_swap_or_not_min_commute
  apply ule_swap_or_not_min_commute_thm
  ---END ule_swap_or_not_min_commute



def ule_swap_or_not_min_commute_logical_before := [llvm|
{
^0(%arg258 : i8, %arg259 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "uge" %arg259, %arg258 : i8
  %3 = llvm.icmp "ne" %arg258, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ule_swap_or_not_min_commute_logical_after := [llvm|
{
^0(%arg258 : i8, %arg259 : i8):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_swap_or_not_min_commute_logical_proof : ule_swap_or_not_min_commute_logical_before ⊑ ule_swap_or_not_min_commute_logical_after := by
  unfold ule_swap_or_not_min_commute_logical_before ule_swap_or_not_min_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ule_swap_or_not_min_commute_logical
  apply ule_swap_or_not_min_commute_logical_thm
  ---END ule_swap_or_not_min_commute_logical



def sge_and_max_before := [llvm|
{
^0(%arg256 : i8, %arg257 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sge" %arg256, %arg257 : i8
  %2 = llvm.icmp "eq" %arg256, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_and_max_after := [llvm|
{
^0(%arg256 : i8, %arg257 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "eq" %arg256, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_and_max_proof : sge_and_max_before ⊑ sge_and_max_after := by
  unfold sge_and_max_before sge_and_max_after
  simp_alive_peephole
  intros
  ---BEGIN sge_and_max
  apply sge_and_max_thm
  ---END sge_and_max



def sge_and_max_logical_before := [llvm|
{
^0(%arg254 : i8, %arg255 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sge" %arg254, %arg255 : i8
  %3 = llvm.icmp "eq" %arg254, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sge_and_max_logical_after := [llvm|
{
^0(%arg254 : i8, %arg255 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "eq" %arg254, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_and_max_logical_proof : sge_and_max_logical_before ⊑ sge_and_max_logical_after := by
  unfold sge_and_max_logical_before sge_and_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sge_and_max_logical
  apply sge_and_max_logical_thm
  ---END sge_and_max_logical



def sge_and_max_logical_samesign_before := [llvm|
{
^0(%arg252 : i8, %arg253 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sge" %arg252, %arg253 : i8
  %3 = llvm.icmp "eq" %arg252, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sge_and_max_logical_samesign_after := [llvm|
{
^0(%arg252 : i8, %arg253 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "eq" %arg252, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_and_max_logical_samesign_proof : sge_and_max_logical_samesign_before ⊑ sge_and_max_logical_samesign_after := by
  unfold sge_and_max_logical_samesign_before sge_and_max_logical_samesign_after
  simp_alive_peephole
  intros
  ---BEGIN sge_and_max_logical_samesign
  apply sge_and_max_logical_samesign_thm
  ---END sge_and_max_logical_samesign



def sge_and_max_commute_before := [llvm|
{
^0(%arg250 : i8, %arg251 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sge" %arg250, %arg251 : i8
  %2 = llvm.icmp "eq" %arg250, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_and_max_commute_after := [llvm|
{
^0(%arg250 : i8, %arg251 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "eq" %arg250, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_and_max_commute_proof : sge_and_max_commute_before ⊑ sge_and_max_commute_after := by
  unfold sge_and_max_commute_before sge_and_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sge_and_max_commute
  apply sge_and_max_commute_thm
  ---END sge_and_max_commute



def sge_and_max_commute_logical_before := [llvm|
{
^0(%arg248 : i8, %arg249 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sge" %arg248, %arg249 : i8
  %3 = llvm.icmp "eq" %arg248, %0 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sge_and_max_commute_logical_after := [llvm|
{
^0(%arg248 : i8, %arg249 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "eq" %arg248, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_and_max_commute_logical_proof : sge_and_max_commute_logical_before ⊑ sge_and_max_commute_logical_after := by
  unfold sge_and_max_commute_logical_before sge_and_max_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sge_and_max_commute_logical
  apply sge_and_max_commute_logical_thm
  ---END sge_and_max_commute_logical



def sge_swap_and_max_before := [llvm|
{
^0(%arg246 : i8, %arg247 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sle" %arg247, %arg246 : i8
  %2 = llvm.icmp "eq" %arg246, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_swap_and_max_after := [llvm|
{
^0(%arg246 : i8, %arg247 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "eq" %arg246, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_swap_and_max_proof : sge_swap_and_max_before ⊑ sge_swap_and_max_after := by
  unfold sge_swap_and_max_before sge_swap_and_max_after
  simp_alive_peephole
  intros
  ---BEGIN sge_swap_and_max
  apply sge_swap_and_max_thm
  ---END sge_swap_and_max



def sge_swap_and_max_logical_before := [llvm|
{
^0(%arg244 : i8, %arg245 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sle" %arg245, %arg244 : i8
  %3 = llvm.icmp "eq" %arg244, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sge_swap_and_max_logical_after := [llvm|
{
^0(%arg244 : i8, %arg245 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "eq" %arg244, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_swap_and_max_logical_proof : sge_swap_and_max_logical_before ⊑ sge_swap_and_max_logical_after := by
  unfold sge_swap_and_max_logical_before sge_swap_and_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sge_swap_and_max_logical
  apply sge_swap_and_max_logical_thm
  ---END sge_swap_and_max_logical



def sge_swap_and_max_commute_before := [llvm|
{
^0(%arg242 : i8, %arg243 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sle" %arg243, %arg242 : i8
  %2 = llvm.icmp "eq" %arg242, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_swap_and_max_commute_after := [llvm|
{
^0(%arg242 : i8, %arg243 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "eq" %arg242, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_swap_and_max_commute_proof : sge_swap_and_max_commute_before ⊑ sge_swap_and_max_commute_after := by
  unfold sge_swap_and_max_commute_before sge_swap_and_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sge_swap_and_max_commute
  apply sge_swap_and_max_commute_thm
  ---END sge_swap_and_max_commute



def sge_swap_and_max_commute_logical_before := [llvm|
{
^0(%arg240 : i8, %arg241 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sle" %arg241, %arg240 : i8
  %3 = llvm.icmp "eq" %arg240, %0 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sge_swap_and_max_commute_logical_after := [llvm|
{
^0(%arg240 : i8, %arg241 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "eq" %arg240, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_swap_and_max_commute_logical_proof : sge_swap_and_max_commute_logical_before ⊑ sge_swap_and_max_commute_logical_after := by
  unfold sge_swap_and_max_commute_logical_before sge_swap_and_max_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sge_swap_and_max_commute_logical
  apply sge_swap_and_max_commute_logical_thm
  ---END sge_swap_and_max_commute_logical



def uge_and_max_before := [llvm|
{
^0(%arg238 : i8, %arg239 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "uge" %arg238, %arg239 : i8
  %2 = llvm.icmp "eq" %arg238, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_and_max_after := [llvm|
{
^0(%arg238 : i8, %arg239 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "eq" %arg238, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_and_max_proof : uge_and_max_before ⊑ uge_and_max_after := by
  unfold uge_and_max_before uge_and_max_after
  simp_alive_peephole
  intros
  ---BEGIN uge_and_max
  apply uge_and_max_thm
  ---END uge_and_max



def uge_and_max_logical_before := [llvm|
{
^0(%arg236 : i8, %arg237 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "uge" %arg236, %arg237 : i8
  %3 = llvm.icmp "eq" %arg236, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def uge_and_max_logical_after := [llvm|
{
^0(%arg236 : i8, %arg237 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "eq" %arg236, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_and_max_logical_proof : uge_and_max_logical_before ⊑ uge_and_max_logical_after := by
  unfold uge_and_max_logical_before uge_and_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN uge_and_max_logical
  apply uge_and_max_logical_thm
  ---END uge_and_max_logical



def uge_and_max_commute_before := [llvm|
{
^0(%arg234 : i8, %arg235 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "uge" %arg234, %arg235 : i8
  %2 = llvm.icmp "eq" %arg234, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_and_max_commute_after := [llvm|
{
^0(%arg234 : i8, %arg235 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "eq" %arg234, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_and_max_commute_proof : uge_and_max_commute_before ⊑ uge_and_max_commute_after := by
  unfold uge_and_max_commute_before uge_and_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN uge_and_max_commute
  apply uge_and_max_commute_thm
  ---END uge_and_max_commute



def uge_and_max_commute_logical_before := [llvm|
{
^0(%arg232 : i8, %arg233 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "uge" %arg232, %arg233 : i8
  %3 = llvm.icmp "eq" %arg232, %0 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def uge_and_max_commute_logical_after := [llvm|
{
^0(%arg232 : i8, %arg233 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "eq" %arg232, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_and_max_commute_logical_proof : uge_and_max_commute_logical_before ⊑ uge_and_max_commute_logical_after := by
  unfold uge_and_max_commute_logical_before uge_and_max_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN uge_and_max_commute_logical
  apply uge_and_max_commute_logical_thm
  ---END uge_and_max_commute_logical



def uge_swap_and_max_before := [llvm|
{
^0(%arg230 : i8, %arg231 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ule" %arg231, %arg230 : i8
  %2 = llvm.icmp "eq" %arg230, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_swap_and_max_after := [llvm|
{
^0(%arg230 : i8, %arg231 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "eq" %arg230, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_swap_and_max_proof : uge_swap_and_max_before ⊑ uge_swap_and_max_after := by
  unfold uge_swap_and_max_before uge_swap_and_max_after
  simp_alive_peephole
  intros
  ---BEGIN uge_swap_and_max
  apply uge_swap_and_max_thm
  ---END uge_swap_and_max



def uge_swap_and_max_logical_before := [llvm|
{
^0(%arg228 : i8, %arg229 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ule" %arg229, %arg228 : i8
  %3 = llvm.icmp "eq" %arg228, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def uge_swap_and_max_logical_after := [llvm|
{
^0(%arg228 : i8, %arg229 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "eq" %arg228, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_swap_and_max_logical_proof : uge_swap_and_max_logical_before ⊑ uge_swap_and_max_logical_after := by
  unfold uge_swap_and_max_logical_before uge_swap_and_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN uge_swap_and_max_logical
  apply uge_swap_and_max_logical_thm
  ---END uge_swap_and_max_logical



def uge_swap_and_max_commute_before := [llvm|
{
^0(%arg226 : i8, %arg227 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ule" %arg227, %arg226 : i8
  %2 = llvm.icmp "eq" %arg226, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_swap_and_max_commute_after := [llvm|
{
^0(%arg226 : i8, %arg227 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "eq" %arg226, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_swap_and_max_commute_proof : uge_swap_and_max_commute_before ⊑ uge_swap_and_max_commute_after := by
  unfold uge_swap_and_max_commute_before uge_swap_and_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN uge_swap_and_max_commute
  apply uge_swap_and_max_commute_thm
  ---END uge_swap_and_max_commute



def uge_swap_and_max_commute_logical_before := [llvm|
{
^0(%arg224 : i8, %arg225 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ule" %arg225, %arg224 : i8
  %3 = llvm.icmp "eq" %arg224, %0 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def uge_swap_and_max_commute_logical_after := [llvm|
{
^0(%arg224 : i8, %arg225 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "eq" %arg224, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_swap_and_max_commute_logical_proof : uge_swap_and_max_commute_logical_before ⊑ uge_swap_and_max_commute_logical_after := by
  unfold uge_swap_and_max_commute_logical_before uge_swap_and_max_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN uge_swap_and_max_commute_logical
  apply uge_swap_and_max_commute_logical_thm
  ---END uge_swap_and_max_commute_logical



def sle_and_min_before := [llvm|
{
^0(%arg222 : i8, %arg223 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sle" %arg222, %arg223 : i8
  %2 = llvm.icmp "eq" %arg222, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_and_min_after := [llvm|
{
^0(%arg222 : i8, %arg223 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "eq" %arg222, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_and_min_proof : sle_and_min_before ⊑ sle_and_min_after := by
  unfold sle_and_min_before sle_and_min_after
  simp_alive_peephole
  intros
  ---BEGIN sle_and_min
  apply sle_and_min_thm
  ---END sle_and_min



def sle_and_min_logical_before := [llvm|
{
^0(%arg220 : i8, %arg221 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sle" %arg220, %arg221 : i8
  %3 = llvm.icmp "eq" %arg220, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sle_and_min_logical_after := [llvm|
{
^0(%arg220 : i8, %arg221 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "eq" %arg220, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_and_min_logical_proof : sle_and_min_logical_before ⊑ sle_and_min_logical_after := by
  unfold sle_and_min_logical_before sle_and_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sle_and_min_logical
  apply sle_and_min_logical_thm
  ---END sle_and_min_logical



def sle_and_min_commute_before := [llvm|
{
^0(%arg218 : i8, %arg219 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sle" %arg218, %arg219 : i8
  %2 = llvm.icmp "eq" %arg218, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_and_min_commute_after := [llvm|
{
^0(%arg218 : i8, %arg219 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "eq" %arg218, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_and_min_commute_proof : sle_and_min_commute_before ⊑ sle_and_min_commute_after := by
  unfold sle_and_min_commute_before sle_and_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sle_and_min_commute
  apply sle_and_min_commute_thm
  ---END sle_and_min_commute



def sle_and_min_commute_logical_before := [llvm|
{
^0(%arg216 : i8, %arg217 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sle" %arg216, %arg217 : i8
  %3 = llvm.icmp "eq" %arg216, %0 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sle_and_min_commute_logical_after := [llvm|
{
^0(%arg216 : i8, %arg217 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "eq" %arg216, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_and_min_commute_logical_proof : sle_and_min_commute_logical_before ⊑ sle_and_min_commute_logical_after := by
  unfold sle_and_min_commute_logical_before sle_and_min_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sle_and_min_commute_logical
  apply sle_and_min_commute_logical_thm
  ---END sle_and_min_commute_logical



def sle_swap_and_min_before := [llvm|
{
^0(%arg214 : i8, %arg215 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sge" %arg215, %arg214 : i8
  %2 = llvm.icmp "eq" %arg214, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_swap_and_min_after := [llvm|
{
^0(%arg214 : i8, %arg215 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "eq" %arg214, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_swap_and_min_proof : sle_swap_and_min_before ⊑ sle_swap_and_min_after := by
  unfold sle_swap_and_min_before sle_swap_and_min_after
  simp_alive_peephole
  intros
  ---BEGIN sle_swap_and_min
  apply sle_swap_and_min_thm
  ---END sle_swap_and_min



def sle_swap_and_min_logical_before := [llvm|
{
^0(%arg212 : i8, %arg213 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sge" %arg213, %arg212 : i8
  %3 = llvm.icmp "eq" %arg212, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sle_swap_and_min_logical_after := [llvm|
{
^0(%arg212 : i8, %arg213 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "eq" %arg212, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_swap_and_min_logical_proof : sle_swap_and_min_logical_before ⊑ sle_swap_and_min_logical_after := by
  unfold sle_swap_and_min_logical_before sle_swap_and_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sle_swap_and_min_logical
  apply sle_swap_and_min_logical_thm
  ---END sle_swap_and_min_logical



def sle_swap_and_min_commute_before := [llvm|
{
^0(%arg210 : i8, %arg211 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sge" %arg211, %arg210 : i8
  %2 = llvm.icmp "eq" %arg210, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_swap_and_min_commute_after := [llvm|
{
^0(%arg210 : i8, %arg211 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "eq" %arg210, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_swap_and_min_commute_proof : sle_swap_and_min_commute_before ⊑ sle_swap_and_min_commute_after := by
  unfold sle_swap_and_min_commute_before sle_swap_and_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sle_swap_and_min_commute
  apply sle_swap_and_min_commute_thm
  ---END sle_swap_and_min_commute



def sle_swap_and_min_commute_logical_before := [llvm|
{
^0(%arg208 : i8, %arg209 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sge" %arg209, %arg208 : i8
  %3 = llvm.icmp "eq" %arg208, %0 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sle_swap_and_min_commute_logical_after := [llvm|
{
^0(%arg208 : i8, %arg209 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "eq" %arg208, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_swap_and_min_commute_logical_proof : sle_swap_and_min_commute_logical_before ⊑ sle_swap_and_min_commute_logical_after := by
  unfold sle_swap_and_min_commute_logical_before sle_swap_and_min_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sle_swap_and_min_commute_logical
  apply sle_swap_and_min_commute_logical_thm
  ---END sle_swap_and_min_commute_logical



def ule_and_min_before := [llvm|
{
^0(%arg206 : i8, %arg207 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ule" %arg206, %arg207 : i8
  %2 = llvm.icmp "eq" %arg206, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_and_min_after := [llvm|
{
^0(%arg206 : i8, %arg207 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg206, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_and_min_proof : ule_and_min_before ⊑ ule_and_min_after := by
  unfold ule_and_min_before ule_and_min_after
  simp_alive_peephole
  intros
  ---BEGIN ule_and_min
  apply ule_and_min_thm
  ---END ule_and_min



def ule_and_min_logical_before := [llvm|
{
^0(%arg204 : i8, %arg205 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ule" %arg204, %arg205 : i8
  %3 = llvm.icmp "eq" %arg204, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ule_and_min_logical_after := [llvm|
{
^0(%arg204 : i8, %arg205 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg204, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_and_min_logical_proof : ule_and_min_logical_before ⊑ ule_and_min_logical_after := by
  unfold ule_and_min_logical_before ule_and_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ule_and_min_logical
  apply ule_and_min_logical_thm
  ---END ule_and_min_logical



def ule_and_min_commute_before := [llvm|
{
^0(%arg202 : i8, %arg203 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ule" %arg202, %arg203 : i8
  %2 = llvm.icmp "eq" %arg202, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_and_min_commute_after := [llvm|
{
^0(%arg202 : i8, %arg203 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg202, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_and_min_commute_proof : ule_and_min_commute_before ⊑ ule_and_min_commute_after := by
  unfold ule_and_min_commute_before ule_and_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ule_and_min_commute
  apply ule_and_min_commute_thm
  ---END ule_and_min_commute



def ule_and_min_commute_logical_before := [llvm|
{
^0(%arg200 : i8, %arg201 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ule" %arg200, %arg201 : i8
  %3 = llvm.icmp "eq" %arg200, %0 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ule_and_min_commute_logical_after := [llvm|
{
^0(%arg200 : i8, %arg201 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg200, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_and_min_commute_logical_proof : ule_and_min_commute_logical_before ⊑ ule_and_min_commute_logical_after := by
  unfold ule_and_min_commute_logical_before ule_and_min_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ule_and_min_commute_logical
  apply ule_and_min_commute_logical_thm
  ---END ule_and_min_commute_logical



def ule_swap_and_min_before := [llvm|
{
^0(%arg198 : i8, %arg199 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "uge" %arg199, %arg198 : i8
  %2 = llvm.icmp "eq" %arg198, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_swap_and_min_after := [llvm|
{
^0(%arg198 : i8, %arg199 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg198, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_swap_and_min_proof : ule_swap_and_min_before ⊑ ule_swap_and_min_after := by
  unfold ule_swap_and_min_before ule_swap_and_min_after
  simp_alive_peephole
  intros
  ---BEGIN ule_swap_and_min
  apply ule_swap_and_min_thm
  ---END ule_swap_and_min



def ule_swap_and_min_logical_before := [llvm|
{
^0(%arg196 : i8, %arg197 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "uge" %arg197, %arg196 : i8
  %3 = llvm.icmp "eq" %arg196, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ule_swap_and_min_logical_after := [llvm|
{
^0(%arg196 : i8, %arg197 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg196, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_swap_and_min_logical_proof : ule_swap_and_min_logical_before ⊑ ule_swap_and_min_logical_after := by
  unfold ule_swap_and_min_logical_before ule_swap_and_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ule_swap_and_min_logical
  apply ule_swap_and_min_logical_thm
  ---END ule_swap_and_min_logical



def ule_swap_and_min_commute_before := [llvm|
{
^0(%arg194 : i8, %arg195 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "uge" %arg195, %arg194 : i8
  %2 = llvm.icmp "eq" %arg194, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_swap_and_min_commute_after := [llvm|
{
^0(%arg194 : i8, %arg195 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg194, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_swap_and_min_commute_proof : ule_swap_and_min_commute_before ⊑ ule_swap_and_min_commute_after := by
  unfold ule_swap_and_min_commute_before ule_swap_and_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ule_swap_and_min_commute
  apply ule_swap_and_min_commute_thm
  ---END ule_swap_and_min_commute



def ule_swap_and_min_commute_logical_before := [llvm|
{
^0(%arg192 : i8, %arg193 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "uge" %arg193, %arg192 : i8
  %3 = llvm.icmp "eq" %arg192, %0 : i8
  %4 = "llvm.select"(%3, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ule_swap_and_min_commute_logical_after := [llvm|
{
^0(%arg192 : i8, %arg193 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg192, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_swap_and_min_commute_logical_proof : ule_swap_and_min_commute_logical_before ⊑ ule_swap_and_min_commute_logical_after := by
  unfold ule_swap_and_min_commute_logical_before ule_swap_and_min_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ule_swap_and_min_commute_logical
  apply ule_swap_and_min_commute_logical_thm
  ---END ule_swap_and_min_commute_logical



def sge_or_max_before := [llvm|
{
^0(%arg190 : i8, %arg191 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sge" %arg190, %arg191 : i8
  %2 = llvm.icmp "eq" %arg190, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_or_max_after := [llvm|
{
^0(%arg190 : i8, %arg191 : i8):
  %0 = llvm.icmp "sge" %arg190, %arg191 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_or_max_proof : sge_or_max_before ⊑ sge_or_max_after := by
  unfold sge_or_max_before sge_or_max_after
  simp_alive_peephole
  intros
  ---BEGIN sge_or_max
  apply sge_or_max_thm
  ---END sge_or_max



def sge_or_max_logical_before := [llvm|
{
^0(%arg188 : i8, %arg189 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sge" %arg188, %arg189 : i8
  %3 = llvm.icmp "eq" %arg188, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sge_or_max_logical_after := [llvm|
{
^0(%arg188 : i8, %arg189 : i8):
  %0 = llvm.icmp "sge" %arg188, %arg189 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_or_max_logical_proof : sge_or_max_logical_before ⊑ sge_or_max_logical_after := by
  unfold sge_or_max_logical_before sge_or_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sge_or_max_logical
  apply sge_or_max_logical_thm
  ---END sge_or_max_logical



def sge_or_max_commute_before := [llvm|
{
^0(%arg186 : i8, %arg187 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sge" %arg186, %arg187 : i8
  %2 = llvm.icmp "eq" %arg186, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_or_max_commute_after := [llvm|
{
^0(%arg186 : i8, %arg187 : i8):
  %0 = llvm.icmp "sge" %arg186, %arg187 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_or_max_commute_proof : sge_or_max_commute_before ⊑ sge_or_max_commute_after := by
  unfold sge_or_max_commute_before sge_or_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sge_or_max_commute
  apply sge_or_max_commute_thm
  ---END sge_or_max_commute



def sge_swap_or_max_before := [llvm|
{
^0(%arg182 : i8, %arg183 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sle" %arg183, %arg182 : i8
  %2 = llvm.icmp "eq" %arg182, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_swap_or_max_after := [llvm|
{
^0(%arg182 : i8, %arg183 : i8):
  %0 = llvm.icmp "sle" %arg183, %arg182 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_swap_or_max_proof : sge_swap_or_max_before ⊑ sge_swap_or_max_after := by
  unfold sge_swap_or_max_before sge_swap_or_max_after
  simp_alive_peephole
  intros
  ---BEGIN sge_swap_or_max
  apply sge_swap_or_max_thm
  ---END sge_swap_or_max



def sge_swap_or_max_logical_before := [llvm|
{
^0(%arg180 : i8, %arg181 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sle" %arg181, %arg180 : i8
  %3 = llvm.icmp "eq" %arg180, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sge_swap_or_max_logical_after := [llvm|
{
^0(%arg180 : i8, %arg181 : i8):
  %0 = llvm.icmp "sle" %arg181, %arg180 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_swap_or_max_logical_proof : sge_swap_or_max_logical_before ⊑ sge_swap_or_max_logical_after := by
  unfold sge_swap_or_max_logical_before sge_swap_or_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sge_swap_or_max_logical
  apply sge_swap_or_max_logical_thm
  ---END sge_swap_or_max_logical



def sge_swap_or_max_commute_before := [llvm|
{
^0(%arg178 : i8, %arg179 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sle" %arg179, %arg178 : i8
  %2 = llvm.icmp "eq" %arg178, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sge_swap_or_max_commute_after := [llvm|
{
^0(%arg178 : i8, %arg179 : i8):
  %0 = llvm.icmp "sle" %arg179, %arg178 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sge_swap_or_max_commute_proof : sge_swap_or_max_commute_before ⊑ sge_swap_or_max_commute_after := by
  unfold sge_swap_or_max_commute_before sge_swap_or_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sge_swap_or_max_commute
  apply sge_swap_or_max_commute_thm
  ---END sge_swap_or_max_commute



def uge_or_max_before := [llvm|
{
^0(%arg174 : i8, %arg175 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "uge" %arg174, %arg175 : i8
  %2 = llvm.icmp "eq" %arg174, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_or_max_after := [llvm|
{
^0(%arg174 : i8, %arg175 : i8):
  %0 = llvm.icmp "uge" %arg174, %arg175 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_or_max_proof : uge_or_max_before ⊑ uge_or_max_after := by
  unfold uge_or_max_before uge_or_max_after
  simp_alive_peephole
  intros
  ---BEGIN uge_or_max
  apply uge_or_max_thm
  ---END uge_or_max



def uge_or_max_logical_before := [llvm|
{
^0(%arg172 : i8, %arg173 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "uge" %arg172, %arg173 : i8
  %3 = llvm.icmp "eq" %arg172, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def uge_or_max_logical_after := [llvm|
{
^0(%arg172 : i8, %arg173 : i8):
  %0 = llvm.icmp "uge" %arg172, %arg173 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_or_max_logical_proof : uge_or_max_logical_before ⊑ uge_or_max_logical_after := by
  unfold uge_or_max_logical_before uge_or_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN uge_or_max_logical
  apply uge_or_max_logical_thm
  ---END uge_or_max_logical



def uge_or_max_commute_before := [llvm|
{
^0(%arg170 : i8, %arg171 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "uge" %arg170, %arg171 : i8
  %2 = llvm.icmp "eq" %arg170, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_or_max_commute_after := [llvm|
{
^0(%arg170 : i8, %arg171 : i8):
  %0 = llvm.icmp "uge" %arg170, %arg171 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_or_max_commute_proof : uge_or_max_commute_before ⊑ uge_or_max_commute_after := by
  unfold uge_or_max_commute_before uge_or_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN uge_or_max_commute
  apply uge_or_max_commute_thm
  ---END uge_or_max_commute



def uge_swap_or_max_before := [llvm|
{
^0(%arg166 : i8, %arg167 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ule" %arg167, %arg166 : i8
  %2 = llvm.icmp "eq" %arg166, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_swap_or_max_after := [llvm|
{
^0(%arg166 : i8, %arg167 : i8):
  %0 = llvm.icmp "ule" %arg167, %arg166 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_swap_or_max_proof : uge_swap_or_max_before ⊑ uge_swap_or_max_after := by
  unfold uge_swap_or_max_before uge_swap_or_max_after
  simp_alive_peephole
  intros
  ---BEGIN uge_swap_or_max
  apply uge_swap_or_max_thm
  ---END uge_swap_or_max



def uge_swap_or_max_logical_before := [llvm|
{
^0(%arg164 : i8, %arg165 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ule" %arg165, %arg164 : i8
  %3 = llvm.icmp "eq" %arg164, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def uge_swap_or_max_logical_after := [llvm|
{
^0(%arg164 : i8, %arg165 : i8):
  %0 = llvm.icmp "ule" %arg165, %arg164 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_swap_or_max_logical_proof : uge_swap_or_max_logical_before ⊑ uge_swap_or_max_logical_after := by
  unfold uge_swap_or_max_logical_before uge_swap_or_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN uge_swap_or_max_logical
  apply uge_swap_or_max_logical_thm
  ---END uge_swap_or_max_logical



def uge_swap_or_max_commute_before := [llvm|
{
^0(%arg162 : i8, %arg163 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ule" %arg163, %arg162 : i8
  %2 = llvm.icmp "eq" %arg162, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def uge_swap_or_max_commute_after := [llvm|
{
^0(%arg162 : i8, %arg163 : i8):
  %0 = llvm.icmp "ule" %arg163, %arg162 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uge_swap_or_max_commute_proof : uge_swap_or_max_commute_before ⊑ uge_swap_or_max_commute_after := by
  unfold uge_swap_or_max_commute_before uge_swap_or_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN uge_swap_or_max_commute
  apply uge_swap_or_max_commute_thm
  ---END uge_swap_or_max_commute



def sle_or_min_before := [llvm|
{
^0(%arg158 : i8, %arg159 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sle" %arg158, %arg159 : i8
  %2 = llvm.icmp "eq" %arg158, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_or_min_after := [llvm|
{
^0(%arg158 : i8, %arg159 : i8):
  %0 = llvm.icmp "sle" %arg158, %arg159 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_or_min_proof : sle_or_min_before ⊑ sle_or_min_after := by
  unfold sle_or_min_before sle_or_min_after
  simp_alive_peephole
  intros
  ---BEGIN sle_or_min
  apply sle_or_min_thm
  ---END sle_or_min



def sle_or_min_logical_before := [llvm|
{
^0(%arg156 : i8, %arg157 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sle" %arg156, %arg157 : i8
  %3 = llvm.icmp "eq" %arg156, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sle_or_min_logical_after := [llvm|
{
^0(%arg156 : i8, %arg157 : i8):
  %0 = llvm.icmp "sle" %arg156, %arg157 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_or_min_logical_proof : sle_or_min_logical_before ⊑ sle_or_min_logical_after := by
  unfold sle_or_min_logical_before sle_or_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sle_or_min_logical
  apply sle_or_min_logical_thm
  ---END sle_or_min_logical



def sle_or_min_commute_before := [llvm|
{
^0(%arg154 : i8, %arg155 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sle" %arg154, %arg155 : i8
  %2 = llvm.icmp "eq" %arg154, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_or_min_commute_after := [llvm|
{
^0(%arg154 : i8, %arg155 : i8):
  %0 = llvm.icmp "sle" %arg154, %arg155 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_or_min_commute_proof : sle_or_min_commute_before ⊑ sle_or_min_commute_after := by
  unfold sle_or_min_commute_before sle_or_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sle_or_min_commute
  apply sle_or_min_commute_thm
  ---END sle_or_min_commute



def sle_swap_or_min_before := [llvm|
{
^0(%arg150 : i8, %arg151 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sge" %arg151, %arg150 : i8
  %2 = llvm.icmp "eq" %arg150, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_swap_or_min_after := [llvm|
{
^0(%arg150 : i8, %arg151 : i8):
  %0 = llvm.icmp "sge" %arg151, %arg150 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_swap_or_min_proof : sle_swap_or_min_before ⊑ sle_swap_or_min_after := by
  unfold sle_swap_or_min_before sle_swap_or_min_after
  simp_alive_peephole
  intros
  ---BEGIN sle_swap_or_min
  apply sle_swap_or_min_thm
  ---END sle_swap_or_min



def sle_swap_or_min_logical_before := [llvm|
{
^0(%arg148 : i8, %arg149 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sge" %arg149, %arg148 : i8
  %3 = llvm.icmp "eq" %arg148, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sle_swap_or_min_logical_after := [llvm|
{
^0(%arg148 : i8, %arg149 : i8):
  %0 = llvm.icmp "sge" %arg149, %arg148 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_swap_or_min_logical_proof : sle_swap_or_min_logical_before ⊑ sle_swap_or_min_logical_after := by
  unfold sle_swap_or_min_logical_before sle_swap_or_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sle_swap_or_min_logical
  apply sle_swap_or_min_logical_thm
  ---END sle_swap_or_min_logical



def sle_swap_or_min_commute_before := [llvm|
{
^0(%arg146 : i8, %arg147 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sge" %arg147, %arg146 : i8
  %2 = llvm.icmp "eq" %arg146, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sle_swap_or_min_commute_after := [llvm|
{
^0(%arg146 : i8, %arg147 : i8):
  %0 = llvm.icmp "sge" %arg147, %arg146 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sle_swap_or_min_commute_proof : sle_swap_or_min_commute_before ⊑ sle_swap_or_min_commute_after := by
  unfold sle_swap_or_min_commute_before sle_swap_or_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sle_swap_or_min_commute
  apply sle_swap_or_min_commute_thm
  ---END sle_swap_or_min_commute



def ule_or_min_before := [llvm|
{
^0(%arg142 : i8, %arg143 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ule" %arg142, %arg143 : i8
  %2 = llvm.icmp "eq" %arg142, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_or_min_after := [llvm|
{
^0(%arg142 : i8, %arg143 : i8):
  %0 = llvm.icmp "ule" %arg142, %arg143 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_or_min_proof : ule_or_min_before ⊑ ule_or_min_after := by
  unfold ule_or_min_before ule_or_min_after
  simp_alive_peephole
  intros
  ---BEGIN ule_or_min
  apply ule_or_min_thm
  ---END ule_or_min



def ule_or_min_logical_before := [llvm|
{
^0(%arg140 : i8, %arg141 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ule" %arg140, %arg141 : i8
  %3 = llvm.icmp "eq" %arg140, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ule_or_min_logical_after := [llvm|
{
^0(%arg140 : i8, %arg141 : i8):
  %0 = llvm.icmp "ule" %arg140, %arg141 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_or_min_logical_proof : ule_or_min_logical_before ⊑ ule_or_min_logical_after := by
  unfold ule_or_min_logical_before ule_or_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ule_or_min_logical
  apply ule_or_min_logical_thm
  ---END ule_or_min_logical



def ule_or_min_commute_before := [llvm|
{
^0(%arg138 : i8, %arg139 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ule" %arg138, %arg139 : i8
  %2 = llvm.icmp "eq" %arg138, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_or_min_commute_after := [llvm|
{
^0(%arg138 : i8, %arg139 : i8):
  %0 = llvm.icmp "ule" %arg138, %arg139 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_or_min_commute_proof : ule_or_min_commute_before ⊑ ule_or_min_commute_after := by
  unfold ule_or_min_commute_before ule_or_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ule_or_min_commute
  apply ule_or_min_commute_thm
  ---END ule_or_min_commute



def ule_swap_or_min_before := [llvm|
{
^0(%arg134 : i8, %arg135 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "uge" %arg135, %arg134 : i8
  %2 = llvm.icmp "eq" %arg134, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_swap_or_min_after := [llvm|
{
^0(%arg134 : i8, %arg135 : i8):
  %0 = llvm.icmp "uge" %arg135, %arg134 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_swap_or_min_proof : ule_swap_or_min_before ⊑ ule_swap_or_min_after := by
  unfold ule_swap_or_min_before ule_swap_or_min_after
  simp_alive_peephole
  intros
  ---BEGIN ule_swap_or_min
  apply ule_swap_or_min_thm
  ---END ule_swap_or_min



def ule_swap_or_min_logical_before := [llvm|
{
^0(%arg132 : i8, %arg133 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "uge" %arg133, %arg132 : i8
  %3 = llvm.icmp "eq" %arg132, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ule_swap_or_min_logical_after := [llvm|
{
^0(%arg132 : i8, %arg133 : i8):
  %0 = llvm.icmp "uge" %arg133, %arg132 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_swap_or_min_logical_proof : ule_swap_or_min_logical_before ⊑ ule_swap_or_min_logical_after := by
  unfold ule_swap_or_min_logical_before ule_swap_or_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ule_swap_or_min_logical
  apply ule_swap_or_min_logical_thm
  ---END ule_swap_or_min_logical



def ule_swap_or_min_commute_before := [llvm|
{
^0(%arg130 : i8, %arg131 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "uge" %arg131, %arg130 : i8
  %2 = llvm.icmp "eq" %arg130, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ule_swap_or_min_commute_after := [llvm|
{
^0(%arg130 : i8, %arg131 : i8):
  %0 = llvm.icmp "uge" %arg131, %arg130 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ule_swap_or_min_commute_proof : ule_swap_or_min_commute_before ⊑ ule_swap_or_min_commute_after := by
  unfold ule_swap_or_min_commute_before ule_swap_or_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ule_swap_or_min_commute
  apply ule_swap_or_min_commute_thm
  ---END ule_swap_or_min_commute



def slt_and_not_max_before := [llvm|
{
^0(%arg126 : i8, %arg127 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "slt" %arg126, %arg127 : i8
  %2 = llvm.icmp "ne" %arg126, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_and_not_max_after := [llvm|
{
^0(%arg126 : i8, %arg127 : i8):
  %0 = llvm.icmp "slt" %arg126, %arg127 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_and_not_max_proof : slt_and_not_max_before ⊑ slt_and_not_max_after := by
  unfold slt_and_not_max_before slt_and_not_max_after
  simp_alive_peephole
  intros
  ---BEGIN slt_and_not_max
  apply slt_and_not_max_thm
  ---END slt_and_not_max



def slt_and_not_max_logical_before := [llvm|
{
^0(%arg124 : i8, %arg125 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "slt" %arg124, %arg125 : i8
  %3 = llvm.icmp "ne" %arg124, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def slt_and_not_max_logical_after := [llvm|
{
^0(%arg124 : i8, %arg125 : i8):
  %0 = llvm.icmp "slt" %arg124, %arg125 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_and_not_max_logical_proof : slt_and_not_max_logical_before ⊑ slt_and_not_max_logical_after := by
  unfold slt_and_not_max_logical_before slt_and_not_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN slt_and_not_max_logical
  apply slt_and_not_max_logical_thm
  ---END slt_and_not_max_logical



def slt_and_not_max_commute_before := [llvm|
{
^0(%arg122 : i8, %arg123 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "slt" %arg122, %arg123 : i8
  %2 = llvm.icmp "ne" %arg122, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_and_not_max_commute_after := [llvm|
{
^0(%arg122 : i8, %arg123 : i8):
  %0 = llvm.icmp "slt" %arg122, %arg123 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_and_not_max_commute_proof : slt_and_not_max_commute_before ⊑ slt_and_not_max_commute_after := by
  unfold slt_and_not_max_commute_before slt_and_not_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN slt_and_not_max_commute
  apply slt_and_not_max_commute_thm
  ---END slt_and_not_max_commute



def slt_swap_and_not_max_before := [llvm|
{
^0(%arg118 : i8, %arg119 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sgt" %arg119, %arg118 : i8
  %2 = llvm.icmp "ne" %arg118, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_swap_and_not_max_after := [llvm|
{
^0(%arg118 : i8, %arg119 : i8):
  %0 = llvm.icmp "sgt" %arg119, %arg118 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_swap_and_not_max_proof : slt_swap_and_not_max_before ⊑ slt_swap_and_not_max_after := by
  unfold slt_swap_and_not_max_before slt_swap_and_not_max_after
  simp_alive_peephole
  intros
  ---BEGIN slt_swap_and_not_max
  apply slt_swap_and_not_max_thm
  ---END slt_swap_and_not_max



def slt_swap_and_not_max_logical_before := [llvm|
{
^0(%arg116 : i8, %arg117 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sgt" %arg117, %arg116 : i8
  %3 = llvm.icmp "ne" %arg116, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def slt_swap_and_not_max_logical_after := [llvm|
{
^0(%arg116 : i8, %arg117 : i8):
  %0 = llvm.icmp "sgt" %arg117, %arg116 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_swap_and_not_max_logical_proof : slt_swap_and_not_max_logical_before ⊑ slt_swap_and_not_max_logical_after := by
  unfold slt_swap_and_not_max_logical_before slt_swap_and_not_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN slt_swap_and_not_max_logical
  apply slt_swap_and_not_max_logical_thm
  ---END slt_swap_and_not_max_logical



def slt_swap_and_not_max_commute_before := [llvm|
{
^0(%arg114 : i8, %arg115 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sgt" %arg115, %arg114 : i8
  %2 = llvm.icmp "ne" %arg114, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_swap_and_not_max_commute_after := [llvm|
{
^0(%arg114 : i8, %arg115 : i8):
  %0 = llvm.icmp "sgt" %arg115, %arg114 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_swap_and_not_max_commute_proof : slt_swap_and_not_max_commute_before ⊑ slt_swap_and_not_max_commute_after := by
  unfold slt_swap_and_not_max_commute_before slt_swap_and_not_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN slt_swap_and_not_max_commute
  apply slt_swap_and_not_max_commute_thm
  ---END slt_swap_and_not_max_commute



def ult_and_not_max_before := [llvm|
{
^0(%arg110 : i8, %arg111 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ult" %arg110, %arg111 : i8
  %2 = llvm.icmp "ne" %arg110, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_and_not_max_after := [llvm|
{
^0(%arg110 : i8, %arg111 : i8):
  %0 = llvm.icmp "ult" %arg110, %arg111 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_and_not_max_proof : ult_and_not_max_before ⊑ ult_and_not_max_after := by
  unfold ult_and_not_max_before ult_and_not_max_after
  simp_alive_peephole
  intros
  ---BEGIN ult_and_not_max
  apply ult_and_not_max_thm
  ---END ult_and_not_max



def ult_and_not_max_logical_before := [llvm|
{
^0(%arg108 : i8, %arg109 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ult" %arg108, %arg109 : i8
  %3 = llvm.icmp "ne" %arg108, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ult_and_not_max_logical_after := [llvm|
{
^0(%arg108 : i8, %arg109 : i8):
  %0 = llvm.icmp "ult" %arg108, %arg109 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_and_not_max_logical_proof : ult_and_not_max_logical_before ⊑ ult_and_not_max_logical_after := by
  unfold ult_and_not_max_logical_before ult_and_not_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ult_and_not_max_logical
  apply ult_and_not_max_logical_thm
  ---END ult_and_not_max_logical



def ult_and_not_max_commute_before := [llvm|
{
^0(%arg106 : i8, %arg107 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ult" %arg106, %arg107 : i8
  %2 = llvm.icmp "ne" %arg106, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_and_not_max_commute_after := [llvm|
{
^0(%arg106 : i8, %arg107 : i8):
  %0 = llvm.icmp "ult" %arg106, %arg107 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_and_not_max_commute_proof : ult_and_not_max_commute_before ⊑ ult_and_not_max_commute_after := by
  unfold ult_and_not_max_commute_before ult_and_not_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ult_and_not_max_commute
  apply ult_and_not_max_commute_thm
  ---END ult_and_not_max_commute



def ult_swap_and_not_max_before := [llvm|
{
^0(%arg102 : i8, %arg103 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ugt" %arg103, %arg102 : i8
  %2 = llvm.icmp "ne" %arg102, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_swap_and_not_max_after := [llvm|
{
^0(%arg102 : i8, %arg103 : i8):
  %0 = llvm.icmp "ugt" %arg103, %arg102 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_swap_and_not_max_proof : ult_swap_and_not_max_before ⊑ ult_swap_and_not_max_after := by
  unfold ult_swap_and_not_max_before ult_swap_and_not_max_after
  simp_alive_peephole
  intros
  ---BEGIN ult_swap_and_not_max
  apply ult_swap_and_not_max_thm
  ---END ult_swap_and_not_max



def ult_swap_and_not_max_logical_before := [llvm|
{
^0(%arg100 : i8, %arg101 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ugt" %arg101, %arg100 : i8
  %3 = llvm.icmp "ne" %arg100, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ult_swap_and_not_max_logical_after := [llvm|
{
^0(%arg100 : i8, %arg101 : i8):
  %0 = llvm.icmp "ugt" %arg101, %arg100 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_swap_and_not_max_logical_proof : ult_swap_and_not_max_logical_before ⊑ ult_swap_and_not_max_logical_after := by
  unfold ult_swap_and_not_max_logical_before ult_swap_and_not_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ult_swap_and_not_max_logical
  apply ult_swap_and_not_max_logical_thm
  ---END ult_swap_and_not_max_logical



def ult_swap_and_not_max_commute_before := [llvm|
{
^0(%arg98 : i8, %arg99 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ugt" %arg99, %arg98 : i8
  %2 = llvm.icmp "ne" %arg98, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_swap_and_not_max_commute_after := [llvm|
{
^0(%arg98 : i8, %arg99 : i8):
  %0 = llvm.icmp "ugt" %arg99, %arg98 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_swap_and_not_max_commute_proof : ult_swap_and_not_max_commute_before ⊑ ult_swap_and_not_max_commute_after := by
  unfold ult_swap_and_not_max_commute_before ult_swap_and_not_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ult_swap_and_not_max_commute
  apply ult_swap_and_not_max_commute_thm
  ---END ult_swap_and_not_max_commute



def sgt_and_not_min_before := [llvm|
{
^0(%arg94 : i8, %arg95 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sgt" %arg94, %arg95 : i8
  %2 = llvm.icmp "ne" %arg94, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_and_not_min_after := [llvm|
{
^0(%arg94 : i8, %arg95 : i8):
  %0 = llvm.icmp "sgt" %arg94, %arg95 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_and_not_min_proof : sgt_and_not_min_before ⊑ sgt_and_not_min_after := by
  unfold sgt_and_not_min_before sgt_and_not_min_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_and_not_min
  apply sgt_and_not_min_thm
  ---END sgt_and_not_min



def sgt_and_not_min_logical_before := [llvm|
{
^0(%arg92 : i8, %arg93 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "sgt" %arg92, %arg93 : i8
  %3 = llvm.icmp "ne" %arg92, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sgt_and_not_min_logical_after := [llvm|
{
^0(%arg92 : i8, %arg93 : i8):
  %0 = llvm.icmp "sgt" %arg92, %arg93 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_and_not_min_logical_proof : sgt_and_not_min_logical_before ⊑ sgt_and_not_min_logical_after := by
  unfold sgt_and_not_min_logical_before sgt_and_not_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_and_not_min_logical
  apply sgt_and_not_min_logical_thm
  ---END sgt_and_not_min_logical



def sgt_and_not_min_commute_before := [llvm|
{
^0(%arg90 : i8, %arg91 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sgt" %arg90, %arg91 : i8
  %2 = llvm.icmp "ne" %arg90, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_and_not_min_commute_after := [llvm|
{
^0(%arg90 : i8, %arg91 : i8):
  %0 = llvm.icmp "sgt" %arg90, %arg91 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_and_not_min_commute_proof : sgt_and_not_min_commute_before ⊑ sgt_and_not_min_commute_after := by
  unfold sgt_and_not_min_commute_before sgt_and_not_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_and_not_min_commute
  apply sgt_and_not_min_commute_thm
  ---END sgt_and_not_min_commute



def sgt_swap_and_not_min_before := [llvm|
{
^0(%arg86 : i8, %arg87 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "slt" %arg87, %arg86 : i8
  %2 = llvm.icmp "ne" %arg86, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_swap_and_not_min_after := [llvm|
{
^0(%arg86 : i8, %arg87 : i8):
  %0 = llvm.icmp "slt" %arg87, %arg86 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_swap_and_not_min_proof : sgt_swap_and_not_min_before ⊑ sgt_swap_and_not_min_after := by
  unfold sgt_swap_and_not_min_before sgt_swap_and_not_min_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_swap_and_not_min
  apply sgt_swap_and_not_min_thm
  ---END sgt_swap_and_not_min



def sgt_swap_and_not_min_logical_before := [llvm|
{
^0(%arg84 : i8, %arg85 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "slt" %arg85, %arg84 : i8
  %3 = llvm.icmp "ne" %arg84, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sgt_swap_and_not_min_logical_after := [llvm|
{
^0(%arg84 : i8, %arg85 : i8):
  %0 = llvm.icmp "slt" %arg85, %arg84 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_swap_and_not_min_logical_proof : sgt_swap_and_not_min_logical_before ⊑ sgt_swap_and_not_min_logical_after := by
  unfold sgt_swap_and_not_min_logical_before sgt_swap_and_not_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_swap_and_not_min_logical
  apply sgt_swap_and_not_min_logical_thm
  ---END sgt_swap_and_not_min_logical



def sgt_swap_and_not_min_commute_before := [llvm|
{
^0(%arg82 : i8, %arg83 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "slt" %arg83, %arg82 : i8
  %2 = llvm.icmp "ne" %arg82, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_swap_and_not_min_commute_after := [llvm|
{
^0(%arg82 : i8, %arg83 : i8):
  %0 = llvm.icmp "slt" %arg83, %arg82 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_swap_and_not_min_commute_proof : sgt_swap_and_not_min_commute_before ⊑ sgt_swap_and_not_min_commute_after := by
  unfold sgt_swap_and_not_min_commute_before sgt_swap_and_not_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_swap_and_not_min_commute
  apply sgt_swap_and_not_min_commute_thm
  ---END sgt_swap_and_not_min_commute



def ugt_and_not_min_before := [llvm|
{
^0(%arg78 : i8, %arg79 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ugt" %arg78, %arg79 : i8
  %2 = llvm.icmp "ne" %arg78, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_and_not_min_after := [llvm|
{
^0(%arg78 : i8, %arg79 : i8):
  %0 = llvm.icmp "ugt" %arg78, %arg79 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_and_not_min_proof : ugt_and_not_min_before ⊑ ugt_and_not_min_after := by
  unfold ugt_and_not_min_before ugt_and_not_min_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_and_not_min
  apply ugt_and_not_min_thm
  ---END ugt_and_not_min



def ugt_and_not_min_logical_before := [llvm|
{
^0(%arg76 : i8, %arg77 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ugt" %arg76, %arg77 : i8
  %3 = llvm.icmp "ne" %arg76, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ugt_and_not_min_logical_after := [llvm|
{
^0(%arg76 : i8, %arg77 : i8):
  %0 = llvm.icmp "ugt" %arg76, %arg77 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_and_not_min_logical_proof : ugt_and_not_min_logical_before ⊑ ugt_and_not_min_logical_after := by
  unfold ugt_and_not_min_logical_before ugt_and_not_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_and_not_min_logical
  apply ugt_and_not_min_logical_thm
  ---END ugt_and_not_min_logical



def ugt_and_not_min_commute_before := [llvm|
{
^0(%arg74 : i8, %arg75 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ugt" %arg74, %arg75 : i8
  %2 = llvm.icmp "ne" %arg74, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_and_not_min_commute_after := [llvm|
{
^0(%arg74 : i8, %arg75 : i8):
  %0 = llvm.icmp "ugt" %arg74, %arg75 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_and_not_min_commute_proof : ugt_and_not_min_commute_before ⊑ ugt_and_not_min_commute_after := by
  unfold ugt_and_not_min_commute_before ugt_and_not_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_and_not_min_commute
  apply ugt_and_not_min_commute_thm
  ---END ugt_and_not_min_commute



def ugt_swap_and_not_min_before := [llvm|
{
^0(%arg70 : i8, %arg71 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ult" %arg71, %arg70 : i8
  %2 = llvm.icmp "ne" %arg70, %0 : i8
  %3 = llvm.and %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_swap_and_not_min_after := [llvm|
{
^0(%arg70 : i8, %arg71 : i8):
  %0 = llvm.icmp "ult" %arg71, %arg70 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_swap_and_not_min_proof : ugt_swap_and_not_min_before ⊑ ugt_swap_and_not_min_after := by
  unfold ugt_swap_and_not_min_before ugt_swap_and_not_min_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_swap_and_not_min
  apply ugt_swap_and_not_min_thm
  ---END ugt_swap_and_not_min



def ugt_swap_and_not_min_logical_before := [llvm|
{
^0(%arg68 : i8, %arg69 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ult" %arg69, %arg68 : i8
  %3 = llvm.icmp "ne" %arg68, %0 : i8
  %4 = "llvm.select"(%2, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ugt_swap_and_not_min_logical_after := [llvm|
{
^0(%arg68 : i8, %arg69 : i8):
  %0 = llvm.icmp "ult" %arg69, %arg68 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_swap_and_not_min_logical_proof : ugt_swap_and_not_min_logical_before ⊑ ugt_swap_and_not_min_logical_after := by
  unfold ugt_swap_and_not_min_logical_before ugt_swap_and_not_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_swap_and_not_min_logical
  apply ugt_swap_and_not_min_logical_thm
  ---END ugt_swap_and_not_min_logical



def ugt_swap_and_not_min_commute_before := [llvm|
{
^0(%arg66 : i8, %arg67 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ult" %arg67, %arg66 : i8
  %2 = llvm.icmp "ne" %arg66, %0 : i8
  %3 = llvm.and %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_swap_and_not_min_commute_after := [llvm|
{
^0(%arg66 : i8, %arg67 : i8):
  %0 = llvm.icmp "ult" %arg67, %arg66 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_swap_and_not_min_commute_proof : ugt_swap_and_not_min_commute_before ⊑ ugt_swap_and_not_min_commute_after := by
  unfold ugt_swap_and_not_min_commute_before ugt_swap_and_not_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_swap_and_not_min_commute
  apply ugt_swap_and_not_min_commute_thm
  ---END ugt_swap_and_not_min_commute



def slt_or_not_max_before := [llvm|
{
^0(%arg62 : i8, %arg63 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "slt" %arg62, %arg63 : i8
  %2 = llvm.icmp "ne" %arg62, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_or_not_max_after := [llvm|
{
^0(%arg62 : i8, %arg63 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "ne" %arg62, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_or_not_max_proof : slt_or_not_max_before ⊑ slt_or_not_max_after := by
  unfold slt_or_not_max_before slt_or_not_max_after
  simp_alive_peephole
  intros
  ---BEGIN slt_or_not_max
  apply slt_or_not_max_thm
  ---END slt_or_not_max



def slt_or_not_max_logical_before := [llvm|
{
^0(%arg60 : i8, %arg61 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "slt" %arg60, %arg61 : i8
  %3 = llvm.icmp "ne" %arg60, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def slt_or_not_max_logical_after := [llvm|
{
^0(%arg60 : i8, %arg61 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "ne" %arg60, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_or_not_max_logical_proof : slt_or_not_max_logical_before ⊑ slt_or_not_max_logical_after := by
  unfold slt_or_not_max_logical_before slt_or_not_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN slt_or_not_max_logical
  apply slt_or_not_max_logical_thm
  ---END slt_or_not_max_logical



def slt_or_not_max_commute_before := [llvm|
{
^0(%arg58 : i8, %arg59 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "slt" %arg58, %arg59 : i8
  %2 = llvm.icmp "ne" %arg58, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_or_not_max_commute_after := [llvm|
{
^0(%arg58 : i8, %arg59 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "ne" %arg58, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_or_not_max_commute_proof : slt_or_not_max_commute_before ⊑ slt_or_not_max_commute_after := by
  unfold slt_or_not_max_commute_before slt_or_not_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN slt_or_not_max_commute
  apply slt_or_not_max_commute_thm
  ---END slt_or_not_max_commute



def slt_or_not_max_commute_logical_before := [llvm|
{
^0(%arg56 : i8, %arg57 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "slt" %arg56, %arg57 : i8
  %3 = llvm.icmp "ne" %arg56, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def slt_or_not_max_commute_logical_after := [llvm|
{
^0(%arg56 : i8, %arg57 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "ne" %arg56, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_or_not_max_commute_logical_proof : slt_or_not_max_commute_logical_before ⊑ slt_or_not_max_commute_logical_after := by
  unfold slt_or_not_max_commute_logical_before slt_or_not_max_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN slt_or_not_max_commute_logical
  apply slt_or_not_max_commute_logical_thm
  ---END slt_or_not_max_commute_logical



def slt_swap_or_not_max_before := [llvm|
{
^0(%arg54 : i8, %arg55 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sgt" %arg55, %arg54 : i8
  %2 = llvm.icmp "ne" %arg54, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_swap_or_not_max_after := [llvm|
{
^0(%arg54 : i8, %arg55 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "ne" %arg54, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_swap_or_not_max_proof : slt_swap_or_not_max_before ⊑ slt_swap_or_not_max_after := by
  unfold slt_swap_or_not_max_before slt_swap_or_not_max_after
  simp_alive_peephole
  intros
  ---BEGIN slt_swap_or_not_max
  apply slt_swap_or_not_max_thm
  ---END slt_swap_or_not_max



def slt_swap_or_not_max_logical_before := [llvm|
{
^0(%arg52 : i8, %arg53 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sgt" %arg53, %arg52 : i8
  %3 = llvm.icmp "ne" %arg52, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def slt_swap_or_not_max_logical_after := [llvm|
{
^0(%arg52 : i8, %arg53 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "ne" %arg52, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_swap_or_not_max_logical_proof : slt_swap_or_not_max_logical_before ⊑ slt_swap_or_not_max_logical_after := by
  unfold slt_swap_or_not_max_logical_before slt_swap_or_not_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN slt_swap_or_not_max_logical
  apply slt_swap_or_not_max_logical_thm
  ---END slt_swap_or_not_max_logical



def slt_swap_or_not_max_commute_before := [llvm|
{
^0(%arg50 : i8, %arg51 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "sgt" %arg51, %arg50 : i8
  %2 = llvm.icmp "ne" %arg50, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def slt_swap_or_not_max_commute_after := [llvm|
{
^0(%arg50 : i8, %arg51 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "ne" %arg50, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_swap_or_not_max_commute_proof : slt_swap_or_not_max_commute_before ⊑ slt_swap_or_not_max_commute_after := by
  unfold slt_swap_or_not_max_commute_before slt_swap_or_not_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN slt_swap_or_not_max_commute
  apply slt_swap_or_not_max_commute_thm
  ---END slt_swap_or_not_max_commute



def slt_swap_or_not_max_commute_logical_before := [llvm|
{
^0(%arg48 : i8, %arg49 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sgt" %arg49, %arg48 : i8
  %3 = llvm.icmp "ne" %arg48, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def slt_swap_or_not_max_commute_logical_after := [llvm|
{
^0(%arg48 : i8, %arg49 : i8):
  %0 = llvm.mlir.constant(127 : i8) : i8
  %1 = llvm.icmp "ne" %arg48, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_swap_or_not_max_commute_logical_proof : slt_swap_or_not_max_commute_logical_before ⊑ slt_swap_or_not_max_commute_logical_after := by
  unfold slt_swap_or_not_max_commute_logical_before slt_swap_or_not_max_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN slt_swap_or_not_max_commute_logical
  apply slt_swap_or_not_max_commute_logical_thm
  ---END slt_swap_or_not_max_commute_logical



def ult_or_not_max_before := [llvm|
{
^0(%arg46 : i8, %arg47 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ult" %arg46, %arg47 : i8
  %2 = llvm.icmp "ne" %arg46, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_or_not_max_after := [llvm|
{
^0(%arg46 : i8, %arg47 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ne" %arg46, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_or_not_max_proof : ult_or_not_max_before ⊑ ult_or_not_max_after := by
  unfold ult_or_not_max_before ult_or_not_max_after
  simp_alive_peephole
  intros
  ---BEGIN ult_or_not_max
  apply ult_or_not_max_thm
  ---END ult_or_not_max



def ult_or_not_max_logical_before := [llvm|
{
^0(%arg44 : i8, %arg45 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ult" %arg44, %arg45 : i8
  %3 = llvm.icmp "ne" %arg44, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ult_or_not_max_logical_after := [llvm|
{
^0(%arg44 : i8, %arg45 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ne" %arg44, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_or_not_max_logical_proof : ult_or_not_max_logical_before ⊑ ult_or_not_max_logical_after := by
  unfold ult_or_not_max_logical_before ult_or_not_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ult_or_not_max_logical
  apply ult_or_not_max_logical_thm
  ---END ult_or_not_max_logical



def ult_or_not_max_commute_before := [llvm|
{
^0(%arg42 : i8, %arg43 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ult" %arg42, %arg43 : i8
  %2 = llvm.icmp "ne" %arg42, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_or_not_max_commute_after := [llvm|
{
^0(%arg42 : i8, %arg43 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ne" %arg42, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_or_not_max_commute_proof : ult_or_not_max_commute_before ⊑ ult_or_not_max_commute_after := by
  unfold ult_or_not_max_commute_before ult_or_not_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ult_or_not_max_commute
  apply ult_or_not_max_commute_thm
  ---END ult_or_not_max_commute



def ult_or_not_max_commute_logical_before := [llvm|
{
^0(%arg40 : i8, %arg41 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ult" %arg40, %arg41 : i8
  %3 = llvm.icmp "ne" %arg40, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ult_or_not_max_commute_logical_after := [llvm|
{
^0(%arg40 : i8, %arg41 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ne" %arg40, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_or_not_max_commute_logical_proof : ult_or_not_max_commute_logical_before ⊑ ult_or_not_max_commute_logical_after := by
  unfold ult_or_not_max_commute_logical_before ult_or_not_max_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ult_or_not_max_commute_logical
  apply ult_or_not_max_commute_logical_thm
  ---END ult_or_not_max_commute_logical



def ult_swap_or_not_max_before := [llvm|
{
^0(%arg38 : i8, %arg39 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ugt" %arg39, %arg38 : i8
  %2 = llvm.icmp "ne" %arg38, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_swap_or_not_max_after := [llvm|
{
^0(%arg38 : i8, %arg39 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ne" %arg38, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_swap_or_not_max_proof : ult_swap_or_not_max_before ⊑ ult_swap_or_not_max_after := by
  unfold ult_swap_or_not_max_before ult_swap_or_not_max_after
  simp_alive_peephole
  intros
  ---BEGIN ult_swap_or_not_max
  apply ult_swap_or_not_max_thm
  ---END ult_swap_or_not_max



def ult_swap_or_not_max_logical_before := [llvm|
{
^0(%arg36 : i8, %arg37 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ugt" %arg37, %arg36 : i8
  %3 = llvm.icmp "ne" %arg36, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ult_swap_or_not_max_logical_after := [llvm|
{
^0(%arg36 : i8, %arg37 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ne" %arg36, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_swap_or_not_max_logical_proof : ult_swap_or_not_max_logical_before ⊑ ult_swap_or_not_max_logical_after := by
  unfold ult_swap_or_not_max_logical_before ult_swap_or_not_max_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ult_swap_or_not_max_logical
  apply ult_swap_or_not_max_logical_thm
  ---END ult_swap_or_not_max_logical



def ult_swap_or_not_max_commute_before := [llvm|
{
^0(%arg34 : i8, %arg35 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ugt" %arg35, %arg34 : i8
  %2 = llvm.icmp "ne" %arg34, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ult_swap_or_not_max_commute_after := [llvm|
{
^0(%arg34 : i8, %arg35 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ne" %arg34, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_swap_or_not_max_commute_proof : ult_swap_or_not_max_commute_before ⊑ ult_swap_or_not_max_commute_after := by
  unfold ult_swap_or_not_max_commute_before ult_swap_or_not_max_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ult_swap_or_not_max_commute
  apply ult_swap_or_not_max_commute_thm
  ---END ult_swap_or_not_max_commute



def ult_swap_or_not_max_commute_logical_before := [llvm|
{
^0(%arg32 : i8, %arg33 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ugt" %arg33, %arg32 : i8
  %3 = llvm.icmp "ne" %arg32, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ult_swap_or_not_max_commute_logical_after := [llvm|
{
^0(%arg32 : i8, %arg33 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "ne" %arg32, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ult_swap_or_not_max_commute_logical_proof : ult_swap_or_not_max_commute_logical_before ⊑ ult_swap_or_not_max_commute_logical_after := by
  unfold ult_swap_or_not_max_commute_logical_before ult_swap_or_not_max_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ult_swap_or_not_max_commute_logical
  apply ult_swap_or_not_max_commute_logical_thm
  ---END ult_swap_or_not_max_commute_logical



def sgt_or_not_min_before := [llvm|
{
^0(%arg30 : i8, %arg31 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sgt" %arg30, %arg31 : i8
  %2 = llvm.icmp "ne" %arg30, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_or_not_min_after := [llvm|
{
^0(%arg30 : i8, %arg31 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "ne" %arg30, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_or_not_min_proof : sgt_or_not_min_before ⊑ sgt_or_not_min_after := by
  unfold sgt_or_not_min_before sgt_or_not_min_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_or_not_min
  apply sgt_or_not_min_thm
  ---END sgt_or_not_min



def sgt_or_not_min_logical_before := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sgt" %arg28, %arg29 : i8
  %3 = llvm.icmp "ne" %arg28, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sgt_or_not_min_logical_after := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "ne" %arg28, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_or_not_min_logical_proof : sgt_or_not_min_logical_before ⊑ sgt_or_not_min_logical_after := by
  unfold sgt_or_not_min_logical_before sgt_or_not_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_or_not_min_logical
  apply sgt_or_not_min_logical_thm
  ---END sgt_or_not_min_logical



def sgt_or_not_min_commute_before := [llvm|
{
^0(%arg26 : i8, %arg27 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "sgt" %arg26, %arg27 : i8
  %2 = llvm.icmp "ne" %arg26, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_or_not_min_commute_after := [llvm|
{
^0(%arg26 : i8, %arg27 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "ne" %arg26, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_or_not_min_commute_proof : sgt_or_not_min_commute_before ⊑ sgt_or_not_min_commute_after := by
  unfold sgt_or_not_min_commute_before sgt_or_not_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_or_not_min_commute
  apply sgt_or_not_min_commute_thm
  ---END sgt_or_not_min_commute



def sgt_or_not_min_commute_logical_before := [llvm|
{
^0(%arg24 : i8, %arg25 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "sgt" %arg24, %arg25 : i8
  %3 = llvm.icmp "ne" %arg24, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sgt_or_not_min_commute_logical_after := [llvm|
{
^0(%arg24 : i8, %arg25 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "ne" %arg24, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_or_not_min_commute_logical_proof : sgt_or_not_min_commute_logical_before ⊑ sgt_or_not_min_commute_logical_after := by
  unfold sgt_or_not_min_commute_logical_before sgt_or_not_min_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_or_not_min_commute_logical
  apply sgt_or_not_min_commute_logical_thm
  ---END sgt_or_not_min_commute_logical



def sgt_swap_or_not_min_before := [llvm|
{
^0(%arg22 : i8, %arg23 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "slt" %arg23, %arg22 : i8
  %2 = llvm.icmp "ne" %arg22, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_swap_or_not_min_after := [llvm|
{
^0(%arg22 : i8, %arg23 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "ne" %arg22, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_swap_or_not_min_proof : sgt_swap_or_not_min_before ⊑ sgt_swap_or_not_min_after := by
  unfold sgt_swap_or_not_min_before sgt_swap_or_not_min_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_swap_or_not_min
  apply sgt_swap_or_not_min_thm
  ---END sgt_swap_or_not_min



def sgt_swap_or_not_min_logical_before := [llvm|
{
^0(%arg20 : i8, %arg21 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "slt" %arg21, %arg20 : i8
  %3 = llvm.icmp "ne" %arg20, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sgt_swap_or_not_min_logical_after := [llvm|
{
^0(%arg20 : i8, %arg21 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "ne" %arg20, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_swap_or_not_min_logical_proof : sgt_swap_or_not_min_logical_before ⊑ sgt_swap_or_not_min_logical_after := by
  unfold sgt_swap_or_not_min_logical_before sgt_swap_or_not_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_swap_or_not_min_logical
  apply sgt_swap_or_not_min_logical_thm
  ---END sgt_swap_or_not_min_logical



def sgt_swap_or_not_min_commute_before := [llvm|
{
^0(%arg18 : i8, %arg19 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "slt" %arg19, %arg18 : i8
  %2 = llvm.icmp "ne" %arg18, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def sgt_swap_or_not_min_commute_after := [llvm|
{
^0(%arg18 : i8, %arg19 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "ne" %arg18, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_swap_or_not_min_commute_proof : sgt_swap_or_not_min_commute_before ⊑ sgt_swap_or_not_min_commute_after := by
  unfold sgt_swap_or_not_min_commute_before sgt_swap_or_not_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_swap_or_not_min_commute
  apply sgt_swap_or_not_min_commute_thm
  ---END sgt_swap_or_not_min_commute



def sgt_swap_or_not_min_commute_logical_before := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "slt" %arg17, %arg16 : i8
  %3 = llvm.icmp "ne" %arg16, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def sgt_swap_or_not_min_commute_logical_after := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(-128 : i8) : i8
  %1 = llvm.icmp "ne" %arg16, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sgt_swap_or_not_min_commute_logical_proof : sgt_swap_or_not_min_commute_logical_before ⊑ sgt_swap_or_not_min_commute_logical_after := by
  unfold sgt_swap_or_not_min_commute_logical_before sgt_swap_or_not_min_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN sgt_swap_or_not_min_commute_logical
  apply sgt_swap_or_not_min_commute_logical_thm
  ---END sgt_swap_or_not_min_commute_logical



def ugt_or_not_min_before := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ugt" %arg14, %arg15 : i8
  %2 = llvm.icmp "ne" %arg14, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_or_not_min_after := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg14, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_or_not_min_proof : ugt_or_not_min_before ⊑ ugt_or_not_min_after := by
  unfold ugt_or_not_min_before ugt_or_not_min_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_or_not_min
  apply ugt_or_not_min_thm
  ---END ugt_or_not_min



def ugt_or_not_min_logical_before := [llvm|
{
^0(%arg12 : i8, %arg13 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ugt" %arg12, %arg13 : i8
  %3 = llvm.icmp "ne" %arg12, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ugt_or_not_min_logical_after := [llvm|
{
^0(%arg12 : i8, %arg13 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg12, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_or_not_min_logical_proof : ugt_or_not_min_logical_before ⊑ ugt_or_not_min_logical_after := by
  unfold ugt_or_not_min_logical_before ugt_or_not_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_or_not_min_logical
  apply ugt_or_not_min_logical_thm
  ---END ugt_or_not_min_logical



def ugt_or_not_min_commute_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ugt" %arg10, %arg11 : i8
  %2 = llvm.icmp "ne" %arg10, %0 : i8
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_or_not_min_commute_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg10, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_or_not_min_commute_proof : ugt_or_not_min_commute_before ⊑ ugt_or_not_min_commute_after := by
  unfold ugt_or_not_min_commute_before ugt_or_not_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_or_not_min_commute
  apply ugt_or_not_min_commute_thm
  ---END ugt_or_not_min_commute



def ugt_or_not_min_commute_logical_before := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ugt" %arg8, %arg9 : i8
  %3 = llvm.icmp "ne" %arg8, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ugt_or_not_min_commute_logical_after := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg8, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_or_not_min_commute_logical_proof : ugt_or_not_min_commute_logical_before ⊑ ugt_or_not_min_commute_logical_after := by
  unfold ugt_or_not_min_commute_logical_before ugt_or_not_min_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_or_not_min_commute_logical
  apply ugt_or_not_min_commute_logical_thm
  ---END ugt_or_not_min_commute_logical



def ugt_swap_or_not_min_before := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ult" %arg7, %arg6 : i8
  %2 = llvm.icmp "ne" %arg6, %0 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_swap_or_not_min_after := [llvm|
{
^0(%arg6 : i8, %arg7 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg6, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_swap_or_not_min_proof : ugt_swap_or_not_min_before ⊑ ugt_swap_or_not_min_after := by
  unfold ugt_swap_or_not_min_before ugt_swap_or_not_min_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_swap_or_not_min
  apply ugt_swap_or_not_min_thm
  ---END ugt_swap_or_not_min



def ugt_swap_or_not_min_logical_before := [llvm|
{
^0(%arg4 : i8, %arg5 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ult" %arg5, %arg4 : i8
  %3 = llvm.icmp "ne" %arg4, %0 : i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ugt_swap_or_not_min_logical_after := [llvm|
{
^0(%arg4 : i8, %arg5 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg4, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_swap_or_not_min_logical_proof : ugt_swap_or_not_min_logical_before ⊑ ugt_swap_or_not_min_logical_after := by
  unfold ugt_swap_or_not_min_logical_before ugt_swap_or_not_min_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_swap_or_not_min_logical
  apply ugt_swap_or_not_min_logical_thm
  ---END ugt_swap_or_not_min_logical



def ugt_swap_or_not_min_commute_before := [llvm|
{
^0(%arg2 : i823, %arg3 : i823):
  %0 = llvm.mlir.constant(0 : i823) : i823
  %1 = llvm.icmp "ult" %arg3, %arg2 : i823
  %2 = llvm.icmp "ne" %arg2, %0 : i823
  %3 = llvm.or %2, %1 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def ugt_swap_or_not_min_commute_after := [llvm|
{
^0(%arg2 : i823, %arg3 : i823):
  %0 = llvm.mlir.constant(0 : i823) : i823
  %1 = llvm.icmp "ne" %arg2, %0 : i823
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_swap_or_not_min_commute_proof : ugt_swap_or_not_min_commute_before ⊑ ugt_swap_or_not_min_commute_after := by
  unfold ugt_swap_or_not_min_commute_before ugt_swap_or_not_min_commute_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_swap_or_not_min_commute
  apply ugt_swap_or_not_min_commute_thm
  ---END ugt_swap_or_not_min_commute



def ugt_swap_or_not_min_commute_logical_before := [llvm|
{
^0(%arg0 : i823, %arg1 : i823):
  %0 = llvm.mlir.constant(0 : i823) : i823
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ult" %arg1, %arg0 : i823
  %3 = llvm.icmp "ne" %arg0, %0 : i823
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def ugt_swap_or_not_min_commute_logical_after := [llvm|
{
^0(%arg0 : i823, %arg1 : i823):
  %0 = llvm.mlir.constant(0 : i823) : i823
  %1 = llvm.icmp "ne" %arg0, %0 : i823
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ugt_swap_or_not_min_commute_logical_proof : ugt_swap_or_not_min_commute_logical_before ⊑ ugt_swap_or_not_min_commute_logical_after := by
  unfold ugt_swap_or_not_min_commute_logical_before ugt_swap_or_not_min_commute_logical_after
  simp_alive_peephole
  intros
  ---BEGIN ugt_swap_or_not_min_commute_logical
  apply ugt_swap_or_not_min_commute_logical_thm
  ---END ugt_swap_or_not_min_commute_logical


