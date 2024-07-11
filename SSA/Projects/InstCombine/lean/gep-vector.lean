import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  gep-vector
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def vectorindex1_before := [llvmfunc|
  llvm.func @vectorindex1() -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<8192xi8>) : !llvm.array<8192 x i8>
    %2 = llvm.mlir.constant(dense<0> : tensor<64x8192xi8>) : !llvm.array<64 x array<8192 x i8>>
    %3 = llvm.mlir.addressof @block : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %6 = llvm.mlir.constant(8192 : i64) : i64
    %7 = llvm.getelementptr inbounds %3[%4, %5, %6] : (!llvm.ptr, i64, vector<2xi64>, i64) -> !llvm.vec<2 x ptr>, !llvm.array<64 x array<8192 x i8>>
    llvm.return %7 : !llvm.vec<2 x ptr>
  }]

def vectorindex2_before := [llvmfunc|
  llvm.func @vectorindex2() -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<8192xi8>) : !llvm.array<8192 x i8>
    %2 = llvm.mlir.constant(dense<0> : tensor<64x8192xi8>) : !llvm.array<64 x array<8192 x i8>>
    %3 = llvm.mlir.addressof @block : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(dense<[8191, 8193]> : vector<2xi64>) : vector<2xi64>
    %7 = llvm.getelementptr inbounds %3[%4, %5, %6] : (!llvm.ptr, i64, i64, vector<2xi64>) -> !llvm.vec<2 x ptr>, !llvm.array<64 x array<8192 x i8>>
    llvm.return %7 : !llvm.vec<2 x ptr>
  }]

def vectorindex3_before := [llvmfunc|
  llvm.func @vectorindex3() -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<8192xi8>) : !llvm.array<8192 x i8>
    %2 = llvm.mlir.constant(dense<0> : tensor<64x8192xi8>) : !llvm.array<64 x array<8192 x i8>>
    %3 = llvm.mlir.addressof @block : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %6 = llvm.mlir.constant(dense<[8191, 8193]> : vector<2xi64>) : vector<2xi64>
    %7 = llvm.getelementptr inbounds %3[%4, %5, %6] : (!llvm.ptr, i64, vector<2xi64>, vector<2xi64>) -> !llvm.vec<2 x ptr>, !llvm.array<64 x array<8192 x i8>>
    llvm.return %7 : !llvm.vec<2 x ptr>
  }]

def bitcast_vec_to_array_gep_before := [llvmfunc|
  llvm.func @bitcast_vec_to_array_gep(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i32>
    llvm.return %0 : !llvm.ptr
  }]

def bitcast_array_to_vec_gep_before := [llvmfunc|
  llvm.func @bitcast_array_to_vec_gep(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr inbounds %arg0[%arg1, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, vector<3xi32>
    llvm.return %0 : !llvm.ptr
  }]

def bitcast_vec_to_array_gep_matching_alloc_size_before := [llvmfunc|
  llvm.func @bitcast_vec_to_array_gep_matching_alloc_size(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.return %0 : !llvm.ptr
  }]

def bitcast_array_to_vec_gep_matching_alloc_size_before := [llvmfunc|
  llvm.func @bitcast_array_to_vec_gep_matching_alloc_size(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr inbounds %arg0[%arg1, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, vector<4xi32>
    llvm.return %0 : !llvm.ptr
  }]

def bitcast_vec_to_array_addrspace_before := [llvmfunc|
  llvm.func @bitcast_vec_to_array_addrspace(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr<3> {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<3>
    %1 = llvm.getelementptr %0[%arg1, %arg2] : (!llvm.ptr<3>, i64, i64) -> !llvm.ptr<3>, !llvm.array<7 x i32>
    llvm.return %1 : !llvm.ptr<3>
  }]

def inbounds_bitcast_vec_to_array_addrspace_before := [llvmfunc|
  llvm.func @inbounds_bitcast_vec_to_array_addrspace(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr<3> {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<3>
    %1 = llvm.getelementptr inbounds %0[%arg1, %arg2] : (!llvm.ptr<3>, i64, i64) -> !llvm.ptr<3>, !llvm.array<7 x i32>
    llvm.return %1 : !llvm.ptr<3>
  }]

def bitcast_vec_to_array_addrspace_matching_alloc_size_before := [llvmfunc|
  llvm.func @bitcast_vec_to_array_addrspace_matching_alloc_size(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr<3> {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<3>
    %1 = llvm.getelementptr %0[%arg1, %arg2] : (!llvm.ptr<3>, i64, i64) -> !llvm.ptr<3>, !llvm.array<4 x i32>
    llvm.return %1 : !llvm.ptr<3>
  }]

def inbounds_bitcast_vec_to_array_addrspace_matching_alloc_size_before := [llvmfunc|
  llvm.func @inbounds_bitcast_vec_to_array_addrspace_matching_alloc_size(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr<3> {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<3>
    %1 = llvm.getelementptr inbounds %0[%arg1, %arg2] : (!llvm.ptr<3>, i64, i64) -> !llvm.ptr<3>, !llvm.array<4 x i32>
    llvm.return %1 : !llvm.ptr<3>
  }]

def test_accumulate_constant_offset_vscale_nonzero_before := [llvmfunc|
  llvm.func @test_accumulate_constant_offset_vscale_nonzero(%arg0: !llvm.vec<? x 16 x  i1>, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.getelementptr %arg1[%0, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.vec<? x 16 x  i8>
    llvm.return %2 : !llvm.ptr
  }]

def test_accumulate_constant_offset_vscale_zero_before := [llvmfunc|
  llvm.func @test_accumulate_constant_offset_vscale_zero(%arg0: !llvm.vec<? x 16 x  i1>, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.getelementptr %arg1[%0, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.vec<? x 16 x  i8>
    llvm.return %2 : !llvm.ptr
  }]

def vectorindex1_combined := [llvmfunc|
  llvm.func @vectorindex1() -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.constant(dense<0> : tensor<8192xi8>) : !llvm.array<8192 x i8>
    %5 = llvm.mlir.constant(dense<0> : tensor<64x8192xi8>) : !llvm.array<64 x array<8192 x i8>>
    %6 = llvm.mlir.addressof @block : !llvm.ptr
    %7 = llvm.getelementptr inbounds %6[%1, %2, %1] : (!llvm.ptr, vector<2xi64>, vector<2xi64>, vector<2xi64>) -> !llvm.vec<2 x ptr>, !llvm.array<64 x array<8192 x i8>>
    llvm.return %7 : !llvm.vec<2 x ptr>
  }]

theorem inst_combine_vectorindex1   : vectorindex1_before  ⊑  vectorindex1_combined := by
  unfold vectorindex1_before vectorindex1_combined
  simp_alive_peephole
  sorry
def vectorindex2_combined := [llvmfunc|
  llvm.func @vectorindex2() -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.constant(dense<[8191, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i8) : i8
    %5 = llvm.mlir.constant(dense<0> : tensor<8192xi8>) : !llvm.array<8192 x i8>
    %6 = llvm.mlir.constant(dense<0> : tensor<64x8192xi8>) : !llvm.array<64 x array<8192 x i8>>
    %7 = llvm.mlir.addressof @block : !llvm.ptr
    %8 = llvm.getelementptr inbounds %7[%3, %1, %0] : (!llvm.ptr, vector<2xi64>, vector<2xi64>, vector<2xi64>) -> !llvm.vec<2 x ptr>, !llvm.array<64 x array<8192 x i8>>
    llvm.return %8 : !llvm.vec<2 x ptr>
  }]

theorem inst_combine_vectorindex2   : vectorindex2_before  ⊑  vectorindex2_combined := by
  unfold vectorindex2_before vectorindex2_combined
  simp_alive_peephole
  sorry
def vectorindex3_combined := [llvmfunc|
  llvm.func @vectorindex3() -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.constant(dense<[8191, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[0, 2]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.mlir.constant(0 : i8) : i8
    %5 = llvm.mlir.constant(dense<0> : tensor<8192xi8>) : !llvm.array<8192 x i8>
    %6 = llvm.mlir.constant(dense<0> : tensor<64x8192xi8>) : !llvm.array<64 x array<8192 x i8>>
    %7 = llvm.mlir.addressof @block : !llvm.ptr
    %8 = llvm.getelementptr inbounds %7[%3, %1, %0] : (!llvm.ptr, vector<2xi64>, vector<2xi64>, vector<2xi64>) -> !llvm.vec<2 x ptr>, !llvm.array<64 x array<8192 x i8>>
    llvm.return %8 : !llvm.vec<2 x ptr>
  }]

theorem inst_combine_vectorindex3   : vectorindex3_before  ⊑  vectorindex3_combined := by
  unfold vectorindex3_before vectorindex3_combined
  simp_alive_peephole
  sorry
def bitcast_vec_to_array_gep_combined := [llvmfunc|
  llvm.func @bitcast_vec_to_array_gep(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i32>
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_bitcast_vec_to_array_gep   : bitcast_vec_to_array_gep_before  ⊑  bitcast_vec_to_array_gep_combined := by
  unfold bitcast_vec_to_array_gep_before bitcast_vec_to_array_gep_combined
  simp_alive_peephole
  sorry
def bitcast_array_to_vec_gep_combined := [llvmfunc|
  llvm.func @bitcast_array_to_vec_gep(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr inbounds %arg0[%arg1, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, vector<3xi32>
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_bitcast_array_to_vec_gep   : bitcast_array_to_vec_gep_before  ⊑  bitcast_array_to_vec_gep_combined := by
  unfold bitcast_array_to_vec_gep_before bitcast_array_to_vec_gep_combined
  simp_alive_peephole
  sorry
def bitcast_vec_to_array_gep_matching_alloc_size_combined := [llvmfunc|
  llvm.func @bitcast_vec_to_array_gep_matching_alloc_size(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i32>
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_bitcast_vec_to_array_gep_matching_alloc_size   : bitcast_vec_to_array_gep_matching_alloc_size_before  ⊑  bitcast_vec_to_array_gep_matching_alloc_size_combined := by
  unfold bitcast_vec_to_array_gep_matching_alloc_size_before bitcast_vec_to_array_gep_matching_alloc_size_combined
  simp_alive_peephole
  sorry
def bitcast_array_to_vec_gep_matching_alloc_size_combined := [llvmfunc|
  llvm.func @bitcast_array_to_vec_gep_matching_alloc_size(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr inbounds %arg0[%arg1, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, vector<4xi32>
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_bitcast_array_to_vec_gep_matching_alloc_size   : bitcast_array_to_vec_gep_matching_alloc_size_before  ⊑  bitcast_array_to_vec_gep_matching_alloc_size_combined := by
  unfold bitcast_array_to_vec_gep_matching_alloc_size_before bitcast_array_to_vec_gep_matching_alloc_size_combined
  simp_alive_peephole
  sorry
def bitcast_vec_to_array_addrspace_combined := [llvmfunc|
  llvm.func @bitcast_vec_to_array_addrspace(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr<3> {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<3>
    %1 = llvm.getelementptr %0[%arg1, %arg2] : (!llvm.ptr<3>, i64, i64) -> !llvm.ptr<3>, !llvm.array<7 x i32>
    llvm.return %1 : !llvm.ptr<3>
  }]

theorem inst_combine_bitcast_vec_to_array_addrspace   : bitcast_vec_to_array_addrspace_before  ⊑  bitcast_vec_to_array_addrspace_combined := by
  unfold bitcast_vec_to_array_addrspace_before bitcast_vec_to_array_addrspace_combined
  simp_alive_peephole
  sorry
def inbounds_bitcast_vec_to_array_addrspace_combined := [llvmfunc|
  llvm.func @inbounds_bitcast_vec_to_array_addrspace(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr<3> {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<3>
    %1 = llvm.getelementptr inbounds %0[%arg1, %arg2] : (!llvm.ptr<3>, i64, i64) -> !llvm.ptr<3>, !llvm.array<7 x i32>
    llvm.return %1 : !llvm.ptr<3>
  }]

theorem inst_combine_inbounds_bitcast_vec_to_array_addrspace   : inbounds_bitcast_vec_to_array_addrspace_before  ⊑  inbounds_bitcast_vec_to_array_addrspace_combined := by
  unfold inbounds_bitcast_vec_to_array_addrspace_before inbounds_bitcast_vec_to_array_addrspace_combined
  simp_alive_peephole
  sorry
def bitcast_vec_to_array_addrspace_matching_alloc_size_combined := [llvmfunc|
  llvm.func @bitcast_vec_to_array_addrspace_matching_alloc_size(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr<3> {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<3>
    %1 = llvm.getelementptr %0[%arg1, %arg2] : (!llvm.ptr<3>, i64, i64) -> !llvm.ptr<3>, !llvm.array<4 x i32>
    llvm.return %1 : !llvm.ptr<3>
  }]

theorem inst_combine_bitcast_vec_to_array_addrspace_matching_alloc_size   : bitcast_vec_to_array_addrspace_matching_alloc_size_before  ⊑  bitcast_vec_to_array_addrspace_matching_alloc_size_combined := by
  unfold bitcast_vec_to_array_addrspace_matching_alloc_size_before bitcast_vec_to_array_addrspace_matching_alloc_size_combined
  simp_alive_peephole
  sorry
def inbounds_bitcast_vec_to_array_addrspace_matching_alloc_size_combined := [llvmfunc|
  llvm.func @inbounds_bitcast_vec_to_array_addrspace_matching_alloc_size(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr<3> {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<3>
    %1 = llvm.getelementptr inbounds %0[%arg1, %arg2] : (!llvm.ptr<3>, i64, i64) -> !llvm.ptr<3>, !llvm.array<4 x i32>
    llvm.return %1 : !llvm.ptr<3>
  }]

theorem inst_combine_inbounds_bitcast_vec_to_array_addrspace_matching_alloc_size   : inbounds_bitcast_vec_to_array_addrspace_matching_alloc_size_before  ⊑  inbounds_bitcast_vec_to_array_addrspace_matching_alloc_size_combined := by
  unfold inbounds_bitcast_vec_to_array_addrspace_matching_alloc_size_before inbounds_bitcast_vec_to_array_addrspace_matching_alloc_size_combined
  simp_alive_peephole
  sorry
def test_accumulate_constant_offset_vscale_nonzero_combined := [llvmfunc|
  llvm.func @test_accumulate_constant_offset_vscale_nonzero(%arg0: !llvm.vec<? x 16 x  i1>, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.getelementptr %arg1[%0, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.vec<? x 16 x  i8>
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_test_accumulate_constant_offset_vscale_nonzero   : test_accumulate_constant_offset_vscale_nonzero_before  ⊑  test_accumulate_constant_offset_vscale_nonzero_combined := by
  unfold test_accumulate_constant_offset_vscale_nonzero_before test_accumulate_constant_offset_vscale_nonzero_combined
  simp_alive_peephole
  sorry
def test_accumulate_constant_offset_vscale_zero_combined := [llvmfunc|
  llvm.func @test_accumulate_constant_offset_vscale_zero(%arg0: !llvm.vec<? x 16 x  i1>, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.getelementptr %arg1[%0, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.vec<? x 16 x  i8>
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_test_accumulate_constant_offset_vscale_zero   : test_accumulate_constant_offset_vscale_zero_before  ⊑  test_accumulate_constant_offset_vscale_zero_combined := by
  unfold test_accumulate_constant_offset_vscale_zero_before test_accumulate_constant_offset_vscale_zero_combined
  simp_alive_peephole
  sorry
