
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
section gcanonicalizehselectshicmphconditionhbittest_statements

def p0_before := [llvm|
{
^0(%arg31 : i8, %arg32 : i8, %arg33 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.and %arg31, %0 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  %3 = "llvm.select"(%2, %arg32, %arg33) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def p0_after := [llvm|
{
^0(%arg31 : i8, %arg32 : i8, %arg33 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg31, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  %4 = "llvm.select"(%3, %arg33, %arg32) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem p0_proof : p0_before ⊑ p0_after := by
  unfold p0_before p0_after
  simp_alive_peephole
  intros
  ---BEGIN p0
  all_goals (try extract_goal ; sorry)
  ---END p0



def p1_before := [llvm|
{
^0(%arg28 : i8, %arg29 : i8, %arg30 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg28, %0 : i8
  %3 = llvm.icmp "ne" %2, %1 : i8
  %4 = "llvm.select"(%3, %arg29, %arg30) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def p1_after := [llvm|
{
^0(%arg28 : i8, %arg29 : i8, %arg30 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg28, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  %4 = "llvm.select"(%3, %arg30, %arg29) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem p1_proof : p1_before ⊑ p1_after := by
  unfold p1_before p1_after
  simp_alive_peephole
  intros
  ---BEGIN p1
  all_goals (try extract_goal ; sorry)
  ---END p1



def n5_before := [llvm|
{
^0(%arg9 : i8, %arg10 : i8, %arg11 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.and %arg9, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  %4 = "llvm.select"(%3, %arg10, %arg11) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def n5_after := [llvm|
{
^0(%arg9 : i8, %arg10 : i8, %arg11 : i8):
  "llvm.return"(%arg11) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n5_proof : n5_before ⊑ n5_after := by
  unfold n5_before n5_after
  simp_alive_peephole
  intros
  ---BEGIN n5
  all_goals (try extract_goal ; sorry)
  ---END n5



def n6_before := [llvm|
{
^0(%arg6 : i8, %arg7 : i8, %arg8 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(3 : i8) : i8
  %2 = llvm.and %arg6, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  %4 = "llvm.select"(%3, %arg7, %arg8) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def n6_after := [llvm|
{
^0(%arg6 : i8, %arg7 : i8, %arg8 : i8):
  "llvm.return"(%arg8) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n6_proof : n6_before ⊑ n6_after := by
  unfold n6_before n6_after
  simp_alive_peephole
  intros
  ---BEGIN n6
  all_goals (try extract_goal ; sorry)
  ---END n6



def n7_before := [llvm|
{
^0(%arg3 : i8, %arg4 : i8, %arg5 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.and %arg3, %0 : i8
  %2 = llvm.icmp "ne" %1, %0 : i8
  %3 = "llvm.select"(%2, %arg4, %arg5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def n7_after := [llvm|
{
^0(%arg3 : i8, %arg4 : i8, %arg5 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg3, %0 : i8
  %3 = llvm.icmp "eq" %2, %1 : i8
  %4 = "llvm.select"(%3, %arg4, %arg5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n7_proof : n7_before ⊑ n7_after := by
  unfold n7_before n7_after
  simp_alive_peephole
  intros
  ---BEGIN n7
  all_goals (try extract_goal ; sorry)
  ---END n7


