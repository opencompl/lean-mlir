import SSA.Projects.InstCombine.tests.proofs.glowhbithsplat_proof
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
section glowhbithsplat_statements
                                                    
def t0_before := [llvm|
{
^0(%arg12 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = llvm.shl %arg12, %0 : i8
  %2 = llvm.ashr %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg12 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %2 = llvm.and %arg12, %0 : i8
  %3 = llvm.sub %1, %2 overflow<nsw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN t0
  apply t0_thm
  ---END t0



def t1_otherbitwidth_before := [llvm|
{
^0(%arg11 : i16):
  %0 = "llvm.mlir.constant"() <{value = 15 : i16}> : () -> i16
  %1 = llvm.shl %arg11, %0 : i16
  %2 = llvm.ashr %1, %0 : i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def t1_otherbitwidth_after := [llvm|
{
^0(%arg11 : i16):
  %0 = "llvm.mlir.constant"() <{value = 1 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = 0 : i16}> : () -> i16
  %2 = llvm.and %arg11, %0 : i16
  %3 = llvm.sub %1, %2 overflow<nsw> : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
theorem t1_otherbitwidth_proof : t1_otherbitwidth_before ⊑ t1_otherbitwidth_after := by
  unfold t1_otherbitwidth_before t1_otherbitwidth_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN t1_otherbitwidth
  apply t1_otherbitwidth_thm
  ---END t1_otherbitwidth


