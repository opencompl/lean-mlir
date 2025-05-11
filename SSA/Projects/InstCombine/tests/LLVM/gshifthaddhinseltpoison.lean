
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
section gshifthaddhinseltpoison_statements

def shl_C1_add_A_C2_i32_before := [llvm|
{
^0(%arg8 : i16):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(6 : i32) : i32
  %2 = llvm.zext %arg8 : i16 to i32
  %3 = llvm.add %2, %0 : i32
  %4 = llvm.shl %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def shl_C1_add_A_C2_i32_after := [llvm|
{
^0(%arg8 : i16):
  %0 = llvm.mlir.constant(192 : i32) : i32
  %1 = llvm.zext nneg %arg8 : i16 to i32
  %2 = llvm.shl %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem shl_C1_add_A_C2_i32_proof : shl_C1_add_A_C2_i32_before ⊑ shl_C1_add_A_C2_i32_after := by
  unfold shl_C1_add_A_C2_i32_before shl_C1_add_A_C2_i32_after
  simp_alive_peephole
  intros
  ---BEGIN shl_C1_add_A_C2_i32
  all_goals (try extract_goal ; sorry)
  ---END shl_C1_add_A_C2_i32



def ashr_C1_add_A_C2_i32_before := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = llvm.mlir.constant(6 : i32) : i32
  %3 = llvm.and %arg7, %0 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.ashr %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def ashr_C1_add_A_C2_i32_after := [llvm|
{
^0(%arg7 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_C1_add_A_C2_i32_proof : ashr_C1_add_A_C2_i32_before ⊑ ashr_C1_add_A_C2_i32_after := by
  unfold ashr_C1_add_A_C2_i32_before ashr_C1_add_A_C2_i32_after
  simp_alive_peephole
  intros
  ---BEGIN ashr_C1_add_A_C2_i32
  all_goals (try extract_goal ; sorry)
  ---END ashr_C1_add_A_C2_i32



def lshr_C1_add_A_C2_i32_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(5 : i32) : i32
  %2 = llvm.mlir.constant(6 : i32) : i32
  %3 = llvm.and %arg6, %0 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.shl %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def lshr_C1_add_A_C2_i32_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(192 : i32) : i32
  %2 = llvm.and %arg6, %0 : i32
  %3 = llvm.shl %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lshr_C1_add_A_C2_i32_proof : lshr_C1_add_A_C2_i32_before ⊑ lshr_C1_add_A_C2_i32_after := by
  unfold lshr_C1_add_A_C2_i32_before lshr_C1_add_A_C2_i32_after
  simp_alive_peephole
  intros
  ---BEGIN lshr_C1_add_A_C2_i32
  all_goals (try extract_goal ; sorry)
  ---END lshr_C1_add_A_C2_i32


