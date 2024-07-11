import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  redundant-left-shift-input-masking-after-truncation-variant-f
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_basic_before := [llvmfunc|
  llvm.func @t0_basic(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-32 : i32) : i32
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.shl %arg0, %1  : i64
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.ashr %2, %1  : i64
    llvm.call @use64(%1) : (i64) -> ()
    llvm.call @use64(%2) : (i64) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.shl %5, %3  : i32
    llvm.return %6 : i32
  }]

def t1_vec_splat_before := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-32> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.zext %arg1 : vector<8xi32> to vector<8xi64>
    %2 = llvm.shl %arg0, %1  : vector<8xi64>
    %3 = llvm.add %arg1, %0  : vector<8xi32>
    %4 = llvm.ashr %2, %1  : vector<8xi64>
    llvm.call @use8xi64(%1) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%2) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%4) : (vector<8xi64>) -> ()
    %5 = llvm.trunc %4 : vector<8xi64> to vector<8xi32>
    %6 = llvm.shl %5, %3  : vector<8xi32>
    llvm.return %6 : vector<8xi32>
  }]

def t2_vec_splat_undef_before := [llvmfunc|
  llvm.func @t2_vec_splat_undef(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(-32 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<8xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<8xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<8xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<8xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<8xi32>
    %11 = llvm.mlir.constant(4 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<8xi32>
    %13 = llvm.mlir.constant(5 : i32) : i32
    %14 = llvm.insertelement %0, %12[%13 : i32] : vector<8xi32>
    %15 = llvm.mlir.constant(6 : i32) : i32
    %16 = llvm.insertelement %1, %14[%15 : i32] : vector<8xi32>
    %17 = llvm.mlir.constant(7 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<8xi32>
    %19 = llvm.zext %arg1 : vector<8xi32> to vector<8xi64>
    %20 = llvm.shl %arg0, %19  : vector<8xi64>
    %21 = llvm.add %arg1, %18  : vector<8xi32>
    %22 = llvm.ashr %20, %19  : vector<8xi64>
    llvm.call @use8xi64(%19) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%20) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%21) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%22) : (vector<8xi64>) -> ()
    %23 = llvm.trunc %22 : vector<8xi64> to vector<8xi32>
    %24 = llvm.shl %23, %21  : vector<8xi32>
    llvm.return %24 : vector<8xi32>
  }]

def t3_vec_nonsplat_before := [llvmfunc|
  llvm.func @t3_vec_nonsplat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.mlir.constant(31 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(-1 : i32) : i32
    %7 = llvm.mlir.constant(-32 : i32) : i32
    %8 = llvm.mlir.undef : vector<8xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<8xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %6, %10[%11 : i32] : vector<8xi32>
    %13 = llvm.mlir.constant(2 : i32) : i32
    %14 = llvm.insertelement %5, %12[%13 : i32] : vector<8xi32>
    %15 = llvm.mlir.constant(3 : i32) : i32
    %16 = llvm.insertelement %4, %14[%15 : i32] : vector<8xi32>
    %17 = llvm.mlir.constant(4 : i32) : i32
    %18 = llvm.insertelement %3, %16[%17 : i32] : vector<8xi32>
    %19 = llvm.mlir.constant(5 : i32) : i32
    %20 = llvm.insertelement %2, %18[%19 : i32] : vector<8xi32>
    %21 = llvm.mlir.constant(6 : i32) : i32
    %22 = llvm.insertelement %1, %20[%21 : i32] : vector<8xi32>
    %23 = llvm.mlir.constant(7 : i32) : i32
    %24 = llvm.insertelement %0, %22[%23 : i32] : vector<8xi32>
    %25 = llvm.zext %arg1 : vector<8xi32> to vector<8xi64>
    %26 = llvm.shl %arg0, %25  : vector<8xi64>
    %27 = llvm.add %arg1, %24  : vector<8xi32>
    %28 = llvm.ashr %26, %25  : vector<8xi64>
    llvm.call @use8xi64(%25) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%26) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%27) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%28) : (vector<8xi64>) -> ()
    %29 = llvm.trunc %28 : vector<8xi64> to vector<8xi32>
    %30 = llvm.shl %29, %27  : vector<8xi32>
    llvm.return %30 : vector<8xi32>
  }]

def n4_extrause_before := [llvmfunc|
  llvm.func @n4_extrause(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-32 : i32) : i32
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.shl %arg0, %1  : i64
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.ashr %2, %1  : i64
    llvm.call @use64(%1) : (i64) -> ()
    llvm.call @use64(%2) : (i64) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %5, %3  : i32
    llvm.return %6 : i32
  }]

def n5_mask_before := [llvmfunc|
  llvm.func @n5_mask(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.shl %arg0, %1  : i64
    %3 = llvm.add %arg1, %0  : i32
    llvm.call @use64(%1) : (i64) -> ()
    llvm.call @use64(%2) : (i64) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.ashr %2, %1  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.shl %5, %3  : i32
    llvm.return %6 : i32
  }]

def t0_basic_combined := [llvmfunc|
  llvm.func @t0_basic(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-32 : i32) : i32
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.shl %arg0, %1  : i64
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.ashr %2, %1  : i64
    llvm.call @use64(%1) : (i64) -> ()
    llvm.call @use64(%2) : (i64) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %arg0 : i64 to i32
    %6 = llvm.shl %5, %3  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_t0_basic   : t0_basic_before  ⊑  t0_basic_combined := by
  unfold t0_basic_before t0_basic_combined
  simp_alive_peephole
  sorry
def t1_vec_splat_combined := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-32> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.zext %arg1 : vector<8xi32> to vector<8xi64>
    %2 = llvm.shl %arg0, %1  : vector<8xi64>
    %3 = llvm.add %arg1, %0  : vector<8xi32>
    %4 = llvm.ashr %2, %1  : vector<8xi64>
    llvm.call @use8xi64(%1) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%2) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%4) : (vector<8xi64>) -> ()
    %5 = llvm.trunc %arg0 : vector<8xi64> to vector<8xi32>
    %6 = llvm.shl %5, %3  : vector<8xi32>
    llvm.return %6 : vector<8xi32>
  }]

theorem inst_combine_t1_vec_splat   : t1_vec_splat_before  ⊑  t1_vec_splat_combined := by
  unfold t1_vec_splat_before t1_vec_splat_combined
  simp_alive_peephole
  sorry
def t2_vec_splat_undef_combined := [llvmfunc|
  llvm.func @t2_vec_splat_undef(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(-32 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<8xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<8xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<8xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<8xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<8xi32>
    %11 = llvm.mlir.constant(4 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<8xi32>
    %13 = llvm.mlir.constant(5 : i32) : i32
    %14 = llvm.insertelement %0, %12[%13 : i32] : vector<8xi32>
    %15 = llvm.mlir.constant(6 : i32) : i32
    %16 = llvm.insertelement %1, %14[%15 : i32] : vector<8xi32>
    %17 = llvm.mlir.constant(7 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<8xi32>
    %19 = llvm.zext %arg1 : vector<8xi32> to vector<8xi64>
    %20 = llvm.shl %arg0, %19  : vector<8xi64>
    %21 = llvm.add %arg1, %18  : vector<8xi32>
    %22 = llvm.ashr %20, %19  : vector<8xi64>
    llvm.call @use8xi64(%19) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%20) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%21) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%22) : (vector<8xi64>) -> ()
    %23 = llvm.trunc %arg0 : vector<8xi64> to vector<8xi32>
    %24 = llvm.shl %23, %21  : vector<8xi32>
    llvm.return %24 : vector<8xi32>
  }]

theorem inst_combine_t2_vec_splat_undef   : t2_vec_splat_undef_before  ⊑  t2_vec_splat_undef_combined := by
  unfold t2_vec_splat_undef_before t2_vec_splat_undef_combined
  simp_alive_peephole
  sorry
def t3_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t3_vec_nonsplat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.mlir.constant(31 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(-1 : i32) : i32
    %7 = llvm.mlir.constant(-32 : i32) : i32
    %8 = llvm.mlir.undef : vector<8xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<8xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %6, %10[%11 : i32] : vector<8xi32>
    %13 = llvm.mlir.constant(2 : i32) : i32
    %14 = llvm.insertelement %5, %12[%13 : i32] : vector<8xi32>
    %15 = llvm.mlir.constant(3 : i32) : i32
    %16 = llvm.insertelement %4, %14[%15 : i32] : vector<8xi32>
    %17 = llvm.mlir.constant(4 : i32) : i32
    %18 = llvm.insertelement %3, %16[%17 : i32] : vector<8xi32>
    %19 = llvm.mlir.constant(5 : i32) : i32
    %20 = llvm.insertelement %2, %18[%19 : i32] : vector<8xi32>
    %21 = llvm.mlir.constant(6 : i32) : i32
    %22 = llvm.insertelement %1, %20[%21 : i32] : vector<8xi32>
    %23 = llvm.mlir.constant(7 : i32) : i32
    %24 = llvm.insertelement %0, %22[%23 : i32] : vector<8xi32>
    %25 = llvm.zext %arg1 : vector<8xi32> to vector<8xi64>
    %26 = llvm.shl %arg0, %25  : vector<8xi64>
    %27 = llvm.add %arg1, %24  : vector<8xi32>
    %28 = llvm.ashr %26, %25  : vector<8xi64>
    llvm.call @use8xi64(%25) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%26) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%27) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%28) : (vector<8xi64>) -> ()
    %29 = llvm.trunc %arg0 : vector<8xi64> to vector<8xi32>
    %30 = llvm.shl %29, %27  : vector<8xi32>
    llvm.return %30 : vector<8xi32>
  }]

theorem inst_combine_t3_vec_nonsplat   : t3_vec_nonsplat_before  ⊑  t3_vec_nonsplat_combined := by
  unfold t3_vec_nonsplat_before t3_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def n4_extrause_combined := [llvmfunc|
  llvm.func @n4_extrause(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-32 : i32) : i32
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.shl %arg0, %1  : i64
    %3 = llvm.add %arg1, %0  : i32
    %4 = llvm.ashr %2, %1  : i64
    llvm.call @use64(%1) : (i64) -> ()
    llvm.call @use64(%2) : (i64) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.shl %5, %3  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_n4_extrause   : n4_extrause_before  ⊑  n4_extrause_combined := by
  unfold n4_extrause_before n4_extrause_combined
  simp_alive_peephole
  sorry
def n5_mask_combined := [llvmfunc|
  llvm.func @n5_mask(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.shl %arg0, %1  : i64
    %3 = llvm.add %arg1, %0  : i32
    llvm.call @use64(%1) : (i64) -> ()
    llvm.call @use64(%2) : (i64) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.ashr %2, %1  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.shl %5, %3  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_n5_mask   : n5_mask_before  ⊑  n5_mask_combined := by
  unfold n5_mask_before n5_mask_combined
  simp_alive_peephole
  sorry
