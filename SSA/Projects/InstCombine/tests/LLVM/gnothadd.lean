
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
section gnothadd_statements

def basic_before := [llvm|
{
^0(%arg25 : i8, %arg26 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg25, %0 : i8
  %2 = llvm.add %1, %arg26 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def basic_after := [llvm|
{
^0(%arg25 : i8, %arg26 : i8):
  %0 = llvm.sub %arg25, %arg26 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem basic_proof : basic_before ⊑ basic_after := by
  unfold basic_before basic_after
  simp_alive_peephole
  intros
  ---BEGIN basic
  all_goals (try extract_goal ; sorry)
  ---END basic



def basic_com_add_before := [llvm|
{
^0(%arg23 : i8, %arg24 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg24, %0 : i8
  %2 = llvm.add %arg23, %1 : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def basic_com_add_after := [llvm|
{
^0(%arg23 : i8, %arg24 : i8):
  %0 = llvm.sub %arg24, %arg23 : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem basic_com_add_proof : basic_com_add_before ⊑ basic_com_add_after := by
  unfold basic_com_add_before basic_com_add_after
  simp_alive_peephole
  intros
  ---BEGIN basic_com_add
  all_goals (try extract_goal ; sorry)
  ---END basic_com_add



def basic_preserve_nsw_before := [llvm|
{
^0(%arg15 : i8, %arg16 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg15, %0 : i8
  %2 = llvm.add %1, %arg16 overflow<nsw> : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def basic_preserve_nsw_after := [llvm|
{
^0(%arg15 : i8, %arg16 : i8):
  %0 = llvm.sub %arg15, %arg16 overflow<nsw> : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem basic_preserve_nsw_proof : basic_preserve_nsw_before ⊑ basic_preserve_nsw_after := by
  unfold basic_preserve_nsw_before basic_preserve_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN basic_preserve_nsw
  all_goals (try extract_goal ; sorry)
  ---END basic_preserve_nsw



def basic_preserve_nuw_before := [llvm|
{
^0(%arg13 : i8, %arg14 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg13, %0 : i8
  %2 = llvm.add %1, %arg14 overflow<nuw> : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def basic_preserve_nuw_after := [llvm|
{
^0(%arg13 : i8, %arg14 : i8):
  %0 = llvm.sub %arg13, %arg14 overflow<nuw> : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem basic_preserve_nuw_proof : basic_preserve_nuw_before ⊑ basic_preserve_nuw_after := by
  unfold basic_preserve_nuw_before basic_preserve_nuw_after
  simp_alive_peephole
  intros
  ---BEGIN basic_preserve_nuw
  all_goals (try extract_goal ; sorry)
  ---END basic_preserve_nuw



def basic_preserve_nuw_nsw_before := [llvm|
{
^0(%arg11 : i8, %arg12 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.xor %arg11, %0 : i8
  %2 = llvm.add %1, %arg12 overflow<nsw,nuw> : i8
  %3 = llvm.xor %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def basic_preserve_nuw_nsw_after := [llvm|
{
^0(%arg11 : i8, %arg12 : i8):
  %0 = llvm.sub %arg11, %arg12 overflow<nsw,nuw> : i8
  "llvm.return"(%0) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem basic_preserve_nuw_nsw_proof : basic_preserve_nuw_nsw_before ⊑ basic_preserve_nuw_nsw_after := by
  unfold basic_preserve_nuw_nsw_before basic_preserve_nuw_nsw_after
  simp_alive_peephole
  intros
  ---BEGIN basic_preserve_nuw_nsw
  all_goals (try extract_goal ; sorry)
  ---END basic_preserve_nuw_nsw


