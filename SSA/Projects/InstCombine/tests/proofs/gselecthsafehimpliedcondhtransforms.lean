import SSA.Projects.InstCombine.tests.proofs.gselecthsafehimpliedcondhtransforms_proof
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
section gselecthsafehimpliedcondhtransforms_statements

def a_true_implies_b_true_before := [llvm|
{
^0(%arg36 : i8, %arg37 : i1, %arg38 : i1):
  %0 = llvm.mlir.constant(20 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "ugt" %arg36, %0 : i8
  %4 = llvm.icmp "ugt" %arg36, %1 : i8
  %5 = "llvm.select"(%4, %arg37, %arg38) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = "llvm.select"(%3, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def a_true_implies_b_true_after := [llvm|
{
^0(%arg36 : i8, %arg37 : i1, %arg38 : i1):
  %0 = llvm.mlir.constant(20 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ugt" %arg36, %0 : i8
  %3 = "llvm.select"(%2, %arg37, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_true_implies_b_true_proof : a_true_implies_b_true_before ⊑ a_true_implies_b_true_after := by
  unfold a_true_implies_b_true_before a_true_implies_b_true_after
  simp_alive_peephole
  intros
  ---BEGIN a_true_implies_b_true
  apply a_true_implies_b_true_thm
  ---END a_true_implies_b_true



def a_true_implies_b_true2_before := [llvm|
{
^0(%arg30 : i8, %arg31 : i1, %arg32 : i1):
  %0 = llvm.mlir.constant(20 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.icmp "ugt" %arg30, %0 : i8
  %3 = llvm.icmp "ugt" %arg30, %1 : i8
  %4 = "llvm.select"(%3, %arg31, %arg32) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def a_true_implies_b_true2_after := [llvm|
{
^0(%arg30 : i8, %arg31 : i1, %arg32 : i1):
  %0 = llvm.mlir.constant(20 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ugt" %arg30, %0 : i8
  %3 = "llvm.select"(%2, %arg31, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_true_implies_b_true2_proof : a_true_implies_b_true2_before ⊑ a_true_implies_b_true2_after := by
  unfold a_true_implies_b_true2_before a_true_implies_b_true2_after
  simp_alive_peephole
  intros
  ---BEGIN a_true_implies_b_true2
  apply a_true_implies_b_true2_thm
  ---END a_true_implies_b_true2



def a_true_implies_b_true2_comm_before := [llvm|
{
^0(%arg27 : i8, %arg28 : i1, %arg29 : i1):
  %0 = llvm.mlir.constant(20 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.icmp "ugt" %arg27, %0 : i8
  %3 = llvm.icmp "ugt" %arg27, %1 : i8
  %4 = "llvm.select"(%3, %arg28, %arg29) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def a_true_implies_b_true2_comm_after := [llvm|
{
^0(%arg27 : i8, %arg28 : i1, %arg29 : i1):
  %0 = llvm.mlir.constant(20 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ugt" %arg27, %0 : i8
  %3 = "llvm.select"(%2, %arg28, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_true_implies_b_true2_comm_proof : a_true_implies_b_true2_comm_before ⊑ a_true_implies_b_true2_comm_after := by
  unfold a_true_implies_b_true2_comm_before a_true_implies_b_true2_comm_after
  simp_alive_peephole
  intros
  ---BEGIN a_true_implies_b_true2_comm
  apply a_true_implies_b_true2_comm_thm
  ---END a_true_implies_b_true2_comm



def a_true_implies_b_false_before := [llvm|
{
^0(%arg24 : i8, %arg25 : i1, %arg26 : i1):
  %0 = llvm.mlir.constant(20 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.mlir.constant(false) : i1
  %3 = llvm.icmp "ugt" %arg24, %0 : i8
  %4 = llvm.icmp "ult" %arg24, %1 : i8
  %5 = "llvm.select"(%4, %arg25, %arg26) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = "llvm.select"(%3, %5, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def a_true_implies_b_false_after := [llvm|
{
^0(%arg24 : i8, %arg25 : i1, %arg26 : i1):
  %0 = llvm.mlir.constant(20 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ugt" %arg24, %0 : i8
  %3 = "llvm.select"(%2, %arg26, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_true_implies_b_false_proof : a_true_implies_b_false_before ⊑ a_true_implies_b_false_after := by
  unfold a_true_implies_b_false_before a_true_implies_b_false_after
  simp_alive_peephole
  intros
  ---BEGIN a_true_implies_b_false
  apply a_true_implies_b_false_thm
  ---END a_true_implies_b_false



def a_true_implies_b_false2_before := [llvm|
{
^0(%arg21 : i8, %arg22 : i1, %arg23 : i1):
  %0 = llvm.mlir.constant(20 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.icmp "ugt" %arg21, %0 : i8
  %3 = llvm.icmp "eq" %arg21, %1 : i8
  %4 = "llvm.select"(%3, %arg22, %arg23) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.and %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def a_true_implies_b_false2_after := [llvm|
{
^0(%arg21 : i8, %arg22 : i1, %arg23 : i1):
  %0 = llvm.mlir.constant(20 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ugt" %arg21, %0 : i8
  %3 = "llvm.select"(%2, %arg23, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_true_implies_b_false2_proof : a_true_implies_b_false2_before ⊑ a_true_implies_b_false2_after := by
  unfold a_true_implies_b_false2_before a_true_implies_b_false2_after
  simp_alive_peephole
  intros
  ---BEGIN a_true_implies_b_false2
  apply a_true_implies_b_false2_thm
  ---END a_true_implies_b_false2



def a_true_implies_b_false2_comm_before := [llvm|
{
^0(%arg18 : i8, %arg19 : i1, %arg20 : i1):
  %0 = llvm.mlir.constant(20 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.icmp "ugt" %arg18, %0 : i8
  %3 = llvm.icmp "eq" %arg18, %1 : i8
  %4 = "llvm.select"(%3, %arg19, %arg20) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.and %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def a_true_implies_b_false2_comm_after := [llvm|
{
^0(%arg18 : i8, %arg19 : i1, %arg20 : i1):
  %0 = llvm.mlir.constant(20 : i8) : i8
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.icmp "ugt" %arg18, %0 : i8
  %3 = "llvm.select"(%2, %arg20, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_true_implies_b_false2_comm_proof : a_true_implies_b_false2_comm_before ⊑ a_true_implies_b_false2_comm_after := by
  unfold a_true_implies_b_false2_comm_before a_true_implies_b_false2_comm_after
  simp_alive_peephole
  intros
  ---BEGIN a_true_implies_b_false2_comm
  apply a_true_implies_b_false2_comm_thm
  ---END a_true_implies_b_false2_comm



def a_false_implies_b_true_before := [llvm|
{
^0(%arg15 : i8, %arg16 : i1, %arg17 : i1):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(20 : i8) : i8
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "ugt" %arg15, %0 : i8
  %4 = llvm.icmp "ult" %arg15, %1 : i8
  %5 = "llvm.select"(%4, %arg16, %arg17) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = "llvm.select"(%3, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def a_false_implies_b_true_after := [llvm|
{
^0(%arg15 : i8, %arg16 : i1, %arg17 : i1):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ugt" %arg15, %0 : i8
  %3 = "llvm.select"(%2, %1, %arg16) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_false_implies_b_true_proof : a_false_implies_b_true_before ⊑ a_false_implies_b_true_after := by
  unfold a_false_implies_b_true_before a_false_implies_b_true_after
  simp_alive_peephole
  intros
  ---BEGIN a_false_implies_b_true
  apply a_false_implies_b_true_thm
  ---END a_false_implies_b_true



def a_false_implies_b_true2_before := [llvm|
{
^0(%arg12 : i8, %arg13 : i1, %arg14 : i1):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(20 : i8) : i8
  %2 = llvm.icmp "ugt" %arg12, %0 : i8
  %3 = llvm.icmp "ult" %arg12, %1 : i8
  %4 = "llvm.select"(%3, %arg13, %arg14) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.or %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def a_false_implies_b_true2_after := [llvm|
{
^0(%arg12 : i8, %arg13 : i1, %arg14 : i1):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ugt" %arg12, %0 : i8
  %3 = "llvm.select"(%2, %1, %arg13) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_false_implies_b_true2_proof : a_false_implies_b_true2_before ⊑ a_false_implies_b_true2_after := by
  unfold a_false_implies_b_true2_before a_false_implies_b_true2_after
  simp_alive_peephole
  intros
  ---BEGIN a_false_implies_b_true2
  apply a_false_implies_b_true2_thm
  ---END a_false_implies_b_true2



def a_false_implies_b_true2_comm_before := [llvm|
{
^0(%arg9 : i8, %arg10 : i1, %arg11 : i1):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(20 : i8) : i8
  %2 = llvm.icmp "ugt" %arg9, %0 : i8
  %3 = llvm.icmp "ult" %arg9, %1 : i8
  %4 = "llvm.select"(%3, %arg10, %arg11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.or %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def a_false_implies_b_true2_comm_after := [llvm|
{
^0(%arg9 : i8, %arg10 : i1, %arg11 : i1):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ugt" %arg9, %0 : i8
  %3 = "llvm.select"(%2, %1, %arg10) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_false_implies_b_true2_comm_proof : a_false_implies_b_true2_comm_before ⊑ a_false_implies_b_true2_comm_after := by
  unfold a_false_implies_b_true2_comm_before a_false_implies_b_true2_comm_after
  simp_alive_peephole
  intros
  ---BEGIN a_false_implies_b_true2_comm
  apply a_false_implies_b_true2_comm_thm
  ---END a_false_implies_b_true2_comm



def a_false_implies_b_false_before := [llvm|
{
^0(%arg6 : i8, %arg7 : i1, %arg8 : i1):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(20 : i8) : i8
  %2 = llvm.mlir.constant(true) : i1
  %3 = llvm.icmp "ugt" %arg6, %0 : i8
  %4 = llvm.icmp "ugt" %arg6, %1 : i8
  %5 = "llvm.select"(%4, %arg7, %arg8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %6 = "llvm.select"(%3, %2, %5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%6) : (i1) -> ()
}
]
def a_false_implies_b_false_after := [llvm|
{
^0(%arg6 : i8, %arg7 : i1, %arg8 : i1):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ugt" %arg6, %0 : i8
  %3 = "llvm.select"(%2, %1, %arg8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_false_implies_b_false_proof : a_false_implies_b_false_before ⊑ a_false_implies_b_false_after := by
  unfold a_false_implies_b_false_before a_false_implies_b_false_after
  simp_alive_peephole
  intros
  ---BEGIN a_false_implies_b_false
  apply a_false_implies_b_false_thm
  ---END a_false_implies_b_false



def a_false_implies_b_false2_before := [llvm|
{
^0(%arg3 : i8, %arg4 : i1, %arg5 : i1):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(20 : i8) : i8
  %2 = llvm.icmp "ugt" %arg3, %0 : i8
  %3 = llvm.icmp "ugt" %arg3, %1 : i8
  %4 = "llvm.select"(%3, %arg4, %arg5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.or %2, %4 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def a_false_implies_b_false2_after := [llvm|
{
^0(%arg3 : i8, %arg4 : i1, %arg5 : i1):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ugt" %arg3, %0 : i8
  %3 = "llvm.select"(%2, %1, %arg5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_false_implies_b_false2_proof : a_false_implies_b_false2_before ⊑ a_false_implies_b_false2_after := by
  unfold a_false_implies_b_false2_before a_false_implies_b_false2_after
  simp_alive_peephole
  intros
  ---BEGIN a_false_implies_b_false2
  apply a_false_implies_b_false2_thm
  ---END a_false_implies_b_false2



def a_false_implies_b_false2_comm_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i1, %arg2 : i1):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(20 : i8) : i8
  %2 = llvm.icmp "ugt" %arg0, %0 : i8
  %3 = llvm.icmp "ugt" %arg0, %1 : i8
  %4 = "llvm.select"(%3, %arg1, %arg2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = llvm.or %4, %2 : i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def a_false_implies_b_false2_comm_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i1, %arg2 : i1):
  %0 = llvm.mlir.constant(10 : i8) : i8
  %1 = llvm.mlir.constant(true) : i1
  %2 = llvm.icmp "ugt" %arg0, %0 : i8
  %3 = "llvm.select"(%2, %1, %arg2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem a_false_implies_b_false2_comm_proof : a_false_implies_b_false2_comm_before ⊑ a_false_implies_b_false2_comm_after := by
  unfold a_false_implies_b_false2_comm_before a_false_implies_b_false2_comm_after
  simp_alive_peephole
  intros
  ---BEGIN a_false_implies_b_false2_comm
  apply a_false_implies_b_false2_comm_thm
  ---END a_false_implies_b_false2_comm


