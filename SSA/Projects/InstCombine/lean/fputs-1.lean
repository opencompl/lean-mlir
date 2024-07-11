import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fputs-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.call @fputs(%2, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("A\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @A : !llvm.ptr
    %2 = llvm.call @fputs(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello\0A\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.call @fputs(%1, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr) {
    llvm.return
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(65 : i32) : i32
    %1 = llvm.call @fputc(%0, %arg0) : (i32, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello\0A\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.call @fwrite(%1, %2, %3, %arg0) : (!llvm.ptr, i32, i32, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
