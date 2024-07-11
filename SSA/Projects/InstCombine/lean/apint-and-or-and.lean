import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-and-or-and
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i17, %arg1: i17) -> i17 {
    %0 = llvm.mlir.constant(7 : i17) : i17
    %1 = llvm.mlir.constant(8 : i17) : i17
    %2 = llvm.and %arg0, %0  : i17
    %3 = llvm.and %arg1, %1  : i17
    %4 = llvm.or %2, %3  : i17
    %5 = llvm.and %4, %0  : i17
    llvm.return %5 : i17
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i49, %arg1: i49) -> i49 {
    %0 = llvm.mlir.constant(1 : i49) : i49
    %1 = llvm.shl %arg1, %0  : i49
    %2 = llvm.or %arg0, %1  : i49
    %3 = llvm.and %2, %0  : i49
    llvm.return %3 : i49
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i67, %arg1: i67) -> i67 {
    %0 = llvm.mlir.constant(66 : i67) : i67
    %1 = llvm.mlir.constant(2 : i67) : i67
    %2 = llvm.lshr %arg1, %0  : i67
    %3 = llvm.or %arg0, %2  : i67
    %4 = llvm.and %3, %1  : i67
    llvm.return %4 : i67
  }]

def or_test1_before := [llvmfunc|
  llvm.func @or_test1(%arg0: i231, %arg1: i231) -> i231 {
    %0 = llvm.mlir.constant(1 : i231) : i231
    %1 = llvm.and %arg0, %0  : i231
    %2 = llvm.or %1, %0  : i231
    llvm.return %2 : i231
  }]

def or_test2_before := [llvmfunc|
  llvm.func @or_test2(%arg0: i7, %arg1: i7) -> i7 {
    %0 = llvm.mlir.constant(6 : i7) : i7
    %1 = llvm.mlir.constant(-64 : i7) : i7
    %2 = llvm.shl %arg0, %0  : i7
    %3 = llvm.or %2, %1  : i7
    llvm.return %3 : i7
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i17, %arg1: i17) -> i17 {
    %0 = llvm.mlir.constant(7 : i17) : i17
    %1 = llvm.and %arg0, %0  : i17
    llvm.return %1 : i17
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i49, %arg1: i49) -> i49 {
    %0 = llvm.mlir.constant(1 : i49) : i49
    %1 = llvm.and %arg0, %0  : i49
    llvm.return %1 : i49
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i67, %arg1: i67) -> i67 {
    %0 = llvm.mlir.constant(2 : i67) : i67
    %1 = llvm.and %arg0, %0  : i67
    llvm.return %1 : i67
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def or_test1_combined := [llvmfunc|
  llvm.func @or_test1(%arg0: i231, %arg1: i231) -> i231 {
    %0 = llvm.mlir.constant(1 : i231) : i231
    llvm.return %0 : i231
  }]

theorem inst_combine_or_test1   : or_test1_before  ⊑  or_test1_combined := by
  unfold or_test1_before or_test1_combined
  simp_alive_peephole
  sorry
def or_test2_combined := [llvmfunc|
  llvm.func @or_test2(%arg0: i7, %arg1: i7) -> i7 {
    %0 = llvm.mlir.constant(-64 : i7) : i7
    llvm.return %0 : i7
  }]

theorem inst_combine_or_test2   : or_test2_before  ⊑  or_test2_combined := by
  unfold or_test2_before or_test2_combined
  simp_alive_peephole
  sorry
