import SSA.Projects.InstCombine.tests.proofs.ghoisthnegationhouthofhbiashcalculation_proof
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
section ghoisthnegationhouthofhbiashcalculation_statements

def t0_before := [llvm|
{
^0(%arg18 : i8, %arg19 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg19 : i8
  %2 = llvm.and %1, %arg18 : i8
  %3 = llvm.sub %2, %arg18 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg18 : i8, %arg19 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.add %arg19, %0 : i8
  %3 = llvm.and %arg18, %2 : i8
  %4 = llvm.sub %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
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



def n7_before := [llvm|
{
^0(%arg5 : i8, %arg6 : i8):
  %0 = llvm.mlir.constant(0 : i8) : i8
  %1 = llvm.sub %0, %arg6 : i8
  %2 = llvm.and %1, %arg5 : i8
  %3 = llvm.sub %arg5, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def n7_after := [llvm|
{
^0(%arg5 : i8, %arg6 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.add %arg6, %0 : i8
  %2 = llvm.and %arg5, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n7_proof : n7_before ⊑ n7_after := by
  unfold n7_before n7_after
  simp_alive_peephole
  intros
  ---BEGIN n7
  apply n7_thm
  ---END n7


