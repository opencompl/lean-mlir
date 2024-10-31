
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
section gashrhdemand_statements

def srem2_ashr_mask_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.srem %arg6, %0 : i32
  %3 = llvm.ashr %2, %1 : i32
  %4 = llvm.and %3, %0 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def srem2_ashr_mask_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.srem %arg6, %0 : i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem srem2_ashr_mask_proof : srem2_ashr_mask_before ⊑ srem2_ashr_mask_after := by
  unfold srem2_ashr_mask_before srem2_ashr_mask_after
  simp_alive_peephole
  ---BEGIN srem2_ashr_mask
  all_goals (try extract_goal ; sorry)
  ---END srem2_ashr_mask



def ashr_can_be_lshr_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.ashr %arg1, %0 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
def ashr_can_be_lshr_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.lshr %arg1, %0 : i32
  %2 = llvm.trunc %1 : i32 to i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_can_be_lshr_proof : ashr_can_be_lshr_before ⊑ ashr_can_be_lshr_after := by
  unfold ashr_can_be_lshr_before ashr_can_be_lshr_after
  simp_alive_peephole
  ---BEGIN ashr_can_be_lshr
  all_goals (try extract_goal ; sorry)
  ---END ashr_can_be_lshr



def ashr_can_be_lshr_2_before := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(4278190080) : i64
  %1 = llvm.mlir.constant(34) : i64
  %2 = llvm.mlir.constant(32) : i64
  %3 = llvm.zext %arg0 : i32 to i64
  %4 = llvm.or %3, %0 : i64
  %5 = llvm.shl %4, %1 : i64
  %6 = llvm.ashr %5, %2 : i64
  %7 = llvm.trunc %6 : i64 to i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def ashr_can_be_lshr_2_after := [llvm|
{
^0(%arg0 : i32):
  %0 = llvm.mlir.constant(2 : i32) : i32
  %1 = llvm.mlir.constant(-67108864 : i32) : i32
  %2 = llvm.shl %arg0, %0 : i32
  %3 = llvm.or %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_can_be_lshr_2_proof : ashr_can_be_lshr_2_before ⊑ ashr_can_be_lshr_2_after := by
  unfold ashr_can_be_lshr_2_before ashr_can_be_lshr_2_after
  simp_alive_peephole
  ---BEGIN ashr_can_be_lshr_2
  all_goals (try extract_goal ; sorry)
  ---END ashr_can_be_lshr_2


