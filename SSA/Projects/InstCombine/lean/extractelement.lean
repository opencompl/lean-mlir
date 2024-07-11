import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  extractelement
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def extractelement_out_of_range_before := [llvmfunc|
  llvm.func @extractelement_out_of_range(%arg0: vector<2xi32>) -> i32 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.extractelement %arg0[%0 : i8] : vector<2xi32>
    llvm.return %1 : i32
  }]

def extractelement_type_out_of_range_before := [llvmfunc|
  llvm.func @extractelement_type_out_of_range(%arg0: vector<2xi32>) -> i32 {
    %0 = llvm.mlir.constant(0 : i128) : i128
    %1 = llvm.extractelement %arg0[%0 : i128] : vector<2xi32>
    llvm.return %1 : i32
  }]

def bitcasted_inselt_equal_num_elts_before := [llvmfunc|
  llvm.func @bitcasted_inselt_equal_num_elts(%arg0: f32) -> i32 {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %3 = llvm.bitcast %2 : vector<4xf32> to vector<4xi32>
    %4 = llvm.extractelement %3[%1 : i32] : vector<4xi32>
    llvm.return %4 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.undef : vector<8xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 2, 3, 4, 5, 6, 7]> : vector<8xi64>) : vector<8xi64>
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<8xi64>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0, 0, 0, 0, 0] : vector<8xi64> 
    %5 = llvm.add %4, %2  : vector<8xi64>
    %6 = llvm.extractelement %5[%1 : i32] : vector<8xi64>
    llvm.return %6 : i64
  }]

def bitcasted_inselt_wide_source_zero_elt_before := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_zero_elt(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %arg0, %1[%2 : i32] : vector<2xi64>
    %4 = llvm.bitcast %3 : vector<2xi64> to vector<4xi32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xi32>
    llvm.return %5 : i32
  }]

def bitcasted_inselt_wide_source_modulo_elt_before := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_modulo_elt(%arg0: i64) -> i16 {
    %0 = llvm.mlir.undef : vector<2xi64>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi64>
    %4 = llvm.bitcast %3 : vector<2xi64> to vector<8xi16>
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi16>
    llvm.return %5 : i16
  }]

def bitcasted_inselt_wide_source_not_modulo_elt_before := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_not_modulo_elt(%arg0: i64) -> i32 {
    %0 = llvm.mlir.undef : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi64>
    %4 = llvm.bitcast %3 : vector<2xi64> to vector<4xi32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xi32>
    llvm.return %5 : i32
  }]

def bitcasted_inselt_wide_source_not_modulo_elt_not_half_before := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_not_modulo_elt_not_half(%arg0: i32) -> i8 {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi32>
    %4 = llvm.bitcast %3 : vector<2xi32> to vector<8xi8>
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi8>
    llvm.return %5 : i8
  }]

def bitcasted_inselt_wide_source_not_modulo_elt_not_half_weird_types_before := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_not_modulo_elt_not_half_weird_types(%arg0: i15) -> i3 {
    %0 = llvm.mlir.undef : vector<3xi15>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<3xi15>
    %4 = llvm.bitcast %3 : vector<3xi15> to vector<15xi3>
    %5 = llvm.extractelement %4[%2 : i32] : vector<15xi3>
    llvm.return %5 : i3
  }]

def bitcasted_inselt_wide_source_wrong_insert_before := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_wrong_insert(%arg0: vector<2xi32>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : vector<2xi32>
    %3 = llvm.bitcast %2 : vector<2xi32> to vector<8xi8>
    %4 = llvm.extractelement %3[%1 : i32] : vector<8xi8>
    llvm.return %4 : i8
  }]

def bitcasted_inselt_wide_source_uses_before := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_uses(%arg0: i32) -> i8 {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi32>
    %4 = llvm.bitcast %3 : vector<2xi32> to vector<8xi8>
    llvm.call @use(%4) : (vector<8xi8>) -> ()
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi8>
    llvm.return %5 : i8
  }]

def bitcasted_inselt_to_FP_before := [llvmfunc|
  llvm.func @bitcasted_inselt_to_FP(%arg0: i64) -> f32 {
    %0 = llvm.mlir.undef : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi64>
    %4 = llvm.bitcast %3 : vector<2xi64> to vector<4xf32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : f32
  }]

def bitcasted_inselt_to_FP_uses_before := [llvmfunc|
  llvm.func @bitcasted_inselt_to_FP_uses(%arg0: i128) -> f32 {
    %0 = llvm.mlir.undef : vector<2xi128>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi128>
    llvm.call @use_v2i128(%3) : (vector<2xi128>) -> ()
    %4 = llvm.bitcast %3 : vector<2xi128> to vector<8xf32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xf32>
    llvm.return %5 : f32
  }]

def bitcasted_inselt_to_FP_uses2_before := [llvmfunc|
  llvm.func @bitcasted_inselt_to_FP_uses2(%arg0: i128) -> f32 {
    %0 = llvm.mlir.undef : vector<2xi128>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi128>
    %4 = llvm.bitcast %3 : vector<2xi128> to vector<8xf32>
    llvm.call @use_v8f32(%4) : (vector<8xf32>) -> ()
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xf32>
    llvm.return %5 : f32
  }]

def bitcasted_inselt_from_FP_before := [llvmfunc|
  llvm.func @bitcasted_inselt_from_FP(%arg0: f64) -> i32 {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<4xi32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xi32>
    llvm.return %5 : i32
  }]

def bitcasted_inselt_from_FP_uses_before := [llvmfunc|
  llvm.func @bitcasted_inselt_from_FP_uses(%arg0: f64) -> i16 {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    llvm.call @use_v2f64(%3) : (vector<2xf64>) -> ()
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<8xi16>
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi16>
    llvm.return %5 : i16
  }]

def bitcasted_inselt_from_FP_uses2_before := [llvmfunc|
  llvm.func @bitcasted_inselt_from_FP_uses2(%arg0: f64) -> i16 {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<8xi16>
    llvm.call @use_v8i16(%4) : (vector<8xi16>) -> ()
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi16>
    llvm.return %5 : i16
  }]

def bitcasted_inselt_to_and_from_FP_before := [llvmfunc|
  llvm.func @bitcasted_inselt_to_and_from_FP(%arg0: f64) -> f32 {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<4xf32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : f32
  }]

def bitcasted_inselt_to_and_from_FP_uses_before := [llvmfunc|
  llvm.func @bitcasted_inselt_to_and_from_FP_uses(%arg0: f64) -> f32 {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    llvm.call @use_v2f64(%3) : (vector<2xf64>) -> ()
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<4xf32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : f32
  }]

def bitcasted_inselt_to_and_from_FP_uses2_before := [llvmfunc|
  llvm.func @bitcasted_inselt_to_and_from_FP_uses2(%arg0: f64) -> f32 {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<4xf32>
    llvm.call @use_v4f32(%4) : (vector<4xf32>) -> ()
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : f32
  }]

def invalid_extractelement_before := [llvmfunc|
  llvm.func @invalid_extractelement(%arg0: vector<2xf64>, %arg1: vector<4xf64>, %arg2: !llvm.ptr) -> vector<4xf64> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.extractelement %arg0[%0 : i32] : vector<2xf64>
    %6 = llvm.insertelement %5, %arg1[%1 : i32] : vector<4xf64>
    %7 = llvm.extractelement %6[%2 : i32] : vector<4xf64>
    llvm.store %7, %arg2 {alignment = 8 : i64} : f64, !llvm.ptr]

    %8 = llvm.extractelement %arg0[%3 : i32] : vector<2xf64>
    %9 = llvm.insertelement %8, %6[%4 : i64] : vector<4xf64>
    llvm.return %9 : vector<4xf64>
  }]

def bitcast_scalar_supported_type_index0_before := [llvmfunc|
  llvm.func @bitcast_scalar_supported_type_index0(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i32 to vector<4xi8>
    %2 = llvm.extractelement %1[%0 : i8] : vector<4xi8>
    llvm.return %2 : i8
  }]

def bitcast_scalar_supported_type_index2_before := [llvmfunc|
  llvm.func @bitcast_scalar_supported_type_index2(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.bitcast %arg0 : i32 to vector<4xi8>
    %2 = llvm.extractelement %1[%0 : i64] : vector<4xi8>
    llvm.return %2 : i8
  }]

def bitcast_scalar_legal_type_index3_before := [llvmfunc|
  llvm.func @bitcast_scalar_legal_type_index3(%arg0: i64) -> i4 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.bitcast %arg0 : i64 to vector<16xi4>
    %2 = llvm.extractelement %1[%0 : i64] : vector<16xi4>
    llvm.return %2 : i4
  }]

def bitcast_scalar_illegal_type_index1_before := [llvmfunc|
  llvm.func @bitcast_scalar_illegal_type_index1(%arg0: i128) -> i8 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.bitcast %arg0 : i128 to vector<16xi8>
    %2 = llvm.extractelement %1[%0 : i64] : vector<16xi8>
    llvm.return %2 : i8
  }]

def bitcast_fp_index0_before := [llvmfunc|
  llvm.func @bitcast_fp_index0(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : f32 to vector<4xi8>
    %2 = llvm.extractelement %1[%0 : i8] : vector<4xi8>
    llvm.return %2 : i8
  }]

def bitcast_fp16vec_index0_before := [llvmfunc|
  llvm.func @bitcast_fp16vec_index0(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i32 to vector<2xf16>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf16>
    llvm.return %2 : f16
  }]

def bitcast_fp16vec_index1_before := [llvmfunc|
  llvm.func @bitcast_fp16vec_index1(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i32 to vector<2xf16>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf16>
    llvm.return %2 : f16
  }]

def bitcast_bfp16vec_index0_before := [llvmfunc|
  llvm.func @bitcast_bfp16vec_index0(%arg0: i32) -> bf16 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i32 to vector<2xbf16>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xbf16>
    llvm.return %2 : bf16
  }]

def bitcast_bfp16vec_index1_before := [llvmfunc|
  llvm.func @bitcast_bfp16vec_index1(%arg0: i32) -> bf16 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i32 to vector<2xbf16>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xbf16>
    llvm.return %2 : bf16
  }]

def bitcast_fp32vec_index0_before := [llvmfunc|
  llvm.func @bitcast_fp32vec_index0(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i64 to vector<2xf32>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf32>
    llvm.return %2 : f32
  }]

def bitcast_fp32vec_index1_before := [llvmfunc|
  llvm.func @bitcast_fp32vec_index1(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i64 to vector<2xf32>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf32>
    llvm.return %2 : f32
  }]

def bitcast_fp64vec64_index0_before := [llvmfunc|
  llvm.func @bitcast_fp64vec64_index0(%arg0: i64) -> f64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i64 to vector<1xf64>
    %2 = llvm.extractelement %1[%0 : i8] : vector<1xf64>
    llvm.return %2 : f64
  }]

def bitcast_fp64vec_index0_before := [llvmfunc|
  llvm.func @bitcast_fp64vec_index0(%arg0: i128) -> f64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i128 to vector<2xf64>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf64>
    llvm.return %2 : f64
  }]

def bitcast_fp64vec_index1_before := [llvmfunc|
  llvm.func @bitcast_fp64vec_index1(%arg0: i128) -> f64 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i128 to vector<2xf64>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf64>
    llvm.return %2 : f64
  }]

def bitcast_x86fp80vec_index0_before := [llvmfunc|
  llvm.func @bitcast_x86fp80vec_index0(%arg0: i160) -> f80 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i160 to vector<2xf80>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf80>
    llvm.return %2 : f80
  }]

def bitcast_x86fp80vec_index1_before := [llvmfunc|
  llvm.func @bitcast_x86fp80vec_index1(%arg0: i160) -> f80 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i160 to vector<2xf80>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf80>
    llvm.return %2 : f80
  }]

def bitcast_fp128vec_index0_before := [llvmfunc|
  llvm.func @bitcast_fp128vec_index0(%arg0: i256) -> f128 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i256 to vector<2xf128>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf128>
    llvm.return %2 : f128
  }]

def bitcast_fp128vec_index1_before := [llvmfunc|
  llvm.func @bitcast_fp128vec_index1(%arg0: i256) -> f128 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i256 to vector<2xf128>
    %2 = llvm.extractelement %1[%0 : i8] : vector<2xf128>
    llvm.return %2 : f128
  }]

def bitcast_ppcfp128vec_index0_before := [llvmfunc|
  llvm.func @bitcast_ppcfp128vec_index0(%arg0: i256) -> !llvm.ppc_fp128 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.bitcast %arg0 : i256 to !llvm.vec<2 x ppc_fp128>
    %2 = llvm.extractelement %1[%0 : i8] : !llvm.vec<2 x ppc_fp128>
    llvm.return %2 : !llvm.ppc_fp128
  }]

def bitcast_ppcfp128vec_index1_before := [llvmfunc|
  llvm.func @bitcast_ppcfp128vec_index1(%arg0: i256) -> !llvm.ppc_fp128 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.bitcast %arg0 : i256 to !llvm.vec<2 x ppc_fp128>
    %2 = llvm.extractelement %1[%0 : i8] : !llvm.vec<2 x ppc_fp128>
    llvm.return %2 : !llvm.ppc_fp128
  }]

def bitcast_scalar_index_variable_before := [llvmfunc|
  llvm.func @bitcast_scalar_index_variable(%arg0: i32, %arg1: i64) -> i8 {
    %0 = llvm.bitcast %arg0 : i32 to vector<4xi8>
    %1 = llvm.extractelement %0[%arg1 : i64] : vector<4xi8>
    llvm.return %1 : i8
  }]

def bitcast_scalar_index0_use_before := [llvmfunc|
  llvm.func @bitcast_scalar_index0_use(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : i64 to vector<8xi8>
    llvm.call @use(%1) : (vector<8xi8>) -> ()
    %2 = llvm.extractelement %1[%0 : i64] : vector<8xi8>
    llvm.return %2 : i8
  }]

def bit_extract_cmp_before := [llvmfunc|
  llvm.func @bit_extract_cmp(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.bitcast %arg0 : i64 to vector<2xf32>
    %3 = llvm.extractelement %2[%0 : i8] : vector<2xf32>
    %4 = llvm.fcmp "oeq" %3, %1 : f32
    llvm.return %4 : i1
  }]

def extelt_select_const_operand_vector_before := [llvmfunc|
  llvm.func @extelt_select_const_operand_vector(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, vector<3xi32>
    %4 = llvm.extractelement %3[%2 : i32] : vector<3xi32>
    llvm.return %4 : i32
  }]

def extelt_select_const_operand_vector_float_before := [llvmfunc|
  llvm.func @extelt_select_const_operand_vector_float(%arg0: i1) -> f32 {
    %0 = llvm.mlir.constant(dense<[2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, vector<3xf32>
    %4 = llvm.extractelement %3[%2 : i32] : vector<3xf32>
    llvm.return %4 : f32
  }]

def extelt_vecselect_const_operand_vector_before := [llvmfunc|
  llvm.func @extelt_vecselect_const_operand_vector(%arg0: vector<3xi1>) -> i32 {
    %0 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : vector<3xi1>, vector<3xi32>
    %4 = llvm.extractelement %3[%2 : i32] : vector<3xi32>
    llvm.return %4 : i32
  }]

def extelt_select_const_operand_extractelt_use_before := [llvmfunc|
  llvm.func @extelt_select_const_operand_extractelt_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.select %arg0, %0, %1 : i1, vector<3xi32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<3xi32>
    %6 = llvm.mul %5, %2  : i32
    %7 = llvm.mul %5, %3  : i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }]

def extelt_select_const_operand_select_use_before := [llvmfunc|
  llvm.func @extelt_select_const_operand_select_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.select %arg0, %0, %1 : i1, vector<3xi32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<3xi32>
    %6 = llvm.extractelement %4[%3 : i32] : vector<3xi32>
    %7 = llvm.mul %5, %6  : i32
    llvm.return %7 : i32
  }]

def extelt_select_const_operand_vector_cond_index_before := [llvmfunc|
  llvm.func @extelt_select_const_operand_vector_cond_index(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi32>) : vector<3xi32>
    %3 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %4 = llvm.select %arg0, %0, %1 : i1, i32
    %5 = llvm.select %arg0, %2, %3 : i1, vector<3xi32>
    %6 = llvm.extractelement %5[%4 : i32] : vector<3xi32>
    llvm.return %6 : i32
  }]

def extelt_select_const_operand_vector_var_index_before := [llvmfunc|
  llvm.func @extelt_select_const_operand_vector_var_index(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<3xi32>
    %3 = llvm.extractelement %2[%arg1 : i32] : vector<3xi32>
    llvm.return %3 : i32
  }]

def extelt_select_var_const_operand_vector_before := [llvmfunc|
  llvm.func @extelt_select_var_const_operand_vector(%arg0: i1, %arg1: vector<3xi32>) -> i32 {
    %0 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.select %arg0, %arg1, %0 : i1, vector<3xi32>
    %3 = llvm.extractelement %2[%1 : i32] : vector<3xi32>
    llvm.return %3 : i32
  }]

def extelt_select_const_var_operand_vector_before := [llvmfunc|
  llvm.func @extelt_select_const_var_operand_vector(%arg0: i1, %arg1: vector<3xi32>) -> i32 {
    %0 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, vector<3xi32>
    %3 = llvm.extractelement %2[%1 : i32] : vector<3xi32>
    llvm.return %3 : i32
  }]

def extelt_select_const_var_operands_vector_extra_use_before := [llvmfunc|
  llvm.func @extelt_select_const_var_operands_vector_extra_use(%arg0: i1, %arg1: vector<3xi32>) -> i32 {
    %0 = llvm.mlir.constant(dense<[42, 5, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.select %arg0, %0, %arg1 : i1, vector<3xi32>
    llvm.call @use_select(%2) : (vector<3xi32>) -> ()
    %3 = llvm.extractelement %2[%1 : i64] : vector<3xi32>
    llvm.return %3 : i32
  }]

def extelt_select_const_operands_vector_extra_use_2_before := [llvmfunc|
  llvm.func @extelt_select_const_operands_vector_extra_use_2(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(dense<[42, 5, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.select %arg0, %0, %1 : i1, vector<3xi32>
    llvm.call @use_select(%3) : (vector<3xi32>) -> ()
    %4 = llvm.extractelement %3[%2 : i64] : vector<3xi32>
    llvm.return %4 : i32
  }]

def crash_4b8320_before := [llvmfunc|
  llvm.func @crash_4b8320(%arg0: vector<2xf32>, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(2 : i64) : i64
    %6 = llvm.fmul %1, %arg0  : vector<2xf32>
    %7 = llvm.fmul %1, %6  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf32>]

    %8 = llvm.extractelement %7[%2 : i64] : vector<2xf32>
    %9 = llvm.extractelement %7[%2 : i64] : vector<2xf32>
    %10 = llvm.insertelement %8, %3[%2 : i64] : vector<4xf32>
    %11 = llvm.insertelement %9, %10[%4 : i64] : vector<4xf32>
    %12 = llvm.insertelement %arg1, %11[%5 : i64] : vector<4xf32>
    %13 = llvm.shufflevector %12, %3 [1, 1, 1, 1] : vector<4xf32> 
    %14 = llvm.fadd %13, %12  : vector<4xf32>
    %15 = llvm.shufflevector %12, %3 [3, 3, 3, 3] : vector<4xf32> 
    %16 = llvm.fadd %14, %15  : vector<4xf32>
    %17 = llvm.extractelement %16[%2 : i64] : vector<4xf32>
    llvm.return %17 : f32
  }]

def extractelement_out_of_range_combined := [llvmfunc|
  llvm.func @extractelement_out_of_range(%arg0: vector<2xi32>) -> i32 {
    %0 = llvm.mlir.poison : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_extractelement_out_of_range   : extractelement_out_of_range_before  ⊑  extractelement_out_of_range_combined := by
  unfold extractelement_out_of_range_before extractelement_out_of_range_combined
  simp_alive_peephole
  sorry
def extractelement_type_out_of_range_combined := [llvmfunc|
  llvm.func @extractelement_type_out_of_range(%arg0: vector<2xi32>) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<2xi32>
    llvm.return %1 : i32
  }]

theorem inst_combine_extractelement_type_out_of_range   : extractelement_type_out_of_range_before  ⊑  extractelement_type_out_of_range_combined := by
  unfold extractelement_type_out_of_range_before extractelement_type_out_of_range_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_equal_num_elts_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_equal_num_elts(%arg0: f32) -> i32 {
    %0 = llvm.bitcast %arg0 : f32 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_bitcasted_inselt_equal_num_elts   : bitcasted_inselt_equal_num_elts_before  ⊑  bitcasted_inselt_equal_num_elts_combined := by
  unfold bitcasted_inselt_equal_num_elts_before bitcasted_inselt_equal_num_elts_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i64) -> i64 {
    llvm.return %arg0 : i64
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_wide_source_zero_elt_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_zero_elt(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_bitcasted_inselt_wide_source_zero_elt   : bitcasted_inselt_wide_source_zero_elt_before  ⊑  bitcasted_inselt_wide_source_zero_elt_combined := by
  unfold bitcasted_inselt_wide_source_zero_elt_before bitcasted_inselt_wide_source_zero_elt_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_wide_source_modulo_elt_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_modulo_elt(%arg0: i64) -> i16 {
    %0 = llvm.trunc %arg0 : i64 to i16
    llvm.return %0 : i16
  }]

theorem inst_combine_bitcasted_inselt_wide_source_modulo_elt   : bitcasted_inselt_wide_source_modulo_elt_before  ⊑  bitcasted_inselt_wide_source_modulo_elt_combined := by
  unfold bitcasted_inselt_wide_source_modulo_elt_before bitcasted_inselt_wide_source_modulo_elt_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_wide_source_not_modulo_elt_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_not_modulo_elt(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_bitcasted_inselt_wide_source_not_modulo_elt   : bitcasted_inselt_wide_source_not_modulo_elt_before  ⊑  bitcasted_inselt_wide_source_not_modulo_elt_combined := by
  unfold bitcasted_inselt_wide_source_not_modulo_elt_before bitcasted_inselt_wide_source_not_modulo_elt_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_wide_source_not_modulo_elt_not_half_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_not_modulo_elt_not_half(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_bitcasted_inselt_wide_source_not_modulo_elt_not_half   : bitcasted_inselt_wide_source_not_modulo_elt_not_half_before  ⊑  bitcasted_inselt_wide_source_not_modulo_elt_not_half_combined := by
  unfold bitcasted_inselt_wide_source_not_modulo_elt_not_half_before bitcasted_inselt_wide_source_not_modulo_elt_not_half_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_wide_source_not_modulo_elt_not_half_weird_types_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_not_modulo_elt_not_half_weird_types(%arg0: i15) -> i3 {
    %0 = llvm.mlir.constant(3 : i15) : i15
    %1 = llvm.lshr %arg0, %0  : i15
    %2 = llvm.trunc %1 : i15 to i3
    llvm.return %2 : i3
  }]

theorem inst_combine_bitcasted_inselt_wide_source_not_modulo_elt_not_half_weird_types   : bitcasted_inselt_wide_source_not_modulo_elt_not_half_weird_types_before  ⊑  bitcasted_inselt_wide_source_not_modulo_elt_not_half_weird_types_combined := by
  unfold bitcasted_inselt_wide_source_not_modulo_elt_not_half_weird_types_before bitcasted_inselt_wide_source_not_modulo_elt_not_half_weird_types_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_wide_source_wrong_insert_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_wrong_insert(%arg0: vector<2xi32>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xi32> to vector<8xi8>
    %2 = llvm.extractelement %1[%0 : i64] : vector<8xi8>
    llvm.return %2 : i8
  }]

theorem inst_combine_bitcasted_inselt_wide_source_wrong_insert   : bitcasted_inselt_wide_source_wrong_insert_before  ⊑  bitcasted_inselt_wide_source_wrong_insert_combined := by
  unfold bitcasted_inselt_wide_source_wrong_insert_before bitcasted_inselt_wide_source_wrong_insert_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_wide_source_uses_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_uses(%arg0: i32) -> i8 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.constant(3 : i64) : i64
    %9 = llvm.insertelement %arg0, %6[%7 : i64] : vector<2xi32>
    %10 = llvm.bitcast %9 : vector<2xi32> to vector<8xi8>
    llvm.call @use(%10) : (vector<8xi8>) -> ()
    %11 = llvm.extractelement %10[%8 : i64] : vector<8xi8>
    llvm.return %11 : i8
  }]

theorem inst_combine_bitcasted_inselt_wide_source_uses   : bitcasted_inselt_wide_source_uses_before  ⊑  bitcasted_inselt_wide_source_uses_combined := by
  unfold bitcasted_inselt_wide_source_uses_before bitcasted_inselt_wide_source_uses_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_to_FP_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_to_FP(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_bitcasted_inselt_to_FP   : bitcasted_inselt_to_FP_before  ⊑  bitcasted_inselt_to_FP_combined := by
  unfold bitcasted_inselt_to_FP_before bitcasted_inselt_to_FP_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_to_FP_uses_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_to_FP_uses(%arg0: i128) -> f32 {
    %0 = llvm.mlir.undef : i128
    %1 = llvm.mlir.poison : i128
    %2 = llvm.mlir.undef : vector<2xi128>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi128>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi128>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.constant(1 : i64) : i64
    %9 = llvm.insertelement %arg0, %6[%7 : i64] : vector<2xi128>
    llvm.call @use_v2i128(%9) : (vector<2xi128>) -> ()
    %10 = llvm.bitcast %9 : vector<2xi128> to vector<8xf32>
    %11 = llvm.extractelement %10[%8 : i64] : vector<8xf32>
    llvm.return %11 : f32
  }]

theorem inst_combine_bitcasted_inselt_to_FP_uses   : bitcasted_inselt_to_FP_uses_before  ⊑  bitcasted_inselt_to_FP_uses_combined := by
  unfold bitcasted_inselt_to_FP_uses_before bitcasted_inselt_to_FP_uses_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_to_FP_uses2_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_to_FP_uses2(%arg0: i128) -> f32 {
    %0 = llvm.mlir.undef : i128
    %1 = llvm.mlir.poison : i128
    %2 = llvm.mlir.undef : vector<2xi128>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi128>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi128>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.constant(1 : i64) : i64
    %9 = llvm.insertelement %arg0, %6[%7 : i64] : vector<2xi128>
    %10 = llvm.bitcast %9 : vector<2xi128> to vector<8xf32>
    llvm.call @use_v8f32(%10) : (vector<8xf32>) -> ()
    %11 = llvm.extractelement %10[%8 : i64] : vector<8xf32>
    llvm.return %11 : f32
  }]

theorem inst_combine_bitcasted_inselt_to_FP_uses2   : bitcasted_inselt_to_FP_uses2_before  ⊑  bitcasted_inselt_to_FP_uses2_combined := by
  unfold bitcasted_inselt_to_FP_uses2_before bitcasted_inselt_to_FP_uses2_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_from_FP_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_from_FP(%arg0: f64) -> i32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.lshr %1, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_bitcasted_inselt_from_FP   : bitcasted_inselt_from_FP_before  ⊑  bitcasted_inselt_from_FP_combined := by
  unfold bitcasted_inselt_from_FP_before bitcasted_inselt_from_FP_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_from_FP_uses_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_from_FP_uses(%arg0: f64) -> i16 {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.poison : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.constant(1 : i64) : i64
    %9 = llvm.insertelement %arg0, %6[%7 : i64] : vector<2xf64>
    llvm.call @use_v2f64(%9) : (vector<2xf64>) -> ()
    %10 = llvm.bitcast %9 : vector<2xf64> to vector<8xi16>
    %11 = llvm.extractelement %10[%8 : i64] : vector<8xi16>
    llvm.return %11 : i16
  }]

theorem inst_combine_bitcasted_inselt_from_FP_uses   : bitcasted_inselt_from_FP_uses_before  ⊑  bitcasted_inselt_from_FP_uses_combined := by
  unfold bitcasted_inselt_from_FP_uses_before bitcasted_inselt_from_FP_uses_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_from_FP_uses2_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_from_FP_uses2(%arg0: f64) -> i16 {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.poison : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.constant(1 : i64) : i64
    %9 = llvm.insertelement %arg0, %6[%7 : i64] : vector<2xf64>
    %10 = llvm.bitcast %9 : vector<2xf64> to vector<8xi16>
    llvm.call @use_v8i16(%10) : (vector<8xi16>) -> ()
    %11 = llvm.extractelement %10[%8 : i64] : vector<8xi16>
    llvm.return %11 : i16
  }]

theorem inst_combine_bitcasted_inselt_from_FP_uses2   : bitcasted_inselt_from_FP_uses2_before  ⊑  bitcasted_inselt_from_FP_uses2_combined := by
  unfold bitcasted_inselt_from_FP_uses2_before bitcasted_inselt_from_FP_uses2_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_to_and_from_FP_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_to_and_from_FP(%arg0: f64) -> f32 {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf64>
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<4xf32>
    %5 = llvm.extractelement %4[%2 : i64] : vector<4xf32>
    llvm.return %5 : f32
  }]

theorem inst_combine_bitcasted_inselt_to_and_from_FP   : bitcasted_inselt_to_and_from_FP_before  ⊑  bitcasted_inselt_to_and_from_FP_combined := by
  unfold bitcasted_inselt_to_and_from_FP_before bitcasted_inselt_to_and_from_FP_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_to_and_from_FP_uses_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_to_and_from_FP_uses(%arg0: f64) -> f32 {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.poison : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.constant(1 : i64) : i64
    %9 = llvm.insertelement %arg0, %6[%7 : i64] : vector<2xf64>
    llvm.call @use_v2f64(%9) : (vector<2xf64>) -> ()
    %10 = llvm.bitcast %9 : vector<2xf64> to vector<4xf32>
    %11 = llvm.extractelement %10[%8 : i64] : vector<4xf32>
    llvm.return %11 : f32
  }]

theorem inst_combine_bitcasted_inselt_to_and_from_FP_uses   : bitcasted_inselt_to_and_from_FP_uses_before  ⊑  bitcasted_inselt_to_and_from_FP_uses_combined := by
  unfold bitcasted_inselt_to_and_from_FP_uses_before bitcasted_inselt_to_and_from_FP_uses_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_to_and_from_FP_uses2_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_to_and_from_FP_uses2(%arg0: f64) -> f32 {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.poison : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.constant(1 : i64) : i64
    %9 = llvm.insertelement %arg0, %6[%7 : i64] : vector<2xf64>
    %10 = llvm.bitcast %9 : vector<2xf64> to vector<4xf32>
    llvm.call @use_v4f32(%10) : (vector<4xf32>) -> ()
    %11 = llvm.extractelement %10[%8 : i64] : vector<4xf32>
    llvm.return %11 : f32
  }]

theorem inst_combine_bitcasted_inselt_to_and_from_FP_uses2   : bitcasted_inselt_to_and_from_FP_uses2_before  ⊑  bitcasted_inselt_to_and_from_FP_uses2_combined := by
  unfold bitcasted_inselt_to_and_from_FP_uses2_before bitcasted_inselt_to_and_from_FP_uses2_combined
  simp_alive_peephole
  sorry
def invalid_extractelement_combined := [llvmfunc|
  llvm.func @invalid_extractelement(%arg0: vector<2xf64>, %arg1: vector<4xf64>, %arg2: !llvm.ptr) -> vector<4xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.shufflevector %arg0, %0 [0, -1, -1, -1] : vector<2xf64> 
    %3 = llvm.shufflevector %arg1, %2 [0, 1, 4, 3] : vector<4xf64> 
    %4 = llvm.extractelement %arg1[%1 : i64] : vector<4xf64>
    llvm.store %4, %arg2 {alignment = 8 : i64} : f64, !llvm.ptr]

theorem inst_combine_invalid_extractelement   : invalid_extractelement_before  ⊑  invalid_extractelement_combined := by
  unfold invalid_extractelement_before invalid_extractelement_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<4xf64>
  }]

theorem inst_combine_invalid_extractelement   : invalid_extractelement_before  ⊑  invalid_extractelement_combined := by
  unfold invalid_extractelement_before invalid_extractelement_combined
  simp_alive_peephole
  sorry
def bitcast_scalar_supported_type_index0_combined := [llvmfunc|
  llvm.func @bitcast_scalar_supported_type_index0(%arg0: i32) -> i8 {
    %0 = llvm.trunc %arg0 : i32 to i8
    llvm.return %0 : i8
  }]

theorem inst_combine_bitcast_scalar_supported_type_index0   : bitcast_scalar_supported_type_index0_before  ⊑  bitcast_scalar_supported_type_index0_combined := by
  unfold bitcast_scalar_supported_type_index0_before bitcast_scalar_supported_type_index0_combined
  simp_alive_peephole
  sorry
def bitcast_scalar_supported_type_index2_combined := [llvmfunc|
  llvm.func @bitcast_scalar_supported_type_index2(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_bitcast_scalar_supported_type_index2   : bitcast_scalar_supported_type_index2_before  ⊑  bitcast_scalar_supported_type_index2_combined := by
  unfold bitcast_scalar_supported_type_index2_before bitcast_scalar_supported_type_index2_combined
  simp_alive_peephole
  sorry
def bitcast_scalar_legal_type_index3_combined := [llvmfunc|
  llvm.func @bitcast_scalar_legal_type_index3(%arg0: i64) -> i4 {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i4
    llvm.return %2 : i4
  }]

theorem inst_combine_bitcast_scalar_legal_type_index3   : bitcast_scalar_legal_type_index3_before  ⊑  bitcast_scalar_legal_type_index3_combined := by
  unfold bitcast_scalar_legal_type_index3_before bitcast_scalar_legal_type_index3_combined
  simp_alive_peephole
  sorry
def bitcast_scalar_illegal_type_index1_combined := [llvmfunc|
  llvm.func @bitcast_scalar_illegal_type_index1(%arg0: i128) -> i8 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.bitcast %arg0 : i128 to vector<16xi8>
    %2 = llvm.extractelement %1[%0 : i64] : vector<16xi8>
    llvm.return %2 : i8
  }]

theorem inst_combine_bitcast_scalar_illegal_type_index1   : bitcast_scalar_illegal_type_index1_before  ⊑  bitcast_scalar_illegal_type_index1_combined := by
  unfold bitcast_scalar_illegal_type_index1_before bitcast_scalar_illegal_type_index1_combined
  simp_alive_peephole
  sorry
def bitcast_fp_index0_combined := [llvmfunc|
  llvm.func @bitcast_fp_index0(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : f32 to vector<4xi8>
    %2 = llvm.extractelement %1[%0 : i64] : vector<4xi8>
    llvm.return %2 : i8
  }]

theorem inst_combine_bitcast_fp_index0   : bitcast_fp_index0_before  ⊑  bitcast_fp_index0_combined := by
  unfold bitcast_fp_index0_before bitcast_fp_index0_combined
  simp_alive_peephole
  sorry
def bitcast_fp16vec_index0_combined := [llvmfunc|
  llvm.func @bitcast_fp16vec_index0(%arg0: i32) -> f16 {
    %0 = llvm.trunc %arg0 : i32 to i16
    %1 = llvm.bitcast %0 : i16 to f16
    llvm.return %1 : f16
  }]

theorem inst_combine_bitcast_fp16vec_index0   : bitcast_fp16vec_index0_before  ⊑  bitcast_fp16vec_index0_combined := by
  unfold bitcast_fp16vec_index0_before bitcast_fp16vec_index0_combined
  simp_alive_peephole
  sorry
def bitcast_fp16vec_index1_combined := [llvmfunc|
  llvm.func @bitcast_fp16vec_index1(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i16
    %3 = llvm.bitcast %2 : i16 to f16
    llvm.return %3 : f16
  }]

theorem inst_combine_bitcast_fp16vec_index1   : bitcast_fp16vec_index1_before  ⊑  bitcast_fp16vec_index1_combined := by
  unfold bitcast_fp16vec_index1_before bitcast_fp16vec_index1_combined
  simp_alive_peephole
  sorry
def bitcast_bfp16vec_index0_combined := [llvmfunc|
  llvm.func @bitcast_bfp16vec_index0(%arg0: i32) -> bf16 {
    %0 = llvm.trunc %arg0 : i32 to i16
    %1 = llvm.bitcast %0 : i16 to bf16
    llvm.return %1 : bf16
  }]

theorem inst_combine_bitcast_bfp16vec_index0   : bitcast_bfp16vec_index0_before  ⊑  bitcast_bfp16vec_index0_combined := by
  unfold bitcast_bfp16vec_index0_before bitcast_bfp16vec_index0_combined
  simp_alive_peephole
  sorry
def bitcast_bfp16vec_index1_combined := [llvmfunc|
  llvm.func @bitcast_bfp16vec_index1(%arg0: i32) -> bf16 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i16
    %3 = llvm.bitcast %2 : i16 to bf16
    llvm.return %3 : bf16
  }]

theorem inst_combine_bitcast_bfp16vec_index1   : bitcast_bfp16vec_index1_before  ⊑  bitcast_bfp16vec_index1_combined := by
  unfold bitcast_bfp16vec_index1_before bitcast_bfp16vec_index1_combined
  simp_alive_peephole
  sorry
def bitcast_fp32vec_index0_combined := [llvmfunc|
  llvm.func @bitcast_fp32vec_index0(%arg0: i64) -> f32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.bitcast %0 : i32 to f32
    llvm.return %1 : f32
  }]

theorem inst_combine_bitcast_fp32vec_index0   : bitcast_fp32vec_index0_before  ⊑  bitcast_fp32vec_index0_combined := by
  unfold bitcast_fp32vec_index0_before bitcast_fp32vec_index0_combined
  simp_alive_peephole
  sorry
def bitcast_fp32vec_index1_combined := [llvmfunc|
  llvm.func @bitcast_fp32vec_index1(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.bitcast %2 : i32 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_bitcast_fp32vec_index1   : bitcast_fp32vec_index1_before  ⊑  bitcast_fp32vec_index1_combined := by
  unfold bitcast_fp32vec_index1_before bitcast_fp32vec_index1_combined
  simp_alive_peephole
  sorry
def bitcast_fp64vec64_index0_combined := [llvmfunc|
  llvm.func @bitcast_fp64vec64_index0(%arg0: i64) -> f64 {
    %0 = llvm.bitcast %arg0 : i64 to f64
    llvm.return %0 : f64
  }]

theorem inst_combine_bitcast_fp64vec64_index0   : bitcast_fp64vec64_index0_before  ⊑  bitcast_fp64vec64_index0_combined := by
  unfold bitcast_fp64vec64_index0_before bitcast_fp64vec64_index0_combined
  simp_alive_peephole
  sorry
def bitcast_fp64vec_index0_combined := [llvmfunc|
  llvm.func @bitcast_fp64vec_index0(%arg0: i128) -> f64 {
    %0 = llvm.trunc %arg0 : i128 to i64
    %1 = llvm.bitcast %0 : i64 to f64
    llvm.return %1 : f64
  }]

theorem inst_combine_bitcast_fp64vec_index0   : bitcast_fp64vec_index0_before  ⊑  bitcast_fp64vec_index0_combined := by
  unfold bitcast_fp64vec_index0_before bitcast_fp64vec_index0_combined
  simp_alive_peephole
  sorry
def bitcast_fp64vec_index1_combined := [llvmfunc|
  llvm.func @bitcast_fp64vec_index1(%arg0: i128) -> f64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.bitcast %arg0 : i128 to vector<2xf64>
    %2 = llvm.extractelement %1[%0 : i64] : vector<2xf64>
    llvm.return %2 : f64
  }]

theorem inst_combine_bitcast_fp64vec_index1   : bitcast_fp64vec_index1_before  ⊑  bitcast_fp64vec_index1_combined := by
  unfold bitcast_fp64vec_index1_before bitcast_fp64vec_index1_combined
  simp_alive_peephole
  sorry
def bitcast_x86fp80vec_index0_combined := [llvmfunc|
  llvm.func @bitcast_x86fp80vec_index0(%arg0: i160) -> f80 {
    %0 = llvm.trunc %arg0 : i160 to i80
    %1 = llvm.bitcast %0 : i80 to f80
    llvm.return %1 : f80
  }]

theorem inst_combine_bitcast_x86fp80vec_index0   : bitcast_x86fp80vec_index0_before  ⊑  bitcast_x86fp80vec_index0_combined := by
  unfold bitcast_x86fp80vec_index0_before bitcast_x86fp80vec_index0_combined
  simp_alive_peephole
  sorry
def bitcast_x86fp80vec_index1_combined := [llvmfunc|
  llvm.func @bitcast_x86fp80vec_index1(%arg0: i160) -> f80 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.bitcast %arg0 : i160 to vector<2xf80>
    %2 = llvm.extractelement %1[%0 : i64] : vector<2xf80>
    llvm.return %2 : f80
  }]

theorem inst_combine_bitcast_x86fp80vec_index1   : bitcast_x86fp80vec_index1_before  ⊑  bitcast_x86fp80vec_index1_combined := by
  unfold bitcast_x86fp80vec_index1_before bitcast_x86fp80vec_index1_combined
  simp_alive_peephole
  sorry
def bitcast_fp128vec_index0_combined := [llvmfunc|
  llvm.func @bitcast_fp128vec_index0(%arg0: i256) -> f128 {
    %0 = llvm.trunc %arg0 : i256 to i128
    %1 = llvm.bitcast %0 : i128 to f128
    llvm.return %1 : f128
  }]

theorem inst_combine_bitcast_fp128vec_index0   : bitcast_fp128vec_index0_before  ⊑  bitcast_fp128vec_index0_combined := by
  unfold bitcast_fp128vec_index0_before bitcast_fp128vec_index0_combined
  simp_alive_peephole
  sorry
def bitcast_fp128vec_index1_combined := [llvmfunc|
  llvm.func @bitcast_fp128vec_index1(%arg0: i256) -> f128 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.bitcast %arg0 : i256 to vector<2xf128>
    %2 = llvm.extractelement %1[%0 : i64] : vector<2xf128>
    llvm.return %2 : f128
  }]

theorem inst_combine_bitcast_fp128vec_index1   : bitcast_fp128vec_index1_before  ⊑  bitcast_fp128vec_index1_combined := by
  unfold bitcast_fp128vec_index1_before bitcast_fp128vec_index1_combined
  simp_alive_peephole
  sorry
def bitcast_ppcfp128vec_index0_combined := [llvmfunc|
  llvm.func @bitcast_ppcfp128vec_index0(%arg0: i256) -> !llvm.ppc_fp128 {
    %0 = llvm.trunc %arg0 : i256 to i128
    %1 = llvm.bitcast %0 : i128 to !llvm.ppc_fp128
    llvm.return %1 : !llvm.ppc_fp128
  }]

theorem inst_combine_bitcast_ppcfp128vec_index0   : bitcast_ppcfp128vec_index0_before  ⊑  bitcast_ppcfp128vec_index0_combined := by
  unfold bitcast_ppcfp128vec_index0_before bitcast_ppcfp128vec_index0_combined
  simp_alive_peephole
  sorry
def bitcast_ppcfp128vec_index1_combined := [llvmfunc|
  llvm.func @bitcast_ppcfp128vec_index1(%arg0: i256) -> !llvm.ppc_fp128 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.bitcast %arg0 : i256 to !llvm.vec<2 x ppc_fp128>
    %2 = llvm.extractelement %1[%0 : i64] : !llvm.vec<2 x ppc_fp128>
    llvm.return %2 : !llvm.ppc_fp128
  }]

theorem inst_combine_bitcast_ppcfp128vec_index1   : bitcast_ppcfp128vec_index1_before  ⊑  bitcast_ppcfp128vec_index1_combined := by
  unfold bitcast_ppcfp128vec_index1_before bitcast_ppcfp128vec_index1_combined
  simp_alive_peephole
  sorry
def bitcast_scalar_index_variable_combined := [llvmfunc|
  llvm.func @bitcast_scalar_index_variable(%arg0: i32, %arg1: i64) -> i8 {
    %0 = llvm.bitcast %arg0 : i32 to vector<4xi8>
    %1 = llvm.extractelement %0[%arg1 : i64] : vector<4xi8>
    llvm.return %1 : i8
  }]

theorem inst_combine_bitcast_scalar_index_variable   : bitcast_scalar_index_variable_before  ⊑  bitcast_scalar_index_variable_combined := by
  unfold bitcast_scalar_index_variable_before bitcast_scalar_index_variable_combined
  simp_alive_peephole
  sorry
def bitcast_scalar_index0_use_combined := [llvmfunc|
  llvm.func @bitcast_scalar_index0_use(%arg0: i64) -> i8 {
    %0 = llvm.bitcast %arg0 : i64 to vector<8xi8>
    llvm.call @use(%0) : (vector<8xi8>) -> ()
    %1 = llvm.trunc %arg0 : i64 to i8
    llvm.return %1 : i8
  }]

theorem inst_combine_bitcast_scalar_index0_use   : bitcast_scalar_index0_use_before  ⊑  bitcast_scalar_index0_use_combined := by
  unfold bitcast_scalar_index0_use_before bitcast_scalar_index0_use_combined
  simp_alive_peephole
  sorry
def bit_extract_cmp_combined := [llvmfunc|
  llvm.func @bit_extract_cmp(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(9223372032559808512 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_bit_extract_cmp   : bit_extract_cmp_before  ⊑  bit_extract_cmp_combined := by
  unfold bit_extract_cmp_before bit_extract_cmp_combined
  simp_alive_peephole
  sorry
def extelt_select_const_operand_vector_combined := [llvmfunc|
  llvm.func @extelt_select_const_operand_vector(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_extelt_select_const_operand_vector   : extelt_select_const_operand_vector_before  ⊑  extelt_select_const_operand_vector_combined := by
  unfold extelt_select_const_operand_vector_before extelt_select_const_operand_vector_combined
  simp_alive_peephole
  sorry
def extelt_select_const_operand_vector_float_combined := [llvmfunc|
  llvm.func @extelt_select_const_operand_vector_float(%arg0: i1) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_extelt_select_const_operand_vector_float   : extelt_select_const_operand_vector_float_before  ⊑  extelt_select_const_operand_vector_float_combined := by
  unfold extelt_select_const_operand_vector_float_before extelt_select_const_operand_vector_float_combined
  simp_alive_peephole
  sorry
def extelt_vecselect_const_operand_vector_combined := [llvmfunc|
  llvm.func @extelt_vecselect_const_operand_vector(%arg0: vector<3xi1>) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(7 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %1, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.mlir.constant(2 : i64) : i64
    %18 = llvm.select %arg0, %8, %16 : vector<3xi1>, vector<3xi32>
    %19 = llvm.extractelement %18[%17 : i64] : vector<3xi32>
    llvm.return %19 : i32
  }]

theorem inst_combine_extelt_vecselect_const_operand_vector   : extelt_vecselect_const_operand_vector_before  ⊑  extelt_vecselect_const_operand_vector_combined := by
  unfold extelt_vecselect_const_operand_vector_before extelt_vecselect_const_operand_vector_combined
  simp_alive_peephole
  sorry
def extelt_select_const_operand_extractelt_use_combined := [llvmfunc|
  llvm.func @extelt_select_const_operand_extractelt_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.select %arg0, %0, %1 : i1, i32
    %5 = llvm.shl %4, %2 overflow<nsw, nuw>  : i32
    %6 = llvm.shl %4, %3 overflow<nsw, nuw>  : i32
    %7 = llvm.mul %5, %6 overflow<nsw, nuw>  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_extelt_select_const_operand_extractelt_use   : extelt_select_const_operand_extractelt_use_before  ⊑  extelt_select_const_operand_extractelt_use_combined := by
  unfold extelt_select_const_operand_extractelt_use_before extelt_select_const_operand_extractelt_use_combined
  simp_alive_peephole
  sorry
def extelt_select_const_operand_select_use_combined := [llvmfunc|
  llvm.func @extelt_select_const_operand_select_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.mlir.constant(7 : i32) : i32
    %11 = llvm.mlir.constant(6 : i32) : i32
    %12 = llvm.mlir.undef : vector<3xi32>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = llvm.insertelement %2, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(1 : i32) : i32
    %16 = llvm.insertelement %11, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.mlir.constant(2 : i32) : i32
    %18 = llvm.insertelement %10, %16[%17 : i32] : vector<3xi32>
    %19 = llvm.mlir.constant(2 : i64) : i64
    %20 = llvm.mlir.constant(1 : i64) : i64
    %21 = llvm.select %arg0, %9, %18 : i1, vector<3xi32>
    %22 = llvm.extractelement %21[%19 : i64] : vector<3xi32>
    %23 = llvm.extractelement %21[%20 : i64] : vector<3xi32>
    %24 = llvm.mul %22, %23 overflow<nsw, nuw>  : i32
    llvm.return %24 : i32
  }]

theorem inst_combine_extelt_select_const_operand_select_use   : extelt_select_const_operand_select_use_before  ⊑  extelt_select_const_operand_select_use_combined := by
  unfold extelt_select_const_operand_select_use_before extelt_select_const_operand_select_use_combined
  simp_alive_peephole
  sorry
def extelt_select_const_operand_vector_cond_index_combined := [llvmfunc|
  llvm.func @extelt_select_const_operand_vector_cond_index(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi32>) : vector<3xi32>
    %3 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %4 = llvm.select %arg0, %0, %1 : i1, i32
    %5 = llvm.select %arg0, %2, %3 : i1, vector<3xi32>
    %6 = llvm.extractelement %5[%4 : i32] : vector<3xi32>
    llvm.return %6 : i32
  }]

theorem inst_combine_extelt_select_const_operand_vector_cond_index   : extelt_select_const_operand_vector_cond_index_before  ⊑  extelt_select_const_operand_vector_cond_index_combined := by
  unfold extelt_select_const_operand_vector_cond_index_before extelt_select_const_operand_vector_cond_index_combined
  simp_alive_peephole
  sorry
def extelt_select_const_operand_vector_var_index_combined := [llvmfunc|
  llvm.func @extelt_select_const_operand_vector_var_index(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<3xi32>
    %3 = llvm.extractelement %2[%arg1 : i32] : vector<3xi32>
    llvm.return %3 : i32
  }]

theorem inst_combine_extelt_select_const_operand_vector_var_index   : extelt_select_const_operand_vector_var_index_before  ⊑  extelt_select_const_operand_vector_var_index_combined := by
  unfold extelt_select_const_operand_vector_var_index_before extelt_select_const_operand_vector_var_index_combined
  simp_alive_peephole
  sorry
def extelt_select_var_const_operand_vector_combined := [llvmfunc|
  llvm.func @extelt_select_var_const_operand_vector(%arg0: i1, %arg1: vector<3xi32>) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.extractelement %arg1[%0 : i64] : vector<3xi32>
    %3 = llvm.select %arg0, %2, %1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_extelt_select_var_const_operand_vector   : extelt_select_var_const_operand_vector_before  ⊑  extelt_select_var_const_operand_vector_combined := by
  unfold extelt_select_var_const_operand_vector_before extelt_select_var_const_operand_vector_combined
  simp_alive_peephole
  sorry
def extelt_select_const_var_operand_vector_combined := [llvmfunc|
  llvm.func @extelt_select_const_var_operand_vector(%arg0: i1, %arg1: vector<3xi32>) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.extractelement %arg1[%0 : i64] : vector<3xi32>
    %3 = llvm.select %arg0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_extelt_select_const_var_operand_vector   : extelt_select_const_var_operand_vector_before  ⊑  extelt_select_const_var_operand_vector_combined := by
  unfold extelt_select_const_var_operand_vector_before extelt_select_const_var_operand_vector_combined
  simp_alive_peephole
  sorry
def extelt_select_const_var_operands_vector_extra_use_combined := [llvmfunc|
  llvm.func @extelt_select_const_var_operands_vector_extra_use(%arg0: i1, %arg1: vector<3xi32>) -> i32 {
    %0 = llvm.mlir.constant(dense<[42, 5, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.select %arg0, %0, %arg1 : i1, vector<3xi32>
    llvm.call @use_select(%2) : (vector<3xi32>) -> ()
    %3 = llvm.extractelement %2[%1 : i64] : vector<3xi32>
    llvm.return %3 : i32
  }]

theorem inst_combine_extelt_select_const_var_operands_vector_extra_use   : extelt_select_const_var_operands_vector_extra_use_before  ⊑  extelt_select_const_var_operands_vector_extra_use_combined := by
  unfold extelt_select_const_var_operands_vector_extra_use_before extelt_select_const_var_operands_vector_extra_use_combined
  simp_alive_peephole
  sorry
def extelt_select_const_operands_vector_extra_use_2_combined := [llvmfunc|
  llvm.func @extelt_select_const_operands_vector_extra_use_2(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(dense<[42, 5, 4]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.select %arg0, %0, %1 : i1, vector<3xi32>
    llvm.call @use_select(%3) : (vector<3xi32>) -> ()
    %4 = llvm.extractelement %3[%2 : i64] : vector<3xi32>
    llvm.return %4 : i32
  }]

theorem inst_combine_extelt_select_const_operands_vector_extra_use_2   : extelt_select_const_operands_vector_extra_use_2_before  ⊑  extelt_select_const_operands_vector_extra_use_2_combined := by
  unfold extelt_select_const_operands_vector_extra_use_2_before extelt_select_const_operands_vector_extra_use_2_combined
  simp_alive_peephole
  sorry
def crash_4b8320_combined := [llvmfunc|
  llvm.func @crash_4b8320(%arg0: vector<2xf32>, %arg1: f32) -> f32 {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.fmul %arg0, %6  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf32>]

theorem inst_combine_crash_4b8320   : crash_4b8320_before  ⊑  crash_4b8320_combined := by
  unfold crash_4b8320_before crash_4b8320_combined
  simp_alive_peephole
  sorry
    %9 = llvm.extractelement %8[%7 : i64] : vector<2xf32>
    %10 = llvm.extractelement %8[%7 : i64] : vector<2xf32>
    %11 = llvm.fadd %9, %10  : f32
    %12 = llvm.fadd %11, %1  : f32
    llvm.return %12 : f32
  }]

theorem inst_combine_crash_4b8320   : crash_4b8320_before  ⊑  crash_4b8320_combined := by
  unfold crash_4b8320_before crash_4b8320_combined
  simp_alive_peephole
  sorry
