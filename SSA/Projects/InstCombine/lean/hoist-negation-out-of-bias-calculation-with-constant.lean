import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  hoist-negation-out-of-bias-calculation-with-constant
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.sub %1, %arg0  : i8
    llvm.return %2 : i8
  }]

def t1_vec_before := [llvmfunc|
  llvm.func @t1_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %0  : vector<2xi8>
    %2 = llvm.sub %1, %arg0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def t2_vec_undef_before := [llvmfunc|
  llvm.func @t2_vec_undef(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.and %arg0, %6  : vector<2xi8>
    %8 = llvm.sub %7, %arg0  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

def t3_vec_nonsplat_before := [llvmfunc|
  llvm.func @t3_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, 44]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %0  : vector<2xi8>
    %2 = llvm.sub %1, %arg0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def n4_extrause_before := [llvmfunc|
  llvm.func @n4_extrause(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %1, %arg0  : i8
    llvm.return %2 : i8
  }]

def n5_before := [llvmfunc|
  llvm.func @n5(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }]

def n6_before := [llvmfunc|
  llvm.func @n6(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.and %arg1, %0  : i8
    %2 = llvm.sub %1, %arg0  : i8
    llvm.return %2 : i8
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-43 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_vec_combined := [llvmfunc|
  llvm.func @t1_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-43> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.and %arg0, %0  : vector<2xi8>
    %4 = llvm.sub %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_t1_vec   : t1_vec_before  ⊑  t1_vec_combined := by
  unfold t1_vec_before t1_vec_combined
  simp_alive_peephole
  sorry
def t2_vec_undef_combined := [llvmfunc|
  llvm.func @t2_vec_undef(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(-43 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(0 : i8) : i8
    %8 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.and %arg0, %6  : vector<2xi8>
    %10 = llvm.sub %8, %9  : vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_t2_vec_undef   : t2_vec_undef_before  ⊑  t2_vec_undef_combined := by
  unfold t2_vec_undef_before t2_vec_undef_combined
  simp_alive_peephole
  sorry
def t3_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t3_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-43, -45]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.and %arg0, %0  : vector<2xi8>
    %4 = llvm.sub %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_t3_vec_nonsplat   : t3_vec_nonsplat_before  ⊑  t3_vec_nonsplat_combined := by
  unfold t3_vec_nonsplat_before t3_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def n4_extrause_combined := [llvmfunc|
  llvm.func @n4_extrause(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_n4_extrause   : n4_extrause_before  ⊑  n4_extrause_combined := by
  unfold n4_extrause_before n4_extrause_combined
  simp_alive_peephole
  sorry
def n5_combined := [llvmfunc|
  llvm.func @n5(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-43 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_n5   : n5_before  ⊑  n5_combined := by
  unfold n5_before n5_combined
  simp_alive_peephole
  sorry
def n6_combined := [llvmfunc|
  llvm.func @n6(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.and %arg1, %0  : i8
    %2 = llvm.sub %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_n6   : n6_before  ⊑  n6_combined := by
  unfold n6_before n6_combined
  simp_alive_peephole
  sorry
