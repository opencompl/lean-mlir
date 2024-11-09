
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
section g2008h01h21hMulTrunc_statements

def test1_before := [llvm|
{
^0(%arg3 : i16):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = llvm.zext %arg3 : i16 to i32
  %3 = llvm.lshr %2, %0 : i32
  %4 = llvm.mul %2, %1 : i32
  %5 = llvm.or %3, %4 : i32
  %6 = llvm.trunc %5 : i32 to i16
  "llvm.return"(%6) : (i16) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg3 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.mlir.constant(5 : i16) : i16
  %2 = llvm.lshr %arg3, %0 : i16
  %3 = llvm.mul %arg3, %1 : i16
  %4 = llvm.or %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
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


