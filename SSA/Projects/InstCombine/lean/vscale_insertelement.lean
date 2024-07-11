import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vscale_insertelement
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def insertelement_bitcast_before := [llvmfunc|
  llvm.func @insertelement_bitcast(%arg0: !llvm.vec<? x 4 x  i32>, %arg1: i32) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg1 : i32 to f32
    %2 = llvm.bitcast %arg0 : !llvm.vec<? x 4 x  i32> to !llvm.vec<? x 4 x  f32>
    %3 = llvm.insertelement %1, %2[%0 : i32] : !llvm.vec<? x 4 x  f32>
    llvm.return %3 : !llvm.vec<? x 4 x  f32>
  }]

def insertelement_extractelement_before := [llvmfunc|
  llvm.func @insertelement_extractelement(%arg0: !llvm.vec<? x 4 x  i32>, %arg1: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.extractelement %arg0[%0 : i32] : !llvm.vec<? x 4 x  i32>
    %3 = llvm.insertelement %2, %arg1[%1 : i32] : !llvm.vec<? x 4 x  i32>
    llvm.return %3 : !llvm.vec<? x 4 x  i32>
  }]

def insertelement_extractelement_fixed_vec_extract_from_scalable_before := [llvmfunc|
  llvm.func @insertelement_extractelement_fixed_vec_extract_from_scalable(%arg0: !llvm.vec<? x 4 x  i32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.extractelement %arg0[%0 : i32] : !llvm.vec<? x 4 x  i32>
    %3 = llvm.insertelement %2, %arg1[%1 : i32] : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def insertelement_insertelement_before := [llvmfunc|
  llvm.func @insertelement_insertelement(%arg0: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %0, %arg0[%0 : i32] : !llvm.vec<? x 4 x  i32>
    %3 = llvm.insertelement %1, %2[%1 : i32] : !llvm.vec<? x 4 x  i32>
    llvm.return %3 : !llvm.vec<? x 4 x  i32>
  }]

def insertelement_sequene_may_not_be_splat_before := [llvmfunc|
  llvm.func @insertelement_sequene_may_not_be_splat(%arg0: f32) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.mlir.undef : !llvm.vec<? x 4 x  f32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<? x 4 x  f32>
    %6 = llvm.insertelement %arg0, %5[%2 : i32] : !llvm.vec<? x 4 x  f32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : !llvm.vec<? x 4 x  f32>
    %8 = llvm.insertelement %arg0, %7[%4 : i32] : !llvm.vec<? x 4 x  f32>
    llvm.return %8 : !llvm.vec<? x 4 x  f32>
  }]

def ossfuzz_27416_before := [llvmfunc|
  llvm.func @ossfuzz_27416(%arg0: i32, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.undef : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.constant(-128 : i8) : i8
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<? x 4 x  i32>
    %5 = llvm.shufflevector %4, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    %6 = llvm.insertelement %2, %5[%3 : i8] : vector<[4]xi32>
    llvm.store %6, %arg1 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr]

    llvm.return
  }]

def insertelement_bitcast_combined := [llvmfunc|
  llvm.func @insertelement_bitcast(%arg0: !llvm.vec<? x 4 x  i32>, %arg1: i32) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.insertelement %arg1, %arg0[%0 : i64] : !llvm.vec<? x 4 x  i32>
    %2 = llvm.bitcast %1 : !llvm.vec<? x 4 x  i32> to !llvm.vec<? x 4 x  f32>
    llvm.return %2 : !llvm.vec<? x 4 x  f32>
  }]

theorem inst_combine_insertelement_bitcast   : insertelement_bitcast_before  ⊑  insertelement_bitcast_combined := by
  unfold insertelement_bitcast_before insertelement_bitcast_combined
  simp_alive_peephole
  sorry
def insertelement_extractelement_combined := [llvmfunc|
  llvm.func @insertelement_extractelement(%arg0: !llvm.vec<? x 4 x  i32>, %arg1: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.extractelement %arg0[%0 : i64] : !llvm.vec<? x 4 x  i32>
    %3 = llvm.insertelement %2, %arg1[%1 : i64] : !llvm.vec<? x 4 x  i32>
    llvm.return %3 : !llvm.vec<? x 4 x  i32>
  }]

theorem inst_combine_insertelement_extractelement   : insertelement_extractelement_before  ⊑  insertelement_extractelement_combined := by
  unfold insertelement_extractelement_before insertelement_extractelement_combined
  simp_alive_peephole
  sorry
def insertelement_extractelement_fixed_vec_extract_from_scalable_combined := [llvmfunc|
  llvm.func @insertelement_extractelement_fixed_vec_extract_from_scalable(%arg0: !llvm.vec<? x 4 x  i32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.extractelement %arg0[%0 : i64] : !llvm.vec<? x 4 x  i32>
    %3 = llvm.insertelement %2, %arg1[%1 : i64] : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_insertelement_extractelement_fixed_vec_extract_from_scalable   : insertelement_extractelement_fixed_vec_extract_from_scalable_before  ⊑  insertelement_extractelement_fixed_vec_extract_from_scalable_combined := by
  unfold insertelement_extractelement_fixed_vec_extract_from_scalable_before insertelement_extractelement_fixed_vec_extract_from_scalable_combined
  simp_alive_peephole
  sorry
def insertelement_insertelement_combined := [llvmfunc|
  llvm.func @insertelement_insertelement(%arg0: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  i32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.insertelement %0, %arg0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %5 = llvm.insertelement %2, %4[%3 : i64] : !llvm.vec<? x 4 x  i32>
    llvm.return %5 : !llvm.vec<? x 4 x  i32>
  }]

theorem inst_combine_insertelement_insertelement   : insertelement_insertelement_before  ⊑  insertelement_insertelement_combined := by
  unfold insertelement_insertelement_before insertelement_insertelement_combined
  simp_alive_peephole
  sorry
def insertelement_sequene_may_not_be_splat_combined := [llvmfunc|
  llvm.func @insertelement_sequene_may_not_be_splat(%arg0: f32) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.mlir.undef : !llvm.vec<? x 4 x  f32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.insertelement %arg0, %0[%1 : i64] : !llvm.vec<? x 4 x  f32>
    %6 = llvm.insertelement %arg0, %5[%2 : i64] : !llvm.vec<? x 4 x  f32>
    %7 = llvm.insertelement %arg0, %6[%3 : i64] : !llvm.vec<? x 4 x  f32>
    %8 = llvm.insertelement %arg0, %7[%4 : i64] : !llvm.vec<? x 4 x  f32>
    llvm.return %8 : !llvm.vec<? x 4 x  f32>
  }]

theorem inst_combine_insertelement_sequene_may_not_be_splat   : insertelement_sequene_may_not_be_splat_before  ⊑  insertelement_sequene_may_not_be_splat_combined := by
  unfold insertelement_sequene_may_not_be_splat_before insertelement_sequene_may_not_be_splat_combined
  simp_alive_peephole
  sorry
def ossfuzz_27416_combined := [llvmfunc|
  llvm.func @ossfuzz_27416(%arg0: i32, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.undef : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %3 = llvm.mlir.undef : i32
    %4 = llvm.mlir.constant(128 : i64) : i64
    %5 = llvm.insertelement %arg0, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %6 = llvm.shufflevector %5, %2 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    %7 = llvm.insertelement %3, %6[%4 : i64] : vector<[4]xi32>
    llvm.store %7, %arg1 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_ossfuzz_27416   : ossfuzz_27416_before  ⊑  ossfuzz_27416_combined := by
  unfold ossfuzz_27416_before ossfuzz_27416_combined
  simp_alive_peephole
  sorry
