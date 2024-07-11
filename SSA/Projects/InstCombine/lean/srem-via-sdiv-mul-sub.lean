import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  srem-via-sdiv-mul-sub
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_basic_before := [llvmfunc|
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sdiv %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.mul %0, %arg1  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def t1_vector_before := [llvmfunc|
  llvm.func @t1_vector(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.sdiv %arg0, %arg1  : vector<2xi8>
    llvm.call @use2xi8(%0) : (vector<2xi8>) -> ()
    %1 = llvm.mul %0, %arg1  : vector<2xi8>
    %2 = llvm.sub %arg0, %1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def t4_extrause_before := [llvmfunc|
  llvm.func @t4_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sdiv %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.mul %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def t5_commutative_before := [llvmfunc|
  llvm.func @t5_commutative(%arg0: i8) -> i8 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.sdiv %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.mul %0, %1  : i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def n6_different_x_before := [llvmfunc|
  llvm.func @n6_different_x(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sdiv %arg0, %arg2  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.mul %0, %arg2  : i8
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }]

def n6_different_y_before := [llvmfunc|
  llvm.func @n6_different_y(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sdiv %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.mul %0, %arg2  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def t0_basic_combined := [llvmfunc|
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sdiv %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.mul %0, %arg1  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t0_basic   : t0_basic_before  ⊑  t0_basic_combined := by
  unfold t0_basic_before t0_basic_combined
  simp_alive_peephole
  sorry
def t1_vector_combined := [llvmfunc|
  llvm.func @t1_vector(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.sdiv %arg0, %arg1  : vector<2xi8>
    llvm.call @use2xi8(%0) : (vector<2xi8>) -> ()
    %1 = llvm.mul %0, %arg1  : vector<2xi8>
    %2 = llvm.sub %arg0, %1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_t1_vector   : t1_vector_before  ⊑  t1_vector_combined := by
  unfold t1_vector_before t1_vector_combined
  simp_alive_peephole
  sorry
def t4_extrause_combined := [llvmfunc|
  llvm.func @t4_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sdiv %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.mul %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t4_extrause   : t4_extrause_before  ⊑  t4_extrause_combined := by
  unfold t4_extrause_before t4_extrause_combined
  simp_alive_peephole
  sorry
def t5_commutative_combined := [llvmfunc|
  llvm.func @t5_commutative(%arg0: i8) -> i8 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.sdiv %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.mul %0, %1  : i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t5_commutative   : t5_commutative_before  ⊑  t5_commutative_combined := by
  unfold t5_commutative_before t5_commutative_combined
  simp_alive_peephole
  sorry
def n6_different_x_combined := [llvmfunc|
  llvm.func @n6_different_x(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sdiv %arg0, %arg2  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.mul %0, %arg2  : i8
    %2 = llvm.sub %arg1, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_n6_different_x   : n6_different_x_before  ⊑  n6_different_x_combined := by
  unfold n6_different_x_before n6_different_x_combined
  simp_alive_peephole
  sorry
def n6_different_y_combined := [llvmfunc|
  llvm.func @n6_different_y(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sdiv %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.mul %0, %arg2  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_n6_different_y   : n6_different_y_before  ⊑  n6_different_y_combined := by
  unfold n6_different_y_before n6_different_y_combined
  simp_alive_peephole
  sorry
