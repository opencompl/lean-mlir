
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
section gcanonicalizehlowhbithmaskhv2handhicmpheqhtohicmphule_statements

def p0_before := [llvm|
{
^0(%arg30 : i8, %arg31 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg31 : i8
  %2 = llvm.xor %1, %0 : i8
  %3 = llvm.and %2, %arg30 : i8
  %4 = llvm.icmp "eq" %3, %arg30 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def p0_after := [llvm|
{
^0(%arg30 : i8, %arg31 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.lshr %arg30, %arg31 : i8
  %2 = llvm.icmp "eq" %1, %0 : i8
  "llvm.return"(%2) : (i1) -> ()
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



def n0_before := [llvm|
{
^0(%arg4 : i8, %arg5 : i8, %arg6 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg5 : i8
  %2 = llvm.xor %1, %0 : i8
  %3 = llvm.and %2, %arg4 : i8
  %4 = llvm.icmp "eq" %3, %arg6 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def n0_after := [llvm|
{
^0(%arg4 : i8, %arg5 : i8, %arg6 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg5 overflow<nsw> : i8
  %2 = llvm.xor %1, %0 : i8
  %3 = llvm.and %arg4, %2 : i8
  %4 = llvm.icmp "eq" %3, %arg6 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n0_proof : n0_before ⊑ n0_after := by
  unfold n0_before n0_after
  simp_alive_peephole
  intros
  ---BEGIN n0
  all_goals (try extract_goal ; sorry)
  ---END n0



def n1_before := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.shl %0, %arg3 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.and %3, %arg2 : i8
  %5 = llvm.icmp "eq" %4, %arg2 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def n1_after := [llvm|
{
^0(%arg2 : i8, %arg3 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.shl %0, %arg3 overflow<nuw> : i8
  %3 = llvm.and %arg2, %2 : i8
  %4 = llvm.icmp "eq" %3, %1 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n1_proof : n1_before ⊑ n1_after := by
  unfold n1_before n1_after
  simp_alive_peephole
  intros
  ---BEGIN n1
  all_goals (try extract_goal ; sorry)
  ---END n1



def n2_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.shl %0, %arg1 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.and %3, %arg0 : i8
  %5 = llvm.icmp "eq" %4, %arg0 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def n2_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(-2 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.shl %0, %arg1 overflow<nsw> : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.and %arg0, %4 : i8
  %6 = llvm.icmp "eq" %5, %2 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n2_proof : n2_before ⊑ n2_after := by
  unfold n2_before n2_after
  simp_alive_peephole
  intros
  ---BEGIN n2
  all_goals (try extract_goal ; sorry)
  ---END n2


