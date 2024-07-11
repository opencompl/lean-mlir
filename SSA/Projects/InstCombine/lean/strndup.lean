import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strndup
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.call @strndup(%2, %3) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def test2_before := [llvmfunc|
  llvm.func @test2() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.call @strndup(%1, %2) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def test3_before := [llvmfunc|
  llvm.func @test3() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.call @strndup(%1, %2) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def test4_before := [llvmfunc|
  llvm.func @test4() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(6 : i64) : i64
    %3 = llvm.call @strndup(%1, %2) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def test5_before := [llvmfunc|
  llvm.func @test5() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.call @strndup(%1, %2) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.call @strndup(%1, %arg0) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @strdup(%2) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.call @strndup(%1, %2) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.call @strdup(%1) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.call @strdup(%1) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.call @strdup(%1) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.call @strndup(%1, %arg0) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
