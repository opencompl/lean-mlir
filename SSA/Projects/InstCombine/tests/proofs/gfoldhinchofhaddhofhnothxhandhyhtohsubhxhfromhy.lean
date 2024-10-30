import SSA.Projects.InstCombine.tests.proofs.gfoldhinchofhaddhofhnothxhandhyhtohsubhxhfromhy_proof
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
section gfoldhinchofhaddhofhnothxhandhyhtohsubhxhfromhy_statements

def t0_before := [llvm|
{
^0(%arg22 : i32, %arg23 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %2 = llvm.xor %arg22, %0 : i32
  %3 = llvm.add %2, %arg23 : i32
  %4 = llvm.add %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg22 : i32, %arg23 : i32):
  %0 = llvm.sub %arg23, %arg22 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  ---BEGIN t0
  apply t0_thm
  ---END t0


