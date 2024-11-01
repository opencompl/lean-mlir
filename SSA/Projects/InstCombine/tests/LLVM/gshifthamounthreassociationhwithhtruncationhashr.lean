
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
section gshifthamounthreassociationhwithhtruncationhashr_statements

def t0_before := [llvm|
{
^0(%arg18 : i32, %arg19 : i16):
  %0 = llvm.mlir.constant(32 : i16) : i16
  %1 = llvm.mlir.constant(-1 : i16) : i16
  %2 = llvm.sub %0, %arg19 : i16
  %3 = llvm.zext %2 : i16 to i32
  %4 = llvm.ashr %arg18, %3 : i32
  %5 = llvm.trunc %4 : i32 to i16
  %6 = llvm.add %arg19, %1 : i16
  %7 = llvm.ashr %5, %6 : i16
  "llvm.return"(%7) : (i16) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg18 : i32, %arg19 : i16):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.ashr %arg18, %0 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  intros
  ---BEGIN t0
  all_goals (try extract_goal ; sorry)
  ---END t0


