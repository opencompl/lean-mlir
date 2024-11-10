
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
section glowhbithsplat_statements

def t0_before := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.shl %arg12, %0 : i8
  %2 = llvm.ashr %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg12, %0 : i8
  %3 = llvm.sub %1, %2 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  intros
  ---BEGIN t0
  all_goals (try extract_goal ; sorry)
  ---END t0



def t1_otherbitwidth_before := [llvm|
{
^0(%arg11 : i16):
  %0 = llvm.mlir.constant(15 : i16) : i16
  %1 = llvm.shl %arg11, %0 : i16
  %2 = llvm.ashr %1, %0 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def t1_otherbitwidth_after := [llvm|
{
^0(%arg11 : i16):
  %0 = llvm.mlir.constant(1 : i16) : i16
  %1 = llvm.mlir.constant(0 : i16) : i16
  %2 = llvm.and %arg11, %0 : i16
  %3 = llvm.sub %1, %2 overflow<nsw> : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_otherbitwidth_proof : t1_otherbitwidth_before ⊑ t1_otherbitwidth_after := by
  unfold t1_otherbitwidth_before t1_otherbitwidth_after
  simp_alive_peephole
  intros
  ---BEGIN t1_otherbitwidth
  all_goals (try extract_goal ; sorry)
  ---END t1_otherbitwidth



def n11_before := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.shl %arg1, %0 : i8
  %3 = llvm.ashr %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def n11_after := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.shl %arg1, %0 : i8
  %3 = llvm.ashr exact %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n11_proof : n11_before ⊑ n11_after := by
  unfold n11_before n11_after
  simp_alive_peephole
  intros
  ---BEGIN n11
  all_goals (try extract_goal ; sorry)
  ---END n11



def n12_before := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.shl %arg0, %0 : i8
  %2 = llvm.ashr %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def n12_after := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.shl %arg0, %0 : i8
  %2 = llvm.ashr exact %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n12_proof : n12_before ⊑ n12_after := by
  unfold n12_before n12_after
  simp_alive_peephole
  intros
  ---BEGIN n12
  all_goals (try extract_goal ; sorry)
  ---END n12


