
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
section gbswap_statements

def test1_trunc_before := [llvm|
{
^0(%arg53 : i32):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.mlir.constant(65280 : i32) : i32
  %3 = llvm.lshr %arg53, %0 : i32
  %4 = llvm.lshr %arg53, %1 : i32
  %5 = llvm.and %4, %2 : i32
  %6 = llvm.or %3, %5 : i32
  %7 = llvm.trunc %6 : i32 to i16
  "llvm.return"(%7) : (i16) -> ()
}
]
def test1_trunc_after := [llvm|
{
^0(%arg53 : i32):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.mlir.constant(65280 : i32) : i32
  %3 = llvm.lshr %arg53, %0 : i32
  %4 = llvm.lshr %arg53, %1 : i32
  %5 = llvm.and %4, %2 : i32
  %6 = llvm.or disjoint %3, %5 : i32
  %7 = llvm.trunc %6 overflow<nuw> : i32 to i16
  "llvm.return"(%7) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_trunc_proof : test1_trunc_before ⊑ test1_trunc_after := by
  unfold test1_trunc_before test1_trunc_after
  simp_alive_peephole
  intros
  ---BEGIN test1_trunc
  all_goals (try extract_goal ; sorry)
  ---END test1_trunc



def PR39793_bswap_u64_as_u16_trunc_before := [llvm|
{
^0(%arg27 : i64):
  %0 = llvm.mlir.constant(8) : i64
  %1 = llvm.mlir.constant(255) : i64
  %2 = llvm.mlir.constant(65280) : i64
  %3 = llvm.lshr %arg27, %0 : i64
  %4 = llvm.and %3, %1 : i64
  %5 = llvm.shl %arg27, %0 : i64
  %6 = llvm.and %5, %2 : i64
  %7 = llvm.or %4, %6 : i64
  %8 = llvm.trunc %7 : i64 to i8
  "llvm.return"(%8) : (i8) -> ()
}
]
def PR39793_bswap_u64_as_u16_trunc_after := [llvm|
{
^0(%arg27 : i64):
  %0 = llvm.mlir.constant(8) : i64
  %1 = llvm.lshr %arg27, %0 : i64
  %2 = llvm.trunc %1 : i64 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR39793_bswap_u64_as_u16_trunc_proof : PR39793_bswap_u64_as_u16_trunc_before ⊑ PR39793_bswap_u64_as_u16_trunc_after := by
  unfold PR39793_bswap_u64_as_u16_trunc_before PR39793_bswap_u64_as_u16_trunc_after
  simp_alive_peephole
  intros
  ---BEGIN PR39793_bswap_u64_as_u16_trunc
  all_goals (try extract_goal ; sorry)
  ---END PR39793_bswap_u64_as_u16_trunc



def PR39793_bswap_u32_as_u16_trunc_before := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.mlir.constant(255 : i32) : i32
  %2 = llvm.mlir.constant(65280 : i32) : i32
  %3 = llvm.lshr %arg24, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.shl %arg24, %0 : i32
  %6 = llvm.and %5, %2 : i32
  %7 = llvm.or %4, %6 : i32
  %8 = llvm.trunc %7 : i32 to i8
  "llvm.return"(%8) : (i8) -> ()
}
]
def PR39793_bswap_u32_as_u16_trunc_after := [llvm|
{
^0(%arg24 : i32):
  %0 = llvm.mlir.constant(8 : i32) : i32
  %1 = llvm.lshr %arg24, %0 : i32
  %2 = llvm.trunc %1 : i32 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR39793_bswap_u32_as_u16_trunc_proof : PR39793_bswap_u32_as_u16_trunc_before ⊑ PR39793_bswap_u32_as_u16_trunc_after := by
  unfold PR39793_bswap_u32_as_u16_trunc_before PR39793_bswap_u32_as_u16_trunc_after
  simp_alive_peephole
  intros
  ---BEGIN PR39793_bswap_u32_as_u16_trunc
  all_goals (try extract_goal ; sorry)
  ---END PR39793_bswap_u32_as_u16_trunc



def bswap_and_mask_1_before := [llvm|
{
^0(%arg19 : i64):
  %0 = llvm.mlir.constant(56) : i64
  %1 = llvm.mlir.constant(40) : i64
  %2 = llvm.mlir.constant(65280) : i64
  %3 = llvm.lshr %arg19, %0 : i64
  %4 = llvm.lshr %arg19, %1 : i64
  %5 = llvm.and %4, %2 : i64
  %6 = llvm.or %5, %3 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
def bswap_and_mask_1_after := [llvm|
{
^0(%arg19 : i64):
  %0 = llvm.mlir.constant(56) : i64
  %1 = llvm.mlir.constant(40) : i64
  %2 = llvm.mlir.constant(65280) : i64
  %3 = llvm.lshr %arg19, %0 : i64
  %4 = llvm.lshr %arg19, %1 : i64
  %5 = llvm.and %4, %2 : i64
  %6 = llvm.or disjoint %5, %3 : i64
  "llvm.return"(%6) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bswap_and_mask_1_proof : bswap_and_mask_1_before ⊑ bswap_and_mask_1_after := by
  unfold bswap_and_mask_1_before bswap_and_mask_1_after
  simp_alive_peephole
  intros
  ---BEGIN bswap_and_mask_1
  all_goals (try extract_goal ; sorry)
  ---END bswap_and_mask_1


