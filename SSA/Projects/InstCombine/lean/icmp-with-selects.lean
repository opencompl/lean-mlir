import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-with-selects
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def both_sides_fold_slt_before := [llvmfunc|
  llvm.func @both_sides_fold_slt(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.select %arg1, %0, %arg0 : i1, i32
    %3 = llvm.select %arg1, %1, %arg0 : i1, i32
    %4 = llvm.icmp "slt" %3, %2 : i32
    llvm.return %4 : i1
  }]

def both_sides_fold_eq_before := [llvmfunc|
  llvm.func @both_sides_fold_eq(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.select %arg1, %0, %arg0 : i1, i32
    %3 = llvm.select %arg1, %1, %arg0 : i1, i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    llvm.return %4 : i1
  }]

def one_side_fold_slt_before := [llvmfunc|
  llvm.func @one_side_fold_slt(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.select %arg3, %arg0, %arg2 : i1, i32
    %1 = llvm.select %arg3, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def one_side_fold_sgt_before := [llvmfunc|
  llvm.func @one_side_fold_sgt(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.select %arg3, %arg2, %arg0 : i1, i32
    %1 = llvm.select %arg3, %arg2, %arg1 : i1, i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def one_side_fold_eq_before := [llvmfunc|
  llvm.func @one_side_fold_eq(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.select %arg3, %arg0, %arg2 : i1, i32
    %1 = llvm.select %arg3, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def no_side_fold_cond_before := [llvmfunc|
  llvm.func @no_side_fold_cond(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.select %arg3, %arg0, %arg2 : i1, i32
    %1 = llvm.select %arg4, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "sle" %1, %0 : i32
    llvm.return %2 : i1
  }]

def no_side_fold_op_before := [llvmfunc|
  llvm.func @no_side_fold_op(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.select %arg3, %arg0, %arg1 : i1, i32
    %1 = llvm.select %arg3, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "sge" %1, %0 : i32
    llvm.return %2 : i1
  }]

def one_select_mult_use_before := [llvmfunc|
  llvm.func @one_select_mult_use(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.mlir.addressof @use : !llvm.ptr
    %1 = llvm.select %arg3, %arg0, %arg2 : i1, i32
    %2 = llvm.select %arg3, %arg1, %arg2 : i1, i32
    llvm.call %0(%1) : !llvm.ptr, (i32) -> ()
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def both_select_mult_use_before := [llvmfunc|
  llvm.func @both_select_mult_use(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.mlir.addressof @use : !llvm.ptr
    %1 = llvm.select %arg3, %arg0, %arg2 : i1, i32
    %2 = llvm.select %arg3, %arg1, %arg2 : i1, i32
    llvm.call %0(%1, %2) : !llvm.ptr, (i32, i32) -> ()
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def fold_vector_ops_before := [llvmfunc|
  llvm.func @fold_vector_ops(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>, %arg3: i1) -> vector<4xi1> {
    %0 = llvm.select %arg3, %arg0, %arg2 : i1, vector<4xi32>
    %1 = llvm.select %arg3, %arg1, %arg2 : i1, vector<4xi32>
    %2 = llvm.icmp "eq" %1, %0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }]

def fold_vector_cond_ops_before := [llvmfunc|
  llvm.func @fold_vector_cond_ops(%arg0: vector<8xi32>, %arg1: vector<8xi32>, %arg2: vector<8xi32>, %arg3: vector<8xi1>) -> vector<8xi1> {
    %0 = llvm.select %arg3, %arg0, %arg2 : vector<8xi1>, vector<8xi32>
    %1 = llvm.select %arg3, %arg1, %arg2 : vector<8xi1>, vector<8xi32>
    %2 = llvm.icmp "sgt" %1, %0 : vector<8xi32>
    llvm.return %2 : vector<8xi1>
  }]

def both_sides_fold_slt_combined := [llvmfunc|
  llvm.func @both_sides_fold_slt(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_both_sides_fold_slt   : both_sides_fold_slt_before  ⊑  both_sides_fold_slt_combined := by
  unfold both_sides_fold_slt_before both_sides_fold_slt_combined
  simp_alive_peephole
  sorry
def both_sides_fold_eq_combined := [llvmfunc|
  llvm.func @both_sides_fold_eq(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    llvm.return %1 : i1
  }]

theorem inst_combine_both_sides_fold_eq   : both_sides_fold_eq_before  ⊑  both_sides_fold_eq_combined := by
  unfold both_sides_fold_eq_before both_sides_fold_eq_combined
  simp_alive_peephole
  sorry
def one_side_fold_slt_combined := [llvmfunc|
  llvm.func @one_side_fold_slt(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "slt" %arg1, %arg0 : i32
    %2 = llvm.select %arg3, %1, %0 : i1, i1
    llvm.return %2 : i1
  }]

theorem inst_combine_one_side_fold_slt   : one_side_fold_slt_before  ⊑  one_side_fold_slt_combined := by
  unfold one_side_fold_slt_before one_side_fold_slt_combined
  simp_alive_peephole
  sorry
def one_side_fold_sgt_combined := [llvmfunc|
  llvm.func @one_side_fold_sgt(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %3 = llvm.xor %arg3, %0  : i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_one_side_fold_sgt   : one_side_fold_sgt_before  ⊑  one_side_fold_sgt_combined := by
  unfold one_side_fold_sgt_before one_side_fold_sgt_combined
  simp_alive_peephole
  sorry
def one_side_fold_eq_combined := [llvmfunc|
  llvm.func @one_side_fold_eq(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg0 : i32
    %2 = llvm.xor %arg3, %0  : i1
    %3 = llvm.select %2, %0, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_one_side_fold_eq   : one_side_fold_eq_before  ⊑  one_side_fold_eq_combined := by
  unfold one_side_fold_eq_before one_side_fold_eq_combined
  simp_alive_peephole
  sorry
def no_side_fold_cond_combined := [llvmfunc|
  llvm.func @no_side_fold_cond(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.select %arg3, %arg0, %arg2 : i1, i32
    %1 = llvm.select %arg4, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "sle" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_no_side_fold_cond   : no_side_fold_cond_before  ⊑  no_side_fold_cond_combined := by
  unfold no_side_fold_cond_before no_side_fold_cond_combined
  simp_alive_peephole
  sorry
def no_side_fold_op_combined := [llvmfunc|
  llvm.func @no_side_fold_op(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.select %arg3, %arg0, %arg1 : i1, i32
    %1 = llvm.select %arg3, %arg1, %arg2 : i1, i32
    %2 = llvm.icmp "sge" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_no_side_fold_op   : no_side_fold_op_before  ⊑  no_side_fold_op_combined := by
  unfold no_side_fold_op_before no_side_fold_op_combined
  simp_alive_peephole
  sorry
def one_select_mult_use_combined := [llvmfunc|
  llvm.func @one_select_mult_use(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.mlir.addressof @use : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg3, %arg0, %arg2 : i1, i32
    llvm.call %0(%2) : !llvm.ptr, (i32) -> ()
    %3 = llvm.icmp "slt" %arg1, %arg0 : i32
    %4 = llvm.select %arg3, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_one_select_mult_use   : one_select_mult_use_before  ⊑  one_select_mult_use_combined := by
  unfold one_select_mult_use_before one_select_mult_use_combined
  simp_alive_peephole
  sorry
def both_select_mult_use_combined := [llvmfunc|
  llvm.func @both_select_mult_use(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i1) -> i1 {
    %0 = llvm.mlir.addressof @use : !llvm.ptr
    %1 = llvm.select %arg3, %arg0, %arg2 : i1, i32
    %2 = llvm.select %arg3, %arg1, %arg2 : i1, i32
    llvm.call %0(%1, %2) : !llvm.ptr, (i32, i32) -> ()
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_both_select_mult_use   : both_select_mult_use_before  ⊑  both_select_mult_use_combined := by
  unfold both_select_mult_use_before both_select_mult_use_combined
  simp_alive_peephole
  sorry
def fold_vector_ops_combined := [llvmfunc|
  llvm.func @fold_vector_ops(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>, %arg3: i1) -> vector<4xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.icmp "eq" %arg1, %arg0 : vector<4xi32>
    %3 = llvm.select %arg3, %2, %1 : i1, vector<4xi1>
    llvm.return %3 : vector<4xi1>
  }]

theorem inst_combine_fold_vector_ops   : fold_vector_ops_before  ⊑  fold_vector_ops_combined := by
  unfold fold_vector_ops_before fold_vector_ops_combined
  simp_alive_peephole
  sorry
def fold_vector_cond_ops_combined := [llvmfunc|
  llvm.func @fold_vector_cond_ops(%arg0: vector<8xi32>, %arg1: vector<8xi32>, %arg2: vector<8xi32>, %arg3: vector<8xi1>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<8xi1>) : vector<8xi1>
    %2 = llvm.icmp "sgt" %arg1, %arg0 : vector<8xi32>
    %3 = llvm.select %arg3, %2, %1 : vector<8xi1>, vector<8xi1>
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fold_vector_cond_ops   : fold_vector_cond_ops_before  ⊑  fold_vector_cond_ops_combined := by
  unfold fold_vector_cond_ops_before fold_vector_cond_ops_combined
  simp_alive_peephole
  sorry
