import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  add-shift
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def flip_add_of_shift_neg_before := [llvmfunc|
  llvm.func @flip_add_of_shift_neg(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.shl %1, %arg1 overflow<nsw, nuw>  : i8
    %3 = llvm.add %2, %arg2  : i8
    llvm.return %3 : i8
  }]

def flip_add_of_shift_neg_vec_before := [llvmfunc|
  llvm.func @flip_add_of_shift_neg_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg2, %arg2  : vector<2xi8>
    %3 = llvm.sub %1, %arg0  : vector<2xi8>
    %4 = llvm.shl %3, %arg1  : vector<2xi8>
    %5 = llvm.add %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def flip_add_of_shift_neg_fail_shr_before := [llvmfunc|
  llvm.func @flip_add_of_shift_neg_fail_shr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.lshr %1, %arg1  : i8
    %3 = llvm.add %2, %arg2  : i8
    llvm.return %3 : i8
  }]

def flip_add_of_shift_neg_vec_fail_multiuse_neg_before := [llvmfunc|
  llvm.func @flip_add_of_shift_neg_vec_fail_multiuse_neg(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg2, %arg2  : vector<2xi8>
    %3 = llvm.sub %1, %arg0  : vector<2xi8>
    %4 = llvm.shl %3, %arg1  : vector<2xi8>
    llvm.call @use.v2i8(%3) : (vector<2xi8>) -> ()
    %5 = llvm.add %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def flip_add_of_shift_neg_vec_fail_multiuse_shift_before := [llvmfunc|
  llvm.func @flip_add_of_shift_neg_vec_fail_multiuse_shift(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg2, %arg2  : vector<2xi8>
    %3 = llvm.sub %1, %arg0  : vector<2xi8>
    %4 = llvm.shl %3, %arg1  : vector<2xi8>
    llvm.call @use.v2i8(%4) : (vector<2xi8>) -> ()
    %5 = llvm.add %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def flip_add_of_shift_neg_combined := [llvmfunc|
  llvm.func @flip_add_of_shift_neg(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg1  : i8
    %1 = llvm.sub %arg2, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_flip_add_of_shift_neg   : flip_add_of_shift_neg_before  ⊑  flip_add_of_shift_neg_combined := by
  unfold flip_add_of_shift_neg_before flip_add_of_shift_neg_combined
  simp_alive_peephole
  sorry
def flip_add_of_shift_neg_vec_combined := [llvmfunc|
  llvm.func @flip_add_of_shift_neg_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mul %arg2, %arg2  : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1  : vector<2xi8>
    %2 = llvm.sub %0, %1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_flip_add_of_shift_neg_vec   : flip_add_of_shift_neg_vec_before  ⊑  flip_add_of_shift_neg_vec_combined := by
  unfold flip_add_of_shift_neg_vec_before flip_add_of_shift_neg_vec_combined
  simp_alive_peephole
  sorry
def flip_add_of_shift_neg_fail_shr_combined := [llvmfunc|
  llvm.func @flip_add_of_shift_neg_fail_shr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.lshr %1, %arg1  : i8
    %3 = llvm.add %2, %arg2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_flip_add_of_shift_neg_fail_shr   : flip_add_of_shift_neg_fail_shr_before  ⊑  flip_add_of_shift_neg_fail_shr_combined := by
  unfold flip_add_of_shift_neg_fail_shr_before flip_add_of_shift_neg_fail_shr_combined
  simp_alive_peephole
  sorry
def flip_add_of_shift_neg_vec_fail_multiuse_neg_combined := [llvmfunc|
  llvm.func @flip_add_of_shift_neg_vec_fail_multiuse_neg(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg2, %arg2  : vector<2xi8>
    %3 = llvm.sub %1, %arg0  : vector<2xi8>
    %4 = llvm.shl %3, %arg1  : vector<2xi8>
    llvm.call @use.v2i8(%3) : (vector<2xi8>) -> ()
    %5 = llvm.add %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

theorem inst_combine_flip_add_of_shift_neg_vec_fail_multiuse_neg   : flip_add_of_shift_neg_vec_fail_multiuse_neg_before  ⊑  flip_add_of_shift_neg_vec_fail_multiuse_neg_combined := by
  unfold flip_add_of_shift_neg_vec_fail_multiuse_neg_before flip_add_of_shift_neg_vec_fail_multiuse_neg_combined
  simp_alive_peephole
  sorry
def flip_add_of_shift_neg_vec_fail_multiuse_shift_combined := [llvmfunc|
  llvm.func @flip_add_of_shift_neg_vec_fail_multiuse_shift(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg2, %arg2  : vector<2xi8>
    %3 = llvm.sub %1, %arg0  : vector<2xi8>
    %4 = llvm.shl %3, %arg1  : vector<2xi8>
    llvm.call @use.v2i8(%4) : (vector<2xi8>) -> ()
    %5 = llvm.add %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

theorem inst_combine_flip_add_of_shift_neg_vec_fail_multiuse_shift   : flip_add_of_shift_neg_vec_fail_multiuse_shift_before  ⊑  flip_add_of_shift_neg_vec_fail_multiuse_shift_combined := by
  unfold flip_add_of_shift_neg_vec_fail_multiuse_shift_before flip_add_of_shift_neg_vec_fail_multiuse_shift_combined
  simp_alive_peephole
  sorry
