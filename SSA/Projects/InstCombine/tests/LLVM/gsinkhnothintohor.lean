
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
section gsinkhnothintohor_statements

def t0_before := [llvm|
{
^0(%arg42 : i32, %arg43 : i32, %arg44 : i32, %arg45 : i32):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.icmp "eq" %arg42, %arg43 : i32
  %2 = llvm.icmp "eq" %arg44, %arg45 : i32
  %3 = llvm.or %2, %1 : i1
  %4 = llvm.xor %3, %0 : i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg42 : i32, %arg43 : i32, %arg44 : i32, %arg45 : i32):
  %0 = llvm.icmp "ne" %arg42, %arg43 : i32
  %1 = llvm.icmp "ne" %arg44, %arg45 : i32
  %2 = llvm.and %1, %0 : i1
  "llvm.return"(%2) : (i1) -> ()
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


