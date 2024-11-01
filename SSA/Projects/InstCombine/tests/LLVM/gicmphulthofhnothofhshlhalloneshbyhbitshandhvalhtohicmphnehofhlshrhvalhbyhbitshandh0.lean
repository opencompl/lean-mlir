
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
section gicmphulthofhnothofhshlhalloneshbyhbitshandhvalhtohicmphnehofhlshrhvalhbyhbitshandh0_statements

def p0_before := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg29 : i8
  %2 = llvm.xor %1, %0 : i8
  %3 = llvm.icmp "ult" %2, %arg28 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def p0_after := [llvm|
{
^0(%arg28 : i8, %arg29 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.lshr %arg28, %arg29 : i8
  %2 = llvm.icmp "ne" %1, %0 : i8
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



def both_before := [llvm|
{
^0(%arg17 : i8, %arg18 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg17 : i8
  %2 = llvm.xor %1, %0 : i8
  %3 = llvm.shl %0, %arg18 : i8
  %4 = llvm.xor %3, %0 : i8
  %5 = llvm.icmp "ult" %2, %4 : i8
  "llvm.return"(%5) : (i1) -> ()
}
]
def both_after := [llvm|
{
^0(%arg17 : i8, %arg18 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg17 overflow<nsw> : i8
  %2 = llvm.shl %0, %arg18 overflow<nsw> : i8
  %3 = llvm.icmp "ugt" %1, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem both_proof : both_before ⊑ both_after := by
  unfold both_before both_after
  simp_alive_peephole
  intros
  ---BEGIN both
  all_goals (try extract_goal ; sorry)
  ---END both



def n0_before := [llvm|
{
^0(%arg9 : i8, %arg10 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.shl %0, %arg10 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.icmp "ult" %3, %arg9 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def n0_after := [llvm|
{
^0(%arg9 : i8, %arg10 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(-1 : i8) : i8
  %2 = llvm.shl %0, %arg10 overflow<nuw> : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.icmp "ugt" %arg9, %3 : i8
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
^0(%arg7 : i8, %arg8 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.shl %0, %arg8 : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.icmp "ult" %3, %arg7 : i8
  "llvm.return"(%4) : (i1) -> ()
}
]
def n1_after := [llvm|
{
^0(%arg7 : i8, %arg8 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.shl %0, %arg8 overflow<nsw> : i8
  %3 = llvm.xor %2, %1 : i8
  %4 = llvm.icmp "ult" %3, %arg7 : i8
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



def n3_before := [llvm|
{
^0(%arg1 : i8, %arg2 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg2 : i8
  %2 = llvm.xor %1, %0 : i8
  %3 = llvm.icmp "ule" %2, %arg1 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def n3_after := [llvm|
{
^0(%arg1 : i8, %arg2 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.shl %0, %arg2 overflow<nsw> : i8
  %2 = llvm.xor %1, %0 : i8
  %3 = llvm.icmp "uge" %arg1, %2 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n3_proof : n3_before ⊑ n3_after := by
  unfold n3_before n3_after
  simp_alive_peephole
  intros
  ---BEGIN n3
  all_goals (try extract_goal ; sorry)
  ---END n3


