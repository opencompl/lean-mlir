import SSA.Projects.InstCombine.tests.proofs.gicmphshrhlthgt_proof
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
section gicmphshrhlthgt_statements

def lshrugt_01_00_before := [llvm|
{
^0(%arg415 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.lshr %arg415, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_00_after := [llvm|
{
^0(%arg415 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.icmp "ugt" %arg415, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_00_proof : lshrugt_01_00_before ⊑ lshrugt_01_00_after := by
  unfold lshrugt_01_00_before lshrugt_01_00_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_00
  apply lshrugt_01_00_thm
  ---END lshrugt_01_00



def lshrugt_01_01_before := [llvm|
{
^0(%arg414 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.lshr %arg414, %0 : i4
  %2 = llvm.icmp "ugt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshrugt_01_01_after := [llvm|
{
^0(%arg414 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.icmp "ugt" %arg414, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_01_proof : lshrugt_01_01_before ⊑ lshrugt_01_01_after := by
  unfold lshrugt_01_01_before lshrugt_01_01_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_01
  apply lshrugt_01_01_thm
  ---END lshrugt_01_01



def lshrugt_01_02_before := [llvm|
{
^0(%arg413 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.lshr %arg413, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_02_after := [llvm|
{
^0(%arg413 : i4):
  %0 = llvm.mlir.constant(5 : i4) : i4
  %1 = llvm.icmp "ugt" %arg413, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_02_proof : lshrugt_01_02_before ⊑ lshrugt_01_02_after := by
  unfold lshrugt_01_02_before lshrugt_01_02_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_02
  apply lshrugt_01_02_thm
  ---END lshrugt_01_02



def lshrugt_01_03_before := [llvm|
{
^0(%arg412 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.lshr %arg412, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_03_after := [llvm|
{
^0(%arg412 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg412, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_03_proof : lshrugt_01_03_before ⊑ lshrugt_01_03_after := by
  unfold lshrugt_01_03_before lshrugt_01_03_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_03
  apply lshrugt_01_03_thm
  ---END lshrugt_01_03



def lshrugt_01_04_before := [llvm|
{
^0(%arg411 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.lshr %arg411, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_04_after := [llvm|
{
^0(%arg411 : i4):
  %0 = llvm.mlir.constant(-7 : i4) : i4
  %1 = llvm.icmp "ugt" %arg411, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_04_proof : lshrugt_01_04_before ⊑ lshrugt_01_04_after := by
  unfold lshrugt_01_04_before lshrugt_01_04_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_04
  apply lshrugt_01_04_thm
  ---END lshrugt_01_04



def lshrugt_01_05_before := [llvm|
{
^0(%arg410 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.lshr %arg410, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_05_after := [llvm|
{
^0(%arg410 : i4):
  %0 = llvm.mlir.constant(-5 : i4) : i4
  %1 = llvm.icmp "ugt" %arg410, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_05_proof : lshrugt_01_05_before ⊑ lshrugt_01_05_after := by
  unfold lshrugt_01_05_before lshrugt_01_05_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_05
  apply lshrugt_01_05_thm
  ---END lshrugt_01_05



def lshrugt_01_06_before := [llvm|
{
^0(%arg409 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.lshr %arg409, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_06_after := [llvm|
{
^0(%arg409 : i4):
  %0 = llvm.mlir.constant(-3 : i4) : i4
  %1 = llvm.icmp "ugt" %arg409, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_06_proof : lshrugt_01_06_before ⊑ lshrugt_01_06_after := by
  unfold lshrugt_01_06_before lshrugt_01_06_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_06
  apply lshrugt_01_06_thm
  ---END lshrugt_01_06



def lshrugt_01_07_before := [llvm|
{
^0(%arg408 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.lshr %arg408, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_07_after := [llvm|
{
^0(%arg408 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_07_proof : lshrugt_01_07_before ⊑ lshrugt_01_07_after := by
  unfold lshrugt_01_07_before lshrugt_01_07_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_07
  apply lshrugt_01_07_thm
  ---END lshrugt_01_07



def lshrugt_01_08_before := [llvm|
{
^0(%arg407 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.lshr %arg407, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_08_after := [llvm|
{
^0(%arg407 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_08_proof : lshrugt_01_08_before ⊑ lshrugt_01_08_after := by
  unfold lshrugt_01_08_before lshrugt_01_08_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_08
  apply lshrugt_01_08_thm
  ---END lshrugt_01_08



def lshrugt_01_09_before := [llvm|
{
^0(%arg406 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.lshr %arg406, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_09_after := [llvm|
{
^0(%arg406 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_09_proof : lshrugt_01_09_before ⊑ lshrugt_01_09_after := by
  unfold lshrugt_01_09_before lshrugt_01_09_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_09
  apply lshrugt_01_09_thm
  ---END lshrugt_01_09



def lshrugt_01_10_before := [llvm|
{
^0(%arg405 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.lshr %arg405, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_10_after := [llvm|
{
^0(%arg405 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_10_proof : lshrugt_01_10_before ⊑ lshrugt_01_10_after := by
  unfold lshrugt_01_10_before lshrugt_01_10_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_10
  apply lshrugt_01_10_thm
  ---END lshrugt_01_10



def lshrugt_01_11_before := [llvm|
{
^0(%arg404 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.lshr %arg404, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_11_after := [llvm|
{
^0(%arg404 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_11_proof : lshrugt_01_11_before ⊑ lshrugt_01_11_after := by
  unfold lshrugt_01_11_before lshrugt_01_11_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_11
  apply lshrugt_01_11_thm
  ---END lshrugt_01_11



def lshrugt_01_12_before := [llvm|
{
^0(%arg403 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.lshr %arg403, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_12_after := [llvm|
{
^0(%arg403 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_12_proof : lshrugt_01_12_before ⊑ lshrugt_01_12_after := by
  unfold lshrugt_01_12_before lshrugt_01_12_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_12
  apply lshrugt_01_12_thm
  ---END lshrugt_01_12



def lshrugt_01_13_before := [llvm|
{
^0(%arg402 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.lshr %arg402, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_13_after := [llvm|
{
^0(%arg402 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_13_proof : lshrugt_01_13_before ⊑ lshrugt_01_13_after := by
  unfold lshrugt_01_13_before lshrugt_01_13_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_13
  apply lshrugt_01_13_thm
  ---END lshrugt_01_13



def lshrugt_01_14_before := [llvm|
{
^0(%arg401 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.lshr %arg401, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_14_after := [llvm|
{
^0(%arg401 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_14_proof : lshrugt_01_14_before ⊑ lshrugt_01_14_after := by
  unfold lshrugt_01_14_before lshrugt_01_14_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_14
  apply lshrugt_01_14_thm
  ---END lshrugt_01_14



def lshrugt_01_15_before := [llvm|
{
^0(%arg400 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.lshr %arg400, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_15_after := [llvm|
{
^0(%arg400 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_15_proof : lshrugt_01_15_before ⊑ lshrugt_01_15_after := by
  unfold lshrugt_01_15_before lshrugt_01_15_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_15
  apply lshrugt_01_15_thm
  ---END lshrugt_01_15



def lshrugt_02_00_before := [llvm|
{
^0(%arg399 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.lshr %arg399, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_00_after := [llvm|
{
^0(%arg399 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.icmp "ugt" %arg399, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_00_proof : lshrugt_02_00_before ⊑ lshrugt_02_00_after := by
  unfold lshrugt_02_00_before lshrugt_02_00_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_00
  apply lshrugt_02_00_thm
  ---END lshrugt_02_00



def lshrugt_02_01_before := [llvm|
{
^0(%arg398 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.lshr %arg398, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_01_after := [llvm|
{
^0(%arg398 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg398, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_01_proof : lshrugt_02_01_before ⊑ lshrugt_02_01_after := by
  unfold lshrugt_02_01_before lshrugt_02_01_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_01
  apply lshrugt_02_01_thm
  ---END lshrugt_02_01



def lshrugt_02_02_before := [llvm|
{
^0(%arg397 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.lshr %arg397, %0 : i4
  %2 = llvm.icmp "ugt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshrugt_02_02_after := [llvm|
{
^0(%arg397 : i4):
  %0 = llvm.mlir.constant(-5 : i4) : i4
  %1 = llvm.icmp "ugt" %arg397, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_02_proof : lshrugt_02_02_before ⊑ lshrugt_02_02_after := by
  unfold lshrugt_02_02_before lshrugt_02_02_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_02
  apply lshrugt_02_02_thm
  ---END lshrugt_02_02



def lshrugt_02_03_before := [llvm|
{
^0(%arg396 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.lshr %arg396, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_03_after := [llvm|
{
^0(%arg396 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_03_proof : lshrugt_02_03_before ⊑ lshrugt_02_03_after := by
  unfold lshrugt_02_03_before lshrugt_02_03_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_03
  apply lshrugt_02_03_thm
  ---END lshrugt_02_03



def lshrugt_02_04_before := [llvm|
{
^0(%arg395 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.lshr %arg395, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_04_after := [llvm|
{
^0(%arg395 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_04_proof : lshrugt_02_04_before ⊑ lshrugt_02_04_after := by
  unfold lshrugt_02_04_before lshrugt_02_04_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_04
  apply lshrugt_02_04_thm
  ---END lshrugt_02_04



def lshrugt_02_05_before := [llvm|
{
^0(%arg394 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.lshr %arg394, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_05_after := [llvm|
{
^0(%arg394 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_05_proof : lshrugt_02_05_before ⊑ lshrugt_02_05_after := by
  unfold lshrugt_02_05_before lshrugt_02_05_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_05
  apply lshrugt_02_05_thm
  ---END lshrugt_02_05



def lshrugt_02_06_before := [llvm|
{
^0(%arg393 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.lshr %arg393, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_06_after := [llvm|
{
^0(%arg393 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_06_proof : lshrugt_02_06_before ⊑ lshrugt_02_06_after := by
  unfold lshrugt_02_06_before lshrugt_02_06_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_06
  apply lshrugt_02_06_thm
  ---END lshrugt_02_06



def lshrugt_02_07_before := [llvm|
{
^0(%arg392 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.lshr %arg392, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_07_after := [llvm|
{
^0(%arg392 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_07_proof : lshrugt_02_07_before ⊑ lshrugt_02_07_after := by
  unfold lshrugt_02_07_before lshrugt_02_07_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_07
  apply lshrugt_02_07_thm
  ---END lshrugt_02_07



def lshrugt_02_08_before := [llvm|
{
^0(%arg391 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.lshr %arg391, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_08_after := [llvm|
{
^0(%arg391 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_08_proof : lshrugt_02_08_before ⊑ lshrugt_02_08_after := by
  unfold lshrugt_02_08_before lshrugt_02_08_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_08
  apply lshrugt_02_08_thm
  ---END lshrugt_02_08



def lshrugt_02_09_before := [llvm|
{
^0(%arg390 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.lshr %arg390, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_09_after := [llvm|
{
^0(%arg390 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_09_proof : lshrugt_02_09_before ⊑ lshrugt_02_09_after := by
  unfold lshrugt_02_09_before lshrugt_02_09_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_09
  apply lshrugt_02_09_thm
  ---END lshrugt_02_09



def lshrugt_02_10_before := [llvm|
{
^0(%arg389 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.lshr %arg389, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_10_after := [llvm|
{
^0(%arg389 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_10_proof : lshrugt_02_10_before ⊑ lshrugt_02_10_after := by
  unfold lshrugt_02_10_before lshrugt_02_10_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_10
  apply lshrugt_02_10_thm
  ---END lshrugt_02_10



def lshrugt_02_11_before := [llvm|
{
^0(%arg388 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.lshr %arg388, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_11_after := [llvm|
{
^0(%arg388 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_11_proof : lshrugt_02_11_before ⊑ lshrugt_02_11_after := by
  unfold lshrugt_02_11_before lshrugt_02_11_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_11
  apply lshrugt_02_11_thm
  ---END lshrugt_02_11



def lshrugt_02_12_before := [llvm|
{
^0(%arg387 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.lshr %arg387, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_12_after := [llvm|
{
^0(%arg387 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_12_proof : lshrugt_02_12_before ⊑ lshrugt_02_12_after := by
  unfold lshrugt_02_12_before lshrugt_02_12_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_12
  apply lshrugt_02_12_thm
  ---END lshrugt_02_12



def lshrugt_02_13_before := [llvm|
{
^0(%arg386 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.lshr %arg386, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_13_after := [llvm|
{
^0(%arg386 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_13_proof : lshrugt_02_13_before ⊑ lshrugt_02_13_after := by
  unfold lshrugt_02_13_before lshrugt_02_13_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_13
  apply lshrugt_02_13_thm
  ---END lshrugt_02_13



def lshrugt_02_14_before := [llvm|
{
^0(%arg385 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.lshr %arg385, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_14_after := [llvm|
{
^0(%arg385 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_14_proof : lshrugt_02_14_before ⊑ lshrugt_02_14_after := by
  unfold lshrugt_02_14_before lshrugt_02_14_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_14
  apply lshrugt_02_14_thm
  ---END lshrugt_02_14



def lshrugt_02_15_before := [llvm|
{
^0(%arg384 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.lshr %arg384, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_15_after := [llvm|
{
^0(%arg384 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_15_proof : lshrugt_02_15_before ⊑ lshrugt_02_15_after := by
  unfold lshrugt_02_15_before lshrugt_02_15_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_15
  apply lshrugt_02_15_thm
  ---END lshrugt_02_15



def lshrugt_03_00_before := [llvm|
{
^0(%arg383 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.lshr %arg383, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_00_after := [llvm|
{
^0(%arg383 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg383, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_00_proof : lshrugt_03_00_before ⊑ lshrugt_03_00_after := by
  unfold lshrugt_03_00_before lshrugt_03_00_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_00
  apply lshrugt_03_00_thm
  ---END lshrugt_03_00



def lshrugt_03_01_before := [llvm|
{
^0(%arg382 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.lshr %arg382, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_01_after := [llvm|
{
^0(%arg382 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_01_proof : lshrugt_03_01_before ⊑ lshrugt_03_01_after := by
  unfold lshrugt_03_01_before lshrugt_03_01_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_01
  apply lshrugt_03_01_thm
  ---END lshrugt_03_01



def lshrugt_03_02_before := [llvm|
{
^0(%arg381 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.lshr %arg381, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_02_after := [llvm|
{
^0(%arg381 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_02_proof : lshrugt_03_02_before ⊑ lshrugt_03_02_after := by
  unfold lshrugt_03_02_before lshrugt_03_02_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_02
  apply lshrugt_03_02_thm
  ---END lshrugt_03_02



def lshrugt_03_03_before := [llvm|
{
^0(%arg380 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.lshr %arg380, %0 : i4
  %2 = llvm.icmp "ugt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshrugt_03_03_after := [llvm|
{
^0(%arg380 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_03_proof : lshrugt_03_03_before ⊑ lshrugt_03_03_after := by
  unfold lshrugt_03_03_before lshrugt_03_03_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_03
  apply lshrugt_03_03_thm
  ---END lshrugt_03_03



def lshrugt_03_04_before := [llvm|
{
^0(%arg379 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.lshr %arg379, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_04_after := [llvm|
{
^0(%arg379 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_04_proof : lshrugt_03_04_before ⊑ lshrugt_03_04_after := by
  unfold lshrugt_03_04_before lshrugt_03_04_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_04
  apply lshrugt_03_04_thm
  ---END lshrugt_03_04



def lshrugt_03_05_before := [llvm|
{
^0(%arg378 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.lshr %arg378, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_05_after := [llvm|
{
^0(%arg378 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_05_proof : lshrugt_03_05_before ⊑ lshrugt_03_05_after := by
  unfold lshrugt_03_05_before lshrugt_03_05_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_05
  apply lshrugt_03_05_thm
  ---END lshrugt_03_05



def lshrugt_03_06_before := [llvm|
{
^0(%arg377 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.lshr %arg377, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_06_after := [llvm|
{
^0(%arg377 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_06_proof : lshrugt_03_06_before ⊑ lshrugt_03_06_after := by
  unfold lshrugt_03_06_before lshrugt_03_06_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_06
  apply lshrugt_03_06_thm
  ---END lshrugt_03_06



def lshrugt_03_07_before := [llvm|
{
^0(%arg376 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.lshr %arg376, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_07_after := [llvm|
{
^0(%arg376 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_07_proof : lshrugt_03_07_before ⊑ lshrugt_03_07_after := by
  unfold lshrugt_03_07_before lshrugt_03_07_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_07
  apply lshrugt_03_07_thm
  ---END lshrugt_03_07



def lshrugt_03_08_before := [llvm|
{
^0(%arg375 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.lshr %arg375, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_08_after := [llvm|
{
^0(%arg375 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_08_proof : lshrugt_03_08_before ⊑ lshrugt_03_08_after := by
  unfold lshrugt_03_08_before lshrugt_03_08_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_08
  apply lshrugt_03_08_thm
  ---END lshrugt_03_08



def lshrugt_03_09_before := [llvm|
{
^0(%arg374 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.lshr %arg374, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_09_after := [llvm|
{
^0(%arg374 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_09_proof : lshrugt_03_09_before ⊑ lshrugt_03_09_after := by
  unfold lshrugt_03_09_before lshrugt_03_09_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_09
  apply lshrugt_03_09_thm
  ---END lshrugt_03_09



def lshrugt_03_10_before := [llvm|
{
^0(%arg373 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.lshr %arg373, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_10_after := [llvm|
{
^0(%arg373 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_10_proof : lshrugt_03_10_before ⊑ lshrugt_03_10_after := by
  unfold lshrugt_03_10_before lshrugt_03_10_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_10
  apply lshrugt_03_10_thm
  ---END lshrugt_03_10



def lshrugt_03_11_before := [llvm|
{
^0(%arg372 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.lshr %arg372, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_11_after := [llvm|
{
^0(%arg372 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_11_proof : lshrugt_03_11_before ⊑ lshrugt_03_11_after := by
  unfold lshrugt_03_11_before lshrugt_03_11_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_11
  apply lshrugt_03_11_thm
  ---END lshrugt_03_11



def lshrugt_03_12_before := [llvm|
{
^0(%arg371 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.lshr %arg371, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_12_after := [llvm|
{
^0(%arg371 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_12_proof : lshrugt_03_12_before ⊑ lshrugt_03_12_after := by
  unfold lshrugt_03_12_before lshrugt_03_12_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_12
  apply lshrugt_03_12_thm
  ---END lshrugt_03_12



def lshrugt_03_13_before := [llvm|
{
^0(%arg370 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.lshr %arg370, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_13_after := [llvm|
{
^0(%arg370 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_13_proof : lshrugt_03_13_before ⊑ lshrugt_03_13_after := by
  unfold lshrugt_03_13_before lshrugt_03_13_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_13
  apply lshrugt_03_13_thm
  ---END lshrugt_03_13



def lshrugt_03_14_before := [llvm|
{
^0(%arg369 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.lshr %arg369, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_14_after := [llvm|
{
^0(%arg369 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_14_proof : lshrugt_03_14_before ⊑ lshrugt_03_14_after := by
  unfold lshrugt_03_14_before lshrugt_03_14_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_14
  apply lshrugt_03_14_thm
  ---END lshrugt_03_14



def lshrugt_03_15_before := [llvm|
{
^0(%arg368 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.lshr %arg368, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_15_after := [llvm|
{
^0(%arg368 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_15_proof : lshrugt_03_15_before ⊑ lshrugt_03_15_after := by
  unfold lshrugt_03_15_before lshrugt_03_15_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_15
  apply lshrugt_03_15_thm
  ---END lshrugt_03_15



def lshrult_01_00_before := [llvm|
{
^0(%arg367 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.lshr %arg367, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_00_after := [llvm|
{
^0(%arg367 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_00_proof : lshrult_01_00_before ⊑ lshrult_01_00_after := by
  unfold lshrult_01_00_before lshrult_01_00_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_00
  apply lshrult_01_00_thm
  ---END lshrult_01_00



def lshrult_01_01_before := [llvm|
{
^0(%arg366 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.lshr %arg366, %0 : i4
  %2 = llvm.icmp "ult" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshrult_01_01_after := [llvm|
{
^0(%arg366 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.icmp "ult" %arg366, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_01_proof : lshrult_01_01_before ⊑ lshrult_01_01_after := by
  unfold lshrult_01_01_before lshrult_01_01_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_01
  apply lshrult_01_01_thm
  ---END lshrult_01_01



def lshrult_01_02_before := [llvm|
{
^0(%arg365 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.lshr %arg365, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_02_after := [llvm|
{
^0(%arg365 : i4):
  %0 = llvm.mlir.constant(4 : i4) : i4
  %1 = llvm.icmp "ult" %arg365, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_02_proof : lshrult_01_02_before ⊑ lshrult_01_02_after := by
  unfold lshrult_01_02_before lshrult_01_02_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_02
  apply lshrult_01_02_thm
  ---END lshrult_01_02



def lshrult_01_03_before := [llvm|
{
^0(%arg364 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.lshr %arg364, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_03_after := [llvm|
{
^0(%arg364 : i4):
  %0 = llvm.mlir.constant(6 : i4) : i4
  %1 = llvm.icmp "ult" %arg364, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_03_proof : lshrult_01_03_before ⊑ lshrult_01_03_after := by
  unfold lshrult_01_03_before lshrult_01_03_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_03
  apply lshrult_01_03_thm
  ---END lshrult_01_03



def lshrult_01_04_before := [llvm|
{
^0(%arg363 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.lshr %arg363, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_04_after := [llvm|
{
^0(%arg363 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg363, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_04_proof : lshrult_01_04_before ⊑ lshrult_01_04_after := by
  unfold lshrult_01_04_before lshrult_01_04_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_04
  apply lshrult_01_04_thm
  ---END lshrult_01_04



def lshrult_01_05_before := [llvm|
{
^0(%arg362 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.lshr %arg362, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_05_after := [llvm|
{
^0(%arg362 : i4):
  %0 = llvm.mlir.constant(-6 : i4) : i4
  %1 = llvm.icmp "ult" %arg362, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_05_proof : lshrult_01_05_before ⊑ lshrult_01_05_after := by
  unfold lshrult_01_05_before lshrult_01_05_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_05
  apply lshrult_01_05_thm
  ---END lshrult_01_05



def lshrult_01_06_before := [llvm|
{
^0(%arg361 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.lshr %arg361, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_06_after := [llvm|
{
^0(%arg361 : i4):
  %0 = llvm.mlir.constant(-4 : i4) : i4
  %1 = llvm.icmp "ult" %arg361, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_06_proof : lshrult_01_06_before ⊑ lshrult_01_06_after := by
  unfold lshrult_01_06_before lshrult_01_06_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_06
  apply lshrult_01_06_thm
  ---END lshrult_01_06



def lshrult_01_07_before := [llvm|
{
^0(%arg360 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.lshr %arg360, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_07_after := [llvm|
{
^0(%arg360 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.icmp "ult" %arg360, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_07_proof : lshrult_01_07_before ⊑ lshrult_01_07_after := by
  unfold lshrult_01_07_before lshrult_01_07_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_07
  apply lshrult_01_07_thm
  ---END lshrult_01_07



def lshrult_01_08_before := [llvm|
{
^0(%arg359 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.lshr %arg359, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_08_after := [llvm|
{
^0(%arg359 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_08_proof : lshrult_01_08_before ⊑ lshrult_01_08_after := by
  unfold lshrult_01_08_before lshrult_01_08_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_08
  apply lshrult_01_08_thm
  ---END lshrult_01_08



def lshrult_01_09_before := [llvm|
{
^0(%arg358 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.lshr %arg358, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_09_after := [llvm|
{
^0(%arg358 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_09_proof : lshrult_01_09_before ⊑ lshrult_01_09_after := by
  unfold lshrult_01_09_before lshrult_01_09_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_09
  apply lshrult_01_09_thm
  ---END lshrult_01_09



def lshrult_01_10_before := [llvm|
{
^0(%arg357 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.lshr %arg357, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_10_after := [llvm|
{
^0(%arg357 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_10_proof : lshrult_01_10_before ⊑ lshrult_01_10_after := by
  unfold lshrult_01_10_before lshrult_01_10_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_10
  apply lshrult_01_10_thm
  ---END lshrult_01_10



def lshrult_01_11_before := [llvm|
{
^0(%arg356 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.lshr %arg356, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_11_after := [llvm|
{
^0(%arg356 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_11_proof : lshrult_01_11_before ⊑ lshrult_01_11_after := by
  unfold lshrult_01_11_before lshrult_01_11_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_11
  apply lshrult_01_11_thm
  ---END lshrult_01_11



def lshrult_01_12_before := [llvm|
{
^0(%arg355 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.lshr %arg355, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_12_after := [llvm|
{
^0(%arg355 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_12_proof : lshrult_01_12_before ⊑ lshrult_01_12_after := by
  unfold lshrult_01_12_before lshrult_01_12_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_12
  apply lshrult_01_12_thm
  ---END lshrult_01_12



def lshrult_01_13_before := [llvm|
{
^0(%arg354 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.lshr %arg354, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_13_after := [llvm|
{
^0(%arg354 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_13_proof : lshrult_01_13_before ⊑ lshrult_01_13_after := by
  unfold lshrult_01_13_before lshrult_01_13_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_13
  apply lshrult_01_13_thm
  ---END lshrult_01_13



def lshrult_01_14_before := [llvm|
{
^0(%arg353 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.lshr %arg353, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_14_after := [llvm|
{
^0(%arg353 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_14_proof : lshrult_01_14_before ⊑ lshrult_01_14_after := by
  unfold lshrult_01_14_before lshrult_01_14_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_14
  apply lshrult_01_14_thm
  ---END lshrult_01_14



def lshrult_01_15_before := [llvm|
{
^0(%arg352 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.lshr %arg352, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_15_after := [llvm|
{
^0(%arg352 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_15_proof : lshrult_01_15_before ⊑ lshrult_01_15_after := by
  unfold lshrult_01_15_before lshrult_01_15_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_15
  apply lshrult_01_15_thm
  ---END lshrult_01_15



def lshrult_02_00_before := [llvm|
{
^0(%arg351 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.lshr %arg351, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_00_after := [llvm|
{
^0(%arg351 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_00_proof : lshrult_02_00_before ⊑ lshrult_02_00_after := by
  unfold lshrult_02_00_before lshrult_02_00_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_00
  apply lshrult_02_00_thm
  ---END lshrult_02_00



def lshrult_02_01_before := [llvm|
{
^0(%arg350 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.lshr %arg350, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_01_after := [llvm|
{
^0(%arg350 : i4):
  %0 = llvm.mlir.constant(4 : i4) : i4
  %1 = llvm.icmp "ult" %arg350, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_01_proof : lshrult_02_01_before ⊑ lshrult_02_01_after := by
  unfold lshrult_02_01_before lshrult_02_01_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_01
  apply lshrult_02_01_thm
  ---END lshrult_02_01



def lshrult_02_02_before := [llvm|
{
^0(%arg349 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.lshr %arg349, %0 : i4
  %2 = llvm.icmp "ult" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshrult_02_02_after := [llvm|
{
^0(%arg349 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg349, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_02_proof : lshrult_02_02_before ⊑ lshrult_02_02_after := by
  unfold lshrult_02_02_before lshrult_02_02_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_02
  apply lshrult_02_02_thm
  ---END lshrult_02_02



def lshrult_02_03_before := [llvm|
{
^0(%arg348 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.lshr %arg348, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_03_after := [llvm|
{
^0(%arg348 : i4):
  %0 = llvm.mlir.constant(-4 : i4) : i4
  %1 = llvm.icmp "ult" %arg348, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_03_proof : lshrult_02_03_before ⊑ lshrult_02_03_after := by
  unfold lshrult_02_03_before lshrult_02_03_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_03
  apply lshrult_02_03_thm
  ---END lshrult_02_03



def lshrult_02_04_before := [llvm|
{
^0(%arg347 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.lshr %arg347, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_04_after := [llvm|
{
^0(%arg347 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_04_proof : lshrult_02_04_before ⊑ lshrult_02_04_after := by
  unfold lshrult_02_04_before lshrult_02_04_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_04
  apply lshrult_02_04_thm
  ---END lshrult_02_04



def lshrult_02_05_before := [llvm|
{
^0(%arg346 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.lshr %arg346, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_05_after := [llvm|
{
^0(%arg346 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_05_proof : lshrult_02_05_before ⊑ lshrult_02_05_after := by
  unfold lshrult_02_05_before lshrult_02_05_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_05
  apply lshrult_02_05_thm
  ---END lshrult_02_05



def lshrult_02_06_before := [llvm|
{
^0(%arg345 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.lshr %arg345, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_06_after := [llvm|
{
^0(%arg345 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_06_proof : lshrult_02_06_before ⊑ lshrult_02_06_after := by
  unfold lshrult_02_06_before lshrult_02_06_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_06
  apply lshrult_02_06_thm
  ---END lshrult_02_06



def lshrult_02_07_before := [llvm|
{
^0(%arg344 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.lshr %arg344, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_07_after := [llvm|
{
^0(%arg344 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_07_proof : lshrult_02_07_before ⊑ lshrult_02_07_after := by
  unfold lshrult_02_07_before lshrult_02_07_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_07
  apply lshrult_02_07_thm
  ---END lshrult_02_07



def lshrult_02_08_before := [llvm|
{
^0(%arg343 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.lshr %arg343, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_08_after := [llvm|
{
^0(%arg343 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_08_proof : lshrult_02_08_before ⊑ lshrult_02_08_after := by
  unfold lshrult_02_08_before lshrult_02_08_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_08
  apply lshrult_02_08_thm
  ---END lshrult_02_08



def lshrult_02_09_before := [llvm|
{
^0(%arg342 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.lshr %arg342, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_09_after := [llvm|
{
^0(%arg342 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_09_proof : lshrult_02_09_before ⊑ lshrult_02_09_after := by
  unfold lshrult_02_09_before lshrult_02_09_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_09
  apply lshrult_02_09_thm
  ---END lshrult_02_09



def lshrult_02_10_before := [llvm|
{
^0(%arg341 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.lshr %arg341, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_10_after := [llvm|
{
^0(%arg341 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_10_proof : lshrult_02_10_before ⊑ lshrult_02_10_after := by
  unfold lshrult_02_10_before lshrult_02_10_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_10
  apply lshrult_02_10_thm
  ---END lshrult_02_10



def lshrult_02_11_before := [llvm|
{
^0(%arg340 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.lshr %arg340, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_11_after := [llvm|
{
^0(%arg340 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_11_proof : lshrult_02_11_before ⊑ lshrult_02_11_after := by
  unfold lshrult_02_11_before lshrult_02_11_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_11
  apply lshrult_02_11_thm
  ---END lshrult_02_11



def lshrult_02_12_before := [llvm|
{
^0(%arg339 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.lshr %arg339, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_12_after := [llvm|
{
^0(%arg339 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_12_proof : lshrult_02_12_before ⊑ lshrult_02_12_after := by
  unfold lshrult_02_12_before lshrult_02_12_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_12
  apply lshrult_02_12_thm
  ---END lshrult_02_12



def lshrult_02_13_before := [llvm|
{
^0(%arg338 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.lshr %arg338, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_13_after := [llvm|
{
^0(%arg338 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_13_proof : lshrult_02_13_before ⊑ lshrult_02_13_after := by
  unfold lshrult_02_13_before lshrult_02_13_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_13
  apply lshrult_02_13_thm
  ---END lshrult_02_13



def lshrult_02_14_before := [llvm|
{
^0(%arg337 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.lshr %arg337, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_14_after := [llvm|
{
^0(%arg337 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_14_proof : lshrult_02_14_before ⊑ lshrult_02_14_after := by
  unfold lshrult_02_14_before lshrult_02_14_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_14
  apply lshrult_02_14_thm
  ---END lshrult_02_14



def lshrult_02_15_before := [llvm|
{
^0(%arg336 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.lshr %arg336, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_15_after := [llvm|
{
^0(%arg336 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_15_proof : lshrult_02_15_before ⊑ lshrult_02_15_after := by
  unfold lshrult_02_15_before lshrult_02_15_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_15
  apply lshrult_02_15_thm
  ---END lshrult_02_15



def lshrult_03_00_before := [llvm|
{
^0(%arg335 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.lshr %arg335, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_00_after := [llvm|
{
^0(%arg335 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_00_proof : lshrult_03_00_before ⊑ lshrult_03_00_after := by
  unfold lshrult_03_00_before lshrult_03_00_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_00
  apply lshrult_03_00_thm
  ---END lshrult_03_00



def lshrult_03_01_before := [llvm|
{
^0(%arg334 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.lshr %arg334, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_01_after := [llvm|
{
^0(%arg334 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg334, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_01_proof : lshrult_03_01_before ⊑ lshrult_03_01_after := by
  unfold lshrult_03_01_before lshrult_03_01_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_01
  apply lshrult_03_01_thm
  ---END lshrult_03_01



def lshrult_03_02_before := [llvm|
{
^0(%arg333 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.lshr %arg333, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_02_after := [llvm|
{
^0(%arg333 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_02_proof : lshrult_03_02_before ⊑ lshrult_03_02_after := by
  unfold lshrult_03_02_before lshrult_03_02_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_02
  apply lshrult_03_02_thm
  ---END lshrult_03_02



def lshrult_03_03_before := [llvm|
{
^0(%arg332 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.lshr %arg332, %0 : i4
  %2 = llvm.icmp "ult" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshrult_03_03_after := [llvm|
{
^0(%arg332 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_03_proof : lshrult_03_03_before ⊑ lshrult_03_03_after := by
  unfold lshrult_03_03_before lshrult_03_03_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_03
  apply lshrult_03_03_thm
  ---END lshrult_03_03



def lshrult_03_04_before := [llvm|
{
^0(%arg331 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.lshr %arg331, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_04_after := [llvm|
{
^0(%arg331 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_04_proof : lshrult_03_04_before ⊑ lshrult_03_04_after := by
  unfold lshrult_03_04_before lshrult_03_04_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_04
  apply lshrult_03_04_thm
  ---END lshrult_03_04



def lshrult_03_05_before := [llvm|
{
^0(%arg330 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.lshr %arg330, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_05_after := [llvm|
{
^0(%arg330 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_05_proof : lshrult_03_05_before ⊑ lshrult_03_05_after := by
  unfold lshrult_03_05_before lshrult_03_05_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_05
  apply lshrult_03_05_thm
  ---END lshrult_03_05



def lshrult_03_06_before := [llvm|
{
^0(%arg329 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.lshr %arg329, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_06_after := [llvm|
{
^0(%arg329 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_06_proof : lshrult_03_06_before ⊑ lshrult_03_06_after := by
  unfold lshrult_03_06_before lshrult_03_06_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_06
  apply lshrult_03_06_thm
  ---END lshrult_03_06



def lshrult_03_07_before := [llvm|
{
^0(%arg328 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.lshr %arg328, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_07_after := [llvm|
{
^0(%arg328 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_07_proof : lshrult_03_07_before ⊑ lshrult_03_07_after := by
  unfold lshrult_03_07_before lshrult_03_07_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_07
  apply lshrult_03_07_thm
  ---END lshrult_03_07



def lshrult_03_08_before := [llvm|
{
^0(%arg327 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.lshr %arg327, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_08_after := [llvm|
{
^0(%arg327 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_08_proof : lshrult_03_08_before ⊑ lshrult_03_08_after := by
  unfold lshrult_03_08_before lshrult_03_08_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_08
  apply lshrult_03_08_thm
  ---END lshrult_03_08



def lshrult_03_09_before := [llvm|
{
^0(%arg326 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.lshr %arg326, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_09_after := [llvm|
{
^0(%arg326 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_09_proof : lshrult_03_09_before ⊑ lshrult_03_09_after := by
  unfold lshrult_03_09_before lshrult_03_09_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_09
  apply lshrult_03_09_thm
  ---END lshrult_03_09



def lshrult_03_10_before := [llvm|
{
^0(%arg325 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.lshr %arg325, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_10_after := [llvm|
{
^0(%arg325 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_10_proof : lshrult_03_10_before ⊑ lshrult_03_10_after := by
  unfold lshrult_03_10_before lshrult_03_10_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_10
  apply lshrult_03_10_thm
  ---END lshrult_03_10



def lshrult_03_11_before := [llvm|
{
^0(%arg324 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.lshr %arg324, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_11_after := [llvm|
{
^0(%arg324 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_11_proof : lshrult_03_11_before ⊑ lshrult_03_11_after := by
  unfold lshrult_03_11_before lshrult_03_11_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_11
  apply lshrult_03_11_thm
  ---END lshrult_03_11



def lshrult_03_12_before := [llvm|
{
^0(%arg323 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.lshr %arg323, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_12_after := [llvm|
{
^0(%arg323 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_12_proof : lshrult_03_12_before ⊑ lshrult_03_12_after := by
  unfold lshrult_03_12_before lshrult_03_12_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_12
  apply lshrult_03_12_thm
  ---END lshrult_03_12



def lshrult_03_13_before := [llvm|
{
^0(%arg322 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.lshr %arg322, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_13_after := [llvm|
{
^0(%arg322 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_13_proof : lshrult_03_13_before ⊑ lshrult_03_13_after := by
  unfold lshrult_03_13_before lshrult_03_13_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_13
  apply lshrult_03_13_thm
  ---END lshrult_03_13



def lshrult_03_14_before := [llvm|
{
^0(%arg321 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.lshr %arg321, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_14_after := [llvm|
{
^0(%arg321 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_14_proof : lshrult_03_14_before ⊑ lshrult_03_14_after := by
  unfold lshrult_03_14_before lshrult_03_14_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_14
  apply lshrult_03_14_thm
  ---END lshrult_03_14



def lshrult_03_15_before := [llvm|
{
^0(%arg320 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.lshr %arg320, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_15_after := [llvm|
{
^0(%arg320 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_15_proof : lshrult_03_15_before ⊑ lshrult_03_15_after := by
  unfold lshrult_03_15_before lshrult_03_15_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_15
  apply lshrult_03_15_thm
  ---END lshrult_03_15



def ashrsgt_01_00_before := [llvm|
{
^0(%arg319 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.ashr %arg319, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_00_after := [llvm|
{
^0(%arg319 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg319, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_00_proof : ashrsgt_01_00_before ⊑ ashrsgt_01_00_after := by
  unfold ashrsgt_01_00_before ashrsgt_01_00_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_00
  apply ashrsgt_01_00_thm
  ---END ashrsgt_01_00



def ashrsgt_01_01_before := [llvm|
{
^0(%arg316 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.ashr %arg316, %0 : i4
  %2 = llvm.icmp "sgt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashrsgt_01_01_after := [llvm|
{
^0(%arg316 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.icmp "sgt" %arg316, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_01_proof : ashrsgt_01_01_before ⊑ ashrsgt_01_01_after := by
  unfold ashrsgt_01_01_before ashrsgt_01_01_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_01
  apply ashrsgt_01_01_thm
  ---END ashrsgt_01_01



def ashrsgt_01_02_before := [llvm|
{
^0(%arg315 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.ashr %arg315, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_02_after := [llvm|
{
^0(%arg315 : i4):
  %0 = llvm.mlir.constant(5 : i4) : i4
  %1 = llvm.icmp "sgt" %arg315, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_02_proof : ashrsgt_01_02_before ⊑ ashrsgt_01_02_after := by
  unfold ashrsgt_01_02_before ashrsgt_01_02_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_02
  apply ashrsgt_01_02_thm
  ---END ashrsgt_01_02



def ashrsgt_01_03_before := [llvm|
{
^0(%arg314 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.ashr %arg314, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_03_after := [llvm|
{
^0(%arg314 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_03_proof : ashrsgt_01_03_before ⊑ ashrsgt_01_03_after := by
  unfold ashrsgt_01_03_before ashrsgt_01_03_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_03
  apply ashrsgt_01_03_thm
  ---END ashrsgt_01_03



def ashrsgt_01_04_before := [llvm|
{
^0(%arg313 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.ashr %arg313, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_04_after := [llvm|
{
^0(%arg313 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_04_proof : ashrsgt_01_04_before ⊑ ashrsgt_01_04_after := by
  unfold ashrsgt_01_04_before ashrsgt_01_04_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_04
  apply ashrsgt_01_04_thm
  ---END ashrsgt_01_04



def ashrsgt_01_05_before := [llvm|
{
^0(%arg312 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.ashr %arg312, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_05_after := [llvm|
{
^0(%arg312 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_05_proof : ashrsgt_01_05_before ⊑ ashrsgt_01_05_after := by
  unfold ashrsgt_01_05_before ashrsgt_01_05_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_05
  apply ashrsgt_01_05_thm
  ---END ashrsgt_01_05



def ashrsgt_01_06_before := [llvm|
{
^0(%arg311 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.ashr %arg311, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_06_after := [llvm|
{
^0(%arg311 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_06_proof : ashrsgt_01_06_before ⊑ ashrsgt_01_06_after := by
  unfold ashrsgt_01_06_before ashrsgt_01_06_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_06
  apply ashrsgt_01_06_thm
  ---END ashrsgt_01_06



def ashrsgt_01_07_before := [llvm|
{
^0(%arg310 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.ashr %arg310, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_07_after := [llvm|
{
^0(%arg310 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_07_proof : ashrsgt_01_07_before ⊑ ashrsgt_01_07_after := by
  unfold ashrsgt_01_07_before ashrsgt_01_07_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_07
  apply ashrsgt_01_07_thm
  ---END ashrsgt_01_07



def ashrsgt_01_08_before := [llvm|
{
^0(%arg309 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.ashr %arg309, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_08_after := [llvm|
{
^0(%arg309 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_08_proof : ashrsgt_01_08_before ⊑ ashrsgt_01_08_after := by
  unfold ashrsgt_01_08_before ashrsgt_01_08_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_08
  apply ashrsgt_01_08_thm
  ---END ashrsgt_01_08



def ashrsgt_01_09_before := [llvm|
{
^0(%arg308 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.ashr %arg308, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_09_after := [llvm|
{
^0(%arg308 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_09_proof : ashrsgt_01_09_before ⊑ ashrsgt_01_09_after := by
  unfold ashrsgt_01_09_before ashrsgt_01_09_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_09
  apply ashrsgt_01_09_thm
  ---END ashrsgt_01_09



def ashrsgt_01_10_before := [llvm|
{
^0(%arg307 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.ashr %arg307, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_10_after := [llvm|
{
^0(%arg307 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_10_proof : ashrsgt_01_10_before ⊑ ashrsgt_01_10_after := by
  unfold ashrsgt_01_10_before ashrsgt_01_10_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_10
  apply ashrsgt_01_10_thm
  ---END ashrsgt_01_10



def ashrsgt_01_11_before := [llvm|
{
^0(%arg306 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.ashr %arg306, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_11_after := [llvm|
{
^0(%arg306 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_11_proof : ashrsgt_01_11_before ⊑ ashrsgt_01_11_after := by
  unfold ashrsgt_01_11_before ashrsgt_01_11_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_11
  apply ashrsgt_01_11_thm
  ---END ashrsgt_01_11



def ashrsgt_01_12_before := [llvm|
{
^0(%arg305 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.ashr %arg305, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_12_after := [llvm|
{
^0(%arg305 : i4):
  %0 = llvm.mlir.constant(-7 : i4) : i4
  %1 = llvm.icmp "sgt" %arg305, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_12_proof : ashrsgt_01_12_before ⊑ ashrsgt_01_12_after := by
  unfold ashrsgt_01_12_before ashrsgt_01_12_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_12
  apply ashrsgt_01_12_thm
  ---END ashrsgt_01_12



def ashrsgt_01_13_before := [llvm|
{
^0(%arg304 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.ashr %arg304, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_13_after := [llvm|
{
^0(%arg304 : i4):
  %0 = llvm.mlir.constant(-5 : i4) : i4
  %1 = llvm.icmp "sgt" %arg304, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_13_proof : ashrsgt_01_13_before ⊑ ashrsgt_01_13_after := by
  unfold ashrsgt_01_13_before ashrsgt_01_13_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_13
  apply ashrsgt_01_13_thm
  ---END ashrsgt_01_13



def ashrsgt_01_14_before := [llvm|
{
^0(%arg303 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.ashr %arg303, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_14_after := [llvm|
{
^0(%arg303 : i4):
  %0 = llvm.mlir.constant(-3 : i4) : i4
  %1 = llvm.icmp "sgt" %arg303, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_14_proof : ashrsgt_01_14_before ⊑ ashrsgt_01_14_after := by
  unfold ashrsgt_01_14_before ashrsgt_01_14_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_14
  apply ashrsgt_01_14_thm
  ---END ashrsgt_01_14



def ashrsgt_01_15_before := [llvm|
{
^0(%arg302 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.ashr %arg302, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_15_after := [llvm|
{
^0(%arg302 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg302, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_15_proof : ashrsgt_01_15_before ⊑ ashrsgt_01_15_after := by
  unfold ashrsgt_01_15_before ashrsgt_01_15_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_15
  apply ashrsgt_01_15_thm
  ---END ashrsgt_01_15



def ashrsgt_02_00_before := [llvm|
{
^0(%arg301 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.ashr %arg301, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_00_after := [llvm|
{
^0(%arg301 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.icmp "sgt" %arg301, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_00_proof : ashrsgt_02_00_before ⊑ ashrsgt_02_00_after := by
  unfold ashrsgt_02_00_before ashrsgt_02_00_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_00
  apply ashrsgt_02_00_thm
  ---END ashrsgt_02_00



def ashrsgt_02_01_before := [llvm|
{
^0(%arg300 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.ashr %arg300, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_01_after := [llvm|
{
^0(%arg300 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_01_proof : ashrsgt_02_01_before ⊑ ashrsgt_02_01_after := by
  unfold ashrsgt_02_01_before ashrsgt_02_01_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_01
  apply ashrsgt_02_01_thm
  ---END ashrsgt_02_01



def ashrsgt_02_02_before := [llvm|
{
^0(%arg299 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.ashr %arg299, %0 : i4
  %2 = llvm.icmp "sgt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashrsgt_02_02_after := [llvm|
{
^0(%arg299 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_02_proof : ashrsgt_02_02_before ⊑ ashrsgt_02_02_after := by
  unfold ashrsgt_02_02_before ashrsgt_02_02_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_02
  apply ashrsgt_02_02_thm
  ---END ashrsgt_02_02



def ashrsgt_02_03_before := [llvm|
{
^0(%arg298 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.ashr %arg298, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_03_after := [llvm|
{
^0(%arg298 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_03_proof : ashrsgt_02_03_before ⊑ ashrsgt_02_03_after := by
  unfold ashrsgt_02_03_before ashrsgt_02_03_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_03
  apply ashrsgt_02_03_thm
  ---END ashrsgt_02_03



def ashrsgt_02_04_before := [llvm|
{
^0(%arg297 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.ashr %arg297, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_04_after := [llvm|
{
^0(%arg297 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_04_proof : ashrsgt_02_04_before ⊑ ashrsgt_02_04_after := by
  unfold ashrsgt_02_04_before ashrsgt_02_04_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_04
  apply ashrsgt_02_04_thm
  ---END ashrsgt_02_04



def ashrsgt_02_05_before := [llvm|
{
^0(%arg296 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.ashr %arg296, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_05_after := [llvm|
{
^0(%arg296 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_05_proof : ashrsgt_02_05_before ⊑ ashrsgt_02_05_after := by
  unfold ashrsgt_02_05_before ashrsgt_02_05_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_05
  apply ashrsgt_02_05_thm
  ---END ashrsgt_02_05



def ashrsgt_02_06_before := [llvm|
{
^0(%arg295 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.ashr %arg295, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_06_after := [llvm|
{
^0(%arg295 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_06_proof : ashrsgt_02_06_before ⊑ ashrsgt_02_06_after := by
  unfold ashrsgt_02_06_before ashrsgt_02_06_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_06
  apply ashrsgt_02_06_thm
  ---END ashrsgt_02_06



def ashrsgt_02_07_before := [llvm|
{
^0(%arg294 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.ashr %arg294, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_07_after := [llvm|
{
^0(%arg294 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_07_proof : ashrsgt_02_07_before ⊑ ashrsgt_02_07_after := by
  unfold ashrsgt_02_07_before ashrsgt_02_07_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_07
  apply ashrsgt_02_07_thm
  ---END ashrsgt_02_07



def ashrsgt_02_08_before := [llvm|
{
^0(%arg293 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.ashr %arg293, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_08_after := [llvm|
{
^0(%arg293 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_08_proof : ashrsgt_02_08_before ⊑ ashrsgt_02_08_after := by
  unfold ashrsgt_02_08_before ashrsgt_02_08_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_08
  apply ashrsgt_02_08_thm
  ---END ashrsgt_02_08



def ashrsgt_02_09_before := [llvm|
{
^0(%arg292 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.ashr %arg292, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_09_after := [llvm|
{
^0(%arg292 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_09_proof : ashrsgt_02_09_before ⊑ ashrsgt_02_09_after := by
  unfold ashrsgt_02_09_before ashrsgt_02_09_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_09
  apply ashrsgt_02_09_thm
  ---END ashrsgt_02_09



def ashrsgt_02_10_before := [llvm|
{
^0(%arg291 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.ashr %arg291, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_10_after := [llvm|
{
^0(%arg291 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_10_proof : ashrsgt_02_10_before ⊑ ashrsgt_02_10_after := by
  unfold ashrsgt_02_10_before ashrsgt_02_10_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_10
  apply ashrsgt_02_10_thm
  ---END ashrsgt_02_10



def ashrsgt_02_11_before := [llvm|
{
^0(%arg290 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.ashr %arg290, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_11_after := [llvm|
{
^0(%arg290 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_11_proof : ashrsgt_02_11_before ⊑ ashrsgt_02_11_after := by
  unfold ashrsgt_02_11_before ashrsgt_02_11_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_11
  apply ashrsgt_02_11_thm
  ---END ashrsgt_02_11



def ashrsgt_02_12_before := [llvm|
{
^0(%arg289 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.ashr %arg289, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_12_after := [llvm|
{
^0(%arg289 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_12_proof : ashrsgt_02_12_before ⊑ ashrsgt_02_12_after := by
  unfold ashrsgt_02_12_before ashrsgt_02_12_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_12
  apply ashrsgt_02_12_thm
  ---END ashrsgt_02_12



def ashrsgt_02_13_before := [llvm|
{
^0(%arg288 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.ashr %arg288, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_13_after := [llvm|
{
^0(%arg288 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_13_proof : ashrsgt_02_13_before ⊑ ashrsgt_02_13_after := by
  unfold ashrsgt_02_13_before ashrsgt_02_13_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_13
  apply ashrsgt_02_13_thm
  ---END ashrsgt_02_13



def ashrsgt_02_14_before := [llvm|
{
^0(%arg287 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.ashr %arg287, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_14_after := [llvm|
{
^0(%arg287 : i4):
  %0 = llvm.mlir.constant(-5 : i4) : i4
  %1 = llvm.icmp "sgt" %arg287, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_14_proof : ashrsgt_02_14_before ⊑ ashrsgt_02_14_after := by
  unfold ashrsgt_02_14_before ashrsgt_02_14_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_14
  apply ashrsgt_02_14_thm
  ---END ashrsgt_02_14



def ashrsgt_02_15_before := [llvm|
{
^0(%arg286 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.ashr %arg286, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_15_after := [llvm|
{
^0(%arg286 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg286, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_15_proof : ashrsgt_02_15_before ⊑ ashrsgt_02_15_after := by
  unfold ashrsgt_02_15_before ashrsgt_02_15_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_15
  apply ashrsgt_02_15_thm
  ---END ashrsgt_02_15



def ashrsgt_03_00_before := [llvm|
{
^0(%arg285 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.ashr %arg285, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_00_after := [llvm|
{
^0(%arg285 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_00_proof : ashrsgt_03_00_before ⊑ ashrsgt_03_00_after := by
  unfold ashrsgt_03_00_before ashrsgt_03_00_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_00
  apply ashrsgt_03_00_thm
  ---END ashrsgt_03_00



def ashrsgt_03_01_before := [llvm|
{
^0(%arg284 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.ashr %arg284, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_01_after := [llvm|
{
^0(%arg284 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_01_proof : ashrsgt_03_01_before ⊑ ashrsgt_03_01_after := by
  unfold ashrsgt_03_01_before ashrsgt_03_01_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_01
  apply ashrsgt_03_01_thm
  ---END ashrsgt_03_01



def ashrsgt_03_02_before := [llvm|
{
^0(%arg283 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.ashr %arg283, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_02_after := [llvm|
{
^0(%arg283 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_02_proof : ashrsgt_03_02_before ⊑ ashrsgt_03_02_after := by
  unfold ashrsgt_03_02_before ashrsgt_03_02_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_02
  apply ashrsgt_03_02_thm
  ---END ashrsgt_03_02



def ashrsgt_03_03_before := [llvm|
{
^0(%arg282 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.ashr %arg282, %0 : i4
  %2 = llvm.icmp "sgt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashrsgt_03_03_after := [llvm|
{
^0(%arg282 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_03_proof : ashrsgt_03_03_before ⊑ ashrsgt_03_03_after := by
  unfold ashrsgt_03_03_before ashrsgt_03_03_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_03
  apply ashrsgt_03_03_thm
  ---END ashrsgt_03_03



def ashrsgt_03_04_before := [llvm|
{
^0(%arg281 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.ashr %arg281, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_04_after := [llvm|
{
^0(%arg281 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_04_proof : ashrsgt_03_04_before ⊑ ashrsgt_03_04_after := by
  unfold ashrsgt_03_04_before ashrsgt_03_04_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_04
  apply ashrsgt_03_04_thm
  ---END ashrsgt_03_04



def ashrsgt_03_05_before := [llvm|
{
^0(%arg280 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.ashr %arg280, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_05_after := [llvm|
{
^0(%arg280 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_05_proof : ashrsgt_03_05_before ⊑ ashrsgt_03_05_after := by
  unfold ashrsgt_03_05_before ashrsgt_03_05_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_05
  apply ashrsgt_03_05_thm
  ---END ashrsgt_03_05



def ashrsgt_03_06_before := [llvm|
{
^0(%arg279 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.ashr %arg279, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_06_after := [llvm|
{
^0(%arg279 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_06_proof : ashrsgt_03_06_before ⊑ ashrsgt_03_06_after := by
  unfold ashrsgt_03_06_before ashrsgt_03_06_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_06
  apply ashrsgt_03_06_thm
  ---END ashrsgt_03_06



def ashrsgt_03_07_before := [llvm|
{
^0(%arg278 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.ashr %arg278, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_07_after := [llvm|
{
^0(%arg278 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_07_proof : ashrsgt_03_07_before ⊑ ashrsgt_03_07_after := by
  unfold ashrsgt_03_07_before ashrsgt_03_07_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_07
  apply ashrsgt_03_07_thm
  ---END ashrsgt_03_07



def ashrsgt_03_08_before := [llvm|
{
^0(%arg277 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.ashr %arg277, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_08_after := [llvm|
{
^0(%arg277 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_08_proof : ashrsgt_03_08_before ⊑ ashrsgt_03_08_after := by
  unfold ashrsgt_03_08_before ashrsgt_03_08_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_08
  apply ashrsgt_03_08_thm
  ---END ashrsgt_03_08



def ashrsgt_03_09_before := [llvm|
{
^0(%arg276 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.ashr %arg276, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_09_after := [llvm|
{
^0(%arg276 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_09_proof : ashrsgt_03_09_before ⊑ ashrsgt_03_09_after := by
  unfold ashrsgt_03_09_before ashrsgt_03_09_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_09
  apply ashrsgt_03_09_thm
  ---END ashrsgt_03_09



def ashrsgt_03_10_before := [llvm|
{
^0(%arg275 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.ashr %arg275, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_10_after := [llvm|
{
^0(%arg275 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_10_proof : ashrsgt_03_10_before ⊑ ashrsgt_03_10_after := by
  unfold ashrsgt_03_10_before ashrsgt_03_10_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_10
  apply ashrsgt_03_10_thm
  ---END ashrsgt_03_10



def ashrsgt_03_11_before := [llvm|
{
^0(%arg274 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.ashr %arg274, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_11_after := [llvm|
{
^0(%arg274 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_11_proof : ashrsgt_03_11_before ⊑ ashrsgt_03_11_after := by
  unfold ashrsgt_03_11_before ashrsgt_03_11_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_11
  apply ashrsgt_03_11_thm
  ---END ashrsgt_03_11



def ashrsgt_03_12_before := [llvm|
{
^0(%arg273 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.ashr %arg273, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_12_after := [llvm|
{
^0(%arg273 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_12_proof : ashrsgt_03_12_before ⊑ ashrsgt_03_12_after := by
  unfold ashrsgt_03_12_before ashrsgt_03_12_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_12
  apply ashrsgt_03_12_thm
  ---END ashrsgt_03_12



def ashrsgt_03_13_before := [llvm|
{
^0(%arg272 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.ashr %arg272, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_13_after := [llvm|
{
^0(%arg272 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_13_proof : ashrsgt_03_13_before ⊑ ashrsgt_03_13_after := by
  unfold ashrsgt_03_13_before ashrsgt_03_13_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_13
  apply ashrsgt_03_13_thm
  ---END ashrsgt_03_13



def ashrsgt_03_14_before := [llvm|
{
^0(%arg271 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.ashr %arg271, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_14_after := [llvm|
{
^0(%arg271 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_14_proof : ashrsgt_03_14_before ⊑ ashrsgt_03_14_after := by
  unfold ashrsgt_03_14_before ashrsgt_03_14_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_14
  apply ashrsgt_03_14_thm
  ---END ashrsgt_03_14



def ashrsgt_03_15_before := [llvm|
{
^0(%arg270 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.ashr %arg270, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_15_after := [llvm|
{
^0(%arg270 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg270, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_15_proof : ashrsgt_03_15_before ⊑ ashrsgt_03_15_after := by
  unfold ashrsgt_03_15_before ashrsgt_03_15_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_15
  apply ashrsgt_03_15_thm
  ---END ashrsgt_03_15



def ashrslt_01_00_before := [llvm|
{
^0(%arg269 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.ashr %arg269, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_00_after := [llvm|
{
^0(%arg269 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg269, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_00_proof : ashrslt_01_00_before ⊑ ashrslt_01_00_after := by
  unfold ashrslt_01_00_before ashrslt_01_00_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_00
  apply ashrslt_01_00_thm
  ---END ashrslt_01_00



def ashrslt_01_01_before := [llvm|
{
^0(%arg268 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.ashr %arg268, %0 : i4
  %2 = llvm.icmp "slt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashrslt_01_01_after := [llvm|
{
^0(%arg268 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.icmp "slt" %arg268, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_01_proof : ashrslt_01_01_before ⊑ ashrslt_01_01_after := by
  unfold ashrslt_01_01_before ashrslt_01_01_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_01
  apply ashrslt_01_01_thm
  ---END ashrslt_01_01



def ashrslt_01_02_before := [llvm|
{
^0(%arg267 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.ashr %arg267, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_02_after := [llvm|
{
^0(%arg267 : i4):
  %0 = llvm.mlir.constant(4 : i4) : i4
  %1 = llvm.icmp "slt" %arg267, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_02_proof : ashrslt_01_02_before ⊑ ashrslt_01_02_after := by
  unfold ashrslt_01_02_before ashrslt_01_02_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_02
  apply ashrslt_01_02_thm
  ---END ashrslt_01_02



def ashrslt_01_03_before := [llvm|
{
^0(%arg266 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.ashr %arg266, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_03_after := [llvm|
{
^0(%arg266 : i4):
  %0 = llvm.mlir.constant(6 : i4) : i4
  %1 = llvm.icmp "slt" %arg266, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_03_proof : ashrslt_01_03_before ⊑ ashrslt_01_03_after := by
  unfold ashrslt_01_03_before ashrslt_01_03_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_03
  apply ashrslt_01_03_thm
  ---END ashrslt_01_03



def ashrslt_01_04_before := [llvm|
{
^0(%arg265 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.ashr %arg265, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_04_after := [llvm|
{
^0(%arg265 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_04_proof : ashrslt_01_04_before ⊑ ashrslt_01_04_after := by
  unfold ashrslt_01_04_before ashrslt_01_04_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_04
  apply ashrslt_01_04_thm
  ---END ashrslt_01_04



def ashrslt_01_05_before := [llvm|
{
^0(%arg264 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.ashr %arg264, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_05_after := [llvm|
{
^0(%arg264 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_05_proof : ashrslt_01_05_before ⊑ ashrslt_01_05_after := by
  unfold ashrslt_01_05_before ashrslt_01_05_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_05
  apply ashrslt_01_05_thm
  ---END ashrslt_01_05



def ashrslt_01_06_before := [llvm|
{
^0(%arg263 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.ashr %arg263, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_06_after := [llvm|
{
^0(%arg263 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_06_proof : ashrslt_01_06_before ⊑ ashrslt_01_06_after := by
  unfold ashrslt_01_06_before ashrslt_01_06_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_06
  apply ashrslt_01_06_thm
  ---END ashrslt_01_06



def ashrslt_01_07_before := [llvm|
{
^0(%arg262 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.ashr %arg262, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_07_after := [llvm|
{
^0(%arg262 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_07_proof : ashrslt_01_07_before ⊑ ashrslt_01_07_after := by
  unfold ashrslt_01_07_before ashrslt_01_07_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_07
  apply ashrslt_01_07_thm
  ---END ashrslt_01_07



def ashrslt_01_08_before := [llvm|
{
^0(%arg261 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.ashr %arg261, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_08_after := [llvm|
{
^0(%arg261 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_08_proof : ashrslt_01_08_before ⊑ ashrslt_01_08_after := by
  unfold ashrslt_01_08_before ashrslt_01_08_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_08
  apply ashrslt_01_08_thm
  ---END ashrslt_01_08



def ashrslt_01_09_before := [llvm|
{
^0(%arg260 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.ashr %arg260, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_09_after := [llvm|
{
^0(%arg260 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_09_proof : ashrslt_01_09_before ⊑ ashrslt_01_09_after := by
  unfold ashrslt_01_09_before ashrslt_01_09_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_09
  apply ashrslt_01_09_thm
  ---END ashrslt_01_09



def ashrslt_01_10_before := [llvm|
{
^0(%arg259 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.ashr %arg259, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_10_after := [llvm|
{
^0(%arg259 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_10_proof : ashrslt_01_10_before ⊑ ashrslt_01_10_after := by
  unfold ashrslt_01_10_before ashrslt_01_10_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_10
  apply ashrslt_01_10_thm
  ---END ashrslt_01_10



def ashrslt_01_11_before := [llvm|
{
^0(%arg258 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.ashr %arg258, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_11_after := [llvm|
{
^0(%arg258 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_11_proof : ashrslt_01_11_before ⊑ ashrslt_01_11_after := by
  unfold ashrslt_01_11_before ashrslt_01_11_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_11
  apply ashrslt_01_11_thm
  ---END ashrslt_01_11



def ashrslt_01_12_before := [llvm|
{
^0(%arg257 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.ashr %arg257, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_12_after := [llvm|
{
^0(%arg257 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_12_proof : ashrslt_01_12_before ⊑ ashrslt_01_12_after := by
  unfold ashrslt_01_12_before ashrslt_01_12_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_12
  apply ashrslt_01_12_thm
  ---END ashrslt_01_12



def ashrslt_01_13_before := [llvm|
{
^0(%arg256 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.ashr %arg256, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_13_after := [llvm|
{
^0(%arg256 : i4):
  %0 = llvm.mlir.constant(-6 : i4) : i4
  %1 = llvm.icmp "slt" %arg256, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_13_proof : ashrslt_01_13_before ⊑ ashrslt_01_13_after := by
  unfold ashrslt_01_13_before ashrslt_01_13_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_13
  apply ashrslt_01_13_thm
  ---END ashrslt_01_13



def ashrslt_01_14_before := [llvm|
{
^0(%arg255 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.ashr %arg255, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_14_after := [llvm|
{
^0(%arg255 : i4):
  %0 = llvm.mlir.constant(-4 : i4) : i4
  %1 = llvm.icmp "slt" %arg255, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_14_proof : ashrslt_01_14_before ⊑ ashrslt_01_14_after := by
  unfold ashrslt_01_14_before ashrslt_01_14_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_14
  apply ashrslt_01_14_thm
  ---END ashrslt_01_14



def ashrslt_01_15_before := [llvm|
{
^0(%arg254 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.ashr %arg254, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_15_after := [llvm|
{
^0(%arg254 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.icmp "slt" %arg254, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_15_proof : ashrslt_01_15_before ⊑ ashrslt_01_15_after := by
  unfold ashrslt_01_15_before ashrslt_01_15_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_15
  apply ashrslt_01_15_thm
  ---END ashrslt_01_15



def ashrslt_02_00_before := [llvm|
{
^0(%arg253 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.ashr %arg253, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_00_after := [llvm|
{
^0(%arg253 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg253, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_00_proof : ashrslt_02_00_before ⊑ ashrslt_02_00_after := by
  unfold ashrslt_02_00_before ashrslt_02_00_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_00
  apply ashrslt_02_00_thm
  ---END ashrslt_02_00



def ashrslt_02_01_before := [llvm|
{
^0(%arg252 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.ashr %arg252, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_01_after := [llvm|
{
^0(%arg252 : i4):
  %0 = llvm.mlir.constant(4 : i4) : i4
  %1 = llvm.icmp "slt" %arg252, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_01_proof : ashrslt_02_01_before ⊑ ashrslt_02_01_after := by
  unfold ashrslt_02_01_before ashrslt_02_01_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_01
  apply ashrslt_02_01_thm
  ---END ashrslt_02_01



def ashrslt_02_02_before := [llvm|
{
^0(%arg251 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.ashr %arg251, %0 : i4
  %2 = llvm.icmp "slt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashrslt_02_02_after := [llvm|
{
^0(%arg251 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_02_proof : ashrslt_02_02_before ⊑ ashrslt_02_02_after := by
  unfold ashrslt_02_02_before ashrslt_02_02_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_02
  apply ashrslt_02_02_thm
  ---END ashrslt_02_02



def ashrslt_02_03_before := [llvm|
{
^0(%arg250 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.ashr %arg250, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_03_after := [llvm|
{
^0(%arg250 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_03_proof : ashrslt_02_03_before ⊑ ashrslt_02_03_after := by
  unfold ashrslt_02_03_before ashrslt_02_03_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_03
  apply ashrslt_02_03_thm
  ---END ashrslt_02_03



def ashrslt_02_04_before := [llvm|
{
^0(%arg249 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.ashr %arg249, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_04_after := [llvm|
{
^0(%arg249 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_04_proof : ashrslt_02_04_before ⊑ ashrslt_02_04_after := by
  unfold ashrslt_02_04_before ashrslt_02_04_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_04
  apply ashrslt_02_04_thm
  ---END ashrslt_02_04



def ashrslt_02_05_before := [llvm|
{
^0(%arg248 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.ashr %arg248, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_05_after := [llvm|
{
^0(%arg248 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_05_proof : ashrslt_02_05_before ⊑ ashrslt_02_05_after := by
  unfold ashrslt_02_05_before ashrslt_02_05_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_05
  apply ashrslt_02_05_thm
  ---END ashrslt_02_05



def ashrslt_02_06_before := [llvm|
{
^0(%arg247 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.ashr %arg247, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_06_after := [llvm|
{
^0(%arg247 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_06_proof : ashrslt_02_06_before ⊑ ashrslt_02_06_after := by
  unfold ashrslt_02_06_before ashrslt_02_06_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_06
  apply ashrslt_02_06_thm
  ---END ashrslt_02_06



def ashrslt_02_07_before := [llvm|
{
^0(%arg246 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.ashr %arg246, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_07_after := [llvm|
{
^0(%arg246 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_07_proof : ashrslt_02_07_before ⊑ ashrslt_02_07_after := by
  unfold ashrslt_02_07_before ashrslt_02_07_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_07
  apply ashrslt_02_07_thm
  ---END ashrslt_02_07



def ashrslt_02_08_before := [llvm|
{
^0(%arg245 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.ashr %arg245, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_08_after := [llvm|
{
^0(%arg245 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_08_proof : ashrslt_02_08_before ⊑ ashrslt_02_08_after := by
  unfold ashrslt_02_08_before ashrslt_02_08_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_08
  apply ashrslt_02_08_thm
  ---END ashrslt_02_08



def ashrslt_02_09_before := [llvm|
{
^0(%arg244 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.ashr %arg244, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_09_after := [llvm|
{
^0(%arg244 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_09_proof : ashrslt_02_09_before ⊑ ashrslt_02_09_after := by
  unfold ashrslt_02_09_before ashrslt_02_09_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_09
  apply ashrslt_02_09_thm
  ---END ashrslt_02_09



def ashrslt_02_10_before := [llvm|
{
^0(%arg243 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.ashr %arg243, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_10_after := [llvm|
{
^0(%arg243 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_10_proof : ashrslt_02_10_before ⊑ ashrslt_02_10_after := by
  unfold ashrslt_02_10_before ashrslt_02_10_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_10
  apply ashrslt_02_10_thm
  ---END ashrslt_02_10



def ashrslt_02_11_before := [llvm|
{
^0(%arg242 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.ashr %arg242, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_11_after := [llvm|
{
^0(%arg242 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_11_proof : ashrslt_02_11_before ⊑ ashrslt_02_11_after := by
  unfold ashrslt_02_11_before ashrslt_02_11_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_11
  apply ashrslt_02_11_thm
  ---END ashrslt_02_11



def ashrslt_02_12_before := [llvm|
{
^0(%arg241 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.ashr %arg241, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_12_after := [llvm|
{
^0(%arg241 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_12_proof : ashrslt_02_12_before ⊑ ashrslt_02_12_after := by
  unfold ashrslt_02_12_before ashrslt_02_12_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_12
  apply ashrslt_02_12_thm
  ---END ashrslt_02_12



def ashrslt_02_13_before := [llvm|
{
^0(%arg240 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.ashr %arg240, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_13_after := [llvm|
{
^0(%arg240 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_13_proof : ashrslt_02_13_before ⊑ ashrslt_02_13_after := by
  unfold ashrslt_02_13_before ashrslt_02_13_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_13
  apply ashrslt_02_13_thm
  ---END ashrslt_02_13



def ashrslt_02_14_before := [llvm|
{
^0(%arg239 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.ashr %arg239, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_14_after := [llvm|
{
^0(%arg239 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_14_proof : ashrslt_02_14_before ⊑ ashrslt_02_14_after := by
  unfold ashrslt_02_14_before ashrslt_02_14_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_14
  apply ashrslt_02_14_thm
  ---END ashrslt_02_14



def ashrslt_02_15_before := [llvm|
{
^0(%arg238 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.ashr %arg238, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_15_after := [llvm|
{
^0(%arg238 : i4):
  %0 = llvm.mlir.constant(-4 : i4) : i4
  %1 = llvm.icmp "slt" %arg238, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_15_proof : ashrslt_02_15_before ⊑ ashrslt_02_15_after := by
  unfold ashrslt_02_15_before ashrslt_02_15_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_15
  apply ashrslt_02_15_thm
  ---END ashrslt_02_15



def ashrslt_03_00_before := [llvm|
{
^0(%arg237 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.ashr %arg237, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_00_after := [llvm|
{
^0(%arg237 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg237, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_00_proof : ashrslt_03_00_before ⊑ ashrslt_03_00_after := by
  unfold ashrslt_03_00_before ashrslt_03_00_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_00
  apply ashrslt_03_00_thm
  ---END ashrslt_03_00



def ashrslt_03_01_before := [llvm|
{
^0(%arg236 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.ashr %arg236, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_01_after := [llvm|
{
^0(%arg236 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_01_proof : ashrslt_03_01_before ⊑ ashrslt_03_01_after := by
  unfold ashrslt_03_01_before ashrslt_03_01_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_01
  apply ashrslt_03_01_thm
  ---END ashrslt_03_01



def ashrslt_03_02_before := [llvm|
{
^0(%arg235 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.ashr %arg235, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_02_after := [llvm|
{
^0(%arg235 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_02_proof : ashrslt_03_02_before ⊑ ashrslt_03_02_after := by
  unfold ashrslt_03_02_before ashrslt_03_02_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_02
  apply ashrslt_03_02_thm
  ---END ashrslt_03_02



def ashrslt_03_03_before := [llvm|
{
^0(%arg234 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.ashr %arg234, %0 : i4
  %2 = llvm.icmp "slt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashrslt_03_03_after := [llvm|
{
^0(%arg234 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_03_proof : ashrslt_03_03_before ⊑ ashrslt_03_03_after := by
  unfold ashrslt_03_03_before ashrslt_03_03_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_03
  apply ashrslt_03_03_thm
  ---END ashrslt_03_03



def ashrslt_03_04_before := [llvm|
{
^0(%arg233 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.ashr %arg233, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_04_after := [llvm|
{
^0(%arg233 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_04_proof : ashrslt_03_04_before ⊑ ashrslt_03_04_after := by
  unfold ashrslt_03_04_before ashrslt_03_04_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_04
  apply ashrslt_03_04_thm
  ---END ashrslt_03_04



def ashrslt_03_05_before := [llvm|
{
^0(%arg232 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.ashr %arg232, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_05_after := [llvm|
{
^0(%arg232 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_05_proof : ashrslt_03_05_before ⊑ ashrslt_03_05_after := by
  unfold ashrslt_03_05_before ashrslt_03_05_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_05
  apply ashrslt_03_05_thm
  ---END ashrslt_03_05



def ashrslt_03_06_before := [llvm|
{
^0(%arg231 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.ashr %arg231, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_06_after := [llvm|
{
^0(%arg231 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_06_proof : ashrslt_03_06_before ⊑ ashrslt_03_06_after := by
  unfold ashrslt_03_06_before ashrslt_03_06_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_06
  apply ashrslt_03_06_thm
  ---END ashrslt_03_06



def ashrslt_03_07_before := [llvm|
{
^0(%arg230 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.ashr %arg230, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_07_after := [llvm|
{
^0(%arg230 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_07_proof : ashrslt_03_07_before ⊑ ashrslt_03_07_after := by
  unfold ashrslt_03_07_before ashrslt_03_07_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_07
  apply ashrslt_03_07_thm
  ---END ashrslt_03_07



def ashrslt_03_08_before := [llvm|
{
^0(%arg229 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.ashr %arg229, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_08_after := [llvm|
{
^0(%arg229 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_08_proof : ashrslt_03_08_before ⊑ ashrslt_03_08_after := by
  unfold ashrslt_03_08_before ashrslt_03_08_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_08
  apply ashrslt_03_08_thm
  ---END ashrslt_03_08



def ashrslt_03_09_before := [llvm|
{
^0(%arg228 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.ashr %arg228, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_09_after := [llvm|
{
^0(%arg228 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_09_proof : ashrslt_03_09_before ⊑ ashrslt_03_09_after := by
  unfold ashrslt_03_09_before ashrslt_03_09_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_09
  apply ashrslt_03_09_thm
  ---END ashrslt_03_09



def ashrslt_03_10_before := [llvm|
{
^0(%arg227 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.ashr %arg227, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_10_after := [llvm|
{
^0(%arg227 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_10_proof : ashrslt_03_10_before ⊑ ashrslt_03_10_after := by
  unfold ashrslt_03_10_before ashrslt_03_10_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_10
  apply ashrslt_03_10_thm
  ---END ashrslt_03_10



def ashrslt_03_11_before := [llvm|
{
^0(%arg226 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.ashr %arg226, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_11_after := [llvm|
{
^0(%arg226 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_11_proof : ashrslt_03_11_before ⊑ ashrslt_03_11_after := by
  unfold ashrslt_03_11_before ashrslt_03_11_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_11
  apply ashrslt_03_11_thm
  ---END ashrslt_03_11



def ashrslt_03_12_before := [llvm|
{
^0(%arg225 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.ashr %arg225, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_12_after := [llvm|
{
^0(%arg225 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_12_proof : ashrslt_03_12_before ⊑ ashrslt_03_12_after := by
  unfold ashrslt_03_12_before ashrslt_03_12_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_12
  apply ashrslt_03_12_thm
  ---END ashrslt_03_12



def ashrslt_03_13_before := [llvm|
{
^0(%arg224 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.ashr %arg224, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_13_after := [llvm|
{
^0(%arg224 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_13_proof : ashrslt_03_13_before ⊑ ashrslt_03_13_after := by
  unfold ashrslt_03_13_before ashrslt_03_13_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_13
  apply ashrslt_03_13_thm
  ---END ashrslt_03_13



def ashrslt_03_14_before := [llvm|
{
^0(%arg223 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.ashr %arg223, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_14_after := [llvm|
{
^0(%arg223 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_14_proof : ashrslt_03_14_before ⊑ ashrslt_03_14_after := by
  unfold ashrslt_03_14_before ashrslt_03_14_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_14
  apply ashrslt_03_14_thm
  ---END ashrslt_03_14



def ashrslt_03_15_before := [llvm|
{
^0(%arg222 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.ashr %arg222, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_15_after := [llvm|
{
^0(%arg222 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_15_proof : ashrslt_03_15_before ⊑ ashrslt_03_15_after := by
  unfold ashrslt_03_15_before ashrslt_03_15_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_15
  apply ashrslt_03_15_thm
  ---END ashrslt_03_15



def lshrugt_01_00_exact_before := [llvm|
{
^0(%arg221 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.lshr exact %arg221, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_00_exact_after := [llvm|
{
^0(%arg221 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "ne" %arg221, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_00_exact_proof : lshrugt_01_00_exact_before ⊑ lshrugt_01_00_exact_after := by
  unfold lshrugt_01_00_exact_before lshrugt_01_00_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_00_exact
  apply lshrugt_01_00_exact_thm
  ---END lshrugt_01_00_exact



def lshrugt_01_01_exact_before := [llvm|
{
^0(%arg220 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.lshr exact %arg220, %0 : i4
  %2 = llvm.icmp "ugt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshrugt_01_01_exact_after := [llvm|
{
^0(%arg220 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.icmp "ugt" %arg220, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_01_exact_proof : lshrugt_01_01_exact_before ⊑ lshrugt_01_01_exact_after := by
  unfold lshrugt_01_01_exact_before lshrugt_01_01_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_01_exact
  apply lshrugt_01_01_exact_thm
  ---END lshrugt_01_01_exact



def lshrugt_01_02_exact_before := [llvm|
{
^0(%arg219 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.lshr exact %arg219, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_02_exact_after := [llvm|
{
^0(%arg219 : i4):
  %0 = llvm.mlir.constant(4 : i4) : i4
  %1 = llvm.icmp "ugt" %arg219, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_02_exact_proof : lshrugt_01_02_exact_before ⊑ lshrugt_01_02_exact_after := by
  unfold lshrugt_01_02_exact_before lshrugt_01_02_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_02_exact
  apply lshrugt_01_02_exact_thm
  ---END lshrugt_01_02_exact



def lshrugt_01_03_exact_before := [llvm|
{
^0(%arg218 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.lshr exact %arg218, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_03_exact_after := [llvm|
{
^0(%arg218 : i4):
  %0 = llvm.mlir.constant(6 : i4) : i4
  %1 = llvm.icmp "ugt" %arg218, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_03_exact_proof : lshrugt_01_03_exact_before ⊑ lshrugt_01_03_exact_after := by
  unfold lshrugt_01_03_exact_before lshrugt_01_03_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_03_exact
  apply lshrugt_01_03_exact_thm
  ---END lshrugt_01_03_exact



def lshrugt_01_04_exact_before := [llvm|
{
^0(%arg217 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.lshr exact %arg217, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_04_exact_after := [llvm|
{
^0(%arg217 : i4):
  %0 = llvm.mlir.constant(-8 : i4) : i4
  %1 = llvm.icmp "ugt" %arg217, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_04_exact_proof : lshrugt_01_04_exact_before ⊑ lshrugt_01_04_exact_after := by
  unfold lshrugt_01_04_exact_before lshrugt_01_04_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_04_exact
  apply lshrugt_01_04_exact_thm
  ---END lshrugt_01_04_exact



def lshrugt_01_05_exact_before := [llvm|
{
^0(%arg216 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.lshr exact %arg216, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_05_exact_after := [llvm|
{
^0(%arg216 : i4):
  %0 = llvm.mlir.constant(-6 : i4) : i4
  %1 = llvm.icmp "ugt" %arg216, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_05_exact_proof : lshrugt_01_05_exact_before ⊑ lshrugt_01_05_exact_after := by
  unfold lshrugt_01_05_exact_before lshrugt_01_05_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_05_exact
  apply lshrugt_01_05_exact_thm
  ---END lshrugt_01_05_exact



def lshrugt_01_06_exact_before := [llvm|
{
^0(%arg215 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.lshr exact %arg215, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_06_exact_after := [llvm|
{
^0(%arg215 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.icmp "eq" %arg215, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_06_exact_proof : lshrugt_01_06_exact_before ⊑ lshrugt_01_06_exact_after := by
  unfold lshrugt_01_06_exact_before lshrugt_01_06_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_06_exact
  apply lshrugt_01_06_exact_thm
  ---END lshrugt_01_06_exact



def lshrugt_01_07_exact_before := [llvm|
{
^0(%arg214 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.lshr exact %arg214, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_07_exact_after := [llvm|
{
^0(%arg214 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_07_exact_proof : lshrugt_01_07_exact_before ⊑ lshrugt_01_07_exact_after := by
  unfold lshrugt_01_07_exact_before lshrugt_01_07_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_07_exact
  apply lshrugt_01_07_exact_thm
  ---END lshrugt_01_07_exact



def lshrugt_01_08_exact_before := [llvm|
{
^0(%arg213 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.lshr exact %arg213, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_08_exact_after := [llvm|
{
^0(%arg213 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_08_exact_proof : lshrugt_01_08_exact_before ⊑ lshrugt_01_08_exact_after := by
  unfold lshrugt_01_08_exact_before lshrugt_01_08_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_08_exact
  apply lshrugt_01_08_exact_thm
  ---END lshrugt_01_08_exact



def lshrugt_01_09_exact_before := [llvm|
{
^0(%arg212 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.lshr exact %arg212, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_09_exact_after := [llvm|
{
^0(%arg212 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_09_exact_proof : lshrugt_01_09_exact_before ⊑ lshrugt_01_09_exact_after := by
  unfold lshrugt_01_09_exact_before lshrugt_01_09_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_09_exact
  apply lshrugt_01_09_exact_thm
  ---END lshrugt_01_09_exact



def lshrugt_01_10_exact_before := [llvm|
{
^0(%arg211 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.lshr exact %arg211, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_10_exact_after := [llvm|
{
^0(%arg211 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_10_exact_proof : lshrugt_01_10_exact_before ⊑ lshrugt_01_10_exact_after := by
  unfold lshrugt_01_10_exact_before lshrugt_01_10_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_10_exact
  apply lshrugt_01_10_exact_thm
  ---END lshrugt_01_10_exact



def lshrugt_01_11_exact_before := [llvm|
{
^0(%arg210 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.lshr exact %arg210, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_11_exact_after := [llvm|
{
^0(%arg210 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_11_exact_proof : lshrugt_01_11_exact_before ⊑ lshrugt_01_11_exact_after := by
  unfold lshrugt_01_11_exact_before lshrugt_01_11_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_11_exact
  apply lshrugt_01_11_exact_thm
  ---END lshrugt_01_11_exact



def lshrugt_01_12_exact_before := [llvm|
{
^0(%arg209 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.lshr exact %arg209, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_12_exact_after := [llvm|
{
^0(%arg209 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_12_exact_proof : lshrugt_01_12_exact_before ⊑ lshrugt_01_12_exact_after := by
  unfold lshrugt_01_12_exact_before lshrugt_01_12_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_12_exact
  apply lshrugt_01_12_exact_thm
  ---END lshrugt_01_12_exact



def lshrugt_01_13_exact_before := [llvm|
{
^0(%arg208 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.lshr exact %arg208, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_13_exact_after := [llvm|
{
^0(%arg208 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_13_exact_proof : lshrugt_01_13_exact_before ⊑ lshrugt_01_13_exact_after := by
  unfold lshrugt_01_13_exact_before lshrugt_01_13_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_13_exact
  apply lshrugt_01_13_exact_thm
  ---END lshrugt_01_13_exact



def lshrugt_01_14_exact_before := [llvm|
{
^0(%arg207 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.lshr exact %arg207, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_14_exact_after := [llvm|
{
^0(%arg207 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_14_exact_proof : lshrugt_01_14_exact_before ⊑ lshrugt_01_14_exact_after := by
  unfold lshrugt_01_14_exact_before lshrugt_01_14_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_14_exact
  apply lshrugt_01_14_exact_thm
  ---END lshrugt_01_14_exact



def lshrugt_01_15_exact_before := [llvm|
{
^0(%arg206 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.lshr exact %arg206, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_01_15_exact_after := [llvm|
{
^0(%arg206 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_01_15_exact_proof : lshrugt_01_15_exact_before ⊑ lshrugt_01_15_exact_after := by
  unfold lshrugt_01_15_exact_before lshrugt_01_15_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_01_15_exact
  apply lshrugt_01_15_exact_thm
  ---END lshrugt_01_15_exact



def lshrugt_02_00_exact_before := [llvm|
{
^0(%arg205 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.lshr exact %arg205, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_00_exact_after := [llvm|
{
^0(%arg205 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "ne" %arg205, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_00_exact_proof : lshrugt_02_00_exact_before ⊑ lshrugt_02_00_exact_after := by
  unfold lshrugt_02_00_exact_before lshrugt_02_00_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_00_exact
  apply lshrugt_02_00_exact_thm
  ---END lshrugt_02_00_exact



def lshrugt_02_01_exact_before := [llvm|
{
^0(%arg204 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.lshr exact %arg204, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_01_exact_after := [llvm|
{
^0(%arg204 : i4):
  %0 = llvm.mlir.constant(4 : i4) : i4
  %1 = llvm.icmp "ugt" %arg204, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_01_exact_proof : lshrugt_02_01_exact_before ⊑ lshrugt_02_01_exact_after := by
  unfold lshrugt_02_01_exact_before lshrugt_02_01_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_01_exact
  apply lshrugt_02_01_exact_thm
  ---END lshrugt_02_01_exact



def lshrugt_02_02_exact_before := [llvm|
{
^0(%arg203 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.lshr exact %arg203, %0 : i4
  %2 = llvm.icmp "ugt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshrugt_02_02_exact_after := [llvm|
{
^0(%arg203 : i4):
  %0 = llvm.mlir.constant(-4 : i4) : i4
  %1 = llvm.icmp "eq" %arg203, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_02_exact_proof : lshrugt_02_02_exact_before ⊑ lshrugt_02_02_exact_after := by
  unfold lshrugt_02_02_exact_before lshrugt_02_02_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_02_exact
  apply lshrugt_02_02_exact_thm
  ---END lshrugt_02_02_exact



def lshrugt_02_03_exact_before := [llvm|
{
^0(%arg202 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.lshr exact %arg202, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_03_exact_after := [llvm|
{
^0(%arg202 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_03_exact_proof : lshrugt_02_03_exact_before ⊑ lshrugt_02_03_exact_after := by
  unfold lshrugt_02_03_exact_before lshrugt_02_03_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_03_exact
  apply lshrugt_02_03_exact_thm
  ---END lshrugt_02_03_exact



def lshrugt_02_04_exact_before := [llvm|
{
^0(%arg201 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.lshr exact %arg201, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_04_exact_after := [llvm|
{
^0(%arg201 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_04_exact_proof : lshrugt_02_04_exact_before ⊑ lshrugt_02_04_exact_after := by
  unfold lshrugt_02_04_exact_before lshrugt_02_04_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_04_exact
  apply lshrugt_02_04_exact_thm
  ---END lshrugt_02_04_exact



def lshrugt_02_05_exact_before := [llvm|
{
^0(%arg200 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.lshr exact %arg200, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_05_exact_after := [llvm|
{
^0(%arg200 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_05_exact_proof : lshrugt_02_05_exact_before ⊑ lshrugt_02_05_exact_after := by
  unfold lshrugt_02_05_exact_before lshrugt_02_05_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_05_exact
  apply lshrugt_02_05_exact_thm
  ---END lshrugt_02_05_exact



def lshrugt_02_06_exact_before := [llvm|
{
^0(%arg199 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.lshr exact %arg199, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_06_exact_after := [llvm|
{
^0(%arg199 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_06_exact_proof : lshrugt_02_06_exact_before ⊑ lshrugt_02_06_exact_after := by
  unfold lshrugt_02_06_exact_before lshrugt_02_06_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_06_exact
  apply lshrugt_02_06_exact_thm
  ---END lshrugt_02_06_exact



def lshrugt_02_07_exact_before := [llvm|
{
^0(%arg198 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.lshr exact %arg198, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_07_exact_after := [llvm|
{
^0(%arg198 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_07_exact_proof : lshrugt_02_07_exact_before ⊑ lshrugt_02_07_exact_after := by
  unfold lshrugt_02_07_exact_before lshrugt_02_07_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_07_exact
  apply lshrugt_02_07_exact_thm
  ---END lshrugt_02_07_exact



def lshrugt_02_08_exact_before := [llvm|
{
^0(%arg197 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.lshr exact %arg197, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_08_exact_after := [llvm|
{
^0(%arg197 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_08_exact_proof : lshrugt_02_08_exact_before ⊑ lshrugt_02_08_exact_after := by
  unfold lshrugt_02_08_exact_before lshrugt_02_08_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_08_exact
  apply lshrugt_02_08_exact_thm
  ---END lshrugt_02_08_exact



def lshrugt_02_09_exact_before := [llvm|
{
^0(%arg196 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.lshr exact %arg196, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_09_exact_after := [llvm|
{
^0(%arg196 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_09_exact_proof : lshrugt_02_09_exact_before ⊑ lshrugt_02_09_exact_after := by
  unfold lshrugt_02_09_exact_before lshrugt_02_09_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_09_exact
  apply lshrugt_02_09_exact_thm
  ---END lshrugt_02_09_exact



def lshrugt_02_10_exact_before := [llvm|
{
^0(%arg195 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.lshr exact %arg195, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_10_exact_after := [llvm|
{
^0(%arg195 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_10_exact_proof : lshrugt_02_10_exact_before ⊑ lshrugt_02_10_exact_after := by
  unfold lshrugt_02_10_exact_before lshrugt_02_10_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_10_exact
  apply lshrugt_02_10_exact_thm
  ---END lshrugt_02_10_exact



def lshrugt_02_11_exact_before := [llvm|
{
^0(%arg194 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.lshr exact %arg194, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_11_exact_after := [llvm|
{
^0(%arg194 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_11_exact_proof : lshrugt_02_11_exact_before ⊑ lshrugt_02_11_exact_after := by
  unfold lshrugt_02_11_exact_before lshrugt_02_11_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_11_exact
  apply lshrugt_02_11_exact_thm
  ---END lshrugt_02_11_exact



def lshrugt_02_12_exact_before := [llvm|
{
^0(%arg193 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.lshr exact %arg193, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_12_exact_after := [llvm|
{
^0(%arg193 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_12_exact_proof : lshrugt_02_12_exact_before ⊑ lshrugt_02_12_exact_after := by
  unfold lshrugt_02_12_exact_before lshrugt_02_12_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_12_exact
  apply lshrugt_02_12_exact_thm
  ---END lshrugt_02_12_exact



def lshrugt_02_13_exact_before := [llvm|
{
^0(%arg192 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.lshr exact %arg192, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_13_exact_after := [llvm|
{
^0(%arg192 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_13_exact_proof : lshrugt_02_13_exact_before ⊑ lshrugt_02_13_exact_after := by
  unfold lshrugt_02_13_exact_before lshrugt_02_13_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_13_exact
  apply lshrugt_02_13_exact_thm
  ---END lshrugt_02_13_exact



def lshrugt_02_14_exact_before := [llvm|
{
^0(%arg191 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.lshr exact %arg191, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_14_exact_after := [llvm|
{
^0(%arg191 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_14_exact_proof : lshrugt_02_14_exact_before ⊑ lshrugt_02_14_exact_after := by
  unfold lshrugt_02_14_exact_before lshrugt_02_14_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_14_exact
  apply lshrugt_02_14_exact_thm
  ---END lshrugt_02_14_exact



def lshrugt_02_15_exact_before := [llvm|
{
^0(%arg190 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.lshr exact %arg190, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_02_15_exact_after := [llvm|
{
^0(%arg190 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_02_15_exact_proof : lshrugt_02_15_exact_before ⊑ lshrugt_02_15_exact_after := by
  unfold lshrugt_02_15_exact_before lshrugt_02_15_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_02_15_exact
  apply lshrugt_02_15_exact_thm
  ---END lshrugt_02_15_exact



def lshrugt_03_00_exact_before := [llvm|
{
^0(%arg189 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.lshr exact %arg189, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_00_exact_after := [llvm|
{
^0(%arg189 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "ne" %arg189, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_00_exact_proof : lshrugt_03_00_exact_before ⊑ lshrugt_03_00_exact_after := by
  unfold lshrugt_03_00_exact_before lshrugt_03_00_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_00_exact
  apply lshrugt_03_00_exact_thm
  ---END lshrugt_03_00_exact



def lshrugt_03_01_exact_before := [llvm|
{
^0(%arg188 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.lshr exact %arg188, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_01_exact_after := [llvm|
{
^0(%arg188 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_01_exact_proof : lshrugt_03_01_exact_before ⊑ lshrugt_03_01_exact_after := by
  unfold lshrugt_03_01_exact_before lshrugt_03_01_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_01_exact
  apply lshrugt_03_01_exact_thm
  ---END lshrugt_03_01_exact



def lshrugt_03_02_exact_before := [llvm|
{
^0(%arg187 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.lshr exact %arg187, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_02_exact_after := [llvm|
{
^0(%arg187 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_02_exact_proof : lshrugt_03_02_exact_before ⊑ lshrugt_03_02_exact_after := by
  unfold lshrugt_03_02_exact_before lshrugt_03_02_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_02_exact
  apply lshrugt_03_02_exact_thm
  ---END lshrugt_03_02_exact



def lshrugt_03_03_exact_before := [llvm|
{
^0(%arg186 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.lshr exact %arg186, %0 : i4
  %2 = llvm.icmp "ugt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshrugt_03_03_exact_after := [llvm|
{
^0(%arg186 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_03_exact_proof : lshrugt_03_03_exact_before ⊑ lshrugt_03_03_exact_after := by
  unfold lshrugt_03_03_exact_before lshrugt_03_03_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_03_exact
  apply lshrugt_03_03_exact_thm
  ---END lshrugt_03_03_exact



def lshrugt_03_04_exact_before := [llvm|
{
^0(%arg185 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.lshr exact %arg185, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_04_exact_after := [llvm|
{
^0(%arg185 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_04_exact_proof : lshrugt_03_04_exact_before ⊑ lshrugt_03_04_exact_after := by
  unfold lshrugt_03_04_exact_before lshrugt_03_04_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_04_exact
  apply lshrugt_03_04_exact_thm
  ---END lshrugt_03_04_exact



def lshrugt_03_05_exact_before := [llvm|
{
^0(%arg184 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.lshr exact %arg184, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_05_exact_after := [llvm|
{
^0(%arg184 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_05_exact_proof : lshrugt_03_05_exact_before ⊑ lshrugt_03_05_exact_after := by
  unfold lshrugt_03_05_exact_before lshrugt_03_05_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_05_exact
  apply lshrugt_03_05_exact_thm
  ---END lshrugt_03_05_exact



def lshrugt_03_06_exact_before := [llvm|
{
^0(%arg183 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.lshr exact %arg183, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_06_exact_after := [llvm|
{
^0(%arg183 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_06_exact_proof : lshrugt_03_06_exact_before ⊑ lshrugt_03_06_exact_after := by
  unfold lshrugt_03_06_exact_before lshrugt_03_06_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_06_exact
  apply lshrugt_03_06_exact_thm
  ---END lshrugt_03_06_exact



def lshrugt_03_07_exact_before := [llvm|
{
^0(%arg182 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.lshr exact %arg182, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_07_exact_after := [llvm|
{
^0(%arg182 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_07_exact_proof : lshrugt_03_07_exact_before ⊑ lshrugt_03_07_exact_after := by
  unfold lshrugt_03_07_exact_before lshrugt_03_07_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_07_exact
  apply lshrugt_03_07_exact_thm
  ---END lshrugt_03_07_exact



def lshrugt_03_08_exact_before := [llvm|
{
^0(%arg181 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.lshr exact %arg181, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_08_exact_after := [llvm|
{
^0(%arg181 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_08_exact_proof : lshrugt_03_08_exact_before ⊑ lshrugt_03_08_exact_after := by
  unfold lshrugt_03_08_exact_before lshrugt_03_08_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_08_exact
  apply lshrugt_03_08_exact_thm
  ---END lshrugt_03_08_exact



def lshrugt_03_09_exact_before := [llvm|
{
^0(%arg180 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.lshr exact %arg180, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_09_exact_after := [llvm|
{
^0(%arg180 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_09_exact_proof : lshrugt_03_09_exact_before ⊑ lshrugt_03_09_exact_after := by
  unfold lshrugt_03_09_exact_before lshrugt_03_09_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_09_exact
  apply lshrugt_03_09_exact_thm
  ---END lshrugt_03_09_exact



def lshrugt_03_10_exact_before := [llvm|
{
^0(%arg179 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.lshr exact %arg179, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_10_exact_after := [llvm|
{
^0(%arg179 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_10_exact_proof : lshrugt_03_10_exact_before ⊑ lshrugt_03_10_exact_after := by
  unfold lshrugt_03_10_exact_before lshrugt_03_10_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_10_exact
  apply lshrugt_03_10_exact_thm
  ---END lshrugt_03_10_exact



def lshrugt_03_11_exact_before := [llvm|
{
^0(%arg178 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.lshr exact %arg178, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_11_exact_after := [llvm|
{
^0(%arg178 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_11_exact_proof : lshrugt_03_11_exact_before ⊑ lshrugt_03_11_exact_after := by
  unfold lshrugt_03_11_exact_before lshrugt_03_11_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_11_exact
  apply lshrugt_03_11_exact_thm
  ---END lshrugt_03_11_exact



def lshrugt_03_12_exact_before := [llvm|
{
^0(%arg177 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.lshr exact %arg177, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_12_exact_after := [llvm|
{
^0(%arg177 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_12_exact_proof : lshrugt_03_12_exact_before ⊑ lshrugt_03_12_exact_after := by
  unfold lshrugt_03_12_exact_before lshrugt_03_12_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_12_exact
  apply lshrugt_03_12_exact_thm
  ---END lshrugt_03_12_exact



def lshrugt_03_13_exact_before := [llvm|
{
^0(%arg176 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.lshr exact %arg176, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_13_exact_after := [llvm|
{
^0(%arg176 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_13_exact_proof : lshrugt_03_13_exact_before ⊑ lshrugt_03_13_exact_after := by
  unfold lshrugt_03_13_exact_before lshrugt_03_13_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_13_exact
  apply lshrugt_03_13_exact_thm
  ---END lshrugt_03_13_exact



def lshrugt_03_14_exact_before := [llvm|
{
^0(%arg175 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.lshr exact %arg175, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_14_exact_after := [llvm|
{
^0(%arg175 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_14_exact_proof : lshrugt_03_14_exact_before ⊑ lshrugt_03_14_exact_after := by
  unfold lshrugt_03_14_exact_before lshrugt_03_14_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_14_exact
  apply lshrugt_03_14_exact_thm
  ---END lshrugt_03_14_exact



def lshrugt_03_15_exact_before := [llvm|
{
^0(%arg174 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.lshr exact %arg174, %0 : i4
  %3 = llvm.icmp "ugt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrugt_03_15_exact_after := [llvm|
{
^0(%arg174 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrugt_03_15_exact_proof : lshrugt_03_15_exact_before ⊑ lshrugt_03_15_exact_after := by
  unfold lshrugt_03_15_exact_before lshrugt_03_15_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrugt_03_15_exact
  apply lshrugt_03_15_exact_thm
  ---END lshrugt_03_15_exact



def ashr_eq_exact_before := [llvm|
{
^0(%arg173 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr exact %arg173, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_eq_exact_after := [llvm|
{
^0(%arg173 : i8):
  %0 = llvm.mlir.constant(80 : i8) : i8
  %1 = llvm.icmp "eq" %arg173, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_eq_exact_proof : ashr_eq_exact_before ⊑ ashr_eq_exact_after := by
  unfold ashr_eq_exact_before ashr_eq_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_eq_exact
  apply ashr_eq_exact_thm
  ---END ashr_eq_exact



def ashr_ne_exact_before := [llvm|
{
^0(%arg172 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr exact %arg172, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ne_exact_after := [llvm|
{
^0(%arg172 : i8):
  %0 = llvm.mlir.constant(80 : i8) : i8
  %1 = llvm.icmp "ne" %arg172, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ne_exact_proof : ashr_ne_exact_before ⊑ ashr_ne_exact_after := by
  unfold ashr_ne_exact_before ashr_ne_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ne_exact
  apply ashr_ne_exact_thm
  ---END ashr_ne_exact



def ashr_ugt_exact_before := [llvm|
{
^0(%arg171 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr exact %arg171, %0 : i8
  %3 = llvm.icmp "ugt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_exact_after := [llvm|
{
^0(%arg171 : i8):
  %0 = llvm.mlir.constant(80 : i8) : i8
  %1 = llvm.icmp "ugt" %arg171, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_exact_proof : ashr_ugt_exact_before ⊑ ashr_ugt_exact_after := by
  unfold ashr_ugt_exact_before ashr_ugt_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_exact
  apply ashr_ugt_exact_thm
  ---END ashr_ugt_exact



def ashr_uge_exact_before := [llvm|
{
^0(%arg170 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr exact %arg170, %0 : i8
  %3 = llvm.icmp "uge" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_uge_exact_after := [llvm|
{
^0(%arg170 : i8):
  %0 = llvm.mlir.constant(72 : i8) : i8
  %1 = llvm.icmp "ugt" %arg170, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_uge_exact_proof : ashr_uge_exact_before ⊑ ashr_uge_exact_after := by
  unfold ashr_uge_exact_before ashr_uge_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_uge_exact
  apply ashr_uge_exact_thm
  ---END ashr_uge_exact



def ashr_ult_exact_before := [llvm|
{
^0(%arg169 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr exact %arg169, %0 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_exact_after := [llvm|
{
^0(%arg169 : i8):
  %0 = llvm.mlir.constant(80 : i8) : i8
  %1 = llvm.icmp "ult" %arg169, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_exact_proof : ashr_ult_exact_before ⊑ ashr_ult_exact_after := by
  unfold ashr_ult_exact_before ashr_ult_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_exact
  apply ashr_ult_exact_thm
  ---END ashr_ult_exact



def ashr_ule_exact_before := [llvm|
{
^0(%arg168 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr exact %arg168, %0 : i8
  %3 = llvm.icmp "ule" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ule_exact_after := [llvm|
{
^0(%arg168 : i8):
  %0 = llvm.mlir.constant(88 : i8) : i8
  %1 = llvm.icmp "ult" %arg168, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ule_exact_proof : ashr_ule_exact_before ⊑ ashr_ule_exact_after := by
  unfold ashr_ule_exact_before ashr_ule_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ule_exact
  apply ashr_ule_exact_thm
  ---END ashr_ule_exact



def ashr_sgt_exact_before := [llvm|
{
^0(%arg167 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr exact %arg167, %0 : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_sgt_exact_after := [llvm|
{
^0(%arg167 : i8):
  %0 = llvm.mlir.constant(80 : i8) : i8
  %1 = llvm.icmp "sgt" %arg167, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_sgt_exact_proof : ashr_sgt_exact_before ⊑ ashr_sgt_exact_after := by
  unfold ashr_sgt_exact_before ashr_sgt_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_sgt_exact
  apply ashr_sgt_exact_thm
  ---END ashr_sgt_exact



def ashr_sge_exact_before := [llvm|
{
^0(%arg166 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr exact %arg166, %0 : i8
  %3 = llvm.icmp "sge" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_sge_exact_after := [llvm|
{
^0(%arg166 : i8):
  %0 = llvm.mlir.constant(72 : i8) : i8
  %1 = llvm.icmp "sgt" %arg166, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_sge_exact_proof : ashr_sge_exact_before ⊑ ashr_sge_exact_after := by
  unfold ashr_sge_exact_before ashr_sge_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_sge_exact
  apply ashr_sge_exact_thm
  ---END ashr_sge_exact



def ashr_slt_exact_before := [llvm|
{
^0(%arg165 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr exact %arg165, %0 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_slt_exact_after := [llvm|
{
^0(%arg165 : i8):
  %0 = llvm.mlir.constant(80 : i8) : i8
  %1 = llvm.icmp "slt" %arg165, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_slt_exact_proof : ashr_slt_exact_before ⊑ ashr_slt_exact_after := by
  unfold ashr_slt_exact_before ashr_slt_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_slt_exact
  apply ashr_slt_exact_thm
  ---END ashr_slt_exact



def ashr_sle_exact_before := [llvm|
{
^0(%arg164 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr exact %arg164, %0 : i8
  %3 = llvm.icmp "sle" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_sle_exact_after := [llvm|
{
^0(%arg164 : i8):
  %0 = llvm.mlir.constant(88 : i8) : i8
  %1 = llvm.icmp "slt" %arg164, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_sle_exact_proof : ashr_sle_exact_before ⊑ ashr_sle_exact_after := by
  unfold ashr_sle_exact_before ashr_sle_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_sle_exact
  apply ashr_sle_exact_thm
  ---END ashr_sle_exact



def ashr_eq_noexact_before := [llvm|
{
^0(%arg163 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr %arg163, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_eq_noexact_after := [llvm|
{
^0(%arg163 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.mlir.constant(80 : i8) : i8
  %2 = llvm.and %arg163, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_eq_noexact_proof : ashr_eq_noexact_before ⊑ ashr_eq_noexact_after := by
  unfold ashr_eq_noexact_before ashr_eq_noexact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_eq_noexact
  apply ashr_eq_noexact_thm
  ---END ashr_eq_noexact



def ashr_ne_noexact_before := [llvm|
{
^0(%arg162 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr %arg162, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ne_noexact_after := [llvm|
{
^0(%arg162 : i8):
  %0 = llvm.mlir.constant(-8 : i8) : i8
  %1 = llvm.mlir.constant(80 : i8) : i8
  %2 = llvm.and %arg162, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ne_noexact_proof : ashr_ne_noexact_before ⊑ ashr_ne_noexact_after := by
  unfold ashr_ne_noexact_before ashr_ne_noexact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ne_noexact
  apply ashr_ne_noexact_thm
  ---END ashr_ne_noexact



def ashr_ugt_noexact_before := [llvm|
{
^0(%arg161 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr %arg161, %0 : i8
  %3 = llvm.icmp "ugt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ugt_noexact_after := [llvm|
{
^0(%arg161 : i8):
  %0 = llvm.mlir.constant(87 : i8) : i8
  %1 = llvm.icmp "ugt" %arg161, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ugt_noexact_proof : ashr_ugt_noexact_before ⊑ ashr_ugt_noexact_after := by
  unfold ashr_ugt_noexact_before ashr_ugt_noexact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ugt_noexact
  apply ashr_ugt_noexact_thm
  ---END ashr_ugt_noexact



def ashr_uge_noexact_before := [llvm|
{
^0(%arg160 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr %arg160, %0 : i8
  %3 = llvm.icmp "uge" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_uge_noexact_after := [llvm|
{
^0(%arg160 : i8):
  %0 = llvm.mlir.constant(79 : i8) : i8
  %1 = llvm.icmp "ugt" %arg160, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_uge_noexact_proof : ashr_uge_noexact_before ⊑ ashr_uge_noexact_after := by
  unfold ashr_uge_noexact_before ashr_uge_noexact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_uge_noexact
  apply ashr_uge_noexact_thm
  ---END ashr_uge_noexact



def ashr_ult_noexact_before := [llvm|
{
^0(%arg159 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr %arg159, %0 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_noexact_after := [llvm|
{
^0(%arg159 : i8):
  %0 = llvm.mlir.constant(80 : i8) : i8
  %1 = llvm.icmp "ult" %arg159, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_noexact_proof : ashr_ult_noexact_before ⊑ ashr_ult_noexact_after := by
  unfold ashr_ult_noexact_before ashr_ult_noexact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_noexact
  apply ashr_ult_noexact_thm
  ---END ashr_ult_noexact



def ashr_ule_noexact_before := [llvm|
{
^0(%arg158 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr %arg158, %0 : i8
  %3 = llvm.icmp "ule" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ule_noexact_after := [llvm|
{
^0(%arg158 : i8):
  %0 = llvm.mlir.constant(88 : i8) : i8
  %1 = llvm.icmp "ult" %arg158, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ule_noexact_proof : ashr_ule_noexact_before ⊑ ashr_ule_noexact_after := by
  unfold ashr_ule_noexact_before ashr_ule_noexact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ule_noexact
  apply ashr_ule_noexact_thm
  ---END ashr_ule_noexact



def ashr_sgt_noexact_before := [llvm|
{
^0(%arg157 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr %arg157, %0 : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_sgt_noexact_after := [llvm|
{
^0(%arg157 : i8):
  %0 = llvm.mlir.constant(87 : i8) : i8
  %1 = llvm.icmp "sgt" %arg157, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_sgt_noexact_proof : ashr_sgt_noexact_before ⊑ ashr_sgt_noexact_after := by
  unfold ashr_sgt_noexact_before ashr_sgt_noexact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_sgt_noexact
  apply ashr_sgt_noexact_thm
  ---END ashr_sgt_noexact



def ashr_sge_noexact_before := [llvm|
{
^0(%arg156 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr %arg156, %0 : i8
  %3 = llvm.icmp "sge" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_sge_noexact_after := [llvm|
{
^0(%arg156 : i8):
  %0 = llvm.mlir.constant(79 : i8) : i8
  %1 = llvm.icmp "sgt" %arg156, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_sge_noexact_proof : ashr_sge_noexact_before ⊑ ashr_sge_noexact_after := by
  unfold ashr_sge_noexact_before ashr_sge_noexact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_sge_noexact
  apply ashr_sge_noexact_thm
  ---END ashr_sge_noexact



def ashr_slt_noexact_before := [llvm|
{
^0(%arg155 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr %arg155, %0 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_slt_noexact_after := [llvm|
{
^0(%arg155 : i8):
  %0 = llvm.mlir.constant(80 : i8) : i8
  %1 = llvm.icmp "slt" %arg155, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_slt_noexact_proof : ashr_slt_noexact_before ⊑ ashr_slt_noexact_after := by
  unfold ashr_slt_noexact_before ashr_slt_noexact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_slt_noexact
  apply ashr_slt_noexact_thm
  ---END ashr_slt_noexact



def ashr_sle_noexact_before := [llvm|
{
^0(%arg154 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.ashr %arg154, %0 : i8
  %3 = llvm.icmp "sle" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_sle_noexact_after := [llvm|
{
^0(%arg154 : i8):
  %0 = llvm.mlir.constant(88 : i8) : i8
  %1 = llvm.icmp "slt" %arg154, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_sle_noexact_proof : ashr_sle_noexact_before ⊑ ashr_sle_noexact_after := by
  unfold ashr_sle_noexact_before ashr_sle_noexact_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_sle_noexact
  apply ashr_sle_noexact_thm
  ---END ashr_sle_noexact



def ashr_sgt_overflow_before := [llvm|
{
^0(%arg150 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(63 : i8) : i8
  %2 = llvm.ashr %arg150, %0 : i8
  %3 = llvm.icmp "sgt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_sgt_overflow_after := [llvm|
{
^0(%arg150 : i8):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_sgt_overflow_proof : ashr_sgt_overflow_before ⊑ ashr_sgt_overflow_after := by
  unfold ashr_sgt_overflow_before ashr_sgt_overflow_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_sgt_overflow
  apply ashr_sgt_overflow_thm
  ---END ashr_sgt_overflow



def lshrult_01_00_exact_before := [llvm|
{
^0(%arg149 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.lshr exact %arg149, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_00_exact_after := [llvm|
{
^0(%arg149 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_00_exact_proof : lshrult_01_00_exact_before ⊑ lshrult_01_00_exact_after := by
  unfold lshrult_01_00_exact_before lshrult_01_00_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_00_exact
  apply lshrult_01_00_exact_thm
  ---END lshrult_01_00_exact



def lshrult_01_01_exact_before := [llvm|
{
^0(%arg148 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.lshr exact %arg148, %0 : i4
  %2 = llvm.icmp "ult" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshrult_01_01_exact_after := [llvm|
{
^0(%arg148 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "eq" %arg148, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_01_exact_proof : lshrult_01_01_exact_before ⊑ lshrult_01_01_exact_after := by
  unfold lshrult_01_01_exact_before lshrult_01_01_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_01_exact
  apply lshrult_01_01_exact_thm
  ---END lshrult_01_01_exact



def lshrult_01_02_exact_before := [llvm|
{
^0(%arg147 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.lshr exact %arg147, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_02_exact_after := [llvm|
{
^0(%arg147 : i4):
  %0 = llvm.mlir.constant(4 : i4) : i4
  %1 = llvm.icmp "ult" %arg147, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_02_exact_proof : lshrult_01_02_exact_before ⊑ lshrult_01_02_exact_after := by
  unfold lshrult_01_02_exact_before lshrult_01_02_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_02_exact
  apply lshrult_01_02_exact_thm
  ---END lshrult_01_02_exact



def lshrult_01_03_exact_before := [llvm|
{
^0(%arg146 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.lshr exact %arg146, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_03_exact_after := [llvm|
{
^0(%arg146 : i4):
  %0 = llvm.mlir.constant(6 : i4) : i4
  %1 = llvm.icmp "ult" %arg146, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_03_exact_proof : lshrult_01_03_exact_before ⊑ lshrult_01_03_exact_after := by
  unfold lshrult_01_03_exact_before lshrult_01_03_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_03_exact
  apply lshrult_01_03_exact_thm
  ---END lshrult_01_03_exact



def lshrult_01_04_exact_before := [llvm|
{
^0(%arg145 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.lshr exact %arg145, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_04_exact_after := [llvm|
{
^0(%arg145 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg145, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_04_exact_proof : lshrult_01_04_exact_before ⊑ lshrult_01_04_exact_after := by
  unfold lshrult_01_04_exact_before lshrult_01_04_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_04_exact
  apply lshrult_01_04_exact_thm
  ---END lshrult_01_04_exact



def lshrult_01_05_exact_before := [llvm|
{
^0(%arg144 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.lshr exact %arg144, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_05_exact_after := [llvm|
{
^0(%arg144 : i4):
  %0 = llvm.mlir.constant(-6 : i4) : i4
  %1 = llvm.icmp "ult" %arg144, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_05_exact_proof : lshrult_01_05_exact_before ⊑ lshrult_01_05_exact_after := by
  unfold lshrult_01_05_exact_before lshrult_01_05_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_05_exact
  apply lshrult_01_05_exact_thm
  ---END lshrult_01_05_exact



def lshrult_01_06_exact_before := [llvm|
{
^0(%arg143 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.lshr exact %arg143, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_06_exact_after := [llvm|
{
^0(%arg143 : i4):
  %0 = llvm.mlir.constant(-4 : i4) : i4
  %1 = llvm.icmp "ult" %arg143, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_06_exact_proof : lshrult_01_06_exact_before ⊑ lshrult_01_06_exact_after := by
  unfold lshrult_01_06_exact_before lshrult_01_06_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_06_exact
  apply lshrult_01_06_exact_thm
  ---END lshrult_01_06_exact



def lshrult_01_07_exact_before := [llvm|
{
^0(%arg142 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.lshr exact %arg142, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_07_exact_after := [llvm|
{
^0(%arg142 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.icmp "ne" %arg142, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_07_exact_proof : lshrult_01_07_exact_before ⊑ lshrult_01_07_exact_after := by
  unfold lshrult_01_07_exact_before lshrult_01_07_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_07_exact
  apply lshrult_01_07_exact_thm
  ---END lshrult_01_07_exact



def lshrult_01_08_exact_before := [llvm|
{
^0(%arg141 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.lshr exact %arg141, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_08_exact_after := [llvm|
{
^0(%arg141 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_08_exact_proof : lshrult_01_08_exact_before ⊑ lshrult_01_08_exact_after := by
  unfold lshrult_01_08_exact_before lshrult_01_08_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_08_exact
  apply lshrult_01_08_exact_thm
  ---END lshrult_01_08_exact



def lshrult_01_09_exact_before := [llvm|
{
^0(%arg140 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.lshr exact %arg140, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_09_exact_after := [llvm|
{
^0(%arg140 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_09_exact_proof : lshrult_01_09_exact_before ⊑ lshrult_01_09_exact_after := by
  unfold lshrult_01_09_exact_before lshrult_01_09_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_09_exact
  apply lshrult_01_09_exact_thm
  ---END lshrult_01_09_exact



def lshrult_01_10_exact_before := [llvm|
{
^0(%arg139 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.lshr exact %arg139, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_10_exact_after := [llvm|
{
^0(%arg139 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_10_exact_proof : lshrult_01_10_exact_before ⊑ lshrult_01_10_exact_after := by
  unfold lshrult_01_10_exact_before lshrult_01_10_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_10_exact
  apply lshrult_01_10_exact_thm
  ---END lshrult_01_10_exact



def lshrult_01_11_exact_before := [llvm|
{
^0(%arg138 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.lshr exact %arg138, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_11_exact_after := [llvm|
{
^0(%arg138 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_11_exact_proof : lshrult_01_11_exact_before ⊑ lshrult_01_11_exact_after := by
  unfold lshrult_01_11_exact_before lshrult_01_11_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_11_exact
  apply lshrult_01_11_exact_thm
  ---END lshrult_01_11_exact



def lshrult_01_12_exact_before := [llvm|
{
^0(%arg137 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.lshr exact %arg137, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_12_exact_after := [llvm|
{
^0(%arg137 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_12_exact_proof : lshrult_01_12_exact_before ⊑ lshrult_01_12_exact_after := by
  unfold lshrult_01_12_exact_before lshrult_01_12_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_12_exact
  apply lshrult_01_12_exact_thm
  ---END lshrult_01_12_exact



def lshrult_01_13_exact_before := [llvm|
{
^0(%arg136 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.lshr exact %arg136, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_13_exact_after := [llvm|
{
^0(%arg136 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_13_exact_proof : lshrult_01_13_exact_before ⊑ lshrult_01_13_exact_after := by
  unfold lshrult_01_13_exact_before lshrult_01_13_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_13_exact
  apply lshrult_01_13_exact_thm
  ---END lshrult_01_13_exact



def lshrult_01_14_exact_before := [llvm|
{
^0(%arg135 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.lshr exact %arg135, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_14_exact_after := [llvm|
{
^0(%arg135 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_14_exact_proof : lshrult_01_14_exact_before ⊑ lshrult_01_14_exact_after := by
  unfold lshrult_01_14_exact_before lshrult_01_14_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_14_exact
  apply lshrult_01_14_exact_thm
  ---END lshrult_01_14_exact



def lshrult_01_15_exact_before := [llvm|
{
^0(%arg134 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.lshr exact %arg134, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_01_15_exact_after := [llvm|
{
^0(%arg134 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_01_15_exact_proof : lshrult_01_15_exact_before ⊑ lshrult_01_15_exact_after := by
  unfold lshrult_01_15_exact_before lshrult_01_15_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_01_15_exact
  apply lshrult_01_15_exact_thm
  ---END lshrult_01_15_exact



def lshrult_02_00_exact_before := [llvm|
{
^0(%arg133 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.lshr exact %arg133, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_00_exact_after := [llvm|
{
^0(%arg133 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_00_exact_proof : lshrult_02_00_exact_before ⊑ lshrult_02_00_exact_after := by
  unfold lshrult_02_00_exact_before lshrult_02_00_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_00_exact
  apply lshrult_02_00_exact_thm
  ---END lshrult_02_00_exact



def lshrult_02_01_exact_before := [llvm|
{
^0(%arg132 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.lshr exact %arg132, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_01_exact_after := [llvm|
{
^0(%arg132 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "eq" %arg132, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_01_exact_proof : lshrult_02_01_exact_before ⊑ lshrult_02_01_exact_after := by
  unfold lshrult_02_01_exact_before lshrult_02_01_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_01_exact
  apply lshrult_02_01_exact_thm
  ---END lshrult_02_01_exact



def lshrult_02_02_exact_before := [llvm|
{
^0(%arg131 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.lshr exact %arg131, %0 : i4
  %2 = llvm.icmp "ult" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshrult_02_02_exact_after := [llvm|
{
^0(%arg131 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg131, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_02_exact_proof : lshrult_02_02_exact_before ⊑ lshrult_02_02_exact_after := by
  unfold lshrult_02_02_exact_before lshrult_02_02_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_02_exact
  apply lshrult_02_02_exact_thm
  ---END lshrult_02_02_exact



def lshrult_02_03_exact_before := [llvm|
{
^0(%arg130 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.lshr exact %arg130, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_03_exact_after := [llvm|
{
^0(%arg130 : i4):
  %0 = llvm.mlir.constant(-4 : i4) : i4
  %1 = llvm.icmp "ne" %arg130, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_03_exact_proof : lshrult_02_03_exact_before ⊑ lshrult_02_03_exact_after := by
  unfold lshrult_02_03_exact_before lshrult_02_03_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_03_exact
  apply lshrult_02_03_exact_thm
  ---END lshrult_02_03_exact



def lshrult_02_04_exact_before := [llvm|
{
^0(%arg129 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.lshr exact %arg129, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_04_exact_after := [llvm|
{
^0(%arg129 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_04_exact_proof : lshrult_02_04_exact_before ⊑ lshrult_02_04_exact_after := by
  unfold lshrult_02_04_exact_before lshrult_02_04_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_04_exact
  apply lshrult_02_04_exact_thm
  ---END lshrult_02_04_exact



def lshrult_02_05_exact_before := [llvm|
{
^0(%arg128 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.lshr exact %arg128, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_05_exact_after := [llvm|
{
^0(%arg128 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_05_exact_proof : lshrult_02_05_exact_before ⊑ lshrult_02_05_exact_after := by
  unfold lshrult_02_05_exact_before lshrult_02_05_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_05_exact
  apply lshrult_02_05_exact_thm
  ---END lshrult_02_05_exact



def lshrult_02_06_exact_before := [llvm|
{
^0(%arg127 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.lshr exact %arg127, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_06_exact_after := [llvm|
{
^0(%arg127 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_06_exact_proof : lshrult_02_06_exact_before ⊑ lshrult_02_06_exact_after := by
  unfold lshrult_02_06_exact_before lshrult_02_06_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_06_exact
  apply lshrult_02_06_exact_thm
  ---END lshrult_02_06_exact



def lshrult_02_07_exact_before := [llvm|
{
^0(%arg126 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.lshr exact %arg126, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_07_exact_after := [llvm|
{
^0(%arg126 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_07_exact_proof : lshrult_02_07_exact_before ⊑ lshrult_02_07_exact_after := by
  unfold lshrult_02_07_exact_before lshrult_02_07_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_07_exact
  apply lshrult_02_07_exact_thm
  ---END lshrult_02_07_exact



def lshrult_02_08_exact_before := [llvm|
{
^0(%arg125 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.lshr exact %arg125, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_08_exact_after := [llvm|
{
^0(%arg125 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_08_exact_proof : lshrult_02_08_exact_before ⊑ lshrult_02_08_exact_after := by
  unfold lshrult_02_08_exact_before lshrult_02_08_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_08_exact
  apply lshrult_02_08_exact_thm
  ---END lshrult_02_08_exact



def lshrult_02_09_exact_before := [llvm|
{
^0(%arg124 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.lshr exact %arg124, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_09_exact_after := [llvm|
{
^0(%arg124 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_09_exact_proof : lshrult_02_09_exact_before ⊑ lshrult_02_09_exact_after := by
  unfold lshrult_02_09_exact_before lshrult_02_09_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_09_exact
  apply lshrult_02_09_exact_thm
  ---END lshrult_02_09_exact



def lshrult_02_10_exact_before := [llvm|
{
^0(%arg123 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.lshr exact %arg123, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_10_exact_after := [llvm|
{
^0(%arg123 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_10_exact_proof : lshrult_02_10_exact_before ⊑ lshrult_02_10_exact_after := by
  unfold lshrult_02_10_exact_before lshrult_02_10_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_10_exact
  apply lshrult_02_10_exact_thm
  ---END lshrult_02_10_exact



def lshrult_02_11_exact_before := [llvm|
{
^0(%arg122 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.lshr exact %arg122, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_11_exact_after := [llvm|
{
^0(%arg122 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_11_exact_proof : lshrult_02_11_exact_before ⊑ lshrult_02_11_exact_after := by
  unfold lshrult_02_11_exact_before lshrult_02_11_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_11_exact
  apply lshrult_02_11_exact_thm
  ---END lshrult_02_11_exact



def lshrult_02_12_exact_before := [llvm|
{
^0(%arg121 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.lshr exact %arg121, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_12_exact_after := [llvm|
{
^0(%arg121 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_12_exact_proof : lshrult_02_12_exact_before ⊑ lshrult_02_12_exact_after := by
  unfold lshrult_02_12_exact_before lshrult_02_12_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_12_exact
  apply lshrult_02_12_exact_thm
  ---END lshrult_02_12_exact



def lshrult_02_13_exact_before := [llvm|
{
^0(%arg120 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.lshr exact %arg120, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_13_exact_after := [llvm|
{
^0(%arg120 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_13_exact_proof : lshrult_02_13_exact_before ⊑ lshrult_02_13_exact_after := by
  unfold lshrult_02_13_exact_before lshrult_02_13_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_13_exact
  apply lshrult_02_13_exact_thm
  ---END lshrult_02_13_exact



def lshrult_02_14_exact_before := [llvm|
{
^0(%arg119 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.lshr exact %arg119, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_14_exact_after := [llvm|
{
^0(%arg119 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_14_exact_proof : lshrult_02_14_exact_before ⊑ lshrult_02_14_exact_after := by
  unfold lshrult_02_14_exact_before lshrult_02_14_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_14_exact
  apply lshrult_02_14_exact_thm
  ---END lshrult_02_14_exact



def lshrult_02_15_exact_before := [llvm|
{
^0(%arg118 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.lshr exact %arg118, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_02_15_exact_after := [llvm|
{
^0(%arg118 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_02_15_exact_proof : lshrult_02_15_exact_before ⊑ lshrult_02_15_exact_after := by
  unfold lshrult_02_15_exact_before lshrult_02_15_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_02_15_exact
  apply lshrult_02_15_exact_thm
  ---END lshrult_02_15_exact



def lshrult_03_00_exact_before := [llvm|
{
^0(%arg117 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.lshr exact %arg117, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_00_exact_after := [llvm|
{
^0(%arg117 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_00_exact_proof : lshrult_03_00_exact_before ⊑ lshrult_03_00_exact_after := by
  unfold lshrult_03_00_exact_before lshrult_03_00_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_00_exact
  apply lshrult_03_00_exact_thm
  ---END lshrult_03_00_exact



def lshrult_03_01_exact_before := [llvm|
{
^0(%arg116 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.lshr exact %arg116, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_01_exact_after := [llvm|
{
^0(%arg116 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "eq" %arg116, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_01_exact_proof : lshrult_03_01_exact_before ⊑ lshrult_03_01_exact_after := by
  unfold lshrult_03_01_exact_before lshrult_03_01_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_01_exact
  apply lshrult_03_01_exact_thm
  ---END lshrult_03_01_exact



def lshrult_03_02_exact_before := [llvm|
{
^0(%arg115 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.lshr exact %arg115, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_02_exact_after := [llvm|
{
^0(%arg115 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_02_exact_proof : lshrult_03_02_exact_before ⊑ lshrult_03_02_exact_after := by
  unfold lshrult_03_02_exact_before lshrult_03_02_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_02_exact
  apply lshrult_03_02_exact_thm
  ---END lshrult_03_02_exact



def lshrult_03_03_exact_before := [llvm|
{
^0(%arg114 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.lshr exact %arg114, %0 : i4
  %2 = llvm.icmp "ult" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def lshrult_03_03_exact_after := [llvm|
{
^0(%arg114 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_03_exact_proof : lshrult_03_03_exact_before ⊑ lshrult_03_03_exact_after := by
  unfold lshrult_03_03_exact_before lshrult_03_03_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_03_exact
  apply lshrult_03_03_exact_thm
  ---END lshrult_03_03_exact



def lshrult_03_04_exact_before := [llvm|
{
^0(%arg113 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.lshr exact %arg113, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_04_exact_after := [llvm|
{
^0(%arg113 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_04_exact_proof : lshrult_03_04_exact_before ⊑ lshrult_03_04_exact_after := by
  unfold lshrult_03_04_exact_before lshrult_03_04_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_04_exact
  apply lshrult_03_04_exact_thm
  ---END lshrult_03_04_exact



def lshrult_03_05_exact_before := [llvm|
{
^0(%arg112 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.lshr exact %arg112, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_05_exact_after := [llvm|
{
^0(%arg112 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_05_exact_proof : lshrult_03_05_exact_before ⊑ lshrult_03_05_exact_after := by
  unfold lshrult_03_05_exact_before lshrult_03_05_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_05_exact
  apply lshrult_03_05_exact_thm
  ---END lshrult_03_05_exact



def lshrult_03_06_exact_before := [llvm|
{
^0(%arg111 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.lshr exact %arg111, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_06_exact_after := [llvm|
{
^0(%arg111 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_06_exact_proof : lshrult_03_06_exact_before ⊑ lshrult_03_06_exact_after := by
  unfold lshrult_03_06_exact_before lshrult_03_06_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_06_exact
  apply lshrult_03_06_exact_thm
  ---END lshrult_03_06_exact



def lshrult_03_07_exact_before := [llvm|
{
^0(%arg110 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.lshr exact %arg110, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_07_exact_after := [llvm|
{
^0(%arg110 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_07_exact_proof : lshrult_03_07_exact_before ⊑ lshrult_03_07_exact_after := by
  unfold lshrult_03_07_exact_before lshrult_03_07_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_07_exact
  apply lshrult_03_07_exact_thm
  ---END lshrult_03_07_exact



def lshrult_03_08_exact_before := [llvm|
{
^0(%arg109 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.lshr exact %arg109, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_08_exact_after := [llvm|
{
^0(%arg109 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_08_exact_proof : lshrult_03_08_exact_before ⊑ lshrult_03_08_exact_after := by
  unfold lshrult_03_08_exact_before lshrult_03_08_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_08_exact
  apply lshrult_03_08_exact_thm
  ---END lshrult_03_08_exact



def lshrult_03_09_exact_before := [llvm|
{
^0(%arg108 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.lshr exact %arg108, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_09_exact_after := [llvm|
{
^0(%arg108 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_09_exact_proof : lshrult_03_09_exact_before ⊑ lshrult_03_09_exact_after := by
  unfold lshrult_03_09_exact_before lshrult_03_09_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_09_exact
  apply lshrult_03_09_exact_thm
  ---END lshrult_03_09_exact



def lshrult_03_10_exact_before := [llvm|
{
^0(%arg107 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.lshr exact %arg107, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_10_exact_after := [llvm|
{
^0(%arg107 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_10_exact_proof : lshrult_03_10_exact_before ⊑ lshrult_03_10_exact_after := by
  unfold lshrult_03_10_exact_before lshrult_03_10_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_10_exact
  apply lshrult_03_10_exact_thm
  ---END lshrult_03_10_exact



def lshrult_03_11_exact_before := [llvm|
{
^0(%arg106 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.lshr exact %arg106, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_11_exact_after := [llvm|
{
^0(%arg106 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_11_exact_proof : lshrult_03_11_exact_before ⊑ lshrult_03_11_exact_after := by
  unfold lshrult_03_11_exact_before lshrult_03_11_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_11_exact
  apply lshrult_03_11_exact_thm
  ---END lshrult_03_11_exact



def lshrult_03_12_exact_before := [llvm|
{
^0(%arg105 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.lshr exact %arg105, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_12_exact_after := [llvm|
{
^0(%arg105 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_12_exact_proof : lshrult_03_12_exact_before ⊑ lshrult_03_12_exact_after := by
  unfold lshrult_03_12_exact_before lshrult_03_12_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_12_exact
  apply lshrult_03_12_exact_thm
  ---END lshrult_03_12_exact



def lshrult_03_13_exact_before := [llvm|
{
^0(%arg104 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.lshr exact %arg104, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_13_exact_after := [llvm|
{
^0(%arg104 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_13_exact_proof : lshrult_03_13_exact_before ⊑ lshrult_03_13_exact_after := by
  unfold lshrult_03_13_exact_before lshrult_03_13_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_13_exact
  apply lshrult_03_13_exact_thm
  ---END lshrult_03_13_exact



def lshrult_03_14_exact_before := [llvm|
{
^0(%arg103 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.lshr exact %arg103, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_14_exact_after := [llvm|
{
^0(%arg103 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_14_exact_proof : lshrult_03_14_exact_before ⊑ lshrult_03_14_exact_after := by
  unfold lshrult_03_14_exact_before lshrult_03_14_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_14_exact
  apply lshrult_03_14_exact_thm
  ---END lshrult_03_14_exact



def lshrult_03_15_exact_before := [llvm|
{
^0(%arg102 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.lshr exact %arg102, %0 : i4
  %3 = llvm.icmp "ult" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def lshrult_03_15_exact_after := [llvm|
{
^0(%arg102 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshrult_03_15_exact_proof : lshrult_03_15_exact_before ⊑ lshrult_03_15_exact_after := by
  unfold lshrult_03_15_exact_before lshrult_03_15_exact_after
  simp_alive_peephole
  intros
  ---BEGIN lshrult_03_15_exact
  apply lshrult_03_15_exact_thm
  ---END lshrult_03_15_exact



def ashrsgt_01_00_exact_before := [llvm|
{
^0(%arg101 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.ashr exact %arg101, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_00_exact_after := [llvm|
{
^0(%arg101 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "sgt" %arg101, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_00_exact_proof : ashrsgt_01_00_exact_before ⊑ ashrsgt_01_00_exact_after := by
  unfold ashrsgt_01_00_exact_before ashrsgt_01_00_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_00_exact
  apply ashrsgt_01_00_exact_thm
  ---END ashrsgt_01_00_exact



def ashrsgt_01_01_exact_before := [llvm|
{
^0(%arg100 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.ashr exact %arg100, %0 : i4
  %2 = llvm.icmp "sgt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashrsgt_01_01_exact_after := [llvm|
{
^0(%arg100 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.icmp "sgt" %arg100, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_01_exact_proof : ashrsgt_01_01_exact_before ⊑ ashrsgt_01_01_exact_after := by
  unfold ashrsgt_01_01_exact_before ashrsgt_01_01_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_01_exact
  apply ashrsgt_01_01_exact_thm
  ---END ashrsgt_01_01_exact



def ashrsgt_01_02_exact_before := [llvm|
{
^0(%arg99 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.ashr exact %arg99, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_02_exact_after := [llvm|
{
^0(%arg99 : i4):
  %0 = llvm.mlir.constant(4 : i4) : i4
  %1 = llvm.icmp "sgt" %arg99, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_02_exact_proof : ashrsgt_01_02_exact_before ⊑ ashrsgt_01_02_exact_after := by
  unfold ashrsgt_01_02_exact_before ashrsgt_01_02_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_02_exact
  apply ashrsgt_01_02_exact_thm
  ---END ashrsgt_01_02_exact



def ashrsgt_01_03_exact_before := [llvm|
{
^0(%arg98 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.ashr exact %arg98, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_03_exact_after := [llvm|
{
^0(%arg98 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_03_exact_proof : ashrsgt_01_03_exact_before ⊑ ashrsgt_01_03_exact_after := by
  unfold ashrsgt_01_03_exact_before ashrsgt_01_03_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_03_exact
  apply ashrsgt_01_03_exact_thm
  ---END ashrsgt_01_03_exact



def ashrsgt_01_04_exact_before := [llvm|
{
^0(%arg97 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.ashr exact %arg97, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_04_exact_after := [llvm|
{
^0(%arg97 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_04_exact_proof : ashrsgt_01_04_exact_before ⊑ ashrsgt_01_04_exact_after := by
  unfold ashrsgt_01_04_exact_before ashrsgt_01_04_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_04_exact
  apply ashrsgt_01_04_exact_thm
  ---END ashrsgt_01_04_exact



def ashrsgt_01_05_exact_before := [llvm|
{
^0(%arg96 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.ashr exact %arg96, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_05_exact_after := [llvm|
{
^0(%arg96 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_05_exact_proof : ashrsgt_01_05_exact_before ⊑ ashrsgt_01_05_exact_after := by
  unfold ashrsgt_01_05_exact_before ashrsgt_01_05_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_05_exact
  apply ashrsgt_01_05_exact_thm
  ---END ashrsgt_01_05_exact



def ashrsgt_01_06_exact_before := [llvm|
{
^0(%arg95 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.ashr exact %arg95, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_06_exact_after := [llvm|
{
^0(%arg95 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_06_exact_proof : ashrsgt_01_06_exact_before ⊑ ashrsgt_01_06_exact_after := by
  unfold ashrsgt_01_06_exact_before ashrsgt_01_06_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_06_exact
  apply ashrsgt_01_06_exact_thm
  ---END ashrsgt_01_06_exact



def ashrsgt_01_07_exact_before := [llvm|
{
^0(%arg94 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.ashr exact %arg94, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_07_exact_after := [llvm|
{
^0(%arg94 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_07_exact_proof : ashrsgt_01_07_exact_before ⊑ ashrsgt_01_07_exact_after := by
  unfold ashrsgt_01_07_exact_before ashrsgt_01_07_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_07_exact
  apply ashrsgt_01_07_exact_thm
  ---END ashrsgt_01_07_exact



def ashrsgt_01_08_exact_before := [llvm|
{
^0(%arg93 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.ashr exact %arg93, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_08_exact_after := [llvm|
{
^0(%arg93 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_08_exact_proof : ashrsgt_01_08_exact_before ⊑ ashrsgt_01_08_exact_after := by
  unfold ashrsgt_01_08_exact_before ashrsgt_01_08_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_08_exact
  apply ashrsgt_01_08_exact_thm
  ---END ashrsgt_01_08_exact



def ashrsgt_01_09_exact_before := [llvm|
{
^0(%arg92 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.ashr exact %arg92, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_09_exact_after := [llvm|
{
^0(%arg92 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_09_exact_proof : ashrsgt_01_09_exact_before ⊑ ashrsgt_01_09_exact_after := by
  unfold ashrsgt_01_09_exact_before ashrsgt_01_09_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_09_exact
  apply ashrsgt_01_09_exact_thm
  ---END ashrsgt_01_09_exact



def ashrsgt_01_10_exact_before := [llvm|
{
^0(%arg91 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.ashr exact %arg91, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_10_exact_after := [llvm|
{
^0(%arg91 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_10_exact_proof : ashrsgt_01_10_exact_before ⊑ ashrsgt_01_10_exact_after := by
  unfold ashrsgt_01_10_exact_before ashrsgt_01_10_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_10_exact
  apply ashrsgt_01_10_exact_thm
  ---END ashrsgt_01_10_exact



def ashrsgt_01_11_exact_before := [llvm|
{
^0(%arg90 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.ashr exact %arg90, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_11_exact_after := [llvm|
{
^0(%arg90 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_11_exact_proof : ashrsgt_01_11_exact_before ⊑ ashrsgt_01_11_exact_after := by
  unfold ashrsgt_01_11_exact_before ashrsgt_01_11_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_11_exact
  apply ashrsgt_01_11_exact_thm
  ---END ashrsgt_01_11_exact



def ashrsgt_01_12_exact_before := [llvm|
{
^0(%arg89 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.ashr exact %arg89, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_12_exact_after := [llvm|
{
^0(%arg89 : i4):
  %0 = llvm.mlir.constant(-8 : i4) : i4
  %1 = llvm.icmp "ne" %arg89, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_12_exact_proof : ashrsgt_01_12_exact_before ⊑ ashrsgt_01_12_exact_after := by
  unfold ashrsgt_01_12_exact_before ashrsgt_01_12_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_12_exact
  apply ashrsgt_01_12_exact_thm
  ---END ashrsgt_01_12_exact



def ashrsgt_01_13_exact_before := [llvm|
{
^0(%arg88 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.ashr exact %arg88, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_13_exact_after := [llvm|
{
^0(%arg88 : i4):
  %0 = llvm.mlir.constant(-6 : i4) : i4
  %1 = llvm.icmp "sgt" %arg88, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_13_exact_proof : ashrsgt_01_13_exact_before ⊑ ashrsgt_01_13_exact_after := by
  unfold ashrsgt_01_13_exact_before ashrsgt_01_13_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_13_exact
  apply ashrsgt_01_13_exact_thm
  ---END ashrsgt_01_13_exact



def ashrsgt_01_14_exact_before := [llvm|
{
^0(%arg87 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.ashr exact %arg87, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_14_exact_after := [llvm|
{
^0(%arg87 : i4):
  %0 = llvm.mlir.constant(-4 : i4) : i4
  %1 = llvm.icmp "sgt" %arg87, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_14_exact_proof : ashrsgt_01_14_exact_before ⊑ ashrsgt_01_14_exact_after := by
  unfold ashrsgt_01_14_exact_before ashrsgt_01_14_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_14_exact
  apply ashrsgt_01_14_exact_thm
  ---END ashrsgt_01_14_exact



def ashrsgt_01_15_exact_before := [llvm|
{
^0(%arg86 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.ashr exact %arg86, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_01_15_exact_after := [llvm|
{
^0(%arg86 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg86, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_01_15_exact_proof : ashrsgt_01_15_exact_before ⊑ ashrsgt_01_15_exact_after := by
  unfold ashrsgt_01_15_exact_before ashrsgt_01_15_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_01_15_exact
  apply ashrsgt_01_15_exact_thm
  ---END ashrsgt_01_15_exact



def ashrsgt_02_00_exact_before := [llvm|
{
^0(%arg85 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.ashr exact %arg85, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_00_exact_after := [llvm|
{
^0(%arg85 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "sgt" %arg85, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_00_exact_proof : ashrsgt_02_00_exact_before ⊑ ashrsgt_02_00_exact_after := by
  unfold ashrsgt_02_00_exact_before ashrsgt_02_00_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_00_exact
  apply ashrsgt_02_00_exact_thm
  ---END ashrsgt_02_00_exact



def ashrsgt_02_01_exact_before := [llvm|
{
^0(%arg84 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.ashr exact %arg84, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_01_exact_after := [llvm|
{
^0(%arg84 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_01_exact_proof : ashrsgt_02_01_exact_before ⊑ ashrsgt_02_01_exact_after := by
  unfold ashrsgt_02_01_exact_before ashrsgt_02_01_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_01_exact
  apply ashrsgt_02_01_exact_thm
  ---END ashrsgt_02_01_exact



def ashrsgt_02_02_exact_before := [llvm|
{
^0(%arg83 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.ashr exact %arg83, %0 : i4
  %2 = llvm.icmp "sgt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashrsgt_02_02_exact_after := [llvm|
{
^0(%arg83 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_02_exact_proof : ashrsgt_02_02_exact_before ⊑ ashrsgt_02_02_exact_after := by
  unfold ashrsgt_02_02_exact_before ashrsgt_02_02_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_02_exact
  apply ashrsgt_02_02_exact_thm
  ---END ashrsgt_02_02_exact



def ashrsgt_02_03_exact_before := [llvm|
{
^0(%arg82 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.ashr exact %arg82, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_03_exact_after := [llvm|
{
^0(%arg82 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_03_exact_proof : ashrsgt_02_03_exact_before ⊑ ashrsgt_02_03_exact_after := by
  unfold ashrsgt_02_03_exact_before ashrsgt_02_03_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_03_exact
  apply ashrsgt_02_03_exact_thm
  ---END ashrsgt_02_03_exact



def ashrsgt_02_04_exact_before := [llvm|
{
^0(%arg81 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.ashr exact %arg81, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_04_exact_after := [llvm|
{
^0(%arg81 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_04_exact_proof : ashrsgt_02_04_exact_before ⊑ ashrsgt_02_04_exact_after := by
  unfold ashrsgt_02_04_exact_before ashrsgt_02_04_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_04_exact
  apply ashrsgt_02_04_exact_thm
  ---END ashrsgt_02_04_exact



def ashrsgt_02_05_exact_before := [llvm|
{
^0(%arg80 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.ashr exact %arg80, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_05_exact_after := [llvm|
{
^0(%arg80 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_05_exact_proof : ashrsgt_02_05_exact_before ⊑ ashrsgt_02_05_exact_after := by
  unfold ashrsgt_02_05_exact_before ashrsgt_02_05_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_05_exact
  apply ashrsgt_02_05_exact_thm
  ---END ashrsgt_02_05_exact



def ashrsgt_02_06_exact_before := [llvm|
{
^0(%arg79 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.ashr exact %arg79, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_06_exact_after := [llvm|
{
^0(%arg79 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_06_exact_proof : ashrsgt_02_06_exact_before ⊑ ashrsgt_02_06_exact_after := by
  unfold ashrsgt_02_06_exact_before ashrsgt_02_06_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_06_exact
  apply ashrsgt_02_06_exact_thm
  ---END ashrsgt_02_06_exact



def ashrsgt_02_07_exact_before := [llvm|
{
^0(%arg78 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.ashr exact %arg78, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_07_exact_after := [llvm|
{
^0(%arg78 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_07_exact_proof : ashrsgt_02_07_exact_before ⊑ ashrsgt_02_07_exact_after := by
  unfold ashrsgt_02_07_exact_before ashrsgt_02_07_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_07_exact
  apply ashrsgt_02_07_exact_thm
  ---END ashrsgt_02_07_exact



def ashrsgt_02_08_exact_before := [llvm|
{
^0(%arg77 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.ashr exact %arg77, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_08_exact_after := [llvm|
{
^0(%arg77 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_08_exact_proof : ashrsgt_02_08_exact_before ⊑ ashrsgt_02_08_exact_after := by
  unfold ashrsgt_02_08_exact_before ashrsgt_02_08_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_08_exact
  apply ashrsgt_02_08_exact_thm
  ---END ashrsgt_02_08_exact



def ashrsgt_02_09_exact_before := [llvm|
{
^0(%arg76 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.ashr exact %arg76, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_09_exact_after := [llvm|
{
^0(%arg76 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_09_exact_proof : ashrsgt_02_09_exact_before ⊑ ashrsgt_02_09_exact_after := by
  unfold ashrsgt_02_09_exact_before ashrsgt_02_09_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_09_exact
  apply ashrsgt_02_09_exact_thm
  ---END ashrsgt_02_09_exact



def ashrsgt_02_10_exact_before := [llvm|
{
^0(%arg75 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.ashr exact %arg75, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_10_exact_after := [llvm|
{
^0(%arg75 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_10_exact_proof : ashrsgt_02_10_exact_before ⊑ ashrsgt_02_10_exact_after := by
  unfold ashrsgt_02_10_exact_before ashrsgt_02_10_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_10_exact
  apply ashrsgt_02_10_exact_thm
  ---END ashrsgt_02_10_exact



def ashrsgt_02_11_exact_before := [llvm|
{
^0(%arg74 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.ashr exact %arg74, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_11_exact_after := [llvm|
{
^0(%arg74 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_11_exact_proof : ashrsgt_02_11_exact_before ⊑ ashrsgt_02_11_exact_after := by
  unfold ashrsgt_02_11_exact_before ashrsgt_02_11_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_11_exact
  apply ashrsgt_02_11_exact_thm
  ---END ashrsgt_02_11_exact



def ashrsgt_02_12_exact_before := [llvm|
{
^0(%arg73 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.ashr exact %arg73, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_12_exact_after := [llvm|
{
^0(%arg73 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_12_exact_proof : ashrsgt_02_12_exact_before ⊑ ashrsgt_02_12_exact_after := by
  unfold ashrsgt_02_12_exact_before ashrsgt_02_12_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_12_exact
  apply ashrsgt_02_12_exact_thm
  ---END ashrsgt_02_12_exact



def ashrsgt_02_13_exact_before := [llvm|
{
^0(%arg72 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.ashr exact %arg72, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_13_exact_after := [llvm|
{
^0(%arg72 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_13_exact_proof : ashrsgt_02_13_exact_before ⊑ ashrsgt_02_13_exact_after := by
  unfold ashrsgt_02_13_exact_before ashrsgt_02_13_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_13_exact
  apply ashrsgt_02_13_exact_thm
  ---END ashrsgt_02_13_exact



def ashrsgt_02_14_exact_before := [llvm|
{
^0(%arg71 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.ashr exact %arg71, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_14_exact_after := [llvm|
{
^0(%arg71 : i4):
  %0 = llvm.mlir.constant(-8 : i4) : i4
  %1 = llvm.icmp "ne" %arg71, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_14_exact_proof : ashrsgt_02_14_exact_before ⊑ ashrsgt_02_14_exact_after := by
  unfold ashrsgt_02_14_exact_before ashrsgt_02_14_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_14_exact
  apply ashrsgt_02_14_exact_thm
  ---END ashrsgt_02_14_exact



def ashrsgt_02_15_exact_before := [llvm|
{
^0(%arg70 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.ashr exact %arg70, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_02_15_exact_after := [llvm|
{
^0(%arg70 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg70, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_02_15_exact_proof : ashrsgt_02_15_exact_before ⊑ ashrsgt_02_15_exact_after := by
  unfold ashrsgt_02_15_exact_before ashrsgt_02_15_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_02_15_exact
  apply ashrsgt_02_15_exact_thm
  ---END ashrsgt_02_15_exact



def ashrsgt_03_00_exact_before := [llvm|
{
^0(%arg69 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.ashr exact %arg69, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_00_exact_after := [llvm|
{
^0(%arg69 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_00_exact_proof : ashrsgt_03_00_exact_before ⊑ ashrsgt_03_00_exact_after := by
  unfold ashrsgt_03_00_exact_before ashrsgt_03_00_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_00_exact
  apply ashrsgt_03_00_exact_thm
  ---END ashrsgt_03_00_exact



def ashrsgt_03_01_exact_before := [llvm|
{
^0(%arg68 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.ashr exact %arg68, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_01_exact_after := [llvm|
{
^0(%arg68 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_01_exact_proof : ashrsgt_03_01_exact_before ⊑ ashrsgt_03_01_exact_after := by
  unfold ashrsgt_03_01_exact_before ashrsgt_03_01_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_01_exact
  apply ashrsgt_03_01_exact_thm
  ---END ashrsgt_03_01_exact



def ashrsgt_03_02_exact_before := [llvm|
{
^0(%arg67 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.ashr exact %arg67, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_02_exact_after := [llvm|
{
^0(%arg67 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_02_exact_proof : ashrsgt_03_02_exact_before ⊑ ashrsgt_03_02_exact_after := by
  unfold ashrsgt_03_02_exact_before ashrsgt_03_02_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_02_exact
  apply ashrsgt_03_02_exact_thm
  ---END ashrsgt_03_02_exact



def ashrsgt_03_03_exact_before := [llvm|
{
^0(%arg66 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.ashr exact %arg66, %0 : i4
  %2 = llvm.icmp "sgt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashrsgt_03_03_exact_after := [llvm|
{
^0(%arg66 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_03_exact_proof : ashrsgt_03_03_exact_before ⊑ ashrsgt_03_03_exact_after := by
  unfold ashrsgt_03_03_exact_before ashrsgt_03_03_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_03_exact
  apply ashrsgt_03_03_exact_thm
  ---END ashrsgt_03_03_exact



def ashrsgt_03_04_exact_before := [llvm|
{
^0(%arg65 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.ashr exact %arg65, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_04_exact_after := [llvm|
{
^0(%arg65 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_04_exact_proof : ashrsgt_03_04_exact_before ⊑ ashrsgt_03_04_exact_after := by
  unfold ashrsgt_03_04_exact_before ashrsgt_03_04_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_04_exact
  apply ashrsgt_03_04_exact_thm
  ---END ashrsgt_03_04_exact



def ashrsgt_03_05_exact_before := [llvm|
{
^0(%arg64 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.ashr exact %arg64, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_05_exact_after := [llvm|
{
^0(%arg64 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_05_exact_proof : ashrsgt_03_05_exact_before ⊑ ashrsgt_03_05_exact_after := by
  unfold ashrsgt_03_05_exact_before ashrsgt_03_05_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_05_exact
  apply ashrsgt_03_05_exact_thm
  ---END ashrsgt_03_05_exact



def ashrsgt_03_06_exact_before := [llvm|
{
^0(%arg63 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.ashr exact %arg63, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_06_exact_after := [llvm|
{
^0(%arg63 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_06_exact_proof : ashrsgt_03_06_exact_before ⊑ ashrsgt_03_06_exact_after := by
  unfold ashrsgt_03_06_exact_before ashrsgt_03_06_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_06_exact
  apply ashrsgt_03_06_exact_thm
  ---END ashrsgt_03_06_exact



def ashrsgt_03_07_exact_before := [llvm|
{
^0(%arg62 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.ashr exact %arg62, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_07_exact_after := [llvm|
{
^0(%arg62 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_07_exact_proof : ashrsgt_03_07_exact_before ⊑ ashrsgt_03_07_exact_after := by
  unfold ashrsgt_03_07_exact_before ashrsgt_03_07_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_07_exact
  apply ashrsgt_03_07_exact_thm
  ---END ashrsgt_03_07_exact



def ashrsgt_03_08_exact_before := [llvm|
{
^0(%arg61 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.ashr exact %arg61, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_08_exact_after := [llvm|
{
^0(%arg61 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_08_exact_proof : ashrsgt_03_08_exact_before ⊑ ashrsgt_03_08_exact_after := by
  unfold ashrsgt_03_08_exact_before ashrsgt_03_08_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_08_exact
  apply ashrsgt_03_08_exact_thm
  ---END ashrsgt_03_08_exact



def ashrsgt_03_09_exact_before := [llvm|
{
^0(%arg60 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.ashr exact %arg60, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_09_exact_after := [llvm|
{
^0(%arg60 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_09_exact_proof : ashrsgt_03_09_exact_before ⊑ ashrsgt_03_09_exact_after := by
  unfold ashrsgt_03_09_exact_before ashrsgt_03_09_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_09_exact
  apply ashrsgt_03_09_exact_thm
  ---END ashrsgt_03_09_exact



def ashrsgt_03_10_exact_before := [llvm|
{
^0(%arg59 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.ashr exact %arg59, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_10_exact_after := [llvm|
{
^0(%arg59 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_10_exact_proof : ashrsgt_03_10_exact_before ⊑ ashrsgt_03_10_exact_after := by
  unfold ashrsgt_03_10_exact_before ashrsgt_03_10_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_10_exact
  apply ashrsgt_03_10_exact_thm
  ---END ashrsgt_03_10_exact



def ashrsgt_03_11_exact_before := [llvm|
{
^0(%arg58 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.ashr exact %arg58, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_11_exact_after := [llvm|
{
^0(%arg58 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_11_exact_proof : ashrsgt_03_11_exact_before ⊑ ashrsgt_03_11_exact_after := by
  unfold ashrsgt_03_11_exact_before ashrsgt_03_11_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_11_exact
  apply ashrsgt_03_11_exact_thm
  ---END ashrsgt_03_11_exact



def ashrsgt_03_12_exact_before := [llvm|
{
^0(%arg57 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.ashr exact %arg57, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_12_exact_after := [llvm|
{
^0(%arg57 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_12_exact_proof : ashrsgt_03_12_exact_before ⊑ ashrsgt_03_12_exact_after := by
  unfold ashrsgt_03_12_exact_before ashrsgt_03_12_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_12_exact
  apply ashrsgt_03_12_exact_thm
  ---END ashrsgt_03_12_exact



def ashrsgt_03_13_exact_before := [llvm|
{
^0(%arg56 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.ashr exact %arg56, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_13_exact_after := [llvm|
{
^0(%arg56 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_13_exact_proof : ashrsgt_03_13_exact_before ⊑ ashrsgt_03_13_exact_after := by
  unfold ashrsgt_03_13_exact_before ashrsgt_03_13_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_13_exact
  apply ashrsgt_03_13_exact_thm
  ---END ashrsgt_03_13_exact



def ashrsgt_03_14_exact_before := [llvm|
{
^0(%arg55 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.ashr exact %arg55, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_14_exact_after := [llvm|
{
^0(%arg55 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_14_exact_proof : ashrsgt_03_14_exact_before ⊑ ashrsgt_03_14_exact_after := by
  unfold ashrsgt_03_14_exact_before ashrsgt_03_14_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_14_exact
  apply ashrsgt_03_14_exact_thm
  ---END ashrsgt_03_14_exact



def ashrsgt_03_15_exact_before := [llvm|
{
^0(%arg54 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.ashr exact %arg54, %0 : i4
  %3 = llvm.icmp "sgt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrsgt_03_15_exact_after := [llvm|
{
^0(%arg54 : i4):
  %0 = llvm.mlir.constant(-1 : i4) : i4
  %1 = llvm.icmp "sgt" %arg54, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrsgt_03_15_exact_proof : ashrsgt_03_15_exact_before ⊑ ashrsgt_03_15_exact_after := by
  unfold ashrsgt_03_15_exact_before ashrsgt_03_15_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrsgt_03_15_exact
  apply ashrsgt_03_15_exact_thm
  ---END ashrsgt_03_15_exact



def ashrslt_01_00_exact_before := [llvm|
{
^0(%arg53 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.ashr exact %arg53, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_00_exact_after := [llvm|
{
^0(%arg53 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg53, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_00_exact_proof : ashrslt_01_00_exact_before ⊑ ashrslt_01_00_exact_after := by
  unfold ashrslt_01_00_exact_before ashrslt_01_00_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_00_exact
  apply ashrslt_01_00_exact_thm
  ---END ashrslt_01_00_exact



def ashrslt_01_01_exact_before := [llvm|
{
^0(%arg52 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.ashr exact %arg52, %0 : i4
  %2 = llvm.icmp "slt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashrslt_01_01_exact_after := [llvm|
{
^0(%arg52 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.icmp "slt" %arg52, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_01_exact_proof : ashrslt_01_01_exact_before ⊑ ashrslt_01_01_exact_after := by
  unfold ashrslt_01_01_exact_before ashrslt_01_01_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_01_exact
  apply ashrslt_01_01_exact_thm
  ---END ashrslt_01_01_exact



def ashrslt_01_02_exact_before := [llvm|
{
^0(%arg51 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.ashr exact %arg51, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_02_exact_after := [llvm|
{
^0(%arg51 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.icmp "slt" %arg51, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_02_exact_proof : ashrslt_01_02_exact_before ⊑ ashrslt_01_02_exact_after := by
  unfold ashrslt_01_02_exact_before ashrslt_01_02_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_02_exact
  apply ashrslt_01_02_exact_thm
  ---END ashrslt_01_02_exact



def ashrslt_01_03_exact_before := [llvm|
{
^0(%arg50 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.ashr exact %arg50, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_03_exact_after := [llvm|
{
^0(%arg50 : i4):
  %0 = llvm.mlir.constant(5 : i4) : i4
  %1 = llvm.icmp "slt" %arg50, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_03_exact_proof : ashrslt_01_03_exact_before ⊑ ashrslt_01_03_exact_after := by
  unfold ashrslt_01_03_exact_before ashrslt_01_03_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_03_exact
  apply ashrslt_01_03_exact_thm
  ---END ashrslt_01_03_exact



def ashrslt_01_04_exact_before := [llvm|
{
^0(%arg49 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.ashr exact %arg49, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_04_exact_after := [llvm|
{
^0(%arg49 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_04_exact_proof : ashrslt_01_04_exact_before ⊑ ashrslt_01_04_exact_after := by
  unfold ashrslt_01_04_exact_before ashrslt_01_04_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_04_exact
  apply ashrslt_01_04_exact_thm
  ---END ashrslt_01_04_exact



def ashrslt_01_05_exact_before := [llvm|
{
^0(%arg48 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.ashr exact %arg48, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_05_exact_after := [llvm|
{
^0(%arg48 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_05_exact_proof : ashrslt_01_05_exact_before ⊑ ashrslt_01_05_exact_after := by
  unfold ashrslt_01_05_exact_before ashrslt_01_05_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_05_exact
  apply ashrslt_01_05_exact_thm
  ---END ashrslt_01_05_exact



def ashrslt_01_06_exact_before := [llvm|
{
^0(%arg47 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.ashr exact %arg47, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_06_exact_after := [llvm|
{
^0(%arg47 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_06_exact_proof : ashrslt_01_06_exact_before ⊑ ashrslt_01_06_exact_after := by
  unfold ashrslt_01_06_exact_before ashrslt_01_06_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_06_exact
  apply ashrslt_01_06_exact_thm
  ---END ashrslt_01_06_exact



def ashrslt_01_07_exact_before := [llvm|
{
^0(%arg46 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.ashr exact %arg46, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_07_exact_after := [llvm|
{
^0(%arg46 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_07_exact_proof : ashrslt_01_07_exact_before ⊑ ashrslt_01_07_exact_after := by
  unfold ashrslt_01_07_exact_before ashrslt_01_07_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_07_exact
  apply ashrslt_01_07_exact_thm
  ---END ashrslt_01_07_exact



def ashrslt_01_08_exact_before := [llvm|
{
^0(%arg45 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.ashr exact %arg45, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_08_exact_after := [llvm|
{
^0(%arg45 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_08_exact_proof : ashrslt_01_08_exact_before ⊑ ashrslt_01_08_exact_after := by
  unfold ashrslt_01_08_exact_before ashrslt_01_08_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_08_exact
  apply ashrslt_01_08_exact_thm
  ---END ashrslt_01_08_exact



def ashrslt_01_09_exact_before := [llvm|
{
^0(%arg44 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.ashr exact %arg44, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_09_exact_after := [llvm|
{
^0(%arg44 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_09_exact_proof : ashrslt_01_09_exact_before ⊑ ashrslt_01_09_exact_after := by
  unfold ashrslt_01_09_exact_before ashrslt_01_09_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_09_exact
  apply ashrslt_01_09_exact_thm
  ---END ashrslt_01_09_exact



def ashrslt_01_10_exact_before := [llvm|
{
^0(%arg43 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.ashr exact %arg43, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_10_exact_after := [llvm|
{
^0(%arg43 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_10_exact_proof : ashrslt_01_10_exact_before ⊑ ashrslt_01_10_exact_after := by
  unfold ashrslt_01_10_exact_before ashrslt_01_10_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_10_exact
  apply ashrslt_01_10_exact_thm
  ---END ashrslt_01_10_exact



def ashrslt_01_11_exact_before := [llvm|
{
^0(%arg42 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.ashr exact %arg42, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_11_exact_after := [llvm|
{
^0(%arg42 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_11_exact_proof : ashrslt_01_11_exact_before ⊑ ashrslt_01_11_exact_after := by
  unfold ashrslt_01_11_exact_before ashrslt_01_11_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_11_exact
  apply ashrslt_01_11_exact_thm
  ---END ashrslt_01_11_exact



def ashrslt_01_12_exact_before := [llvm|
{
^0(%arg41 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.ashr exact %arg41, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_12_exact_after := [llvm|
{
^0(%arg41 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_12_exact_proof : ashrslt_01_12_exact_before ⊑ ashrslt_01_12_exact_after := by
  unfold ashrslt_01_12_exact_before ashrslt_01_12_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_12_exact
  apply ashrslt_01_12_exact_thm
  ---END ashrslt_01_12_exact



def ashrslt_01_13_exact_before := [llvm|
{
^0(%arg40 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.ashr exact %arg40, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_13_exact_after := [llvm|
{
^0(%arg40 : i4):
  %0 = llvm.mlir.constant(-6 : i4) : i4
  %1 = llvm.icmp "slt" %arg40, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_13_exact_proof : ashrslt_01_13_exact_before ⊑ ashrslt_01_13_exact_after := by
  unfold ashrslt_01_13_exact_before ashrslt_01_13_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_13_exact
  apply ashrslt_01_13_exact_thm
  ---END ashrslt_01_13_exact



def ashrslt_01_14_exact_before := [llvm|
{
^0(%arg39 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.ashr exact %arg39, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_14_exact_after := [llvm|
{
^0(%arg39 : i4):
  %0 = llvm.mlir.constant(-4 : i4) : i4
  %1 = llvm.icmp "slt" %arg39, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_14_exact_proof : ashrslt_01_14_exact_before ⊑ ashrslt_01_14_exact_after := by
  unfold ashrslt_01_14_exact_before ashrslt_01_14_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_14_exact
  apply ashrslt_01_14_exact_thm
  ---END ashrslt_01_14_exact



def ashrslt_01_15_exact_before := [llvm|
{
^0(%arg38 : i4):
  %0 = llvm.mlir.constant(1 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.ashr exact %arg38, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_01_15_exact_after := [llvm|
{
^0(%arg38 : i4):
  %0 = llvm.mlir.constant(-2 : i4) : i4
  %1 = llvm.icmp "slt" %arg38, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_01_15_exact_proof : ashrslt_01_15_exact_before ⊑ ashrslt_01_15_exact_after := by
  unfold ashrslt_01_15_exact_before ashrslt_01_15_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_01_15_exact
  apply ashrslt_01_15_exact_thm
  ---END ashrslt_01_15_exact



def ashrslt_02_00_exact_before := [llvm|
{
^0(%arg37 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.ashr exact %arg37, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_00_exact_after := [llvm|
{
^0(%arg37 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg37, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_00_exact_proof : ashrslt_02_00_exact_before ⊑ ashrslt_02_00_exact_after := by
  unfold ashrslt_02_00_exact_before ashrslt_02_00_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_00_exact
  apply ashrslt_02_00_exact_thm
  ---END ashrslt_02_00_exact



def ashrslt_02_01_exact_before := [llvm|
{
^0(%arg36 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.ashr exact %arg36, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_01_exact_after := [llvm|
{
^0(%arg36 : i4):
  %0 = llvm.mlir.constant(4 : i4) : i4
  %1 = llvm.icmp "slt" %arg36, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_01_exact_proof : ashrslt_02_01_exact_before ⊑ ashrslt_02_01_exact_after := by
  unfold ashrslt_02_01_exact_before ashrslt_02_01_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_01_exact
  apply ashrslt_02_01_exact_thm
  ---END ashrslt_02_01_exact



def ashrslt_02_02_exact_before := [llvm|
{
^0(%arg35 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.ashr exact %arg35, %0 : i4
  %2 = llvm.icmp "slt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashrslt_02_02_exact_after := [llvm|
{
^0(%arg35 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_02_exact_proof : ashrslt_02_02_exact_before ⊑ ashrslt_02_02_exact_after := by
  unfold ashrslt_02_02_exact_before ashrslt_02_02_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_02_exact
  apply ashrslt_02_02_exact_thm
  ---END ashrslt_02_02_exact



def ashrslt_02_03_exact_before := [llvm|
{
^0(%arg34 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(3 : i4) : i4
  %2 = llvm.ashr exact %arg34, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_03_exact_after := [llvm|
{
^0(%arg34 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_03_exact_proof : ashrslt_02_03_exact_before ⊑ ashrslt_02_03_exact_after := by
  unfold ashrslt_02_03_exact_before ashrslt_02_03_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_03_exact
  apply ashrslt_02_03_exact_thm
  ---END ashrslt_02_03_exact



def ashrslt_02_04_exact_before := [llvm|
{
^0(%arg33 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.ashr exact %arg33, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_04_exact_after := [llvm|
{
^0(%arg33 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_04_exact_proof : ashrslt_02_04_exact_before ⊑ ashrslt_02_04_exact_after := by
  unfold ashrslt_02_04_exact_before ashrslt_02_04_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_04_exact
  apply ashrslt_02_04_exact_thm
  ---END ashrslt_02_04_exact



def ashrslt_02_05_exact_before := [llvm|
{
^0(%arg32 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.ashr exact %arg32, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_05_exact_after := [llvm|
{
^0(%arg32 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_05_exact_proof : ashrslt_02_05_exact_before ⊑ ashrslt_02_05_exact_after := by
  unfold ashrslt_02_05_exact_before ashrslt_02_05_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_05_exact
  apply ashrslt_02_05_exact_thm
  ---END ashrslt_02_05_exact



def ashrslt_02_06_exact_before := [llvm|
{
^0(%arg31 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.ashr exact %arg31, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_06_exact_after := [llvm|
{
^0(%arg31 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_06_exact_proof : ashrslt_02_06_exact_before ⊑ ashrslt_02_06_exact_after := by
  unfold ashrslt_02_06_exact_before ashrslt_02_06_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_06_exact
  apply ashrslt_02_06_exact_thm
  ---END ashrslt_02_06_exact



def ashrslt_02_07_exact_before := [llvm|
{
^0(%arg30 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.ashr exact %arg30, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_07_exact_after := [llvm|
{
^0(%arg30 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_07_exact_proof : ashrslt_02_07_exact_before ⊑ ashrslt_02_07_exact_after := by
  unfold ashrslt_02_07_exact_before ashrslt_02_07_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_07_exact
  apply ashrslt_02_07_exact_thm
  ---END ashrslt_02_07_exact



def ashrslt_02_08_exact_before := [llvm|
{
^0(%arg29 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.ashr exact %arg29, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_08_exact_after := [llvm|
{
^0(%arg29 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_08_exact_proof : ashrslt_02_08_exact_before ⊑ ashrslt_02_08_exact_after := by
  unfold ashrslt_02_08_exact_before ashrslt_02_08_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_08_exact
  apply ashrslt_02_08_exact_thm
  ---END ashrslt_02_08_exact



def ashrslt_02_09_exact_before := [llvm|
{
^0(%arg28 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.ashr exact %arg28, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_09_exact_after := [llvm|
{
^0(%arg28 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_09_exact_proof : ashrslt_02_09_exact_before ⊑ ashrslt_02_09_exact_after := by
  unfold ashrslt_02_09_exact_before ashrslt_02_09_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_09_exact
  apply ashrslt_02_09_exact_thm
  ---END ashrslt_02_09_exact



def ashrslt_02_10_exact_before := [llvm|
{
^0(%arg27 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.ashr exact %arg27, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_10_exact_after := [llvm|
{
^0(%arg27 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_10_exact_proof : ashrslt_02_10_exact_before ⊑ ashrslt_02_10_exact_after := by
  unfold ashrslt_02_10_exact_before ashrslt_02_10_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_10_exact
  apply ashrslt_02_10_exact_thm
  ---END ashrslt_02_10_exact



def ashrslt_02_11_exact_before := [llvm|
{
^0(%arg26 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.ashr exact %arg26, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_11_exact_after := [llvm|
{
^0(%arg26 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_11_exact_proof : ashrslt_02_11_exact_before ⊑ ashrslt_02_11_exact_after := by
  unfold ashrslt_02_11_exact_before ashrslt_02_11_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_11_exact
  apply ashrslt_02_11_exact_thm
  ---END ashrslt_02_11_exact



def ashrslt_02_12_exact_before := [llvm|
{
^0(%arg25 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.ashr exact %arg25, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_12_exact_after := [llvm|
{
^0(%arg25 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_12_exact_proof : ashrslt_02_12_exact_before ⊑ ashrslt_02_12_exact_after := by
  unfold ashrslt_02_12_exact_before ashrslt_02_12_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_12_exact
  apply ashrslt_02_12_exact_thm
  ---END ashrslt_02_12_exact



def ashrslt_02_13_exact_before := [llvm|
{
^0(%arg24 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.ashr exact %arg24, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_13_exact_after := [llvm|
{
^0(%arg24 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_13_exact_proof : ashrslt_02_13_exact_before ⊑ ashrslt_02_13_exact_after := by
  unfold ashrslt_02_13_exact_before ashrslt_02_13_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_13_exact
  apply ashrslt_02_13_exact_thm
  ---END ashrslt_02_13_exact



def ashrslt_02_14_exact_before := [llvm|
{
^0(%arg23 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.ashr exact %arg23, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_14_exact_after := [llvm|
{
^0(%arg23 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_14_exact_proof : ashrslt_02_14_exact_before ⊑ ashrslt_02_14_exact_after := by
  unfold ashrslt_02_14_exact_before ashrslt_02_14_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_14_exact
  apply ashrslt_02_14_exact_thm
  ---END ashrslt_02_14_exact



def ashrslt_02_15_exact_before := [llvm|
{
^0(%arg22 : i4):
  %0 = llvm.mlir.constant(2 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.ashr exact %arg22, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_02_15_exact_after := [llvm|
{
^0(%arg22 : i4):
  %0 = llvm.mlir.constant(-4 : i4) : i4
  %1 = llvm.icmp "slt" %arg22, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_02_15_exact_proof : ashrslt_02_15_exact_before ⊑ ashrslt_02_15_exact_after := by
  unfold ashrslt_02_15_exact_before ashrslt_02_15_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_02_15_exact
  apply ashrslt_02_15_exact_thm
  ---END ashrslt_02_15_exact



def ashrslt_03_00_exact_before := [llvm|
{
^0(%arg21 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(0 : i4) : i4
  %2 = llvm.ashr exact %arg21, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_00_exact_after := [llvm|
{
^0(%arg21 : i4):
  %0 = llvm.mlir.constant(0 : i4) : i4
  %1 = llvm.icmp "slt" %arg21, %0 : i4
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_00_exact_proof : ashrslt_03_00_exact_before ⊑ ashrslt_03_00_exact_after := by
  unfold ashrslt_03_00_exact_before ashrslt_03_00_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_00_exact
  apply ashrslt_03_00_exact_thm
  ---END ashrslt_03_00_exact



def ashrslt_03_01_exact_before := [llvm|
{
^0(%arg20 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(1 : i4) : i4
  %2 = llvm.ashr exact %arg20, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_01_exact_after := [llvm|
{
^0(%arg20 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_01_exact_proof : ashrslt_03_01_exact_before ⊑ ashrslt_03_01_exact_after := by
  unfold ashrslt_03_01_exact_before ashrslt_03_01_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_01_exact
  apply ashrslt_03_01_exact_thm
  ---END ashrslt_03_01_exact



def ashrslt_03_02_exact_before := [llvm|
{
^0(%arg19 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(2 : i4) : i4
  %2 = llvm.ashr exact %arg19, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_02_exact_after := [llvm|
{
^0(%arg19 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_02_exact_proof : ashrslt_03_02_exact_before ⊑ ashrslt_03_02_exact_after := by
  unfold ashrslt_03_02_exact_before ashrslt_03_02_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_02_exact
  apply ashrslt_03_02_exact_thm
  ---END ashrslt_03_02_exact



def ashrslt_03_03_exact_before := [llvm|
{
^0(%arg18 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.ashr exact %arg18, %0 : i4
  %2 = llvm.icmp "slt" %1, %0 : i4
  "llvm.return"(%2) : (i1) -> ()
}
]
def ashrslt_03_03_exact_after := [llvm|
{
^0(%arg18 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_03_exact_proof : ashrslt_03_03_exact_before ⊑ ashrslt_03_03_exact_after := by
  unfold ashrslt_03_03_exact_before ashrslt_03_03_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_03_exact
  apply ashrslt_03_03_exact_thm
  ---END ashrslt_03_03_exact



def ashrslt_03_04_exact_before := [llvm|
{
^0(%arg17 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(4 : i4) : i4
  %2 = llvm.ashr exact %arg17, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_04_exact_after := [llvm|
{
^0(%arg17 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_04_exact_proof : ashrslt_03_04_exact_before ⊑ ashrslt_03_04_exact_after := by
  unfold ashrslt_03_04_exact_before ashrslt_03_04_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_04_exact
  apply ashrslt_03_04_exact_thm
  ---END ashrslt_03_04_exact



def ashrslt_03_05_exact_before := [llvm|
{
^0(%arg16 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(5 : i4) : i4
  %2 = llvm.ashr exact %arg16, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_05_exact_after := [llvm|
{
^0(%arg16 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_05_exact_proof : ashrslt_03_05_exact_before ⊑ ashrslt_03_05_exact_after := by
  unfold ashrslt_03_05_exact_before ashrslt_03_05_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_05_exact
  apply ashrslt_03_05_exact_thm
  ---END ashrslt_03_05_exact



def ashrslt_03_06_exact_before := [llvm|
{
^0(%arg15 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(6 : i4) : i4
  %2 = llvm.ashr exact %arg15, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_06_exact_after := [llvm|
{
^0(%arg15 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_06_exact_proof : ashrslt_03_06_exact_before ⊑ ashrslt_03_06_exact_after := by
  unfold ashrslt_03_06_exact_before ashrslt_03_06_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_06_exact
  apply ashrslt_03_06_exact_thm
  ---END ashrslt_03_06_exact



def ashrslt_03_07_exact_before := [llvm|
{
^0(%arg14 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(7 : i4) : i4
  %2 = llvm.ashr exact %arg14, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_07_exact_after := [llvm|
{
^0(%arg14 : i4):
  %0 = llvm.mlir.constant(true) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_07_exact_proof : ashrslt_03_07_exact_before ⊑ ashrslt_03_07_exact_after := by
  unfold ashrslt_03_07_exact_before ashrslt_03_07_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_07_exact
  apply ashrslt_03_07_exact_thm
  ---END ashrslt_03_07_exact



def ashrslt_03_08_exact_before := [llvm|
{
^0(%arg13 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-8 : i4) : i4
  %2 = llvm.ashr exact %arg13, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_08_exact_after := [llvm|
{
^0(%arg13 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_08_exact_proof : ashrslt_03_08_exact_before ⊑ ashrslt_03_08_exact_after := by
  unfold ashrslt_03_08_exact_before ashrslt_03_08_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_08_exact
  apply ashrslt_03_08_exact_thm
  ---END ashrslt_03_08_exact



def ashrslt_03_09_exact_before := [llvm|
{
^0(%arg12 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-7 : i4) : i4
  %2 = llvm.ashr exact %arg12, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_09_exact_after := [llvm|
{
^0(%arg12 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_09_exact_proof : ashrslt_03_09_exact_before ⊑ ashrslt_03_09_exact_after := by
  unfold ashrslt_03_09_exact_before ashrslt_03_09_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_09_exact
  apply ashrslt_03_09_exact_thm
  ---END ashrslt_03_09_exact



def ashrslt_03_10_exact_before := [llvm|
{
^0(%arg11 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-6 : i4) : i4
  %2 = llvm.ashr exact %arg11, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_10_exact_after := [llvm|
{
^0(%arg11 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_10_exact_proof : ashrslt_03_10_exact_before ⊑ ashrslt_03_10_exact_after := by
  unfold ashrslt_03_10_exact_before ashrslt_03_10_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_10_exact
  apply ashrslt_03_10_exact_thm
  ---END ashrslt_03_10_exact



def ashrslt_03_11_exact_before := [llvm|
{
^0(%arg10 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-5 : i4) : i4
  %2 = llvm.ashr exact %arg10, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_11_exact_after := [llvm|
{
^0(%arg10 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_11_exact_proof : ashrslt_03_11_exact_before ⊑ ashrslt_03_11_exact_after := by
  unfold ashrslt_03_11_exact_before ashrslt_03_11_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_11_exact
  apply ashrslt_03_11_exact_thm
  ---END ashrslt_03_11_exact



def ashrslt_03_12_exact_before := [llvm|
{
^0(%arg9 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-4 : i4) : i4
  %2 = llvm.ashr exact %arg9, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_12_exact_after := [llvm|
{
^0(%arg9 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_12_exact_proof : ashrslt_03_12_exact_before ⊑ ashrslt_03_12_exact_after := by
  unfold ashrslt_03_12_exact_before ashrslt_03_12_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_12_exact
  apply ashrslt_03_12_exact_thm
  ---END ashrslt_03_12_exact



def ashrslt_03_13_exact_before := [llvm|
{
^0(%arg8 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-3 : i4) : i4
  %2 = llvm.ashr exact %arg8, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_13_exact_after := [llvm|
{
^0(%arg8 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_13_exact_proof : ashrslt_03_13_exact_before ⊑ ashrslt_03_13_exact_after := by
  unfold ashrslt_03_13_exact_before ashrslt_03_13_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_13_exact
  apply ashrslt_03_13_exact_thm
  ---END ashrslt_03_13_exact



def ashrslt_03_14_exact_before := [llvm|
{
^0(%arg7 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-2 : i4) : i4
  %2 = llvm.ashr exact %arg7, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_14_exact_after := [llvm|
{
^0(%arg7 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_14_exact_proof : ashrslt_03_14_exact_before ⊑ ashrslt_03_14_exact_after := by
  unfold ashrslt_03_14_exact_before ashrslt_03_14_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_14_exact
  apply ashrslt_03_14_exact_thm
  ---END ashrslt_03_14_exact



def ashrslt_03_15_exact_before := [llvm|
{
^0(%arg6 : i4):
  %0 = llvm.mlir.constant(3 : i4) : i4
  %1 = llvm.mlir.constant(-1 : i4) : i4
  %2 = llvm.ashr exact %arg6, %0 : i4
  %3 = llvm.icmp "slt" %2, %1 : i4
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashrslt_03_15_exact_after := [llvm|
{
^0(%arg6 : i4):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashrslt_03_15_exact_proof : ashrslt_03_15_exact_before ⊑ ashrslt_03_15_exact_after := by
  unfold ashrslt_03_15_exact_before ashrslt_03_15_exact_after
  simp_alive_peephole
  intros
  ---BEGIN ashrslt_03_15_exact
  apply ashrslt_03_15_exact_thm
  ---END ashrslt_03_15_exact



def ashr_slt_exact_near_pow2_cmpval_before := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.ashr exact %arg5, %0 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_slt_exact_near_pow2_cmpval_after := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(9 : i8) : i8
  %1 = llvm.icmp "slt" %arg5, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_slt_exact_near_pow2_cmpval_proof : ashr_slt_exact_near_pow2_cmpval_before ⊑ ashr_slt_exact_near_pow2_cmpval_after := by
  unfold ashr_slt_exact_near_pow2_cmpval_before ashr_slt_exact_near_pow2_cmpval_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_slt_exact_near_pow2_cmpval
  apply ashr_slt_exact_near_pow2_cmpval_thm
  ---END ashr_slt_exact_near_pow2_cmpval



def ashr_ult_exact_near_pow2_cmpval_before := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.ashr exact %arg4, %0 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def ashr_ult_exact_near_pow2_cmpval_after := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(9 : i8) : i8
  %1 = llvm.icmp "ult" %arg4, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ult_exact_near_pow2_cmpval_proof : ashr_ult_exact_near_pow2_cmpval_before ⊑ ashr_ult_exact_near_pow2_cmpval_after := by
  unfold ashr_ult_exact_near_pow2_cmpval_before ashr_ult_exact_near_pow2_cmpval_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ult_exact_near_pow2_cmpval
  apply ashr_ult_exact_near_pow2_cmpval_thm
  ---END ashr_ult_exact_near_pow2_cmpval



def negtest_near_pow2_cmpval_ashr_slt_noexact_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.ashr %arg3, %0 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def negtest_near_pow2_cmpval_ashr_slt_noexact_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.icmp "slt" %arg3, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negtest_near_pow2_cmpval_ashr_slt_noexact_proof : negtest_near_pow2_cmpval_ashr_slt_noexact_before ⊑ negtest_near_pow2_cmpval_ashr_slt_noexact_after := by
  unfold negtest_near_pow2_cmpval_ashr_slt_noexact_before negtest_near_pow2_cmpval_ashr_slt_noexact_after
  simp_alive_peephole
  intros
  ---BEGIN negtest_near_pow2_cmpval_ashr_slt_noexact
  apply negtest_near_pow2_cmpval_ashr_slt_noexact_thm
  ---END negtest_near_pow2_cmpval_ashr_slt_noexact



def negtest_near_pow2_cmpval_ashr_wrong_cmp_pred_before := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.ashr exact %arg2, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def negtest_near_pow2_cmpval_ashr_wrong_cmp_pred_after := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.icmp "eq" %arg2, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negtest_near_pow2_cmpval_ashr_wrong_cmp_pred_proof : negtest_near_pow2_cmpval_ashr_wrong_cmp_pred_before ⊑ negtest_near_pow2_cmpval_ashr_wrong_cmp_pred_after := by
  unfold negtest_near_pow2_cmpval_ashr_wrong_cmp_pred_before negtest_near_pow2_cmpval_ashr_wrong_cmp_pred_after
  simp_alive_peephole
  intros
  ---BEGIN negtest_near_pow2_cmpval_ashr_wrong_cmp_pred
  apply negtest_near_pow2_cmpval_ashr_wrong_cmp_pred_thm
  ---END negtest_near_pow2_cmpval_ashr_wrong_cmp_pred



def negtest_near_pow2_cmpval_isnt_close_to_pow2_before := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.ashr exact %arg1, %0 : i8
  %3 = llvm.icmp "slt" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def negtest_near_pow2_cmpval_isnt_close_to_pow2_after := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(12 : i8) : i8
  %1 = llvm.icmp "slt" %arg1, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negtest_near_pow2_cmpval_isnt_close_to_pow2_proof : negtest_near_pow2_cmpval_isnt_close_to_pow2_before ⊑ negtest_near_pow2_cmpval_isnt_close_to_pow2_after := by
  unfold negtest_near_pow2_cmpval_isnt_close_to_pow2_before negtest_near_pow2_cmpval_isnt_close_to_pow2_after
  simp_alive_peephole
  intros
  ---BEGIN negtest_near_pow2_cmpval_isnt_close_to_pow2
  apply negtest_near_pow2_cmpval_isnt_close_to_pow2_thm
  ---END negtest_near_pow2_cmpval_isnt_close_to_pow2



def negtest_near_pow2_cmpval_would_overflow_into_signbit_before := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.mlir.constant(33 : i8) : i8
  %2 = llvm.ashr exact %arg0, %0 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def negtest_near_pow2_cmpval_would_overflow_into_signbit_after := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "sgt" %arg0, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem negtest_near_pow2_cmpval_would_overflow_into_signbit_proof : negtest_near_pow2_cmpval_would_overflow_into_signbit_before ⊑ negtest_near_pow2_cmpval_would_overflow_into_signbit_after := by
  unfold negtest_near_pow2_cmpval_would_overflow_into_signbit_before negtest_near_pow2_cmpval_would_overflow_into_signbit_after
  simp_alive_peephole
  intros
  ---BEGIN negtest_near_pow2_cmpval_would_overflow_into_signbit
  apply negtest_near_pow2_cmpval_would_overflow_into_signbit_thm
  ---END negtest_near_pow2_cmpval_would_overflow_into_signbit


