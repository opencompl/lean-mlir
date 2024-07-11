import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shift-add
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def shl_C1_add_A_C2_i32_before := [llvmfunc|
  llvm.func @shl_C1_add_A_C2_i32(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.add %2, %0  : i32
    %4 = llvm.shl %1, %3  : i32
    llvm.return %4 : i32
  }]

def ashr_C1_add_A_C2_i32_before := [llvmfunc|
  llvm.func @ashr_C1_add_A_C2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.ashr %2, %4  : i32
    llvm.return %5 : i32
  }]

def lshr_C1_add_A_C2_i32_before := [llvmfunc|
  llvm.func @lshr_C1_add_A_C2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.shl %2, %4  : i32
    llvm.return %5 : i32
  }]

def shl_C1_add_A_C2_v4i32_before := [llvmfunc|
  llvm.func @shl_C1_add_A_C2_v4i32(%arg0: vector<4xi16>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.zext %arg0 : vector<4xi16> to vector<4xi32>
    %3 = llvm.add %2, %0  : vector<4xi32>
    %4 = llvm.shl %1, %3  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

def ashr_C1_add_A_C2_v4i32_before := [llvmfunc|
  llvm.func @ashr_C1_add_A_C2_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 15, 255, 65535]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.add %3, %1  : vector<4xi32>
    %5 = llvm.ashr %2, %4  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

def lshr_C1_add_A_C2_v4i32_before := [llvmfunc|
  llvm.func @lshr_C1_add_A_C2_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 15, 255, 65535]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.add %3, %1  : vector<4xi32>
    %5 = llvm.lshr %2, %4  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

def shl_C1_add_A_C2_v4i32_splat_before := [llvmfunc|
  llvm.func @shl_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.zext %arg0 : i16 to i32
    %5 = llvm.insertelement %4, %0[%1 : i32] : vector<4xi32>
    %6 = llvm.shufflevector %5, %0 [0, 0, 0, 0] : vector<4xi32> 
    %7 = llvm.add %6, %2  : vector<4xi32>
    %8 = llvm.shl %3, %7  : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }]

def ashr_C1_add_A_C2_v4i32_splat_before := [llvmfunc|
  llvm.func @ashr_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.zext %arg0 : i16 to i32
    %5 = llvm.insertelement %4, %0[%1 : i32] : vector<4xi32>
    %6 = llvm.shufflevector %5, %0 [0, 0, 0, 0] : vector<4xi32> 
    %7 = llvm.add %6, %2  : vector<4xi32>
    %8 = llvm.ashr %3, %7  : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }]

def lshr_C1_add_A_C2_v4i32_splat_before := [llvmfunc|
  llvm.func @lshr_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 50, 16]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<[6, 2, 1, -7]> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.zext %arg0 : i16 to i32
    %5 = llvm.insertelement %4, %0[%1 : i32] : vector<4xi32>
    %6 = llvm.shufflevector %5, %0 [0, 0, 0, 0] : vector<4xi32> 
    %7 = llvm.add %6, %2  : vector<4xi32>
    %8 = llvm.lshr %3, %7  : vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }]

def shl_add_nuw_before := [llvmfunc|
  llvm.func @shl_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.shl %1, %2  : i32
    llvm.return %3 : i32
  }]

def lshr_add_nuw_before := [llvmfunc|
  llvm.func @lshr_add_nuw(%arg0: vector<2xi12>) -> vector<2xi12> {
    %0 = llvm.mlir.constant(1 : i12) : i12
    %1 = llvm.mlir.constant(5 : i12) : i12
    %2 = llvm.mlir.constant(dense<[5, 1]> : vector<2xi12>) : vector<2xi12>
    %3 = llvm.mlir.constant(42 : i12) : i12
    %4 = llvm.mlir.constant(6 : i12) : i12
    %5 = llvm.mlir.constant(dense<[6, 42]> : vector<2xi12>) : vector<2xi12>
    %6 = llvm.add %arg0, %2 overflow<nuw>  : vector<2xi12>
    %7 = llvm.lshr %5, %6  : vector<2xi12>
    llvm.return %7 : vector<2xi12>
  }]

def ashr_add_nuw_before := [llvmfunc|
  llvm.func @ashr_add_nuw(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(-6 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.ashr %1, %2  : i32
    llvm.return %3 : i32
  }]

def shl_nuw_add_nuw_before := [llvmfunc|
  llvm.func @shl_nuw_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.shl %0, %1 overflow<nuw>  : i32
    llvm.return %2 : i32
  }]

def shl_nsw_add_nuw_before := [llvmfunc|
  llvm.func @shl_nsw_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

def lshr_exact_add_nuw_before := [llvmfunc|
  llvm.func @lshr_exact_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }]

def ashr_exact_add_nuw_before := [llvmfunc|
  llvm.func @ashr_exact_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.ashr %1, %2  : i32
    llvm.return %3 : i32
  }]

def shl_add_nsw_before := [llvmfunc|
  llvm.func @shl_add_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.shl %1, %2  : i32
    llvm.return %3 : i32
  }]

def lshr_exact_add_positive_shift_positive_before := [llvmfunc|
  llvm.func @lshr_exact_add_positive_shift_positive(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }]

def lshr_exact_add_big_negative_offset_before := [llvmfunc|
  llvm.func @lshr_exact_add_big_negative_offset(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }]

def lshr_exact_add_negative_shift_negative_before := [llvmfunc|
  llvm.func @lshr_exact_add_negative_shift_negative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }]

def lshr_add_negative_shift_no_exact_before := [llvmfunc|
  llvm.func @lshr_add_negative_shift_no_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }]

def lshr_exact_add_negative_shift_positive_before := [llvmfunc|
  llvm.func @lshr_exact_add_negative_shift_positive(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }]

def lshr_exact_add_negative_shift_positive_extra_use_before := [llvmfunc|
  llvm.func @lshr_exact_add_negative_shift_positive_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.lshr %1, %2  : i8
    llvm.return %3 : i8
  }]

def lshr_exact_add_negative_shift_positive_vec_before := [llvmfunc|
  llvm.func @lshr_exact_add_negative_shift_positive_vec(%arg0: vector<2xi9>) -> vector<2xi9> {
    %0 = llvm.mlir.constant(-7 : i9) : i9
    %1 = llvm.mlir.constant(dense<-7> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.mlir.constant(2 : i9) : i9
    %3 = llvm.mlir.constant(dense<2> : vector<2xi9>) : vector<2xi9>
    %4 = llvm.add %arg0, %1  : vector<2xi9>
    %5 = llvm.lshr %3, %4  : vector<2xi9>
    llvm.return %5 : vector<2xi9>
  }]

def lshr_exact_add_negative_shift_lzcnt_before := [llvmfunc|
  llvm.func @lshr_exact_add_negative_shift_lzcnt(%arg0: vector<2xi9>) -> vector<2xi9> {
    %0 = llvm.mlir.constant(-7 : i9) : i9
    %1 = llvm.mlir.constant(dense<-7> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.mlir.constant(4 : i9) : i9
    %3 = llvm.mlir.constant(dense<4> : vector<2xi9>) : vector<2xi9>
    %4 = llvm.add %arg0, %1  : vector<2xi9>
    %5 = llvm.lshr %3, %4  : vector<2xi9>
    llvm.return %5 : vector<2xi9>
  }]

def ashr_exact_add_negative_shift_no_trailing_zeros_before := [llvmfunc|
  llvm.func @ashr_exact_add_negative_shift_no_trailing_zeros(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.constant(-112 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.ashr %1, %2  : i8
    llvm.return %3 : i8
  }]

def ashr_exact_add_big_negative_offset_before := [llvmfunc|
  llvm.func @ashr_exact_add_big_negative_offset(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.ashr %1, %2  : i32
    llvm.return %3 : i32
  }]

def ashr_add_negative_shift_no_exact_before := [llvmfunc|
  llvm.func @ashr_add_negative_shift_no_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.ashr %1, %2  : i32
    llvm.return %3 : i32
  }]

def ashr_exact_add_negative_shift_negative_before := [llvmfunc|
  llvm.func @ashr_exact_add_negative_shift_negative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.ashr %1, %2  : i32
    llvm.return %3 : i32
  }]

def ashr_exact_add_negative_shift_negative_extra_use_before := [llvmfunc|
  llvm.func @ashr_exact_add_negative_shift_negative_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.ashr %1, %2  : i8
    llvm.return %3 : i8
  }]

def ashr_exact_add_negative_shift_negative_vec_before := [llvmfunc|
  llvm.func @ashr_exact_add_negative_shift_negative_vec(%arg0: vector<2xi7>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(-5 : i7) : i7
    %1 = llvm.mlir.constant(dense<-5> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(-2 : i7) : i7
    %3 = llvm.mlir.constant(dense<-2> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.add %arg0, %1  : vector<2xi7>
    %5 = llvm.ashr %3, %4  : vector<2xi7>
    llvm.return %5 : vector<2xi7>
  }]

def ashr_exact_add_negative_leading_ones_vec_before := [llvmfunc|
  llvm.func @ashr_exact_add_negative_leading_ones_vec(%arg0: vector<2xi7>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(-5 : i7) : i7
    %1 = llvm.mlir.constant(dense<-5> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(-4 : i7) : i7
    %3 = llvm.mlir.constant(dense<-4> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.add %arg0, %1  : vector<2xi7>
    %5 = llvm.ashr %3, %4  : vector<2xi7>
    llvm.return %5 : vector<2xi7>
  }]

def shl_nsw_add_negative_before := [llvmfunc|
  llvm.func @shl_nsw_add_negative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

def shl_nuw_add_negative_splat_uses_before := [llvmfunc|
  llvm.func @shl_nuw_add_negative_splat_uses(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<12> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    llvm.store %2, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr]

    %3 = llvm.shl %1, %2 overflow<nuw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def shl_nsw_add_negative_invalid_constant_before := [llvmfunc|
  llvm.func @shl_nsw_add_negative_invalid_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

def shl_nsw_add_positive_invalid_constant_before := [llvmfunc|
  llvm.func @shl_nsw_add_positive_invalid_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

def shl_nsw_add_negative_invalid_constant2_before := [llvmfunc|
  llvm.func @shl_nsw_add_negative_invalid_constant2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

def shl_nsw_add_negative_invalid_constant3_before := [llvmfunc|
  llvm.func @shl_nsw_add_negative_invalid_constant3(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-8 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.add %arg0, %0  : i4
    %3 = llvm.shl %1, %2 overflow<nsw>  : i4
    llvm.return %3 : i4
  }]

def lshr_2_add_zext_basic_before := [llvmfunc|
  llvm.func @lshr_2_add_zext_basic(%arg0: i1, %arg1: i1) -> i2 {
    %0 = llvm.mlir.constant(1 : i2) : i2
    %1 = llvm.zext %arg0 : i1 to i2
    %2 = llvm.zext %arg1 : i1 to i2
    %3 = llvm.add %1, %2  : i2
    %4 = llvm.lshr %3, %0  : i2
    llvm.return %4 : i2
  }]

def ashr_2_add_zext_basic_before := [llvmfunc|
  llvm.func @ashr_2_add_zext_basic(%arg0: i1, %arg1: i1) -> i2 {
    %0 = llvm.mlir.constant(1 : i2) : i2
    %1 = llvm.zext %arg0 : i1 to i2
    %2 = llvm.zext %arg1 : i1 to i2
    %3 = llvm.add %1, %2  : i2
    %4 = llvm.ashr %3, %0  : i2
    llvm.return %4 : i2
  }]

def lshr_16_add_zext_basic_before := [llvmfunc|
  llvm.func @lshr_16_add_zext_basic(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.zext %arg1 : i16 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.lshr %3, %0  : i32
    llvm.return %4 : i32
  }]

def lshr_16_add_zext_basic_multiuse_before := [llvmfunc|
  llvm.func @lshr_16_add_zext_basic_multiuse(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.zext %arg1 : i16 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.lshr %3, %0  : i32
    %5 = llvm.or %4, %1  : i32
    llvm.return %5 : i32
  }]

def lshr_16_add_known_16_leading_zeroes_before := [llvmfunc|
  llvm.func @lshr_16_add_known_16_leading_zeroes(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.add %2, %3  : i32
    %5 = llvm.lshr %4, %1  : i32
    llvm.return %5 : i32
  }]

def lshr_16_add_not_known_16_leading_zeroes_before := [llvmfunc|
  llvm.func @lshr_16_add_not_known_16_leading_zeroes(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(131071 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.add %3, %4  : i32
    %6 = llvm.lshr %5, %2  : i32
    llvm.return %6 : i32
  }]

def lshr_32_add_zext_basic_before := [llvmfunc|
  llvm.func @lshr_32_add_zext_basic(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.add %1, %2  : i64
    %4 = llvm.lshr %3, %0  : i64
    llvm.return %4 : i64
  }]

def lshr_32_add_zext_basic_multiuse_before := [llvmfunc|
  llvm.func @lshr_32_add_zext_basic_multiuse(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.add %1, %2  : i64
    %4 = llvm.lshr %3, %0  : i64
    %5 = llvm.or %4, %2  : i64
    llvm.return %5 : i64
  }]

def lshr_31_i32_add_zext_basic_before := [llvmfunc|
  llvm.func @lshr_31_i32_add_zext_basic(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.add %1, %2  : i64
    %4 = llvm.lshr %3, %0  : i64
    llvm.return %4 : i64
  }]

def lshr_33_i32_add_zext_basic_before := [llvmfunc|
  llvm.func @lshr_33_i32_add_zext_basic(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(33 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.add %1, %2  : i64
    %4 = llvm.lshr %3, %0  : i64
    llvm.return %4 : i64
  }]

def lshr_16_to_64_add_zext_basic_before := [llvmfunc|
  llvm.func @lshr_16_to_64_add_zext_basic(%arg0: i16, %arg1: i16) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.zext %arg0 : i16 to i64
    %2 = llvm.zext %arg1 : i16 to i64
    %3 = llvm.add %1, %2  : i64
    %4 = llvm.lshr %3, %0  : i64
    llvm.return %4 : i64
  }]

def lshr_32_add_known_32_leading_zeroes_before := [llvmfunc|
  llvm.func @lshr_32_add_known_32_leading_zeroes(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.and %arg1, %0  : i64
    %4 = llvm.add %2, %3  : i64
    %5 = llvm.lshr %4, %1  : i64
    llvm.return %5 : i64
  }]

def lshr_32_add_not_known_32_leading_zeroes_before := [llvmfunc|
  llvm.func @lshr_32_add_not_known_32_leading_zeroes(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(8589934591 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.and %arg1, %1  : i64
    %5 = llvm.add %3, %4  : i64
    %6 = llvm.lshr %5, %2  : i64
    llvm.return %6 : i64
  }]

def ashr_16_add_zext_basic_before := [llvmfunc|
  llvm.func @ashr_16_add_zext_basic(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.zext %arg1 : i16 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.lshr %3, %0  : i32
    llvm.return %4 : i32
  }]

def ashr_32_add_zext_basic_before := [llvmfunc|
  llvm.func @ashr_32_add_zext_basic(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.add %1, %2  : i64
    %4 = llvm.ashr %3, %0  : i64
    llvm.return %4 : i64
  }]

def ashr_16_to_64_add_zext_basic_before := [llvmfunc|
  llvm.func @ashr_16_to_64_add_zext_basic(%arg0: i16, %arg1: i16) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.zext %arg0 : i16 to i64
    %2 = llvm.zext %arg1 : i16 to i64
    %3 = llvm.add %1, %2  : i64
    %4 = llvm.ashr %3, %0  : i64
    llvm.return %4 : i64
  }]

def lshr_32_add_zext_trunc_before := [llvmfunc|
  llvm.func @lshr_32_add_zext_trunc(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.add %1, %2  : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.lshr %3, %0  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.add %4, %6  : i32
    llvm.return %7 : i32
  }]

def add3_i96_before := [llvmfunc|
  llvm.func @add3_i96(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.undef : vector<3xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.extractelement %arg0[%0 : i64] : vector<3xi32>
    %9 = llvm.zext %8 : i32 to i64
    %10 = llvm.extractelement %arg1[%0 : i64] : vector<3xi32>
    %11 = llvm.zext %10 : i32 to i64
    %12 = llvm.add %11, %9 overflow<nsw, nuw>  : i64
    %13 = llvm.extractelement %arg0[%1 : i64] : vector<3xi32>
    %14 = llvm.zext %13 : i32 to i64
    %15 = llvm.extractelement %arg1[%1 : i64] : vector<3xi32>
    %16 = llvm.zext %15 : i32 to i64
    %17 = llvm.add %16, %14 overflow<nsw, nuw>  : i64
    %18 = llvm.lshr %12, %2  : i64
    %19 = llvm.add %17, %18 overflow<nsw, nuw>  : i64
    %20 = llvm.extractelement %arg0[%3 : i64] : vector<3xi32>
    %21 = llvm.extractelement %arg1[%3 : i64] : vector<3xi32>
    %22 = llvm.add %21, %20  : i32
    %23 = llvm.lshr %19, %2  : i64
    %24 = llvm.trunc %23 : i64 to i32
    %25 = llvm.add %22, %24  : i32
    %26 = llvm.trunc %12 : i64 to i32
    %27 = llvm.insertelement %26, %4[%5 : i32] : vector<3xi32>
    %28 = llvm.trunc %19 : i64 to i32
    %29 = llvm.insertelement %28, %27[%6 : i32] : vector<3xi32>
    %30 = llvm.insertelement %25, %29[%7 : i32] : vector<3xi32>
    llvm.return %30 : vector<3xi32>
  }]

def shl_fold_or_disjoint_cnt_before := [llvmfunc|
  llvm.func @shl_fold_or_disjoint_cnt(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.shl %1, %2  : i8
    llvm.return %3 : i8
  }]

def ashr_fold_or_disjoint_cnt_before := [llvmfunc|
  llvm.func @ashr_fold_or_disjoint_cnt(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.ashr %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def lshr_fold_or_disjoint_cnt_out_of_bounds_before := [llvmfunc|
  llvm.func @lshr_fold_or_disjoint_cnt_out_of_bounds(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 8]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def shl_C1_add_A_C2_i32_combined := [llvmfunc|
  llvm.func @shl_C1_add_A_C2_i32(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(192 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.shl %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_C1_add_A_C2_i32   : shl_C1_add_A_C2_i32_before  ⊑  shl_C1_add_A_C2_i32_combined := by
  unfold shl_C1_add_A_C2_i32_before shl_C1_add_A_C2_i32_combined
  simp_alive_peephole
  sorry
def ashr_C1_add_A_C2_i32_combined := [llvmfunc|
  llvm.func @ashr_C1_add_A_C2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ashr_C1_add_A_C2_i32   : ashr_C1_add_A_C2_i32_before  ⊑  ashr_C1_add_A_C2_i32_combined := by
  unfold ashr_C1_add_A_C2_i32_before ashr_C1_add_A_C2_i32_combined
  simp_alive_peephole
  sorry
def lshr_C1_add_A_C2_i32_combined := [llvmfunc|
  llvm.func @lshr_C1_add_A_C2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(192 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_C1_add_A_C2_i32   : lshr_C1_add_A_C2_i32_before  ⊑  lshr_C1_add_A_C2_i32_combined := by
  unfold lshr_C1_add_A_C2_i32_before lshr_C1_add_A_C2_i32_combined
  simp_alive_peephole
  sorry
def shl_C1_add_A_C2_v4i32_combined := [llvmfunc|
  llvm.func @shl_C1_add_A_C2_v4i32(%arg0: vector<4xi16>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(-458752 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(6 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.zext %arg0 : vector<4xi16> to vector<4xi32>
    %14 = llvm.shl %12, %13  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }]

theorem inst_combine_shl_C1_add_A_C2_v4i32   : shl_C1_add_A_C2_v4i32_before  ⊑  shl_C1_add_A_C2_v4i32_combined := by
  unfold shl_C1_add_A_C2_v4i32_before shl_C1_add_A_C2_v4i32_combined
  simp_alive_peephole
  sorry
def ashr_C1_add_A_C2_v4i32_combined := [llvmfunc|
  llvm.func @ashr_C1_add_A_C2_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 15, 255, 65535]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(6 : i32) : i32
    %5 = llvm.mlir.undef : vector<4xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.insertelement %2, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<4xi32>
    %14 = llvm.and %arg0, %0  : vector<4xi32>
    %15 = llvm.ashr %13, %14  : vector<4xi32>
    llvm.return %15 : vector<4xi32>
  }]

theorem inst_combine_ashr_C1_add_A_C2_v4i32   : ashr_C1_add_A_C2_v4i32_before  ⊑  ashr_C1_add_A_C2_v4i32_combined := by
  unfold ashr_C1_add_A_C2_v4i32_before ashr_C1_add_A_C2_v4i32_combined
  simp_alive_peephole
  sorry
def lshr_C1_add_A_C2_v4i32_combined := [llvmfunc|
  llvm.func @lshr_C1_add_A_C2_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 15, 255, 65535]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(6 : i32) : i32
    %5 = llvm.mlir.undef : vector<4xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.insertelement %2, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<4xi32>
    %14 = llvm.and %arg0, %0  : vector<4xi32>
    %15 = llvm.lshr %13, %14  : vector<4xi32>
    llvm.return %15 : vector<4xi32>
  }]

theorem inst_combine_lshr_C1_add_A_C2_v4i32   : lshr_C1_add_A_C2_v4i32_before  ⊑  lshr_C1_add_A_C2_v4i32_combined := by
  unfold lshr_C1_add_A_C2_v4i32_before lshr_C1_add_A_C2_v4i32_combined
  simp_alive_peephole
  sorry
def shl_C1_add_A_C2_v4i32_splat_combined := [llvmfunc|
  llvm.func @shl_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-458752 : i32) : i32
    %3 = llvm.mlir.poison : i32
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.mlir.constant(6 : i32) : i32
    %6 = llvm.mlir.undef : vector<4xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.insertelement %4, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.insertelement %3, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.insertelement %2, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.zext %arg0 : i16 to i32
    %16 = llvm.insertelement %15, %0[%1 : i64] : vector<4xi32>
    %17 = llvm.shufflevector %16, %0 [0, 0, 0, 0] : vector<4xi32> 
    %18 = llvm.shl %14, %17  : vector<4xi32>
    llvm.return %18 : vector<4xi32>
  }]

theorem inst_combine_shl_C1_add_A_C2_v4i32_splat   : shl_C1_add_A_C2_v4i32_splat_before  ⊑  shl_C1_add_A_C2_v4i32_splat_combined := by
  unfold shl_C1_add_A_C2_v4i32_splat_before shl_C1_add_A_C2_v4i32_splat_combined
  simp_alive_peephole
  sorry
def ashr_C1_add_A_C2_v4i32_splat_combined := [llvmfunc|
  llvm.func @ashr_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.poison : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(6 : i32) : i32
    %6 = llvm.mlir.undef : vector<4xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.insertelement %4, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.insertelement %3, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.insertelement %2, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.zext %arg0 : i16 to i32
    %16 = llvm.insertelement %15, %0[%1 : i64] : vector<4xi32>
    %17 = llvm.shufflevector %16, %0 [0, 0, 0, 0] : vector<4xi32> 
    %18 = llvm.ashr %14, %17  : vector<4xi32>
    llvm.return %18 : vector<4xi32>
  }]

theorem inst_combine_ashr_C1_add_A_C2_v4i32_splat   : ashr_C1_add_A_C2_v4i32_splat_before  ⊑  ashr_C1_add_A_C2_v4i32_splat_combined := by
  unfold ashr_C1_add_A_C2_v4i32_splat_before ashr_C1_add_A_C2_v4i32_splat_combined
  simp_alive_peephole
  sorry
def lshr_C1_add_A_C2_v4i32_splat_combined := [llvmfunc|
  llvm.func @lshr_C1_add_A_C2_v4i32_splat(%arg0: i16) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(65535 : i32) : i32
    %3 = llvm.mlir.poison : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(6 : i32) : i32
    %6 = llvm.mlir.undef : vector<4xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.insertelement %5, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.insertelement %4, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.insertelement %3, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.insertelement %2, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.zext %arg0 : i16 to i32
    %16 = llvm.insertelement %15, %0[%1 : i64] : vector<4xi32>
    %17 = llvm.shufflevector %16, %0 [0, 0, 0, 0] : vector<4xi32> 
    %18 = llvm.lshr %14, %17  : vector<4xi32>
    llvm.return %18 : vector<4xi32>
  }]

theorem inst_combine_lshr_C1_add_A_C2_v4i32_splat   : lshr_C1_add_A_C2_v4i32_splat_before  ⊑  lshr_C1_add_A_C2_v4i32_splat_combined := by
  unfold lshr_C1_add_A_C2_v4i32_splat_before lshr_C1_add_A_C2_v4i32_splat_combined
  simp_alive_peephole
  sorry
def shl_add_nuw_combined := [llvmfunc|
  llvm.func @shl_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(192 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_shl_add_nuw   : shl_add_nuw_before  ⊑  shl_add_nuw_combined := by
  unfold shl_add_nuw_before shl_add_nuw_combined
  simp_alive_peephole
  sorry
def lshr_add_nuw_combined := [llvmfunc|
  llvm.func @lshr_add_nuw(%arg0: vector<2xi12>) -> vector<2xi12> {
    %0 = llvm.mlir.constant(21 : i12) : i12
    %1 = llvm.mlir.constant(0 : i12) : i12
    %2 = llvm.mlir.constant(dense<[0, 21]> : vector<2xi12>) : vector<2xi12>
    %3 = llvm.lshr %2, %arg0  : vector<2xi12>
    llvm.return %3 : vector<2xi12>
  }]

theorem inst_combine_lshr_add_nuw   : lshr_add_nuw_before  ⊑  lshr_add_nuw_combined := by
  unfold lshr_add_nuw_before lshr_add_nuw_combined
  simp_alive_peephole
  sorry
def ashr_add_nuw_combined := [llvmfunc|
  llvm.func @ashr_add_nuw(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_ashr_add_nuw   : ashr_add_nuw_before  ⊑  ashr_add_nuw_combined := by
  unfold ashr_add_nuw_before ashr_add_nuw_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_ashr_add_nuw   : ashr_add_nuw_before  ⊑  ashr_add_nuw_combined := by
  unfold ashr_add_nuw_before ashr_add_nuw_combined
  simp_alive_peephole
  sorry
def shl_nuw_add_nuw_combined := [llvmfunc|
  llvm.func @shl_nuw_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_shl_nuw_add_nuw   : shl_nuw_add_nuw_before  ⊑  shl_nuw_add_nuw_combined := by
  unfold shl_nuw_add_nuw_before shl_nuw_add_nuw_combined
  simp_alive_peephole
  sorry
def shl_nsw_add_nuw_combined := [llvmfunc|
  llvm.func @shl_nsw_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_shl_nsw_add_nuw   : shl_nsw_add_nuw_before  ⊑  shl_nsw_add_nuw_combined := by
  unfold shl_nsw_add_nuw_before shl_nsw_add_nuw_combined
  simp_alive_peephole
  sorry
def lshr_exact_add_nuw_combined := [llvmfunc|
  llvm.func @lshr_exact_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_lshr_exact_add_nuw   : lshr_exact_add_nuw_before  ⊑  lshr_exact_add_nuw_combined := by
  unfold lshr_exact_add_nuw_before lshr_exact_add_nuw_combined
  simp_alive_peephole
  sorry
def ashr_exact_add_nuw_combined := [llvmfunc|
  llvm.func @ashr_exact_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.ashr %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_ashr_exact_add_nuw   : ashr_exact_add_nuw_before  ⊑  ashr_exact_add_nuw_combined := by
  unfold ashr_exact_add_nuw_before ashr_exact_add_nuw_combined
  simp_alive_peephole
  sorry
def shl_add_nsw_combined := [llvmfunc|
  llvm.func @shl_add_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.shl %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_shl_add_nsw   : shl_add_nsw_before  ⊑  shl_add_nsw_combined := by
  unfold shl_add_nsw_before shl_add_nsw_combined
  simp_alive_peephole
  sorry
def lshr_exact_add_positive_shift_positive_combined := [llvmfunc|
  llvm.func @lshr_exact_add_positive_shift_positive(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_exact_add_positive_shift_positive   : lshr_exact_add_positive_shift_positive_before  ⊑  lshr_exact_add_positive_shift_positive_combined := by
  unfold lshr_exact_add_positive_shift_positive_before lshr_exact_add_positive_shift_positive_combined
  simp_alive_peephole
  sorry
def lshr_exact_add_big_negative_offset_combined := [llvmfunc|
  llvm.func @lshr_exact_add_big_negative_offset(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_exact_add_big_negative_offset   : lshr_exact_add_big_negative_offset_before  ⊑  lshr_exact_add_big_negative_offset_combined := by
  unfold lshr_exact_add_big_negative_offset_before lshr_exact_add_big_negative_offset_combined
  simp_alive_peephole
  sorry
def lshr_exact_add_negative_shift_negative_combined := [llvmfunc|
  llvm.func @lshr_exact_add_negative_shift_negative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_exact_add_negative_shift_negative   : lshr_exact_add_negative_shift_negative_before  ⊑  lshr_exact_add_negative_shift_negative_combined := by
  unfold lshr_exact_add_negative_shift_negative_before lshr_exact_add_negative_shift_negative_combined
  simp_alive_peephole
  sorry
def lshr_add_negative_shift_no_exact_combined := [llvmfunc|
  llvm.func @lshr_add_negative_shift_no_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.lshr %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_add_negative_shift_no_exact   : lshr_add_negative_shift_no_exact_before  ⊑  lshr_add_negative_shift_no_exact_combined := by
  unfold lshr_add_negative_shift_no_exact_before lshr_add_negative_shift_no_exact_combined
  simp_alive_peephole
  sorry
def lshr_exact_add_negative_shift_positive_combined := [llvmfunc|
  llvm.func @lshr_exact_add_negative_shift_positive(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_lshr_exact_add_negative_shift_positive   : lshr_exact_add_negative_shift_positive_before  ⊑  lshr_exact_add_negative_shift_positive_combined := by
  unfold lshr_exact_add_negative_shift_positive_before lshr_exact_add_negative_shift_positive_combined
  simp_alive_peephole
  sorry
def lshr_exact_add_negative_shift_positive_extra_use_combined := [llvmfunc|
  llvm.func @lshr_exact_add_negative_shift_positive_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.lshr %1, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_lshr_exact_add_negative_shift_positive_extra_use   : lshr_exact_add_negative_shift_positive_extra_use_before  ⊑  lshr_exact_add_negative_shift_positive_extra_use_combined := by
  unfold lshr_exact_add_negative_shift_positive_extra_use_before lshr_exact_add_negative_shift_positive_extra_use_combined
  simp_alive_peephole
  sorry
def lshr_exact_add_negative_shift_positive_vec_combined := [llvmfunc|
  llvm.func @lshr_exact_add_negative_shift_positive_vec(%arg0: vector<2xi9>) -> vector<2xi9> {
    %0 = llvm.mlir.constant(-256 : i9) : i9
    %1 = llvm.mlir.constant(dense<-256> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.lshr %1, %arg0  : vector<2xi9>
    llvm.return %2 : vector<2xi9>
  }]

theorem inst_combine_lshr_exact_add_negative_shift_positive_vec   : lshr_exact_add_negative_shift_positive_vec_before  ⊑  lshr_exact_add_negative_shift_positive_vec_combined := by
  unfold lshr_exact_add_negative_shift_positive_vec_before lshr_exact_add_negative_shift_positive_vec_combined
  simp_alive_peephole
  sorry
def lshr_exact_add_negative_shift_lzcnt_combined := [llvmfunc|
  llvm.func @lshr_exact_add_negative_shift_lzcnt(%arg0: vector<2xi9>) -> vector<2xi9> {
    %0 = llvm.mlir.constant(-7 : i9) : i9
    %1 = llvm.mlir.constant(dense<-7> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.mlir.constant(4 : i9) : i9
    %3 = llvm.mlir.constant(dense<4> : vector<2xi9>) : vector<2xi9>
    %4 = llvm.add %arg0, %1  : vector<2xi9>
    %5 = llvm.lshr %3, %4  : vector<2xi9>
    llvm.return %5 : vector<2xi9>
  }]

theorem inst_combine_lshr_exact_add_negative_shift_lzcnt   : lshr_exact_add_negative_shift_lzcnt_before  ⊑  lshr_exact_add_negative_shift_lzcnt_combined := by
  unfold lshr_exact_add_negative_shift_lzcnt_before lshr_exact_add_negative_shift_lzcnt_combined
  simp_alive_peephole
  sorry
def ashr_exact_add_negative_shift_no_trailing_zeros_combined := [llvmfunc|
  llvm.func @ashr_exact_add_negative_shift_no_trailing_zeros(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.constant(-112 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.ashr %1, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_ashr_exact_add_negative_shift_no_trailing_zeros   : ashr_exact_add_negative_shift_no_trailing_zeros_before  ⊑  ashr_exact_add_negative_shift_no_trailing_zeros_combined := by
  unfold ashr_exact_add_negative_shift_no_trailing_zeros_before ashr_exact_add_negative_shift_no_trailing_zeros_combined
  simp_alive_peephole
  sorry
def ashr_exact_add_big_negative_offset_combined := [llvmfunc|
  llvm.func @ashr_exact_add_big_negative_offset(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.ashr %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashr_exact_add_big_negative_offset   : ashr_exact_add_big_negative_offset_before  ⊑  ashr_exact_add_big_negative_offset_combined := by
  unfold ashr_exact_add_big_negative_offset_before ashr_exact_add_big_negative_offset_combined
  simp_alive_peephole
  sorry
def ashr_add_negative_shift_no_exact_combined := [llvmfunc|
  llvm.func @ashr_add_negative_shift_no_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.ashr %1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashr_add_negative_shift_no_exact   : ashr_add_negative_shift_no_exact_before  ⊑  ashr_add_negative_shift_no_exact_combined := by
  unfold ashr_add_negative_shift_no_exact_before ashr_add_negative_shift_no_exact_combined
  simp_alive_peephole
  sorry
def ashr_exact_add_negative_shift_negative_combined := [llvmfunc|
  llvm.func @ashr_exact_add_negative_shift_negative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.ashr %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_ashr_exact_add_negative_shift_negative   : ashr_exact_add_negative_shift_negative_before  ⊑  ashr_exact_add_negative_shift_negative_combined := by
  unfold ashr_exact_add_negative_shift_negative_before ashr_exact_add_negative_shift_negative_combined
  simp_alive_peephole
  sorry
def ashr_exact_add_negative_shift_negative_extra_use_combined := [llvmfunc|
  llvm.func @ashr_exact_add_negative_shift_negative_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.ashr %1, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_ashr_exact_add_negative_shift_negative_extra_use   : ashr_exact_add_negative_shift_negative_extra_use_before  ⊑  ashr_exact_add_negative_shift_negative_extra_use_combined := by
  unfold ashr_exact_add_negative_shift_negative_extra_use_before ashr_exact_add_negative_shift_negative_extra_use_combined
  simp_alive_peephole
  sorry
def ashr_exact_add_negative_shift_negative_vec_combined := [llvmfunc|
  llvm.func @ashr_exact_add_negative_shift_negative_vec(%arg0: vector<2xi7>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(-64 : i7) : i7
    %1 = llvm.mlir.constant(dense<-64> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.ashr %1, %arg0  : vector<2xi7>
    llvm.return %2 : vector<2xi7>
  }]

theorem inst_combine_ashr_exact_add_negative_shift_negative_vec   : ashr_exact_add_negative_shift_negative_vec_before  ⊑  ashr_exact_add_negative_shift_negative_vec_combined := by
  unfold ashr_exact_add_negative_shift_negative_vec_before ashr_exact_add_negative_shift_negative_vec_combined
  simp_alive_peephole
  sorry
def ashr_exact_add_negative_leading_ones_vec_combined := [llvmfunc|
  llvm.func @ashr_exact_add_negative_leading_ones_vec(%arg0: vector<2xi7>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(-5 : i7) : i7
    %1 = llvm.mlir.constant(dense<-5> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(-4 : i7) : i7
    %3 = llvm.mlir.constant(dense<-4> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.add %arg0, %1  : vector<2xi7>
    %5 = llvm.ashr %3, %4  : vector<2xi7>
    llvm.return %5 : vector<2xi7>
  }]

theorem inst_combine_ashr_exact_add_negative_leading_ones_vec   : ashr_exact_add_negative_leading_ones_vec_before  ⊑  ashr_exact_add_negative_leading_ones_vec_combined := by
  unfold ashr_exact_add_negative_leading_ones_vec_before ashr_exact_add_negative_leading_ones_vec_combined
  simp_alive_peephole
  sorry
def shl_nsw_add_negative_combined := [llvmfunc|
  llvm.func @shl_nsw_add_negative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_shl_nsw_add_negative   : shl_nsw_add_negative_before  ⊑  shl_nsw_add_negative_combined := by
  unfold shl_nsw_add_negative_before shl_nsw_add_negative_combined
  simp_alive_peephole
  sorry
def shl_nuw_add_negative_splat_uses_combined := [llvmfunc|
  llvm.func @shl_nuw_add_negative_splat_uses(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    llvm.store %2, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr]

theorem inst_combine_shl_nuw_add_negative_splat_uses   : shl_nuw_add_negative_splat_uses_before  ⊑  shl_nuw_add_negative_splat_uses_combined := by
  unfold shl_nuw_add_negative_splat_uses_before shl_nuw_add_negative_splat_uses_combined
  simp_alive_peephole
  sorry
    %3 = llvm.shl %1, %arg0 overflow<nuw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_shl_nuw_add_negative_splat_uses   : shl_nuw_add_negative_splat_uses_before  ⊑  shl_nuw_add_negative_splat_uses_combined := by
  unfold shl_nuw_add_negative_splat_uses_before shl_nuw_add_negative_splat_uses_combined
  simp_alive_peephole
  sorry
def shl_nsw_add_negative_invalid_constant_combined := [llvmfunc|
  llvm.func @shl_nsw_add_negative_invalid_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_shl_nsw_add_negative_invalid_constant   : shl_nsw_add_negative_invalid_constant_before  ⊑  shl_nsw_add_negative_invalid_constant_combined := by
  unfold shl_nsw_add_negative_invalid_constant_before shl_nsw_add_negative_invalid_constant_combined
  simp_alive_peephole
  sorry
def shl_nsw_add_positive_invalid_constant_combined := [llvmfunc|
  llvm.func @shl_nsw_add_positive_invalid_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_shl_nsw_add_positive_invalid_constant   : shl_nsw_add_positive_invalid_constant_before  ⊑  shl_nsw_add_positive_invalid_constant_combined := by
  unfold shl_nsw_add_positive_invalid_constant_before shl_nsw_add_positive_invalid_constant_combined
  simp_alive_peephole
  sorry
def shl_nsw_add_negative_invalid_constant2_combined := [llvmfunc|
  llvm.func @shl_nsw_add_negative_invalid_constant2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_shl_nsw_add_negative_invalid_constant2   : shl_nsw_add_negative_invalid_constant2_before  ⊑  shl_nsw_add_negative_invalid_constant2_combined := by
  unfold shl_nsw_add_negative_invalid_constant2_before shl_nsw_add_negative_invalid_constant2_combined
  simp_alive_peephole
  sorry
def shl_nsw_add_negative_invalid_constant3_combined := [llvmfunc|
  llvm.func @shl_nsw_add_negative_invalid_constant3(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-8 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.shl %1, %2 overflow<nsw>  : i4
    llvm.return %3 : i4
  }]

theorem inst_combine_shl_nsw_add_negative_invalid_constant3   : shl_nsw_add_negative_invalid_constant3_before  ⊑  shl_nsw_add_negative_invalid_constant3_combined := by
  unfold shl_nsw_add_negative_invalid_constant3_before shl_nsw_add_negative_invalid_constant3_combined
  simp_alive_peephole
  sorry
def lshr_2_add_zext_basic_combined := [llvmfunc|
  llvm.func @lshr_2_add_zext_basic(%arg0: i1, %arg1: i1) -> i2 {
    %0 = llvm.and %arg0, %arg1  : i1
    %1 = llvm.zext %0 : i1 to i2
    llvm.return %1 : i2
  }]

theorem inst_combine_lshr_2_add_zext_basic   : lshr_2_add_zext_basic_before  ⊑  lshr_2_add_zext_basic_combined := by
  unfold lshr_2_add_zext_basic_before lshr_2_add_zext_basic_combined
  simp_alive_peephole
  sorry
def ashr_2_add_zext_basic_combined := [llvmfunc|
  llvm.func @ashr_2_add_zext_basic(%arg0: i1, %arg1: i1) -> i2 {
    %0 = llvm.mlir.constant(1 : i2) : i2
    %1 = llvm.zext %arg0 : i1 to i2
    %2 = llvm.zext %arg1 : i1 to i2
    %3 = llvm.add %1, %2 overflow<nuw>  : i2
    %4 = llvm.ashr %3, %0  : i2
    llvm.return %4 : i2
  }]

theorem inst_combine_ashr_2_add_zext_basic   : ashr_2_add_zext_basic_before  ⊑  ashr_2_add_zext_basic_combined := by
  unfold ashr_2_add_zext_basic_before ashr_2_add_zext_basic_combined
  simp_alive_peephole
  sorry
def lshr_16_add_zext_basic_combined := [llvmfunc|
  llvm.func @lshr_16_add_zext_basic(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.xor %arg0, %0  : i16
    %2 = llvm.icmp "ult" %1, %arg1 : i16
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_16_add_zext_basic   : lshr_16_add_zext_basic_before  ⊑  lshr_16_add_zext_basic_combined := by
  unfold lshr_16_add_zext_basic_before lshr_16_add_zext_basic_combined
  simp_alive_peephole
  sorry
def lshr_16_add_zext_basic_multiuse_combined := [llvmfunc|
  llvm.func @lshr_16_add_zext_basic_multiuse(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.zext %arg1 : i16 to i32
    %3 = llvm.add %1, %2 overflow<nsw, nuw>  : i32
    %4 = llvm.lshr %3, %0  : i32
    %5 = llvm.or %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_lshr_16_add_zext_basic_multiuse   : lshr_16_add_zext_basic_multiuse_before  ⊑  lshr_16_add_zext_basic_multiuse_combined := by
  unfold lshr_16_add_zext_basic_multiuse_before lshr_16_add_zext_basic_multiuse_combined
  simp_alive_peephole
  sorry
def lshr_16_add_known_16_leading_zeroes_combined := [llvmfunc|
  llvm.func @lshr_16_add_known_16_leading_zeroes(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.add %2, %3 overflow<nsw, nuw>  : i32
    %5 = llvm.lshr %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_lshr_16_add_known_16_leading_zeroes   : lshr_16_add_known_16_leading_zeroes_before  ⊑  lshr_16_add_known_16_leading_zeroes_combined := by
  unfold lshr_16_add_known_16_leading_zeroes_before lshr_16_add_known_16_leading_zeroes_combined
  simp_alive_peephole
  sorry
def lshr_16_add_not_known_16_leading_zeroes_combined := [llvmfunc|
  llvm.func @lshr_16_add_not_known_16_leading_zeroes(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(131071 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.add %3, %4 overflow<nsw, nuw>  : i32
    %6 = llvm.lshr %5, %2  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_lshr_16_add_not_known_16_leading_zeroes   : lshr_16_add_not_known_16_leading_zeroes_before  ⊑  lshr_16_add_not_known_16_leading_zeroes_combined := by
  unfold lshr_16_add_not_known_16_leading_zeroes_before lshr_16_add_not_known_16_leading_zeroes_combined
  simp_alive_peephole
  sorry
def lshr_32_add_zext_basic_combined := [llvmfunc|
  llvm.func @lshr_32_add_zext_basic(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    %3 = llvm.zext %2 : i1 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_lshr_32_add_zext_basic   : lshr_32_add_zext_basic_before  ⊑  lshr_32_add_zext_basic_combined := by
  unfold lshr_32_add_zext_basic_before lshr_32_add_zext_basic_combined
  simp_alive_peephole
  sorry
def lshr_32_add_zext_basic_multiuse_combined := [llvmfunc|
  llvm.func @lshr_32_add_zext_basic_multiuse(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.add %1, %2 overflow<nsw, nuw>  : i64
    %4 = llvm.lshr %3, %0  : i64
    %5 = llvm.or %4, %2  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_lshr_32_add_zext_basic_multiuse   : lshr_32_add_zext_basic_multiuse_before  ⊑  lshr_32_add_zext_basic_multiuse_combined := by
  unfold lshr_32_add_zext_basic_multiuse_before lshr_32_add_zext_basic_multiuse_combined
  simp_alive_peephole
  sorry
def lshr_31_i32_add_zext_basic_combined := [llvmfunc|
  llvm.func @lshr_31_i32_add_zext_basic(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.add %1, %2 overflow<nsw, nuw>  : i64
    %4 = llvm.lshr %3, %0  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_lshr_31_i32_add_zext_basic   : lshr_31_i32_add_zext_basic_before  ⊑  lshr_31_i32_add_zext_basic_combined := by
  unfold lshr_31_i32_add_zext_basic_before lshr_31_i32_add_zext_basic_combined
  simp_alive_peephole
  sorry
def lshr_33_i32_add_zext_basic_combined := [llvmfunc|
  llvm.func @lshr_33_i32_add_zext_basic(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_lshr_33_i32_add_zext_basic   : lshr_33_i32_add_zext_basic_before  ⊑  lshr_33_i32_add_zext_basic_combined := by
  unfold lshr_33_i32_add_zext_basic_before lshr_33_i32_add_zext_basic_combined
  simp_alive_peephole
  sorry
def lshr_16_to_64_add_zext_basic_combined := [llvmfunc|
  llvm.func @lshr_16_to_64_add_zext_basic(%arg0: i16, %arg1: i16) -> i64 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.xor %arg0, %0  : i16
    %2 = llvm.icmp "ult" %1, %arg1 : i16
    %3 = llvm.zext %2 : i1 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_lshr_16_to_64_add_zext_basic   : lshr_16_to_64_add_zext_basic_before  ⊑  lshr_16_to_64_add_zext_basic_combined := by
  unfold lshr_16_to_64_add_zext_basic_before lshr_16_to_64_add_zext_basic_combined
  simp_alive_peephole
  sorry
def lshr_32_add_known_32_leading_zeroes_combined := [llvmfunc|
  llvm.func @lshr_32_add_known_32_leading_zeroes(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.and %arg1, %0  : i64
    %4 = llvm.add %2, %3 overflow<nsw, nuw>  : i64
    %5 = llvm.lshr %4, %1  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_lshr_32_add_known_32_leading_zeroes   : lshr_32_add_known_32_leading_zeroes_before  ⊑  lshr_32_add_known_32_leading_zeroes_combined := by
  unfold lshr_32_add_known_32_leading_zeroes_before lshr_32_add_known_32_leading_zeroes_combined
  simp_alive_peephole
  sorry
def lshr_32_add_not_known_32_leading_zeroes_combined := [llvmfunc|
  llvm.func @lshr_32_add_not_known_32_leading_zeroes(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(8589934591 : i64) : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.and %arg1, %1  : i64
    %5 = llvm.add %3, %4 overflow<nsw, nuw>  : i64
    %6 = llvm.lshr %5, %2  : i64
    llvm.return %6 : i64
  }]

theorem inst_combine_lshr_32_add_not_known_32_leading_zeroes   : lshr_32_add_not_known_32_leading_zeroes_before  ⊑  lshr_32_add_not_known_32_leading_zeroes_combined := by
  unfold lshr_32_add_not_known_32_leading_zeroes_before lshr_32_add_not_known_32_leading_zeroes_combined
  simp_alive_peephole
  sorry
def ashr_16_add_zext_basic_combined := [llvmfunc|
  llvm.func @ashr_16_add_zext_basic(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.xor %arg0, %0  : i16
    %2 = llvm.icmp "ult" %1, %arg1 : i16
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashr_16_add_zext_basic   : ashr_16_add_zext_basic_before  ⊑  ashr_16_add_zext_basic_combined := by
  unfold ashr_16_add_zext_basic_before ashr_16_add_zext_basic_combined
  simp_alive_peephole
  sorry
def ashr_32_add_zext_basic_combined := [llvmfunc|
  llvm.func @ashr_32_add_zext_basic(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    %3 = llvm.zext %2 : i1 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_ashr_32_add_zext_basic   : ashr_32_add_zext_basic_before  ⊑  ashr_32_add_zext_basic_combined := by
  unfold ashr_32_add_zext_basic_before ashr_32_add_zext_basic_combined
  simp_alive_peephole
  sorry
def ashr_16_to_64_add_zext_basic_combined := [llvmfunc|
  llvm.func @ashr_16_to_64_add_zext_basic(%arg0: i16, %arg1: i16) -> i64 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.xor %arg0, %0  : i16
    %2 = llvm.icmp "ult" %1, %arg1 : i16
    %3 = llvm.zext %2 : i1 to i64
    llvm.return %3 : i64
  }]

theorem inst_combine_ashr_16_to_64_add_zext_basic   : ashr_16_to_64_add_zext_basic_before  ⊑  ashr_16_to_64_add_zext_basic_combined := by
  unfold ashr_16_to_64_add_zext_basic_before ashr_16_to_64_add_zext_basic_combined
  simp_alive_peephole
  sorry
def lshr_32_add_zext_trunc_combined := [llvmfunc|
  llvm.func @lshr_32_add_zext_trunc(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    %1 = llvm.icmp "ult" %0, %arg0 : i32
    %2 = llvm.zext %1 : i1 to i32
    %3 = llvm.add %0, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_32_add_zext_trunc   : lshr_32_add_zext_trunc_before  ⊑  lshr_32_add_zext_trunc_combined := by
  unfold lshr_32_add_zext_trunc_before lshr_32_add_zext_trunc_combined
  simp_alive_peephole
  sorry
def add3_i96_combined := [llvmfunc|
  llvm.func @add3_i96(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(32 : i64) : i64
    %4 = llvm.mlir.poison : vector<3xi32>
    %5 = llvm.extractelement %arg0[%0 : i64] : vector<3xi32>
    %6 = llvm.extractelement %arg1[%0 : i64] : vector<3xi32>
    %7 = llvm.add %6, %5  : i32
    %8 = llvm.icmp "ult" %7, %6 : i32
    %9 = llvm.extractelement %arg0[%1 : i64] : vector<3xi32>
    %10 = llvm.zext %9 : i32 to i64
    %11 = llvm.extractelement %arg1[%1 : i64] : vector<3xi32>
    %12 = llvm.zext %11 : i32 to i64
    %13 = llvm.add %12, %10 overflow<nsw, nuw>  : i64
    %14 = llvm.zext %8 : i1 to i64
    %15 = llvm.add %13, %14 overflow<nsw, nuw>  : i64
    %16 = llvm.extractelement %arg0[%2 : i64] : vector<3xi32>
    %17 = llvm.extractelement %arg1[%2 : i64] : vector<3xi32>
    %18 = llvm.add %17, %16  : i32
    %19 = llvm.lshr %15, %3  : i64
    %20 = llvm.trunc %19 : i64 to i32
    %21 = llvm.add %18, %20  : i32
    %22 = llvm.insertelement %7, %4[%0 : i64] : vector<3xi32>
    %23 = llvm.trunc %15 : i64 to i32
    %24 = llvm.insertelement %23, %22[%1 : i64] : vector<3xi32>
    %25 = llvm.insertelement %21, %24[%2 : i64] : vector<3xi32>
    llvm.return %25 : vector<3xi32>
  }]

theorem inst_combine_add3_i96   : add3_i96_before  ⊑  add3_i96_combined := by
  unfold add3_i96_before add3_i96_combined
  simp_alive_peephole
  sorry
def shl_fold_or_disjoint_cnt_combined := [llvmfunc|
  llvm.func @shl_fold_or_disjoint_cnt(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.shl %1, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_shl_fold_or_disjoint_cnt   : shl_fold_or_disjoint_cnt_before  ⊑  shl_fold_or_disjoint_cnt_combined := by
  unfold shl_fold_or_disjoint_cnt_before shl_fold_or_disjoint_cnt_combined
  simp_alive_peephole
  sorry
def ashr_fold_or_disjoint_cnt_combined := [llvmfunc|
  llvm.func @ashr_fold_or_disjoint_cnt(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_ashr_fold_or_disjoint_cnt   : ashr_fold_or_disjoint_cnt_before  ⊑  ashr_fold_or_disjoint_cnt_combined := by
  unfold ashr_fold_or_disjoint_cnt_before ashr_fold_or_disjoint_cnt_combined
  simp_alive_peephole
  sorry
def lshr_fold_or_disjoint_cnt_out_of_bounds_combined := [llvmfunc|
  llvm.func @lshr_fold_or_disjoint_cnt_out_of_bounds(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 8]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_lshr_fold_or_disjoint_cnt_out_of_bounds   : lshr_fold_or_disjoint_cnt_out_of_bounds_before  ⊑  lshr_fold_or_disjoint_cnt_out_of_bounds_combined := by
  unfold lshr_fold_or_disjoint_cnt_out_of_bounds_before lshr_fold_or_disjoint_cnt_out_of_bounds_combined
  simp_alive_peephole
  sorry
