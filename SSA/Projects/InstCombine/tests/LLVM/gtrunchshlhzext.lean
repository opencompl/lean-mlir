
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
section gtrunchshlhzext_statements

def trunc_shl_zext_32_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(4 : i16) : i16
  %1 = llvm.trunc %arg1 : i32 to i16
  %2 = llvm.shl %1, %0 : i16
  %3 = llvm.zext %2 : i16 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def trunc_shl_zext_32_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(4 : i32) : i32
  %1 = llvm.mlir.constant(65520 : i32) : i32
  %2 = llvm.shl %arg1, %0 : i32
  %3 = llvm.and %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_zext_32_proof : trunc_shl_zext_32_before ⊑ trunc_shl_zext_32_after := by
  unfold trunc_shl_zext_32_before trunc_shl_zext_32_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_zext_32
  all_goals (try extract_goal ; sorry)
  ---END trunc_shl_zext_32



def trunc_shl_zext_64_before := [llvm|
{
^0(%arg0 : i64):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.trunc %arg0 : i64 to i8
  %2 = llvm.shl %1, %0 : i8
  %3 = llvm.zext %2 : i8 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def trunc_shl_zext_64_after := [llvm|
{
^0(%arg0 : i64):
  %0 = llvm.mlir.constant(7) : i64
  %1 = llvm.mlir.constant(128) : i64
  %2 = llvm.shl %arg0, %0 : i64
  %3 = llvm.and %2, %1 : i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_shl_zext_64_proof : trunc_shl_zext_64_before ⊑ trunc_shl_zext_64_after := by
  unfold trunc_shl_zext_64_before trunc_shl_zext_64_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_shl_zext_64
  all_goals (try extract_goal ; sorry)
  ---END trunc_shl_zext_64


