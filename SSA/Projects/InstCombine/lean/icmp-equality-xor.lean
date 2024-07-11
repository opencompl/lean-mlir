import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-equality-xor
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def cmpeq_xor_cst1_before := [llvmfunc|
  llvm.func @cmpeq_xor_cst1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

def cmpeq_xor_cst2_before := [llvmfunc|
  llvm.func @cmpeq_xor_cst2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def cmpeq_xor_cst3_before := [llvmfunc|
  llvm.func @cmpeq_xor_cst3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }]

def cmpne_xor_cst1_before := [llvmfunc|
  llvm.func @cmpne_xor_cst1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ne" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

def cmpne_xor_cst2_before := [llvmfunc|
  llvm.func @cmpne_xor_cst2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

def cmpne_xor_cst3_before := [llvmfunc|
  llvm.func @cmpne_xor_cst3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    llvm.return %3 : i1
  }]

def cmpeq_xor_cst1_multiuse_before := [llvmfunc|
  llvm.func @cmpeq_xor_cst1_multiuse(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

def cmpeq_xor_cst1_commuted_before := [llvmfunc|
  llvm.func @cmpeq_xor_cst1_commuted(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mul %arg1, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }]

def cmpeq_xor_cst1_vec_before := [llvmfunc|
  llvm.func @cmpeq_xor_cst1_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[10, 11]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "eq" %arg1, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def foo1_before := [llvmfunc|
  llvm.func @foo1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.icmp "eq" %2, %4 : i32
    llvm.return %5 : i1
  }]

def foo2_before := [llvmfunc|
  llvm.func @foo2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.icmp "eq" %1, %3 : i32
    llvm.return %4 : i1
  }]

def foo3_before := [llvmfunc|
  llvm.func @foo3(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-2, -1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[9, 79]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def fold_xorC_eq0_multiuse_before := [llvmfunc|
  llvm.func @fold_xorC_eq0_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.xor %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    llvm.return %2 : i1
  }]

def fold_xorC_eq1_multiuse_fail_before := [llvmfunc|
  llvm.func @fold_xorC_eq1_multiuse_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.xor %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    llvm.return %2 : i1
  }]

def fold_xorC_neC_multiuse_before := [llvmfunc|
  llvm.func @fold_xorC_neC_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(45 : i8) : i8
    %1 = llvm.mlir.constant(67 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.return %3 : i1
  }]

def cmpeq_xor_cst1_combined := [llvmfunc|
  llvm.func @cmpeq_xor_cst1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_cmpeq_xor_cst1   : cmpeq_xor_cst1_before  ⊑  cmpeq_xor_cst1_combined := by
  unfold cmpeq_xor_cst1_before cmpeq_xor_cst1_combined
  simp_alive_peephole
  sorry
def cmpeq_xor_cst2_combined := [llvmfunc|
  llvm.func @cmpeq_xor_cst2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_cmpeq_xor_cst2   : cmpeq_xor_cst2_before  ⊑  cmpeq_xor_cst2_combined := by
  unfold cmpeq_xor_cst2_before cmpeq_xor_cst2_combined
  simp_alive_peephole
  sorry
def cmpeq_xor_cst3_combined := [llvmfunc|
  llvm.func @cmpeq_xor_cst3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_cmpeq_xor_cst3   : cmpeq_xor_cst3_before  ⊑  cmpeq_xor_cst3_combined := by
  unfold cmpeq_xor_cst3_before cmpeq_xor_cst3_combined
  simp_alive_peephole
  sorry
def cmpne_xor_cst1_combined := [llvmfunc|
  llvm.func @cmpne_xor_cst1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_cmpne_xor_cst1   : cmpne_xor_cst1_before  ⊑  cmpne_xor_cst1_combined := by
  unfold cmpne_xor_cst1_before cmpne_xor_cst1_combined
  simp_alive_peephole
  sorry
def cmpne_xor_cst2_combined := [llvmfunc|
  llvm.func @cmpne_xor_cst2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_cmpne_xor_cst2   : cmpne_xor_cst2_before  ⊑  cmpne_xor_cst2_combined := by
  unfold cmpne_xor_cst2_before cmpne_xor_cst2_combined
  simp_alive_peephole
  sorry
def cmpne_xor_cst3_combined := [llvmfunc|
  llvm.func @cmpne_xor_cst3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_cmpne_xor_cst3   : cmpne_xor_cst3_before  ⊑  cmpne_xor_cst3_combined := by
  unfold cmpne_xor_cst3_before cmpne_xor_cst3_combined
  simp_alive_peephole
  sorry
def cmpeq_xor_cst1_multiuse_combined := [llvmfunc|
  llvm.func @cmpeq_xor_cst1_multiuse(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_cmpeq_xor_cst1_multiuse   : cmpeq_xor_cst1_multiuse_before  ⊑  cmpeq_xor_cst1_multiuse_combined := by
  unfold cmpeq_xor_cst1_multiuse_before cmpeq_xor_cst1_multiuse_combined
  simp_alive_peephole
  sorry
def cmpeq_xor_cst1_commuted_combined := [llvmfunc|
  llvm.func @cmpeq_xor_cst1_commuted(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mul %arg1, %arg1  : i32
    %2 = llvm.xor %1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_cmpeq_xor_cst1_commuted   : cmpeq_xor_cst1_commuted_before  ⊑  cmpeq_xor_cst1_commuted_combined := by
  unfold cmpeq_xor_cst1_commuted_before cmpeq_xor_cst1_commuted_combined
  simp_alive_peephole
  sorry
def cmpeq_xor_cst1_vec_combined := [llvmfunc|
  llvm.func @cmpeq_xor_cst1_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[10, 11]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %arg1  : vector<2xi32>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_cmpeq_xor_cst1_vec   : cmpeq_xor_cst1_vec_before  ⊑  cmpeq_xor_cst1_vec_combined := by
  unfold cmpeq_xor_cst1_vec_before cmpeq_xor_cst1_vec_combined
  simp_alive_peephole
  sorry
def foo1_combined := [llvmfunc|
  llvm.func @foo1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_foo1   : foo1_before  ⊑  foo1_combined := by
  unfold foo1_before foo1_combined
  simp_alive_peephole
  sorry
def foo2_combined := [llvmfunc|
  llvm.func @foo2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_foo2   : foo2_before  ⊑  foo2_combined := by
  unfold foo2_before foo2_combined
  simp_alive_peephole
  sorry
def foo3_combined := [llvmfunc|
  llvm.func @foo3(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-2, -1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[9, 79]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_foo3   : foo3_before  ⊑  foo3_combined := by
  unfold foo3_before foo3_combined
  simp_alive_peephole
  sorry
def fold_xorC_eq0_multiuse_combined := [llvmfunc|
  llvm.func @fold_xorC_eq0_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.xor %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    llvm.return %2 : i1
  }]

theorem inst_combine_fold_xorC_eq0_multiuse   : fold_xorC_eq0_multiuse_before  ⊑  fold_xorC_eq0_multiuse_combined := by
  unfold fold_xorC_eq0_multiuse_before fold_xorC_eq0_multiuse_combined
  simp_alive_peephole
  sorry
def fold_xorC_eq1_multiuse_fail_combined := [llvmfunc|
  llvm.func @fold_xorC_eq1_multiuse_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.xor %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.call @use.i8(%1) : (i8) -> ()
    llvm.return %2 : i1
  }]

theorem inst_combine_fold_xorC_eq1_multiuse_fail   : fold_xorC_eq1_multiuse_fail_before  ⊑  fold_xorC_eq1_multiuse_fail_combined := by
  unfold fold_xorC_eq1_multiuse_fail_before fold_xorC_eq1_multiuse_fail_combined
  simp_alive_peephole
  sorry
def fold_xorC_neC_multiuse_combined := [llvmfunc|
  llvm.func @fold_xorC_neC_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(45 : i8) : i8
    %1 = llvm.mlir.constant(67 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.return %3 : i1
  }]

theorem inst_combine_fold_xorC_neC_multiuse   : fold_xorC_neC_multiuse_before  ⊑  fold_xorC_neC_multiuse_combined := by
  unfold fold_xorC_neC_multiuse_before fold_xorC_neC_multiuse_combined
  simp_alive_peephole
  sorry
