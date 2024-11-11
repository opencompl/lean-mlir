
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
section gandhnarrow_statements

def zext_add_before := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(44 : i16) : i16
  %1 = llvm.zext %arg15 : i8 to i16
  %2 = llvm.add %1, %0 : i16
  %3 = llvm.and %2, %1 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def zext_add_after := [llvm|
{
^0(%arg15 : i8):
  %0 = llvm.mlir.constant(44 : i8) : i8
  %1 = llvm.add %arg15, %0 : i8
  %2 = llvm.and %1, %arg15 : i8
  %3 = llvm.zext %2 : i8 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_add_proof : zext_add_before ⊑ zext_add_after := by
  unfold zext_add_before zext_add_after
  simp_alive_peephole
  intros
  ---BEGIN zext_add
  all_goals (try extract_goal ; sorry)
  ---END zext_add



def zext_sub_before := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(-5 : i16) : i16
  %1 = llvm.zext %arg14 : i8 to i16
  %2 = llvm.sub %0, %1 : i16
  %3 = llvm.and %2, %1 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def zext_sub_after := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(-5 : i8) : i8
  %1 = llvm.sub %0, %arg14 : i8
  %2 = llvm.and %1, %arg14 : i8
  %3 = llvm.zext %2 : i8 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_sub_proof : zext_sub_before ⊑ zext_sub_after := by
  unfold zext_sub_before zext_sub_after
  simp_alive_peephole
  intros
  ---BEGIN zext_sub
  all_goals (try extract_goal ; sorry)
  ---END zext_sub



def zext_mul_before := [llvm|
{
^0(%arg13 : i8):
  %0 = llvm.mlir.constant(3 : i16) : i16
  %1 = llvm.zext %arg13 : i8 to i16
  %2 = llvm.mul %1, %0 : i16
  %3 = llvm.and %2, %1 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def zext_mul_after := [llvm|
{
^0(%arg13 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mul %arg13, %0 : i8
  %2 = llvm.and %1, %arg13 : i8
  %3 = llvm.zext %2 : i8 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_mul_proof : zext_mul_before ⊑ zext_mul_after := by
  unfold zext_mul_before zext_mul_after
  simp_alive_peephole
  intros
  ---BEGIN zext_mul
  all_goals (try extract_goal ; sorry)
  ---END zext_mul



def zext_lshr_before := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(4 : i16) : i16
  %1 = llvm.zext %arg12 : i8 to i16
  %2 = llvm.lshr %1, %0 : i16
  %3 = llvm.and %2, %1 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def zext_lshr_after := [llvm|
{
^0(%arg12 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.lshr %arg12, %0 : i8
  %2 = llvm.and %1, %arg12 : i8
  %3 = llvm.zext nneg %2 : i8 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_lshr_proof : zext_lshr_before ⊑ zext_lshr_after := by
  unfold zext_lshr_before zext_lshr_after
  simp_alive_peephole
  intros
  ---BEGIN zext_lshr
  all_goals (try extract_goal ; sorry)
  ---END zext_lshr



def zext_ashr_before := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(2 : i16) : i16
  %1 = llvm.zext %arg11 : i8 to i16
  %2 = llvm.ashr %1, %0 : i16
  %3 = llvm.and %2, %1 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def zext_ashr_after := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(2 : i8) : i8
  %1 = llvm.lshr %arg11, %0 : i8
  %2 = llvm.and %1, %arg11 : i8
  %3 = llvm.zext nneg %2 : i8 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_ashr_proof : zext_ashr_before ⊑ zext_ashr_after := by
  unfold zext_ashr_before zext_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN zext_ashr
  all_goals (try extract_goal ; sorry)
  ---END zext_ashr



def zext_shl_before := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(3 : i16) : i16
  %1 = llvm.zext %arg10 : i8 to i16
  %2 = llvm.shl %1, %0 : i16
  %3 = llvm.and %2, %1 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def zext_shl_after := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.shl %arg10, %0 : i8
  %2 = llvm.and %1, %arg10 : i8
  %3 = llvm.zext %2 : i8 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_shl_proof : zext_shl_before ⊑ zext_shl_after := by
  unfold zext_shl_before zext_shl_after
  simp_alive_peephole
  intros
  ---BEGIN zext_shl
  all_goals (try extract_goal ; sorry)
  ---END zext_shl


