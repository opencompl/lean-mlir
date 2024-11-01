
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
section gpartallyhredundanthlefthshifthinputhmaskinghafterhtruncationhvarianthd_statements

def PR51351_before := [llvm|
{
^0(%arg0 : i64, %arg1 : i32):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.mlir.constant(-33 : i32) : i32
  %2 = llvm.zext %arg1 : i32 to i64
  %3 = llvm.shl %0, %2 : i64
  %4 = llvm.ashr %3, %2 : i64
  %5 = llvm.add %arg1, %1 : i32
  %6 = llvm.and %4, %arg0 : i64
  %7 = llvm.trunc %6 : i64 to i32
  %8 = llvm.shl %7, %5 : i32
  "llvm.return"(%8) : (i32) -> ()
}
]
def PR51351_after := [llvm|
{
^0(%arg0 : i64, %arg1 : i32):
  %0 = llvm.mlir.constant(-33 : i32) : i32
  %1 = llvm.add %arg1, %0 : i32
  %2 = llvm.trunc %arg0 : i64 to i32
  %3 = llvm.shl %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR51351_proof : PR51351_before ⊑ PR51351_after := by
  unfold PR51351_before PR51351_after
  simp_alive_peephole
  intros
  ---BEGIN PR51351
  all_goals (try extract_goal ; sorry)
  ---END PR51351


