import SSA.Projects.InstCombine.tests.proofs.gandhorhicmphconsthicmp_proof
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
section gandhorhicmphconsthicmp_statements

def eq_basic_before := [llvm|
{
^0(%arg34 : i8, %arg35 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg34, %0 : i8
  %2 = llvm.icmp "ugt" %arg34, %arg35 : i8
  %3 = llvm.or %1, %2 : i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def eq_basic_after := [llvm|
{
^0(%arg34 : i8, %arg35 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.add %arg34, %0 : i8
  %2 = llvm.icmp "uge" %1, %arg35 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_basic_proof : eq_basic_before ⊑ eq_basic_after := by
  unfold eq_basic_before eq_basic_after
  simp_alive_peephole
  intros
  ---BEGIN eq_basic
  apply eq_basic_thm
  ---END eq_basic



def ne_basic_equal_5_before := [llvm|
{
^0(%arg32 : i8, %arg33 : i8):
  %0 = llvm.mlir.constant(-5 : i8) : i8
  %1 = llvm.mlir.constant(5 : i8) : i8
  %2 = llvm.add %arg32, %0 : i8
  %3 = llvm.icmp "ne" %arg32, %1 : i8
  %4 = llvm.icmp "ule" %2, %arg33 : i8
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def ne_basic_equal_5_after := [llvm|
{
^0(%arg32 : i8, %arg33 : i8):
  %0 = llvm.mlir.constant(-6 : i8) : i8
  %1 = llvm.add %arg32, %0 : i8
  %2 = llvm.icmp "ult" %1, %arg33 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_basic_equal_5_proof : ne_basic_equal_5_before ⊑ ne_basic_equal_5_after := by
  unfold ne_basic_equal_5_before ne_basic_equal_5_after
  simp_alive_peephole
  intros
  ---BEGIN ne_basic_equal_5
  apply ne_basic_equal_5_thm
  ---END ne_basic_equal_5



def eq_basic_equal_minus_1_before := [llvm|
{
^0(%arg30 : i8, %arg31 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.add %arg30, %0 : i8
  %3 = llvm.icmp "eq" %arg30, %1 : i8
  %4 = llvm.icmp "ugt" %2, %arg31 : i8
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def eq_basic_equal_minus_1_after := [llvm|
{
^0(%arg30 : i8, %arg31 : i8):
  %0 = llvm.icmp "uge" %arg30, %arg31 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_basic_equal_minus_1_proof : eq_basic_equal_minus_1_before ⊑ eq_basic_equal_minus_1_after := by
  unfold eq_basic_equal_minus_1_before eq_basic_equal_minus_1_after
  simp_alive_peephole
  intros
  ---BEGIN eq_basic_equal_minus_1
  apply eq_basic_equal_minus_1_thm
  ---END eq_basic_equal_minus_1



def ne_basic_equal_minus_7_before := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(-7 : i8) : i8
  %2 = llvm.add %arg28, %0 : i8
  %3 = llvm.icmp "ne" %arg28, %1 : i8
  %4 = llvm.icmp "ule" %2, %arg29 : i8
  %5 = llvm.and %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def ne_basic_equal_minus_7_after := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.add %arg28, %0 : i8
  %2 = llvm.icmp "ult" %1, %arg29 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_basic_equal_minus_7_proof : ne_basic_equal_minus_7_before ⊑ ne_basic_equal_minus_7_after := by
  unfold ne_basic_equal_minus_7_before ne_basic_equal_minus_7_after
  simp_alive_peephole
  intros
  ---BEGIN ne_basic_equal_minus_7
  apply ne_basic_equal_minus_7_thm
  ---END ne_basic_equal_minus_7



def eq_commuted_before := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(43 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.sdiv %0, %arg3 : i8
  %3 = llvm.icmp "eq" %arg2, %1 : i8
  %4 = llvm.icmp "ult" %2, %arg2 : i8
  %5 = llvm.or %3, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def eq_commuted_after := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(43 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.sdiv %0, %arg3 : i8
  %3 = llvm.add %arg2, %1 : i8
  %4 = llvm.icmp "uge" %3, %2 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eq_commuted_proof : eq_commuted_before ⊑ eq_commuted_after := by
  unfold eq_commuted_before eq_commuted_after
  simp_alive_peephole
  intros
  ---BEGIN eq_commuted
  apply eq_commuted_thm
  ---END eq_commuted



def ne_commuted_equal_minus_1_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(-1 : i8) : i8
  %3 = llvm.sdiv %0, %arg1 : i8
  %4 = llvm.add %arg0, %1 : i8
  %5 = llvm.icmp "ne" %arg0, %2 : i8
  %6 = llvm.icmp "uge" %3, %4 : i8
  %7 = llvm.and %5, %6 : i1
  "llvm.return"(%7) : (i1) -> ()
}
]
def ne_commuted_equal_minus_1_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.sdiv %0, %arg1 : i8
  %2 = llvm.icmp "ult" %arg0, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ne_commuted_equal_minus_1_proof : ne_commuted_equal_minus_1_before ⊑ ne_commuted_equal_minus_1_after := by
  unfold ne_commuted_equal_minus_1_before ne_commuted_equal_minus_1_after
  simp_alive_peephole
  intros
  ---BEGIN ne_commuted_equal_minus_1
  apply ne_commuted_equal_minus_1_thm
  ---END ne_commuted_equal_minus_1


