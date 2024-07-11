import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  hoist-negation-out-of-bias-calculation
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }]

def t1_commutative_before := [llvmfunc|
  llvm.func @t1_commutative(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.and %1, %2  : i8
    %4 = llvm.sub %3, %1  : i8
    llvm.return %4 : i8
  }]

def t2_vec_before := [llvmfunc|
  llvm.func @t2_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %1, %arg1  : vector<2xi8>
    %3 = llvm.and %2, %arg0  : vector<2xi8>
    %4 = llvm.sub %3, %arg0  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def t3_vec_poison_before := [llvmfunc|
  llvm.func @t3_vec_poison(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.sub %6, %arg1  : vector<2xi8>
    %8 = llvm.and %7, %arg0  : vector<2xi8>
    %9 = llvm.sub %8, %arg0  : vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }]

def n4_extrause0_before := [llvmfunc|
  llvm.func @n4_extrause0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }]

def n5_extrause1_before := [llvmfunc|
  llvm.func @n5_extrause1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }]

def n6_extrause2_before := [llvmfunc|
  llvm.func @n6_extrause2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.and %1, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }]

def n7_before := [llvmfunc|
  llvm.func @n7(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def n8_before := [llvmfunc|
  llvm.func @n8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }]

def n9_before := [llvmfunc|
  llvm.func @n9(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg2  : i8
    %2 = llvm.and %arg1, %1  : i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg1, %0  : i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_commutative_combined := [llvmfunc|
  llvm.func @t1_commutative(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.sub %1, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_t1_commutative   : t1_commutative_before  ⊑  t1_commutative_combined := by
  unfold t1_commutative_before t1_commutative_combined
  simp_alive_peephole
  sorry
def t2_vec_combined := [llvmfunc|
  llvm.func @t2_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg1, %0  : vector<2xi8>
    %4 = llvm.and %3, %arg0  : vector<2xi8>
    %5 = llvm.sub %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

theorem inst_combine_t2_vec   : t2_vec_before  ⊑  t2_vec_combined := by
  unfold t2_vec_before t2_vec_combined
  simp_alive_peephole
  sorry
def t3_vec_poison_combined := [llvmfunc|
  llvm.func @t3_vec_poison(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg1, %0  : vector<2xi8>
    %4 = llvm.and %3, %arg0  : vector<2xi8>
    %5 = llvm.sub %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

theorem inst_combine_t3_vec_poison   : t3_vec_poison_before  ⊑  t3_vec_poison_combined := by
  unfold t3_vec_poison_before t3_vec_poison_combined
  simp_alive_peephole
  sorry
def n4_extrause0_combined := [llvmfunc|
  llvm.func @n4_extrause0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_n4_extrause0   : n4_extrause0_before  ⊑  n4_extrause0_combined := by
  unfold n4_extrause0_before n4_extrause0_combined
  simp_alive_peephole
  sorry
def n5_extrause1_combined := [llvmfunc|
  llvm.func @n5_extrause1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_n5_extrause1   : n5_extrause1_before  ⊑  n5_extrause1_combined := by
  unfold n5_extrause1_before n5_extrause1_combined
  simp_alive_peephole
  sorry
def n6_extrause2_combined := [llvmfunc|
  llvm.func @n6_extrause2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.and %1, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_n6_extrause2   : n6_extrause2_before  ⊑  n6_extrause2_combined := by
  unfold n6_extrause2_before n6_extrause2_combined
  simp_alive_peephole
  sorry
def n7_combined := [llvmfunc|
  llvm.func @n7(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.add %arg1, %0  : i8
    %2 = llvm.and %1, %arg0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_n7   : n7_before  ⊑  n7_combined := by
  unfold n7_before n7_combined
  simp_alive_peephole
  sorry
def n8_combined := [llvmfunc|
  llvm.func @n8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_n8   : n8_before  ⊑  n8_combined := by
  unfold n8_before n8_combined
  simp_alive_peephole
  sorry
def n9_combined := [llvmfunc|
  llvm.func @n9(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg2  : i8
    %2 = llvm.and %1, %arg1  : i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_n9   : n9_before  ⊑  n9_combined := by
  unfold n9_before n9_combined
  simp_alive_peephole
  sorry
