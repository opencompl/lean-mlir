
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
section gselecthimmhcanon_statements

def thisdoesnotloop_before := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(-128 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.icmp "slt" %arg6, %0 : i32
  %3 = "llvm.select"(%2, %1, %arg7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %4 = llvm.trunc %3 : i32 to i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def thisdoesnotloop_after := [llvm|
{
^0(%arg6 : i32, %arg7 : i32):
  %0 = llvm.mlir.constant(-128 : i32) : i32
  %1 = llvm.mlir.constant(-128 : i8) : i8
  %2 = llvm.icmp "slt" %arg6, %0 : i32
  %3 = llvm.trunc %arg7 : i32 to i8
  %4 = "llvm.select"(%2, %1, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem thisdoesnotloop_proof : thisdoesnotloop_before ⊑ thisdoesnotloop_after := by
  unfold thisdoesnotloop_before thisdoesnotloop_after
  simp_alive_peephole
  intros
  ---BEGIN thisdoesnotloop
  all_goals (try extract_goal ; sorry)
  ---END thisdoesnotloop


