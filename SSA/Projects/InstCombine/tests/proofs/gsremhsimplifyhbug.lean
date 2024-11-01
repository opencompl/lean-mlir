import SSA.Projects.InstCombine.tests.proofs.gsremhsimplifyhbug_proof
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
section gsremhsimplifyhbug_statements

def f_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.or %arg0, %0 : i32
  %3 = llvm.srem %2, %0 : i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def f_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(false) : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem f_proof : f_before ⊑ f_after := by
  unfold f_before f_after
  simp_alive_peephole
  intros
  ---BEGIN f
  apply f_thm
  ---END f


