import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  binop-cast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def testAdd_before := [llvmfunc|
  llvm.func @testAdd(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    %1 = llvm.bitcast %0 : i32 to i32
    llvm.return %1 : i32
  }]

def and_sext_to_sel_before := [llvmfunc|
  llvm.func @and_sext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    %1 = llvm.and %0, %arg0  : i32
    llvm.return %1 : i32
  }]

def and_sext_to_sel_constant_vec_before := [llvmfunc|
  llvm.func @and_sext_to_sel_constant_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, -7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.and %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def and_sext_to_sel_swap_before := [llvmfunc|
  llvm.func @and_sext_to_sel_swap(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %1 = llvm.sext %arg1 : vector<2xi1> to vector<2xi32>
    %2 = llvm.and %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def and_sext_to_sel_multi_use_before := [llvmfunc|
  llvm.func @and_sext_to_sel_multi_use(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.and %0, %arg0  : i32
    llvm.return %1 : i32
  }]

def and_sext_to_sel_multi_use_constant_mask_before := [llvmfunc|
  llvm.func @and_sext_to_sel_multi_use_constant_mask(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

def and_not_sext_to_sel_before := [llvmfunc|
  llvm.func @and_not_sext_to_sel(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg1 : vector<2xi1> to vector<2xi32>
    llvm.call @use_vec(%1) : (vector<2xi32>) -> ()
    %2 = llvm.xor %1, %0  : vector<2xi32>
    %3 = llvm.and %2, %arg0  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def and_not_sext_to_sel_commute_before := [llvmfunc|
  llvm.func @and_not_sext_to_sel_commute(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg0, %arg0  : i32
    %2 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.xor %2, %0  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }]

def and_xor_sext_to_sel_before := [llvmfunc|
  llvm.func @and_xor_sext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def and_not_zext_to_sel_before := [llvmfunc|
  llvm.func @and_not_zext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def or_sext_to_sel_before := [llvmfunc|
  llvm.func @or_sext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    %1 = llvm.or %0, %arg0  : i32
    llvm.return %1 : i32
  }]

def or_sext_to_sel_constant_vec_before := [llvmfunc|
  llvm.func @or_sext_to_sel_constant_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, -7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.or %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def or_sext_to_sel_swap_before := [llvmfunc|
  llvm.func @or_sext_to_sel_swap(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %1 = llvm.sext %arg1 : vector<2xi1> to vector<2xi32>
    %2 = llvm.or %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def or_sext_to_sel_multi_use_before := [llvmfunc|
  llvm.func @or_sext_to_sel_multi_use(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.or %0, %arg0  : i32
    llvm.return %1 : i32
  }]

def or_sext_to_sel_multi_use_constant_mask_before := [llvmfunc|
  llvm.func @or_sext_to_sel_multi_use_constant_mask(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }]

def xor_sext_to_sel_before := [llvmfunc|
  llvm.func @xor_sext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    %1 = llvm.xor %0, %arg0  : i32
    llvm.return %1 : i32
  }]

def xor_sext_to_sel_constant_vec_before := [llvmfunc|
  llvm.func @xor_sext_to_sel_constant_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, -7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.xor %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def xor_sext_to_sel_swap_before := [llvmfunc|
  llvm.func @xor_sext_to_sel_swap(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %1 = llvm.sext %arg1 : vector<2xi1> to vector<2xi32>
    %2 = llvm.xor %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def xor_sext_to_sel_multi_use_before := [llvmfunc|
  llvm.func @xor_sext_to_sel_multi_use(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.xor %0, %arg0  : i32
    llvm.return %1 : i32
  }]

def xor_sext_to_sel_multi_use_constant_mask_before := [llvmfunc|
  llvm.func @xor_sext_to_sel_multi_use_constant_mask(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

def PR63321_before := [llvmfunc|
  llvm.func @PR63321(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %2 = llvm.zext %1 : i8 to i64
    %3 = llvm.add %0, %2  : i64
    %4 = llvm.and %3, %arg1  : i64
    llvm.return %4 : i64
  }]

def and_add_non_bool_before := [llvmfunc|
  llvm.func @and_add_non_bool(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %2 = llvm.zext %1 : i8 to i64
    %3 = llvm.add %0, %2  : i64
    %4 = llvm.and %3, %arg1  : i64
    llvm.return %4 : i64
  }]

def and_add_bool_to_select_before := [llvmfunc|
  llvm.func @and_add_bool_to_select(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.add %0, %1  : i32
    %3 = llvm.and %2, %arg1  : i32
    llvm.return %3 : i32
  }]

def and_add_bool_no_fold_before := [llvmfunc|
  llvm.func @and_add_bool_no_fold(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.and %3, %arg0  : i32
    llvm.return %4 : i32
  }]

def and_add_bool_vec_to_select_before := [llvmfunc|
  llvm.func @and_add_bool_vec_to_select(%arg0: vector<2xi1>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.add %0, %1  : vector<2xi32>
    %3 = llvm.and %2, %arg1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def and_add_bool_to_select_multi_use_before := [llvmfunc|
  llvm.func @and_add_bool_to_select_multi_use(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.add %0, %1  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }]

def testAdd_combined := [llvmfunc|
  llvm.func @testAdd(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_testAdd   : testAdd_before  ⊑  testAdd_combined := by
  unfold testAdd_before testAdd_combined
  simp_alive_peephole
  sorry
def and_sext_to_sel_combined := [llvmfunc|
  llvm.func @and_sext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.select %arg1, %arg0, %0 : i1, i32
    llvm.return %1 : i32
  }]

theorem inst_combine_and_sext_to_sel   : and_sext_to_sel_before  ⊑  and_sext_to_sel_combined := by
  unfold and_sext_to_sel_before and_sext_to_sel_combined
  simp_alive_peephole
  sorry
def and_sext_to_sel_constant_vec_combined := [llvmfunc|
  llvm.func @and_sext_to_sel_constant_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, -7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_and_sext_to_sel_constant_vec   : and_sext_to_sel_constant_vec_before  ⊑  and_sext_to_sel_constant_vec_combined := by
  unfold and_sext_to_sel_constant_vec_before and_sext_to_sel_constant_vec_combined
  simp_alive_peephole
  sorry
def and_sext_to_sel_swap_combined := [llvmfunc|
  llvm.func @and_sext_to_sel_swap(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %3 = llvm.select %arg1, %2, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_and_sext_to_sel_swap   : and_sext_to_sel_swap_before  ⊑  and_sext_to_sel_swap_combined := by
  unfold and_sext_to_sel_swap_before and_sext_to_sel_swap_combined
  simp_alive_peephole
  sorry
def and_sext_to_sel_multi_use_combined := [llvmfunc|
  llvm.func @and_sext_to_sel_multi_use(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.and %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_and_sext_to_sel_multi_use   : and_sext_to_sel_multi_use_before  ⊑  and_sext_to_sel_multi_use_combined := by
  unfold and_sext_to_sel_multi_use_before and_sext_to_sel_multi_use_combined
  simp_alive_peephole
  sorry
def and_sext_to_sel_multi_use_constant_mask_combined := [llvmfunc|
  llvm.func @and_sext_to_sel_multi_use_constant_mask(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_sext_to_sel_multi_use_constant_mask   : and_sext_to_sel_multi_use_constant_mask_before  ⊑  and_sext_to_sel_multi_use_constant_mask_combined := by
  unfold and_sext_to_sel_multi_use_constant_mask_before and_sext_to_sel_multi_use_constant_mask_combined
  simp_alive_peephole
  sorry
def and_not_sext_to_sel_combined := [llvmfunc|
  llvm.func @and_not_sext_to_sel(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sext %arg1 : vector<2xi1> to vector<2xi32>
    llvm.call @use_vec(%2) : (vector<2xi32>) -> ()
    %3 = llvm.select %arg1, %1, %arg0 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_and_not_sext_to_sel   : and_not_sext_to_sel_before  ⊑  and_not_sext_to_sel_combined := by
  unfold and_not_sext_to_sel_before and_not_sext_to_sel_combined
  simp_alive_peephole
  sorry
def and_not_sext_to_sel_commute_combined := [llvmfunc|
  llvm.func @and_not_sext_to_sel_commute(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mul %arg0, %arg0  : i32
    %3 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.xor %3, %0  : i32
    llvm.call @use(%4) : (i32) -> ()
    %5 = llvm.select %arg1, %1, %2 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_and_not_sext_to_sel_commute   : and_not_sext_to_sel_commute_before  ⊑  and_not_sext_to_sel_commute_combined := by
  unfold and_not_sext_to_sel_commute_before and_not_sext_to_sel_commute_combined
  simp_alive_peephole
  sorry
def and_xor_sext_to_sel_combined := [llvmfunc|
  llvm.func @and_xor_sext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_xor_sext_to_sel   : and_xor_sext_to_sel_before  ⊑  and_xor_sext_to_sel_combined := by
  unfold and_xor_sext_to_sel_before and_xor_sext_to_sel_combined
  simp_alive_peephole
  sorry
def and_not_zext_to_sel_combined := [llvmfunc|
  llvm.func @and_not_zext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_and_not_zext_to_sel   : and_not_zext_to_sel_before  ⊑  and_not_zext_to_sel_combined := by
  unfold and_not_zext_to_sel_before and_not_zext_to_sel_combined
  simp_alive_peephole
  sorry
def or_sext_to_sel_combined := [llvmfunc|
  llvm.func @or_sext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.select %arg1, %0, %arg0 : i1, i32
    llvm.return %1 : i32
  }]

theorem inst_combine_or_sext_to_sel   : or_sext_to_sel_before  ⊑  or_sext_to_sel_combined := by
  unfold or_sext_to_sel_before or_sext_to_sel_combined
  simp_alive_peephole
  sorry
def or_sext_to_sel_constant_vec_combined := [llvmfunc|
  llvm.func @or_sext_to_sel_constant_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[42, -7]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_or_sext_to_sel_constant_vec   : or_sext_to_sel_constant_vec_before  ⊑  or_sext_to_sel_constant_vec_combined := by
  unfold or_sext_to_sel_constant_vec_before or_sext_to_sel_constant_vec_combined
  simp_alive_peephole
  sorry
def or_sext_to_sel_swap_combined := [llvmfunc|
  llvm.func @or_sext_to_sel_swap(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %2 = llvm.select %arg1, %0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_or_sext_to_sel_swap   : or_sext_to_sel_swap_before  ⊑  or_sext_to_sel_swap_combined := by
  unfold or_sext_to_sel_swap_before or_sext_to_sel_swap_combined
  simp_alive_peephole
  sorry
def or_sext_to_sel_multi_use_combined := [llvmfunc|
  llvm.func @or_sext_to_sel_multi_use(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.or %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_or_sext_to_sel_multi_use   : or_sext_to_sel_multi_use_before  ⊑  or_sext_to_sel_multi_use_combined := by
  unfold or_sext_to_sel_multi_use_before or_sext_to_sel_multi_use_combined
  simp_alive_peephole
  sorry
def or_sext_to_sel_multi_use_constant_mask_combined := [llvmfunc|
  llvm.func @or_sext_to_sel_multi_use_constant_mask(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_or_sext_to_sel_multi_use_constant_mask   : or_sext_to_sel_multi_use_constant_mask_before  ⊑  or_sext_to_sel_multi_use_constant_mask_combined := by
  unfold or_sext_to_sel_multi_use_constant_mask_before or_sext_to_sel_multi_use_constant_mask_combined
  simp_alive_peephole
  sorry
def xor_sext_to_sel_combined := [llvmfunc|
  llvm.func @xor_sext_to_sel(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    %1 = llvm.xor %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_xor_sext_to_sel   : xor_sext_to_sel_before  ⊑  xor_sext_to_sel_combined := by
  unfold xor_sext_to_sel_before xor_sext_to_sel_combined
  simp_alive_peephole
  sorry
def xor_sext_to_sel_constant_vec_combined := [llvmfunc|
  llvm.func @xor_sext_to_sel_constant_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, -7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_xor_sext_to_sel_constant_vec   : xor_sext_to_sel_constant_vec_before  ⊑  xor_sext_to_sel_constant_vec_combined := by
  unfold xor_sext_to_sel_constant_vec_before xor_sext_to_sel_constant_vec_combined
  simp_alive_peephole
  sorry
def xor_sext_to_sel_swap_combined := [llvmfunc|
  llvm.func @xor_sext_to_sel_swap(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mul %arg0, %arg0  : vector<2xi32>
    %1 = llvm.sext %arg1 : vector<2xi1> to vector<2xi32>
    %2 = llvm.xor %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_xor_sext_to_sel_swap   : xor_sext_to_sel_swap_before  ⊑  xor_sext_to_sel_swap_combined := by
  unfold xor_sext_to_sel_swap_before xor_sext_to_sel_swap_combined
  simp_alive_peephole
  sorry
def xor_sext_to_sel_multi_use_combined := [llvmfunc|
  llvm.func @xor_sext_to_sel_multi_use(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.sext %arg1 : i1 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.xor %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_xor_sext_to_sel_multi_use   : xor_sext_to_sel_multi_use_before  ⊑  xor_sext_to_sel_multi_use_combined := by
  unfold xor_sext_to_sel_multi_use_before xor_sext_to_sel_multi_use_combined
  simp_alive_peephole
  sorry
def xor_sext_to_sel_multi_use_constant_mask_combined := [llvmfunc|
  llvm.func @xor_sext_to_sel_multi_use_constant_mask(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_xor_sext_to_sel_multi_use_constant_mask   : xor_sext_to_sel_multi_use_constant_mask_before  ⊑  xor_sext_to_sel_multi_use_constant_mask_combined := by
  unfold xor_sext_to_sel_multi_use_constant_mask_before xor_sext_to_sel_multi_use_constant_mask_combined
  simp_alive_peephole
  sorry
def PR63321_combined := [llvmfunc|
  llvm.func @PR63321(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %3 = llvm.icmp "eq" %2, %0 : i8
    %4 = llvm.select %3, %arg1, %1 : i1, i64
    llvm.return %4 : i64
  }]

theorem inst_combine_PR63321   : PR63321_before  ⊑  PR63321_combined := by
  unfold PR63321_before PR63321_combined
  simp_alive_peephole
  sorry
def and_add_non_bool_combined := [llvmfunc|
  llvm.func @and_add_non_bool(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %2 = llvm.zext %1 : i8 to i64
    %3 = llvm.add %2, %0 overflow<nsw>  : i64
    %4 = llvm.and %3, %arg1  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_and_add_non_bool   : and_add_non_bool_before  ⊑  and_add_non_bool_combined := by
  unfold and_add_non_bool_before and_add_non_bool_combined
  simp_alive_peephole
  sorry
def and_add_bool_to_select_combined := [llvmfunc|
  llvm.func @and_add_bool_to_select(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.select %arg0, %0, %arg1 : i1, i32
    llvm.return %1 : i32
  }]

theorem inst_combine_and_add_bool_to_select   : and_add_bool_to_select_before  ⊑  and_add_bool_to_select_combined := by
  unfold and_add_bool_to_select_before and_add_bool_to_select_combined
  simp_alive_peephole
  sorry
def and_add_bool_no_fold_combined := [llvmfunc|
  llvm.func @and_add_bool_no_fold(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.select %3, %arg0, %1 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_and_add_bool_no_fold   : and_add_bool_no_fold_before  ⊑  and_add_bool_no_fold_combined := by
  unfold and_add_bool_no_fold_before and_add_bool_no_fold_combined
  simp_alive_peephole
  sorry
def and_add_bool_vec_to_select_combined := [llvmfunc|
  llvm.func @and_add_bool_vec_to_select(%arg0: vector<2xi1>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.select %arg0, %1, %arg1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_and_add_bool_vec_to_select   : and_add_bool_vec_to_select_before  ⊑  and_add_bool_vec_to_select_combined := by
  unfold and_add_bool_vec_to_select_before and_add_bool_vec_to_select_combined
  simp_alive_peephole
  sorry
def and_add_bool_to_select_multi_use_combined := [llvmfunc|
  llvm.func @and_add_bool_to_select_multi_use(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.sext %1 : i1 to i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_and_add_bool_to_select_multi_use   : and_add_bool_to_select_multi_use_before  ⊑  and_add_bool_to_select_multi_use_combined := by
  unfold and_add_bool_to_select_multi_use_before and_add_bool_to_select_multi_use_combined
  simp_alive_peephole
  sorry
