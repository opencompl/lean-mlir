import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vscale_extractelement-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def extractelement_in_range_before := [llvmfunc|
  llvm.func @extractelement_in_range(%arg0: !llvm.vec<? x 4 x  i32>) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : !llvm.vec<? x 4 x  i32>
    llvm.return %1 : i32
  }]

def extractelement_maybe_out_of_range_before := [llvmfunc|
  llvm.func @extractelement_maybe_out_of_range(%arg0: !llvm.vec<? x 4 x  i32>) -> i32 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : !llvm.vec<? x 4 x  i32>
    llvm.return %1 : i32
  }]

def extractelement_bitcast_before := [llvmfunc|
  llvm.func @extractelement_bitcast(%arg0: f32) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  f32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<? x 4 x  f32>
    %3 = llvm.bitcast %2 : !llvm.vec<? x 4 x  f32> to !llvm.vec<? x 4 x  i32>
    %4 = llvm.extractelement %3[%1 : i32] : !llvm.vec<? x 4 x  i32>
    llvm.return %4 : i32
  }]

def extractelement_bitcast_to_trunc_before := [llvmfunc|
  llvm.func @extractelement_bitcast_to_trunc(%arg0: !llvm.vec<? x 2 x  i32>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : !llvm.vec<? x 2 x  i32>
    %3 = llvm.bitcast %2 : !llvm.vec<? x 2 x  i32> to !llvm.vec<? x 8 x  i8>
    %4 = llvm.extractelement %3[%1 : i32] : !llvm.vec<? x 8 x  i8>
    llvm.return %4 : i8
  }]

def extractelement_bitcast_useless_insert_before := [llvmfunc|
  llvm.func @extractelement_bitcast_useless_insert(%arg0: !llvm.vec<? x 2 x  i32>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : !llvm.vec<? x 2 x  i32>
    %3 = llvm.bitcast %2 : !llvm.vec<? x 2 x  i32> to !llvm.vec<? x 8 x  i8>
    %4 = llvm.extractelement %3[%1 : i32] : !llvm.vec<? x 8 x  i8>
    llvm.return %4 : i8
  }]

def extractelement_bitcast_insert_extra_use_insert_before := [llvmfunc|
  llvm.func @extractelement_bitcast_insert_extra_use_insert(%arg0: !llvm.vec<? x 2 x  i32>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : !llvm.vec<? x 2 x  i32>
    llvm.call @use_vscale_2_i32(%2) : (!llvm.vec<? x 2 x  i32>) -> ()
    %3 = llvm.bitcast %2 : !llvm.vec<? x 2 x  i32> to !llvm.vec<? x 8 x  i8>
    %4 = llvm.extractelement %3[%1 : i32] : !llvm.vec<? x 8 x  i8>
    llvm.return %4 : i8
  }]

def extractelement_bitcast_insert_extra_use_bitcast_before := [llvmfunc|
  llvm.func @extractelement_bitcast_insert_extra_use_bitcast(%arg0: !llvm.vec<? x 2 x  i32>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : !llvm.vec<? x 2 x  i32>
    %3 = llvm.bitcast %2 : !llvm.vec<? x 2 x  i32> to !llvm.vec<? x 8 x  i8>
    llvm.call @use_vscale_8_i8(%3) : (!llvm.vec<? x 8 x  i8>) -> ()
    %4 = llvm.extractelement %3[%1 : i32] : !llvm.vec<? x 8 x  i8>
    llvm.return %4 : i8
  }]

def extractelement_shuffle_maybe_out_of_range_before := [llvmfunc|
  llvm.func @extractelement_shuffle_maybe_out_of_range(%arg0: i32) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    %5 = llvm.extractelement %4[%2 : i32] : vector<[4]xi32>
    llvm.return %5 : i32
  }]

def extractelement_shuffle_invalid_index_before := [llvmfunc|
  llvm.func @extractelement_shuffle_invalid_index(%arg0: i32) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    %5 = llvm.extractelement %4[%2 : i32] : vector<[4]xi32>
    llvm.return %5 : i32
  }]

def extractelement_insertelement_same_positions_before := [llvmfunc|
  llvm.func @extractelement_insertelement_same_positions(%arg0: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.extractelement %arg0[%0 : i32] : !llvm.vec<? x 4 x  i32>
    %5 = llvm.extractelement %arg0[%1 : i32] : !llvm.vec<? x 4 x  i32>
    %6 = llvm.extractelement %arg0[%2 : i32] : !llvm.vec<? x 4 x  i32>
    %7 = llvm.extractelement %arg0[%3 : i32] : !llvm.vec<? x 4 x  i32>
    %8 = llvm.insertelement %4, %arg0[%0 : i32] : !llvm.vec<? x 4 x  i32>
    %9 = llvm.insertelement %5, %8[%1 : i32] : !llvm.vec<? x 4 x  i32>
    %10 = llvm.insertelement %6, %9[%2 : i32] : !llvm.vec<? x 4 x  i32>
    %11 = llvm.insertelement %7, %10[%3 : i32] : !llvm.vec<? x 4 x  i32>
    llvm.return %11 : !llvm.vec<? x 4 x  i32>
  }]

def extractelement_insertelement_diff_positions_before := [llvmfunc|
  llvm.func @extractelement_insertelement_diff_positions(%arg0: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.mlir.constant(3 : i32) : i32
    %8 = llvm.extractelement %arg0[%0 : i32] : !llvm.vec<? x 4 x  i32>
    %9 = llvm.extractelement %arg0[%1 : i32] : !llvm.vec<? x 4 x  i32>
    %10 = llvm.extractelement %arg0[%2 : i32] : !llvm.vec<? x 4 x  i32>
    %11 = llvm.extractelement %arg0[%3 : i32] : !llvm.vec<? x 4 x  i32>
    %12 = llvm.insertelement %8, %arg0[%4 : i32] : !llvm.vec<? x 4 x  i32>
    %13 = llvm.insertelement %9, %12[%5 : i32] : !llvm.vec<? x 4 x  i32>
    %14 = llvm.insertelement %10, %13[%6 : i32] : !llvm.vec<? x 4 x  i32>
    %15 = llvm.insertelement %11, %14[%7 : i32] : !llvm.vec<? x 4 x  i32>
    llvm.return %15 : !llvm.vec<? x 4 x  i32>
  }]

def bitcast_of_extractelement_before := [llvmfunc|
  llvm.func @bitcast_of_extractelement(%arg0: !llvm.vec<? x 2 x  f32>) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.extractelement %arg0[%0 : i32] : !llvm.vec<? x 2 x  f32>
    %2 = llvm.bitcast %1 : f32 to i32
    llvm.return %2 : i32
  }]

def extractelement_is_zero_before := [llvmfunc|
  llvm.func @extractelement_is_zero(%arg0: !llvm.vec<? x 2 x  i32>, %arg1: i1, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.extractelement %arg0[%0 : i32] : !llvm.vec<? x 2 x  i32>
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def ossfuzz_25272_before := [llvmfunc|
  llvm.func @ossfuzz_25272(%arg0: f32) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  f32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2147483647 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<? x 4 x  f32>
    %4 = llvm.bitcast %3 : !llvm.vec<? x 4 x  f32> to !llvm.vec<? x 4 x  i32>
    %5 = llvm.extractelement %4[%2 : i32] : !llvm.vec<? x 4 x  i32>
    llvm.return %5 : i32
  }]

def extractelement_in_range_combined := [llvmfunc|
  llvm.func @extractelement_in_range(%arg0: !llvm.vec<? x 4 x  i32>) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : !llvm.vec<? x 4 x  i32>
    llvm.return %1 : i32
  }]

theorem inst_combine_extractelement_in_range   : extractelement_in_range_before  ⊑  extractelement_in_range_combined := by
  unfold extractelement_in_range_before extractelement_in_range_combined
  simp_alive_peephole
  sorry
def extractelement_maybe_out_of_range_combined := [llvmfunc|
  llvm.func @extractelement_maybe_out_of_range(%arg0: !llvm.vec<? x 4 x  i32>) -> i32 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : !llvm.vec<? x 4 x  i32>
    llvm.return %1 : i32
  }]

theorem inst_combine_extractelement_maybe_out_of_range   : extractelement_maybe_out_of_range_before  ⊑  extractelement_maybe_out_of_range_combined := by
  unfold extractelement_maybe_out_of_range_before extractelement_maybe_out_of_range_combined
  simp_alive_peephole
  sorry
def extractelement_bitcast_combined := [llvmfunc|
  llvm.func @extractelement_bitcast(%arg0: f32) -> i32 {
    %0 = llvm.bitcast %arg0 : f32 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_extractelement_bitcast   : extractelement_bitcast_before  ⊑  extractelement_bitcast_combined := by
  unfold extractelement_bitcast_before extractelement_bitcast_combined
  simp_alive_peephole
  sorry
def extractelement_bitcast_to_trunc_combined := [llvmfunc|
  llvm.func @extractelement_bitcast_to_trunc(%arg0: !llvm.vec<? x 2 x  i32>, %arg1: i32) -> i8 {
    %0 = llvm.trunc %arg1 : i32 to i8
    llvm.return %0 : i8
  }]

theorem inst_combine_extractelement_bitcast_to_trunc   : extractelement_bitcast_to_trunc_before  ⊑  extractelement_bitcast_to_trunc_combined := by
  unfold extractelement_bitcast_to_trunc_before extractelement_bitcast_to_trunc_combined
  simp_alive_peephole
  sorry
def extractelement_bitcast_useless_insert_combined := [llvmfunc|
  llvm.func @extractelement_bitcast_useless_insert(%arg0: !llvm.vec<? x 2 x  i32>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.bitcast %arg0 : !llvm.vec<? x 2 x  i32> to !llvm.vec<? x 8 x  i8>
    %2 = llvm.extractelement %1[%0 : i64] : !llvm.vec<? x 8 x  i8>
    llvm.return %2 : i8
  }]

theorem inst_combine_extractelement_bitcast_useless_insert   : extractelement_bitcast_useless_insert_before  ⊑  extractelement_bitcast_useless_insert_combined := by
  unfold extractelement_bitcast_useless_insert_before extractelement_bitcast_useless_insert_combined
  simp_alive_peephole
  sorry
def extractelement_bitcast_insert_extra_use_insert_combined := [llvmfunc|
  llvm.func @extractelement_bitcast_insert_extra_use_insert(%arg0: !llvm.vec<? x 2 x  i32>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.insertelement %arg1, %arg0[%0 : i64] : !llvm.vec<? x 2 x  i32>
    llvm.call @use_vscale_2_i32(%2) : (!llvm.vec<? x 2 x  i32>) -> ()
    %3 = llvm.bitcast %2 : !llvm.vec<? x 2 x  i32> to !llvm.vec<? x 8 x  i8>
    %4 = llvm.extractelement %3[%1 : i64] : !llvm.vec<? x 8 x  i8>
    llvm.return %4 : i8
  }]

theorem inst_combine_extractelement_bitcast_insert_extra_use_insert   : extractelement_bitcast_insert_extra_use_insert_before  ⊑  extractelement_bitcast_insert_extra_use_insert_combined := by
  unfold extractelement_bitcast_insert_extra_use_insert_before extractelement_bitcast_insert_extra_use_insert_combined
  simp_alive_peephole
  sorry
def extractelement_bitcast_insert_extra_use_bitcast_combined := [llvmfunc|
  llvm.func @extractelement_bitcast_insert_extra_use_bitcast(%arg0: !llvm.vec<? x 2 x  i32>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.insertelement %arg1, %arg0[%0 : i64] : !llvm.vec<? x 2 x  i32>
    %3 = llvm.bitcast %2 : !llvm.vec<? x 2 x  i32> to !llvm.vec<? x 8 x  i8>
    llvm.call @use_vscale_8_i8(%3) : (!llvm.vec<? x 8 x  i8>) -> ()
    %4 = llvm.extractelement %3[%1 : i64] : !llvm.vec<? x 8 x  i8>
    llvm.return %4 : i8
  }]

theorem inst_combine_extractelement_bitcast_insert_extra_use_bitcast   : extractelement_bitcast_insert_extra_use_bitcast_before  ⊑  extractelement_bitcast_insert_extra_use_bitcast_combined := by
  unfold extractelement_bitcast_insert_extra_use_bitcast_before extractelement_bitcast_insert_extra_use_bitcast_combined
  simp_alive_peephole
  sorry
def extractelement_shuffle_maybe_out_of_range_combined := [llvmfunc|
  llvm.func @extractelement_shuffle_maybe_out_of_range(%arg0: i32) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    %5 = llvm.extractelement %4[%2 : i64] : vector<[4]xi32>
    llvm.return %5 : i32
  }]

theorem inst_combine_extractelement_shuffle_maybe_out_of_range   : extractelement_shuffle_maybe_out_of_range_before  ⊑  extractelement_shuffle_maybe_out_of_range_combined := by
  unfold extractelement_shuffle_maybe_out_of_range_before extractelement_shuffle_maybe_out_of_range_combined
  simp_alive_peephole
  sorry
def extractelement_shuffle_invalid_index_combined := [llvmfunc|
  llvm.func @extractelement_shuffle_invalid_index(%arg0: i32) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(4294967295 : i64) : i64
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    %5 = llvm.extractelement %4[%2 : i64] : vector<[4]xi32>
    llvm.return %5 : i32
  }]

theorem inst_combine_extractelement_shuffle_invalid_index   : extractelement_shuffle_invalid_index_before  ⊑  extractelement_shuffle_invalid_index_combined := by
  unfold extractelement_shuffle_invalid_index_before extractelement_shuffle_invalid_index_combined
  simp_alive_peephole
  sorry
def extractelement_insertelement_same_positions_combined := [llvmfunc|
  llvm.func @extractelement_insertelement_same_positions(%arg0: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  i32> {
    llvm.return %arg0 : !llvm.vec<? x 4 x  i32>
  }]

theorem inst_combine_extractelement_insertelement_same_positions   : extractelement_insertelement_same_positions_before  ⊑  extractelement_insertelement_same_positions_combined := by
  unfold extractelement_insertelement_same_positions_before extractelement_insertelement_same_positions_combined
  simp_alive_peephole
  sorry
def extractelement_insertelement_diff_positions_combined := [llvmfunc|
  llvm.func @extractelement_insertelement_diff_positions(%arg0: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.mlir.constant(6 : i64) : i64
    %3 = llvm.mlir.constant(7 : i64) : i64
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(3 : i64) : i64
    %8 = llvm.extractelement %arg0[%0 : i64] : !llvm.vec<? x 4 x  i32>
    %9 = llvm.extractelement %arg0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %10 = llvm.extractelement %arg0[%2 : i64] : !llvm.vec<? x 4 x  i32>
    %11 = llvm.extractelement %arg0[%3 : i64] : !llvm.vec<? x 4 x  i32>
    %12 = llvm.insertelement %8, %arg0[%4 : i64] : !llvm.vec<? x 4 x  i32>
    %13 = llvm.insertelement %9, %12[%5 : i64] : !llvm.vec<? x 4 x  i32>
    %14 = llvm.insertelement %10, %13[%6 : i64] : !llvm.vec<? x 4 x  i32>
    %15 = llvm.insertelement %11, %14[%7 : i64] : !llvm.vec<? x 4 x  i32>
    llvm.return %15 : !llvm.vec<? x 4 x  i32>
  }]

theorem inst_combine_extractelement_insertelement_diff_positions   : extractelement_insertelement_diff_positions_before  ⊑  extractelement_insertelement_diff_positions_combined := by
  unfold extractelement_insertelement_diff_positions_before extractelement_insertelement_diff_positions_combined
  simp_alive_peephole
  sorry
def bitcast_of_extractelement_combined := [llvmfunc|
  llvm.func @bitcast_of_extractelement(%arg0: !llvm.vec<? x 2 x  f32>) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : !llvm.vec<? x 2 x  f32> to !llvm.vec<? x 2 x  i32>
    %2 = llvm.extractelement %1[%0 : i64] : !llvm.vec<? x 2 x  i32>
    llvm.return %2 : i32
  }]

theorem inst_combine_bitcast_of_extractelement   : bitcast_of_extractelement_before  ⊑  bitcast_of_extractelement_combined := by
  unfold bitcast_of_extractelement_before bitcast_of_extractelement_combined
  simp_alive_peephole
  sorry
def extractelement_is_zero_combined := [llvmfunc|
  llvm.func @extractelement_is_zero(%arg0: !llvm.vec<? x 2 x  i32>, %arg1: i1, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.extractelement %arg0[%0 : i64] : !llvm.vec<? x 2 x  i32>
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_extractelement_is_zero   : extractelement_is_zero_before  ⊑  extractelement_is_zero_combined := by
  unfold extractelement_is_zero_before extractelement_is_zero_combined
  simp_alive_peephole
  sorry
def ossfuzz_25272_combined := [llvmfunc|
  llvm.func @ossfuzz_25272(%arg0: f32) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  f32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(2147483647 : i64) : i64
    %3 = llvm.insertelement %arg0, %0[%1 : i64] : !llvm.vec<? x 4 x  f32>
    %4 = llvm.bitcast %3 : !llvm.vec<? x 4 x  f32> to !llvm.vec<? x 4 x  i32>
    %5 = llvm.extractelement %4[%2 : i64] : !llvm.vec<? x 4 x  i32>
    llvm.return %5 : i32
  }]

theorem inst_combine_ossfuzz_25272   : ossfuzz_25272_before  ⊑  ossfuzz_25272_combined := by
  unfold ossfuzz_25272_before ossfuzz_25272_combined
  simp_alive_peephole
  sorry
