
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
section gapinthselect_statements

def zext_before := [llvm|
{
^0(%arg10 : i1):
  %0 = llvm.mlir.constant(1 : i41) : i41
  %1 = llvm.mlir.constant(0 : i41) : i41
  %2 = "llvm.select"(%arg10, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i41, i41) -> i41
  "llvm.return"(%2) : (i41) -> ()
}
]
def zext_after := [llvm|
{
^0(%arg10 : i1):
  %0 = llvm.zext %arg10 : i1 to i41
  "llvm.return"(%0) : (i41) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_proof : zext_before ⊑ zext_after := by
  unfold zext_before zext_after
  simp_alive_peephole
  intros
  ---BEGIN zext
  all_goals (try extract_goal ; sorry)
  ---END zext



def sext_before := [llvm|
{
^0(%arg9 : i1):
  %0 = llvm.mlir.constant(-1 : i41) : i41
  %1 = llvm.mlir.constant(0 : i41) : i41
  %2 = "llvm.select"(%arg9, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i41, i41) -> i41
  "llvm.return"(%2) : (i41) -> ()
}
]
def sext_after := [llvm|
{
^0(%arg9 : i1):
  %0 = llvm.sext %arg9 : i1 to i41
  "llvm.return"(%0) : (i41) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_proof : sext_before ⊑ sext_after := by
  unfold sext_before sext_after
  simp_alive_peephole
  intros
  ---BEGIN sext
  all_goals (try extract_goal ; sorry)
  ---END sext



def not_zext_before := [llvm|
{
^0(%arg8 : i1):
  %0 = llvm.mlir.constant(0 : i999) : i999
  %1 = llvm.mlir.constant(1 : i999) : i999
  %2 = "llvm.select"(%arg8, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i999, i999) -> i999
  "llvm.return"(%2) : (i999) -> ()
}
]
def not_zext_after := [llvm|
{
^0(%arg8 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg8, %0 : i1
  %2 = llvm.zext %1 : i1 to i999
  "llvm.return"(%2) : (i999) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_zext_proof : not_zext_before ⊑ not_zext_after := by
  unfold not_zext_before not_zext_after
  simp_alive_peephole
  intros
  ---BEGIN not_zext
  all_goals (try extract_goal ; sorry)
  ---END not_zext



def not_sext_before := [llvm|
{
^0(%arg7 : i1):
  %0 = llvm.mlir.constant(0 : i999) : i999
  %1 = llvm.mlir.constant(-1 : i999) : i999
  %2 = "llvm.select"(%arg7, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i999, i999) -> i999
  "llvm.return"(%2) : (i999) -> ()
}
]
def not_sext_after := [llvm|
{
^0(%arg7 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg7, %0 : i1
  %2 = llvm.sext %1 : i1 to i999
  "llvm.return"(%2) : (i999) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_sext_proof : not_sext_before ⊑ not_sext_after := by
  unfold not_sext_before not_sext_after
  simp_alive_peephole
  intros
  ---BEGIN not_sext
  all_goals (try extract_goal ; sorry)
  ---END not_sext



def test3_before := [llvm|
{
^0(%arg1 : i41):
  %0 = llvm.mlir.constant(0 : i41) : i41
  %1 = llvm.mlir.constant(-1 : i41) : i41
  %2 = llvm.icmp "slt" %arg1, %0 : i41
  %3 = "llvm.select"(%2, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i41, i41) -> i41
  "llvm.return"(%3) : (i41) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg1 : i41):
  %0 = llvm.mlir.constant(40 : i41) : i41
  %1 = llvm.ashr %arg1, %0 : i41
  "llvm.return"(%1) : (i41) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  intros
  ---BEGIN test3
  all_goals (try extract_goal ; sorry)
  ---END test3



def test4_before := [llvm|
{
^0(%arg0 : i1023):
  %0 = llvm.mlir.constant(0 : i1023) : i1023
  %1 = llvm.mlir.constant(-1 : i1023) : i1023
  %2 = llvm.icmp "slt" %arg0, %0 : i1023
  %3 = "llvm.select"(%2, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1023, i1023) -> i1023
  "llvm.return"(%3) : (i1023) -> ()
}
]
def test4_after := [llvm|
{
^0(%arg0 : i1023):
  %0 = llvm.mlir.constant(1022 : i1023) : i1023
  %1 = llvm.ashr %arg0, %0 : i1023
  "llvm.return"(%1) : (i1023) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test4_proof : test4_before ⊑ test4_after := by
  unfold test4_before test4_after
  simp_alive_peephole
  intros
  ---BEGIN test4
  all_goals (try extract_goal ; sorry)
  ---END test4


