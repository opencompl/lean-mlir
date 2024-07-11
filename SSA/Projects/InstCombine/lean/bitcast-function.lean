import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bitcast-function
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bitcast_scalar_before := [llvmfunc|
  llvm.func @bitcast_scalar(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_i32 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> f32]

    %2 = llvm.call %0(%1) : !llvm.ptr, (f32) -> f32
    llvm.store %2, %arg1 {alignment = 8 : i64} : f32, !llvm.ptr]

    llvm.return
  }]

def bitcast_vector_before := [llvmfunc|
  llvm.func @bitcast_vector(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_v2i32 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<2xf32>]

    %2 = llvm.call %0(%1) : !llvm.ptr, (vector<2xf32>) -> vector<2xf32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<2xf32>, !llvm.ptr]

    llvm.return
  }]

def bitcast_vector_scalar_same_size_before := [llvmfunc|
  llvm.func @bitcast_vector_scalar_same_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_i64 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<2xf32>]

    %2 = llvm.call %0(%1) : !llvm.ptr, (vector<2xf32>) -> vector<2xf32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<2xf32>, !llvm.ptr]

    llvm.return
  }]

def bitcast_scalar_vector_same_size_before := [llvmfunc|
  llvm.func @bitcast_scalar_vector_same_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_v2f32 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

    %2 = llvm.call %0(%1) : !llvm.ptr, (i64) -> i64
    llvm.store %2, %arg1 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def bitcast_vector_ptrs_same_size_before := [llvmfunc|
  llvm.func @bitcast_vector_ptrs_same_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.vec<2 x ptr>]

    %1 = llvm.call @func_v2i32p(%0) : (!llvm.vec<2 x ptr>) -> !llvm.vec<2 x ptr>
    llvm.store %1, %arg1 {alignment = 8 : i64} : !llvm.vec<2 x ptr>, !llvm.ptr]

    llvm.return
  }]

def bitcast_mismatch_scalar_size_before := [llvmfunc|
  llvm.func @bitcast_mismatch_scalar_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_i64 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> f32]

    %2 = llvm.call %0(%1) : !llvm.ptr, (f32) -> f32
    llvm.store %2, %arg1 {alignment = 8 : i64} : f32, !llvm.ptr]

    llvm.return
  }]

def bitcast_mismatch_vector_element_and_bit_size_before := [llvmfunc|
  llvm.func @bitcast_mismatch_vector_element_and_bit_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_v2i64 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<2xf32>]

    %2 = llvm.call %0(%1) : !llvm.ptr, (vector<2xf32>) -> vector<2xf32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<2xf32>, !llvm.ptr]

    llvm.return
  }]

def bitcast_vector_mismatched_number_elements_before := [llvmfunc|
  llvm.func @bitcast_vector_mismatched_number_elements(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_v2i32 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<4xf32>]

    %2 = llvm.call %0(%1) : !llvm.ptr, (vector<4xf32>) -> vector<4xf32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<4xf32>, !llvm.ptr]

    llvm.return
  }]

def bitcast_vector_scalar_mismatched_bit_size_before := [llvmfunc|
  llvm.func @bitcast_vector_scalar_mismatched_bit_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_i64 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<4xf32>]

    %2 = llvm.call %0(%1) : !llvm.ptr, (vector<4xf32>) -> vector<4xf32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<4xf32>, !llvm.ptr]

    llvm.return
  }]

def bitcast_vector_ptrs_scalar_mismatched_bit_size_before := [llvmfunc|
  llvm.func @bitcast_vector_ptrs_scalar_mismatched_bit_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_i64 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.vec<4 x ptr>]

    %2 = llvm.call %0(%1) : !llvm.ptr, (!llvm.vec<4 x ptr>) -> !llvm.vec<4 x ptr>
    llvm.store %2, %arg1 {alignment = 8 : i64} : !llvm.vec<4 x ptr>, !llvm.ptr]

    llvm.return
  }]

def bitcast_scalar_vector_ptrs_same_size_before := [llvmfunc|
  llvm.func @bitcast_scalar_vector_ptrs_same_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_v2i32p : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

    %2 = llvm.call %0(%1) : !llvm.ptr, (i64) -> i64
    llvm.store %2, %arg1 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def bitcast_scalar_vector_mismatched_bit_size_before := [llvmfunc|
  llvm.func @bitcast_scalar_vector_mismatched_bit_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_v4f32 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

    %2 = llvm.call %0(%1) : !llvm.ptr, (i64) -> i64
    llvm.store %2, %arg1 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def bitcast_scalar_combined := [llvmfunc|
  llvm.func @bitcast_scalar(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i32]

theorem inst_combine_bitcast_scalar   : bitcast_scalar_before  ⊑  bitcast_scalar_combined := by
  unfold bitcast_scalar_before bitcast_scalar_combined
  simp_alive_peephole
  sorry
    %1 = llvm.call @func_i32(%0) : (i32) -> i32
    llvm.store %1, %arg1 {alignment = 8 : i64} : i32, !llvm.ptr]

theorem inst_combine_bitcast_scalar   : bitcast_scalar_before  ⊑  bitcast_scalar_combined := by
  unfold bitcast_scalar_before bitcast_scalar_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bitcast_scalar   : bitcast_scalar_before  ⊑  bitcast_scalar_combined := by
  unfold bitcast_scalar_before bitcast_scalar_combined
  simp_alive_peephole
  sorry
def bitcast_vector_combined := [llvmfunc|
  llvm.func @bitcast_vector(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<2xi32>]

theorem inst_combine_bitcast_vector   : bitcast_vector_before  ⊑  bitcast_vector_combined := by
  unfold bitcast_vector_before bitcast_vector_combined
  simp_alive_peephole
  sorry
    %1 = llvm.call @func_v2i32(%0) : (vector<2xi32>) -> vector<2xi32>
    llvm.store %1, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr]

theorem inst_combine_bitcast_vector   : bitcast_vector_before  ⊑  bitcast_vector_combined := by
  unfold bitcast_vector_before bitcast_vector_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bitcast_vector   : bitcast_vector_before  ⊑  bitcast_vector_combined := by
  unfold bitcast_vector_before bitcast_vector_combined
  simp_alive_peephole
  sorry
def bitcast_vector_scalar_same_size_combined := [llvmfunc|
  llvm.func @bitcast_vector_scalar_same_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

theorem inst_combine_bitcast_vector_scalar_same_size   : bitcast_vector_scalar_same_size_before  ⊑  bitcast_vector_scalar_same_size_combined := by
  unfold bitcast_vector_scalar_same_size_before bitcast_vector_scalar_same_size_combined
  simp_alive_peephole
  sorry
    %1 = llvm.call @func_i64(%0) : (i64) -> i64
    llvm.store %1, %arg1 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_bitcast_vector_scalar_same_size   : bitcast_vector_scalar_same_size_before  ⊑  bitcast_vector_scalar_same_size_combined := by
  unfold bitcast_vector_scalar_same_size_before bitcast_vector_scalar_same_size_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bitcast_vector_scalar_same_size   : bitcast_vector_scalar_same_size_before  ⊑  bitcast_vector_scalar_same_size_combined := by
  unfold bitcast_vector_scalar_same_size_before bitcast_vector_scalar_same_size_combined
  simp_alive_peephole
  sorry
def bitcast_scalar_vector_same_size_combined := [llvmfunc|
  llvm.func @bitcast_scalar_vector_same_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<2xf32>]

theorem inst_combine_bitcast_scalar_vector_same_size   : bitcast_scalar_vector_same_size_before  ⊑  bitcast_scalar_vector_same_size_combined := by
  unfold bitcast_scalar_vector_same_size_before bitcast_scalar_vector_same_size_combined
  simp_alive_peephole
  sorry
    %1 = llvm.call @func_v2f32(%0) : (vector<2xf32>) -> vector<2xf32>
    llvm.store %1, %arg1 {alignment = 8 : i64} : vector<2xf32>, !llvm.ptr]

theorem inst_combine_bitcast_scalar_vector_same_size   : bitcast_scalar_vector_same_size_before  ⊑  bitcast_scalar_vector_same_size_combined := by
  unfold bitcast_scalar_vector_same_size_before bitcast_scalar_vector_same_size_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bitcast_scalar_vector_same_size   : bitcast_scalar_vector_same_size_before  ⊑  bitcast_scalar_vector_same_size_combined := by
  unfold bitcast_scalar_vector_same_size_before bitcast_scalar_vector_same_size_combined
  simp_alive_peephole
  sorry
def bitcast_vector_ptrs_same_size_combined := [llvmfunc|
  llvm.func @bitcast_vector_ptrs_same_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.vec<2 x ptr>]

theorem inst_combine_bitcast_vector_ptrs_same_size   : bitcast_vector_ptrs_same_size_before  ⊑  bitcast_vector_ptrs_same_size_combined := by
  unfold bitcast_vector_ptrs_same_size_before bitcast_vector_ptrs_same_size_combined
  simp_alive_peephole
  sorry
    %1 = llvm.call @func_v2i32p(%0) : (!llvm.vec<2 x ptr>) -> !llvm.vec<2 x ptr>
    llvm.store %1, %arg1 {alignment = 8 : i64} : !llvm.vec<2 x ptr>, !llvm.ptr]

theorem inst_combine_bitcast_vector_ptrs_same_size   : bitcast_vector_ptrs_same_size_before  ⊑  bitcast_vector_ptrs_same_size_combined := by
  unfold bitcast_vector_ptrs_same_size_before bitcast_vector_ptrs_same_size_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bitcast_vector_ptrs_same_size   : bitcast_vector_ptrs_same_size_before  ⊑  bitcast_vector_ptrs_same_size_combined := by
  unfold bitcast_vector_ptrs_same_size_before bitcast_vector_ptrs_same_size_combined
  simp_alive_peephole
  sorry
def bitcast_mismatch_scalar_size_combined := [llvmfunc|
  llvm.func @bitcast_mismatch_scalar_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_i64 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> f32]

theorem inst_combine_bitcast_mismatch_scalar_size   : bitcast_mismatch_scalar_size_before  ⊑  bitcast_mismatch_scalar_size_combined := by
  unfold bitcast_mismatch_scalar_size_before bitcast_mismatch_scalar_size_combined
  simp_alive_peephole
  sorry
    %2 = llvm.call %0(%1) : !llvm.ptr, (f32) -> f32
    llvm.store %2, %arg1 {alignment = 8 : i64} : f32, !llvm.ptr]

theorem inst_combine_bitcast_mismatch_scalar_size   : bitcast_mismatch_scalar_size_before  ⊑  bitcast_mismatch_scalar_size_combined := by
  unfold bitcast_mismatch_scalar_size_before bitcast_mismatch_scalar_size_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bitcast_mismatch_scalar_size   : bitcast_mismatch_scalar_size_before  ⊑  bitcast_mismatch_scalar_size_combined := by
  unfold bitcast_mismatch_scalar_size_before bitcast_mismatch_scalar_size_combined
  simp_alive_peephole
  sorry
def bitcast_mismatch_vector_element_and_bit_size_combined := [llvmfunc|
  llvm.func @bitcast_mismatch_vector_element_and_bit_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_v2i64 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<2xf32>]

theorem inst_combine_bitcast_mismatch_vector_element_and_bit_size   : bitcast_mismatch_vector_element_and_bit_size_before  ⊑  bitcast_mismatch_vector_element_and_bit_size_combined := by
  unfold bitcast_mismatch_vector_element_and_bit_size_before bitcast_mismatch_vector_element_and_bit_size_combined
  simp_alive_peephole
  sorry
    %2 = llvm.call %0(%1) : !llvm.ptr, (vector<2xf32>) -> vector<2xf32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<2xf32>, !llvm.ptr]

theorem inst_combine_bitcast_mismatch_vector_element_and_bit_size   : bitcast_mismatch_vector_element_and_bit_size_before  ⊑  bitcast_mismatch_vector_element_and_bit_size_combined := by
  unfold bitcast_mismatch_vector_element_and_bit_size_before bitcast_mismatch_vector_element_and_bit_size_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bitcast_mismatch_vector_element_and_bit_size   : bitcast_mismatch_vector_element_and_bit_size_before  ⊑  bitcast_mismatch_vector_element_and_bit_size_combined := by
  unfold bitcast_mismatch_vector_element_and_bit_size_before bitcast_mismatch_vector_element_and_bit_size_combined
  simp_alive_peephole
  sorry
def bitcast_vector_mismatched_number_elements_combined := [llvmfunc|
  llvm.func @bitcast_vector_mismatched_number_elements(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_v2i32 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<4xf32>]

theorem inst_combine_bitcast_vector_mismatched_number_elements   : bitcast_vector_mismatched_number_elements_before  ⊑  bitcast_vector_mismatched_number_elements_combined := by
  unfold bitcast_vector_mismatched_number_elements_before bitcast_vector_mismatched_number_elements_combined
  simp_alive_peephole
  sorry
    %2 = llvm.call %0(%1) : !llvm.ptr, (vector<4xf32>) -> vector<4xf32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<4xf32>, !llvm.ptr]

theorem inst_combine_bitcast_vector_mismatched_number_elements   : bitcast_vector_mismatched_number_elements_before  ⊑  bitcast_vector_mismatched_number_elements_combined := by
  unfold bitcast_vector_mismatched_number_elements_before bitcast_vector_mismatched_number_elements_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bitcast_vector_mismatched_number_elements   : bitcast_vector_mismatched_number_elements_before  ⊑  bitcast_vector_mismatched_number_elements_combined := by
  unfold bitcast_vector_mismatched_number_elements_before bitcast_vector_mismatched_number_elements_combined
  simp_alive_peephole
  sorry
def bitcast_vector_scalar_mismatched_bit_size_combined := [llvmfunc|
  llvm.func @bitcast_vector_scalar_mismatched_bit_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_i64 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<4xf32>]

theorem inst_combine_bitcast_vector_scalar_mismatched_bit_size   : bitcast_vector_scalar_mismatched_bit_size_before  ⊑  bitcast_vector_scalar_mismatched_bit_size_combined := by
  unfold bitcast_vector_scalar_mismatched_bit_size_before bitcast_vector_scalar_mismatched_bit_size_combined
  simp_alive_peephole
  sorry
    %2 = llvm.call %0(%1) : !llvm.ptr, (vector<4xf32>) -> vector<4xf32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<4xf32>, !llvm.ptr]

theorem inst_combine_bitcast_vector_scalar_mismatched_bit_size   : bitcast_vector_scalar_mismatched_bit_size_before  ⊑  bitcast_vector_scalar_mismatched_bit_size_combined := by
  unfold bitcast_vector_scalar_mismatched_bit_size_before bitcast_vector_scalar_mismatched_bit_size_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bitcast_vector_scalar_mismatched_bit_size   : bitcast_vector_scalar_mismatched_bit_size_before  ⊑  bitcast_vector_scalar_mismatched_bit_size_combined := by
  unfold bitcast_vector_scalar_mismatched_bit_size_before bitcast_vector_scalar_mismatched_bit_size_combined
  simp_alive_peephole
  sorry
def bitcast_vector_ptrs_scalar_mismatched_bit_size_combined := [llvmfunc|
  llvm.func @bitcast_vector_ptrs_scalar_mismatched_bit_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_i64 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.vec<4 x ptr>]

theorem inst_combine_bitcast_vector_ptrs_scalar_mismatched_bit_size   : bitcast_vector_ptrs_scalar_mismatched_bit_size_before  ⊑  bitcast_vector_ptrs_scalar_mismatched_bit_size_combined := by
  unfold bitcast_vector_ptrs_scalar_mismatched_bit_size_before bitcast_vector_ptrs_scalar_mismatched_bit_size_combined
  simp_alive_peephole
  sorry
    %2 = llvm.call %0(%1) : !llvm.ptr, (!llvm.vec<4 x ptr>) -> !llvm.vec<4 x ptr>
    llvm.store %2, %arg1 {alignment = 8 : i64} : !llvm.vec<4 x ptr>, !llvm.ptr]

theorem inst_combine_bitcast_vector_ptrs_scalar_mismatched_bit_size   : bitcast_vector_ptrs_scalar_mismatched_bit_size_before  ⊑  bitcast_vector_ptrs_scalar_mismatched_bit_size_combined := by
  unfold bitcast_vector_ptrs_scalar_mismatched_bit_size_before bitcast_vector_ptrs_scalar_mismatched_bit_size_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bitcast_vector_ptrs_scalar_mismatched_bit_size   : bitcast_vector_ptrs_scalar_mismatched_bit_size_before  ⊑  bitcast_vector_ptrs_scalar_mismatched_bit_size_combined := by
  unfold bitcast_vector_ptrs_scalar_mismatched_bit_size_before bitcast_vector_ptrs_scalar_mismatched_bit_size_combined
  simp_alive_peephole
  sorry
def bitcast_scalar_vector_ptrs_same_size_combined := [llvmfunc|
  llvm.func @bitcast_scalar_vector_ptrs_same_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_v2i32p : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

theorem inst_combine_bitcast_scalar_vector_ptrs_same_size   : bitcast_scalar_vector_ptrs_same_size_before  ⊑  bitcast_scalar_vector_ptrs_same_size_combined := by
  unfold bitcast_scalar_vector_ptrs_same_size_before bitcast_scalar_vector_ptrs_same_size_combined
  simp_alive_peephole
  sorry
    %2 = llvm.call %0(%1) : !llvm.ptr, (i64) -> i64
    llvm.store %2, %arg1 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_bitcast_scalar_vector_ptrs_same_size   : bitcast_scalar_vector_ptrs_same_size_before  ⊑  bitcast_scalar_vector_ptrs_same_size_combined := by
  unfold bitcast_scalar_vector_ptrs_same_size_before bitcast_scalar_vector_ptrs_same_size_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bitcast_scalar_vector_ptrs_same_size   : bitcast_scalar_vector_ptrs_same_size_before  ⊑  bitcast_scalar_vector_ptrs_same_size_combined := by
  unfold bitcast_scalar_vector_ptrs_same_size_before bitcast_scalar_vector_ptrs_same_size_combined
  simp_alive_peephole
  sorry
def bitcast_scalar_vector_mismatched_bit_size_combined := [llvmfunc|
  llvm.func @bitcast_scalar_vector_mismatched_bit_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_v4f32 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

theorem inst_combine_bitcast_scalar_vector_mismatched_bit_size   : bitcast_scalar_vector_mismatched_bit_size_before  ⊑  bitcast_scalar_vector_mismatched_bit_size_combined := by
  unfold bitcast_scalar_vector_mismatched_bit_size_before bitcast_scalar_vector_mismatched_bit_size_combined
  simp_alive_peephole
  sorry
    %2 = llvm.call %0(%1) : !llvm.ptr, (i64) -> i64
    llvm.store %2, %arg1 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_bitcast_scalar_vector_mismatched_bit_size   : bitcast_scalar_vector_mismatched_bit_size_before  ⊑  bitcast_scalar_vector_mismatched_bit_size_combined := by
  unfold bitcast_scalar_vector_mismatched_bit_size_before bitcast_scalar_vector_mismatched_bit_size_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bitcast_scalar_vector_mismatched_bit_size   : bitcast_scalar_vector_mismatched_bit_size_before  ⊑  bitcast_scalar_vector_mismatched_bit_size_combined := by
  unfold bitcast_scalar_vector_mismatched_bit_size_before bitcast_scalar_vector_mismatched_bit_size_combined
  simp_alive_peephole
  sorry
