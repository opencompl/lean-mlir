import SSA.Projects.InstCombine.tests.proofs.goperandhcomplexity_proof
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
section goperandhcomplexity_statements

def neg_before := [llvm|
{
^0(%arg10 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.udiv %arg10, %0 : i8
  %3 = llvm.sub %1, %arg10 : i8
  %4 = llvm.xor %3, %2 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def neg_after := [llvm|
{
^0(%arg10 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.udiv %arg10, %0 : i8
  %3 = llvm.sub %1, %arg10 : i8
  %4 = llvm.xor %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem neg_proof : neg_before ⊑ neg_after := by
  unfold neg_before neg_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN neg
  apply neg_thm
  ---END neg



def not_before := [llvm|
{
^0(%arg7 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.udiv %arg7, %0 : i8
  %3 = llvm.xor %1, %arg7 : i8
  %4 = llvm.mul %3, %2 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def not_after := [llvm|
{
^0(%arg7 : i8):
  %0 = "llvm.mlir.constant"() <{value = 42 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.udiv %arg7, %0 : i8
  %3 = llvm.xor %arg7, %1 : i8
  %4 = llvm.mul %2, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem not_proof : not_before ⊑ not_after := by
  unfold not_before not_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN not
  apply not_thm
  ---END not


