import SSA.Projects.InstCombine.tests.proofs.glshrhtrunchsexthtohashrhsext_proof
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
section glshrhtrunchsexthtohashrhsext_statements

def t0_before := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.lshr %arg17, %0 : i8
  %2 = llvm.trunc %1 : i8 to i4
  %3 = llvm.sext %2 : i4 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg17 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.ashr %arg17, %0 : i8
  %2 = llvm.sext %1 : i8 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  intros
  ---BEGIN t0
  apply t0_thm
  ---END t0



def t1_before := [llvm|
{
^0(%arg16 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.lshr %arg16, %0 : i8
  %2 = llvm.trunc %1 : i8 to i3
  %3 = llvm.sext %2 : i3 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def t1_after := [llvm|
{
^0(%arg16 : i8):
  %0 = llvm.mlir.constant(5 : i8) : i8
  %1 = llvm.ashr %arg16, %0 : i8
  %2 = llvm.sext %1 : i8 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t1_proof : t1_before ⊑ t1_after := by
  unfold t1_before t1_after
  simp_alive_peephole
  intros
  ---BEGIN t1
  apply t1_thm
  ---END t1



def t2_before := [llvm|
{
^0(%arg15 : i7):
  %0 = llvm.mlir.constant(3 : i7) : i7
  %1 = llvm.lshr %arg15, %0 : i7
  %2 = llvm.trunc %1 : i7 to i4
  %3 = llvm.sext %2 : i4 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def t2_after := [llvm|
{
^0(%arg15 : i7):
  %0 = llvm.mlir.constant(3 : i7) : i7
  %1 = llvm.ashr %arg15, %0 : i7
  %2 = llvm.sext %1 : i7 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem t2_proof : t2_before ⊑ t2_after := by
  unfold t2_before t2_after
  simp_alive_peephole
  intros
  ---BEGIN t2
  apply t2_thm
  ---END t2



def same_source_shifted_signbit_before := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.lshr %arg2, %0 : i32
  %2 = llvm.trunc %1 : i32 to i8
  %3 = llvm.sext %2 : i8 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def same_source_shifted_signbit_after := [llvm|
{
^0(%arg2 : i32):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.ashr %arg2, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem same_source_shifted_signbit_proof : same_source_shifted_signbit_before ⊑ same_source_shifted_signbit_after := by
  unfold same_source_shifted_signbit_before same_source_shifted_signbit_after
  simp_alive_peephole
  intros
  ---BEGIN same_source_shifted_signbit
  apply same_source_shifted_signbit_thm
  ---END same_source_shifted_signbit


