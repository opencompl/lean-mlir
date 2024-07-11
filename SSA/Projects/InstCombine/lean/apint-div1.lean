import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-div1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(4096 : i33) : i33
    %1 = llvm.udiv %arg0, %0  : i33
    llvm.return %1 : i33
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i49) -> i49 {
    %0 = llvm.mlir.constant(4096 : i49) : i49
    %1 = llvm.mlir.constant(17 : i49) : i49
    %2 = llvm.shl %0, %1  : i49
    %3 = llvm.udiv %arg0, %2  : i49
    llvm.return %3 : i49
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i59, %arg1: i1) -> i59 {
    %0 = llvm.mlir.constant(1024 : i59) : i59
    %1 = llvm.mlir.constant(4096 : i59) : i59
    %2 = llvm.select %arg1, %0, %1 : i1, i59
    %3 = llvm.udiv %arg0, %2  : i59
    llvm.return %3 : i59
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(12 : i33) : i33
    %1 = llvm.lshr %arg0, %0  : i33
    llvm.return %1 : i33
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i49) -> i49 {
    %0 = llvm.mlir.constant(29 : i49) : i49
    %1 = llvm.lshr %arg0, %0  : i49
    llvm.return %1 : i49
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i59, %arg1: i1) -> i59 {
    %0 = llvm.mlir.constant(10 : i59) : i59
    %1 = llvm.mlir.constant(12 : i59) : i59
    %2 = llvm.select %arg1, %0, %1 : i1, i59
    %3 = llvm.lshr %arg0, %2  : i59
    llvm.return %3 : i59
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
