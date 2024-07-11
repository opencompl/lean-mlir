import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-shl-trunc
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test0_before := [llvmfunc|
  llvm.func @test0(%arg0: i39, %arg1: i39) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i39
    %1 = llvm.trunc %0 : i39 to i1
    llvm.return %1 : i1
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i799, %arg1: i799) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i799
    %1 = llvm.trunc %0 : i799 to i1
    llvm.return %1 : i1
  }]

def test0vec_before := [llvmfunc|
  llvm.func @test0vec(%arg0: vector<2xi39>, %arg1: vector<2xi39>) -> vector<2xi1> {
    %0 = llvm.lshr %arg0, %arg1  : vector<2xi39>
    %1 = llvm.trunc %0 : vector<2xi39> to vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

def test0_combined := [llvmfunc|
  llvm.func @test0(%arg0: i39, %arg1: i39) -> i1 {
    %0 = llvm.mlir.constant(1 : i39) : i39
    %1 = llvm.mlir.constant(0 : i39) : i39
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i39
    %3 = llvm.and %2, %arg0  : i39
    %4 = llvm.icmp "ne" %3, %1 : i39
    llvm.return %4 : i1
  }]

theorem inst_combine_test0   : test0_before  ⊑  test0_combined := by
  unfold test0_before test0_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i799, %arg1: i799) -> i1 {
    %0 = llvm.mlir.constant(1 : i799) : i799
    %1 = llvm.mlir.constant(0 : i799) : i799
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i799
    %3 = llvm.and %2, %arg0  : i799
    %4 = llvm.icmp "ne" %3, %1 : i799
    llvm.return %4 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test0vec_combined := [llvmfunc|
  llvm.func @test0vec(%arg0: vector<2xi39>, %arg1: vector<2xi39>) -> vector<2xi1> {
    %0 = llvm.lshr %arg0, %arg1  : vector<2xi39>
    %1 = llvm.trunc %0 : vector<2xi39> to vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test0vec   : test0vec_before  ⊑  test0vec_combined := by
  unfold test0vec_before test0vec_combined
  simp_alive_peephole
  sorry
