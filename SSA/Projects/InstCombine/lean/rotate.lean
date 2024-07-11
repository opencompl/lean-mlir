import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  rotate
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def rotl_i32_constant_before := [llvmfunc|
  llvm.func @rotl_i32_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.constant(21 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

def rotr_i42_constant_before := [llvmfunc|
  llvm.func @rotr_i42_constant(%arg0: i42) -> i42 {
    %0 = llvm.mlir.constant(31 : i42) : i42
    %1 = llvm.mlir.constant(11 : i42) : i42
    %2 = llvm.shl %arg0, %0  : i42
    %3 = llvm.lshr %arg0, %1  : i42
    %4 = llvm.or %3, %2  : i42
    llvm.return %4 : i42
  }]

def rotr_i8_constant_commute_before := [llvmfunc|
  llvm.func @rotr_i8_constant_commute(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.lshr %arg0, %1  : i8
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }]

def rotl_i88_constant_commute_before := [llvmfunc|
  llvm.func @rotl_i88_constant_commute(%arg0: i88) -> i88 {
    %0 = llvm.mlir.constant(44 : i88) : i88
    %1 = llvm.shl %arg0, %0  : i88
    %2 = llvm.lshr %arg0, %0  : i88
    %3 = llvm.or %1, %2  : i88
    llvm.return %3 : i88
  }]

def rotl_v2i16_constant_splat_before := [llvmfunc|
  llvm.func @rotl_v2i16_constant_splat(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.shl %arg0, %0  : vector<2xi16>
    %3 = llvm.lshr %arg0, %1  : vector<2xi16>
    %4 = llvm.or %2, %3  : vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def rotl_v2i16_constant_splat_poison0_before := [llvmfunc|
  llvm.func @rotl_v2i16_constant_splat_poison0(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi16>
    %7 = llvm.mlir.constant(dense<15> : vector<2xi16>) : vector<2xi16>
    %8 = llvm.shl %arg0, %6  : vector<2xi16>
    %9 = llvm.lshr %arg0, %7  : vector<2xi16>
    %10 = llvm.or %8, %9  : vector<2xi16>
    llvm.return %10 : vector<2xi16>
  }]

def rotl_v2i16_constant_splat_poison1_before := [llvmfunc|
  llvm.func @rotl_v2i16_constant_splat_poison1(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.constant(15 : i16) : i16
    %3 = llvm.mlir.undef : vector<2xi16>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi16>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi16>
    %8 = llvm.shl %arg0, %0  : vector<2xi16>
    %9 = llvm.lshr %arg0, %7  : vector<2xi16>
    %10 = llvm.or %8, %9  : vector<2xi16>
    llvm.return %10 : vector<2xi16>
  }]

def rotr_v2i17_constant_splat_before := [llvmfunc|
  llvm.func @rotr_v2i17_constant_splat(%arg0: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.constant(12 : i17) : i17
    %1 = llvm.mlir.constant(dense<12> : vector<2xi17>) : vector<2xi17>
    %2 = llvm.mlir.constant(5 : i17) : i17
    %3 = llvm.mlir.constant(dense<5> : vector<2xi17>) : vector<2xi17>
    %4 = llvm.shl %arg0, %1  : vector<2xi17>
    %5 = llvm.lshr %arg0, %3  : vector<2xi17>
    %6 = llvm.or %5, %4  : vector<2xi17>
    llvm.return %6 : vector<2xi17>
  }]

def rotr_v2i17_constant_splat_poison0_before := [llvmfunc|
  llvm.func @rotr_v2i17_constant_splat_poison0(%arg0: vector<2xi17>) -> vector<2xi17> {
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
    %13 = llvm.shl %arg0, %6  : vector<2xi17>
    %14 = llvm.lshr %arg0, %12  : vector<2xi17>
    %15 = llvm.or %14, %13  : vector<2xi17>
    llvm.return %15 : vector<2xi17>
  }]

def rotr_v2i17_constant_splat_poison1_before := [llvmfunc|
  llvm.func @rotr_v2i17_constant_splat_poison1(%arg0: vector<2xi17>) -> vector<2xi17> {
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
    %13 = llvm.shl %arg0, %6  : vector<2xi17>
    %14 = llvm.lshr %arg0, %12  : vector<2xi17>
    %15 = llvm.or %14, %13  : vector<2xi17>
    llvm.return %15 : vector<2xi17>
  }]

def rotr_v2i32_constant_nonsplat_before := [llvmfunc|
  llvm.func @rotr_v2i32_constant_nonsplat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[17, 19]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[15, 13]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %arg0, %1  : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def rotr_v2i32_constant_nonsplat_poison0_before := [llvmfunc|
  llvm.func @rotr_v2i32_constant_nonsplat_poison0(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(19 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<[15, 13]> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.shl %arg0, %6  : vector<2xi32>
    %9 = llvm.lshr %arg0, %7  : vector<2xi32>
    %10 = llvm.or %8, %9  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def rotr_v2i32_constant_nonsplat_poison1_before := [llvmfunc|
  llvm.func @rotr_v2i32_constant_nonsplat_poison1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[17, 19]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.shl %arg0, %0  : vector<2xi32>
    %9 = llvm.lshr %arg0, %7  : vector<2xi32>
    %10 = llvm.or %8, %9  : vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def rotl_v2i36_constant_nonsplat_before := [llvmfunc|
  llvm.func @rotl_v2i36_constant_nonsplat(%arg0: vector<2xi36>) -> vector<2xi36> {
    %0 = llvm.mlir.constant(11 : i36) : i36
    %1 = llvm.mlir.constant(21 : i36) : i36
    %2 = llvm.mlir.constant(dense<[21, 11]> : vector<2xi36>) : vector<2xi36>
    %3 = llvm.mlir.constant(25 : i36) : i36
    %4 = llvm.mlir.constant(15 : i36) : i36
    %5 = llvm.mlir.constant(dense<[15, 25]> : vector<2xi36>) : vector<2xi36>
    %6 = llvm.shl %arg0, %2  : vector<2xi36>
    %7 = llvm.lshr %arg0, %5  : vector<2xi36>
    %8 = llvm.or %6, %7  : vector<2xi36>
    llvm.return %8 : vector<2xi36>
  }]

def rotl_v3i36_constant_nonsplat_poison0_before := [llvmfunc|
  llvm.func @rotl_v3i36_constant_nonsplat_poison0(%arg0: vector<3xi36>) -> vector<3xi36> {
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
    %20 = llvm.lshr %arg0, %18  : vector<3xi36>
    %21 = llvm.or %19, %20  : vector<3xi36>
    llvm.return %21 : vector<3xi36>
  }]

def rotl_i32_before := [llvmfunc|
  llvm.func @rotl_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

def rotr_i37_before := [llvmfunc|
  llvm.func @rotr_i37(%arg0: i37, %arg1: i37) -> i37 {
    %0 = llvm.mlir.constant(37 : i37) : i37
    %1 = llvm.sub %0, %arg1  : i37
    %2 = llvm.shl %arg0, %1  : i37
    %3 = llvm.lshr %arg0, %arg1  : i37
    %4 = llvm.or %3, %2  : i37
    llvm.return %4 : i37
  }]

def rotr_i8_commute_before := [llvmfunc|
  llvm.func @rotr_i8_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.shl %arg0, %1  : i8
    %3 = llvm.lshr %arg0, %arg1  : i8
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }]

def rotl_v4i32_before := [llvmfunc|
  llvm.func @rotl_v4i32(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %0, %arg1  : vector<4xi32>
    %2 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %3 = llvm.lshr %arg0, %1  : vector<4xi32>
    %4 = llvm.or %2, %3  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

def rotr_v3i42_before := [llvmfunc|
  llvm.func @rotr_v3i42(%arg0: vector<3xi42>, %arg1: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.mlir.constant(42 : i42) : i42
    %1 = llvm.mlir.constant(dense<42> : vector<3xi42>) : vector<3xi42>
    %2 = llvm.sub %1, %arg1  : vector<3xi42>
    %3 = llvm.shl %arg0, %2  : vector<3xi42>
    %4 = llvm.lshr %arg0, %arg1  : vector<3xi42>
    %5 = llvm.or %4, %3  : vector<3xi42>
    llvm.return %5 : vector<3xi42>
  }]

def rotl_safe_i32_before := [llvmfunc|
  llvm.func @rotl_safe_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.and %2, %1  : i32
    %5 = llvm.shl %arg0, %3  : i32
    %6 = llvm.lshr %arg0, %4  : i32
    %7 = llvm.or %6, %5  : i32
    llvm.return %7 : i32
  }]

def rotl_safe_i16_commute_extra_use_before := [llvmfunc|
  llvm.func @rotl_safe_i16_commute_extra_use(%arg0: i16, %arg1: i16, %arg2: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(15 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.and %2, %1  : i16
    llvm.store %4, %arg2 {alignment = 2 : i64} : i16, !llvm.ptr]

    %5 = llvm.shl %arg0, %3  : i16
    %6 = llvm.lshr %arg0, %4  : i16
    %7 = llvm.or %5, %6  : i16
    llvm.return %7 : i16
  }]

def rotr_safe_i64_before := [llvmfunc|
  llvm.func @rotr_safe_i64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.sub %0, %arg1  : i64
    %3 = llvm.and %arg1, %1  : i64
    %4 = llvm.and %2, %1  : i64
    %5 = llvm.shl %arg0, %4  : i64
    %6 = llvm.lshr %arg0, %3  : i64
    %7 = llvm.or %6, %5  : i64
    llvm.return %7 : i64
  }]

def rotr_safe_i8_commute_extra_use_before := [llvmfunc|
  llvm.func @rotr_safe_i8_commute_extra_use(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.and %2, %1  : i8
    %5 = llvm.shl %arg0, %4  : i8
    %6 = llvm.lshr %arg0, %3  : i8
    llvm.store %6, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr]

    %7 = llvm.or %5, %6  : i8
    llvm.return %7 : i8
  }]

def rotl_safe_v2i32_before := [llvmfunc|
  llvm.func @rotl_safe_v2i32(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg1  : vector<2xi32>
    %4 = llvm.and %arg1, %2  : vector<2xi32>
    %5 = llvm.and %3, %2  : vector<2xi32>
    %6 = llvm.shl %arg0, %4  : vector<2xi32>
    %7 = llvm.lshr %arg0, %5  : vector<2xi32>
    %8 = llvm.or %7, %6  : vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def rotr_safe_v3i16_before := [llvmfunc|
  llvm.func @rotr_safe_v3i16(%arg0: vector<3xi16>, %arg1: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<15> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.sub %1, %arg1  : vector<3xi16>
    %4 = llvm.and %arg1, %2  : vector<3xi16>
    %5 = llvm.and %3, %2  : vector<3xi16>
    %6 = llvm.shl %arg0, %5  : vector<3xi16>
    %7 = llvm.lshr %arg0, %4  : vector<3xi16>
    %8 = llvm.or %7, %6  : vector<3xi16>
    llvm.return %8 : vector<3xi16>
  }]

def rotate_left_16bit_before := [llvmfunc|
  llvm.func @rotate_left_16bit(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.zext %arg0 : i16 to i32
    %4 = llvm.shl %3, %2  : i32
    %5 = llvm.sub %1, %2  : i32
    %6 = llvm.lshr %3, %5  : i32
    %7 = llvm.or %6, %4  : i32
    %8 = llvm.trunc %7 : i32 to i16
    llvm.return %8 : i16
  }]

def rotate_left_commute_16bit_vec_before := [llvmfunc|
  llvm.func @rotate_left_commute_16bit_vec(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg1, %0  : vector<2xi32>
    %3 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %4 = llvm.shl %3, %2  : vector<2xi32>
    %5 = llvm.sub %1, %2  : vector<2xi32>
    %6 = llvm.lshr %3, %5  : vector<2xi32>
    %7 = llvm.or %4, %6  : vector<2xi32>
    %8 = llvm.trunc %7 : vector<2xi32> to vector<2xi16>
    llvm.return %8 : vector<2xi16>
  }]

def rotate_right_8bit_before := [llvmfunc|
  llvm.func @rotate_right_8bit(%arg0: i8, %arg1: i3) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.zext %arg1 : i3 to i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.lshr %2, %1  : i32
    %4 = llvm.sub %0, %1  : i32
    %5 = llvm.shl %2, %4  : i32
    %6 = llvm.or %5, %3  : i32
    %7 = llvm.trunc %6 : i32 to i8
    llvm.return %7 : i8
  }]

def rotate_right_commute_8bit_unmasked_shl_before := [llvmfunc|
  llvm.func @rotate_right_commute_8bit_unmasked_shl(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.lshr %4, %3  : i32
    %6 = llvm.sub %2, %3  : i32
    %7 = llvm.shl %4, %6  : i32
    %8 = llvm.or %5, %7  : i32
    %9 = llvm.trunc %8 : i32 to i8
    llvm.return %9 : i8
  }]

def rotate_right_commute_8bit_before := [llvmfunc|
  llvm.func @rotate_right_commute_8bit(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.lshr %4, %3  : i32
    %6 = llvm.sub %2, %3  : i32
    %7 = llvm.shl %arg0, %6  : i32
    %8 = llvm.or %5, %7  : i32
    %9 = llvm.trunc %8 : i32 to i8
    llvm.return %9 : i8
  }]

def rotate8_not_safe_before := [llvmfunc|
  llvm.func @rotate8_not_safe(%arg0: i8, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %1, %2  : i32
    %4 = llvm.shl %1, %arg1  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.trunc %5 : i32 to i8
    llvm.return %6 : i8
  }]

def rotate9_not_safe_before := [llvmfunc|
  llvm.func @rotate9_not_safe(%arg0: i9, %arg1: i32) -> i9 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.zext %arg0 : i9 to i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %1, %2  : i32
    %4 = llvm.shl %1, %arg1  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.trunc %5 : i32 to i9
    llvm.return %6 : i9
  }]

def rotateleft_16_neg_mask_before := [llvmfunc|
  llvm.func @rotateleft_16_neg_mask(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(15 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.zext %3 : i16 to i32
    %5 = llvm.and %2, %1  : i16
    %6 = llvm.zext %5 : i16 to i32
    %7 = llvm.zext %arg0 : i16 to i32
    %8 = llvm.shl %7, %4  : i32
    %9 = llvm.lshr %7, %6  : i32
    %10 = llvm.or %9, %8  : i32
    %11 = llvm.trunc %10 : i32 to i16
    llvm.return %11 : i16
  }]

def rotateleft_16_neg_mask_commute_before := [llvmfunc|
  llvm.func @rotateleft_16_neg_mask_commute(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(15 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.zext %3 : i16 to i32
    %5 = llvm.and %2, %1  : i16
    %6 = llvm.zext %5 : i16 to i32
    %7 = llvm.zext %arg0 : i16 to i32
    %8 = llvm.shl %7, %4  : i32
    %9 = llvm.lshr %7, %6  : i32
    %10 = llvm.or %8, %9  : i32
    %11 = llvm.trunc %10 : i32 to i16
    llvm.return %11 : i16
  }]

def rotateright_8_neg_mask_before := [llvmfunc|
  llvm.func @rotateright_8_neg_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.zext %3 : i8 to i32
    %5 = llvm.and %2, %1  : i8
    %6 = llvm.zext %5 : i8 to i32
    %7 = llvm.zext %arg0 : i8 to i32
    %8 = llvm.shl %7, %6  : i32
    %9 = llvm.lshr %7, %4  : i32
    %10 = llvm.or %9, %8  : i32
    %11 = llvm.trunc %10 : i32 to i8
    llvm.return %11 : i8
  }]

def rotateright_8_neg_mask_commute_before := [llvmfunc|
  llvm.func @rotateright_8_neg_mask_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.zext %3 : i8 to i32
    %5 = llvm.and %2, %1  : i8
    %6 = llvm.zext %5 : i8 to i32
    %7 = llvm.zext %arg0 : i8 to i32
    %8 = llvm.shl %7, %6  : i32
    %9 = llvm.lshr %7, %4  : i32
    %10 = llvm.or %8, %9  : i32
    %11 = llvm.trunc %10 : i32 to i8
    llvm.return %11 : i8
  }]

def rotateright_16_neg_mask_wide_amount_before := [llvmfunc|
  llvm.func @rotateright_16_neg_mask_wide_amount(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.and %2, %1  : i32
    %5 = llvm.zext %arg0 : i16 to i32
    %6 = llvm.shl %5, %4  : i32
    %7 = llvm.lshr %5, %3  : i32
    %8 = llvm.or %7, %6  : i32
    %9 = llvm.trunc %8 : i32 to i16
    llvm.return %9 : i16
  }]

def rotateright_16_neg_mask_wide_amount_commute_before := [llvmfunc|
  llvm.func @rotateright_16_neg_mask_wide_amount_commute(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.and %2, %1  : i32
    %5 = llvm.zext %arg0 : i16 to i32
    %6 = llvm.shl %5, %4  : i32
    %7 = llvm.lshr %5, %3  : i32
    %8 = llvm.or %6, %7  : i32
    %9 = llvm.trunc %8 : i32 to i16
    llvm.return %9 : i16
  }]

def rotateright_64_zext_neg_mask_amount_before := [llvmfunc|
  llvm.func @rotateright_64_zext_neg_mask_amount(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.lshr %arg0, %3  : i64
    %5 = llvm.sub %1, %arg1 overflow<nsw>  : i32
    %6 = llvm.and %5, %0  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.shl %arg0, %7  : i64
    %9 = llvm.or %4, %8  : i64
    llvm.return %9 : i64
  }]

def rotateleft_8_neg_mask_wide_amount_before := [llvmfunc|
  llvm.func @rotateleft_8_neg_mask_wide_amount(%arg0: i8, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.and %2, %1  : i32
    %5 = llvm.zext %arg0 : i8 to i32
    %6 = llvm.shl %5, %3  : i32
    %7 = llvm.lshr %5, %4  : i32
    %8 = llvm.or %7, %6  : i32
    %9 = llvm.trunc %8 : i32 to i8
    llvm.return %9 : i8
  }]

def rotateleft_8_neg_mask_wide_amount_commute_before := [llvmfunc|
  llvm.func @rotateleft_8_neg_mask_wide_amount_commute(%arg0: i8, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.and %2, %1  : i32
    %5 = llvm.zext %arg0 : i8 to i32
    %6 = llvm.shl %5, %3  : i32
    %7 = llvm.lshr %5, %4  : i32
    %8 = llvm.or %6, %7  : i32
    %9 = llvm.trunc %8 : i32 to i8
    llvm.return %9 : i8
  }]

def rotateleft_64_zext_neg_mask_amount_before := [llvmfunc|
  llvm.func @rotateleft_64_zext_neg_mask_amount(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.shl %arg0, %3  : i64
    %5 = llvm.sub %1, %arg1 overflow<nsw>  : i32
    %6 = llvm.and %5, %0  : i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.lshr %arg0, %7  : i64
    %9 = llvm.or %4, %8  : i64
    llvm.return %9 : i64
  }]

def rotateleft_9_neg_mask_wide_amount_commute_before := [llvmfunc|
  llvm.func @rotateleft_9_neg_mask_wide_amount_commute(%arg0: i9, %arg1: i33) -> i9 {
    %0 = llvm.mlir.constant(0 : i33) : i33
    %1 = llvm.mlir.constant(8 : i33) : i33
    %2 = llvm.sub %0, %arg1  : i33
    %3 = llvm.and %arg1, %1  : i33
    %4 = llvm.and %2, %1  : i33
    %5 = llvm.zext %arg0 : i9 to i33
    %6 = llvm.shl %5, %3  : i33
    %7 = llvm.lshr %5, %4  : i33
    %8 = llvm.or %6, %7  : i33
    %9 = llvm.trunc %8 : i33 to i9
    llvm.return %9 : i9
  }]

def rotl_sub_mask_before := [llvmfunc|
  llvm.func @rotl_sub_mask(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(64 : i64) : i64
    %2 = llvm.and %arg1, %0  : i64
    %3 = llvm.shl %arg0, %2  : i64
    %4 = llvm.sub %1, %2 overflow<nsw, nuw>  : i64
    %5 = llvm.lshr %arg0, %4  : i64
    %6 = llvm.or %5, %3  : i64
    llvm.return %6 : i64
  }]

def rotr_sub_mask_before := [llvmfunc|
  llvm.func @rotr_sub_mask(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(64 : i64) : i64
    %2 = llvm.and %arg1, %0  : i64
    %3 = llvm.lshr %arg0, %2  : i64
    %4 = llvm.sub %1, %2 overflow<nsw, nuw>  : i64
    %5 = llvm.shl %arg0, %4  : i64
    %6 = llvm.or %5, %3  : i64
    llvm.return %6 : i64
  }]

def rotr_sub_mask_vector_before := [llvmfunc|
  llvm.func @rotr_sub_mask_vector(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<63> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<64> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.and %arg1, %0  : vector<2xi64>
    %3 = llvm.lshr %arg0, %2  : vector<2xi64>
    %4 = llvm.sub %1, %2 overflow<nsw, nuw>  : vector<2xi64>
    %5 = llvm.shl %arg0, %4  : vector<2xi64>
    %6 = llvm.or %5, %3  : vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }]

def rotr_select_before := [llvmfunc|
  llvm.func @rotr_select(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.icmp "eq" %arg1, %0 : i32
    %3 = llvm.sub %1, %arg1  : i32
    %4 = llvm.lshr %arg0, %arg1  : i32
    %5 = llvm.shl %arg0, %3  : i32
    %6 = llvm.or %4, %5  : i32
    %7 = llvm.select %2, %arg0, %6 : i1, i32
    llvm.return %7 : i32
  }]

def rotr_select_commute_before := [llvmfunc|
  llvm.func @rotr_select_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(8 : i8) : i8
    %2 = llvm.icmp "eq" %arg1, %0 : i8
    %3 = llvm.sub %1, %arg1  : i8
    %4 = llvm.lshr %arg0, %arg1  : i8
    %5 = llvm.shl %arg0, %3  : i8
    %6 = llvm.or %5, %4  : i8
    %7 = llvm.select %2, %arg0, %6 : i1, i8
    llvm.return %7 : i8
  }]

def rotl_select_before := [llvmfunc|
  llvm.func @rotl_select(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(16 : i16) : i16
    %2 = llvm.icmp "eq" %arg1, %0 : i16
    %3 = llvm.sub %1, %arg1  : i16
    %4 = llvm.lshr %arg0, %3  : i16
    %5 = llvm.shl %arg0, %arg1  : i16
    %6 = llvm.or %4, %5  : i16
    %7 = llvm.select %2, %arg0, %6 : i1, i16
    llvm.return %7 : i16
  }]

def rotl_select_commute_before := [llvmfunc|
  llvm.func @rotl_select_commute(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<64> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.icmp "eq" %arg1, %1 : vector<2xi64>
    %4 = llvm.sub %2, %arg1  : vector<2xi64>
    %5 = llvm.lshr %arg0, %4  : vector<2xi64>
    %6 = llvm.shl %arg0, %arg1  : vector<2xi64>
    %7 = llvm.or %6, %5  : vector<2xi64>
    %8 = llvm.select %3, %arg0, %7 : vector<2xi1>, vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }]

def rotl_select_weird_type_before := [llvmfunc|
  llvm.func @rotl_select_weird_type(%arg0: i24, %arg1: i24) -> i24 {
    %0 = llvm.mlir.constant(0 : i24) : i24
    %1 = llvm.mlir.constant(24 : i24) : i24
    %2 = llvm.icmp "eq" %arg1, %0 : i24
    %3 = llvm.sub %1, %arg1  : i24
    %4 = llvm.lshr %arg0, %3  : i24
    %5 = llvm.shl %arg0, %arg1  : i24
    %6 = llvm.or %5, %4  : i24
    %7 = llvm.select %2, %arg0, %6 : i1, i24
    llvm.return %7 : i24
  }]

def rotl_select_zext_shamt_before := [llvmfunc|
  llvm.func @rotl_select_zext_shamt(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.and %arg1, %0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    %5 = llvm.zext %3 : i8 to i32
    %6 = llvm.sub %2, %3 overflow<nsw, nuw>  : i8
    %7 = llvm.zext %6 : i8 to i32
    %8 = llvm.lshr %arg0, %7  : i32
    %9 = llvm.shl %arg0, %5  : i32
    %10 = llvm.or %9, %8  : i32
    %11 = llvm.select %4, %arg0, %10 : i1, i32
    llvm.return %11 : i32
  }]

def rotr_select_zext_shamt_before := [llvmfunc|
  llvm.func @rotr_select_zext_shamt(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(64 : i32) : i32
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.zext %3 : i32 to i64
    %6 = llvm.lshr %arg0, %5  : i64
    %7 = llvm.sub %2, %3 overflow<nsw, nuw>  : i32
    %8 = llvm.zext %7 : i32 to i64
    %9 = llvm.shl %arg0, %8  : i64
    %10 = llvm.or %9, %6  : i64
    %11 = llvm.select %4, %arg0, %10 : i1, i64
    llvm.return %11 : i64
  }]

def rotl_constant_expr_before := [llvmfunc|
  llvm.func @rotl_constant_expr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.addressof @external_global : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.mlir.constant(11 : i32) : i32
    %3 = llvm.lshr %1, %arg0  : i32
    %4 = llvm.shl %1, %2  : i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }]

def rotateleft32_doubleand1_before := [llvmfunc|
  llvm.func @rotateleft32_doubleand1(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.and %arg1, %0  : i8
    %4 = llvm.zext %3 : i8 to i32
    %5 = llvm.sub %1, %4 overflow<nsw>  : i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.shl %arg0, %4  : i32
    %8 = llvm.lshr %arg0, %6  : i32
    %9 = llvm.or %8, %7  : i32
    llvm.return %9 : i32
  }]

def rotateright32_doubleand1_before := [llvmfunc|
  llvm.func @rotateright32_doubleand1(%arg0: i32, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(31 : i16) : i16
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.and %arg1, %0  : i16
    %4 = llvm.zext %3 : i16 to i32
    %5 = llvm.sub %1, %4 overflow<nsw>  : i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.shl %arg0, %6  : i32
    %8 = llvm.lshr %arg0, %4  : i32
    %9 = llvm.or %8, %7  : i32
    llvm.return %9 : i32
  }]

def unmasked_shlop_unmasked_shift_amount_before := [llvmfunc|
  llvm.func @unmasked_shlop_unmasked_shift_amount(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sub %1, %arg1  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.lshr %2, %arg1  : i32
    %6 = llvm.or %4, %5  : i32
    %7 = llvm.trunc %6 : i32 to i8
    llvm.return %7 : i8
  }]

def check_rotate_masked_16bit_before := [llvmfunc|
  llvm.func @check_rotate_masked_16bit(%arg0: i8, %arg1: i32) -> i16 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.and %arg0, %1  : i8
    %5 = llvm.zext %4 : i8 to i32
    %6 = llvm.lshr %3, %5  : i32
    %7 = llvm.sub %2, %arg0  : i8
    %8 = llvm.and %7, %1  : i8
    %9 = llvm.zext %8 : i8 to i32
    %10 = llvm.shl %3, %9 overflow<nsw, nuw>  : i32
    %11 = llvm.or %6, %10  : i32
    %12 = llvm.trunc %11 : i32 to i16
    llvm.return %12 : i16
  }]

def rotl_i32_constant_combined := [llvmfunc|
  llvm.func @rotl_i32_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i32, i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_rotl_i32_constant   : rotl_i32_constant_before  ⊑  rotl_i32_constant_combined := by
  unfold rotl_i32_constant_before rotl_i32_constant_combined
  simp_alive_peephole
  sorry
def rotr_i42_constant_combined := [llvmfunc|
  llvm.func @rotr_i42_constant(%arg0: i42) -> i42 {
    %0 = llvm.mlir.constant(31 : i42) : i42
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i42, i42, i42) -> i42
    llvm.return %1 : i42
  }]

theorem inst_combine_rotr_i42_constant   : rotr_i42_constant_before  ⊑  rotr_i42_constant_combined := by
  unfold rotr_i42_constant_before rotr_i42_constant_combined
  simp_alive_peephole
  sorry
def rotr_i8_constant_commute_combined := [llvmfunc|
  llvm.func @rotr_i8_constant_commute(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_rotr_i8_constant_commute   : rotr_i8_constant_commute_before  ⊑  rotr_i8_constant_commute_combined := by
  unfold rotr_i8_constant_commute_before rotr_i8_constant_commute_combined
  simp_alive_peephole
  sorry
def rotl_i88_constant_commute_combined := [llvmfunc|
  llvm.func @rotl_i88_constant_commute(%arg0: i88) -> i88 {
    %0 = llvm.mlir.constant(44 : i88) : i88
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i88, i88, i88) -> i88
    llvm.return %1 : i88
  }]

theorem inst_combine_rotl_i88_constant_commute   : rotl_i88_constant_commute_before  ⊑  rotl_i88_constant_commute_combined := by
  unfold rotl_i88_constant_commute_before rotl_i88_constant_commute_combined
  simp_alive_peephole
  sorry
def rotl_v2i16_constant_splat_combined := [llvmfunc|
  llvm.func @rotl_v2i16_constant_splat(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (vector<2xi16>, vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

theorem inst_combine_rotl_v2i16_constant_splat   : rotl_v2i16_constant_splat_before  ⊑  rotl_v2i16_constant_splat_combined := by
  unfold rotl_v2i16_constant_splat_before rotl_v2i16_constant_splat_combined
  simp_alive_peephole
  sorry
def rotl_v2i16_constant_splat_poison0_combined := [llvmfunc|
  llvm.func @rotl_v2i16_constant_splat_poison0(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (vector<2xi16>, vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

theorem inst_combine_rotl_v2i16_constant_splat_poison0   : rotl_v2i16_constant_splat_poison0_before  ⊑  rotl_v2i16_constant_splat_poison0_combined := by
  unfold rotl_v2i16_constant_splat_poison0_before rotl_v2i16_constant_splat_poison0_combined
  simp_alive_peephole
  sorry
def rotl_v2i16_constant_splat_poison1_combined := [llvmfunc|
  llvm.func @rotl_v2i16_constant_splat_poison1(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (vector<2xi16>, vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

theorem inst_combine_rotl_v2i16_constant_splat_poison1   : rotl_v2i16_constant_splat_poison1_before  ⊑  rotl_v2i16_constant_splat_poison1_combined := by
  unfold rotl_v2i16_constant_splat_poison1_before rotl_v2i16_constant_splat_poison1_combined
  simp_alive_peephole
  sorry
def rotr_v2i17_constant_splat_combined := [llvmfunc|
  llvm.func @rotr_v2i17_constant_splat(%arg0: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.constant(12 : i17) : i17
    %1 = llvm.mlir.constant(dense<12> : vector<2xi17>) : vector<2xi17>
    %2 = llvm.intr.fshl(%arg0, %arg0, %1)  : (vector<2xi17>, vector<2xi17>, vector<2xi17>) -> vector<2xi17>
    llvm.return %2 : vector<2xi17>
  }]

theorem inst_combine_rotr_v2i17_constant_splat   : rotr_v2i17_constant_splat_before  ⊑  rotr_v2i17_constant_splat_combined := by
  unfold rotr_v2i17_constant_splat_before rotr_v2i17_constant_splat_combined
  simp_alive_peephole
  sorry
def rotr_v2i17_constant_splat_poison0_combined := [llvmfunc|
  llvm.func @rotr_v2i17_constant_splat_poison0(%arg0: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.constant(12 : i17) : i17
    %1 = llvm.mlir.constant(dense<12> : vector<2xi17>) : vector<2xi17>
    %2 = llvm.intr.fshl(%arg0, %arg0, %1)  : (vector<2xi17>, vector<2xi17>, vector<2xi17>) -> vector<2xi17>
    llvm.return %2 : vector<2xi17>
  }]

theorem inst_combine_rotr_v2i17_constant_splat_poison0   : rotr_v2i17_constant_splat_poison0_before  ⊑  rotr_v2i17_constant_splat_poison0_combined := by
  unfold rotr_v2i17_constant_splat_poison0_before rotr_v2i17_constant_splat_poison0_combined
  simp_alive_peephole
  sorry
def rotr_v2i17_constant_splat_poison1_combined := [llvmfunc|
  llvm.func @rotr_v2i17_constant_splat_poison1(%arg0: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.constant(12 : i17) : i17
    %1 = llvm.mlir.constant(dense<12> : vector<2xi17>) : vector<2xi17>
    %2 = llvm.intr.fshl(%arg0, %arg0, %1)  : (vector<2xi17>, vector<2xi17>, vector<2xi17>) -> vector<2xi17>
    llvm.return %2 : vector<2xi17>
  }]

theorem inst_combine_rotr_v2i17_constant_splat_poison1   : rotr_v2i17_constant_splat_poison1_before  ⊑  rotr_v2i17_constant_splat_poison1_combined := by
  unfold rotr_v2i17_constant_splat_poison1_before rotr_v2i17_constant_splat_poison1_combined
  simp_alive_peephole
  sorry
def rotr_v2i32_constant_nonsplat_combined := [llvmfunc|
  llvm.func @rotr_v2i32_constant_nonsplat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[17, 19]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_rotr_v2i32_constant_nonsplat   : rotr_v2i32_constant_nonsplat_before  ⊑  rotr_v2i32_constant_nonsplat_combined := by
  unfold rotr_v2i32_constant_nonsplat_before rotr_v2i32_constant_nonsplat_combined
  simp_alive_peephole
  sorry
def rotr_v2i32_constant_nonsplat_poison0_combined := [llvmfunc|
  llvm.func @rotr_v2i32_constant_nonsplat_poison0(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(19 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.intr.fshl(%arg0, %arg0, %6)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

theorem inst_combine_rotr_v2i32_constant_nonsplat_poison0   : rotr_v2i32_constant_nonsplat_poison0_before  ⊑  rotr_v2i32_constant_nonsplat_poison0_combined := by
  unfold rotr_v2i32_constant_nonsplat_poison0_before rotr_v2i32_constant_nonsplat_poison0_combined
  simp_alive_peephole
  sorry
def rotr_v2i32_constant_nonsplat_poison1_combined := [llvmfunc|
  llvm.func @rotr_v2i32_constant_nonsplat_poison1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[17, 0]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_rotr_v2i32_constant_nonsplat_poison1   : rotr_v2i32_constant_nonsplat_poison1_before  ⊑  rotr_v2i32_constant_nonsplat_poison1_combined := by
  unfold rotr_v2i32_constant_nonsplat_poison1_before rotr_v2i32_constant_nonsplat_poison1_combined
  simp_alive_peephole
  sorry
def rotl_v2i36_constant_nonsplat_combined := [llvmfunc|
  llvm.func @rotl_v2i36_constant_nonsplat(%arg0: vector<2xi36>) -> vector<2xi36> {
    %0 = llvm.mlir.constant(11 : i36) : i36
    %1 = llvm.mlir.constant(21 : i36) : i36
    %2 = llvm.mlir.constant(dense<[21, 11]> : vector<2xi36>) : vector<2xi36>
    %3 = llvm.intr.fshl(%arg0, %arg0, %2)  : (vector<2xi36>, vector<2xi36>, vector<2xi36>) -> vector<2xi36>
    llvm.return %3 : vector<2xi36>
  }]

theorem inst_combine_rotl_v2i36_constant_nonsplat   : rotl_v2i36_constant_nonsplat_before  ⊑  rotl_v2i36_constant_nonsplat_combined := by
  unfold rotl_v2i36_constant_nonsplat_before rotl_v2i36_constant_nonsplat_combined
  simp_alive_peephole
  sorry
def rotl_v3i36_constant_nonsplat_poison0_combined := [llvmfunc|
  llvm.func @rotl_v3i36_constant_nonsplat_poison0(%arg0: vector<3xi36>) -> vector<3xi36> {
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
    %10 = llvm.intr.fshl(%arg0, %arg0, %9)  : (vector<3xi36>, vector<3xi36>, vector<3xi36>) -> vector<3xi36>
    llvm.return %10 : vector<3xi36>
  }]

theorem inst_combine_rotl_v3i36_constant_nonsplat_poison0   : rotl_v3i36_constant_nonsplat_poison0_before  ⊑  rotl_v3i36_constant_nonsplat_poison0_combined := by
  unfold rotl_v3i36_constant_nonsplat_poison0_before rotl_v3i36_constant_nonsplat_poison0_combined
  simp_alive_peephole
  sorry
def rotl_i32_combined := [llvmfunc|
  llvm.func @rotl_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.or %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_rotl_i32   : rotl_i32_before  ⊑  rotl_i32_combined := by
  unfold rotl_i32_before rotl_i32_combined
  simp_alive_peephole
  sorry
def rotr_i37_combined := [llvmfunc|
  llvm.func @rotr_i37(%arg0: i37, %arg1: i37) -> i37 {
    %0 = llvm.mlir.constant(37 : i37) : i37
    %1 = llvm.sub %0, %arg1  : i37
    %2 = llvm.shl %arg0, %1  : i37
    %3 = llvm.lshr %arg0, %arg1  : i37
    %4 = llvm.or %3, %2  : i37
    llvm.return %4 : i37
  }]

theorem inst_combine_rotr_i37   : rotr_i37_before  ⊑  rotr_i37_combined := by
  unfold rotr_i37_before rotr_i37_combined
  simp_alive_peephole
  sorry
def rotr_i8_commute_combined := [llvmfunc|
  llvm.func @rotr_i8_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.shl %arg0, %1  : i8
    %3 = llvm.lshr %arg0, %arg1  : i8
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_rotr_i8_commute   : rotr_i8_commute_before  ⊑  rotr_i8_commute_combined := by
  unfold rotr_i8_commute_before rotr_i8_commute_combined
  simp_alive_peephole
  sorry
def rotl_v4i32_combined := [llvmfunc|
  llvm.func @rotl_v4i32(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %0, %arg1  : vector<4xi32>
    %2 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %3 = llvm.lshr %arg0, %1  : vector<4xi32>
    %4 = llvm.or %2, %3  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_rotl_v4i32   : rotl_v4i32_before  ⊑  rotl_v4i32_combined := by
  unfold rotl_v4i32_before rotl_v4i32_combined
  simp_alive_peephole
  sorry
def rotr_v3i42_combined := [llvmfunc|
  llvm.func @rotr_v3i42(%arg0: vector<3xi42>, %arg1: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.mlir.constant(42 : i42) : i42
    %1 = llvm.mlir.constant(dense<42> : vector<3xi42>) : vector<3xi42>
    %2 = llvm.sub %1, %arg1  : vector<3xi42>
    %3 = llvm.shl %arg0, %2  : vector<3xi42>
    %4 = llvm.lshr %arg0, %arg1  : vector<3xi42>
    %5 = llvm.or %4, %3  : vector<3xi42>
    llvm.return %5 : vector<3xi42>
  }]

theorem inst_combine_rotr_v3i42   : rotr_v3i42_before  ⊑  rotr_v3i42_combined := by
  unfold rotr_v3i42_before rotr_v3i42_combined
  simp_alive_peephole
  sorry
def rotl_safe_i32_combined := [llvmfunc|
  llvm.func @rotl_safe_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i32, i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_rotl_safe_i32   : rotl_safe_i32_before  ⊑  rotl_safe_i32_combined := by
  unfold rotl_safe_i32_before rotl_safe_i32_combined
  simp_alive_peephole
  sorry
def rotl_safe_i16_commute_extra_use_combined := [llvmfunc|
  llvm.func @rotl_safe_i16_commute_extra_use(%arg0: i16, %arg1: i16, %arg2: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(15 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.and %2, %1  : i16
    llvm.store %3, %arg2 {alignment = 2 : i64} : i16, !llvm.ptr]

theorem inst_combine_rotl_safe_i16_commute_extra_use   : rotl_safe_i16_commute_extra_use_before  ⊑  rotl_safe_i16_commute_extra_use_combined := by
  unfold rotl_safe_i16_commute_extra_use_before rotl_safe_i16_commute_extra_use_combined
  simp_alive_peephole
  sorry
    %4 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i16, i16, i16) -> i16
    llvm.return %4 : i16
  }]

theorem inst_combine_rotl_safe_i16_commute_extra_use   : rotl_safe_i16_commute_extra_use_before  ⊑  rotl_safe_i16_commute_extra_use_combined := by
  unfold rotl_safe_i16_commute_extra_use_before rotl_safe_i16_commute_extra_use_combined
  simp_alive_peephole
  sorry
def rotr_safe_i64_combined := [llvmfunc|
  llvm.func @rotr_safe_i64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i64, i64, i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_rotr_safe_i64   : rotr_safe_i64_before  ⊑  rotr_safe_i64_combined := by
  unfold rotr_safe_i64_before rotr_safe_i64_combined
  simp_alive_peephole
  sorry
def rotr_safe_i8_commute_extra_use_combined := [llvmfunc|
  llvm.func @rotr_safe_i8_commute_extra_use(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.and %2, %1  : i8
    %5 = llvm.shl %arg0, %4  : i8
    %6 = llvm.lshr %arg0, %3  : i8
    llvm.store %6, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_rotr_safe_i8_commute_extra_use   : rotr_safe_i8_commute_extra_use_before  ⊑  rotr_safe_i8_commute_extra_use_combined := by
  unfold rotr_safe_i8_commute_extra_use_before rotr_safe_i8_commute_extra_use_combined
  simp_alive_peephole
  sorry
    %7 = llvm.or %5, %6  : i8
    llvm.return %7 : i8
  }]

theorem inst_combine_rotr_safe_i8_commute_extra_use   : rotr_safe_i8_commute_extra_use_before  ⊑  rotr_safe_i8_commute_extra_use_combined := by
  unfold rotr_safe_i8_commute_extra_use_before rotr_safe_i8_commute_extra_use_combined
  simp_alive_peephole
  sorry
def rotl_safe_v2i32_combined := [llvmfunc|
  llvm.func @rotl_safe_v2i32(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_rotl_safe_v2i32   : rotl_safe_v2i32_before  ⊑  rotl_safe_v2i32_combined := by
  unfold rotl_safe_v2i32_before rotl_safe_v2i32_combined
  simp_alive_peephole
  sorry
def rotr_safe_v3i16_combined := [llvmfunc|
  llvm.func @rotr_safe_v3i16(%arg0: vector<3xi16>, %arg1: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (vector<3xi16>, vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    llvm.return %0 : vector<3xi16>
  }]

theorem inst_combine_rotr_safe_v3i16   : rotr_safe_v3i16_before  ⊑  rotr_safe_v3i16_combined := by
  unfold rotr_safe_v3i16_before rotr_safe_v3i16_combined
  simp_alive_peephole
  sorry
def rotate_left_16bit_combined := [llvmfunc|
  llvm.func @rotate_left_16bit(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.trunc %arg1 : i32 to i16
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i16, i16, i16) -> i16
    llvm.return %1 : i16
  }]

theorem inst_combine_rotate_left_16bit   : rotate_left_16bit_before  ⊑  rotate_left_16bit_combined := by
  unfold rotate_left_16bit_before rotate_left_16bit_combined
  simp_alive_peephole
  sorry
def rotate_left_commute_16bit_vec_combined := [llvmfunc|
  llvm.func @rotate_left_commute_16bit_vec(%arg0: vector<2xi16>, %arg1: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.trunc %arg1 : vector<2xi32> to vector<2xi16>
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (vector<2xi16>, vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

theorem inst_combine_rotate_left_commute_16bit_vec   : rotate_left_commute_16bit_vec_before  ⊑  rotate_left_commute_16bit_vec_combined := by
  unfold rotate_left_commute_16bit_vec_before rotate_left_commute_16bit_vec_combined
  simp_alive_peephole
  sorry
def rotate_right_8bit_combined := [llvmfunc|
  llvm.func @rotate_right_8bit(%arg0: i8, %arg1: i3) -> i8 {
    %0 = llvm.zext %arg1 : i3 to i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_rotate_right_8bit   : rotate_right_8bit_before  ⊑  rotate_right_8bit_combined := by
  unfold rotate_right_8bit_before rotate_right_8bit_combined
  simp_alive_peephole
  sorry
def rotate_right_commute_8bit_unmasked_shl_combined := [llvmfunc|
  llvm.func @rotate_right_commute_8bit_unmasked_shl(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.trunc %arg1 : i32 to i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.trunc %arg0 : i32 to i8
    %5 = llvm.intr.fshr(%3, %4, %2)  : (i8, i8, i8) -> i8
    llvm.return %5 : i8
  }]

theorem inst_combine_rotate_right_commute_8bit_unmasked_shl   : rotate_right_commute_8bit_unmasked_shl_before  ⊑  rotate_right_commute_8bit_unmasked_shl_combined := by
  unfold rotate_right_commute_8bit_unmasked_shl_before rotate_right_commute_8bit_unmasked_shl_combined
  simp_alive_peephole
  sorry
def rotate_right_commute_8bit_combined := [llvmfunc|
  llvm.func @rotate_right_commute_8bit(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.trunc %arg1 : i32 to i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.trunc %arg0 : i32 to i8
    %5 = llvm.intr.fshr(%3, %4, %2)  : (i8, i8, i8) -> i8
    llvm.return %5 : i8
  }]

theorem inst_combine_rotate_right_commute_8bit   : rotate_right_commute_8bit_before  ⊑  rotate_right_commute_8bit_combined := by
  unfold rotate_right_commute_8bit_before rotate_right_commute_8bit_combined
  simp_alive_peephole
  sorry
def rotate8_not_safe_combined := [llvmfunc|
  llvm.func @rotate8_not_safe(%arg0: i8, %arg1: i32) -> i8 {
    %0 = llvm.trunc %arg1 : i32 to i8
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_rotate8_not_safe   : rotate8_not_safe_before  ⊑  rotate8_not_safe_combined := by
  unfold rotate8_not_safe_before rotate8_not_safe_combined
  simp_alive_peephole
  sorry
def rotate9_not_safe_combined := [llvmfunc|
  llvm.func @rotate9_not_safe(%arg0: i9, %arg1: i32) -> i9 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.zext %arg0 : i9 to i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %1, %2  : i32
    %4 = llvm.shl %1, %arg1  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.trunc %5 : i32 to i9
    llvm.return %6 : i9
  }]

theorem inst_combine_rotate9_not_safe   : rotate9_not_safe_before  ⊑  rotate9_not_safe_combined := by
  unfold rotate9_not_safe_before rotate9_not_safe_combined
  simp_alive_peephole
  sorry
def rotateleft_16_neg_mask_combined := [llvmfunc|
  llvm.func @rotateleft_16_neg_mask(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i16, i16, i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_rotateleft_16_neg_mask   : rotateleft_16_neg_mask_before  ⊑  rotateleft_16_neg_mask_combined := by
  unfold rotateleft_16_neg_mask_before rotateleft_16_neg_mask_combined
  simp_alive_peephole
  sorry
def rotateleft_16_neg_mask_commute_combined := [llvmfunc|
  llvm.func @rotateleft_16_neg_mask_commute(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i16, i16, i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_rotateleft_16_neg_mask_commute   : rotateleft_16_neg_mask_commute_before  ⊑  rotateleft_16_neg_mask_commute_combined := by
  unfold rotateleft_16_neg_mask_commute_before rotateleft_16_neg_mask_commute_combined
  simp_alive_peephole
  sorry
def rotateright_8_neg_mask_combined := [llvmfunc|
  llvm.func @rotateright_8_neg_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_rotateright_8_neg_mask   : rotateright_8_neg_mask_before  ⊑  rotateright_8_neg_mask_combined := by
  unfold rotateright_8_neg_mask_before rotateright_8_neg_mask_combined
  simp_alive_peephole
  sorry
def rotateright_8_neg_mask_commute_combined := [llvmfunc|
  llvm.func @rotateright_8_neg_mask_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_rotateright_8_neg_mask_commute   : rotateright_8_neg_mask_commute_before  ⊑  rotateright_8_neg_mask_commute_combined := by
  unfold rotateright_8_neg_mask_commute_before rotateright_8_neg_mask_commute_combined
  simp_alive_peephole
  sorry
def rotateright_16_neg_mask_wide_amount_combined := [llvmfunc|
  llvm.func @rotateright_16_neg_mask_wide_amount(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.trunc %arg1 : i32 to i16
    %1 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i16, i16, i16) -> i16
    llvm.return %1 : i16
  }]

theorem inst_combine_rotateright_16_neg_mask_wide_amount   : rotateright_16_neg_mask_wide_amount_before  ⊑  rotateright_16_neg_mask_wide_amount_combined := by
  unfold rotateright_16_neg_mask_wide_amount_before rotateright_16_neg_mask_wide_amount_combined
  simp_alive_peephole
  sorry
def rotateright_16_neg_mask_wide_amount_commute_combined := [llvmfunc|
  llvm.func @rotateright_16_neg_mask_wide_amount_commute(%arg0: i16, %arg1: i32) -> i16 {
    %0 = llvm.trunc %arg1 : i32 to i16
    %1 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i16, i16, i16) -> i16
    llvm.return %1 : i16
  }]

theorem inst_combine_rotateright_16_neg_mask_wide_amount_commute   : rotateright_16_neg_mask_wide_amount_commute_before  ⊑  rotateright_16_neg_mask_wide_amount_commute_combined := by
  unfold rotateright_16_neg_mask_wide_amount_commute_before rotateright_16_neg_mask_wide_amount_commute_combined
  simp_alive_peephole
  sorry
def rotateright_64_zext_neg_mask_amount_combined := [llvmfunc|
  llvm.func @rotateright_64_zext_neg_mask_amount(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.zext %arg1 : i32 to i64
    %1 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i64, i64, i64) -> i64
    llvm.return %1 : i64
  }]

theorem inst_combine_rotateright_64_zext_neg_mask_amount   : rotateright_64_zext_neg_mask_amount_before  ⊑  rotateright_64_zext_neg_mask_amount_combined := by
  unfold rotateright_64_zext_neg_mask_amount_before rotateright_64_zext_neg_mask_amount_combined
  simp_alive_peephole
  sorry
def rotateleft_8_neg_mask_wide_amount_combined := [llvmfunc|
  llvm.func @rotateleft_8_neg_mask_wide_amount(%arg0: i8, %arg1: i32) -> i8 {
    %0 = llvm.trunc %arg1 : i32 to i8
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_rotateleft_8_neg_mask_wide_amount   : rotateleft_8_neg_mask_wide_amount_before  ⊑  rotateleft_8_neg_mask_wide_amount_combined := by
  unfold rotateleft_8_neg_mask_wide_amount_before rotateleft_8_neg_mask_wide_amount_combined
  simp_alive_peephole
  sorry
def rotateleft_8_neg_mask_wide_amount_commute_combined := [llvmfunc|
  llvm.func @rotateleft_8_neg_mask_wide_amount_commute(%arg0: i8, %arg1: i32) -> i8 {
    %0 = llvm.trunc %arg1 : i32 to i8
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_rotateleft_8_neg_mask_wide_amount_commute   : rotateleft_8_neg_mask_wide_amount_commute_before  ⊑  rotateleft_8_neg_mask_wide_amount_commute_combined := by
  unfold rotateleft_8_neg_mask_wide_amount_commute_before rotateleft_8_neg_mask_wide_amount_commute_combined
  simp_alive_peephole
  sorry
def rotateleft_64_zext_neg_mask_amount_combined := [llvmfunc|
  llvm.func @rotateleft_64_zext_neg_mask_amount(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.zext %arg1 : i32 to i64
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i64, i64, i64) -> i64
    llvm.return %1 : i64
  }]

theorem inst_combine_rotateleft_64_zext_neg_mask_amount   : rotateleft_64_zext_neg_mask_amount_before  ⊑  rotateleft_64_zext_neg_mask_amount_combined := by
  unfold rotateleft_64_zext_neg_mask_amount_before rotateleft_64_zext_neg_mask_amount_combined
  simp_alive_peephole
  sorry
def rotateleft_9_neg_mask_wide_amount_commute_combined := [llvmfunc|
  llvm.func @rotateleft_9_neg_mask_wide_amount_commute(%arg0: i9, %arg1: i33) -> i9 {
    %0 = llvm.mlir.constant(0 : i33) : i33
    %1 = llvm.mlir.constant(8 : i33) : i33
    %2 = llvm.sub %0, %arg1  : i33
    %3 = llvm.and %arg1, %1  : i33
    %4 = llvm.and %2, %1  : i33
    %5 = llvm.zext %arg0 : i9 to i33
    %6 = llvm.shl %5, %3 overflow<nsw, nuw>  : i33
    %7 = llvm.lshr %5, %4  : i33
    %8 = llvm.or %6, %7  : i33
    %9 = llvm.trunc %8 : i33 to i9
    llvm.return %9 : i9
  }]

theorem inst_combine_rotateleft_9_neg_mask_wide_amount_commute   : rotateleft_9_neg_mask_wide_amount_commute_before  ⊑  rotateleft_9_neg_mask_wide_amount_commute_combined := by
  unfold rotateleft_9_neg_mask_wide_amount_commute_before rotateleft_9_neg_mask_wide_amount_commute_combined
  simp_alive_peephole
  sorry
def rotl_sub_mask_combined := [llvmfunc|
  llvm.func @rotl_sub_mask(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i64, i64, i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_rotl_sub_mask   : rotl_sub_mask_before  ⊑  rotl_sub_mask_combined := by
  unfold rotl_sub_mask_before rotl_sub_mask_combined
  simp_alive_peephole
  sorry
def rotr_sub_mask_combined := [llvmfunc|
  llvm.func @rotr_sub_mask(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i64, i64, i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_rotr_sub_mask   : rotr_sub_mask_before  ⊑  rotr_sub_mask_combined := by
  unfold rotr_sub_mask_before rotr_sub_mask_combined
  simp_alive_peephole
  sorry
def rotr_sub_mask_vector_combined := [llvmfunc|
  llvm.func @rotr_sub_mask_vector(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (vector<2xi64>, vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_rotr_sub_mask_vector   : rotr_sub_mask_vector_before  ⊑  rotr_sub_mask_vector_combined := by
  unfold rotr_sub_mask_vector_before rotr_sub_mask_vector_combined
  simp_alive_peephole
  sorry
def rotr_select_combined := [llvmfunc|
  llvm.func @rotr_select(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i32, i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_rotr_select   : rotr_select_before  ⊑  rotr_select_combined := by
  unfold rotr_select_before rotr_select_combined
  simp_alive_peephole
  sorry
def rotr_select_commute_combined := [llvmfunc|
  llvm.func @rotr_select_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_rotr_select_commute   : rotr_select_commute_before  ⊑  rotr_select_commute_combined := by
  unfold rotr_select_commute_before rotr_select_commute_combined
  simp_alive_peephole
  sorry
def rotl_select_combined := [llvmfunc|
  llvm.func @rotl_select(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i16, i16, i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_rotl_select   : rotl_select_before  ⊑  rotl_select_combined := by
  unfold rotl_select_before rotl_select_combined
  simp_alive_peephole
  sorry
def rotl_select_commute_combined := [llvmfunc|
  llvm.func @rotl_select_commute(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (vector<2xi64>, vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    llvm.return %0 : vector<2xi64>
  }]

theorem inst_combine_rotl_select_commute   : rotl_select_commute_before  ⊑  rotl_select_commute_combined := by
  unfold rotl_select_commute_before rotl_select_commute_combined
  simp_alive_peephole
  sorry
def rotl_select_weird_type_combined := [llvmfunc|
  llvm.func @rotl_select_weird_type(%arg0: i24, %arg1: i24) -> i24 {
    %0 = llvm.mlir.constant(0 : i24) : i24
    %1 = llvm.mlir.constant(24 : i24) : i24
    %2 = llvm.icmp "eq" %arg1, %0 : i24
    %3 = llvm.sub %1, %arg1  : i24
    %4 = llvm.lshr %arg0, %3  : i24
    %5 = llvm.shl %arg0, %arg1  : i24
    %6 = llvm.or %5, %4  : i24
    %7 = llvm.select %2, %arg0, %6 : i1, i24
    llvm.return %7 : i24
  }]

theorem inst_combine_rotl_select_weird_type   : rotl_select_weird_type_before  ⊑  rotl_select_weird_type_combined := by
  unfold rotl_select_weird_type_before rotl_select_weird_type_combined
  simp_alive_peephole
  sorry
def rotl_select_zext_shamt_combined := [llvmfunc|
  llvm.func @rotl_select_zext_shamt(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg1 : i8 to i32
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i32, i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_rotl_select_zext_shamt   : rotl_select_zext_shamt_before  ⊑  rotl_select_zext_shamt_combined := by
  unfold rotl_select_zext_shamt_before rotl_select_zext_shamt_combined
  simp_alive_peephole
  sorry
def rotr_select_zext_shamt_combined := [llvmfunc|
  llvm.func @rotr_select_zext_shamt(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.zext %arg1 : i32 to i64
    %1 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i64, i64, i64) -> i64
    llvm.return %1 : i64
  }]

theorem inst_combine_rotr_select_zext_shamt   : rotr_select_zext_shamt_before  ⊑  rotr_select_zext_shamt_combined := by
  unfold rotr_select_zext_shamt_before rotr_select_zext_shamt_combined
  simp_alive_peephole
  sorry
def rotl_constant_expr_combined := [llvmfunc|
  llvm.func @rotl_constant_expr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.addressof @external_global : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.mlir.constant(11 : i32) : i32
    %3 = llvm.shl %1, %2  : i32
    %4 = llvm.lshr %1, %arg0  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_rotl_constant_expr   : rotl_constant_expr_before  ⊑  rotl_constant_expr_combined := by
  unfold rotl_constant_expr_before rotl_constant_expr_combined
  simp_alive_peephole
  sorry
def rotateleft32_doubleand1_combined := [llvmfunc|
  llvm.func @rotateleft32_doubleand1(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.zext %arg1 : i8 to i32
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i32, i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_rotateleft32_doubleand1   : rotateleft32_doubleand1_before  ⊑  rotateleft32_doubleand1_combined := by
  unfold rotateleft32_doubleand1_before rotateleft32_doubleand1_combined
  simp_alive_peephole
  sorry
def rotateright32_doubleand1_combined := [llvmfunc|
  llvm.func @rotateright32_doubleand1(%arg0: i32, %arg1: i16) -> i32 {
    %0 = llvm.zext %arg1 : i16 to i32
    %1 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i32, i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_rotateright32_doubleand1   : rotateright32_doubleand1_before  ⊑  rotateright32_doubleand1_combined := by
  unfold rotateright32_doubleand1_before rotateright32_doubleand1_combined
  simp_alive_peephole
  sorry
def unmasked_shlop_unmasked_shift_amount_combined := [llvmfunc|
  llvm.func @unmasked_shlop_unmasked_shift_amount(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sub %1, %arg1  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.lshr %2, %arg1  : i32
    %6 = llvm.or %4, %5  : i32
    %7 = llvm.trunc %6 : i32 to i8
    llvm.return %7 : i8
  }]

theorem inst_combine_unmasked_shlop_unmasked_shift_amount   : unmasked_shlop_unmasked_shift_amount_before  ⊑  unmasked_shlop_unmasked_shift_amount_combined := by
  unfold unmasked_shlop_unmasked_shift_amount_before unmasked_shlop_unmasked_shift_amount_combined
  simp_alive_peephole
  sorry
def check_rotate_masked_16bit_combined := [llvmfunc|
  llvm.func @check_rotate_masked_16bit(%arg0: i8, %arg1: i32) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.zext %arg0 : i8 to i16
    %2 = llvm.trunc %arg1 : i32 to i16
    %3 = llvm.and %2, %0  : i16
    %4 = llvm.intr.fshr(%3, %3, %1)  : (i16, i16, i16) -> i16
    llvm.return %4 : i16
  }]

theorem inst_combine_check_rotate_masked_16bit   : check_rotate_masked_16bit_before  ⊑  check_rotate_masked_16bit_combined := by
  unfold check_rotate_masked_16bit_before check_rotate_masked_16bit_combined
  simp_alive_peephole
  sorry
