import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  extractelement-inseltpoison
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
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %3 = llvm.bitcast %2 : vector<4xf32> to vector<4xi32>
    %4 = llvm.extractelement %3[%1 : i32] : vector<4xi32>
    llvm.return %4 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i64) -> i64 {
    %0 = llvm.mlir.poison : vector<8xi64>
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
    %0 = llvm.mlir.poison : vector<2xi64>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi64>
    %4 = llvm.bitcast %3 : vector<2xi64> to vector<8xi16>
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi16>
    llvm.return %5 : i16
  }]

def bitcasted_inselt_wide_source_not_modulo_elt_before := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_not_modulo_elt(%arg0: i64) -> i32 {
    %0 = llvm.mlir.poison : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi64>
    %4 = llvm.bitcast %3 : vector<2xi64> to vector<4xi32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xi32>
    llvm.return %5 : i32
  }]

def bitcasted_inselt_wide_source_not_modulo_elt_not_half_before := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_not_modulo_elt_not_half(%arg0: i32) -> i8 {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi32>
    %4 = llvm.bitcast %3 : vector<2xi32> to vector<8xi8>
    %5 = llvm.extractelement %4[%2 : i32] : vector<8xi8>
    llvm.return %5 : i8
  }]

def bitcasted_inselt_wide_source_not_modulo_elt_not_half_weird_types_before := [llvmfunc|
  llvm.func @bitcasted_inselt_wide_source_not_modulo_elt_not_half_weird_types(%arg0: i15) -> i3 {
    %0 = llvm.mlir.poison : vector<3xi15>
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
    %0 = llvm.mlir.poison : vector<2xi32>
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
    %0 = llvm.mlir.poison : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xi64>
    %4 = llvm.bitcast %3 : vector<2xi64> to vector<4xf32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : f32
  }]

def bitcasted_inselt_to_FP_uses_before := [llvmfunc|
  llvm.func @bitcasted_inselt_to_FP_uses(%arg0: i128) -> f32 {
    %0 = llvm.mlir.poison : vector<2xi128>
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
    %0 = llvm.mlir.poison : vector<2xi128>
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
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<4xi32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xi32>
    llvm.return %5 : i32
  }]

def bitcasted_inselt_from_FP_uses_before := [llvmfunc|
  llvm.func @bitcasted_inselt_from_FP_uses(%arg0: f64) -> i16 {
    %0 = llvm.mlir.poison : vector<2xf64>
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
    %0 = llvm.mlir.poison : vector<2xf64>
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
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<2xf64>
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<4xf32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : f32
  }]

def bitcasted_inselt_to_and_from_FP_uses_before := [llvmfunc|
  llvm.func @bitcasted_inselt_to_and_from_FP_uses(%arg0: f64) -> f32 {
    %0 = llvm.mlir.poison : vector<2xf64>
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
    %0 = llvm.mlir.poison : vector<2xf64>
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
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi32>
    %4 = llvm.bitcast %3 : vector<2xi32> to vector<8xi8>
    llvm.call @use(%4) : (vector<8xi8>) -> ()
    %5 = llvm.extractelement %4[%2 : i64] : vector<8xi8>
    llvm.return %5 : i8
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
    %0 = llvm.mlir.poison : vector<2xi128>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi128>
    llvm.call @use_v2i128(%3) : (vector<2xi128>) -> ()
    %4 = llvm.bitcast %3 : vector<2xi128> to vector<8xf32>
    %5 = llvm.extractelement %4[%2 : i64] : vector<8xf32>
    llvm.return %5 : f32
  }]

theorem inst_combine_bitcasted_inselt_to_FP_uses   : bitcasted_inselt_to_FP_uses_before  ⊑  bitcasted_inselt_to_FP_uses_combined := by
  unfold bitcasted_inselt_to_FP_uses_before bitcasted_inselt_to_FP_uses_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_to_FP_uses2_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_to_FP_uses2(%arg0: i128) -> f32 {
    %0 = llvm.mlir.poison : vector<2xi128>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi128>
    %4 = llvm.bitcast %3 : vector<2xi128> to vector<8xf32>
    llvm.call @use_v8f32(%4) : (vector<8xf32>) -> ()
    %5 = llvm.extractelement %4[%2 : i64] : vector<8xf32>
    llvm.return %5 : f32
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
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf64>
    llvm.call @use_v2f64(%3) : (vector<2xf64>) -> ()
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<8xi16>
    %5 = llvm.extractelement %4[%2 : i64] : vector<8xi16>
    llvm.return %5 : i16
  }]

theorem inst_combine_bitcasted_inselt_from_FP_uses   : bitcasted_inselt_from_FP_uses_before  ⊑  bitcasted_inselt_from_FP_uses_combined := by
  unfold bitcasted_inselt_from_FP_uses_before bitcasted_inselt_from_FP_uses_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_from_FP_uses2_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_from_FP_uses2(%arg0: f64) -> i16 {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf64>
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<8xi16>
    llvm.call @use_v8i16(%4) : (vector<8xi16>) -> ()
    %5 = llvm.extractelement %4[%2 : i64] : vector<8xi16>
    llvm.return %5 : i16
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
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf64>
    llvm.call @use_v2f64(%3) : (vector<2xf64>) -> ()
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<4xf32>
    %5 = llvm.extractelement %4[%2 : i64] : vector<4xf32>
    llvm.return %5 : f32
  }]

theorem inst_combine_bitcasted_inselt_to_and_from_FP_uses   : bitcasted_inselt_to_and_from_FP_uses_before  ⊑  bitcasted_inselt_to_and_from_FP_uses_combined := by
  unfold bitcasted_inselt_to_and_from_FP_uses_before bitcasted_inselt_to_and_from_FP_uses_combined
  simp_alive_peephole
  sorry
def bitcasted_inselt_to_and_from_FP_uses2_combined := [llvmfunc|
  llvm.func @bitcasted_inselt_to_and_from_FP_uses2(%arg0: f64) -> f32 {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xf64>
    %4 = llvm.bitcast %3 : vector<2xf64> to vector<4xf32>
    llvm.call @use_v4f32(%4) : (vector<4xf32>) -> ()
    %5 = llvm.extractelement %4[%2 : i64] : vector<4xf32>
    llvm.return %5 : f32
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
    llvm.store %4, %arg2 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.return %3 : vector<4xf64>
  }]

theorem inst_combine_invalid_extractelement   : invalid_extractelement_before  ⊑  invalid_extractelement_combined := by
  unfold invalid_extractelement_before invalid_extractelement_combined
  simp_alive_peephole
  sorry
