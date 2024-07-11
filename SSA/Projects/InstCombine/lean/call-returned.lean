import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  call-returned
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def returned_const_int_arg_before := [llvmfunc|
  llvm.func @returned_const_int_arg() -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.call @passthru_i32(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def returned_const_ptr_arg_before := [llvmfunc|
  llvm.func @returned_const_ptr_arg() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.call @passthru_p8(%0) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def returned_const_ptr_arg_casted_before := [llvmfunc|
  llvm.func @returned_const_ptr_arg_casted() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.call @passthru_p8_from_p32(%0) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def returned_ptr_arg_casted_before := [llvmfunc|
  llvm.func @returned_ptr_arg_casted(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.call @passthru_p8_from_p32(%arg0) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def returned_const_vec_arg_casted_before := [llvmfunc|
  llvm.func @returned_const_vec_arg_casted() -> vector<8xi8> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @GV : !llvm.ptr
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> vector<2xi32>]

    %4 = llvm.call @passthru_8i8v_from_2i32v(%3) : (vector<2xi32>) -> vector<8xi8>
    llvm.return %4 : vector<8xi8>
  }]

def returned_vec_arg_casted_before := [llvmfunc|
  llvm.func @returned_vec_arg_casted(%arg0: vector<2xi32>) -> vector<8xi8> {
    %0 = llvm.call @passthru_8i8v_from_2i32v(%arg0) : (vector<2xi32>) -> vector<8xi8>
    llvm.return %0 : vector<8xi8>
  }]

def returned_var_arg_before := [llvmfunc|
  llvm.func @returned_var_arg(%arg0: i32) -> i32 {
    %0 = llvm.call @passthru_i32(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

def returned_const_int_arg_musttail_before := [llvmfunc|
  llvm.func @returned_const_int_arg_musttail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.call @passthru_i32(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def returned_var_arg_musttail_before := [llvmfunc|
  llvm.func @returned_var_arg_musttail(%arg0: i32) -> i32 {
    %0 = llvm.call @passthru_i32(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

def returned_const_int_arg_combined := [llvmfunc|
  llvm.func @returned_const_int_arg() -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.call @passthru_i32(%0) : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_returned_const_int_arg   : returned_const_int_arg_before  ⊑  returned_const_int_arg_combined := by
  unfold returned_const_int_arg_before returned_const_int_arg_combined
  simp_alive_peephole
  sorry
def returned_const_ptr_arg_combined := [llvmfunc|
  llvm.func @returned_const_ptr_arg() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.call @passthru_p8(%0) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_returned_const_ptr_arg   : returned_const_ptr_arg_before  ⊑  returned_const_ptr_arg_combined := by
  unfold returned_const_ptr_arg_before returned_const_ptr_arg_combined
  simp_alive_peephole
  sorry
def returned_const_ptr_arg_casted_combined := [llvmfunc|
  llvm.func @returned_const_ptr_arg_casted() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.call @passthru_p8_from_p32(%0) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_returned_const_ptr_arg_casted   : returned_const_ptr_arg_casted_before  ⊑  returned_const_ptr_arg_casted_combined := by
  unfold returned_const_ptr_arg_casted_before returned_const_ptr_arg_casted_combined
  simp_alive_peephole
  sorry
def returned_ptr_arg_casted_combined := [llvmfunc|
  llvm.func @returned_ptr_arg_casted(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.call @passthru_p8_from_p32(%arg0) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_returned_ptr_arg_casted   : returned_ptr_arg_casted_before  ⊑  returned_ptr_arg_casted_combined := by
  unfold returned_ptr_arg_casted_before returned_ptr_arg_casted_combined
  simp_alive_peephole
  sorry
def returned_const_vec_arg_casted_combined := [llvmfunc|
  llvm.func @returned_const_vec_arg_casted() -> vector<8xi8> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : vector<8xi8>) : vector<8xi8>
    %4 = llvm.call @passthru_8i8v_from_2i32v(%1) : (vector<2xi32>) -> vector<8xi8>
    llvm.return %3 : vector<8xi8>
  }]

theorem inst_combine_returned_const_vec_arg_casted   : returned_const_vec_arg_casted_before  ⊑  returned_const_vec_arg_casted_combined := by
  unfold returned_const_vec_arg_casted_before returned_const_vec_arg_casted_combined
  simp_alive_peephole
  sorry
def returned_vec_arg_casted_combined := [llvmfunc|
  llvm.func @returned_vec_arg_casted(%arg0: vector<2xi32>) -> vector<8xi8> {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to vector<8xi8>
    %1 = llvm.call @passthru_8i8v_from_2i32v(%arg0) : (vector<2xi32>) -> vector<8xi8>
    llvm.return %0 : vector<8xi8>
  }]

theorem inst_combine_returned_vec_arg_casted   : returned_vec_arg_casted_before  ⊑  returned_vec_arg_casted_combined := by
  unfold returned_vec_arg_casted_before returned_vec_arg_casted_combined
  simp_alive_peephole
  sorry
def returned_var_arg_combined := [llvmfunc|
  llvm.func @returned_var_arg(%arg0: i32) -> i32 {
    %0 = llvm.call @passthru_i32(%arg0) : (i32) -> i32
    llvm.return %arg0 : i32
  }]

theorem inst_combine_returned_var_arg   : returned_var_arg_before  ⊑  returned_var_arg_combined := by
  unfold returned_var_arg_before returned_var_arg_combined
  simp_alive_peephole
  sorry
def returned_const_int_arg_musttail_combined := [llvmfunc|
  llvm.func @returned_const_int_arg_musttail(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.call @passthru_i32(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_returned_const_int_arg_musttail   : returned_const_int_arg_musttail_before  ⊑  returned_const_int_arg_musttail_combined := by
  unfold returned_const_int_arg_musttail_before returned_const_int_arg_musttail_combined
  simp_alive_peephole
  sorry
def returned_var_arg_musttail_combined := [llvmfunc|
  llvm.func @returned_var_arg_musttail(%arg0: i32) -> i32 {
    %0 = llvm.call @passthru_i32(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_returned_var_arg_musttail   : returned_var_arg_musttail_before  ⊑  returned_var_arg_musttail_combined := by
  unfold returned_var_arg_musttail_before returned_var_arg_musttail_combined
  simp_alive_peephole
  sorry
