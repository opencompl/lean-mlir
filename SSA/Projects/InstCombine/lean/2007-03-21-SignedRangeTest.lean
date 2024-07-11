import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-03-21-SignedRangeTest
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-6 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test_vec_before := [llvmfunc|
  llvm.func @test_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-6> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(71 : i32) : i32
    %1 = llvm.mlir.constant(-12 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def test_vec_combined := [llvmfunc|
  llvm.func @test_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<71> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-12> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_test_vec   : test_vec_before  ⊑  test_vec_combined := by
  unfold test_vec_before test_vec_combined
  simp_alive_peephole
  sorry
