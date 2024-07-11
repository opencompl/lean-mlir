import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  subtract-from-one-hand-of-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_sub_from_trueval_before := [llvmfunc|
  llvm.func @t0_sub_from_trueval(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i8
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }]

def t1_sub_from_falseval_before := [llvmfunc|
  llvm.func @t1_sub_from_falseval(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i8
    %1 = llvm.sub %arg2, %0  : i8
    llvm.return %1 : i8
  }]

def t2_vec_before := [llvmfunc|
  llvm.func @t2_vec(%arg0: i1, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, vector<2xi8>
    %1 = llvm.sub %arg1, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def n3_extrause_before := [llvmfunc|
  llvm.func @n3_extrause(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }]

def n4_wrong_hands_before := [llvmfunc|
  llvm.func @n4_wrong_hands(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i8
    %1 = llvm.sub %arg3, %0  : i8
    llvm.return %1 : i8
  }]

def t0_sub_from_trueval_combined := [llvmfunc|
  llvm.func @t0_sub_from_trueval(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg1, %arg2  : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t0_sub_from_trueval   : t0_sub_from_trueval_before  ⊑  t0_sub_from_trueval_combined := by
  unfold t0_sub_from_trueval_before t0_sub_from_trueval_combined
  simp_alive_peephole
  sorry
def t1_sub_from_falseval_combined := [llvmfunc|
  llvm.func @t1_sub_from_falseval(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg2, %arg1  : i8
    %2 = llvm.select %arg0, %1, %0 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t1_sub_from_falseval   : t1_sub_from_falseval_before  ⊑  t1_sub_from_falseval_combined := by
  unfold t1_sub_from_falseval_before t1_sub_from_falseval_combined
  simp_alive_peephole
  sorry
def t2_vec_combined := [llvmfunc|
  llvm.func @t2_vec(%arg0: i1, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %arg1, %arg2  : vector<2xi8>
    %3 = llvm.select %arg0, %1, %2 : i1, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_t2_vec   : t2_vec_before  ⊑  t2_vec_combined := by
  unfold t2_vec_before t2_vec_combined
  simp_alive_peephole
  sorry
def n3_extrause_combined := [llvmfunc|
  llvm.func @n3_extrause(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_n3_extrause   : n3_extrause_before  ⊑  n3_extrause_combined := by
  unfold n3_extrause_before n3_extrause_combined
  simp_alive_peephole
  sorry
def n4_wrong_hands_combined := [llvmfunc|
  llvm.func @n4_wrong_hands(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i8
    %1 = llvm.sub %arg3, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_n4_wrong_hands   : n4_wrong_hands_before  ⊑  n4_wrong_hands_combined := by
  unfold n4_wrong_hands_before n4_wrong_hands_combined
  simp_alive_peephole
  sorry
