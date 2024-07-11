import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  insert-extract-shuffle
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: vector<8xi8>) -> vector<1xi8> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.undef : vector<1xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %arg0[%0 : i32] : vector<8xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<1xi8>
    llvm.return %4 : vector<1xi8>
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: vector<8xi16>, %arg1: vector<8xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi16>
    %5 = llvm.extractelement %arg0[%0 : i32] : vector<8xi16>
    %6 = llvm.extractelement %arg0[%1 : i32] : vector<8xi16>
    %7 = llvm.extractelement %arg1[%2 : i32] : vector<8xi16>
    %8 = llvm.extractelement %arg0[%3 : i32] : vector<8xi16>
    %9 = llvm.insertelement %5, %4[%2 : i32] : vector<4xi16>
    %10 = llvm.insertelement %6, %9[%1 : i32] : vector<4xi16>
    %11 = llvm.insertelement %7, %10[%3 : i32] : vector<4xi16>
    %12 = llvm.insertelement %8, %11[%0 : i32] : vector<4xi16>
    llvm.return %12 : vector<4xi16>
  }]

def test_vcopyq_lane_p64_before := [llvmfunc|
  llvm.func @test_vcopyq_lane_p64(%arg0: vector<2xi64>, %arg1: vector<1xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.extractelement %arg1[%0 : i32] : vector<1xi64>
    %3 = llvm.insertelement %2, %arg0[%1 : i32] : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def widen_extract2_before := [llvmfunc|
  llvm.func @widen_extract2(%arg0: vector<4xf32>, %arg1: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.extractelement %arg1[%0 : i32] : vector<2xf32>
    %4 = llvm.extractelement %arg1[%1 : i32] : vector<2xf32>
    %5 = llvm.insertelement %3, %arg0[%1 : i32] : vector<4xf32>
    %6 = llvm.insertelement %4, %5[%2 : i32] : vector<4xf32>
    llvm.return %6 : vector<4xf32>
  }]

def widen_extract3_before := [llvmfunc|
  llvm.func @widen_extract3(%arg0: vector<4xf32>, %arg1: vector<3xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.extractelement %arg1[%0 : i32] : vector<3xf32>
    %4 = llvm.extractelement %arg1[%1 : i32] : vector<3xf32>
    %5 = llvm.extractelement %arg1[%2 : i32] : vector<3xf32>
    %6 = llvm.insertelement %3, %arg0[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %4, %6[%1 : i32] : vector<4xf32>
    %8 = llvm.insertelement %5, %7[%0 : i32] : vector<4xf32>
    llvm.return %8 : vector<4xf32>
  }]

def widen_extract4_before := [llvmfunc|
  llvm.func @widen_extract4(%arg0: vector<8xf32>, %arg1: vector<2xf32>) -> vector<8xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.extractelement %arg1[%0 : i32] : vector<2xf32>
    %3 = llvm.insertelement %2, %arg0[%1 : i32] : vector<8xf32>
    llvm.return %3 : vector<8xf32>
  }]

def pr26015_before := [llvmfunc|
  llvm.func @pr26015(%arg0: vector<4xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(dense<0> : vector<8xi16>) : vector<8xi16>
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(6 : i32) : i32
    %5 = llvm.mlir.constant(7 : i32) : i32
    %6 = llvm.extractelement %arg0[%0 : i32] : vector<4xi16>
    %7 = llvm.insertelement %6, %2[%3 : i32] : vector<8xi16>
    %8 = llvm.insertelement %1, %7[%4 : i32] : vector<8xi16>
    %9 = llvm.extractelement %arg0[%3 : i32] : vector<4xi16>
    %10 = llvm.insertelement %9, %8[%5 : i32] : vector<8xi16>
    llvm.return %10 : vector<8xi16>
  }]

def pr25999_before := [llvmfunc|
  llvm.func @pr25999(%arg0: vector<4xi16>, %arg1: i1) -> vector<8xi16> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant(dense<0> : vector<8xi16>) : vector<8xi16>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.mlir.constant(6 : i32) : i32
    %7 = llvm.mlir.constant(7 : i32) : i32
    %8 = llvm.extractelement %arg0[%0 : i32] : vector<4xi16>
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %9 = llvm.insertelement %8, %3[%5 : i32] : vector<8xi16>
    %10 = llvm.insertelement %2, %9[%6 : i32] : vector<8xi16>
    %11 = llvm.extractelement %arg0[%5 : i32] : vector<4xi16>
    %12 = llvm.insertelement %11, %10[%7 : i32] : vector<8xi16>
    llvm.return %12 : vector<8xi16>
  ^bb2:  // pred: ^bb0
    %13 = llvm.add %8, %1  : i16
    %14 = llvm.insertelement %13, %3[%4 : i32] : vector<8xi16>
    llvm.return %14 : vector<8xi16>
  }]

def pr25999_phis1_before := [llvmfunc|
  llvm.func @pr25999_phis1(%arg0: i1, %arg1: vector<2xf64>, %arg2: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : vector<2xf64>, vector<4xf64>)
  ^bb1:  // pred: ^bb0
    %4 = llvm.call @dummy(%arg1) : (vector<2xf64>) -> vector<2xf64>
    llvm.br ^bb2(%4, %1 : vector<2xf64>, vector<4xf64>)
  ^bb2(%5: vector<2xf64>, %6: vector<4xf64>):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.extractelement %5[%2 : i32] : vector<2xf64>
    %8 = llvm.insertelement %7, %6[%3 : i32] : vector<4xf64>
    llvm.return %8 : vector<4xf64>
  }]

def pr25999_phis2_before := [llvmfunc|
  llvm.func @pr25999_phis2(%arg0: i1, %arg1: vector<2xf64>, %arg2: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : vector<2xf64>, vector<4xf64>)
  ^bb1:  // pred: ^bb0
    %4 = llvm.call @dummy(%arg1) : (vector<2xf64>) -> vector<2xf64>
    llvm.br ^bb2(%4, %1 : vector<2xf64>, vector<4xf64>)
  ^bb2(%5: vector<2xf64>, %6: vector<4xf64>):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.fadd %5, %5  : vector<2xf64>
    %8 = llvm.extractelement %7[%2 : i32] : vector<2xf64>
    %9 = llvm.insertelement %8, %6[%3 : i32] : vector<4xf64>
    llvm.return %9 : vector<4xf64>
  }]

def pr26354_before := [llvmfunc|
  llvm.func @pr26354(%arg0: !llvm.ptr, %arg1: i1) -> f64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.undef : vector<4xf64>
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf64>) : vector<4xf64>
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<2xf64>]

    %7 = llvm.extractelement %6[%0 : i32] : vector<2xf64>
    %8 = llvm.extractelement %6[%1 : i32] : vector<2xf64>
    llvm.cond_br %arg1, ^bb1, ^bb2(%2 : vector<4xf64>)
  ^bb1:  // pred: ^bb0
    %9 = llvm.insertelement %8, %4[%5 : i32] : vector<4xf64>
    llvm.br ^bb2(%9 : vector<4xf64>)
  ^bb2(%10: vector<4xf64>):  // 2 preds: ^bb0, ^bb1
    %11 = llvm.extractelement %10[%1 : i32] : vector<4xf64>
    %12 = llvm.fmul %7, %11  : f64
    llvm.return %12 : f64
  }]

def PR30923_before := [llvmfunc|
  llvm.func @PR30923(%arg0: vector<2xf32>, %arg1: !llvm.ptr) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : vector<2xf32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %5 = llvm.mlir.undef : vector<4xf32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<4xf32>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %4, %7[%8 : i32] : vector<4xf32>
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.insertelement %3, %9[%10 : i32] : vector<4xf32>
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.insertelement %3, %11[%12 : i32] : vector<4xf32>
    %14 = llvm.mlir.constant(2 : i32) : i32
    %15 = llvm.mlir.constant(3 : i32) : i32
    %16 = llvm.extractelement %arg0[%0 : i32] : vector<2xf32>
    llvm.store %16, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %17 = llvm.shufflevector %arg0, %1 [0, 1, -1, -1] : vector<2xf32> 
    %18 = llvm.extractelement %17[%2 : i32] : vector<4xf32>
    %19 = llvm.insertelement %18, %13[%14 : i32] : vector<4xf32>
    %20 = llvm.insertelement %16, %19[%15 : i32] : vector<4xf32>
    llvm.return %20 : vector<4xf32>
  }]

def extractelt_insertion_before := [llvmfunc|
  llvm.func @extractelt_insertion(%arg0: vector<2xi32>, %arg1: i32) -> vector<4xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.extractelement %arg0[%0 : i32] : vector<2xi32>
    %6 = llvm.insertelement %5, %2[%3 : i64] : vector<4xi32>
    %7 = llvm.add %arg1, %4  : i32
    %8 = llvm.extractelement %arg0[%7 : i32] : vector<2xi32>
    %9 = llvm.icmp "eq" %8, %1 : i32
    %10 = llvm.select %9, %6, %2 : i1, vector<4xi32>
    llvm.return %10 : vector<4xi32>
  }]

def collectShuffleElts_before := [llvmfunc|
  llvm.func @collectShuffleElts(%arg0: vector<2xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.undef : vector<4xf32>
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.extractelement %arg0[%0 : i32] : vector<2xf32>
    %6 = llvm.extractelement %arg0[%1 : i32] : vector<2xf32>
    %7 = llvm.insertelement %5, %2[%1 : i32] : vector<4xf32>
    %8 = llvm.insertelement %6, %7[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %arg1, %8[%4 : i32] : vector<4xf32>
    llvm.return %9 : vector<4xf32>
  }]

def insert_shuffle_before := [llvmfunc|
  llvm.func @insert_shuffle(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %3 = llvm.shufflevector %2, %arg1 [0, 5, 6, 7] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

def insert_shuffle_translate_before := [llvmfunc|
  llvm.func @insert_shuffle_translate(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %3 = llvm.shufflevector %2, %arg1 [4, 0, 6, 7] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

def insert_not_undef_shuffle_translate_before := [llvmfunc|
  llvm.func @insert_not_undef_shuffle_translate(%arg0: f32, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.insertelement %arg0, %arg2[%0 : i32] : vector<4xf32>
    %2 = llvm.shufflevector %1, %arg1 [4, 5, 3, 7] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }]

def insert_not_undef_shuffle_translate_commute_before := [llvmfunc|
  llvm.func @insert_not_undef_shuffle_translate_commute(%arg0: f32, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.insertelement %arg0, %arg2[%0 : i32] : vector<4xf32>
    %2 = llvm.shufflevector %arg1, %1 [0, 6, 2, -1] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }]

def insert_insert_shuffle_translate_before := [llvmfunc|
  llvm.func @insert_insert_shuffle_translate(%arg0: f32, %arg1: f32, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg0, %arg2[%0 : i32] : vector<4xf32>
    %3 = llvm.insertelement %arg1, %arg2[%1 : i32] : vector<4xf32>
    %4 = llvm.shufflevector %2, %3 [4, 0, 6, 7] : vector<4xf32> 
    llvm.return %4 : vector<4xf32>
  }]

def insert_insert_shuffle_translate_commute_before := [llvmfunc|
  llvm.func @insert_insert_shuffle_translate_commute(%arg0: f32, %arg1: f32, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg0, %arg2[%0 : i32] : vector<4xf32>
    %3 = llvm.insertelement %arg1, %arg2[%1 : i32] : vector<4xf32>
    %4 = llvm.shufflevector %2, %3 [0, 6, 2, 3] : vector<4xf32> 
    llvm.return %4 : vector<4xf32>
  }]

def insert_insert_shuffle_translate_wrong_mask_before := [llvmfunc|
  llvm.func @insert_insert_shuffle_translate_wrong_mask(%arg0: f32, %arg1: f32, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg0, %arg2[%0 : i32] : vector<4xf32>
    %3 = llvm.insertelement %arg1, %arg2[%1 : i32] : vector<4xf32>
    %4 = llvm.shufflevector %2, %3 [0, 6, 2, 7] : vector<4xf32> 
    llvm.return %4 : vector<4xf32>
  }]

def insert_not_undef_shuffle_translate_commute_uses_before := [llvmfunc|
  llvm.func @insert_not_undef_shuffle_translate_commute_uses(%arg0: f32, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.insertelement %arg0, %arg2[%0 : i32] : vector<4xf32>
    llvm.call @use(%1) : (vector<4xf32>) -> ()
    %2 = llvm.shufflevector %arg1, %1 [6, -1, 2, 3] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }]

def insert_not_undef_shuffle_translate_commute_lengthen_before := [llvmfunc|
  llvm.func @insert_not_undef_shuffle_translate_commute_lengthen(%arg0: f32, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<5xf32> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.insertelement %arg0, %arg2[%0 : i32] : vector<4xf32>
    %2 = llvm.shufflevector %arg1, %1 [0, 6, 2, -1, -1] : vector<4xf32> 
    llvm.return %2 : vector<5xf32>
  }]

def insert_nonzero_index_splat_before := [llvmfunc|
  llvm.func @insert_nonzero_index_splat(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %3 = llvm.shufflevector %2, %0 [-1, 2, 2, -1] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

def insert_nonzero_index_splat_narrow_before := [llvmfunc|
  llvm.func @insert_nonzero_index_splat_narrow(%arg0: f64) -> vector<3xf64> {
    %0 = llvm.mlir.undef : vector<4xf64>
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf64>
    %3 = llvm.shufflevector %2, %0 [3, -1, 3] : vector<4xf64> 
    llvm.return %3 : vector<3xf64>
  }]

def insert_nonzero_index_splat_widen_before := [llvmfunc|
  llvm.func @insert_nonzero_index_splat_widen(%arg0: i7) -> vector<5xi7> {
    %0 = llvm.mlir.undef : vector<4xi7>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi7>
    %3 = llvm.shufflevector %2, %0 [-1, 1, 1, -1, 1] : vector<4xi7> 
    llvm.return %3 : vector<5xi7>
  }]

def insert_nonzero_index_splat_extra_use_before := [llvmfunc|
  llvm.func @insert_nonzero_index_splat_extra_use(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %2, %0 [-1, 2, 2, -1] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

def insert_nonzero_index_splat_wrong_base_before := [llvmfunc|
  llvm.func @insert_nonzero_index_splat_wrong_base(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xf32>
    %2 = llvm.insertelement %arg0, %arg1[%0 : i32] : vector<4xf32>
    %3 = llvm.shufflevector %2, %1 [-1, 2, 3, -1] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

def insert_nonzero_index_splat_wrong_index_before := [llvmfunc|
  llvm.func @insert_nonzero_index_splat_wrong_index(%arg0: f32, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.insertelement %arg0, %0[%arg1 : i32] : vector<4xf32>
    %2 = llvm.shufflevector %1, %0 [-1, 1, 1, -1] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }]

def insert_in_splat_before := [llvmfunc|
  llvm.func @insert_in_splat(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %4 = llvm.shufflevector %3, %0 [-1, 0, 0, -1] : vector<4xf32> 
    %5 = llvm.insertelement %arg0, %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

def insert_in_splat_extra_uses_before := [llvmfunc|
  llvm.func @insert_in_splat_extra_uses(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    llvm.call @use(%3) : (vector<4xf32>) -> ()
    %4 = llvm.shufflevector %3, %0 [-1, 0, 0, -1] : vector<4xf32> 
    llvm.call @use(%4) : (vector<4xf32>) -> ()
    %5 = llvm.insertelement %arg0, %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

def insert_in_splat_variable_index_before := [llvmfunc|
  llvm.func @insert_in_splat_variable_index(%arg0: f32, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %3 = llvm.shufflevector %2, %0 [-1, 0, 0, -1] : vector<4xf32> 
    %4 = llvm.insertelement %arg0, %3[%arg1 : i32] : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }]

def insert_in_nonsplat_before := [llvmfunc|
  llvm.func @insert_in_nonsplat(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %4 = llvm.shufflevector %3, %arg1 [-1, 0, 4, -1] : vector<4xf32> 
    %5 = llvm.insertelement %arg0, %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

def insert_in_nonsplat2_before := [llvmfunc|
  llvm.func @insert_in_nonsplat2(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xf32>
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.insertelement %arg0, %arg1[%0 : i32] : vector<4xf32>
    %4 = llvm.shufflevector %3, %1 [-1, 0, 1, -1] : vector<4xf32> 
    %5 = llvm.insertelement %arg0, %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

def shuf_identity_padding_before := [llvmfunc|
  llvm.func @shuf_identity_padding(%arg0: vector<2xi8>, %arg1: i8) -> vector<4xi8> {
    %0 = llvm.mlir.undef : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi8> 
    %4 = llvm.extractelement %arg0[%1 : i32] : vector<2xi8>
    %5 = llvm.insertelement %4, %3[%1 : i32] : vector<4xi8>
    %6 = llvm.insertelement %arg1, %5[%2 : i32] : vector<4xi8>
    llvm.return %6 : vector<4xi8>
  }]

def shuf_identity_extract_before := [llvmfunc|
  llvm.func @shuf_identity_extract(%arg0: vector<4xi8>, %arg1: i8) -> vector<3xi8> {
    %0 = llvm.mlir.undef : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.shufflevector %arg0, %0 [0, -1, -1] : vector<4xi8> 
    %4 = llvm.extractelement %arg0[%1 : i32] : vector<4xi8>
    %5 = llvm.insertelement %4, %3[%1 : i32] : vector<3xi8>
    %6 = llvm.insertelement %arg1, %5[%2 : i32] : vector<3xi8>
    llvm.return %6 : vector<3xi8>
  }]

def shuf_identity_extract_extra_use_before := [llvmfunc|
  llvm.func @shuf_identity_extract_extra_use(%arg0: vector<6xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<6xf32>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.shufflevector %arg0, %0 [0, -1, -1, 3] : vector<6xf32> 
    llvm.call @use(%3) : (vector<4xf32>) -> ()
    %4 = llvm.extractelement %arg0[%1 : i32] : vector<6xf32>
    %5 = llvm.insertelement %4, %3[%1 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg1, %5[%2 : i32] : vector<4xf32>
    llvm.return %6 : vector<4xf32>
  }]

def shuf_identity_padding_variable_index_before := [llvmfunc|
  llvm.func @shuf_identity_padding_variable_index(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<4xi8> {
    %0 = llvm.mlir.undef : vector<2xi8>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi8> 
    %3 = llvm.extractelement %arg0[%arg2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %2[%arg2 : i32] : vector<4xi8>
    %5 = llvm.insertelement %arg1, %4[%1 : i32] : vector<4xi8>
    llvm.return %5 : vector<4xi8>
  }]

def shuf_identity_padding_wrong_source_vec_before := [llvmfunc|
  llvm.func @shuf_identity_padding_wrong_source_vec(%arg0: vector<2xi8>, %arg1: i8, %arg2: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.undef : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi8> 
    %4 = llvm.extractelement %arg2[%1 : i32] : vector<2xi8>
    %5 = llvm.insertelement %4, %3[%1 : i32] : vector<4xi8>
    %6 = llvm.insertelement %arg1, %5[%2 : i32] : vector<4xi8>
    llvm.return %6 : vector<4xi8>
  }]

def shuf_identity_padding_wrong_index_before := [llvmfunc|
  llvm.func @shuf_identity_padding_wrong_index(%arg0: vector<2xi8>, %arg1: i8) -> vector<4xi8> {
    %0 = llvm.mlir.undef : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi8> 
    %5 = llvm.extractelement %arg0[%1 : i32] : vector<2xi8>
    %6 = llvm.insertelement %5, %4[%2 : i32] : vector<4xi8>
    %7 = llvm.insertelement %arg1, %6[%3 : i32] : vector<4xi8>
    llvm.return %7 : vector<4xi8>
  }]

def insert_undemanded_element_op0_before := [llvmfunc|
  llvm.func @insert_undemanded_element_op0(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %2, %arg1 [0, 7, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

def insert_undemanded_element_op1_before := [llvmfunc|
  llvm.func @insert_undemanded_element_op1(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %arg1, %2 [3, 2, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

def insert_undemanded_element_unequal_length_op0_before := [llvmfunc|
  llvm.func @insert_undemanded_element_unequal_length_op0(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<5xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %2, %arg1 [-1, 0, 7, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<5xf32>
  }]

def insert_undemanded_element_unequal_length_op1_before := [llvmfunc|
  llvm.func @insert_undemanded_element_unequal_length_op1(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<5xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %arg1, %2 [-1, 3, 2, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<5xf32>
  }]

def insert_demanded_element_op0_before := [llvmfunc|
  llvm.func @insert_demanded_element_op0(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %2, %arg1 [3, 2, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

def insert_demanded_element_op1_before := [llvmfunc|
  llvm.func @insert_demanded_element_op1(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(4.300000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %arg1, %2 [0, 7, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

def insert_demanded_element_unequal_length_op0_before := [llvmfunc|
  llvm.func @insert_demanded_element_unequal_length_op0(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<5xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %2, %arg1 [-1, 3, 2, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<5xf32>
  }]

def insert_demanded_element_unequal_length_op1_before := [llvmfunc|
  llvm.func @insert_demanded_element_unequal_length_op1(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<5xf32> {
    %0 = llvm.mlir.constant(4.300000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %arg1, %2 [-1, 0, 7, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<5xf32>
  }]

def splat_constant_before := [llvmfunc|
  llvm.func @splat_constant(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.undef : vector<4xf32>
    %3 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    %4 = llvm.shufflevector %3, %2 [3, 3, 3, 3] : vector<4xf32> 
    %5 = llvm.fadd %3, %4  : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

def infloop_D151807_before := [llvmfunc|
  llvm.func @infloop_D151807(%arg0: vector<4xf32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.shufflevector %arg0, %0 [2, -1] : vector<4xf32> 
    %5 = llvm.bitcast %4 : vector<2xf32> to vector<2xi32>
    %6 = llvm.extractelement %5[%1 : i64] : vector<2xi32>
    %7 = llvm.insertelement %6, %3[%1 : i64] : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: vector<8xi8>) -> vector<1xi8> {
    %0 = llvm.mlir.poison : vector<8xi8>
    %1 = llvm.shufflevector %arg0, %0 [5] : vector<8xi8> 
    llvm.return %1 : vector<1xi8>
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: vector<8xi16>, %arg1: vector<8xi16>) -> vector<4xi16> {
    %0 = llvm.shufflevector %arg1, %arg0 [11, 9, 0, 10] : vector<8xi16> 
    llvm.return %0 : vector<4xi16>
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test_vcopyq_lane_p64_combined := [llvmfunc|
  llvm.func @test_vcopyq_lane_p64(%arg0: vector<2xi64>, %arg1: vector<1xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : vector<1xi64>
    %1 = llvm.shufflevector %arg1, %0 [0, -1] : vector<1xi64> 
    %2 = llvm.shufflevector %arg0, %1 [0, 2] : vector<2xi64> 
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_test_vcopyq_lane_p64   : test_vcopyq_lane_p64_before  ⊑  test_vcopyq_lane_p64_combined := by
  unfold test_vcopyq_lane_p64_before test_vcopyq_lane_p64_combined
  simp_alive_peephole
  sorry
def widen_extract2_combined := [llvmfunc|
  llvm.func @widen_extract2(%arg0: vector<4xf32>, %arg1: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg1, %0 [0, 1, -1, -1] : vector<2xf32> 
    %2 = llvm.shufflevector %arg0, %1 [0, 4, 2, 5] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }]

theorem inst_combine_widen_extract2   : widen_extract2_before  ⊑  widen_extract2_combined := by
  unfold widen_extract2_before widen_extract2_combined
  simp_alive_peephole
  sorry
def widen_extract3_combined := [llvmfunc|
  llvm.func @widen_extract3(%arg0: vector<4xf32>, %arg1: vector<3xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<3xf32>
    %1 = llvm.shufflevector %arg1, %0 [0, 1, 2, -1] : vector<3xf32> 
    %2 = llvm.shufflevector %arg0, %1 [6, 5, 4, 3] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }]

theorem inst_combine_widen_extract3   : widen_extract3_before  ⊑  widen_extract3_combined := by
  unfold widen_extract3_before widen_extract3_combined
  simp_alive_peephole
  sorry
def widen_extract4_combined := [llvmfunc|
  llvm.func @widen_extract4(%arg0: vector<8xf32>, %arg1: vector<2xf32>) -> vector<8xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg1, %0 [0, -1, -1, -1, -1, -1, -1, -1] : vector<2xf32> 
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 8, 3, 4, 5, 6, 7] : vector<8xf32> 
    llvm.return %2 : vector<8xf32>
  }]

theorem inst_combine_widen_extract4   : widen_extract4_before  ⊑  widen_extract4_combined := by
  unfold widen_extract4_before widen_extract4_combined
  simp_alive_peephole
  sorry
def pr26015_combined := [llvmfunc|
  llvm.func @pr26015(%arg0: vector<4xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.poison : vector<4xi16>
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.undef : vector<8xi16>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<8xi16>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<8xi16>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<8xi16>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<8xi16>
    %12 = llvm.mlir.constant(4 : i32) : i32
    %13 = llvm.insertelement %2, %11[%12 : i32] : vector<8xi16>
    %14 = llvm.mlir.constant(5 : i32) : i32
    %15 = llvm.insertelement %2, %13[%14 : i32] : vector<8xi16>
    %16 = llvm.mlir.constant(6 : i32) : i32
    %17 = llvm.insertelement %2, %15[%16 : i32] : vector<8xi16>
    %18 = llvm.mlir.constant(7 : i32) : i32
    %19 = llvm.insertelement %1, %17[%18 : i32] : vector<8xi16>
    %20 = llvm.shufflevector %arg0, %0 [-1, -1, 2, 3, -1, -1, -1, -1] : vector<4xi16> 
    %21 = llvm.shufflevector %19, %20 [0, 1, 2, 10, 4, 5, 6, 11] : vector<8xi16> 
    llvm.return %21 : vector<8xi16>
  }]

theorem inst_combine_pr26015   : pr26015_before  ⊑  pr26015_combined := by
  unfold pr26015_before pr26015_combined
  simp_alive_peephole
  sorry
def pr25999_combined := [llvmfunc|
  llvm.func @pr25999(%arg0: vector<4xi16>, %arg1: i1) -> vector<8xi16> {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.poison : i16
    %4 = llvm.mlir.undef : vector<8xi16>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<8xi16>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<8xi16>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<8xi16>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %2, %10[%11 : i32] : vector<8xi16>
    %13 = llvm.mlir.constant(4 : i32) : i32
    %14 = llvm.insertelement %2, %12[%13 : i32] : vector<8xi16>
    %15 = llvm.mlir.constant(5 : i32) : i32
    %16 = llvm.insertelement %2, %14[%15 : i32] : vector<8xi16>
    %17 = llvm.mlir.constant(6 : i32) : i32
    %18 = llvm.insertelement %2, %16[%17 : i32] : vector<8xi16>
    %19 = llvm.mlir.constant(7 : i32) : i32
    %20 = llvm.insertelement %2, %18[%19 : i32] : vector<8xi16>
    %21 = llvm.mlir.constant(0 : i64) : i64
    %22 = llvm.mlir.poison : vector<4xi16>
    %23 = llvm.mlir.undef : vector<8xi16>
    %24 = llvm.mlir.constant(0 : i32) : i32
    %25 = llvm.insertelement %2, %23[%24 : i32] : vector<8xi16>
    %26 = llvm.mlir.constant(1 : i32) : i32
    %27 = llvm.insertelement %2, %25[%26 : i32] : vector<8xi16>
    %28 = llvm.mlir.constant(2 : i32) : i32
    %29 = llvm.insertelement %2, %27[%28 : i32] : vector<8xi16>
    %30 = llvm.mlir.constant(3 : i32) : i32
    %31 = llvm.insertelement %3, %29[%30 : i32] : vector<8xi16>
    %32 = llvm.mlir.constant(4 : i32) : i32
    %33 = llvm.insertelement %2, %31[%32 : i32] : vector<8xi16>
    %34 = llvm.mlir.constant(5 : i32) : i32
    %35 = llvm.insertelement %2, %33[%34 : i32] : vector<8xi16>
    %36 = llvm.mlir.constant(6 : i32) : i32
    %37 = llvm.insertelement %2, %35[%36 : i32] : vector<8xi16>
    %38 = llvm.mlir.constant(7 : i32) : i32
    %39 = llvm.insertelement %3, %37[%38 : i32] : vector<8xi16>
    %40 = llvm.mlir.constant(3 : i64) : i64
    %41 = llvm.extractelement %arg0[%0 : i64] : vector<4xi16>
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %42 = llvm.shufflevector %arg0, %22 [-1, -1, -1, 3, -1, -1, -1, -1] : vector<4xi16> 
    %43 = llvm.insertelement %41, %39[%40 : i64] : vector<8xi16>
    %44 = llvm.shufflevector %43, %42 [0, 1, 2, 3, 4, 5, 6, 11] : vector<8xi16> 
    llvm.return %44 : vector<8xi16>
  ^bb2:  // pred: ^bb0
    %45 = llvm.add %41, %1  : i16
    %46 = llvm.insertelement %45, %20[%21 : i64] : vector<8xi16>
    llvm.return %46 : vector<8xi16>
  }]

theorem inst_combine_pr25999   : pr25999_before  ⊑  pr25999_combined := by
  unfold pr25999_before pr25999_combined
  simp_alive_peephole
  sorry
def pr25999_phis1_combined := [llvmfunc|
  llvm.func @pr25999_phis1(%arg0: i1, %arg1: vector<2xf64>, %arg2: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.mlir.poison : vector<2xf64>
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : vector<2xf64>, vector<4xf64>)
  ^bb1:  // pred: ^bb0
    %3 = llvm.call @dummy(%arg1) : (vector<2xf64>) -> vector<2xf64>
    llvm.br ^bb2(%3, %1 : vector<2xf64>, vector<4xf64>)
  ^bb2(%4: vector<2xf64>, %5: vector<4xf64>):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.shufflevector %4, %2 [0, -1, -1, -1] : vector<2xf64> 
    %7 = llvm.shufflevector %5, %6 [0, 1, 4, 3] : vector<4xf64> 
    llvm.return %7 : vector<4xf64>
  }]

theorem inst_combine_pr25999_phis1   : pr25999_phis1_before  ⊑  pr25999_phis1_combined := by
  unfold pr25999_phis1_before pr25999_phis1_combined
  simp_alive_peephole
  sorry
def pr25999_phis2_combined := [llvmfunc|
  llvm.func @pr25999_phis2(%arg0: i1, %arg1: vector<2xf64>, %arg2: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.mlir.poison : vector<2xf64>
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : vector<2xf64>, vector<4xf64>)
  ^bb1:  // pred: ^bb0
    %3 = llvm.call @dummy(%arg1) : (vector<2xf64>) -> vector<2xf64>
    llvm.br ^bb2(%3, %1 : vector<2xf64>, vector<4xf64>)
  ^bb2(%4: vector<2xf64>, %5: vector<4xf64>):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.fadd %4, %4  : vector<2xf64>
    %7 = llvm.shufflevector %6, %2 [0, -1, -1, -1] : vector<2xf64> 
    %8 = llvm.shufflevector %5, %7 [0, 1, 4, 3] : vector<4xf64> 
    llvm.return %8 : vector<4xf64>
  }]

theorem inst_combine_pr25999_phis2   : pr25999_phis2_before  ⊑  pr25999_phis2_combined := by
  unfold pr25999_phis2_before pr25999_phis2_combined
  simp_alive_peephole
  sorry
def pr26354_combined := [llvmfunc|
  llvm.func @pr26354(%arg0: !llvm.ptr, %arg1: i1) -> f64 {
    %0 = llvm.mlir.undef : vector<4xf64>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.poison : f64
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.mlir.undef : vector<4xf64>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf64>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<4xf64>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %3, %8[%9 : i32] : vector<4xf64>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %2, %10[%11 : i32] : vector<4xf64>
    %13 = llvm.mlir.constant(3 : i64) : i64
    %14 = llvm.mlir.constant(0 : i64) : i64
    %15 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<2xf64>
    llvm.cond_br %arg1, ^bb1, ^bb2(%0 : vector<4xf64>)
  ^bb1:  // pred: ^bb0
    %16 = llvm.extractelement %15[%1 : i64] : vector<2xf64>
    %17 = llvm.insertelement %16, %12[%13 : i64] : vector<4xf64>
    llvm.br ^bb2(%17 : vector<4xf64>)
  ^bb2(%18: vector<4xf64>):  // 2 preds: ^bb0, ^bb1
    %19 = llvm.extractelement %15[%14 : i64] : vector<2xf64>
    %20 = llvm.extractelement %18[%1 : i64] : vector<4xf64>
    %21 = llvm.fmul %19, %20  : f64
    llvm.return %21 : f64
  }]

theorem inst_combine_pr26354   : pr26354_before  ⊑  pr26354_combined := by
  unfold pr26354_before pr26354_combined
  simp_alive_peephole
  sorry
def PR30923_combined := [llvmfunc|
  llvm.func @PR30923(%arg0: vector<2xf32>, %arg1: !llvm.ptr) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.poison : f32
    %3 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %4 = llvm.mlir.undef : vector<4xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<4xf32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %2, %10[%11 : i32] : vector<4xf32>
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.mlir.constant(3 : i64) : i64
    %15 = llvm.extractelement %arg0[%0 : i64] : vector<2xf32>
    llvm.store %15, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %16 = llvm.extractelement %arg0[%1 : i64] : vector<2xf32>
    %17 = llvm.insertelement %16, %12[%13 : i64] : vector<4xf32>
    %18 = llvm.insertelement %15, %17[%14 : i64] : vector<4xf32>
    llvm.return %18 : vector<4xf32>
  }]

theorem inst_combine_PR30923   : PR30923_before  ⊑  PR30923_combined := by
  unfold PR30923_before PR30923_combined
  simp_alive_peephole
  sorry
def extractelt_insertion_combined := [llvmfunc|
  llvm.func @extractelt_insertion(%arg0: vector<2xi32>, %arg1: i32) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %14 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi32> 
    %15 = llvm.shufflevector %11, %14 [0, 0, 0, 5] : vector<4xi32> 
    %16 = llvm.add %arg1, %12  : i32
    %17 = llvm.extractelement %14[%16 : i32] : vector<4xi32>
    %18 = llvm.icmp "eq" %17, %2 : i32
    %19 = llvm.select %18, %15, %13 : i1, vector<4xi32>
    llvm.return %19 : vector<4xi32>
  }]

theorem inst_combine_extractelt_insertion   : extractelt_insertion_before  ⊑  extractelt_insertion_combined := by
  unfold extractelt_insertion_before extractelt_insertion_combined
  simp_alive_peephole
  sorry
def collectShuffleElts_combined := [llvmfunc|
  llvm.func @collectShuffleElts(%arg0: vector<2xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.poison : f32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.mlir.undef : vector<4xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<4xf32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %2, %10[%11 : i32] : vector<4xf32>
    %13 = llvm.mlir.constant(2 : i64) : i64
    %14 = llvm.mlir.constant(3 : i64) : i64
    %15 = llvm.extractelement %arg0[%0 : i64] : vector<2xf32>
    %16 = llvm.extractelement %arg0[%1 : i64] : vector<2xf32>
    %17 = llvm.insertelement %15, %12[%1 : i64] : vector<4xf32>
    %18 = llvm.insertelement %16, %17[%13 : i64] : vector<4xf32>
    %19 = llvm.insertelement %arg1, %18[%14 : i64] : vector<4xf32>
    llvm.return %19 : vector<4xf32>
  }]

theorem inst_combine_collectShuffleElts   : collectShuffleElts_before  ⊑  collectShuffleElts_combined := by
  unfold collectShuffleElts_before collectShuffleElts_combined
  simp_alive_peephole
  sorry
def insert_shuffle_combined := [llvmfunc|
  llvm.func @insert_shuffle(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.insertelement %arg0, %arg1[%0 : i64] : vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

theorem inst_combine_insert_shuffle   : insert_shuffle_before  ⊑  insert_shuffle_combined := by
  unfold insert_shuffle_before insert_shuffle_combined
  simp_alive_peephole
  sorry
def insert_shuffle_translate_combined := [llvmfunc|
  llvm.func @insert_shuffle_translate(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.insertelement %arg0, %arg1[%0 : i64] : vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

theorem inst_combine_insert_shuffle_translate   : insert_shuffle_translate_before  ⊑  insert_shuffle_translate_combined := by
  unfold insert_shuffle_translate_before insert_shuffle_translate_combined
  simp_alive_peephole
  sorry
def insert_not_undef_shuffle_translate_combined := [llvmfunc|
  llvm.func @insert_not_undef_shuffle_translate(%arg0: f32, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.insertelement %arg0, %arg1[%0 : i64] : vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

theorem inst_combine_insert_not_undef_shuffle_translate   : insert_not_undef_shuffle_translate_before  ⊑  insert_not_undef_shuffle_translate_combined := by
  unfold insert_not_undef_shuffle_translate_before insert_not_undef_shuffle_translate_combined
  simp_alive_peephole
  sorry
def insert_not_undef_shuffle_translate_commute_combined := [llvmfunc|
  llvm.func @insert_not_undef_shuffle_translate_commute(%arg0: f32, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.insertelement %arg0, %arg1[%0 : i64] : vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

theorem inst_combine_insert_not_undef_shuffle_translate_commute   : insert_not_undef_shuffle_translate_commute_before  ⊑  insert_not_undef_shuffle_translate_commute_combined := by
  unfold insert_not_undef_shuffle_translate_commute_before insert_not_undef_shuffle_translate_commute_combined
  simp_alive_peephole
  sorry
def insert_insert_shuffle_translate_combined := [llvmfunc|
  llvm.func @insert_insert_shuffle_translate(%arg0: f32, %arg1: f32, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.insertelement %arg0, %arg2[%0 : i64] : vector<4xf32>
    %3 = llvm.insertelement %arg1, %2[%1 : i64] : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_insert_insert_shuffle_translate   : insert_insert_shuffle_translate_before  ⊑  insert_insert_shuffle_translate_combined := by
  unfold insert_insert_shuffle_translate_before insert_insert_shuffle_translate_combined
  simp_alive_peephole
  sorry
def insert_insert_shuffle_translate_commute_combined := [llvmfunc|
  llvm.func @insert_insert_shuffle_translate_commute(%arg0: f32, %arg1: f32, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.insertelement %arg0, %arg2[%0 : i64] : vector<4xf32>
    %3 = llvm.insertelement %arg1, %2[%1 : i64] : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_insert_insert_shuffle_translate_commute   : insert_insert_shuffle_translate_commute_before  ⊑  insert_insert_shuffle_translate_commute_combined := by
  unfold insert_insert_shuffle_translate_commute_before insert_insert_shuffle_translate_commute_combined
  simp_alive_peephole
  sorry
def insert_insert_shuffle_translate_wrong_mask_combined := [llvmfunc|
  llvm.func @insert_insert_shuffle_translate_wrong_mask(%arg0: f32, %arg1: f32, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.insertelement %arg0, %arg2[%0 : i64] : vector<4xf32>
    %3 = llvm.insertelement %arg1, %arg2[%1 : i64] : vector<4xf32>
    %4 = llvm.shufflevector %2, %3 [0, 6, 2, 7] : vector<4xf32> 
    llvm.return %4 : vector<4xf32>
  }]

theorem inst_combine_insert_insert_shuffle_translate_wrong_mask   : insert_insert_shuffle_translate_wrong_mask_before  ⊑  insert_insert_shuffle_translate_wrong_mask_combined := by
  unfold insert_insert_shuffle_translate_wrong_mask_before insert_insert_shuffle_translate_wrong_mask_combined
  simp_alive_peephole
  sorry
def insert_not_undef_shuffle_translate_commute_uses_combined := [llvmfunc|
  llvm.func @insert_not_undef_shuffle_translate_commute_uses(%arg0: f32, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %arg2[%0 : i64] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.insertelement %arg0, %arg1[%1 : i64] : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_insert_not_undef_shuffle_translate_commute_uses   : insert_not_undef_shuffle_translate_commute_uses_before  ⊑  insert_not_undef_shuffle_translate_commute_uses_combined := by
  unfold insert_not_undef_shuffle_translate_commute_uses_before insert_not_undef_shuffle_translate_commute_uses_combined
  simp_alive_peephole
  sorry
def insert_not_undef_shuffle_translate_commute_lengthen_combined := [llvmfunc|
  llvm.func @insert_not_undef_shuffle_translate_commute_lengthen(%arg0: f32, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<5xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xf32>
    %3 = llvm.shufflevector %arg1, %2 [0, 6, 2, -1, -1] : vector<4xf32> 
    llvm.return %3 : vector<5xf32>
  }]

theorem inst_combine_insert_not_undef_shuffle_translate_commute_lengthen   : insert_not_undef_shuffle_translate_commute_lengthen_before  ⊑  insert_not_undef_shuffle_translate_commute_lengthen_combined := by
  unfold insert_not_undef_shuffle_translate_commute_lengthen_before insert_not_undef_shuffle_translate_commute_lengthen_combined
  simp_alive_peephole
  sorry
def insert_nonzero_index_splat_combined := [llvmfunc|
  llvm.func @insert_nonzero_index_splat(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xf32>
    %3 = llvm.shufflevector %2, %0 [-1, 0, 0, -1] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_insert_nonzero_index_splat   : insert_nonzero_index_splat_before  ⊑  insert_nonzero_index_splat_combined := by
  unfold insert_nonzero_index_splat_before insert_nonzero_index_splat_combined
  simp_alive_peephole
  sorry
def insert_nonzero_index_splat_narrow_combined := [llvmfunc|
  llvm.func @insert_nonzero_index_splat_narrow(%arg0: f64) -> vector<3xf64> {
    %0 = llvm.mlir.poison : vector<3xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<3xf64>
    %3 = llvm.shufflevector %2, %0 [0, -1, 0] : vector<3xf64> 
    llvm.return %3 : vector<3xf64>
  }]

theorem inst_combine_insert_nonzero_index_splat_narrow   : insert_nonzero_index_splat_narrow_before  ⊑  insert_nonzero_index_splat_narrow_combined := by
  unfold insert_nonzero_index_splat_narrow_before insert_nonzero_index_splat_narrow_combined
  simp_alive_peephole
  sorry
def insert_nonzero_index_splat_widen_combined := [llvmfunc|
  llvm.func @insert_nonzero_index_splat_widen(%arg0: i7) -> vector<5xi7> {
    %0 = llvm.mlir.poison : vector<5xi7>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<5xi7>
    %3 = llvm.shufflevector %2, %0 [-1, 0, 0, -1, 0] : vector<5xi7> 
    llvm.return %3 : vector<5xi7>
  }]

theorem inst_combine_insert_nonzero_index_splat_widen   : insert_nonzero_index_splat_widen_before  ⊑  insert_nonzero_index_splat_widen_combined := by
  unfold insert_nonzero_index_splat_widen_before insert_nonzero_index_splat_widen_combined
  simp_alive_peephole
  sorry
def insert_nonzero_index_splat_extra_use_combined := [llvmfunc|
  llvm.func @insert_nonzero_index_splat_extra_use(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.undef : vector<4xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xf32>
    %11 = llvm.mlir.constant(2 : i64) : i64
    %12 = llvm.mlir.poison : vector<4xf32>
    %13 = llvm.insertelement %arg0, %10[%11 : i64] : vector<4xf32>
    llvm.call @use(%13) : (vector<4xf32>) -> ()
    %14 = llvm.shufflevector %13, %12 [-1, 2, 2, -1] : vector<4xf32> 
    llvm.return %14 : vector<4xf32>
  }]

theorem inst_combine_insert_nonzero_index_splat_extra_use   : insert_nonzero_index_splat_extra_use_before  ⊑  insert_nonzero_index_splat_extra_use_combined := by
  unfold insert_nonzero_index_splat_extra_use_before insert_nonzero_index_splat_extra_use_combined
  simp_alive_peephole
  sorry
def insert_nonzero_index_splat_wrong_base_combined := [llvmfunc|
  llvm.func @insert_nonzero_index_splat_wrong_base(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xf32>
    %2 = llvm.insertelement %arg0, %arg1[%0 : i64] : vector<4xf32>
    %3 = llvm.shufflevector %2, %1 [-1, 2, 3, -1] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_insert_nonzero_index_splat_wrong_base   : insert_nonzero_index_splat_wrong_base_before  ⊑  insert_nonzero_index_splat_wrong_base_combined := by
  unfold insert_nonzero_index_splat_wrong_base_before insert_nonzero_index_splat_wrong_base_combined
  simp_alive_peephole
  sorry
def insert_nonzero_index_splat_wrong_index_combined := [llvmfunc|
  llvm.func @insert_nonzero_index_splat_wrong_index(%arg0: f32, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.undef : f32
    %2 = llvm.mlir.undef : vector<4xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xf32>
    %11 = llvm.mlir.poison : vector<4xf32>
    %12 = llvm.insertelement %arg0, %10[%arg1 : i32] : vector<4xf32>
    %13 = llvm.shufflevector %12, %11 [-1, 1, 1, -1] : vector<4xf32> 
    llvm.return %13 : vector<4xf32>
  }]

theorem inst_combine_insert_nonzero_index_splat_wrong_index   : insert_nonzero_index_splat_wrong_index_before  ⊑  insert_nonzero_index_splat_wrong_index_combined := by
  unfold insert_nonzero_index_splat_wrong_index_before insert_nonzero_index_splat_wrong_index_combined
  simp_alive_peephole
  sorry
def insert_in_splat_combined := [llvmfunc|
  llvm.func @insert_in_splat(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xf32>
    %3 = llvm.shufflevector %2, %0 [-1, 0, 0, 0] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_insert_in_splat   : insert_in_splat_before  ⊑  insert_in_splat_combined := by
  unfold insert_in_splat_before insert_in_splat_combined
  simp_alive_peephole
  sorry
def insert_in_splat_extra_uses_combined := [llvmfunc|
  llvm.func @insert_in_splat_extra_uses(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.undef : vector<4xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xf32>
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.poison : vector<4xf32>
    %13 = llvm.insertelement %arg0, %10[%11 : i64] : vector<4xf32>
    llvm.call @use(%13) : (vector<4xf32>) -> ()
    %14 = llvm.shufflevector %13, %12 [-1, 0, 0, -1] : vector<4xf32> 
    llvm.call @use(%14) : (vector<4xf32>) -> ()
    %15 = llvm.shufflevector %13, %12 [-1, 0, 0, 0] : vector<4xf32> 
    llvm.return %15 : vector<4xf32>
  }]

theorem inst_combine_insert_in_splat_extra_uses   : insert_in_splat_extra_uses_before  ⊑  insert_in_splat_extra_uses_combined := by
  unfold insert_in_splat_extra_uses_before insert_in_splat_extra_uses_combined
  simp_alive_peephole
  sorry
def insert_in_splat_variable_index_combined := [llvmfunc|
  llvm.func @insert_in_splat_variable_index(%arg0: f32, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xf32>
    %3 = llvm.shufflevector %2, %0 [-1, 0, 0, -1] : vector<4xf32> 
    %4 = llvm.insertelement %arg0, %3[%arg1 : i32] : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }]

theorem inst_combine_insert_in_splat_variable_index   : insert_in_splat_variable_index_before  ⊑  insert_in_splat_variable_index_combined := by
  unfold insert_in_splat_variable_index_before insert_in_splat_variable_index_combined
  simp_alive_peephole
  sorry
def insert_in_nonsplat_combined := [llvmfunc|
  llvm.func @insert_in_nonsplat(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xf32>
    %4 = llvm.shufflevector %3, %arg1 [-1, 0, 4, -1] : vector<4xf32> 
    %5 = llvm.insertelement %arg0, %4[%2 : i64] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

theorem inst_combine_insert_in_nonsplat   : insert_in_nonsplat_before  ⊑  insert_in_nonsplat_combined := by
  unfold insert_in_nonsplat_before insert_in_nonsplat_combined
  simp_alive_peephole
  sorry
def insert_in_nonsplat2_combined := [llvmfunc|
  llvm.func @insert_in_nonsplat2(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xf32>
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.insertelement %arg0, %arg1[%0 : i64] : vector<4xf32>
    %4 = llvm.shufflevector %3, %1 [-1, 0, 1, -1] : vector<4xf32> 
    %5 = llvm.insertelement %arg0, %4[%2 : i64] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

theorem inst_combine_insert_in_nonsplat2   : insert_in_nonsplat2_before  ⊑  insert_in_nonsplat2_combined := by
  unfold insert_in_nonsplat2_before insert_in_nonsplat2_combined
  simp_alive_peephole
  sorry
def shuf_identity_padding_combined := [llvmfunc|
  llvm.func @shuf_identity_padding(%arg0: vector<2xi8>, %arg1: i8) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi8> 
    %3 = llvm.insertelement %arg1, %2[%1 : i64] : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_shuf_identity_padding   : shuf_identity_padding_before  ⊑  shuf_identity_padding_combined := by
  unfold shuf_identity_padding_before shuf_identity_padding_combined
  simp_alive_peephole
  sorry
def shuf_identity_extract_combined := [llvmfunc|
  llvm.func @shuf_identity_extract(%arg0: vector<4xi8>, %arg1: i8) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.shufflevector %arg0, %0 [0, 1, -1] : vector<4xi8> 
    %3 = llvm.insertelement %arg1, %2[%1 : i64] : vector<3xi8>
    llvm.return %3 : vector<3xi8>
  }]

theorem inst_combine_shuf_identity_extract   : shuf_identity_extract_before  ⊑  shuf_identity_extract_combined := by
  unfold shuf_identity_extract_before shuf_identity_extract_combined
  simp_alive_peephole
  sorry
def shuf_identity_extract_extra_use_combined := [llvmfunc|
  llvm.func @shuf_identity_extract_extra_use(%arg0: vector<6xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<6xf32>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.shufflevector %arg0, %0 [0, -1, -1, 3] : vector<6xf32> 
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %arg0, %0 [0, -1, 2, 3] : vector<6xf32> 
    %4 = llvm.insertelement %arg1, %3[%1 : i64] : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }]

theorem inst_combine_shuf_identity_extract_extra_use   : shuf_identity_extract_extra_use_before  ⊑  shuf_identity_extract_extra_use_combined := by
  unfold shuf_identity_extract_extra_use_before shuf_identity_extract_extra_use_combined
  simp_alive_peephole
  sorry
def shuf_identity_padding_variable_index_combined := [llvmfunc|
  llvm.func @shuf_identity_padding_variable_index(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi8> 
    %3 = llvm.extractelement %arg0[%arg2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %2[%arg2 : i32] : vector<4xi8>
    %5 = llvm.insertelement %arg1, %4[%1 : i64] : vector<4xi8>
    llvm.return %5 : vector<4xi8>
  }]

theorem inst_combine_shuf_identity_padding_variable_index   : shuf_identity_padding_variable_index_before  ⊑  shuf_identity_padding_variable_index_combined := by
  unfold shuf_identity_padding_variable_index_before shuf_identity_padding_variable_index_combined
  simp_alive_peephole
  sorry
def shuf_identity_padding_wrong_source_vec_combined := [llvmfunc|
  llvm.func @shuf_identity_padding_wrong_source_vec(%arg0: vector<2xi8>, %arg1: i8, %arg2: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.shufflevector %arg0, %0 [0, -1, -1, -1] : vector<2xi8> 
    %4 = llvm.extractelement %arg2[%1 : i64] : vector<2xi8>
    %5 = llvm.insertelement %4, %3[%1 : i64] : vector<4xi8>
    %6 = llvm.insertelement %arg1, %5[%2 : i64] : vector<4xi8>
    llvm.return %6 : vector<4xi8>
  }]

theorem inst_combine_shuf_identity_padding_wrong_source_vec   : shuf_identity_padding_wrong_source_vec_before  ⊑  shuf_identity_padding_wrong_source_vec_combined := by
  unfold shuf_identity_padding_wrong_source_vec_before shuf_identity_padding_wrong_source_vec_combined
  simp_alive_peephole
  sorry
def shuf_identity_padding_wrong_index_combined := [llvmfunc|
  llvm.func @shuf_identity_padding_wrong_index(%arg0: vector<2xi8>, %arg1: i8) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi8> 
    %5 = llvm.extractelement %arg0[%1 : i64] : vector<2xi8>
    %6 = llvm.insertelement %5, %4[%2 : i64] : vector<4xi8>
    %7 = llvm.insertelement %arg1, %6[%3 : i64] : vector<4xi8>
    llvm.return %7 : vector<4xi8>
  }]

theorem inst_combine_shuf_identity_padding_wrong_index   : shuf_identity_padding_wrong_index_before  ⊑  shuf_identity_padding_wrong_index_combined := by
  unfold shuf_identity_padding_wrong_index_before shuf_identity_padding_wrong_index_combined
  simp_alive_peephole
  sorry
def insert_undemanded_element_op0_combined := [llvmfunc|
  llvm.func @insert_undemanded_element_op0(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.insertelement %0, %arg0[%1 : i64] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %arg0, %arg1 [0, 7, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_insert_undemanded_element_op0   : insert_undemanded_element_op0_before  ⊑  insert_undemanded_element_op0_combined := by
  unfold insert_undemanded_element_op0_before insert_undemanded_element_op0_combined
  simp_alive_peephole
  sorry
def insert_undemanded_element_op1_combined := [llvmfunc|
  llvm.func @insert_undemanded_element_op1(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.insertelement %0, %arg0[%1 : i64] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %arg1, %arg0 [3, 2, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_insert_undemanded_element_op1   : insert_undemanded_element_op1_before  ⊑  insert_undemanded_element_op1_combined := by
  unfold insert_undemanded_element_op1_before insert_undemanded_element_op1_combined
  simp_alive_peephole
  sorry
def insert_undemanded_element_unequal_length_op0_combined := [llvmfunc|
  llvm.func @insert_undemanded_element_unequal_length_op0(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<5xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.insertelement %0, %arg0[%1 : i64] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %arg0, %arg1 [-1, 0, 7, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<5xf32>
  }]

theorem inst_combine_insert_undemanded_element_unequal_length_op0   : insert_undemanded_element_unequal_length_op0_before  ⊑  insert_undemanded_element_unequal_length_op0_combined := by
  unfold insert_undemanded_element_unequal_length_op0_before insert_undemanded_element_unequal_length_op0_combined
  simp_alive_peephole
  sorry
def insert_undemanded_element_unequal_length_op1_combined := [llvmfunc|
  llvm.func @insert_undemanded_element_unequal_length_op1(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<5xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.insertelement %0, %arg0[%1 : i64] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %arg1, %arg0 [-1, 3, 2, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<5xf32>
  }]

theorem inst_combine_insert_undemanded_element_unequal_length_op1   : insert_undemanded_element_unequal_length_op1_before  ⊑  insert_undemanded_element_unequal_length_op1_combined := by
  unfold insert_undemanded_element_unequal_length_op1_before insert_undemanded_element_unequal_length_op1_combined
  simp_alive_peephole
  sorry
def insert_demanded_element_op0_combined := [llvmfunc|
  llvm.func @insert_demanded_element_op0(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.insertelement %0, %arg0[%1 : i64] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %2, %arg1 [3, 2, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_insert_demanded_element_op0   : insert_demanded_element_op0_before  ⊑  insert_demanded_element_op0_combined := by
  unfold insert_demanded_element_op0_before insert_demanded_element_op0_combined
  simp_alive_peephole
  sorry
def insert_demanded_element_op1_combined := [llvmfunc|
  llvm.func @insert_demanded_element_op1(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(4.300000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.insertelement %0, %arg0[%1 : i64] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %arg1, %2 [0, 7, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_insert_demanded_element_op1   : insert_demanded_element_op1_before  ⊑  insert_demanded_element_op1_combined := by
  unfold insert_demanded_element_op1_before insert_demanded_element_op1_combined
  simp_alive_peephole
  sorry
def insert_demanded_element_unequal_length_op0_combined := [llvmfunc|
  llvm.func @insert_demanded_element_unequal_length_op0(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<5xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.insertelement %0, %arg0[%1 : i64] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %2, %arg1 [-1, 3, 2, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<5xf32>
  }]

theorem inst_combine_insert_demanded_element_unequal_length_op0   : insert_demanded_element_unequal_length_op0_before  ⊑  insert_demanded_element_unequal_length_op0_combined := by
  unfold insert_demanded_element_unequal_length_op0_before insert_demanded_element_unequal_length_op0_combined
  simp_alive_peephole
  sorry
def insert_demanded_element_unequal_length_op1_combined := [llvmfunc|
  llvm.func @insert_demanded_element_unequal_length_op1(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<5xf32> {
    %0 = llvm.mlir.constant(4.300000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.insertelement %0, %arg0[%1 : i64] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %arg1, %2 [-1, 0, 7, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<5xf32>
  }]

theorem inst_combine_insert_demanded_element_unequal_length_op1   : insert_demanded_element_unequal_length_op1_before  ⊑  insert_demanded_element_unequal_length_op1_combined := by
  unfold insert_demanded_element_unequal_length_op1_before insert_demanded_element_unequal_length_op1_combined
  simp_alive_peephole
  sorry
def splat_constant_combined := [llvmfunc|
  llvm.func @splat_constant(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(dense<3.000000e+00> : vector<4xf32>) : vector<4xf32>
    %3 = llvm.insertelement %0, %arg0[%1 : i64] : vector<4xf32>
    %4 = llvm.fadd %3, %2  : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }]

theorem inst_combine_splat_constant   : splat_constant_before  ⊑  splat_constant_combined := by
  unfold splat_constant_before splat_constant_combined
  simp_alive_peephole
  sorry
def infloop_D151807_combined := [llvmfunc|
  llvm.func @infloop_D151807(%arg0: vector<4xf32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.poison : vector<2xi32>
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %2, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.shufflevector %arg0, %0 [2, -1] : vector<4xf32> 
    %14 = llvm.bitcast %13 : vector<2xf32> to vector<2xi32>
    %15 = llvm.shufflevector %14, %1 [0, -1, -1, -1] : vector<2xi32> 
    %16 = llvm.shufflevector %12, %15 [4, 0, 0, 0] : vector<4xi32> 
    llvm.return %16 : vector<4xi32>
  }]

theorem inst_combine_infloop_D151807   : infloop_D151807_before  ⊑  infloop_D151807_combined := by
  unfold infloop_D151807_before infloop_D151807_combined
  simp_alive_peephole
  sorry
