import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  srem-canonicalize
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_srem_canonicalize_op0_before := [llvmfunc|
  llvm.func @test_srem_canonicalize_op0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.srem %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def test_srem_canonicalize_op1_before := [llvmfunc|
  llvm.func @test_srem_canonicalize_op1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.srem %2, %3  : i32
    llvm.return %4 : i32
  }]

def test_srem_canonicalize_nonsw_before := [llvmfunc|
  llvm.func @test_srem_canonicalize_nonsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.srem %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def test_srem_canonicalize_vec_before := [llvmfunc|
  llvm.func @test_srem_canonicalize_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %1, %arg0 overflow<nsw>  : vector<2xi32>
    %3 = llvm.srem %2, %arg1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def test_srem_canonicalize_multiple_uses_before := [llvmfunc|
  llvm.func @test_srem_canonicalize_multiple_uses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.srem %1, %arg1  : i32
    %3 = llvm.srem %2, %1  : i32
    llvm.return %3 : i32
  }]

def test_srem_canonicalize_op0_combined := [llvmfunc|
  llvm.func @test_srem_canonicalize_op0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.srem %arg0, %arg1  : i32
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_srem_canonicalize_op0   : test_srem_canonicalize_op0_before  ⊑  test_srem_canonicalize_op0_combined := by
  unfold test_srem_canonicalize_op0_before test_srem_canonicalize_op0_combined
  simp_alive_peephole
  sorry
def test_srem_canonicalize_op1_combined := [llvmfunc|
  llvm.func @test_srem_canonicalize_op1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.srem %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_srem_canonicalize_op1   : test_srem_canonicalize_op1_before  ⊑  test_srem_canonicalize_op1_combined := by
  unfold test_srem_canonicalize_op1_before test_srem_canonicalize_op1_combined
  simp_alive_peephole
  sorry
def test_srem_canonicalize_nonsw_combined := [llvmfunc|
  llvm.func @test_srem_canonicalize_nonsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.srem %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_srem_canonicalize_nonsw   : test_srem_canonicalize_nonsw_before  ⊑  test_srem_canonicalize_nonsw_combined := by
  unfold test_srem_canonicalize_nonsw_before test_srem_canonicalize_nonsw_combined
  simp_alive_peephole
  sorry
def test_srem_canonicalize_vec_combined := [llvmfunc|
  llvm.func @test_srem_canonicalize_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.srem %arg0, %arg1  : vector<2xi32>
    %3 = llvm.sub %1, %2 overflow<nsw>  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test_srem_canonicalize_vec   : test_srem_canonicalize_vec_before  ⊑  test_srem_canonicalize_vec_combined := by
  unfold test_srem_canonicalize_vec_before test_srem_canonicalize_vec_combined
  simp_alive_peephole
  sorry
def test_srem_canonicalize_multiple_uses_combined := [llvmfunc|
  llvm.func @test_srem_canonicalize_multiple_uses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.srem %1, %arg1  : i32
    %3 = llvm.srem %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_srem_canonicalize_multiple_uses   : test_srem_canonicalize_multiple_uses_before  ⊑  test_srem_canonicalize_multiple_uses_combined := by
  unfold test_srem_canonicalize_multiple_uses_before test_srem_canonicalize_multiple_uses_combined
  simp_alive_peephole
  sorry
