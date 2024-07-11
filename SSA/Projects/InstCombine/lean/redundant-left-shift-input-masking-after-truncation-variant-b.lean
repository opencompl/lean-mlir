import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  redundant-left-shift-input-masking-after-truncation-variant-b
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_basic_before := [llvmfunc|
  llvm.func @t0_basic(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.shl %0, %2  : i64
    %4 = llvm.xor %3, %0  : i64
    %5 = llvm.sub %1, %arg1  : i32
    %6 = llvm.and %4, %arg0  : i64
    llvm.call @use32(%arg1) : (i32) -> ()
    llvm.call @use64(%2) : (i64) -> ()
    llvm.call @use64(%3) : (i64) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.shl %7, %5  : i32
    llvm.return %8 : i32
  }]

def t1_vec_splat_before := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi64>) : vector<8xi64>
    %1 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %2 = llvm.zext %arg1 : vector<8xi32> to vector<8xi64>
    %3 = llvm.shl %0, %2  : vector<8xi64>
    %4 = llvm.xor %3, %0  : vector<8xi64>
    %5 = llvm.sub %1, %arg1  : vector<8xi32>
    %6 = llvm.and %4, %arg0  : vector<8xi64>
    llvm.call @use8xi32(%arg1) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%2) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%3) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%4) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%5) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%6) : (vector<8xi64>) -> ()
    %7 = llvm.trunc %6 : vector<8xi64> to vector<8xi32>
    %8 = llvm.shl %7, %5  : vector<8xi32>
    llvm.return %8 : vector<8xi32>
  }]

def t2_vec_splat_poison_before := [llvmfunc|
  llvm.func @t2_vec_splat_poison(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.undef : vector<8xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<8xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<8xi64>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<8xi64>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<8xi64>
    %11 = llvm.mlir.constant(4 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<8xi64>
    %13 = llvm.mlir.constant(5 : i32) : i32
    %14 = llvm.insertelement %0, %12[%13 : i32] : vector<8xi64>
    %15 = llvm.mlir.constant(6 : i32) : i32
    %16 = llvm.insertelement %1, %14[%15 : i32] : vector<8xi64>
    %17 = llvm.mlir.constant(7 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<8xi64>
    %19 = llvm.mlir.constant(32 : i32) : i32
    %20 = llvm.mlir.poison : i32
    %21 = llvm.mlir.undef : vector<8xi32>
    %22 = llvm.mlir.constant(0 : i32) : i32
    %23 = llvm.insertelement %19, %21[%22 : i32] : vector<8xi32>
    %24 = llvm.mlir.constant(1 : i32) : i32
    %25 = llvm.insertelement %19, %23[%24 : i32] : vector<8xi32>
    %26 = llvm.mlir.constant(2 : i32) : i32
    %27 = llvm.insertelement %19, %25[%26 : i32] : vector<8xi32>
    %28 = llvm.mlir.constant(3 : i32) : i32
    %29 = llvm.insertelement %19, %27[%28 : i32] : vector<8xi32>
    %30 = llvm.mlir.constant(4 : i32) : i32
    %31 = llvm.insertelement %19, %29[%30 : i32] : vector<8xi32>
    %32 = llvm.mlir.constant(5 : i32) : i32
    %33 = llvm.insertelement %19, %31[%32 : i32] : vector<8xi32>
    %34 = llvm.mlir.constant(6 : i32) : i32
    %35 = llvm.insertelement %20, %33[%34 : i32] : vector<8xi32>
    %36 = llvm.mlir.constant(7 : i32) : i32
    %37 = llvm.insertelement %19, %35[%36 : i32] : vector<8xi32>
    %38 = llvm.zext %arg1 : vector<8xi32> to vector<8xi64>
    %39 = llvm.shl %18, %38  : vector<8xi64>
    %40 = llvm.xor %39, %18  : vector<8xi64>
    %41 = llvm.sub %37, %arg1  : vector<8xi32>
    %42 = llvm.and %40, %arg0  : vector<8xi64>
    llvm.call @use8xi32(%arg1) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%38) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%39) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%40) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%41) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%42) : (vector<8xi64>) -> ()
    %43 = llvm.trunc %42 : vector<8xi64> to vector<8xi32>
    %44 = llvm.shl %43, %41  : vector<8xi32>
    llvm.return %44 : vector<8xi32>
  }]

def t3_vec_nonsplat_before := [llvmfunc|
  llvm.func @t3_vec_nonsplat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<[-1, 0, 0, 1, 0, 0, 0, 0]> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<8xi64>) : vector<8xi64>
    %2 = llvm.mlir.constant(dense<[33, 32, 33, 32, 32, 32, 32, 32]> : vector<8xi32>) : vector<8xi32>
    %3 = llvm.add %arg1, %0  : vector<8xi32>
    %4 = llvm.zext %3 : vector<8xi32> to vector<8xi64>
    %5 = llvm.shl %1, %4  : vector<8xi64>
    %6 = llvm.xor %5, %1  : vector<8xi64>
    %7 = llvm.sub %2, %arg1  : vector<8xi32>
    %8 = llvm.and %6, %arg0  : vector<8xi64>
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%4) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%5) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%6) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%7) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%8) : (vector<8xi64>) -> ()
    %9 = llvm.trunc %8 : vector<8xi64> to vector<8xi32>
    %10 = llvm.shl %9, %7  : vector<8xi32>
    llvm.return %10 : vector<8xi32>
  }]

def t4_allones_trunc_before := [llvmfunc|
  llvm.func @t4_allones_trunc(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.shl %0, %3  : i64
    %5 = llvm.xor %4, %1  : i64
    %6 = llvm.sub %2, %arg1  : i32
    %7 = llvm.and %5, %arg0  : i64
    llvm.call @use32(%arg1) : (i32) -> ()
    llvm.call @use64(%3) : (i64) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.shl %8, %6  : i32
    llvm.return %9 : i32
  }]

def n5_extrause_before := [llvmfunc|
  llvm.func @n5_extrause(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.shl %0, %2  : i64
    %4 = llvm.xor %3, %0  : i64
    %5 = llvm.sub %1, %arg1  : i32
    %6 = llvm.and %4, %arg0  : i64
    llvm.call @use32(%arg1) : (i32) -> ()
    llvm.call @use64(%2) : (i64) -> ()
    llvm.call @use64(%3) : (i64) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.trunc %6 : i64 to i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %7, %5  : i32
    llvm.return %8 : i32
  }]

def t0_basic_combined := [llvmfunc|
  llvm.func @t0_basic(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.shl %0, %2 overflow<nsw>  : i64
    %4 = llvm.xor %3, %0  : i64
    %5 = llvm.sub %1, %arg1  : i32
    %6 = llvm.and %4, %arg0  : i64
    llvm.call @use32(%arg1) : (i32) -> ()
    llvm.call @use64(%2) : (i64) -> ()
    llvm.call @use64(%3) : (i64) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.trunc %arg0 : i64 to i32
    %8 = llvm.shl %7, %5  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_t0_basic   : t0_basic_before  ⊑  t0_basic_combined := by
  unfold t0_basic_before t0_basic_combined
  simp_alive_peephole
  sorry
def t1_vec_splat_combined := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<8xi64>) : vector<8xi64>
    %1 = llvm.mlir.constant(dense<32> : vector<8xi32>) : vector<8xi32>
    %2 = llvm.zext %arg1 : vector<8xi32> to vector<8xi64>
    %3 = llvm.shl %0, %2 overflow<nsw>  : vector<8xi64>
    %4 = llvm.xor %3, %0  : vector<8xi64>
    %5 = llvm.sub %1, %arg1  : vector<8xi32>
    %6 = llvm.and %4, %arg0  : vector<8xi64>
    llvm.call @use8xi32(%arg1) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%2) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%3) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%4) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%5) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%6) : (vector<8xi64>) -> ()
    %7 = llvm.trunc %arg0 : vector<8xi64> to vector<8xi32>
    %8 = llvm.shl %7, %5  : vector<8xi32>
    llvm.return %8 : vector<8xi32>
  }]

theorem inst_combine_t1_vec_splat   : t1_vec_splat_before  ⊑  t1_vec_splat_combined := by
  unfold t1_vec_splat_before t1_vec_splat_combined
  simp_alive_peephole
  sorry
def t2_vec_splat_poison_combined := [llvmfunc|
  llvm.func @t2_vec_splat_poison(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.undef : vector<8xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<8xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<8xi64>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<8xi64>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<8xi64>
    %11 = llvm.mlir.constant(4 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<8xi64>
    %13 = llvm.mlir.constant(5 : i32) : i32
    %14 = llvm.insertelement %0, %12[%13 : i32] : vector<8xi64>
    %15 = llvm.mlir.constant(6 : i32) : i32
    %16 = llvm.insertelement %1, %14[%15 : i32] : vector<8xi64>
    %17 = llvm.mlir.constant(7 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<8xi64>
    %19 = llvm.mlir.constant(32 : i32) : i32
    %20 = llvm.mlir.poison : i32
    %21 = llvm.mlir.undef : vector<8xi32>
    %22 = llvm.mlir.constant(0 : i32) : i32
    %23 = llvm.insertelement %19, %21[%22 : i32] : vector<8xi32>
    %24 = llvm.mlir.constant(1 : i32) : i32
    %25 = llvm.insertelement %19, %23[%24 : i32] : vector<8xi32>
    %26 = llvm.mlir.constant(2 : i32) : i32
    %27 = llvm.insertelement %19, %25[%26 : i32] : vector<8xi32>
    %28 = llvm.mlir.constant(3 : i32) : i32
    %29 = llvm.insertelement %19, %27[%28 : i32] : vector<8xi32>
    %30 = llvm.mlir.constant(4 : i32) : i32
    %31 = llvm.insertelement %19, %29[%30 : i32] : vector<8xi32>
    %32 = llvm.mlir.constant(5 : i32) : i32
    %33 = llvm.insertelement %19, %31[%32 : i32] : vector<8xi32>
    %34 = llvm.mlir.constant(6 : i32) : i32
    %35 = llvm.insertelement %20, %33[%34 : i32] : vector<8xi32>
    %36 = llvm.mlir.constant(7 : i32) : i32
    %37 = llvm.insertelement %19, %35[%36 : i32] : vector<8xi32>
    %38 = llvm.zext %arg1 : vector<8xi32> to vector<8xi64>
    %39 = llvm.shl %18, %38 overflow<nsw>  : vector<8xi64>
    %40 = llvm.xor %39, %18  : vector<8xi64>
    %41 = llvm.sub %37, %arg1  : vector<8xi32>
    %42 = llvm.and %40, %arg0  : vector<8xi64>
    llvm.call @use8xi32(%arg1) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%38) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%39) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%40) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%41) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%42) : (vector<8xi64>) -> ()
    %43 = llvm.trunc %arg0 : vector<8xi64> to vector<8xi32>
    %44 = llvm.shl %43, %41  : vector<8xi32>
    llvm.return %44 : vector<8xi32>
  }]

theorem inst_combine_t2_vec_splat_poison   : t2_vec_splat_poison_before  ⊑  t2_vec_splat_poison_combined := by
  unfold t2_vec_splat_poison_before t2_vec_splat_poison_combined
  simp_alive_peephole
  sorry
def t3_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t3_vec_nonsplat(%arg0: vector<8xi64>, %arg1: vector<8xi32>) -> vector<8xi32> {
    %0 = llvm.mlir.constant(dense<[-1, 0, 0, 1, 0, 0, 0, 0]> : vector<8xi32>) : vector<8xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<8xi64>) : vector<8xi64>
    %2 = llvm.mlir.constant(dense<[33, 32, 33, 32, 32, 32, 32, 32]> : vector<8xi32>) : vector<8xi32>
    %3 = llvm.add %arg1, %0  : vector<8xi32>
    %4 = llvm.zext %3 : vector<8xi32> to vector<8xi64>
    %5 = llvm.shl %1, %4 overflow<nsw>  : vector<8xi64>
    %6 = llvm.xor %5, %1  : vector<8xi64>
    %7 = llvm.sub %2, %arg1  : vector<8xi32>
    %8 = llvm.and %6, %arg0  : vector<8xi64>
    llvm.call @use8xi32(%3) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%4) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%5) : (vector<8xi64>) -> ()
    llvm.call @use8xi64(%6) : (vector<8xi64>) -> ()
    llvm.call @use8xi32(%7) : (vector<8xi32>) -> ()
    llvm.call @use8xi64(%8) : (vector<8xi64>) -> ()
    %9 = llvm.trunc %arg0 : vector<8xi64> to vector<8xi32>
    %10 = llvm.shl %9, %7  : vector<8xi32>
    llvm.return %10 : vector<8xi32>
  }]

theorem inst_combine_t3_vec_nonsplat   : t3_vec_nonsplat_before  ⊑  t3_vec_nonsplat_combined := by
  unfold t3_vec_nonsplat_before t3_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def t4_allones_trunc_combined := [llvmfunc|
  llvm.func @t4_allones_trunc(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.zext %arg1 : i32 to i64
    %4 = llvm.shl %0, %3 overflow<nsw>  : i64
    %5 = llvm.xor %4, %1  : i64
    %6 = llvm.sub %2, %arg1  : i32
    %7 = llvm.and %5, %arg0  : i64
    llvm.call @use32(%arg1) : (i32) -> ()
    llvm.call @use64(%3) : (i64) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use64(%5) : (i64) -> ()
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.shl %8, %6  : i32
    llvm.return %9 : i32
  }]

theorem inst_combine_t4_allones_trunc   : t4_allones_trunc_before  ⊑  t4_allones_trunc_combined := by
  unfold t4_allones_trunc_before t4_allones_trunc_combined
  simp_alive_peephole
  sorry
def n5_extrause_combined := [llvmfunc|
  llvm.func @n5_extrause(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.shl %0, %2 overflow<nsw>  : i64
    %4 = llvm.xor %3, %0  : i64
    %5 = llvm.sub %1, %arg1  : i32
    %6 = llvm.and %4, %arg0  : i64
    llvm.call @use32(%arg1) : (i32) -> ()
    llvm.call @use64(%2) : (i64) -> ()
    llvm.call @use64(%3) : (i64) -> ()
    llvm.call @use64(%4) : (i64) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.trunc %6 : i64 to i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %7, %5  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n5_extrause   : n5_extrause_before  ⊑  n5_extrause_combined := by
  unfold n5_extrause_before n5_extrause_combined
  simp_alive_peephole
  sorry
