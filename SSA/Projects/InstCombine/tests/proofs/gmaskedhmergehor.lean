import SSA.Projects.InstCombine.tests.proofs.gmaskedhmergehor_proof
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
section gmaskedhmergehor_statements

def n3_constmask_samemask_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65280 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = llvm.or %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def n3_constmask_samemask_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65280 : i32}> : () -> i32
  %1 = llvm.or %arg0, %arg1 : i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem n3_constmask_samemask_proof : n3_constmask_samemask_before ⊑ n3_constmask_samemask_after := by
  unfold n3_constmask_samemask_before n3_constmask_samemask_after
  simp_alive_peephole
  ---BEGIN n3_constmask_samemask
  apply n3_constmask_samemask_thm
  ---END n3_constmask_samemask


