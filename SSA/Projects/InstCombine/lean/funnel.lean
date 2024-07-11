import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  funnel
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fshl_i32_constant_before := [llvmfunc|
  llvm.func @fshl_i32_constant(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.constant(21 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.lshr %arg1, %1  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

def fshr_i42_constant_before := [llvmfunc|
  llvm.func @fshr_i42_constant(%arg0: i42, %arg1: i42) -> i42 {
    %0 = llvm.mlir.constant(31 : i42) : i42
    %1 = llvm.mlir.constant(11 : i42) : i42
    %2 = llvm.lshr %arg0, %0  : i42
    %3 = llvm.shl %arg1, %1  : i42
    %4 = llvm.or %2, %3  : i42
    llvm.return %4 : i42
  }]

def fshl_v2i16_constant_splat_before := [llvmfunc|
  llvm.func @fshl_v2i16_constant_splat(%arg0: vector<2xi16>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.shl %arg0, %0  : vector<2xi16>
    %3 = llvm.lshr %arg1, %1  : vector<2xi16>
    %4 = llvm.or %2, %3  : vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def fshl_v2i16_constant_splat_poison0_before := [llvmfunc|
  llvm.func @fshl_v2i16_constant_splat_poison0(%arg0: vector<2xi16>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi16>
    %7 = llvm.mlir.constant(dense<15> : vector<2xi16>) : vector<2xi16>
    %8 = llvm.shl %arg0, %6  : vector<2xi16>
    %9 = llvm.lshr %arg1, %7  : vector<2xi16>
    %10 = llvm.or %8, %9  : vector<2xi16>
    llvm.return %10 : vector<2xi16>
  }]

def fshl_v2i16_constant_splat_poison1_before := [llvmfunc|
  llvm.func @fshl_v2i16_constant_splat_poison1(%arg0: vector<2xi16>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.constant(15 : i16) : i16
    %3 = llvm.mlir.undef : vector<2xi16>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi16>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi16>
    %8 = llvm.shl %arg0, %0  : vector<2xi16>
    %9 = llvm.lshr %arg1, %7  : vector<2xi16>
    %10 = llvm.or %8, %9  : vector<2xi16>
    llvm.return %10 : vector<2xi16>
  }]

def fshr_v2i17_constant_splat_before := [llvmfunc|
  llvm.func @fshr_v2i17_constant_splat(%arg0: vector<2xi17>, %arg1: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.constant(12 : i17) : i17
    %1 = llvm.mlir.constant(dense<12> : vector<2xi17>) : vector<2xi17>
    %2 = llvm.mlir.constant(5 : i17) : i17
    %3 = llvm.mlir.constant(dense<5> : vector<2xi17>) : vector<2xi17>
    %4 = llvm.lshr %arg0, %1  : vector<2xi17>
    %5 = llvm.shl %arg1, %3  : vector<2xi17>
    %6 = llvm.or %4, %5  : vector<2xi17>
    llvm.return %6 : vector<2xi17>
  }]

def fshr_v2i17_constant_splat_poison0_before := [llvmfunc|
  llvm.func @fshr_v2i17_constant_splat_poison0(%arg0: vector<2xi17>, %arg1: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.poison : i17
    %1 = llvm.mlir.constant(12 : i17) : i17
    %2 = llvm.mlir.undef : vector<2xi17>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi17>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi17>
    %7 = llvm.mlir.constant(5 : i17) : i17
    %8 = llvm.mlir.undef : vector<2xi17>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<2xi17>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %7, %10[%11 : i32] : vector<2xi17>
    %13 = llvm.lshr %arg0, %6  : vector<2xi17>
    %14 = llvm.shl %arg1, %12  : vector<2xi17>
    %15 = llvm.or %13, %14  : vector<2xi17>
    llvm.return %15 : vector<2xi17>
  }]

def fshr_v2i17_constant_splat_poison1_before := [llvmfunc|
  llvm.func @fshr_v2i17_constant_splat_poison1(%arg0: vector<2xi17>, %arg1: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.poison : i17
    %1 = llvm.mlir.constant(12 : i17) : i17
    %2 = llvm.mlir.undef : vector<2xi17>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi17>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi17>
    %7 = llvm.mlir.constant(5 : i17) : i17
    %8 = llvm.mlir.undef : vector<2xi17>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi17>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi17>
    %13 = llvm.lshr %arg0, %6  : vector<2xi17>
    %14 = llvm.shl %arg1, %12  : vector<2xi17>
    %15 = llvm.or %13, %14  : vector<2xi17>
    llvm.return %15 : vector<2xi17>
  }]

def fshr_v2i32_constant_nonsplat_before := [llvmfunc|
  llvm.func @fshr_v2i32_constant_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[17, 19]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[15, 13]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.shl %arg1, %1  : vector<2xi32>
    %4 = llvm.or %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def fshr_v2i32_constant_nonsplat_poison0_before := [llvmfunc|
  llvm.func @fshr_v2i32_constant_nonsplat_poison0(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(19 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<[15, 13]> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.lshr %arg0, %6  : vector<2xi32>
    %9 = llvm.shl %arg1, %7  : vector<2xi32>
    %10 = llvm.or %9, %8  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def fshr_v2i32_constant_nonsplat_poison1_before := [llvmfunc|
  llvm.func @fshr_v2i32_constant_nonsplat_poison1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[17, 19]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.lshr %arg0, %0  : vector<2xi32>
    %9 = llvm.shl %arg1, %7  : vector<2xi32>
    %10 = llvm.or %9, %8  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def fshl_v2i36_constant_nonsplat_before := [llvmfunc|
  llvm.func @fshl_v2i36_constant_nonsplat(%arg0: vector<2xi36>, %arg1: vector<2xi36>) -> vector<2xi36> {
    %0 = llvm.mlir.constant(11 : i36) : i36
    %1 = llvm.mlir.constant(21 : i36) : i36
    %2 = llvm.mlir.constant(dense<[21, 11]> : vector<2xi36>) : vector<2xi36>
    %3 = llvm.mlir.constant(25 : i36) : i36
    %4 = llvm.mlir.constant(15 : i36) : i36
    %5 = llvm.mlir.constant(dense<[15, 25]> : vector<2xi36>) : vector<2xi36>
    %6 = llvm.shl %arg0, %2  : vector<2xi36>
    %7 = llvm.lshr %arg1, %5  : vector<2xi36>
    %8 = llvm.or %6, %7  : vector<2xi36>
    llvm.return %8 : vector<2xi36>
  }]

def fshl_v3i36_constant_nonsplat_poison0_before := [llvmfunc|
  llvm.func @fshl_v3i36_constant_nonsplat_poison0(%arg0: vector<3xi36>, %arg1: vector<3xi36>) -> vector<3xi36> {
    %0 = llvm.mlir.poison : i36
    %1 = llvm.mlir.constant(11 : i36) : i36
    %2 = llvm.mlir.constant(21 : i36) : i36
    %3 = llvm.mlir.undef : vector<3xi36>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi36>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi36>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi36>
    %10 = llvm.mlir.constant(25 : i36) : i36
    %11 = llvm.mlir.constant(15 : i36) : i36
    %12 = llvm.mlir.undef : vector<3xi36>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = llvm.insertelement %11, %12[%13 : i32] : vector<3xi36>
    %15 = llvm.mlir.constant(1 : i32) : i32
    %16 = llvm.insertelement %10, %14[%15 : i32] : vector<3xi36>
    %17 = llvm.mlir.constant(2 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<3xi36>
    %19 = llvm.shl %arg0, %9  : vector<3xi36>
    %20 = llvm.lshr %arg1, %18  : vector<3xi36>
    %21 = llvm.or %19, %20  : vector<3xi36>
    llvm.return %21 : vector<3xi36>
  }]

def fshl_sub_mask_before := [llvmfunc|
  llvm.func @fshl_sub_mask(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(64 : i64) : i64
    %2 = llvm.and %arg2, %0  : i64
    %3 = llvm.shl %arg0, %2  : i64
    %4 = llvm.sub %1, %2 overflow<nsw, nuw>  : i64
    %5 = llvm.lshr %arg1, %4  : i64
    %6 = llvm.or %3, %5  : i64
    llvm.return %6 : i64
  }]

def fshr_sub_mask_before := [llvmfunc|
  llvm.func @fshr_sub_mask(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(64 : i64) : i64
    %2 = llvm.and %arg2, %0  : i64
    %3 = llvm.lshr %arg0, %2  : i64
    %4 = llvm.sub %1, %2 overflow<nsw, nuw>  : i64
    %5 = llvm.shl %arg1, %4  : i64
    %6 = llvm.or %5, %3  : i64
    llvm.return %6 : i64
  }]

def fshr_sub_mask_vector_before := [llvmfunc|
  llvm.func @fshr_sub_mask_vector(%arg0: vector<2xi64>, %arg1: vector<2xi64>, %arg2: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<63> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<64> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.and %arg2, %0  : vector<2xi64>
    %3 = llvm.lshr %arg0, %2  : vector<2xi64>
    %4 = llvm.sub %1, %2 overflow<nsw, nuw>  : vector<2xi64>
    %5 = llvm.shl %arg1, %4  : vector<2xi64>
    %6 = llvm.or %5, %3  : vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }]

def fshl_16bit_before := [llvmfunc|
  llvm.func @fshl_16bit(%arg0: i16, %arg1: i16, %arg2: i32) -> i16 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.and %arg2, %0  : i32
    %3 = llvm.zext %arg0 : i16 to i32
    %4 = llvm.shl %3, %2  : i32
    %5 = llvm.sub %1, %2  : i32
    %6 = llvm.zext %arg1 : i16 to i32
    %7 = llvm.lshr %6, %5  : i32
    %8 = llvm.or %7, %4  : i32
    %9 = llvm.trunc %8 : i32 to i16
    llvm.return %9 : i16
  }]

def fshl_commute_16bit_vec_before := [llvmfunc|
  llvm.func @fshl_commute_16bit_vec(%arg0: vector<2xi16>, %arg1: vector<2xi16>, %arg2: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg2, %0  : vector<2xi32>
    %3 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %4 = llvm.shl %3, %2  : vector<2xi32>
    %5 = llvm.sub %1, %2  : vector<2xi32>
    %6 = llvm.zext %arg1 : vector<2xi16> to vector<2xi32>
    %7 = llvm.lshr %6, %5  : vector<2xi32>
    %8 = llvm.or %4, %7  : vector<2xi32>
    %9 = llvm.trunc %8 : vector<2xi32> to vector<2xi16>
    llvm.return %9 : vector<2xi16>
  }]

def fshr_8bit_before := [llvmfunc|
  llvm.func @fshr_8bit(%arg0: i8, %arg1: i8, %arg2: i3) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.zext %arg2 : i3 to i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.lshr %2, %1  : i32
    %4 = llvm.sub %0, %1  : i32
    %5 = llvm.zext %arg1 : i8 to i32
    %6 = llvm.shl %5, %4  : i32
    %7 = llvm.or %6, %3  : i32
    %8 = llvm.trunc %7 : i32 to i8
    llvm.return %8 : i8
  }]

def fshr_commute_8bit_before := [llvmfunc|
  llvm.func @fshr_commute_8bit(%arg0: i32, %arg1: i32, %arg2: i32) -> i8 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg2, %0  : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.lshr %4, %3  : i32
    %6 = llvm.sub %2, %3  : i32
    %7 = llvm.and %arg1, %1  : i32
    %8 = llvm.shl %7, %6  : i32
    %9 = llvm.or %5, %8  : i32
    %10 = llvm.trunc %9 : i32 to i8
    llvm.return %10 : i8
  }]

def fshr_commute_8bit_unmasked_shl_before := [llvmfunc|
  llvm.func @fshr_commute_8bit_unmasked_shl(%arg0: i32, %arg1: i32, %arg2: i32) -> i8 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg2, %0  : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.lshr %4, %3  : i32
    %6 = llvm.sub %2, %3  : i32
    %7 = llvm.and %arg1, %1  : i32
    %8 = llvm.shl %arg1, %6  : i32
    %9 = llvm.or %5, %8  : i32
    %10 = llvm.trunc %9 : i32 to i8
    llvm.return %10 : i8
  }]

def fshr_select_before := [llvmfunc|
  llvm.func @fshr_select(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(8 : i8) : i8
    %2 = llvm.icmp "eq" %arg2, %0 : i8
    %3 = llvm.sub %1, %arg2  : i8
    %4 = llvm.lshr %arg1, %arg2  : i8
    %5 = llvm.shl %arg0, %3  : i8
    %6 = llvm.or %5, %4  : i8
    %7 = llvm.select %2, %arg1, %6 : i1, i8
    llvm.return %7 : i8
  }]

def fshl_select_before := [llvmfunc|
  llvm.func @fshl_select(%arg0: i16, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(16 : i16) : i16
    %2 = llvm.icmp "eq" %arg2, %0 : i16
    %3 = llvm.sub %1, %arg2  : i16
    %4 = llvm.lshr %arg1, %3  : i16
    %5 = llvm.shl %arg0, %arg2  : i16
    %6 = llvm.or %4, %5  : i16
    %7 = llvm.select %2, %arg0, %6 : i1, i16
    llvm.return %7 : i16
  }]

def fshl_select_vector_before := [llvmfunc|
  llvm.func @fshl_select_vector(%arg0: vector<2xi64>, %arg1: vector<2xi64>, %arg2: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<64> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.icmp "eq" %arg2, %1 : vector<2xi64>
    %4 = llvm.sub %2, %arg2  : vector<2xi64>
    %5 = llvm.lshr %arg0, %4  : vector<2xi64>
    %6 = llvm.shl %arg1, %arg2  : vector<2xi64>
    %7 = llvm.or %6, %5  : vector<2xi64>
    %8 = llvm.select %3, %arg1, %7 : vector<2xi1>, vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }]

def fshl_concat_i8_i24_before := [llvmfunc|
  llvm.func @fshl_concat_i8_i24(%arg0: i8, %arg1: i24, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.zext %arg1 : i24 to i32
    %5 = llvm.or %4, %3  : i32
    llvm.store %5, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %6 = llvm.shl %4, %1  : i32
    %7 = llvm.or %2, %6  : i32
    llvm.return %7 : i32
  }]

def fshl_concat_i8_i8_before := [llvmfunc|
  llvm.func @fshl_concat_i8_i8(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.mlir.constant(19 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.or %4, %3  : i32
    llvm.store %5, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %6 = llvm.shl %4, %1  : i32
    %7 = llvm.or %2, %6  : i32
    llvm.return %7 : i32
  }]

def fshl_concat_i8_i8_overlap_before := [llvmfunc|
  llvm.func @fshl_concat_i8_i8_overlap(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.or %4, %3  : i32
    llvm.store %5, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %6 = llvm.shl %4, %1  : i32
    %7 = llvm.or %2, %6  : i32
    llvm.return %7 : i32
  }]

def fshl_concat_i8_i8_drop_before := [llvmfunc|
  llvm.func @fshl_concat_i8_i8_drop(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(25 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.or %4, %3  : i32
    llvm.store %5, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %6 = llvm.shl %4, %1  : i32
    %7 = llvm.or %2, %6  : i32
    llvm.return %7 : i32
  }]

def fshl_concat_i8_i8_different_slot_before := [llvmfunc|
  llvm.func @fshl_concat_i8_i8_different_slot(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(22 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.or %4, %3  : i32
    llvm.store %5, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %6 = llvm.shl %4, %1  : i32
    %7 = llvm.or %2, %6  : i32
    llvm.return %7 : i32
  }]

def fshl_concat_unknown_source_before := [llvmfunc|
  llvm.func @fshl_concat_unknown_source(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.or %arg1, %1  : i32
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.shl %arg1, %0  : i32
    %4 = llvm.or %arg0, %3  : i32
    llvm.return %4 : i32
  }]

def fshl_concat_vector_before := [llvmfunc|
  llvm.func @fshl_concat_vector(%arg0: vector<2xi8>, %arg1: vector<2xi24>, %arg2: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<24> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %3 = llvm.shl %2, %0  : vector<2xi32>
    %4 = llvm.zext %arg1 : vector<2xi24> to vector<2xi32>
    %5 = llvm.or %3, %4  : vector<2xi32>
    llvm.store %5, %arg2 {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr]

    %6 = llvm.shl %4, %1  : vector<2xi32>
    %7 = llvm.or %6, %2  : vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def unmasked_shlop_unmasked_shift_amount_before := [llvmfunc|
  llvm.func @unmasked_shlop_unmasked_shift_amount(%arg0: i32, %arg1: i32, %arg2: i32) -> i8 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.sub %1, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.lshr %2, %arg2  : i32
    %6 = llvm.or %4, %5  : i32
    %7 = llvm.trunc %6 : i32 to i8
    llvm.return %7 : i8
  }]

def unmasked_shlop_insufficient_mask_shift_amount_before := [llvmfunc|
  llvm.func @unmasked_shlop_insufficient_mask_shift_amount(%arg0: i16, %arg1: i16, %arg2: i16) -> i8 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.mlir.constant(255 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.and %arg2, %0  : i16
    %4 = llvm.and %arg0, %1  : i16
    %5 = llvm.sub %2, %3  : i16
    %6 = llvm.shl %arg1, %5  : i16
    %7 = llvm.lshr %4, %3  : i16
    %8 = llvm.or %6, %7  : i16
    %9 = llvm.trunc %8 : i16 to i8
    llvm.return %9 : i8
  }]

def unmasked_shlop_masked_shift_amount_before := [llvmfunc|
  llvm.func @unmasked_shlop_masked_shift_amount(%arg0: i16, %arg1: i16, %arg2: i16) -> i8 {
    %0 = llvm.mlir.constant(7 : i16) : i16
    %1 = llvm.mlir.constant(255 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.and %arg2, %0  : i16
    %4 = llvm.and %arg0, %1  : i16
    %5 = llvm.sub %2, %3  : i16
    %6 = llvm.shl %arg1, %5  : i16
    %7 = llvm.lshr %4, %3  : i16
    %8 = llvm.or %6, %7  : i16
    %9 = llvm.trunc %8 : i16 to i8
    llvm.return %9 : i8
  }]

def test_rotl_and_neg_before := [llvmfunc|
  llvm.func @test_rotl_and_neg(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.lshr %arg0, %4  : i32
    %6 = llvm.or %2, %5  : i32
    llvm.return %6 : i32
  }]

def test_rotl_and_neg_commuted_before := [llvmfunc|
  llvm.func @test_rotl_and_neg_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.lshr %arg0, %4  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

def test_rotr_and_neg_before := [llvmfunc|
  llvm.func @test_rotr_and_neg(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.shl %arg0, %4  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

def test_fshl_and_neg_before := [llvmfunc|
  llvm.func @test_fshl_and_neg(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.shl %arg0, %arg2  : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.lshr %arg1, %4  : i32
    %6 = llvm.or %2, %5  : i32
    llvm.return %6 : i32
  }]

def test_rotl_and_neg_wrong_mask_before := [llvmfunc|
  llvm.func @test_rotl_and_neg_wrong_mask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.lshr %arg0, %4  : i32
    %6 = llvm.or %2, %5  : i32
    llvm.return %6 : i32
  }]

def fshl_i32_constant_combined := [llvmfunc|
  llvm.func @fshl_i32_constant(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i32, i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_fshl_i32_constant   : fshl_i32_constant_before  ⊑  fshl_i32_constant_combined := by
  unfold fshl_i32_constant_before fshl_i32_constant_combined
  simp_alive_peephole
  sorry
def fshr_i42_constant_combined := [llvmfunc|
  llvm.func @fshr_i42_constant(%arg0: i42, %arg1: i42) -> i42 {
    %0 = llvm.mlir.constant(11 : i42) : i42
    %1 = llvm.intr.fshl(%arg1, %arg0, %0)  : (i42, i42, i42) -> i42
    llvm.return %1 : i42
  }]

theorem inst_combine_fshr_i42_constant   : fshr_i42_constant_before  ⊑  fshr_i42_constant_combined := by
  unfold fshr_i42_constant_before fshr_i42_constant_combined
  simp_alive_peephole
  sorry
def fshl_v2i16_constant_splat_combined := [llvmfunc|
  llvm.func @fshl_v2i16_constant_splat(%arg0: vector<2xi16>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (vector<2xi16>, vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

theorem inst_combine_fshl_v2i16_constant_splat   : fshl_v2i16_constant_splat_before  ⊑  fshl_v2i16_constant_splat_combined := by
  unfold fshl_v2i16_constant_splat_before fshl_v2i16_constant_splat_combined
  simp_alive_peephole
  sorry
def fshl_v2i16_constant_splat_poison0_combined := [llvmfunc|
  llvm.func @fshl_v2i16_constant_splat_poison0(%arg0: vector<2xi16>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (vector<2xi16>, vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

theorem inst_combine_fshl_v2i16_constant_splat_poison0   : fshl_v2i16_constant_splat_poison0_before  ⊑  fshl_v2i16_constant_splat_poison0_combined := by
  unfold fshl_v2i16_constant_splat_poison0_before fshl_v2i16_constant_splat_poison0_combined
  simp_alive_peephole
  sorry
def fshl_v2i16_constant_splat_poison1_combined := [llvmfunc|
  llvm.func @fshl_v2i16_constant_splat_poison1(%arg0: vector<2xi16>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (vector<2xi16>, vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

theorem inst_combine_fshl_v2i16_constant_splat_poison1   : fshl_v2i16_constant_splat_poison1_before  ⊑  fshl_v2i16_constant_splat_poison1_combined := by
  unfold fshl_v2i16_constant_splat_poison1_before fshl_v2i16_constant_splat_poison1_combined
  simp_alive_peephole
  sorry
def fshr_v2i17_constant_splat_combined := [llvmfunc|
  llvm.func @fshr_v2i17_constant_splat(%arg0: vector<2xi17>, %arg1: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.constant(5 : i17) : i17
    %1 = llvm.mlir.constant(dense<5> : vector<2xi17>) : vector<2xi17>
    %2 = llvm.intr.fshl(%arg1, %arg0, %1)  : (vector<2xi17>, vector<2xi17>, vector<2xi17>) -> vector<2xi17>
    llvm.return %2 : vector<2xi17>
  }]

theorem inst_combine_fshr_v2i17_constant_splat   : fshr_v2i17_constant_splat_before  ⊑  fshr_v2i17_constant_splat_combined := by
  unfold fshr_v2i17_constant_splat_before fshr_v2i17_constant_splat_combined
  simp_alive_peephole
  sorry
def fshr_v2i17_constant_splat_poison0_combined := [llvmfunc|
  llvm.func @fshr_v2i17_constant_splat_poison0(%arg0: vector<2xi17>, %arg1: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.constant(5 : i17) : i17
    %1 = llvm.mlir.constant(dense<5> : vector<2xi17>) : vector<2xi17>
    %2 = llvm.intr.fshl(%arg1, %arg0, %1)  : (vector<2xi17>, vector<2xi17>, vector<2xi17>) -> vector<2xi17>
    llvm.return %2 : vector<2xi17>
  }]

theorem inst_combine_fshr_v2i17_constant_splat_poison0   : fshr_v2i17_constant_splat_poison0_before  ⊑  fshr_v2i17_constant_splat_poison0_combined := by
  unfold fshr_v2i17_constant_splat_poison0_before fshr_v2i17_constant_splat_poison0_combined
  simp_alive_peephole
  sorry
def fshr_v2i17_constant_splat_poison1_combined := [llvmfunc|
  llvm.func @fshr_v2i17_constant_splat_poison1(%arg0: vector<2xi17>, %arg1: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.constant(5 : i17) : i17
    %1 = llvm.mlir.constant(dense<5> : vector<2xi17>) : vector<2xi17>
    %2 = llvm.intr.fshl(%arg1, %arg0, %1)  : (vector<2xi17>, vector<2xi17>, vector<2xi17>) -> vector<2xi17>
    llvm.return %2 : vector<2xi17>
  }]

theorem inst_combine_fshr_v2i17_constant_splat_poison1   : fshr_v2i17_constant_splat_poison1_before  ⊑  fshr_v2i17_constant_splat_poison1_combined := by
  unfold fshr_v2i17_constant_splat_poison1_before fshr_v2i17_constant_splat_poison1_combined
  simp_alive_peephole
  sorry
def fshr_v2i32_constant_nonsplat_combined := [llvmfunc|
  llvm.func @fshr_v2i32_constant_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[15, 13]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.fshl(%arg1, %arg0, %0)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_fshr_v2i32_constant_nonsplat   : fshr_v2i32_constant_nonsplat_before  ⊑  fshr_v2i32_constant_nonsplat_combined := by
  unfold fshr_v2i32_constant_nonsplat_before fshr_v2i32_constant_nonsplat_combined
  simp_alive_peephole
  sorry
def fshr_v2i32_constant_nonsplat_poison0_combined := [llvmfunc|
  llvm.func @fshr_v2i32_constant_nonsplat_poison0(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[0, 13]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.fshl(%arg1, %arg0, %0)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_fshr_v2i32_constant_nonsplat_poison0   : fshr_v2i32_constant_nonsplat_poison0_before  ⊑  fshr_v2i32_constant_nonsplat_poison0_combined := by
  unfold fshr_v2i32_constant_nonsplat_poison0_before fshr_v2i32_constant_nonsplat_poison0_combined
  simp_alive_peephole
  sorry
def fshr_v2i32_constant_nonsplat_poison1_combined := [llvmfunc|
  llvm.func @fshr_v2i32_constant_nonsplat_poison1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.intr.fshl(%arg1, %arg0, %6)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

theorem inst_combine_fshr_v2i32_constant_nonsplat_poison1   : fshr_v2i32_constant_nonsplat_poison1_before  ⊑  fshr_v2i32_constant_nonsplat_poison1_combined := by
  unfold fshr_v2i32_constant_nonsplat_poison1_before fshr_v2i32_constant_nonsplat_poison1_combined
  simp_alive_peephole
  sorry
def fshl_v2i36_constant_nonsplat_combined := [llvmfunc|
  llvm.func @fshl_v2i36_constant_nonsplat(%arg0: vector<2xi36>, %arg1: vector<2xi36>) -> vector<2xi36> {
    %0 = llvm.mlir.constant(11 : i36) : i36
    %1 = llvm.mlir.constant(21 : i36) : i36
    %2 = llvm.mlir.constant(dense<[21, 11]> : vector<2xi36>) : vector<2xi36>
    %3 = llvm.intr.fshl(%arg0, %arg1, %2)  : (vector<2xi36>, vector<2xi36>, vector<2xi36>) -> vector<2xi36>
    llvm.return %3 : vector<2xi36>
  }]

theorem inst_combine_fshl_v2i36_constant_nonsplat   : fshl_v2i36_constant_nonsplat_before  ⊑  fshl_v2i36_constant_nonsplat_combined := by
  unfold fshl_v2i36_constant_nonsplat_before fshl_v2i36_constant_nonsplat_combined
  simp_alive_peephole
  sorry
def fshl_v3i36_constant_nonsplat_poison0_combined := [llvmfunc|
  llvm.func @fshl_v3i36_constant_nonsplat_poison0(%arg0: vector<3xi36>, %arg1: vector<3xi36>) -> vector<3xi36> {
    %0 = llvm.mlir.poison : i36
    %1 = llvm.mlir.constant(11 : i36) : i36
    %2 = llvm.mlir.constant(21 : i36) : i36
    %3 = llvm.mlir.undef : vector<3xi36>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi36>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi36>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi36>
    %10 = llvm.intr.fshl(%arg0, %arg1, %9)  : (vector<3xi36>, vector<3xi36>, vector<3xi36>) -> vector<3xi36>
    llvm.return %10 : vector<3xi36>
  }]

theorem inst_combine_fshl_v3i36_constant_nonsplat_poison0   : fshl_v3i36_constant_nonsplat_poison0_before  ⊑  fshl_v3i36_constant_nonsplat_poison0_combined := by
  unfold fshl_v3i36_constant_nonsplat_poison0_before fshl_v3i36_constant_nonsplat_poison0_combined
  simp_alive_peephole
  sorry
def fshl_sub_mask_combined := [llvmfunc|
  llvm.func @fshl_sub_mask(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg2)  : (i64, i64, i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_fshl_sub_mask   : fshl_sub_mask_before  ⊑  fshl_sub_mask_combined := by
  unfold fshl_sub_mask_before fshl_sub_mask_combined
  simp_alive_peephole
  sorry
def fshr_sub_mask_combined := [llvmfunc|
  llvm.func @fshr_sub_mask(%arg0: i64, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.intr.fshr(%arg1, %arg0, %arg2)  : (i64, i64, i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_fshr_sub_mask   : fshr_sub_mask_before  ⊑  fshr_sub_mask_combined := by
  unfold fshr_sub_mask_before fshr_sub_mask_combined
  simp_alive_peephole
  sorry
def fshr_sub_mask_vector_combined := [llvmfunc|
  llvm.func @fshr_sub_mask_vector(%arg0: vector<2xi64>, %arg1: vector<2xi64>, %arg2: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.intr.fshr(%arg1, %arg0, %arg2)  : (vector<2xi64>, vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_fshr_sub_mask_vector   : fshr_sub_mask_vector_before  ⊑  fshr_sub_mask_vector_combined := by
  unfold fshr_sub_mask_vector_before fshr_sub_mask_vector_combined
  simp_alive_peephole
  sorry
def fshl_16bit_combined := [llvmfunc|
  llvm.func @fshl_16bit(%arg0: i16, %arg1: i16, %arg2: i32) -> i16 {
    %0 = llvm.trunc %arg2 : i32 to i16
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i16, i16, i16) -> i16
    llvm.return %1 : i16
  }]

theorem inst_combine_fshl_16bit   : fshl_16bit_before  ⊑  fshl_16bit_combined := by
  unfold fshl_16bit_before fshl_16bit_combined
  simp_alive_peephole
  sorry
def fshl_commute_16bit_vec_combined := [llvmfunc|
  llvm.func @fshl_commute_16bit_vec(%arg0: vector<2xi16>, %arg1: vector<2xi16>, %arg2: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.trunc %arg2 : vector<2xi32> to vector<2xi16>
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (vector<2xi16>, vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

theorem inst_combine_fshl_commute_16bit_vec   : fshl_commute_16bit_vec_before  ⊑  fshl_commute_16bit_vec_combined := by
  unfold fshl_commute_16bit_vec_before fshl_commute_16bit_vec_combined
  simp_alive_peephole
  sorry
def fshr_8bit_combined := [llvmfunc|
  llvm.func @fshr_8bit(%arg0: i8, %arg1: i8, %arg2: i3) -> i8 {
    %0 = llvm.zext %arg2 : i3 to i8
    %1 = llvm.intr.fshr(%arg1, %arg0, %0)  : (i8, i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_fshr_8bit   : fshr_8bit_before  ⊑  fshr_8bit_combined := by
  unfold fshr_8bit_before fshr_8bit_combined
  simp_alive_peephole
  sorry
def fshr_commute_8bit_combined := [llvmfunc|
  llvm.func @fshr_commute_8bit(%arg0: i32, %arg1: i32, %arg2: i32) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.trunc %arg2 : i32 to i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.trunc %arg1 : i32 to i8
    %4 = llvm.trunc %arg0 : i32 to i8
    %5 = llvm.intr.fshr(%3, %4, %2)  : (i8, i8, i8) -> i8
    llvm.return %5 : i8
  }]

theorem inst_combine_fshr_commute_8bit   : fshr_commute_8bit_before  ⊑  fshr_commute_8bit_combined := by
  unfold fshr_commute_8bit_before fshr_commute_8bit_combined
  simp_alive_peephole
  sorry
def fshr_commute_8bit_unmasked_shl_combined := [llvmfunc|
  llvm.func @fshr_commute_8bit_unmasked_shl(%arg0: i32, %arg1: i32, %arg2: i32) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.trunc %arg2 : i32 to i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.trunc %arg1 : i32 to i8
    %4 = llvm.trunc %arg0 : i32 to i8
    %5 = llvm.intr.fshr(%3, %4, %2)  : (i8, i8, i8) -> i8
    llvm.return %5 : i8
  }]

theorem inst_combine_fshr_commute_8bit_unmasked_shl   : fshr_commute_8bit_unmasked_shl_before  ⊑  fshr_commute_8bit_unmasked_shl_combined := by
  unfold fshr_commute_8bit_unmasked_shl_before fshr_commute_8bit_unmasked_shl_combined
  simp_alive_peephole
  sorry
def fshr_select_combined := [llvmfunc|
  llvm.func @fshr_select(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.freeze %arg0 : i8
    %1 = llvm.intr.fshr(%0, %arg1, %arg2)  : (i8, i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_fshr_select   : fshr_select_before  ⊑  fshr_select_combined := by
  unfold fshr_select_before fshr_select_combined
  simp_alive_peephole
  sorry
def fshl_select_combined := [llvmfunc|
  llvm.func @fshl_select(%arg0: i16, %arg1: i16, %arg2: i16) -> i16 {
    %0 = llvm.freeze %arg1 : i16
    %1 = llvm.intr.fshl(%arg0, %0, %arg2)  : (i16, i16, i16) -> i16
    llvm.return %1 : i16
  }]

theorem inst_combine_fshl_select   : fshl_select_before  ⊑  fshl_select_combined := by
  unfold fshl_select_before fshl_select_combined
  simp_alive_peephole
  sorry
def fshl_select_vector_combined := [llvmfunc|
  llvm.func @fshl_select_vector(%arg0: vector<2xi64>, %arg1: vector<2xi64>, %arg2: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.freeze %arg0 : vector<2xi64>
    %1 = llvm.intr.fshl(%arg1, %0, %arg2)  : (vector<2xi64>, vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

theorem inst_combine_fshl_select_vector   : fshl_select_vector_before  ⊑  fshl_select_vector_combined := by
  unfold fshl_select_vector_before fshl_select_vector_combined
  simp_alive_peephole
  sorry
def fshl_concat_i8_i24_combined := [llvmfunc|
  llvm.func @fshl_concat_i8_i24(%arg0: i8, %arg1: i24, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.shl %2, %0 overflow<nuw>  : i32
    %4 = llvm.zext %arg1 : i24 to i32
    %5 = llvm.or %3, %4  : i32
    llvm.store %5, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fshl_concat_i8_i24   : fshl_concat_i8_i24_before  ⊑  fshl_concat_i8_i24_combined := by
  unfold fshl_concat_i8_i24_before fshl_concat_i8_i24_combined
  simp_alive_peephole
  sorry
    %6 = llvm.intr.fshl(%5, %5, %1)  : (i32, i32, i32) -> i32
    llvm.return %6 : i32
  }]

theorem inst_combine_fshl_concat_i8_i24   : fshl_concat_i8_i24_before  ⊑  fshl_concat_i8_i24_combined := by
  unfold fshl_concat_i8_i24_before fshl_concat_i8_i24_combined
  simp_alive_peephole
  sorry
def fshl_concat_i8_i8_combined := [llvmfunc|
  llvm.func @fshl_concat_i8_i8(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.mlir.constant(19 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.shl %2, %0 overflow<nsw, nuw>  : i32
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.or %3, %4  : i32
    llvm.store %5, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fshl_concat_i8_i8   : fshl_concat_i8_i8_before  ⊑  fshl_concat_i8_i8_combined := by
  unfold fshl_concat_i8_i8_before fshl_concat_i8_i8_combined
  simp_alive_peephole
  sorry
    %6 = llvm.intr.fshl(%5, %5, %1)  : (i32, i32, i32) -> i32
    llvm.return %6 : i32
  }]

theorem inst_combine_fshl_concat_i8_i8   : fshl_concat_i8_i8_before  ⊑  fshl_concat_i8_i8_combined := by
  unfold fshl_concat_i8_i8_before fshl_concat_i8_i8_combined
  simp_alive_peephole
  sorry
def fshl_concat_i8_i8_overlap_combined := [llvmfunc|
  llvm.func @fshl_concat_i8_i8_overlap(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.or %3, %4  : i32
    llvm.store %5, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fshl_concat_i8_i8_overlap   : fshl_concat_i8_i8_overlap_before  ⊑  fshl_concat_i8_i8_overlap_combined := by
  unfold fshl_concat_i8_i8_overlap_before fshl_concat_i8_i8_overlap_combined
  simp_alive_peephole
  sorry
    %6 = llvm.shl %4, %1 overflow<nsw, nuw>  : i32
    %7 = llvm.or %6, %2  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_fshl_concat_i8_i8_overlap   : fshl_concat_i8_i8_overlap_before  ⊑  fshl_concat_i8_i8_overlap_combined := by
  unfold fshl_concat_i8_i8_overlap_before fshl_concat_i8_i8_overlap_combined
  simp_alive_peephole
  sorry
def fshl_concat_i8_i8_drop_combined := [llvmfunc|
  llvm.func @fshl_concat_i8_i8_drop(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(25 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.shl %2, %0 overflow<nsw, nuw>  : i32
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.or %3, %4  : i32
    llvm.store %5, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fshl_concat_i8_i8_drop   : fshl_concat_i8_i8_drop_before  ⊑  fshl_concat_i8_i8_drop_combined := by
  unfold fshl_concat_i8_i8_drop_before fshl_concat_i8_i8_drop_combined
  simp_alive_peephole
  sorry
    %6 = llvm.shl %4, %1  : i32
    %7 = llvm.or %6, %2  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_fshl_concat_i8_i8_drop   : fshl_concat_i8_i8_drop_before  ⊑  fshl_concat_i8_i8_drop_combined := by
  unfold fshl_concat_i8_i8_drop_before fshl_concat_i8_i8_drop_combined
  simp_alive_peephole
  sorry
def fshl_concat_i8_i8_different_slot_combined := [llvmfunc|
  llvm.func @fshl_concat_i8_i8_different_slot(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(22 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.shl %2, %0 overflow<nsw, nuw>  : i32
    %4 = llvm.zext %arg1 : i8 to i32
    %5 = llvm.or %3, %4  : i32
    llvm.store %5, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fshl_concat_i8_i8_different_slot   : fshl_concat_i8_i8_different_slot_before  ⊑  fshl_concat_i8_i8_different_slot_combined := by
  unfold fshl_concat_i8_i8_different_slot_before fshl_concat_i8_i8_different_slot_combined
  simp_alive_peephole
  sorry
    %6 = llvm.shl %4, %1 overflow<nsw, nuw>  : i32
    %7 = llvm.or %6, %2  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_fshl_concat_i8_i8_different_slot   : fshl_concat_i8_i8_different_slot_before  ⊑  fshl_concat_i8_i8_different_slot_combined := by
  unfold fshl_concat_i8_i8_different_slot_before fshl_concat_i8_i8_different_slot_combined
  simp_alive_peephole
  sorry
def fshl_concat_unknown_source_combined := [llvmfunc|
  llvm.func @fshl_concat_unknown_source(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fshl_concat_unknown_source   : fshl_concat_unknown_source_before  ⊑  fshl_concat_unknown_source_combined := by
  unfold fshl_concat_unknown_source_before fshl_concat_unknown_source_combined
  simp_alive_peephole
  sorry
    %3 = llvm.shl %arg1, %0  : i32
    %4 = llvm.or %3, %arg0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_fshl_concat_unknown_source   : fshl_concat_unknown_source_before  ⊑  fshl_concat_unknown_source_combined := by
  unfold fshl_concat_unknown_source_before fshl_concat_unknown_source_combined
  simp_alive_peephole
  sorry
def fshl_concat_vector_combined := [llvmfunc|
  llvm.func @fshl_concat_vector(%arg0: vector<2xi8>, %arg1: vector<2xi24>, %arg2: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<24> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %3 = llvm.shl %2, %0 overflow<nuw>  : vector<2xi32>
    %4 = llvm.zext %arg1 : vector<2xi24> to vector<2xi32>
    %5 = llvm.or %3, %4  : vector<2xi32>
    llvm.store %5, %arg2 {alignment = 4 : i64} : vector<2xi32>, !llvm.ptr]

theorem inst_combine_fshl_concat_vector   : fshl_concat_vector_before  ⊑  fshl_concat_vector_combined := by
  unfold fshl_concat_vector_before fshl_concat_vector_combined
  simp_alive_peephole
  sorry
    %6 = llvm.intr.fshl(%5, %5, %1)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

theorem inst_combine_fshl_concat_vector   : fshl_concat_vector_before  ⊑  fshl_concat_vector_combined := by
  unfold fshl_concat_vector_before fshl_concat_vector_combined
  simp_alive_peephole
  sorry
def unmasked_shlop_unmasked_shift_amount_combined := [llvmfunc|
  llvm.func @unmasked_shlop_unmasked_shift_amount(%arg0: i32, %arg1: i32, %arg2: i32) -> i8 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.sub %1, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.lshr %2, %arg2  : i32
    %6 = llvm.or %4, %5  : i32
    %7 = llvm.trunc %6 : i32 to i8
    llvm.return %7 : i8
  }]

theorem inst_combine_unmasked_shlop_unmasked_shift_amount   : unmasked_shlop_unmasked_shift_amount_before  ⊑  unmasked_shlop_unmasked_shift_amount_combined := by
  unfold unmasked_shlop_unmasked_shift_amount_before unmasked_shlop_unmasked_shift_amount_combined
  simp_alive_peephole
  sorry
def unmasked_shlop_insufficient_mask_shift_amount_combined := [llvmfunc|
  llvm.func @unmasked_shlop_insufficient_mask_shift_amount(%arg0: i16, %arg1: i16, %arg2: i16) -> i8 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.mlir.constant(255 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.and %arg2, %0  : i16
    %4 = llvm.and %arg0, %1  : i16
    %5 = llvm.sub %2, %3 overflow<nsw>  : i16
    %6 = llvm.shl %arg1, %5  : i16
    %7 = llvm.lshr %4, %3  : i16
    %8 = llvm.or %6, %7  : i16
    %9 = llvm.trunc %8 : i16 to i8
    llvm.return %9 : i8
  }]

theorem inst_combine_unmasked_shlop_insufficient_mask_shift_amount   : unmasked_shlop_insufficient_mask_shift_amount_before  ⊑  unmasked_shlop_insufficient_mask_shift_amount_combined := by
  unfold unmasked_shlop_insufficient_mask_shift_amount_before unmasked_shlop_insufficient_mask_shift_amount_combined
  simp_alive_peephole
  sorry
def unmasked_shlop_masked_shift_amount_combined := [llvmfunc|
  llvm.func @unmasked_shlop_masked_shift_amount(%arg0: i16, %arg1: i16, %arg2: i16) -> i8 {
    %0 = llvm.trunc %arg2 : i16 to i8
    %1 = llvm.trunc %arg1 : i16 to i8
    %2 = llvm.trunc %arg0 : i16 to i8
    %3 = llvm.intr.fshr(%1, %2, %0)  : (i8, i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_unmasked_shlop_masked_shift_amount   : unmasked_shlop_masked_shift_amount_before  ⊑  unmasked_shlop_masked_shift_amount_combined := by
  unfold unmasked_shlop_masked_shift_amount_before unmasked_shlop_masked_shift_amount_combined
  simp_alive_peephole
  sorry
def test_rotl_and_neg_combined := [llvmfunc|
  llvm.func @test_rotl_and_neg(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i32, i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_rotl_and_neg   : test_rotl_and_neg_before  ⊑  test_rotl_and_neg_combined := by
  unfold test_rotl_and_neg_before test_rotl_and_neg_combined
  simp_alive_peephole
  sorry
def test_rotl_and_neg_commuted_combined := [llvmfunc|
  llvm.func @test_rotl_and_neg_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i32, i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_rotl_and_neg_commuted   : test_rotl_and_neg_commuted_before  ⊑  test_rotl_and_neg_commuted_combined := by
  unfold test_rotl_and_neg_commuted_before test_rotl_and_neg_commuted_combined
  simp_alive_peephole
  sorry
def test_rotr_and_neg_combined := [llvmfunc|
  llvm.func @test_rotr_and_neg(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i32, i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_rotr_and_neg   : test_rotr_and_neg_before  ⊑  test_rotr_and_neg_combined := by
  unfold test_rotr_and_neg_before test_rotr_and_neg_combined
  simp_alive_peephole
  sorry
def test_fshl_and_neg_combined := [llvmfunc|
  llvm.func @test_fshl_and_neg(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.shl %arg0, %arg2  : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.lshr %arg1, %4  : i32
    %6 = llvm.or %2, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test_fshl_and_neg   : test_fshl_and_neg_before  ⊑  test_fshl_and_neg_combined := by
  unfold test_fshl_and_neg_before test_fshl_and_neg_combined
  simp_alive_peephole
  sorry
def test_rotl_and_neg_wrong_mask_combined := [llvmfunc|
  llvm.func @test_rotl_and_neg_wrong_mask(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.lshr %arg0, %4  : i32
    %6 = llvm.or %2, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test_rotl_and_neg_wrong_mask   : test_rotl_and_neg_wrong_mask_before  ⊑  test_rotl_and_neg_wrong_mask_combined := by
  unfold test_rotl_and_neg_wrong_mask_before test_rotl_and_neg_wrong_mask_combined
  simp_alive_peephole
  sorry
