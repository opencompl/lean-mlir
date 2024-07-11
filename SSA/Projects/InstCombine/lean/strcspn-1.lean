import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strcspn-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @strcspn(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.return %3 : i64
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @strcspn(%2, %arg0) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.return %3 : i64
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3() -> i64 {
    %0 = llvm.mlir.constant("abcba\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @abcba : !llvm.ptr
    %2 = llvm.mlir.constant("abc\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @abc : !llvm.ptr
    %4 = llvm.call @strcspn(%1, %3) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.return %4 : i64
  }]

def test_no_simplify1_before := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i64 {
    %0 = llvm.call @strcspn(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.return %0 : i64
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
def test_no_simplify1_combined := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i64 {
    %0 = llvm.call @strcspn(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test_no_simplify1   : test_no_simplify1_before  ⊑  test_no_simplify1_combined := by
  unfold test_no_simplify1_before test_no_simplify1_combined
  simp_alive_peephole
  sorry
