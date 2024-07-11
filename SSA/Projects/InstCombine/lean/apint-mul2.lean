import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-mul2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i177) -> i177 {
    %0 = llvm.mlir.constant(1 : i177) : i177
    %1 = llvm.mlir.constant(155 : i177) : i177
    %2 = llvm.shl %0, %1  : i177
    %3 = llvm.mul %arg0, %2  : i177
    llvm.return %3 : i177
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: vector<2xi177>) -> vector<2xi177> {
    %0 = llvm.mlir.constant(1 : i177) : i177
    %1 = llvm.mlir.constant(dense<1> : vector<2xi177>) : vector<2xi177>
    %2 = llvm.mlir.constant(155 : i177) : i177
    %3 = llvm.mlir.constant(dense<155> : vector<2xi177>) : vector<2xi177>
    %4 = llvm.shl %1, %3  : vector<2xi177>
    %5 = llvm.mul %arg0, %4  : vector<2xi177>
    llvm.return %5 : vector<2xi177>
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: vector<2xi177>) -> vector<2xi177> {
    %0 = llvm.mlir.constant(1 : i177) : i177
    %1 = llvm.mlir.constant(dense<1> : vector<2xi177>) : vector<2xi177>
    %2 = llvm.mlir.constant(155 : i177) : i177
    %3 = llvm.mlir.constant(150 : i177) : i177
    %4 = llvm.mlir.constant(dense<[150, 155]> : vector<2xi177>) : vector<2xi177>
    %5 = llvm.shl %1, %4  : vector<2xi177>
    %6 = llvm.mul %arg0, %5  : vector<2xi177>
    llvm.return %6 : vector<2xi177>
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i177) -> i177 {
    %0 = llvm.mlir.constant(155 : i177) : i177
    %1 = llvm.shl %arg0, %0  : i177
    llvm.return %1 : i177
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: vector<2xi177>) -> vector<2xi177> {
    %0 = llvm.mlir.constant(155 : i177) : i177
    %1 = llvm.mlir.constant(dense<155> : vector<2xi177>) : vector<2xi177>
    %2 = llvm.shl %arg0, %1  : vector<2xi177>
    llvm.return %2 : vector<2xi177>
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: vector<2xi177>) -> vector<2xi177> {
    %0 = llvm.mlir.constant(155 : i177) : i177
    %1 = llvm.mlir.constant(150 : i177) : i177
    %2 = llvm.mlir.constant(dense<[150, 155]> : vector<2xi177>) : vector<2xi177>
    %3 = llvm.shl %arg0, %2  : vector<2xi177>
    llvm.return %3 : vector<2xi177>
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
