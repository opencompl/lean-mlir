import SSA.Projects.InstCombine.tests.proofs.guaddo_proof
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
section guaddo_statements

def uaddo_commute3_before := [llvm|
{
^0(%arg25 : i32, %arg26 : i32, %arg27 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg26, %0 : i32
  %2 = llvm.add %arg25, %arg26 : i32
  %3 = llvm.icmp "ult" %1, %arg25 : i32
  %4 = "llvm.select"(%3, %arg27, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def uaddo_commute3_after := [llvm|
{
^0(%arg25 : i32, %arg26 : i32, %arg27 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg26, %0 : i32
  %2 = llvm.add %arg25, %arg26 : i32
  %3 = llvm.icmp "ugt" %arg25, %1 : i32
  %4 = "llvm.select"(%3, %arg27, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uaddo_commute3_proof : uaddo_commute3_before ⊑ uaddo_commute3_after := by
  unfold uaddo_commute3_before uaddo_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN uaddo_commute3
  apply uaddo_commute3_thm
  ---END uaddo_commute3



def uaddo_commute4_before := [llvm|
{
^0(%arg22 : i32, %arg23 : i32, %arg24 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg23, %0 : i32
  %2 = llvm.add %arg23, %arg22 : i32
  %3 = llvm.icmp "ult" %1, %arg22 : i32
  %4 = "llvm.select"(%3, %arg24, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def uaddo_commute4_after := [llvm|
{
^0(%arg22 : i32, %arg23 : i32, %arg24 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg23, %0 : i32
  %2 = llvm.add %arg23, %arg22 : i32
  %3 = llvm.icmp "ugt" %arg22, %1 : i32
  %4 = "llvm.select"(%3, %arg24, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uaddo_commute4_proof : uaddo_commute4_before ⊑ uaddo_commute4_after := by
  unfold uaddo_commute4_before uaddo_commute4_after
  simp_alive_peephole
  intros
  ---BEGIN uaddo_commute4
  apply uaddo_commute4_thm
  ---END uaddo_commute4



def uaddo_commute7_before := [llvm|
{
^0(%arg13 : i32, %arg14 : i32, %arg15 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg14, %0 : i32
  %2 = llvm.add %arg13, %arg14 : i32
  %3 = llvm.icmp "ult" %1, %arg13 : i32
  %4 = "llvm.select"(%3, %2, %arg15) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def uaddo_commute7_after := [llvm|
{
^0(%arg13 : i32, %arg14 : i32, %arg15 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg14, %0 : i32
  %2 = llvm.add %arg13, %arg14 : i32
  %3 = llvm.icmp "ugt" %arg13, %1 : i32
  %4 = "llvm.select"(%3, %2, %arg15) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uaddo_commute7_proof : uaddo_commute7_before ⊑ uaddo_commute7_after := by
  unfold uaddo_commute7_before uaddo_commute7_after
  simp_alive_peephole
  intros
  ---BEGIN uaddo_commute7
  apply uaddo_commute7_thm
  ---END uaddo_commute7



def uaddo_commute8_before := [llvm|
{
^0(%arg10 : i32, %arg11 : i32, %arg12 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg11, %0 : i32
  %2 = llvm.add %arg11, %arg10 : i32
  %3 = llvm.icmp "ult" %1, %arg10 : i32
  %4 = "llvm.select"(%3, %2, %arg12) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def uaddo_commute8_after := [llvm|
{
^0(%arg10 : i32, %arg11 : i32, %arg12 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg11, %0 : i32
  %2 = llvm.add %arg11, %arg10 : i32
  %3 = llvm.icmp "ugt" %arg10, %1 : i32
  %4 = "llvm.select"(%3, %2, %arg12) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uaddo_commute8_proof : uaddo_commute8_before ⊑ uaddo_commute8_after := by
  unfold uaddo_commute8_before uaddo_commute8_after
  simp_alive_peephole
  intros
  ---BEGIN uaddo_commute8
  apply uaddo_commute8_thm
  ---END uaddo_commute8



def uaddo_wrong_pred2_before := [llvm|
{
^0(%arg4 : i32, %arg5 : i32, %arg6 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg5, %0 : i32
  %2 = llvm.add %arg4, %arg5 : i32
  %3 = llvm.icmp "uge" %arg4, %1 : i32
  %4 = "llvm.select"(%3, %arg6, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def uaddo_wrong_pred2_after := [llvm|
{
^0(%arg4 : i32, %arg5 : i32, %arg6 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg5, %0 : i32
  %2 = llvm.add %arg4, %arg5 : i32
  %3 = llvm.icmp "ult" %arg4, %1 : i32
  %4 = "llvm.select"(%3, %2, %arg6) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem uaddo_wrong_pred2_proof : uaddo_wrong_pred2_before ⊑ uaddo_wrong_pred2_after := by
  unfold uaddo_wrong_pred2_before uaddo_wrong_pred2_after
  simp_alive_peephole
  intros
  ---BEGIN uaddo_wrong_pred2
  apply uaddo_wrong_pred2_thm
  ---END uaddo_wrong_pred2


