import SSA.Projects.InstCombine.tests.proofs.gsdivhicmp_proof
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
section gsdivhicmp_statements

def sdiv_exact_eq_0_before := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sdiv exact %arg16, %arg17 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def sdiv_exact_eq_0_after := [llvm|
{
^0(%arg16 : i8, %arg17 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg16, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_exact_eq_0_proof : sdiv_exact_eq_0_before ⊑ sdiv_exact_eq_0_after := by
  unfold sdiv_exact_eq_0_before sdiv_exact_eq_0_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_exact_eq_0
  apply sdiv_exact_eq_0_thm
  ---END sdiv_exact_eq_0



def udiv_exact_ne_0_before := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.udiv exact %arg14, %arg15 : i8
  %2 = llvm.icmp "ne" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def udiv_exact_ne_0_after := [llvm|
{
^0(%arg14 : i8, %arg15 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg14, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_exact_ne_0_proof : udiv_exact_ne_0_before ⊑ udiv_exact_ne_0_after := by
  unfold udiv_exact_ne_0_before udiv_exact_ne_0_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_exact_ne_0
  apply udiv_exact_ne_0_thm
  ---END udiv_exact_ne_0



def sdiv_exact_ne_1_before := [llvm|
{
^0(%arg12 : i8, %arg13 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sdiv exact %arg12, %arg13 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def sdiv_exact_ne_1_after := [llvm|
{
^0(%arg12 : i8, %arg13 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg12, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_exact_ne_1_proof : sdiv_exact_ne_1_before ⊑ sdiv_exact_ne_1_after := by
  unfold sdiv_exact_ne_1_before sdiv_exact_ne_1_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_exact_ne_1
  apply sdiv_exact_ne_1_thm
  ---END sdiv_exact_ne_1



def udiv_exact_eq_1_before := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.udiv exact %arg10, %arg11 : i8
  %2 = llvm.icmp "ne" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def udiv_exact_eq_1_after := [llvm|
{
^0(%arg10 : i8, %arg11 : i8):
  %0 = llvm.icmp "ne" %arg10, %arg11 : i8
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_exact_eq_1_proof : udiv_exact_eq_1_before ⊑ udiv_exact_eq_1_after := by
  unfold udiv_exact_eq_1_before udiv_exact_eq_1_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_exact_eq_1
  apply udiv_exact_eq_1_thm
  ---END udiv_exact_eq_1



def sdiv_exact_eq_9_no_of_before := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(9 : i8) : i8
  %2 = llvm.and %arg9, %0 : i8
  %3 = llvm.sdiv exact %arg8, %2 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def sdiv_exact_eq_9_no_of_after := [llvm|
{
^0(%arg8 : i8, %arg9 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(9 : i8) : i8
  %2 = llvm.and %arg9, %0 : i8
  %3 = llvm.mul %2, %1 overflow<nsw,nuw> : i8
  %4 = llvm.icmp "eq" %3, %arg8 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv_exact_eq_9_no_of_proof : sdiv_exact_eq_9_no_of_before ⊑ sdiv_exact_eq_9_no_of_after := by
  unfold sdiv_exact_eq_9_no_of_before sdiv_exact_eq_9_no_of_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv_exact_eq_9_no_of
  apply sdiv_exact_eq_9_no_of_thm
  ---END sdiv_exact_eq_9_no_of



def udiv_exact_ne_30_no_of_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(30 : i8) : i8
  %2 = llvm.and %arg1, %0 : i8
  %3 = llvm.udiv exact %arg0, %2 : i8
  %4 = llvm.icmp "ne" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def udiv_exact_ne_30_no_of_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(30 : i8) : i8
  %2 = llvm.and %arg1, %0 : i8
  %3 = llvm.mul %2, %1 overflow<nuw> : i8
  %4 = llvm.icmp "ne" %3, %arg0 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_exact_ne_30_no_of_proof : udiv_exact_ne_30_no_of_before ⊑ udiv_exact_ne_30_no_of_after := by
  unfold udiv_exact_ne_30_no_of_before udiv_exact_ne_30_no_of_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_exact_ne_30_no_of
  apply udiv_exact_ne_30_no_of_thm
  ---END udiv_exact_ne_30_no_of


