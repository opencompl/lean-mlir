import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shufflevec-bitcast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: vector<16xi8>, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.shufflevector %arg0, %0 [12, 13, 14, 15] : vector<16xi8> 
    %2 = llvm.bitcast %1 : vector<4xi8> to f32
    %3 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.store %3, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %2, %arg2 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.return
  }]

def splat_bitcast_operand_before := [llvmfunc|
  llvm.func @splat_bitcast_operand(%arg0: vector<8xi8>) -> vector<4xi16> {
    %0 = llvm.mlir.undef : vector<8xi8>
    %1 = llvm.mlir.undef : vector<4xi16>
    %2 = llvm.shufflevector %arg0, %0 [1, 1, 1, 1, 1, 1, 1, 1] : vector<8xi8> 
    %3 = llvm.bitcast %2 : vector<8xi8> to vector<4xi16>
    %4 = llvm.shufflevector %3, %1 [0, 2, 1, 0] : vector<4xi16> 
    llvm.return %4 : vector<4xi16>
  }]

def splat_bitcast_operand_uses_before := [llvmfunc|
  llvm.func @splat_bitcast_operand_uses(%arg0: vector<8xi8>) -> vector<4xi16> {
    %0 = llvm.mlir.undef : vector<8xi8>
    %1 = llvm.mlir.undef : vector<4xi16>
    %2 = llvm.shufflevector %arg0, %0 [1, 1, 1, 1, 1, 1, 1, 1] : vector<8xi8> 
    %3 = llvm.bitcast %2 : vector<8xi8> to vector<4xi16>
    llvm.call @use(%3) : (vector<4xi16>) -> ()
    %4 = llvm.shufflevector %3, %1 [0, 2, 1, 0] : vector<4xi16> 
    llvm.return %4 : vector<4xi16>
  }]

def splat_bitcast_operand_same_size_src_elt_before := [llvmfunc|
  llvm.func @splat_bitcast_operand_same_size_src_elt(%arg0: vector<4xf32>) -> vector<4xi32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.undef : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %0 [2, 2, 2, 2] : vector<4xf32> 
    %3 = llvm.bitcast %2 : vector<4xf32> to vector<4xi32>
    %4 = llvm.shufflevector %3, %1 [0, 2, 1, 0] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def shuf_bitcast_operand_before := [llvmfunc|
  llvm.func @shuf_bitcast_operand(%arg0: vector<16xi8>) -> vector<4xi32> {
    %0 = llvm.mlir.undef : vector<16xi8>
    %1 = llvm.mlir.undef : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %0 [12, 13, 14, 15, 8, 9, 10, 11, 4, 5, 6, 7, 0, 1, 2, 3] : vector<16xi8> 
    %3 = llvm.bitcast %2 : vector<16xi8> to vector<4xi32>
    %4 = llvm.shufflevector %3, %1 [3, 2, 1, 0] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def splat_bitcast_operand_change_type_before := [llvmfunc|
  llvm.func @splat_bitcast_operand_change_type(%arg0: vector<8xi8>) -> vector<5xi16> {
    %0 = llvm.mlir.undef : vector<8xi8>
    %1 = llvm.mlir.undef : vector<4xi16>
    %2 = llvm.shufflevector %arg0, %0 [1, 1, 1, 1, 1, 1, 1, 1] : vector<8xi8> 
    %3 = llvm.bitcast %2 : vector<8xi8> to vector<4xi16>
    %4 = llvm.shufflevector %3, %1 [0, 2, 1, 0, 3] : vector<4xi16> 
    llvm.return %4 : vector<5xi16>
  }]

def splat_bitcast_operand_wider_src_elt_before := [llvmfunc|
  llvm.func @splat_bitcast_operand_wider_src_elt(%arg0: vector<2xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.undef : vector<4xi16>
    %2 = llvm.shufflevector %arg0, %0 [1, 1] : vector<2xi32> 
    %3 = llvm.bitcast %2 : vector<2xi32> to vector<4xi16>
    %4 = llvm.shufflevector %3, %1 [0, 1, 0, 1] : vector<4xi16> 
    llvm.return %4 : vector<4xi16>
  }]

def splat_bitcast_operand_wider_src_elt_uses_before := [llvmfunc|
  llvm.func @splat_bitcast_operand_wider_src_elt_uses(%arg0: vector<2xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.undef : vector<4xi16>
    %2 = llvm.shufflevector %arg0, %0 [1, 1] : vector<2xi32> 
    %3 = llvm.bitcast %2 : vector<2xi32> to vector<4xi16>
    llvm.call @use(%3) : (vector<4xi16>) -> ()
    %4 = llvm.shufflevector %3, %1 [0, 1, 0, 1] : vector<4xi16> 
    llvm.return %4 : vector<4xi16>
  }]

def shuf_bitcast_operand_wider_src_before := [llvmfunc|
  llvm.func @shuf_bitcast_operand_wider_src(%arg0: vector<4xi32>) -> vector<16xi8> {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.mlir.undef : vector<16xi8>
    %2 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi32> 
    %3 = llvm.bitcast %2 : vector<4xi32> to vector<16xi8>
    %4 = llvm.shufflevector %3, %1 [12, 13, 14, 15, 8, 9, 10, 11, 4, 5, 6, 7, 0, 1, 2, 3] : vector<16xi8> 
    llvm.return %4 : vector<16xi8>
  }]

def shuf_bitcast_operand_cannot_widen_before := [llvmfunc|
  llvm.func @shuf_bitcast_operand_cannot_widen(%arg0: vector<4xi32>) -> vector<16xi8> {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.mlir.undef : vector<16xi8>
    %2 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi32> 
    %3 = llvm.bitcast %2 : vector<4xi32> to vector<16xi8>
    %4 = llvm.shufflevector %3, %1 [12, 13, 12, 13, 8, 9, 10, 11, 4, 5, 6, 7, 0, 1, 2, 3] : vector<16xi8> 
    llvm.return %4 : vector<16xi8>
  }]

def shuf_bitcast_operand_cannot_widen_undef_before := [llvmfunc|
  llvm.func @shuf_bitcast_operand_cannot_widen_undef(%arg0: vector<4xi32>) -> vector<16xi8> {
    %0 = llvm.mlir.undef : vector<4xi32>
    %1 = llvm.mlir.undef : vector<16xi8>
    %2 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi32> 
    %3 = llvm.bitcast %2 : vector<4xi32> to vector<16xi8>
    %4 = llvm.shufflevector %3, %1 [12, -1, 14, 15, 8, 9, 10, 11, 4, 5, 6, 7, 0, 1, 2, 3] : vector<16xi8> 
    llvm.return %4 : vector<16xi8>
  }]

def shuf_bitcast_insert_before := [llvmfunc|
  llvm.func @shuf_bitcast_insert(%arg0: vector<2xi8>, %arg1: i8) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xi4>
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to vector<4xi4>
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi4> 
    llvm.return %4 : vector<2xi4>
  }]

def shuf_bitcast_inserti_use1_before := [llvmfunc|
  llvm.func @shuf_bitcast_inserti_use1(%arg0: vector<2xi8>, %arg1: i8, %arg2: !llvm.ptr) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xi4>
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : vector<2xi8>
    llvm.store %2, %arg2 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr]

    %3 = llvm.bitcast %2 : vector<2xi8> to vector<4xi4>
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi4> 
    llvm.return %4 : vector<2xi4>
  }]

def shuf_bitcast_insert_use2_before := [llvmfunc|
  llvm.func @shuf_bitcast_insert_use2(%arg0: vector<2xi8>, %arg1: i8, %arg2: !llvm.ptr) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xi4>
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to vector<4xi4>
    llvm.store %3, %arg2 {alignment = 2 : i64} : vector<4xi4>, !llvm.ptr]

    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi4> 
    llvm.return %4 : vector<2xi4>
  }]

def shuf_bitcast_insert_wrong_index_before := [llvmfunc|
  llvm.func @shuf_bitcast_insert_wrong_index(%arg0: vector<2xi8>, %arg1: i8) -> vector<2xi4> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xi4>
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to vector<4xi4>
    %4 = llvm.shufflevector %3, %1 [0, 1] : vector<4xi4> 
    llvm.return %4 : vector<2xi4>
  }]

def shuf_bitcast_wrong_size_before := [llvmfunc|
  llvm.func @shuf_bitcast_wrong_size(%arg0: vector<2xi8>, %arg1: i8) -> vector<3xi4> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : vector<4xi4>
    %2 = llvm.insertelement %arg1, %arg0[%0 : i32] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to vector<4xi4>
    %4 = llvm.shufflevector %3, %1 [0, 1, 2] : vector<4xi4> 
    llvm.return %4 : vector<3xi4>
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: vector<16xi8>, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<16xi8> to vector<4xi32>
    %2 = llvm.extractelement %1[%0 : i64] : vector<4xi32>
    %3 = llvm.bitcast %arg0 : vector<16xi8> to vector<4xf32>
    %4 = llvm.extractelement %3[%0 : i64] : vector<4xf32>
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %arg2 {alignment = 4 : i64} : f32, !llvm.ptr]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def splat_bitcast_operand_combined := [llvmfunc|
  llvm.func @splat_bitcast_operand(%arg0: vector<8xi8>) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<8xi8>
    %1 = llvm.shufflevector %arg0, %0 [1, 1, 1, 1, 1, 1, 1, 1] : vector<8xi8> 
    %2 = llvm.bitcast %1 : vector<8xi8> to vector<4xi16>
    llvm.return %2 : vector<4xi16>
  }]

theorem inst_combine_splat_bitcast_operand   : splat_bitcast_operand_before  ⊑  splat_bitcast_operand_combined := by
  unfold splat_bitcast_operand_before splat_bitcast_operand_combined
  simp_alive_peephole
  sorry
def splat_bitcast_operand_uses_combined := [llvmfunc|
  llvm.func @splat_bitcast_operand_uses(%arg0: vector<8xi8>) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<8xi8>
    %1 = llvm.shufflevector %arg0, %0 [1, 1, 1, 1, 1, 1, 1, 1] : vector<8xi8> 
    %2 = llvm.bitcast %1 : vector<8xi8> to vector<4xi16>
    llvm.call @use(%2) : (vector<4xi16>) -> ()
    %3 = llvm.bitcast %1 : vector<8xi8> to vector<4xi16>
    llvm.return %3 : vector<4xi16>
  }]

theorem inst_combine_splat_bitcast_operand_uses   : splat_bitcast_operand_uses_before  ⊑  splat_bitcast_operand_uses_combined := by
  unfold splat_bitcast_operand_uses_before splat_bitcast_operand_uses_combined
  simp_alive_peephole
  sorry
def splat_bitcast_operand_same_size_src_elt_combined := [llvmfunc|
  llvm.func @splat_bitcast_operand_same_size_src_elt(%arg0: vector<4xf32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.bitcast %arg0 : vector<4xf32> to vector<4xi32>
    %2 = llvm.shufflevector %1, %0 [2, 2, 2, 2] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_splat_bitcast_operand_same_size_src_elt   : splat_bitcast_operand_same_size_src_elt_before  ⊑  splat_bitcast_operand_same_size_src_elt_combined := by
  unfold splat_bitcast_operand_same_size_src_elt_before splat_bitcast_operand_same_size_src_elt_combined
  simp_alive_peephole
  sorry
def shuf_bitcast_operand_combined := [llvmfunc|
  llvm.func @shuf_bitcast_operand(%arg0: vector<16xi8>) -> vector<4xi32> {
    %0 = llvm.bitcast %arg0 : vector<16xi8> to vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_shuf_bitcast_operand   : shuf_bitcast_operand_before  ⊑  shuf_bitcast_operand_combined := by
  unfold shuf_bitcast_operand_before shuf_bitcast_operand_combined
  simp_alive_peephole
  sorry
def splat_bitcast_operand_change_type_combined := [llvmfunc|
  llvm.func @splat_bitcast_operand_change_type(%arg0: vector<8xi8>) -> vector<5xi16> {
    %0 = llvm.mlir.poison : vector<8xi8>
    %1 = llvm.mlir.poison : vector<4xi16>
    %2 = llvm.shufflevector %arg0, %0 [1, 1, 1, 1, 1, 1, 1, 1] : vector<8xi8> 
    %3 = llvm.bitcast %2 : vector<8xi8> to vector<4xi16>
    %4 = llvm.shufflevector %3, %1 [0, 2, 1, 0, 3] : vector<4xi16> 
    llvm.return %4 : vector<5xi16>
  }]

theorem inst_combine_splat_bitcast_operand_change_type   : splat_bitcast_operand_change_type_before  ⊑  splat_bitcast_operand_change_type_combined := by
  unfold splat_bitcast_operand_change_type_before splat_bitcast_operand_change_type_combined
  simp_alive_peephole
  sorry
def splat_bitcast_operand_wider_src_elt_combined := [llvmfunc|
  llvm.func @splat_bitcast_operand_wider_src_elt(%arg0: vector<2xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 1] : vector<2xi32> 
    %2 = llvm.bitcast %1 : vector<2xi32> to vector<4xi16>
    llvm.return %2 : vector<4xi16>
  }]

theorem inst_combine_splat_bitcast_operand_wider_src_elt   : splat_bitcast_operand_wider_src_elt_before  ⊑  splat_bitcast_operand_wider_src_elt_combined := by
  unfold splat_bitcast_operand_wider_src_elt_before splat_bitcast_operand_wider_src_elt_combined
  simp_alive_peephole
  sorry
def splat_bitcast_operand_wider_src_elt_uses_combined := [llvmfunc|
  llvm.func @splat_bitcast_operand_wider_src_elt_uses(%arg0: vector<2xi32>) -> vector<4xi16> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 1] : vector<2xi32> 
    %2 = llvm.bitcast %1 : vector<2xi32> to vector<4xi16>
    llvm.call @use(%2) : (vector<4xi16>) -> ()
    %3 = llvm.bitcast %1 : vector<2xi32> to vector<4xi16>
    llvm.return %3 : vector<4xi16>
  }]

theorem inst_combine_splat_bitcast_operand_wider_src_elt_uses   : splat_bitcast_operand_wider_src_elt_uses_before  ⊑  splat_bitcast_operand_wider_src_elt_uses_combined := by
  unfold splat_bitcast_operand_wider_src_elt_uses_before splat_bitcast_operand_wider_src_elt_uses_combined
  simp_alive_peephole
  sorry
def shuf_bitcast_operand_wider_src_combined := [llvmfunc|
  llvm.func @shuf_bitcast_operand_wider_src(%arg0: vector<4xi32>) -> vector<16xi8> {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to vector<16xi8>
    llvm.return %0 : vector<16xi8>
  }]

theorem inst_combine_shuf_bitcast_operand_wider_src   : shuf_bitcast_operand_wider_src_before  ⊑  shuf_bitcast_operand_wider_src_combined := by
  unfold shuf_bitcast_operand_wider_src_before shuf_bitcast_operand_wider_src_combined
  simp_alive_peephole
  sorry
def shuf_bitcast_operand_cannot_widen_combined := [llvmfunc|
  llvm.func @shuf_bitcast_operand_cannot_widen(%arg0: vector<4xi32>) -> vector<16xi8> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.poison : vector<16xi8>
    %2 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi32> 
    %3 = llvm.bitcast %2 : vector<4xi32> to vector<16xi8>
    %4 = llvm.shufflevector %3, %1 [12, 13, 12, 13, 8, 9, 10, 11, 4, 5, 6, 7, 0, 1, 2, 3] : vector<16xi8> 
    llvm.return %4 : vector<16xi8>
  }]

theorem inst_combine_shuf_bitcast_operand_cannot_widen   : shuf_bitcast_operand_cannot_widen_before  ⊑  shuf_bitcast_operand_cannot_widen_combined := by
  unfold shuf_bitcast_operand_cannot_widen_before shuf_bitcast_operand_cannot_widen_combined
  simp_alive_peephole
  sorry
def shuf_bitcast_operand_cannot_widen_undef_combined := [llvmfunc|
  llvm.func @shuf_bitcast_operand_cannot_widen_undef(%arg0: vector<4xi32>) -> vector<16xi8> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.mlir.poison : vector<16xi8>
    %2 = llvm.shufflevector %arg0, %0 [3, 2, 1, 0] : vector<4xi32> 
    %3 = llvm.bitcast %2 : vector<4xi32> to vector<16xi8>
    %4 = llvm.shufflevector %3, %1 [12, -1, 14, 15, 8, 9, 10, 11, 4, 5, 6, 7, 0, 1, 2, 3] : vector<16xi8> 
    llvm.return %4 : vector<16xi8>
  }]

theorem inst_combine_shuf_bitcast_operand_cannot_widen_undef   : shuf_bitcast_operand_cannot_widen_undef_before  ⊑  shuf_bitcast_operand_cannot_widen_undef_combined := by
  unfold shuf_bitcast_operand_cannot_widen_undef_before shuf_bitcast_operand_cannot_widen_undef_combined
  simp_alive_peephole
  sorry
def shuf_bitcast_insert_combined := [llvmfunc|
  llvm.func @shuf_bitcast_insert(%arg0: vector<2xi8>, %arg1: i8) -> vector<2xi4> {
    %0 = llvm.bitcast %arg1 : i8 to vector<2xi4>
    llvm.return %0 : vector<2xi4>
  }]

theorem inst_combine_shuf_bitcast_insert   : shuf_bitcast_insert_before  ⊑  shuf_bitcast_insert_combined := by
  unfold shuf_bitcast_insert_before shuf_bitcast_insert_combined
  simp_alive_peephole
  sorry
def shuf_bitcast_inserti_use1_combined := [llvmfunc|
  llvm.func @shuf_bitcast_inserti_use1(%arg0: vector<2xi8>, %arg1: i8, %arg2: !llvm.ptr) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.insertelement %arg1, %arg0[%0 : i64] : vector<2xi8>
    llvm.store %1, %arg2 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr]

theorem inst_combine_shuf_bitcast_inserti_use1   : shuf_bitcast_inserti_use1_before  ⊑  shuf_bitcast_inserti_use1_combined := by
  unfold shuf_bitcast_inserti_use1_before shuf_bitcast_inserti_use1_combined
  simp_alive_peephole
  sorry
    %2 = llvm.bitcast %arg1 : i8 to vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

theorem inst_combine_shuf_bitcast_inserti_use1   : shuf_bitcast_inserti_use1_before  ⊑  shuf_bitcast_inserti_use1_combined := by
  unfold shuf_bitcast_inserti_use1_before shuf_bitcast_inserti_use1_combined
  simp_alive_peephole
  sorry
def shuf_bitcast_insert_use2_combined := [llvmfunc|
  llvm.func @shuf_bitcast_insert_use2(%arg0: vector<2xi8>, %arg1: i8, %arg2: !llvm.ptr) -> vector<2xi4> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.insertelement %arg1, %arg0[%0 : i64] : vector<2xi8>
    llvm.store %1, %arg2 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr]

theorem inst_combine_shuf_bitcast_insert_use2   : shuf_bitcast_insert_use2_before  ⊑  shuf_bitcast_insert_use2_combined := by
  unfold shuf_bitcast_insert_use2_before shuf_bitcast_insert_use2_combined
  simp_alive_peephole
  sorry
    %2 = llvm.bitcast %arg1 : i8 to vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }]

theorem inst_combine_shuf_bitcast_insert_use2   : shuf_bitcast_insert_use2_before  ⊑  shuf_bitcast_insert_use2_combined := by
  unfold shuf_bitcast_insert_use2_before shuf_bitcast_insert_use2_combined
  simp_alive_peephole
  sorry
def shuf_bitcast_insert_wrong_index_combined := [llvmfunc|
  llvm.func @shuf_bitcast_insert_wrong_index(%arg0: vector<2xi8>, %arg1: i8) -> vector<2xi4> {
    %0 = llvm.mlir.poison : vector<4xi4>
    %1 = llvm.bitcast %arg0 : vector<2xi8> to vector<4xi4>
    %2 = llvm.shufflevector %1, %0 [0, 1] : vector<4xi4> 
    llvm.return %2 : vector<2xi4>
  }]

theorem inst_combine_shuf_bitcast_insert_wrong_index   : shuf_bitcast_insert_wrong_index_before  ⊑  shuf_bitcast_insert_wrong_index_combined := by
  unfold shuf_bitcast_insert_wrong_index_before shuf_bitcast_insert_wrong_index_combined
  simp_alive_peephole
  sorry
def shuf_bitcast_wrong_size_combined := [llvmfunc|
  llvm.func @shuf_bitcast_wrong_size(%arg0: vector<2xi8>, %arg1: i8) -> vector<3xi4> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.poison : vector<4xi4>
    %2 = llvm.insertelement %arg1, %arg0[%0 : i64] : vector<2xi8>
    %3 = llvm.bitcast %2 : vector<2xi8> to vector<4xi4>
    %4 = llvm.shufflevector %3, %1 [0, 1, 2] : vector<4xi4> 
    llvm.return %4 : vector<3xi4>
  }]

theorem inst_combine_shuf_bitcast_wrong_size   : shuf_bitcast_wrong_size_before  ⊑  shuf_bitcast_wrong_size_combined := by
  unfold shuf_bitcast_wrong_size_before shuf_bitcast_wrong_size_combined
  simp_alive_peephole
  sorry
