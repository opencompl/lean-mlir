import SSA.Projects.InstCombine.tests.proofs.ghoisthnegationhouthofhbiashcalculationhwithhconstant_proof
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
section ghoisthnegationhouthofhbiashcalculationhwithhconstant_statements

def t0_before := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.and %arg7, %0 : i8
  %2 = llvm.sub %1, %arg7 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg7 : i8):
  %0 = llvm.mlir.constant(-43 : i8) : i8
  %1 = llvm.mlir.constant(0 : i8) : i8
  %2 = llvm.and %arg7, %0 : i8
  %3 = llvm.sub %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
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



def n5_before := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(42 : i8) : i8
  %1 = llvm.and %arg2, %0 : i8
  %2 = llvm.sub %arg2, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def n5_after := [llvm|
{
^0(%arg2 : i8):
  %0 = llvm.mlir.constant(-43 : i8) : i8
  %1 = llvm.and %arg2, %0 : i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n5_proof : n5_before ⊑ n5_after := by
  unfold n5_before n5_after
  simp_alive_peephole
  intros
  ---BEGIN n5
  apply n5_thm
  ---END n5


