
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
section gpr14365_statements

def test0_before := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(1431655765 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.and %arg3, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %4, %2 overflow<nsw> : i32
  %6 = llvm.add %arg3, %5 overflow<nsw> : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test0_after := [llvm|
{
^0(%arg3 : i32):
  %0 = llvm.mlir.constant(-1431655766 : i32) : i32
  %1 = llvm.and %arg3, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test0_proof : test0_before ⊑ test0_after := by
  unfold test0_before test0_after
  simp_alive_peephole
  intros
  ---BEGIN test0
  all_goals (try extract_goal ; sorry)
  ---END test0



def test1_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(1431655765 : i32) : i32
  %2 = llvm.mlir.constant(-1 : i32) : i32
  %3 = llvm.ashr %arg1, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  %6 = llvm.add %5, %0 overflow<nsw> : i32
  %7 = llvm.add %arg1, %6 overflow<nsw> : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(1431655765 : i32) : i32
  %2 = llvm.lshr %arg1, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.sub %arg1, %3 overflow<nsw> : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  all_goals (try extract_goal ; sorry)
  ---END test1


