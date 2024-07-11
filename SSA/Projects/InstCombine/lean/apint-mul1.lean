import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-mul1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i17) -> i17 {
    %0 = llvm.mlir.constant(1024 : i17) : i17
    %1 = llvm.mul %arg0, %0  : i17
    llvm.return %1 : i17
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.constant(1024 : i17) : i17
    %1 = llvm.mlir.constant(dense<1024> : vector<2xi17>) : vector<2xi17>
    %2 = llvm.mul %arg0, %1  : vector<2xi17>
    llvm.return %2 : vector<2xi17>
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.constant(256 : i17) : i17
    %1 = llvm.mlir.constant(1024 : i17) : i17
    %2 = llvm.mlir.constant(dense<[1024, 256]> : vector<2xi17>) : vector<2xi17>
    %3 = llvm.mul %arg0, %2  : vector<2xi17>
    llvm.return %3 : vector<2xi17>
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i17) -> i17 {
    %0 = llvm.mlir.constant(10 : i17) : i17
    %1 = llvm.shl %arg0, %0  : i17
    llvm.return %1 : i17
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.constant(10 : i17) : i17
    %1 = llvm.mlir.constant(dense<10> : vector<2xi17>) : vector<2xi17>
    %2 = llvm.shl %arg0, %1  : vector<2xi17>
    llvm.return %2 : vector<2xi17>
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.constant(8 : i17) : i17
    %1 = llvm.mlir.constant(10 : i17) : i17
    %2 = llvm.mlir.constant(dense<[10, 8]> : vector<2xi17>) : vector<2xi17>
    %3 = llvm.shl %arg0, %2  : vector<2xi17>
    llvm.return %3 : vector<2xi17>
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
