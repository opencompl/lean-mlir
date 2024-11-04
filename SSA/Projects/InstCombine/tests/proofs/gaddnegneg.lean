import SSA.Projects.InstCombine.tests.proofs.gaddnegneg_proof
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
section gaddnegneg_statements

def l_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32, %arg3 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sub %0, %arg1 : i32
  %2 = llvm.sub %0, %arg2 : i32
  %3 = llvm.add %2, %1 : i32
  %4 = llvm.add %3, %arg3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def l_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32, %arg3 : i32):
  %0 = llvm.add %arg2, %arg1 : i32
  %1 = llvm.sub %arg3, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem l_proof : l_before ⊑ l_after := by
  unfold l_before l_after
  simp_alive_peephole
  intros
  ---BEGIN l
  apply l_thm
  ---END l


