
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
section gcanonicalizehsignedhtruncationhcheck_statements

def p0_before := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.shl %arg14, %0 : i8
  %2 = llvm.ashr exact %1, %0 : i8
  %3 = llvm.icmp "ne" %2, %arg14 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def p0_after := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(-4 : i8) : i8
  %1 = llvm.mlir.constant(-8 : i8) : i8
  %2 = llvm.add %arg14, %0 : i8
  %3 = llvm.icmp "ult" %2, %1 : i8
  "llvm.return"(%3) : (i1) -> ()
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



def pb_before := [llvm|
{
^0(%arg13 : i65):
  %0 = llvm.mlir.constant(1 : i65) : i65
  %1 = llvm.shl %arg13, %0 : i65
  %2 = llvm.ashr exact %1, %0 : i65
  %3 = llvm.icmp "ne" %arg13, %2 : i65
  "llvm.return"(%3) : (i1) -> ()
}
]
def pb_after := [llvm|
{
^0(%arg13 : i65):
  %0 = llvm.mlir.constant(9223372036854775808 : i65) : i65
  %1 = llvm.mlir.constant(0 : i65) : i65
  %2 = llvm.add %arg13, %0 : i65
  %3 = llvm.icmp "slt" %2, %1 : i65
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem pb_proof : pb_before ⊑ pb_after := by
  unfold pb_before pb_after
  simp_alive_peephole
  intros
  ---BEGIN pb
  all_goals (try extract_goal ; sorry)
  ---END pb



def n1_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.shl %arg3, %0 : i8
  %2 = llvm.lshr exact %1, %0 : i8
  %3 = llvm.icmp "ne" %2, %arg3 : i8
  "llvm.return"(%3) : (i1) -> ()
}
]
def n1_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.icmp "ugt" %arg3, %0 : i8
  "llvm.return"(%1) : (i1) -> ()
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


