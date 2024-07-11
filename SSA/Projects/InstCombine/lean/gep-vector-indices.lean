import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  gep-vector-indices
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def vector_splat_indices_v2i64_ext0_before := [llvmfunc|
  llvm.func @vector_splat_indices_v2i64_ext0(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %3 = llvm.extractelement %2[%1 : i32] : !llvm.vec<2 x ptr>
    llvm.return %3 : !llvm.ptr
  }]

def vector_splat_indices_nxv2i64_ext0_before := [llvmfunc|
  llvm.func @vector_splat_indices_nxv2i64_ext0(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.poison : !llvm.vec<? x 2 x  i64>
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %1, %0[%2 : i32] : !llvm.vec<? x 2 x  i64>
    %4 = llvm.shufflevector %3, %0 [0, 0] : !llvm.vec<? x 2 x  i64> 
    %5 = llvm.getelementptr inbounds %arg0[%4] : (!llvm.ptr, vector<[2]xi64>) -> !llvm.vec<? x 2 x  ptr>, i32
    %6 = llvm.extractelement %5[%2 : i32] : !llvm.vec<? x 2 x  ptr>
    llvm.return %6 : !llvm.ptr
  }]

def vector_indices_v2i64_ext0_before := [llvmfunc|
  llvm.func @vector_indices_v2i64_ext0(%arg0: !llvm.ptr, %arg1: vector<2xi64>) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i32
    %2 = llvm.extractelement %1[%0 : i32] : !llvm.vec<2 x ptr>
    llvm.return %2 : !llvm.ptr
  }]

def vector_indices_nxv1i64_ext0_before := [llvmfunc|
  llvm.func @vector_indices_nxv1i64_ext0(%arg0: !llvm.ptr, %arg1: !llvm.vec<? x 1 x  i64>) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, !llvm.vec<? x 1 x  i64>) -> !llvm.vec<? x 1 x  ptr>, i32
    %2 = llvm.extractelement %1[%0 : i32] : !llvm.vec<? x 1 x  ptr>
    llvm.return %2 : !llvm.ptr
  }]

def vector_splat_ptrs_v2i64_ext0_before := [llvmfunc|
  llvm.func @vector_splat_ptrs_v2i64_ext0(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.poison : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<2 x ptr>
    %3 = llvm.shufflevector %2, %0 [0, 0] : !llvm.vec<2 x ptr> 
    %4 = llvm.getelementptr %3[%arg1] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i32
    %5 = llvm.extractelement %4[%1 : i32] : !llvm.vec<2 x ptr>
    llvm.return %5 : !llvm.ptr
  }]

def vector_splat_ptrs_nxv2i64_ext0_before := [llvmfunc|
  llvm.func @vector_splat_ptrs_nxv2i64_ext0(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.poison : !llvm.vec<? x 2 x  ptr>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<? x 2 x  ptr>
    %3 = llvm.shufflevector %2, %0 [0, 0] : !llvm.vec<? x 2 x  ptr> 
    %4 = llvm.getelementptr %3[%arg1] : (!llvm.vec<? x 2 x  ptr>, i64) -> !llvm.vec<? x 2 x  ptr>, i32
    %5 = llvm.extractelement %4[%1 : i32] : !llvm.vec<? x 2 x  ptr>
    llvm.return %5 : !llvm.ptr
  }]

def vector_struct1_splat_indices_v4i64_ext1_before := [llvmfunc|
  llvm.func @vector_struct1_splat_indices_v4i64_ext1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(dense<4> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.getelementptr %arg0[%0, 0] : (!llvm.ptr, vector<4xi32>) -> !llvm.vec<4 x ptr>, !llvm.struct<(f32, f32)>
    %4 = llvm.extractelement %3[%2 : i32] : !llvm.vec<4 x ptr>
    llvm.return %4 : !llvm.ptr
  }]

def vector_struct2_splat_indices_v4i64_ext1_before := [llvmfunc|
  llvm.func @vector_struct2_splat_indices_v4i64_ext1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<4> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.getelementptr %arg0[%0, 1, %2] : (!llvm.ptr, i32, vector<4xi32>) -> !llvm.vec<4 x ptr>, !llvm.struct<(f32, array<8 x f32>)>
    %4 = llvm.extractelement %3[%1 : i32] : !llvm.vec<4 x ptr>
    llvm.return %4 : !llvm.ptr
  }]

def vector_indices_nxv2i64_ext3_before := [llvmfunc|
  llvm.func @vector_indices_nxv2i64_ext3(%arg0: !llvm.ptr, %arg1: !llvm.vec<? x 2 x  i64>) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, !llvm.vec<? x 2 x  i64>) -> !llvm.vec<? x 2 x  ptr>, i32
    %2 = llvm.extractelement %1[%0 : i32] : !llvm.vec<? x 2 x  ptr>
    llvm.return %2 : !llvm.ptr
  }]

def vector_indices_nxv2i64_extN_before := [llvmfunc|
  llvm.func @vector_indices_nxv2i64_extN(%arg0: !llvm.ptr, %arg1: !llvm.vec<? x 2 x  i64>, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, !llvm.vec<? x 2 x  i64>) -> !llvm.vec<? x 2 x  ptr>, i32
    %1 = llvm.extractelement %0[%arg2 : i32] : !llvm.vec<? x 2 x  ptr>
    llvm.return %1 : !llvm.ptr
  }]

def vector_indices_nxv2i64_mulitple_use_before := [llvmfunc|
  llvm.func @vector_indices_nxv2i64_mulitple_use(%arg0: !llvm.ptr, %arg1: !llvm.vec<? x 2 x  i64>, %arg2: !llvm.ptr, %arg3: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, !llvm.vec<? x 2 x  i64>) -> !llvm.vec<? x 2 x  ptr>, i32
    %3 = llvm.extractelement %2[%0 : i32] : !llvm.vec<? x 2 x  ptr>
    %4 = llvm.extractelement %2[%1 : i32] : !llvm.vec<? x 2 x  ptr>
    llvm.store %3, %arg2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.store %4, %arg3 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def vector_ptrs_and_indices_ext0_before := [llvmfunc|
  llvm.func @vector_ptrs_and_indices_ext0(%arg0: !llvm.vec<? x 4 x  ptr>, %arg1: !llvm.vec<? x 4 x  i64>) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.getelementptr %arg0[%arg1] : (!llvm.vec<? x 4 x  ptr>, !llvm.vec<? x 4 x  i64>) -> !llvm.vec<? x 4 x  ptr>, i32
    %2 = llvm.extractelement %1[%0 : i32] : !llvm.vec<? x 4 x  ptr>
    llvm.return %2 : !llvm.ptr
  }]

def vector_splat_indices_v2i64_ext0_combined := [llvmfunc|
  llvm.func @vector_splat_indices_v2i64_ext0(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_vector_splat_indices_v2i64_ext0   : vector_splat_indices_v2i64_ext0_before  ⊑  vector_splat_indices_v2i64_ext0_combined := by
  unfold vector_splat_indices_v2i64_ext0_before vector_splat_indices_v2i64_ext0_combined
  simp_alive_peephole
  sorry
def vector_splat_indices_nxv2i64_ext0_combined := [llvmfunc|
  llvm.func @vector_splat_indices_nxv2i64_ext0(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_vector_splat_indices_nxv2i64_ext0   : vector_splat_indices_nxv2i64_ext0_before  ⊑  vector_splat_indices_nxv2i64_ext0_combined := by
  unfold vector_splat_indices_nxv2i64_ext0_before vector_splat_indices_nxv2i64_ext0_combined
  simp_alive_peephole
  sorry
def vector_indices_v2i64_ext0_combined := [llvmfunc|
  llvm.func @vector_indices_v2i64_ext0(%arg0: !llvm.ptr, %arg1: vector<2xi64>) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.extractelement %arg1[%0 : i64] : vector<2xi64>
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_vector_indices_v2i64_ext0   : vector_indices_v2i64_ext0_before  ⊑  vector_indices_v2i64_ext0_combined := by
  unfold vector_indices_v2i64_ext0_before vector_indices_v2i64_ext0_combined
  simp_alive_peephole
  sorry
def vector_indices_nxv1i64_ext0_combined := [llvmfunc|
  llvm.func @vector_indices_nxv1i64_ext0(%arg0: !llvm.ptr, %arg1: !llvm.vec<? x 1 x  i64>) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.extractelement %arg1[%0 : i64] : !llvm.vec<? x 1 x  i64>
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_vector_indices_nxv1i64_ext0   : vector_indices_nxv1i64_ext0_before  ⊑  vector_indices_nxv1i64_ext0_combined := by
  unfold vector_indices_nxv1i64_ext0_before vector_indices_nxv1i64_ext0_combined
  simp_alive_peephole
  sorry
def vector_splat_ptrs_v2i64_ext0_combined := [llvmfunc|
  llvm.func @vector_splat_ptrs_v2i64_ext0(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_vector_splat_ptrs_v2i64_ext0   : vector_splat_ptrs_v2i64_ext0_before  ⊑  vector_splat_ptrs_v2i64_ext0_combined := by
  unfold vector_splat_ptrs_v2i64_ext0_before vector_splat_ptrs_v2i64_ext0_combined
  simp_alive_peephole
  sorry
def vector_splat_ptrs_nxv2i64_ext0_combined := [llvmfunc|
  llvm.func @vector_splat_ptrs_nxv2i64_ext0(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_vector_splat_ptrs_nxv2i64_ext0   : vector_splat_ptrs_nxv2i64_ext0_before  ⊑  vector_splat_ptrs_nxv2i64_ext0_combined := by
  unfold vector_splat_ptrs_nxv2i64_ext0_before vector_splat_ptrs_nxv2i64_ext0_combined
  simp_alive_peephole
  sorry
def vector_struct1_splat_indices_v4i64_ext1_combined := [llvmfunc|
  llvm.func @vector_struct1_splat_indices_v4i64_ext1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0, 0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<(f32, f32)>
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_vector_struct1_splat_indices_v4i64_ext1   : vector_struct1_splat_indices_v4i64_ext1_before  ⊑  vector_struct1_splat_indices_v4i64_ext1_combined := by
  unfold vector_struct1_splat_indices_v4i64_ext1_before vector_struct1_splat_indices_v4i64_ext1_combined
  simp_alive_peephole
  sorry
def vector_struct2_splat_indices_v4i64_ext1_combined := [llvmfunc|
  llvm.func @vector_struct2_splat_indices_v4i64_ext1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.getelementptr %arg0[%0, 1, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.struct<(f32, array<8 x f32>)>
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_vector_struct2_splat_indices_v4i64_ext1   : vector_struct2_splat_indices_v4i64_ext1_before  ⊑  vector_struct2_splat_indices_v4i64_ext1_combined := by
  unfold vector_struct2_splat_indices_v4i64_ext1_before vector_struct2_splat_indices_v4i64_ext1_combined
  simp_alive_peephole
  sorry
def vector_indices_nxv2i64_ext3_combined := [llvmfunc|
  llvm.func @vector_indices_nxv2i64_ext3(%arg0: !llvm.ptr, %arg1: !llvm.vec<? x 2 x  i64>) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, !llvm.vec<? x 2 x  i64>) -> !llvm.vec<? x 2 x  ptr>, i32
    %2 = llvm.extractelement %1[%0 : i64] : !llvm.vec<? x 2 x  ptr>
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_vector_indices_nxv2i64_ext3   : vector_indices_nxv2i64_ext3_before  ⊑  vector_indices_nxv2i64_ext3_combined := by
  unfold vector_indices_nxv2i64_ext3_before vector_indices_nxv2i64_ext3_combined
  simp_alive_peephole
  sorry
def vector_indices_nxv2i64_extN_combined := [llvmfunc|
  llvm.func @vector_indices_nxv2i64_extN(%arg0: !llvm.ptr, %arg1: !llvm.vec<? x 2 x  i64>, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, !llvm.vec<? x 2 x  i64>) -> !llvm.vec<? x 2 x  ptr>, i32
    %1 = llvm.extractelement %0[%arg2 : i32] : !llvm.vec<? x 2 x  ptr>
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_vector_indices_nxv2i64_extN   : vector_indices_nxv2i64_extN_before  ⊑  vector_indices_nxv2i64_extN_combined := by
  unfold vector_indices_nxv2i64_extN_before vector_indices_nxv2i64_extN_combined
  simp_alive_peephole
  sorry
def vector_indices_nxv2i64_mulitple_use_combined := [llvmfunc|
  llvm.func @vector_indices_nxv2i64_mulitple_use(%arg0: !llvm.ptr, %arg1: !llvm.vec<? x 2 x  i64>, %arg2: !llvm.ptr, %arg3: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, !llvm.vec<? x 2 x  i64>) -> !llvm.vec<? x 2 x  ptr>, i32
    %3 = llvm.extractelement %2[%0 : i64] : !llvm.vec<? x 2 x  ptr>
    %4 = llvm.extractelement %2[%1 : i64] : !llvm.vec<? x 2 x  ptr>
    llvm.store %3, %arg2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %4, %arg3 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_vector_indices_nxv2i64_mulitple_use   : vector_indices_nxv2i64_mulitple_use_before  ⊑  vector_indices_nxv2i64_mulitple_use_combined := by
  unfold vector_indices_nxv2i64_mulitple_use_before vector_indices_nxv2i64_mulitple_use_combined
  simp_alive_peephole
  sorry
def vector_ptrs_and_indices_ext0_combined := [llvmfunc|
  llvm.func @vector_ptrs_and_indices_ext0(%arg0: !llvm.vec<? x 4 x  ptr>, %arg1: !llvm.vec<? x 4 x  i64>) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr %arg0[%arg1] : (!llvm.vec<? x 4 x  ptr>, !llvm.vec<? x 4 x  i64>) -> !llvm.vec<? x 4 x  ptr>, i32
    %2 = llvm.extractelement %1[%0 : i64] : !llvm.vec<? x 4 x  ptr>
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_vector_ptrs_and_indices_ext0   : vector_ptrs_and_indices_ext0_before  ⊑  vector_ptrs_and_indices_ext0_combined := by
  unfold vector_ptrs_and_indices_ext0_before vector_ptrs_and_indices_ext0_combined
  simp_alive_peephole
  sorry
