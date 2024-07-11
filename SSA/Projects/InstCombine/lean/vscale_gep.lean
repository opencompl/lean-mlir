import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vscale_gep
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def gep_index_type_is_scalable_before := [llvmfunc|
  llvm.func @gep_index_type_is_scalable(%arg0: !llvm.ptr) -> !llvm.vec<? x 2 x  ptr> {
    %0 = llvm.mlir.undef : !llvm.vec<? x 2 x  i64>
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, !llvm.vec<? x 2 x  i64>) -> !llvm.vec<? x 2 x  ptr>, i8
    llvm.return %1 : !llvm.vec<? x 2 x  ptr>
  }]

def gep_num_of_indices_1_before := [llvmfunc|
  llvm.func @gep_num_of_indices_1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    llvm.return %1 : !llvm.ptr
  }]

def gep_bitcast_before := [llvmfunc|
  llvm.func @gep_bitcast(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.undef : !llvm.vec<? x 16 x  i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 16 x  i8>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 16 x  i8>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 16 x  i8>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 16 x  i8>
    %10 = llvm.mlir.constant(4 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : !llvm.vec<? x 16 x  i8>
    %12 = llvm.mlir.constant(5 : i32) : i32
    %13 = llvm.insertelement %0, %11[%12 : i32] : !llvm.vec<? x 16 x  i8>
    %14 = llvm.mlir.constant(6 : i32) : i32
    %15 = llvm.insertelement %0, %13[%14 : i32] : !llvm.vec<? x 16 x  i8>
    %16 = llvm.mlir.constant(7 : i32) : i32
    %17 = llvm.insertelement %0, %15[%16 : i32] : !llvm.vec<? x 16 x  i8>
    %18 = llvm.mlir.constant(8 : i32) : i32
    %19 = llvm.insertelement %0, %17[%18 : i32] : !llvm.vec<? x 16 x  i8>
    %20 = llvm.mlir.constant(9 : i32) : i32
    %21 = llvm.insertelement %0, %19[%20 : i32] : !llvm.vec<? x 16 x  i8>
    %22 = llvm.mlir.constant(10 : i32) : i32
    %23 = llvm.insertelement %0, %21[%22 : i32] : !llvm.vec<? x 16 x  i8>
    %24 = llvm.mlir.constant(11 : i32) : i32
    %25 = llvm.insertelement %0, %23[%24 : i32] : !llvm.vec<? x 16 x  i8>
    %26 = llvm.mlir.constant(12 : i32) : i32
    %27 = llvm.insertelement %0, %25[%26 : i32] : !llvm.vec<? x 16 x  i8>
    %28 = llvm.mlir.constant(13 : i32) : i32
    %29 = llvm.insertelement %0, %27[%28 : i32] : !llvm.vec<? x 16 x  i8>
    %30 = llvm.mlir.constant(14 : i32) : i32
    %31 = llvm.insertelement %0, %29[%30 : i32] : !llvm.vec<? x 16 x  i8>
    %32 = llvm.mlir.constant(15 : i32) : i32
    %33 = llvm.insertelement %0, %31[%32 : i32] : !llvm.vec<? x 16 x  i8>
    %34 = llvm.mlir.constant(1 : i64) : i64
    llvm.store %33, %arg0 {alignment = 16 : i64} : !llvm.vec<? x 16 x  i8>, !llvm.ptr]

    %35 = llvm.getelementptr %arg0[%34] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 16 x  i8>
    llvm.store %33, %35 {alignment = 16 : i64} : !llvm.vec<? x 16 x  i8>, !llvm.ptr]

    llvm.return
  }]

def gep_alloca_inbounds_vscale_zero_before := [llvmfunc|
  llvm.func @gep_alloca_inbounds_vscale_zero() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.alloca %0 x !llvm.vec<? x 4 x  i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.getelementptr %3[%1, %2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %5 : i32
  }]

def gep_alloca_inbounds_vscale_nonzero_before := [llvmfunc|
  llvm.func @gep_alloca_inbounds_vscale_nonzero() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.alloca %0 x !llvm.vec<? x 4 x  i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.getelementptr %2[%0, %1] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %4 : i32
  }]

def gep_index_type_is_scalable_combined := [llvmfunc|
  llvm.func @gep_index_type_is_scalable(%arg0: !llvm.ptr) -> !llvm.vec<? x 2 x  ptr> {
    %0 = llvm.mlir.undef : !llvm.vec<? x 2 x  i64>
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, !llvm.vec<? x 2 x  i64>) -> !llvm.vec<? x 2 x  ptr>, i8
    llvm.return %1 : !llvm.vec<? x 2 x  ptr>
  }]

theorem inst_combine_gep_index_type_is_scalable   : gep_index_type_is_scalable_before  ⊑  gep_index_type_is_scalable_combined := by
  unfold gep_index_type_is_scalable_before gep_index_type_is_scalable_combined
  simp_alive_peephole
  sorry
def gep_num_of_indices_1_combined := [llvmfunc|
  llvm.func @gep_num_of_indices_1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_gep_num_of_indices_1   : gep_num_of_indices_1_before  ⊑  gep_num_of_indices_1_combined := by
  unfold gep_num_of_indices_1_before gep_num_of_indices_1_combined
  simp_alive_peephole
  sorry
def gep_bitcast_combined := [llvmfunc|
  llvm.func @gep_bitcast(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.undef : !llvm.vec<? x 16 x  i8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 16 x  i8>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 16 x  i8>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 16 x  i8>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 16 x  i8>
    %10 = llvm.mlir.constant(4 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : !llvm.vec<? x 16 x  i8>
    %12 = llvm.mlir.constant(5 : i32) : i32
    %13 = llvm.insertelement %0, %11[%12 : i32] : !llvm.vec<? x 16 x  i8>
    %14 = llvm.mlir.constant(6 : i32) : i32
    %15 = llvm.insertelement %0, %13[%14 : i32] : !llvm.vec<? x 16 x  i8>
    %16 = llvm.mlir.constant(7 : i32) : i32
    %17 = llvm.insertelement %0, %15[%16 : i32] : !llvm.vec<? x 16 x  i8>
    %18 = llvm.mlir.constant(8 : i32) : i32
    %19 = llvm.insertelement %0, %17[%18 : i32] : !llvm.vec<? x 16 x  i8>
    %20 = llvm.mlir.constant(9 : i32) : i32
    %21 = llvm.insertelement %0, %19[%20 : i32] : !llvm.vec<? x 16 x  i8>
    %22 = llvm.mlir.constant(10 : i32) : i32
    %23 = llvm.insertelement %0, %21[%22 : i32] : !llvm.vec<? x 16 x  i8>
    %24 = llvm.mlir.constant(11 : i32) : i32
    %25 = llvm.insertelement %0, %23[%24 : i32] : !llvm.vec<? x 16 x  i8>
    %26 = llvm.mlir.constant(12 : i32) : i32
    %27 = llvm.insertelement %0, %25[%26 : i32] : !llvm.vec<? x 16 x  i8>
    %28 = llvm.mlir.constant(13 : i32) : i32
    %29 = llvm.insertelement %0, %27[%28 : i32] : !llvm.vec<? x 16 x  i8>
    %30 = llvm.mlir.constant(14 : i32) : i32
    %31 = llvm.insertelement %0, %29[%30 : i32] : !llvm.vec<? x 16 x  i8>
    %32 = llvm.mlir.constant(15 : i32) : i32
    %33 = llvm.insertelement %0, %31[%32 : i32] : !llvm.vec<? x 16 x  i8>
    %34 = llvm.mlir.constant(1 : i64) : i64
    llvm.store %33, %arg0 {alignment = 16 : i64} : !llvm.vec<? x 16 x  i8>, !llvm.ptr
    %35 = llvm.getelementptr %arg0[%34] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 16 x  i8>
    llvm.store %33, %35 {alignment = 16 : i64} : !llvm.vec<? x 16 x  i8>, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_gep_bitcast   : gep_bitcast_before  ⊑  gep_bitcast_combined := by
  unfold gep_bitcast_before gep_bitcast_combined
  simp_alive_peephole
  sorry
def gep_alloca_inbounds_vscale_zero_combined := [llvmfunc|
  llvm.func @gep_alloca_inbounds_vscale_zero() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.alloca %0 x !llvm.vec<? x 4 x  i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %5 : i32
  }]

theorem inst_combine_gep_alloca_inbounds_vscale_zero   : gep_alloca_inbounds_vscale_zero_before  ⊑  gep_alloca_inbounds_vscale_zero_combined := by
  unfold gep_alloca_inbounds_vscale_zero_before gep_alloca_inbounds_vscale_zero_combined
  simp_alive_peephole
  sorry
def gep_alloca_inbounds_vscale_nonzero_combined := [llvmfunc|
  llvm.func @gep_alloca_inbounds_vscale_nonzero() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.alloca %0 x !llvm.vec<? x 4 x  i32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.getelementptr %3[%1, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %5 : i32
  }]

theorem inst_combine_gep_alloca_inbounds_vscale_nonzero   : gep_alloca_inbounds_vscale_nonzero_before  ⊑  gep_alloca_inbounds_vscale_nonzero_combined := by
  unfold gep_alloca_inbounds_vscale_nonzero_before gep_alloca_inbounds_vscale_nonzero_combined
  simp_alive_peephole
  sorry
