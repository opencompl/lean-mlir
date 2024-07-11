import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-and-compare
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i33, %arg1: i33) -> i1 {
    %0 = llvm.mlir.constant(65280 : i33) : i33
    %1 = llvm.and %arg0, %0  : i33
    %2 = llvm.and %arg1, %0  : i33
    %3 = llvm.icmp "ne" %1, %2 : i33
    llvm.return %3 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i999, %arg1: i999) -> i1 {
    %0 = llvm.mlir.constant(65280 : i999) : i999
    %1 = llvm.and %arg0, %0  : i999
    %2 = llvm.and %arg1, %0  : i999
    %3 = llvm.icmp "ne" %1, %2 : i999
    llvm.return %3 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i33, %arg1: i33) -> i1 {
    %0 = llvm.mlir.constant(65280 : i33) : i33
    %1 = llvm.mlir.constant(0 : i33) : i33
    %2 = llvm.xor %arg0, %arg1  : i33
    %3 = llvm.and %2, %0  : i33
    %4 = llvm.icmp "ne" %3, %1 : i33
    llvm.return %4 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i999, %arg1: i999) -> i1 {
    %0 = llvm.mlir.constant(65280 : i999) : i999
    %1 = llvm.mlir.constant(0 : i999) : i999
    %2 = llvm.xor %arg0, %arg1  : i999
    %3 = llvm.and %2, %0  : i999
    %4 = llvm.icmp "ne" %3, %1 : i999
    llvm.return %4 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
