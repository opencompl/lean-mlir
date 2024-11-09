import SSA.Projects.InstCombine.tests.proofs.g2012h08h28hudiv_ashl_proof
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
section g2012h08h28hudiv_ashl_statements

def udiv400_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(100 : i32) : i32
  %2 = llvm.lshr %arg5, %0 : i32
  %3 = llvm.udiv %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def udiv400_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(400 : i32) : i32
  %1 = llvm.udiv %arg5, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv400_proof : udiv400_before ⊑ udiv400_after := by
  unfold udiv400_before udiv400_after
  simp_alive_peephole
  intros
  ---BEGIN udiv400
  apply udiv400_thm
  ---END udiv400



def sdiv400_yes_before := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(100 : i32) : i32
  %2 = llvm.lshr %arg3, %0 : i32
  %3 = llvm.sdiv %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def sdiv400_yes_after := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(400 : i32) : i32
  %1 = llvm.udiv %arg3, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sdiv400_yes_proof : sdiv400_yes_before ⊑ sdiv400_yes_after := by
  unfold sdiv400_yes_before sdiv400_yes_after
  simp_alive_peephole
  intros
  ---BEGIN sdiv400_yes
  apply sdiv400_yes_thm
  ---END sdiv400_yes



def udiv_i80_before := [llvm|
{
^0(%arg2 : i80):
  %0 = llvm.mlir.constant(2 : i80) : i80
  %1 = llvm.mlir.constant(100 : i80) : i80
  %2 = llvm.lshr %arg2, %0 : i80
  %3 = llvm.udiv %2, %1 : i80
  "llvm.return"(%3) : (i80) -> ()
}
]
def udiv_i80_after := [llvm|
{
^0(%arg2 : i80):
  %0 = llvm.mlir.constant(400 : i80) : i80
  %1 = llvm.udiv %arg2, %0 : i80
  "llvm.return"(%1) : (i80) -> ()
}
]
set_option debug.skipKernelTC true in
theorem udiv_i80_proof : udiv_i80_before ⊑ udiv_i80_after := by
  unfold udiv_i80_before udiv_i80_after
  simp_alive_peephole
  intros
  ---BEGIN udiv_i80
  apply udiv_i80_thm
  ---END udiv_i80


