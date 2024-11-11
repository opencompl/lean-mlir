import SSA.Projects.InstCombine.tests.proofs.gshifthsra_proof
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
section gshifthsra_statements

def test1_before := [llvm|
{
^0(%arg19 : i32, %arg20 : i8):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.zext %arg20 : i8 to i32
  %2 = llvm.ashr %arg19, %1 : i32
  %3 = llvm.and %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg19 : i32, %arg20 : i8):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.zext nneg %arg20 : i8 to i32
  %2 = llvm.lshr %arg19, %1 : i32
  %3 = llvm.and %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  apply test1_thm
  ---END test1



def test2_before := [llvm|
{
^0(%arg18 : i8):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.zext %arg18 : i8 to i32
  %3 = llvm.add %2, %0 : i32
  %4 = llvm.ashr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg18 : i8):
  %0 = llvm.mlir.constant(7 : i32) : i32
  %1 = llvm.mlir.constant(3 : i32) : i32
  %2 = llvm.zext %arg18 : i8 to i32
  %3 = llvm.add %2, %0 overflow<nsw,nuw> : i32
  %4 = llvm.lshr %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  intros
  ---BEGIN test2
  apply test2_thm
  ---END test2



def ashr_ashr_before := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(7 : i32) : i32
  %2 = llvm.ashr %arg7, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_ashr_after := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(12 : i32) : i32
  %1 = llvm.ashr %arg7, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_ashr_proof : ashr_ashr_before ⊑ ashr_ashr_after := by
  unfold ashr_ashr_before ashr_ashr_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_ashr
  apply ashr_ashr_thm
  ---END ashr_ashr



def ashr_overshift_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(17 : i32) : i32
  %2 = llvm.ashr %arg6, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def ashr_overshift_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.ashr %arg6, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_overshift_proof : ashr_overshift_before ⊑ ashr_overshift_after := by
  unfold ashr_overshift_before ashr_overshift_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_overshift
  apply ashr_overshift_thm
  ---END ashr_overshift



def hoist_ashr_ahead_of_sext_1_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(3 : i32) : i32
  %1 = llvm.sext %arg3 : i8 to i32
  %2 = llvm.ashr %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def hoist_ashr_ahead_of_sext_1_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.ashr %arg3, %0 : i8
  %2 = llvm.sext %1 : i8 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem hoist_ashr_ahead_of_sext_1_proof : hoist_ashr_ahead_of_sext_1_before ⊑ hoist_ashr_ahead_of_sext_1_after := by
  unfold hoist_ashr_ahead_of_sext_1_before hoist_ashr_ahead_of_sext_1_after
  simp_alive_peephole
  intros
  ---BEGIN hoist_ashr_ahead_of_sext_1
  apply hoist_ashr_ahead_of_sext_1_thm
  ---END hoist_ashr_ahead_of_sext_1



def hoist_ashr_ahead_of_sext_2_before := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.sext %arg1 : i8 to i32
  %2 = llvm.ashr %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def hoist_ashr_ahead_of_sext_2_after := [llvm|
{
^0(%arg1 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.ashr %arg1, %0 : i8
  %2 = llvm.sext %1 : i8 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem hoist_ashr_ahead_of_sext_2_proof : hoist_ashr_ahead_of_sext_2_before ⊑ hoist_ashr_ahead_of_sext_2_after := by
  unfold hoist_ashr_ahead_of_sext_2_before hoist_ashr_ahead_of_sext_2_after
  simp_alive_peephole
  intros
  ---BEGIN hoist_ashr_ahead_of_sext_2
  apply hoist_ashr_ahead_of_sext_2_thm
  ---END hoist_ashr_ahead_of_sext_2


