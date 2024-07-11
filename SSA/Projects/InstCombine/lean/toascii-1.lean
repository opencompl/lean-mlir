import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  toascii-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @toascii(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.call @toascii(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3() -> i32 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.call @toascii(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def test_simplify4_before := [llvmfunc|
  llvm.func @test_simplify4() -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.call @toascii(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def test_simplify5_before := [llvmfunc|
  llvm.func @test_simplify5() -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.call @toascii(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def test_simplify6_before := [llvmfunc|
  llvm.func @test_simplify6() -> i32 {
    %0 = llvm.mlir.constant(256 : i32) : i32
    %1 = llvm.call @toascii(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def test_simplify7_before := [llvmfunc|
  llvm.func @test_simplify7(%arg0: i32) -> i32 {
    %0 = llvm.call @toascii(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3() -> i32 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
def test_simplify4_combined := [llvmfunc|
  llvm.func @test_simplify4() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify4   : test_simplify4_before  ⊑  test_simplify4_combined := by
  unfold test_simplify4_before test_simplify4_combined
  simp_alive_peephole
  sorry
def test_simplify5_combined := [llvmfunc|
  llvm.func @test_simplify5() -> i32 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify5   : test_simplify5_before  ⊑  test_simplify5_combined := by
  unfold test_simplify5_before test_simplify5_combined
  simp_alive_peephole
  sorry
def test_simplify6_combined := [llvmfunc|
  llvm.func @test_simplify6() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify6   : test_simplify6_before  ⊑  test_simplify6_combined := by
  unfold test_simplify6_before test_simplify6_combined
  simp_alive_peephole
  sorry
def test_simplify7_combined := [llvmfunc|
  llvm.func @test_simplify7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_simplify7   : test_simplify7_before  ⊑  test_simplify7_combined := by
  unfold test_simplify7_before test_simplify7_combined
  simp_alive_peephole
  sorry
