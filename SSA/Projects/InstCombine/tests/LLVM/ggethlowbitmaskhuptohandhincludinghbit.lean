
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
section ggethlowbitmaskhuptohandhincludinghbit_statements
                                                    
def t0_before := [llvm|
{
^0(%arg18 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg18 : i8
  %3 = llvm.add %2, %1 : i8
  %4 = llvm.or %3, %2 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg18 : i8):
  %0 = "llvm.mlir.constant"() <{value = 7 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.sub %0, %arg18 : i8
  %3 = llvm.lshr %1, %2 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN t0
  all_goals (try extract_goal ; sorry)
  ---END t0



def t1_before := [llvm|
{
^0(%arg17 : i16):
  %0 = "llvm.mlir.constant"() <{value = 1 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = -1 : i16}> : () -> i16
  %2 = llvm.shl %0, %arg17 : i16
  %3 = llvm.add %2, %1 : i16
  %4 = llvm.or %3, %2 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def t1_after := [llvm|
{
^0(%arg17 : i16):
  %0 = "llvm.mlir.constant"() <{value = 15 : i16}> : () -> i16
  %1 = "llvm.mlir.constant"() <{value = -1 : i16}> : () -> i16
  %2 = llvm.sub %0, %arg17 : i16
  %3 = llvm.lshr %1, %2 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
theorem t1_proof : t1_before ⊑ t1_after := by
  unfold t1_before t1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN t1
  all_goals (try extract_goal ; sorry)
  ---END t1



def t9_nocse_before := [llvm|
{
^0(%arg9 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg9 : i8
  %3 = llvm.shl %0, %arg9 : i8
  %4 = llvm.add %2, %1 : i8
  %5 = llvm.or %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def t9_nocse_after := [llvm|
{
^0(%arg9 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg9 overflow<nuw> : i8
  %3 = llvm.shl %1, %arg9 overflow<nsw> : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem t9_nocse_proof : t9_nocse_before ⊑ t9_nocse_after := by
  unfold t9_nocse_before t9_nocse_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN t9_nocse
  all_goals (try extract_goal ; sorry)
  ---END t9_nocse



def t17_nocse_mismatching_x_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg0 : i8
  %3 = llvm.shl %0, %arg1 : i8
  %4 = llvm.add %2, %1 : i8
  %5 = llvm.or %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def t17_nocse_mismatching_x_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %2 = llvm.shl %0, %arg1 overflow<nuw> : i8
  %3 = llvm.shl %1, %arg0 overflow<nsw> : i8
  %4 = llvm.xor %3, %1 : i8
  %5 = llvm.or %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem t17_nocse_mismatching_x_proof : t17_nocse_mismatching_x_before ⊑ t17_nocse_mismatching_x_after := by
  unfold t17_nocse_mismatching_x_before t17_nocse_mismatching_x_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN t17_nocse_mismatching_x
  all_goals (try extract_goal ; sorry)
  ---END t17_nocse_mismatching_x


