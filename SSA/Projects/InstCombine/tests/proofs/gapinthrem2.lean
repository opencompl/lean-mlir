import SSA.Projects.InstCombine.tests.proofs.gapinthrem2_proof
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
section gapinthrem2_statements

def test1_before := [llvm|
{
^0(%arg3 : i333):
  %0 = "llvm.mlir.constant"() <{value = 70368744177664 : i333}> : () -> i333
  %1 = llvm.urem %arg3, %0 : i333
  "llvm.return"(%1) : (i333) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg3 : i333):
  %0 = "llvm.mlir.constant"() <{value = 70368744177663 : i333}> : () -> i333
  %1 = llvm.and %arg3, %0 : i333
  "llvm.return"(%1) : (i333) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test1
  apply test1_thm
  ---END test1



def test2_before := [llvm|
{
^0(%arg2 : i499):
  %0 = "llvm.mlir.constant"() <{value = 4096 : i499}> : () -> i499
  %1 = "llvm.mlir.constant"() <{value = 111 : i499}> : () -> i499
  %2 = llvm.shl %0, %1 : i499
  %3 = llvm.urem %arg2, %2 : i499
  "llvm.return"(%3) : (i499) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg2 : i499):
  %0 = "llvm.mlir.constant"() <{value = 10633823966279326983230456482242756607 : i499}> : () -> i499
  %1 = llvm.and %arg2, %0 : i499
  "llvm.return"(%1) : (i499) -> ()
}
]
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN test2
  apply test2_thm
  ---END test2


