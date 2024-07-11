import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-rem2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i333) -> i333 {
    %0 = llvm.mlir.constant(70368744177664 : i333) : i333
    %1 = llvm.urem %arg0, %0  : i333
    llvm.return %1 : i333
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i499) -> i499 {
    %0 = llvm.mlir.constant(4096 : i499) : i499
    %1 = llvm.mlir.constant(111 : i499) : i499
    %2 = llvm.shl %0, %1  : i499
    %3 = llvm.urem %arg0, %2  : i499
    llvm.return %3 : i499
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i599, %arg1: i1) -> i599 {
    %0 = llvm.mlir.constant(70368744177664 : i599) : i599
    %1 = llvm.mlir.constant(4096 : i599) : i599
    %2 = llvm.select %arg1, %0, %1 : i1, i599
    %3 = llvm.urem %arg0, %2  : i599
    llvm.return %3 : i599
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i333) -> i333 {
    %0 = llvm.mlir.constant(70368744177663 : i333) : i333
    %1 = llvm.and %arg0, %0  : i333
    llvm.return %1 : i333
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i499) -> i499 {
    %0 = llvm.mlir.constant(10633823966279326983230456482242756607 : i499) : i499
    %1 = llvm.and %arg0, %0  : i499
    llvm.return %1 : i499
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i599, %arg1: i1) -> i599 {
    %0 = llvm.mlir.constant(70368744177663 : i599) : i599
    %1 = llvm.mlir.constant(4095 : i599) : i599
    %2 = llvm.select %arg1, %0, %1 : i1, i599
    %3 = llvm.and %2, %arg0  : i599
    llvm.return %3 : i599
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
