
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
section g2010h11h23hDistributed_statements

def foo_before := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.add %arg3, %arg2 overflow<nsw> : i32
  %1 = llvm.mul %0, %arg3 overflow<nsw> : i32
  %2 = llvm.mul %arg3, %arg3 overflow<nsw> : i32
  %3 = llvm.sub %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def foo_after := [llvm|
{
^0(%arg2 : i32, %arg3 : i32):
  %0 = llvm.mul %arg2, %arg3 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo_proof : foo_before ⊑ foo_after := by
  unfold foo_before foo_after
  simp_alive_peephole
  intros
  ---BEGIN foo
  all_goals (try extract_goal ; sorry)
  ---END foo



def bar_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.and %arg1, %arg0 : i64
  %3 = llvm.xor %2, %0 : i64
  %4 = llvm.and %arg1, %3 : i64
  %5 = llvm.icmp "eq" %4, %1 : i64
  "llvm.return"(%5) : (i1) -> ()
}
]
def bar_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.mlir.constant(0) : i64
  %2 = llvm.xor %arg0, %0 : i64
  %3 = llvm.and %arg1, %2 : i64
  %4 = llvm.icmp "eq" %3, %1 : i64
  "llvm.return"(%4) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bar_proof : bar_before ⊑ bar_after := by
  unfold bar_before bar_after
  simp_alive_peephole
  intros
  ---BEGIN bar
  all_goals (try extract_goal ; sorry)
  ---END bar


