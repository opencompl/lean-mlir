import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strstr-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @strstr(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("a\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %2 = llvm.call @strstr(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3() -> !llvm.ptr {
    %0 = llvm.mlir.constant("abcde\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.mlir.constant("bcd\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @".str3" : !llvm.ptr
    %4 = llvm.call @strstr(%1, %3) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def test_simplify4_before := [llvmfunc|
  llvm.func @test_simplify4(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.call @strstr(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test_simplify5_before := [llvmfunc|
  llvm.func @test_simplify5(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.call @strstr(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    %1 = llvm.icmp "eq" %0, %arg0 : !llvm.ptr
    llvm.return %1 : i1
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.call @strstr(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.ptr attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.call @strstr(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(97 : i32) : i32
    %1 = llvm.call @strchr(%arg0, %0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3() -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("abcde\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
def test_simplify4_combined := [llvmfunc|
  llvm.func @test_simplify4(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_test_simplify4   : test_simplify4_before  ⊑  test_simplify4_combined := by
  unfold test_simplify4_before test_simplify4_combined
  simp_alive_peephole
  sorry
def test_simplify5_combined := [llvmfunc|
  llvm.func @test_simplify5(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @strlen(%arg1) : (!llvm.ptr) -> i64
    %2 = llvm.call @strncmp(%arg0, %arg1, %1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test_simplify5   : test_simplify5_before  ⊑  test_simplify5_combined := by
  unfold test_simplify5_before test_simplify5_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.call @strstr(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.ptr attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.call @strstr(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
