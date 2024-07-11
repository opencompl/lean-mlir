import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  variable-signext-of-variable-high-bit-extraction
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }]

def t0_zext_of_nbits_before := [llvmfunc|
  llvm.func @t0_zext_of_nbits(%arg0: i64, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(64 : i16) : i16
    %1 = llvm.mlir.constant(32 : i16) : i16
    %2 = llvm.zext %arg1 : i8 to i16
    llvm.call @use16(%2) : (i16) -> ()
    %3 = llvm.sub %0, %2  : i16
    llvm.call @use16(%3) : (i16) -> ()
    %4 = llvm.zext %3 : i16 to i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.lshr %arg0, %4  : i64
    llvm.call @use64(%5) : (i64) -> ()
    %6 = llvm.trunc %5 : i64 to i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.sub %1, %2  : i16
    llvm.call @use16(%7) : (i16) -> ()
    %8 = llvm.zext %7 : i16 to i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.shl %6, %8  : i32
    %10 = llvm.ashr %9, %8  : i32
    llvm.return %10 : i32
  }]

def t0_exact_before := [llvmfunc|
  llvm.func @t0_exact(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }]

def t1_redundant_sext_before := [llvmfunc|
  llvm.func @t1_redundant_sext(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.ashr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }]

def t2_notrunc_before := [llvmfunc|
  llvm.func @t2_notrunc(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.sub %0, %arg1  : i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.lshr %arg0, %1  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.sub %0, %arg1  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.shl %2, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.ashr %4, %3  : i64
    llvm.return %5 : i64
  }]

def t3_notrunc_redundant_sext_before := [llvmfunc|
  llvm.func @t3_notrunc_redundant_sext(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.sub %0, %arg1  : i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.ashr %arg0, %1  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.sub %0, %arg1  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.shl %2, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.ashr %4, %3  : i64
    llvm.return %5 : i64
  }]

def t4_vec_before := [llvmfunc|
  llvm.func @t4_vec(%arg0: vector<2xi64>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg1  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.lshr %arg0, %3  : vector<2xi64>
    %5 = llvm.trunc %4 : vector<2xi64> to vector<2xi32>
    %6 = llvm.sub %1, %arg1  : vector<2xi32>
    %7 = llvm.shl %5, %6  : vector<2xi32>
    %8 = llvm.ashr %7, %6  : vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def t5_vec_poison_before := [llvmfunc|
  llvm.func @t5_vec_poison(%arg0: vector<3xi64>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(32 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %9, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %0, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.mlir.undef : vector<3xi32>
    %18 = llvm.mlir.constant(0 : i32) : i32
    %19 = llvm.insertelement %0, %17[%18 : i32] : vector<3xi32>
    %20 = llvm.mlir.constant(1 : i32) : i32
    %21 = llvm.insertelement %9, %19[%20 : i32] : vector<3xi32>
    %22 = llvm.mlir.constant(2 : i32) : i32
    %23 = llvm.insertelement %9, %21[%22 : i32] : vector<3xi32>
    %24 = llvm.sub %8, %arg1  : vector<3xi32>
    %25 = llvm.zext %24 : vector<3xi32> to vector<3xi64>
    %26 = llvm.lshr %arg0, %25  : vector<3xi64>
    %27 = llvm.trunc %26 : vector<3xi64> to vector<3xi32>
    %28 = llvm.sub %16, %arg1  : vector<3xi32>
    %29 = llvm.sub %23, %arg1  : vector<3xi32>
    %30 = llvm.shl %27, %28  : vector<3xi32>
    %31 = llvm.ashr %30, %29  : vector<3xi32>
    llvm.return %31 : vector<3xi32>
  }]

def t6_extrause_good0_before := [llvmfunc|
  llvm.func @t6_extrause_good0(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }]

def t7_extrause_good1_before := [llvmfunc|
  llvm.func @t7_extrause_good1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.sub %1, %arg1  : i32
    %8 = llvm.shl %5, %6  : i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.ashr %8, %7  : i32
    llvm.return %9 : i32
  }]

def n8_extrause_bad_before := [llvmfunc|
  llvm.func @n8_extrause_bad(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }]

def n9_before := [llvmfunc|
  llvm.func @n9(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }]

def n10_before := [llvmfunc|
  llvm.func @n10(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }]

def n11_before := [llvmfunc|
  llvm.func @n11(%arg0: i64, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg2  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }]

def n12_before := [llvmfunc|
  llvm.func @n12(%arg0: i64, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    %7 = llvm.sub %1, %arg2  : i32
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %5, %6  : i32
    %9 = llvm.ashr %8, %7  : i32
    llvm.return %9 : i32
  }]

def n13_before := [llvmfunc|
  llvm.func @n13(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.lshr %7, %6  : i32
    llvm.return %8 : i32
  }]

def n13_extrause_before := [llvmfunc|
  llvm.func @n13_extrause(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.lshr %7, %6  : i32
    llvm.return %8 : i32
  }]

def n14_before := [llvmfunc|
  llvm.func @n14(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.ashr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.lshr %7, %6  : i32
    llvm.return %8 : i32
  }]

def n14_extrause_before := [llvmfunc|
  llvm.func @n14_extrause(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.ashr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.lshr %7, %6  : i32
    llvm.return %8 : i32
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.ashr %arg0, %3  : i64
    %8 = llvm.trunc %7 : i64 to i32
    llvm.return %8 : i32
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t0_zext_of_nbits_combined := [llvmfunc|
  llvm.func @t0_zext_of_nbits(%arg0: i64, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(64 : i16) : i16
    %1 = llvm.mlir.constant(32 : i16) : i16
    %2 = llvm.zext %arg1 : i8 to i16
    llvm.call @use16(%2) : (i16) -> ()
    %3 = llvm.sub %0, %2 overflow<nsw>  : i16
    llvm.call @use16(%3) : (i16) -> ()
    %4 = llvm.zext %3 : i16 to i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.lshr %arg0, %4  : i64
    llvm.call @use64(%5) : (i64) -> ()
    %6 = llvm.trunc %5 : i64 to i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.sub %1, %2 overflow<nsw>  : i16
    llvm.call @use16(%7) : (i16) -> ()
    %8 = llvm.zext %7 : i16 to i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.ashr %arg0, %4  : i64
    %10 = llvm.trunc %9 : i64 to i32
    llvm.return %10 : i32
  }]

theorem inst_combine_t0_zext_of_nbits   : t0_zext_of_nbits_before  ⊑  t0_zext_of_nbits_combined := by
  unfold t0_zext_of_nbits_before t0_zext_of_nbits_combined
  simp_alive_peephole
  sorry
def t0_exact_combined := [llvmfunc|
  llvm.func @t0_exact(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.ashr %arg0, %3  : i64
    %8 = llvm.trunc %7 : i64 to i32
    llvm.return %8 : i32
  }]

theorem inst_combine_t0_exact   : t0_exact_before  ⊑  t0_exact_combined := by
  unfold t0_exact_before t0_exact_combined
  simp_alive_peephole
  sorry
def t1_redundant_sext_combined := [llvmfunc|
  llvm.func @t1_redundant_sext(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.ashr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_t1_redundant_sext   : t1_redundant_sext_before  ⊑  t1_redundant_sext_combined := by
  unfold t1_redundant_sext_before t1_redundant_sext_combined
  simp_alive_peephole
  sorry
def t2_notrunc_combined := [llvmfunc|
  llvm.func @t2_notrunc(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.sub %0, %arg1  : i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.lshr %arg0, %1  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.sub %0, %arg1  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.shl %2, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.ashr %arg0, %1  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_t2_notrunc   : t2_notrunc_before  ⊑  t2_notrunc_combined := by
  unfold t2_notrunc_before t2_notrunc_combined
  simp_alive_peephole
  sorry
def t3_notrunc_redundant_sext_combined := [llvmfunc|
  llvm.func @t3_notrunc_redundant_sext(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.sub %0, %arg1  : i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.ashr %arg0, %1  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.sub %0, %arg1  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.shl %2, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    llvm.return %2 : i64
  }]

theorem inst_combine_t3_notrunc_redundant_sext   : t3_notrunc_redundant_sext_before  ⊑  t3_notrunc_redundant_sext_combined := by
  unfold t3_notrunc_redundant_sext_before t3_notrunc_redundant_sext_combined
  simp_alive_peephole
  sorry
def t4_vec_combined := [llvmfunc|
  llvm.func @t4_vec(%arg0: vector<2xi64>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sub %0, %arg1  : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi32> to vector<2xi64>
    %3 = llvm.ashr %arg0, %2  : vector<2xi64>
    %4 = llvm.trunc %3 : vector<2xi64> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_t4_vec   : t4_vec_before  ⊑  t4_vec_combined := by
  unfold t4_vec_before t4_vec_combined
  simp_alive_peephole
  sorry
def t5_vec_poison_combined := [llvmfunc|
  llvm.func @t5_vec_poison(%arg0: vector<3xi64>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.sub %8, %arg1  : vector<3xi32>
    %10 = llvm.zext %9 : vector<3xi32> to vector<3xi64>
    %11 = llvm.ashr %arg0, %10  : vector<3xi64>
    %12 = llvm.trunc %11 : vector<3xi64> to vector<3xi32>
    llvm.return %12 : vector<3xi32>
  }]

theorem inst_combine_t5_vec_poison   : t5_vec_poison_before  ⊑  t5_vec_poison_combined := by
  unfold t5_vec_poison_before t5_vec_poison_combined
  simp_alive_peephole
  sorry
def t6_extrause_good0_combined := [llvmfunc|
  llvm.func @t6_extrause_good0(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.ashr %arg0, %3  : i64
    %8 = llvm.trunc %7 : i64 to i32
    llvm.return %8 : i32
  }]

theorem inst_combine_t6_extrause_good0   : t6_extrause_good0_before  ⊑  t6_extrause_good0_combined := by
  unfold t6_extrause_good0_before t6_extrause_good0_combined
  simp_alive_peephole
  sorry
def t7_extrause_good1_combined := [llvmfunc|
  llvm.func @t7_extrause_good1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.ashr %arg0, %3  : i64
    %9 = llvm.trunc %8 : i64 to i32
    llvm.return %9 : i32
  }]

theorem inst_combine_t7_extrause_good1   : t7_extrause_good1_before  ⊑  t7_extrause_good1_combined := by
  unfold t7_extrause_good1_before t7_extrause_good1_combined
  simp_alive_peephole
  sorry
def n8_extrause_bad_combined := [llvmfunc|
  llvm.func @n8_extrause_bad(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n8_extrause_bad   : n8_extrause_bad_before  ⊑  n8_extrause_bad_combined := by
  unfold n8_extrause_bad_before n8_extrause_bad_combined
  simp_alive_peephole
  sorry
def n9_combined := [llvmfunc|
  llvm.func @n9(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n9   : n9_before  ⊑  n9_combined := by
  unfold n9_before n9_combined
  simp_alive_peephole
  sorry
def n10_combined := [llvmfunc|
  llvm.func @n10(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n10   : n10_before  ⊑  n10_combined := by
  unfold n10_before n10_combined
  simp_alive_peephole
  sorry
def n11_combined := [llvmfunc|
  llvm.func @n11(%arg0: i64, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg2  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    %8 = llvm.ashr %7, %6  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n11   : n11_before  ⊑  n11_combined := by
  unfold n11_before n11_combined
  simp_alive_peephole
  sorry
def n12_combined := [llvmfunc|
  llvm.func @n12(%arg0: i64, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    %7 = llvm.sub %1, %arg2  : i32
    llvm.call @use32(%6) : (i32) -> ()
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %5, %6  : i32
    %9 = llvm.ashr %8, %7  : i32
    llvm.return %9 : i32
  }]

theorem inst_combine_n12   : n12_before  ⊑  n12_combined := by
  unfold n12_before n12_combined
  simp_alive_peephole
  sorry
def n13_combined := [llvmfunc|
  llvm.func @n13(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.zext %3 : i32 to i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.lshr %arg0, %4  : i64
    llvm.call @use64(%5) : (i64) -> ()
    %6 = llvm.trunc %5 : i64 to i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.lshr %2, %7  : i32
    %9 = llvm.and %8, %6  : i32
    llvm.return %9 : i32
  }]

theorem inst_combine_n13   : n13_before  ⊑  n13_combined := by
  unfold n13_before n13_combined
  simp_alive_peephole
  sorry
def n13_extrause_combined := [llvmfunc|
  llvm.func @n13_extrause(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.lshr %7, %6  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n13_extrause   : n13_extrause_before  ⊑  n13_extrause_combined := by
  unfold n13_extrause_before n13_extrause_combined
  simp_alive_peephole
  sorry
def n14_combined := [llvmfunc|
  llvm.func @n14(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.zext %3 : i32 to i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.ashr %arg0, %4  : i64
    llvm.call @use64(%5) : (i64) -> ()
    %6 = llvm.trunc %5 : i64 to i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.lshr %2, %7  : i32
    %9 = llvm.and %8, %6  : i32
    llvm.return %9 : i32
  }]

theorem inst_combine_n14   : n14_before  ⊑  n14_combined := by
  unfold n14_before n14_combined
  simp_alive_peephole
  sorry
def n14_extrause_combined := [llvmfunc|
  llvm.func @n14_extrause(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.ashr %arg0, %3  : i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.trunc %4 : i64 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.sub %1, %arg1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %5, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.lshr %7, %6  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_n14_extrause   : n14_extrause_before  ⊑  n14_extrause_combined := by
  unfold n14_extrause_before n14_extrause_combined
  simp_alive_peephole
  sorry
