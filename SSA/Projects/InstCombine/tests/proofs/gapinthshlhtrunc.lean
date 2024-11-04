import SSA.Projects.InstCombine.tests.proofs.gapinthshlhtrunc_proof
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
section gapinthshlhtrunc_statements

def test0_before := [llvm|
{
^0(%arg4 : i39, %arg5 : i39):
  %0 = llvm.lshr %arg4, %arg5 : i39
  %1 = llvm.trunc %0 : i39 to i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test0_after := [llvm|
{
^0(%arg4 : i39, %arg5 : i39):
  %0 = llvm.mlir.constant(1 : i39) : i39
  %1 = llvm.mlir.constant(0 : i39) : i39
  %2 = llvm.shl %0, %arg5 overflow<nuw> : i39
  %3 = llvm.and %2, %arg4 : i39
  %4 = llvm.icmp "ne" %3, %1 : i39
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test0_proof : test0_before ⊑ test0_after := by
  unfold test0_before test0_after
  simp_alive_peephole
  intros
  ---BEGIN test0
  apply test0_thm
  ---END test0



def test1_before := [llvm|
{
^0(%arg2 : i799, %arg3 : i799):
  %0 = llvm.lshr %arg2, %arg3 : i799
  %1 = llvm.trunc %0 : i799 to i1
  "llvm.return"(%1) : (i1) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg2 : i799, %arg3 : i799):
  %0 = llvm.mlir.constant(1 : i799) : i799
  %1 = llvm.mlir.constant(0 : i799) : i799
  %2 = llvm.shl %0, %arg3 overflow<nuw> : i799
  %3 = llvm.and %2, %arg2 : i799
  %4 = llvm.icmp "ne" %3, %1 : i799
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  apply test1_thm
  ---END test1


