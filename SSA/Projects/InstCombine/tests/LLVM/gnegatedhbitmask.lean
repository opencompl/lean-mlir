
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
section gnegatedhbitmask_statements

def neg_mask1_lshr_before := [llvm|
{
^0(%arg22 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.lshr %arg22, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.sub %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def neg_mask1_lshr_after := [llvm|
{
^0(%arg22 : i8):
  %0 = llvm.mlir.constant(4 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.shl %arg22, %0 : i8
  %3 = llvm.ashr %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem neg_mask1_lshr_proof : neg_mask1_lshr_before ⊑ neg_mask1_lshr_after := by
  unfold neg_mask1_lshr_before neg_mask1_lshr_after
  simp_alive_peephole
  ---BEGIN neg_mask1_lshr
  all_goals (try extract_goal ; sorry)
  ---END neg_mask1_lshr



def sub_mask1_lshr_before := [llvm|
{
^0(%arg21 : i8):
  %0 = llvm.mlir.constant(1 : i8) : i8
  %1 = llvm.mlir.constant(10 : i8) : i8
  %2 = llvm.lshr %arg21, %0 : i8
  %3 = llvm.and %2, %0 : i8
  %4 = llvm.sub %1, %3 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def sub_mask1_lshr_after := [llvm|
{
^0(%arg21 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.mlir.constant(10 : i8) : i8
  %3 = llvm.shl %arg21, %0 : i8
  %4 = llvm.ashr %3, %1 : i8
  %5 = llvm.add %4, %2 overflow<nsw> : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem sub_mask1_lshr_proof : sub_mask1_lshr_before ⊑ sub_mask1_lshr_after := by
  unfold sub_mask1_lshr_before sub_mask1_lshr_after
  simp_alive_peephole
  ---BEGIN sub_mask1_lshr
  all_goals (try extract_goal ; sorry)
  ---END sub_mask1_lshr



def sub_mask1_trunc_lshr_before := [llvm|
{
^0(%arg17 : i64):
  %0 = llvm.mlir.constant(15) : i64
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(10 : i8) : i8
  %3 = llvm.lshr %arg17, %0 : i64
  %4 = llvm.trunc %3 : i64 to i8
  %5 = llvm.and %4, %1 : i8
  %6 = llvm.sub %2, %5 : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
def sub_mask1_trunc_lshr_after := [llvm|
{
^0(%arg17 : i64):
  %0 = llvm.mlir.constant(48) : i64
  %1 = llvm.mlir.constant(63) : i64
  %2 = llvm.mlir.constant(10 : i8) : i8
  %3 = llvm.shl %arg17, %0 : i64
  %4 = llvm.ashr %3, %1 : i64
  %5 = llvm.trunc %4 : i64 to i8
  %6 = llvm.add %5, %2 overflow<nsw> : i8
  "llvm.return"(%6) : (i8) -> ()
}
]
theorem sub_mask1_trunc_lshr_proof : sub_mask1_trunc_lshr_before ⊑ sub_mask1_trunc_lshr_after := by
  unfold sub_mask1_trunc_lshr_before sub_mask1_trunc_lshr_after
  simp_alive_peephole
  ---BEGIN sub_mask1_trunc_lshr
  all_goals (try extract_goal ; sorry)
  ---END sub_mask1_trunc_lshr



def sub_sext_mask1_trunc_lshr_before := [llvm|
{
^0(%arg16 : i64):
  %0 = llvm.mlir.constant(15) : i64
  %1 = llvm.mlir.constant(1 : i8) : i8
  %2 = llvm.mlir.constant(10 : i32) : i32
  %3 = llvm.lshr %arg16, %0 : i64
  %4 = llvm.trunc %3 : i64 to i8
  %5 = llvm.and %4, %1 : i8
  %6 = llvm.sext %5 : i8 to i32
  %7 = llvm.sub %2, %6 : i32
  "llvm.return"(%7) : (i32) -> ()
}
]
def sub_sext_mask1_trunc_lshr_after := [llvm|
{
^0(%arg16 : i64):
  %0 = llvm.mlir.constant(48) : i64
  %1 = llvm.mlir.constant(63) : i64
  %2 = llvm.mlir.constant(10 : i8) : i8
  %3 = llvm.shl %arg16, %0 : i64
  %4 = llvm.ashr %3, %1 : i64
  %5 = llvm.trunc %4 : i64 to i8
  %6 = llvm.add %5, %2 overflow<nsw> : i8
  %7 = llvm.zext %6 : i8 to i32
  "llvm.return"(%7) : (i32) -> ()
}
]
theorem sub_sext_mask1_trunc_lshr_proof : sub_sext_mask1_trunc_lshr_before ⊑ sub_sext_mask1_trunc_lshr_after := by
  unfold sub_sext_mask1_trunc_lshr_before sub_sext_mask1_trunc_lshr_after
  simp_alive_peephole
  ---BEGIN sub_sext_mask1_trunc_lshr
  all_goals (try extract_goal ; sorry)
  ---END sub_sext_mask1_trunc_lshr



def sub_zext_trunc_lshr_before := [llvm|
{
^0(%arg15 : i64):
  %0 = llvm.mlir.constant(15) : i64
  %1 = llvm.mlir.constant(10 : i32) : i32
  %2 = llvm.lshr %arg15, %0 : i64
  %3 = llvm.trunc %2 : i64 to i1
  %4 = llvm.zext %3 : i1 to i32
  %5 = llvm.sub %1, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def sub_zext_trunc_lshr_after := [llvm|
{
^0(%arg15 : i64):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.mlir.constant(10 : i32) : i32
  %3 = llvm.trunc %arg15 : i64 to i32
  %4 = llvm.shl %3, %0 : i32
  %5 = llvm.ashr %4, %1 : i32
  %6 = llvm.add %5, %2 overflow<nsw> : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem sub_zext_trunc_lshr_proof : sub_zext_trunc_lshr_before ⊑ sub_zext_trunc_lshr_after := by
  unfold sub_zext_trunc_lshr_before sub_zext_trunc_lshr_after
  simp_alive_peephole
  ---BEGIN sub_zext_trunc_lshr
  all_goals (try extract_goal ; sorry)
  ---END sub_zext_trunc_lshr



def neg_mask2_lshr_before := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.lshr %arg14, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.sub %2, %4 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def neg_mask2_lshr_after := [llvm|
{
^0(%arg14 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(2 : i8) : i8
  %2 = llvm.mlir.constant(0 : i8) : i8
  %3 = llvm.lshr %arg14, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.sub %2, %4 overflow<nsw> : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
theorem neg_mask2_lshr_proof : neg_mask2_lshr_before ⊑ neg_mask2_lshr_after := by
  unfold neg_mask2_lshr_before neg_mask2_lshr_after
  simp_alive_peephole
  ---BEGIN neg_mask2_lshr
  all_goals (try extract_goal ; sorry)
  ---END neg_mask2_lshr



def neg_signbit_before := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg8, %0 : i8
  %3 = llvm.zext %2 : i8 to i32
  %4 = llvm.sub %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def neg_signbit_after := [llvm|
{
^0(%arg8 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.ashr %arg8, %0 : i8
  %2 = llvm.sext %1 : i8 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem neg_signbit_proof : neg_signbit_before ⊑ neg_signbit_after := by
  unfold neg_signbit_before neg_signbit_after
  simp_alive_peephole
  ---BEGIN neg_signbit
  all_goals (try extract_goal ; sorry)
  ---END neg_signbit



def neg_not_signbit2_before := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg4, %0 : i8
  %3 = llvm.zext %2 : i8 to i32
  %4 = llvm.sub %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def neg_not_signbit2_after := [llvm|
{
^0(%arg4 : i8):
  %0 = llvm.mlir.constant(6 : i8) : i8
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg4, %0 : i8
  %3 = llvm.zext %2 : i8 to i32
  %4 = llvm.sub %1, %3 overflow<nsw> : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem neg_not_signbit2_proof : neg_not_signbit2_before ⊑ neg_not_signbit2_after := by
  unfold neg_not_signbit2_before neg_not_signbit2_after
  simp_alive_peephole
  ---BEGIN neg_not_signbit2
  all_goals (try extract_goal ; sorry)
  ---END neg_not_signbit2



def neg_not_signbit3_before := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.ashr %arg3, %0 : i8
  %3 = llvm.zext %2 : i8 to i32
  %4 = llvm.sub %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def neg_not_signbit3_after := [llvm|
{
^0(%arg3 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.ashr %arg3, %0 : i8
  %3 = llvm.zext %2 : i8 to i32
  %4 = llvm.sub %1, %3 overflow<nsw> : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem neg_not_signbit3_proof : neg_not_signbit3_before ⊑ neg_not_signbit3_after := by
  unfold neg_not_signbit3_before neg_not_signbit3_after
  simp_alive_peephole
  ---BEGIN neg_not_signbit3
  all_goals (try extract_goal ; sorry)
  ---END neg_not_signbit3


