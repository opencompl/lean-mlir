import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  binop-select-cast-of-select-cond
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def add_select_zext_before := [llvmfunc|
  llvm.func @add_select_zext(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.add %2, %3  : i64
    llvm.return %4 : i64
  }]

def add_select_sext_before := [llvmfunc|
  llvm.func @add_select_sext(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.add %2, %3  : i64
    llvm.return %4 : i64
  }]

def add_select_not_zext_before := [llvmfunc|
  llvm.func @add_select_not_zext(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    %4 = llvm.xor %arg0, %2  : i1
    %5 = llvm.zext %4 : i1 to i64
    %6 = llvm.add %3, %5  : i64
    llvm.return %6 : i64
  }]

def add_select_not_sext_before := [llvmfunc|
  llvm.func @add_select_not_sext(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    %4 = llvm.xor %arg0, %2  : i1
    %5 = llvm.sext %4 : i1 to i64
    %6 = llvm.add %3, %5  : i64
    llvm.return %6 : i64
  }]

def sub_select_sext_before := [llvmfunc|
  llvm.func @sub_select_sext(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    %2 = llvm.sext %arg0 : i1 to i64
    %3 = llvm.sub %1, %2  : i64
    llvm.return %3 : i64
  }]

def sub_select_not_zext_before := [llvmfunc|
  llvm.func @sub_select_not_zext(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i64
    %3 = llvm.xor %arg0, %1  : i1
    %4 = llvm.zext %3 : i1 to i64
    %5 = llvm.sub %2, %4  : i64
    llvm.return %5 : i64
  }]

def sub_select_not_sext_before := [llvmfunc|
  llvm.func @sub_select_not_sext(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i64
    %3 = llvm.xor %arg0, %1  : i1
    %4 = llvm.sext %3 : i1 to i64
    %5 = llvm.sub %2, %4  : i64
    llvm.return %5 : i64
  }]

def mul_select_zext_before := [llvmfunc|
  llvm.func @mul_select_zext(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    %2 = llvm.zext %arg0 : i1 to i64
    %3 = llvm.mul %1, %2  : i64
    llvm.return %3 : i64
  }]

def mul_select_sext_before := [llvmfunc|
  llvm.func @mul_select_sext(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.sext %arg0 : i1 to i64
    %4 = llvm.mul %2, %3  : i64
    llvm.return %4 : i64
  }]

def select_zext_different_condition_before := [llvmfunc|
  llvm.func @select_zext_different_condition(%arg0: i1, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.add %2, %3  : i64
    llvm.return %4 : i64
  }]

def vector_test_before := [llvmfunc|
  llvm.func @vector_test(%arg0: i1) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.select %arg0, %0, %1 : i1, vector<2xi64>
    %6 = llvm.zext %arg0 : i1 to i64
    %7 = llvm.insertelement %6, %2[%3 : i32] : vector<2xi64>
    %8 = llvm.insertelement %6, %7[%4 : i32] : vector<2xi64>
    %9 = llvm.add %5, %8  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }]

def multiuse_add_before := [llvmfunc|
  llvm.func @multiuse_add(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.add %2, %3  : i64
    %5 = llvm.add %4, %1  : i64
    llvm.return %5 : i64
  }]

def multiuse_select_before := [llvmfunc|
  llvm.func @multiuse_select(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.zext %arg0 : i1 to i64
    %4 = llvm.sub %2, %3  : i64
    %5 = llvm.mul %2, %4  : i64
    llvm.return %5 : i64
  }]

def select_non_const_sides_before := [llvmfunc|
  llvm.func @select_non_const_sides(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, i64
    %2 = llvm.sub %1, %0  : i64
    llvm.return %2 : i64
  }]

def sub_select_sext_op_swapped_non_const_args_before := [llvmfunc|
  llvm.func @sub_select_sext_op_swapped_non_const_args(%arg0: i1, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i6
    %1 = llvm.sext %arg0 : i1 to i6
    %2 = llvm.sub %1, %0  : i6
    llvm.return %2 : i6
  }]

def sub_select_zext_op_swapped_non_const_args_before := [llvmfunc|
  llvm.func @sub_select_zext_op_swapped_non_const_args(%arg0: i1, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i6
    %1 = llvm.zext %arg0 : i1 to i6
    %2 = llvm.sub %1, %0  : i6
    llvm.return %2 : i6
  }]

def vectorized_add_before := [llvmfunc|
  llvm.func @vectorized_add(%arg0: vector<2xi1>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi8>
    %2 = llvm.select %arg0, %arg1, %0 : vector<2xi1>, vector<2xi8>
    %3 = llvm.add %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def pr64669_before := [llvmfunc|
  llvm.func @pr64669(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(25 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @b : !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<72 x i32>
    %4 = llvm.mlir.addressof @c : !llvm.ptr
    %5 = llvm.icmp "ne" %3, %4 : !llvm.ptr
    %6 = llvm.select %5, %arg0, %1 : i1, i64
    %7 = llvm.zext %5 : i1 to i64
    %8 = llvm.add %6, %7 overflow<nsw>  : i64
    llvm.return %8 : i64
  }]

def add_select_zext_combined := [llvmfunc|
  llvm.func @add_select_zext(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(65 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    llvm.return %2 : i64
  }]

theorem inst_combine_add_select_zext   : add_select_zext_before  ⊑  add_select_zext_combined := by
  unfold add_select_zext_before add_select_zext_combined
  simp_alive_peephole
  sorry
def add_select_sext_combined := [llvmfunc|
  llvm.func @add_select_sext(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    llvm.return %2 : i64
  }]

theorem inst_combine_add_select_sext   : add_select_sext_before  ⊑  add_select_sext_combined := by
  unfold add_select_sext_before add_select_sext_combined
  simp_alive_peephole
  sorry
def add_select_not_zext_combined := [llvmfunc|
  llvm.func @add_select_not_zext(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    llvm.return %2 : i64
  }]

theorem inst_combine_add_select_not_zext   : add_select_not_zext_before  ⊑  add_select_not_zext_combined := by
  unfold add_select_not_zext_before add_select_not_zext_combined
  simp_alive_peephole
  sorry
def add_select_not_sext_combined := [llvmfunc|
  llvm.func @add_select_not_sext(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    llvm.return %2 : i64
  }]

theorem inst_combine_add_select_not_sext   : add_select_not_sext_before  ⊑  add_select_not_sext_combined := by
  unfold add_select_not_sext_before add_select_not_sext_combined
  simp_alive_peephole
  sorry
def sub_select_sext_combined := [llvmfunc|
  llvm.func @sub_select_sext(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(65 : i64) : i64
    %1 = llvm.select %arg0, %0, %arg1 : i1, i64
    llvm.return %1 : i64
  }]

theorem inst_combine_sub_select_sext   : sub_select_sext_before  ⊑  sub_select_sext_combined := by
  unfold sub_select_sext_before sub_select_sext_combined
  simp_alive_peephole
  sorry
def sub_select_not_zext_combined := [llvmfunc|
  llvm.func @sub_select_not_zext(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    llvm.return %1 : i64
  }]

theorem inst_combine_sub_select_not_zext   : sub_select_not_zext_before  ⊑  sub_select_not_zext_combined := by
  unfold sub_select_not_zext_before sub_select_not_zext_combined
  simp_alive_peephole
  sorry
def sub_select_not_sext_combined := [llvmfunc|
  llvm.func @sub_select_not_sext(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(65 : i64) : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    llvm.return %1 : i64
  }]

theorem inst_combine_sub_select_not_sext   : sub_select_not_sext_before  ⊑  sub_select_not_sext_combined := by
  unfold sub_select_not_sext_before sub_select_not_sext_combined
  simp_alive_peephole
  sorry
def mul_select_zext_combined := [llvmfunc|
  llvm.func @mul_select_zext(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.select %arg0, %arg1, %0 : i1, i64
    llvm.return %1 : i64
  }]

theorem inst_combine_mul_select_zext   : mul_select_zext_before  ⊑  mul_select_zext_combined := by
  unfold mul_select_zext_before mul_select_zext_combined
  simp_alive_peephole
  sorry
def mul_select_sext_combined := [llvmfunc|
  llvm.func @mul_select_sext(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(-64 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    llvm.return %2 : i64
  }]

theorem inst_combine_mul_select_sext   : mul_select_sext_before  ⊑  mul_select_sext_combined := by
  unfold mul_select_sext_before mul_select_sext_combined
  simp_alive_peephole
  sorry
def select_zext_different_condition_combined := [llvmfunc|
  llvm.func @select_zext_different_condition(%arg0: i1, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    %3 = llvm.zext %arg1 : i1 to i64
    %4 = llvm.add %2, %3 overflow<nsw, nuw>  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_select_zext_different_condition   : select_zext_different_condition_before  ⊑  select_zext_different_condition_combined := by
  unfold select_zext_different_condition_before select_zext_different_condition_combined
  simp_alive_peephole
  sorry
def vector_test_combined := [llvmfunc|
  llvm.func @vector_test(%arg0: i1) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.poison : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.select %arg0, %0, %1 : i1, vector<2xi64>
    %5 = llvm.zext %arg0 : i1 to i64
    %6 = llvm.insertelement %5, %2[%3 : i64] : vector<2xi64>
    %7 = llvm.shufflevector %6, %2 [0, 0] : vector<2xi64> 
    %8 = llvm.add %4, %7 overflow<nsw, nuw>  : vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }]

theorem inst_combine_vector_test   : vector_test_before  ⊑  vector_test_combined := by
  unfold vector_test_before vector_test_combined
  simp_alive_peephole
  sorry
def multiuse_add_combined := [llvmfunc|
  llvm.func @multiuse_add(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(66 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    llvm.return %2 : i64
  }]

theorem inst_combine_multiuse_add   : multiuse_add_before  ⊑  multiuse_add_combined := by
  unfold multiuse_add_before multiuse_add_combined
  simp_alive_peephole
  sorry
def multiuse_select_combined := [llvmfunc|
  llvm.func @multiuse_select(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(4032 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.select %arg0, %0, %1 : i1, i64
    llvm.return %2 : i64
  }]

theorem inst_combine_multiuse_select   : multiuse_select_before  ⊑  multiuse_select_combined := by
  unfold multiuse_select_before multiuse_select_combined
  simp_alive_peephole
  sorry
def select_non_const_sides_combined := [llvmfunc|
  llvm.func @select_non_const_sides(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.add %arg1, %0  : i64
    %2 = llvm.select %arg0, %1, %arg2 : i1, i64
    llvm.return %2 : i64
  }]

theorem inst_combine_select_non_const_sides   : select_non_const_sides_before  ⊑  select_non_const_sides_combined := by
  unfold select_non_const_sides_before select_non_const_sides_combined
  simp_alive_peephole
  sorry
def sub_select_sext_op_swapped_non_const_args_combined := [llvmfunc|
  llvm.func @sub_select_sext_op_swapped_non_const_args(%arg0: i1, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.mlir.constant(-1 : i6) : i6
    %1 = llvm.mlir.constant(0 : i6) : i6
    %2 = llvm.xor %arg1, %0  : i6
    %3 = llvm.sub %1, %arg2  : i6
    %4 = llvm.select %arg0, %2, %3 : i1, i6
    llvm.return %4 : i6
  }]

theorem inst_combine_sub_select_sext_op_swapped_non_const_args   : sub_select_sext_op_swapped_non_const_args_before  ⊑  sub_select_sext_op_swapped_non_const_args_combined := by
  unfold sub_select_sext_op_swapped_non_const_args_before sub_select_sext_op_swapped_non_const_args_combined
  simp_alive_peephole
  sorry
def sub_select_zext_op_swapped_non_const_args_combined := [llvmfunc|
  llvm.func @sub_select_zext_op_swapped_non_const_args(%arg0: i1, %arg1: i6, %arg2: i6) -> i6 {
    %0 = llvm.mlir.constant(1 : i6) : i6
    %1 = llvm.mlir.constant(0 : i6) : i6
    %2 = llvm.sub %0, %arg1  : i6
    %3 = llvm.sub %1, %arg2  : i6
    %4 = llvm.select %arg0, %2, %3 : i1, i6
    llvm.return %4 : i6
  }]

theorem inst_combine_sub_select_zext_op_swapped_non_const_args   : sub_select_zext_op_swapped_non_const_args_before  ⊑  sub_select_zext_op_swapped_non_const_args_combined := by
  unfold sub_select_zext_op_swapped_non_const_args_before sub_select_zext_op_swapped_non_const_args_combined
  simp_alive_peephole
  sorry
def vectorized_add_combined := [llvmfunc|
  llvm.func @vectorized_add(%arg0: vector<2xi1>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg1, %0  : vector<2xi8>
    %2 = llvm.select %arg0, %1, %0 : vector<2xi1>, vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_vectorized_add   : vectorized_add_before  ⊑  vectorized_add_combined := by
  unfold vectorized_add_before vectorized_add_combined
  simp_alive_peephole
  sorry
def pr64669_combined := [llvmfunc|
  llvm.func @pr64669(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    %2 = llvm.mlir.constant(25 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.addressof @b : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%3, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<72 x i32>
    %6 = llvm.icmp "ne" %5, %1 : !llvm.ptr
    %7 = llvm.add %arg0, %0  : i64
    %8 = llvm.select %6, %7, %3 : i1, i64
    llvm.return %8 : i64
  }]

theorem inst_combine_pr64669   : pr64669_before  ⊑  pr64669_combined := by
  unfold pr64669_before pr64669_combined
  simp_alive_peephole
  sorry
