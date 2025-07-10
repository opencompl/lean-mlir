import SSA.Projects.InstCombine.tests.proofs.gcasthmulhselect_proof
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
section gcasthmulhselect_statements

def mul_before := [llvm|
{
^0(%arg17 : i32, %arg18 : i32):
  %0 = llvm.trunc %arg17 : i32 to i8
  %1 = llvm.trunc %arg18 : i32 to i8
  %2 = llvm.mul %0, %1 : i8
  %3 = llvm.zext %2 : i8 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def mul_after := [llvm|
{
^0(%arg17 : i32, %arg18 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mul %arg17, %arg18 : i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem mul_proof : mul_before ⊑ mul_after := by
  unfold mul_before mul_after
  simp_alive_peephole
  intros
  ---BEGIN mul
  apply mul_thm
  ---END mul



def select1_before := [llvm|
{
^0(%arg13 : i1, %arg14 : i32, %arg15 : i32, %arg16 : i32):
  %0 = llvm.trunc %arg14 : i32 to i8
  %1 = llvm.trunc %arg15 : i32 to i8
  %2 = llvm.trunc %arg16 : i32 to i8
  %3 = llvm.add %0, %1 : i8
  %4 = "llvm.select"(%arg13, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %5 = llvm.zext %4 : i8 to i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def select1_after := [llvm|
{
^0(%arg13 : i1, %arg14 : i32, %arg15 : i32, %arg16 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.add %arg14, %arg15 : i32
  %2 = "llvm.select"(%arg13, %arg16, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = llvm.and %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select1_proof : select1_before ⊑ select1_after := by
  unfold select1_before select1_after
  simp_alive_peephole
  intros
  ---BEGIN select1
  apply select1_thm
  ---END select1



def select2_before := [llvm|
{
^0(%arg9 : i1, %arg10 : i8, %arg11 : i8, %arg12 : i8):
  %0 = llvm.zext %arg10 : i8 to i32
  %1 = llvm.zext %arg11 : i8 to i32
  %2 = llvm.zext %arg12 : i8 to i32
  %3 = llvm.add %0, %1 : i32
  %4 = "llvm.select"(%arg9, %2, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %5 = llvm.trunc %4 : i32 to i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def select2_after := [llvm|
{
^0(%arg9 : i1, %arg10 : i8, %arg11 : i8, %arg12 : i8):
  %0 = llvm.add %arg10, %arg11 : i8
  %1 = "llvm.select"(%arg9, %arg12, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%1) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem select2_proof : select2_before ⊑ select2_after := by
  unfold select2_before select2_after
  simp_alive_peephole
  intros
  ---BEGIN select2
  apply select2_thm
  ---END select2



def eval_zext_multi_use_in_one_inst_before := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(5 : i16) : i16
  %1 = llvm.trunc %arg7 : i32 to i16
  %2 = llvm.and %1, %0 : i16
  %3 = llvm.mul %2, %2 overflow<nsw,nuw> : i16
  %4 = llvm.zext %3 : i16 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def eval_zext_multi_use_in_one_inst_after := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(5 : i16) : i16
  %1 = llvm.trunc %arg7 : i32 to i16
  %2 = llvm.and %1, %0 : i16
  %3 = llvm.mul %2, %2 overflow<nsw,nuw> : i16
  %4 = llvm.zext nneg %3 : i16 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eval_zext_multi_use_in_one_inst_proof : eval_zext_multi_use_in_one_inst_before ⊑ eval_zext_multi_use_in_one_inst_after := by
  unfold eval_zext_multi_use_in_one_inst_before eval_zext_multi_use_in_one_inst_after
  simp_alive_peephole
  intros
  ---BEGIN eval_zext_multi_use_in_one_inst
  apply eval_zext_multi_use_in_one_inst_thm
  ---END eval_zext_multi_use_in_one_inst



def eval_sext_multi_use_in_one_inst_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(14 : i16) : i16
  %1 = llvm.mlir.constant(-32768 : i16) : i16
  %2 = llvm.trunc %arg6 : i32 to i16
  %3 = llvm.and %2, %0 : i16
  %4 = llvm.mul %3, %3 overflow<nsw,nuw> : i16
  %5 = llvm.or %4, %1 : i16
  %6 = llvm.sext %5 : i16 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def eval_sext_multi_use_in_one_inst_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(14 : i16) : i16
  %1 = llvm.mlir.constant(-32768 : i16) : i16
  %2 = llvm.trunc %arg6 : i32 to i16
  %3 = llvm.and %2, %0 : i16
  %4 = llvm.mul %3, %3 overflow<nsw,nuw> : i16
  %5 = llvm.or disjoint %4, %1 : i16
  %6 = llvm.sext %5 : i16 to i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem eval_sext_multi_use_in_one_inst_proof : eval_sext_multi_use_in_one_inst_before ⊑ eval_sext_multi_use_in_one_inst_after := by
  unfold eval_sext_multi_use_in_one_inst_before eval_sext_multi_use_in_one_inst_after
  simp_alive_peephole
  intros
  ---BEGIN eval_sext_multi_use_in_one_inst
  apply eval_sext_multi_use_in_one_inst_thm
  ---END eval_sext_multi_use_in_one_inst



def foo_before := [llvm|
{
^0(%arg0 : i1):
  %0 = llvm.zext %arg0 : i1 to i8
  "llvm.return"(%arg0) : (i1) -> ()
}
]
def foo_after := [llvm|
{
^0(%arg0 : i1):
  "llvm.return"(%arg0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem foo_proof : foo_before ⊑ foo_after := by
  unfold foo_before foo_after
  simp_alive_peephole
  intros
  ---BEGIN foo
  apply foo_thm
  ---END foo


