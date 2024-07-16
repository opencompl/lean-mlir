import SSA.Projects.InstCombine.tests.LLVM.gnothadd_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM
open BitVec



open MLIR AST
open Std (BitVec)
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
                                                                       
def basic_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.add %1, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def basic_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem basic_proof : basic_before ⊑ basic_after := by
  unfold basic_before basic_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN basic
  apply basic_thm
  ---END basic



def basic_com_add_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg1, %0 : i8
  %2 = llvm.add %arg0, %1 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def basic_com_add_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.sub %arg1, %arg0 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem basic_com_add_proof : basic_com_add_before ⊑ basic_com_add_after := by
  unfold basic_com_add_before basic_com_add_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN basic_com_add
  apply basic_com_add_thm
  ---END basic_com_add



def basic_preserve_nsw_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.add %1, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def basic_preserve_nsw_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem basic_preserve_nsw_proof : basic_preserve_nsw_before ⊑ basic_preserve_nsw_after := by
  unfold basic_preserve_nsw_before basic_preserve_nsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN basic_preserve_nsw
  apply basic_preserve_nsw_thm
  ---END basic_preserve_nsw



def basic_preserve_nuw_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.add %1, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def basic_preserve_nuw_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem basic_preserve_nuw_proof : basic_preserve_nuw_before ⊑ basic_preserve_nuw_after := by
  unfold basic_preserve_nuw_before basic_preserve_nuw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN basic_preserve_nuw
  apply basic_preserve_nuw_thm
  ---END basic_preserve_nuw



def basic_preserve_nuw_nsw_before := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = "llvm.mlir.constant"() <{value = -1 : i8}> : () -> i8
  %1 = llvm.xor %arg0, %0 : i8
  %2 = llvm.add %1, %arg1 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def basic_preserve_nuw_nsw_after := [llvm|
{
^0(%arg0 : i8, %arg1 : i8):
  %0 = llvm.sub %arg0, %arg1 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
theorem basic_preserve_nuw_nsw_proof : basic_preserve_nuw_nsw_before ⊑ basic_preserve_nuw_nsw_after := by
  unfold basic_preserve_nuw_nsw_before basic_preserve_nuw_nsw_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  try alive_auto
  ---BEGIN basic_preserve_nuw_nsw
  apply basic_preserve_nuw_nsw_thm
  ---END basic_preserve_nuw_nsw


