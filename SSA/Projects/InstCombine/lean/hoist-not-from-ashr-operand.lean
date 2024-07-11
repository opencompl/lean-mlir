import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  hoist-not-from-ashr-operand
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.ashr %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.ashr %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def t2_vec_before := [llvmfunc|
  llvm.func @t2_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.ashr %1, %arg1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def t3_vec_poison_before := [llvmfunc|
  llvm.func @t3_vec_poison(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.xor %arg0, %6  : vector<2xi8>
    %8 = llvm.ashr %7, %arg1  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }]

def n4_before := [llvmfunc|
  llvm.func @n4(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.ashr %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg1  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg1  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t2_vec_combined := [llvmfunc|
  llvm.func @t2_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %arg1  : vector<2xi8>
    %2 = llvm.xor %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_t2_vec   : t2_vec_before  ⊑  t2_vec_combined := by
  unfold t2_vec_before t2_vec_combined
  simp_alive_peephole
  sorry
def t3_vec_poison_combined := [llvmfunc|
  llvm.func @t3_vec_poison(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %arg1  : vector<2xi8>
    %2 = llvm.xor %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_t3_vec_poison   : t3_vec_poison_before  ⊑  t3_vec_poison_combined := by
  unfold t3_vec_poison_before t3_vec_poison_combined
  simp_alive_peephole
  sorry
def n4_combined := [llvmfunc|
  llvm.func @n4(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.ashr %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_n4   : n4_before  ⊑  n4_combined := by
  unfold n4_before n4_combined
  simp_alive_peephole
  sorry
