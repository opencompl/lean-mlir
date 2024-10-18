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
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN t0
  apply t0_thm
  ---END t0



def n12_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.add %2, %arg1 : i32
  %4 = llvm.add %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def n12_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{value = -1 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.xor %arg0, %0 : i32
  %3 = llvm.add %arg1, %2 : i32
  %4 = llvm.add %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem n12_proof : n12_before ⊑ n12_after := by
  unfold n12_before n12_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN n12
  apply n12_thm
  ---END n12


