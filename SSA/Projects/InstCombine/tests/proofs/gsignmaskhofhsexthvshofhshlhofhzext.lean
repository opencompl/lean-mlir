import SSA.Projects.InstCombine.tests.proofs.gsignmaskhofhsexthvshofhshlhofhzext_proof
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
section gsignmaskhofhsexthvshofhshlhofhzext_statements

def t0_before := [llvm|
{
^0(%arg12 : i16):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.zext %arg12 : i16 to i32
  %3 = llvm.shl %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg12 : i16):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.sext %arg12 : i16 to i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
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
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.zext %arg11 : i8 to i32
  %3 = llvm.shl %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def t1_after := [llvm|
{
^0(%arg11 : i8):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.sext %arg11 : i8 to i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
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



def n2_before := [llvm|
{
^0(%arg10 : i16):
  %0 = llvm.mlir.constant(15 : i32) : i32
  %1 = llvm.mlir.constant(-2147483648 : i32) : i32
  %2 = llvm.zext %arg10 : i16 to i32
  %3 = llvm.shl %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def n2_after := [llvm|
{
^0(%arg10 : i16):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n2_proof : n2_before ⊑ n2_after := by
  unfold n2_before n2_after
  simp_alive_peephole
  intros
  ---BEGIN n2
  apply n2_thm
  ---END n2



def n4_before := [llvm|
{
^0(%arg8 : i16):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(-1073741824 : i32) : i32
  %2 = llvm.zext %arg8 : i16 to i32
  %3 = llvm.shl %2, %0 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def n4_after := [llvm|
{
^0(%arg8 : i16):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(-1073741824 : i32) : i32
  %2 = llvm.zext %arg8 : i16 to i32
  %3 = llvm.shl %2, %0 overflow<nuw> : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem n4_proof : n4_before ⊑ n4_after := by
  unfold n4_before n4_after
  simp_alive_peephole
  intros
  ---BEGIN n4
  apply n4_thm
  ---END n4


