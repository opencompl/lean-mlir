import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strpbrk-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @strpbrk(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @strpbrk(%2, %arg0) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello world\00") : !llvm.array<12 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant("w\00") : !llvm.array<2 x i8>
    %3 = llvm.mlir.addressof @w : !llvm.ptr
    %4 = llvm.call @strpbrk(%1, %3) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def test_simplify4_before := [llvmfunc|
  llvm.func @test_simplify4(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("w\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @w : !llvm.ptr
    %2 = llvm.call @strpbrk(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def test_no_simplify1_before := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.call @strpbrk(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3() -> !llvm.ptr {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("hello world\00") : !llvm.array<12 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<12 x i8>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
def test_simplify4_combined := [llvmfunc|
  llvm.func @test_simplify4(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(119 : i32) : i32
    %1 = llvm.call @strchr(%arg0, %0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test_simplify4   : test_simplify4_before  ⊑  test_simplify4_combined := by
  unfold test_simplify4_before test_simplify4_combined
  simp_alive_peephole
  sorry
def test_no_simplify1_combined := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.call @strpbrk(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test_no_simplify1   : test_no_simplify1_before  ⊑  test_no_simplify1_combined := by
  unfold test_no_simplify1_before test_no_simplify1_combined
  simp_alive_peephole
  sorry
