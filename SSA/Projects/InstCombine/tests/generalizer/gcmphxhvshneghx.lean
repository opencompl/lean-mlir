import SSA.Projects.InstCombine.tests.proofs.gcmphxhvshneghx_proof
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
section gcmphxhvshneghx_statements

def t0_before := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg14 overflow<nsw> : i8
  %2 = llvm.icmp "sgt" %1, %arg14 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "slt" %arg14, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
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
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg12 overflow<nsw> : i8
  %2 = llvm.icmp "sge" %1, %arg12 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def t1_after := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.icmp "slt" %arg12, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
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
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg11 overflow<nsw> : i8
  %2 = llvm.icmp "slt" %1, %arg11 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def t2_after := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "sgt" %arg11, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
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



def t3_before := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg10 overflow<nsw> : i8
  %2 = llvm.icmp "sle" %1, %arg10 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def t3_after := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "sgt" %arg10, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t3_proof : t3_before ⊑ t3_after := by
  unfold t3_before t3_after
  simp_alive_peephole
  intros
  ---BEGIN t3
  apply t3_thm
  ---END t3



def t4_before := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg9 overflow<nsw> : i8
  %2 = llvm.icmp "ugt" %1, %arg9 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def t4_after := [llvm|
{
^0(%arg9 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "sgt" %arg9, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t4_proof : t4_before ⊑ t4_after := by
  unfold t4_before t4_after
  simp_alive_peephole
  intros
  ---BEGIN t4
  apply t4_thm
  ---END t4



def t5_before := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg8 overflow<nsw> : i8
  %2 = llvm.icmp "uge" %1, %arg8 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def t5_after := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.icmp "sgt" %arg8, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t5_proof : t5_before ⊑ t5_after := by
  unfold t5_before t5_after
  simp_alive_peephole
  intros
  ---BEGIN t5
  apply t5_thm
  ---END t5



def t6_before := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg7 overflow<nsw> : i8
  %2 = llvm.icmp "ult" %1, %arg7 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def t6_after := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "slt" %arg7, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t6_proof : t6_before ⊑ t6_after := by
  unfold t6_before t6_after
  simp_alive_peephole
  intros
  ---BEGIN t6
  apply t6_thm
  ---END t6



def t7_before := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg6 overflow<nsw> : i8
  %2 = llvm.icmp "ule" %1, %arg6 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def t7_after := [llvm|
{
^0(%arg6 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.icmp "slt" %arg6, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t7_proof : t7_before ⊑ t7_after := by
  unfold t7_before t7_after
  simp_alive_peephole
  intros
  ---BEGIN t7
  apply t7_thm
  ---END t7



def t8_before := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg5 overflow<nsw> : i8
  %2 = llvm.icmp "eq" %1, %arg5 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def t8_after := [llvm|
{
^0(%arg5 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "eq" %arg5, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t8_proof : t8_before ⊑ t8_after := by
  unfold t8_before t8_after
  simp_alive_peephole
  intros
  ---BEGIN t8
  apply t8_thm
  ---END t8



def t9_before := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg4 overflow<nsw> : i8
  %2 = llvm.icmp "ne" %1, %arg4 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def t9_after := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.icmp "ne" %arg4, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t9_proof : t9_before ⊑ t9_after := by
  unfold t9_before t9_after
  simp_alive_peephole
  intros
  ---BEGIN t9
  apply t9_thm
  ---END t9



def n10_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg3 : i8
  %2 = llvm.icmp "sgt" %1, %arg3 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def n10_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg3 : i8
  %2 = llvm.icmp "slt" %arg3, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n10_proof : n10_before ⊑ n10_after := by
  unfold n10_before n10_after
  simp_alive_peephole
  intros
  ---BEGIN n10
  apply n10_thm
  ---END n10



def n12_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg0 overflow<nsw> : i8
  %2 = llvm.icmp "sgt" %1, %arg1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
def n12_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg0 overflow<nsw> : i8
  %2 = llvm.icmp "slt" %arg1, %1 : i8
  "llvm.return"(%2) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n12_proof : n12_before ⊑ n12_after := by
  unfold n12_before n12_after
  simp_alive_peephole
  intros
  ---BEGIN n12
  apply n12_thm
  ---END n12


