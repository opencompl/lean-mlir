import SSA.Projects.InstCombine.tests.LLVM.gsubhnot_proof
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
                                                                       
def sub_not_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.sub %arg0, %arg1 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def sub_not_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.add %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem sub_not_proof : sub_not_before ⊑ sub_not_after := by
  unfold sub_not_before sub_not_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sub_not
  apply sub_not_thm
  ---END sub_not



def dec_sub_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.sub %arg0, %arg1 : i8
  %2 = llvm.add %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def dec_sub_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.add %1, %arg0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem dec_sub_proof : dec_sub_before ⊑ dec_sub_after := by
  unfold dec_sub_before dec_sub_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN dec_sub
  apply dec_sub_thm
  ---END dec_sub



def sub_inc_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = llvm.sub %arg1, %1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def sub_inc_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.add %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem sub_inc_proof : sub_inc_before ⊑ sub_inc_after := by
  unfold sub_inc_before sub_inc_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sub_inc
  apply sub_inc_thm
  ---END sub_inc



def sub_dec_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.add %arg0, %0 : i8
  %2 = llvm.sub %1, %arg1 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def sub_dec_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.add %1, %arg0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem sub_dec_proof : sub_dec_before ⊑ sub_dec_after := by
  unfold sub_dec_before sub_dec_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN sub_dec
  apply sub_dec_thm
  ---END sub_dec


