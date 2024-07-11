import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fprintf-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_c : !llvm.ptr
    %2 = llvm.mlir.constant(104 : i8) : i8
    %3 = llvm.call @fprintf(%arg0, %1, %2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i8) -> i32
    llvm.return
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_s : !llvm.ptr
    %2 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %3 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %4 = llvm.call @fprintf(%arg0, %1, %3) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test_simplify4_before := [llvmfunc|
  llvm.func @test_simplify4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%d\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_d : !llvm.ptr
    %2 = llvm.mlir.constant(187 : i32) : i32
    %3 = llvm.call @fprintf(%arg0, %1, %2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return
  }]

def test_simplify5_before := [llvmfunc|
  llvm.func @test_simplify5(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test_no_simplify1_before := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%f\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_f : !llvm.ptr
    %2 = llvm.mlir.constant(1.870000e+00 : f64) : f64
    %3 = llvm.call @fprintf(%arg0, %1, %2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
    llvm.return
  }]

def test_no_simplify2_before := [llvmfunc|
  llvm.func @test_no_simplify2(%arg0: !llvm.ptr, %arg1: f64) {
    %0 = llvm.mlir.constant("%f\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_f : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1, %arg1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
    llvm.return
  }]

def test_no_simplify3_before := [llvmfunc|
  llvm.func @test_no_simplify3(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

def test_no_simplify4_before := [llvmfunc|
  llvm.func @test_no_simplify4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%m\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_m : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %2 = llvm.mlir.constant(12 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.call @fwrite(%1, %2, %3, %arg0) : (!llvm.ptr, i32, i32, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(104 : i32) : i32
    %1 = llvm.call @fputc(%0, %arg0) : (i32, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %2 = llvm.mlir.constant(12 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.call @fwrite(%1, %2, %3, %arg0) : (!llvm.ptr, i32, i32, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
def test_simplify4_combined := [llvmfunc|
  llvm.func @test_simplify4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%d\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_d : !llvm.ptr
    %2 = llvm.mlir.constant(187 : i32) : i32
    %3 = llvm.call @fprintf(%arg0, %1, %2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return
  }]

theorem inst_combine_test_simplify4   : test_simplify4_before  ⊑  test_simplify4_combined := by
  unfold test_simplify4_before test_simplify4_combined
  simp_alive_peephole
  sorry
def test_simplify5_combined := [llvmfunc|
  llvm.func @test_simplify5(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %2 = llvm.mlir.constant(12 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.call @fwrite(%1, %2, %3, %arg0) : (!llvm.ptr, i32, i32, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test_simplify5   : test_simplify5_before  ⊑  test_simplify5_combined := by
  unfold test_simplify5_before test_simplify5_combined
  simp_alive_peephole
  sorry
def test_no_simplify1_combined := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%f\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_f : !llvm.ptr
    %2 = llvm.mlir.constant(1.870000e+00 : f64) : f64
    %3 = llvm.call @fprintf(%arg0, %1, %2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_test_no_simplify1   : test_no_simplify1_before  ⊑  test_no_simplify1_combined := by
  unfold test_no_simplify1_before test_no_simplify1_combined
  simp_alive_peephole
  sorry
def test_no_simplify2_combined := [llvmfunc|
  llvm.func @test_no_simplify2(%arg0: !llvm.ptr, %arg1: f64) {
    %0 = llvm.mlir.constant("%f\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_f : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1, %arg1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
    llvm.return
  }]

theorem inst_combine_test_no_simplify2   : test_no_simplify2_before  ⊑  test_no_simplify2_combined := by
  unfold test_no_simplify2_before test_no_simplify2_combined
  simp_alive_peephole
  sorry
def test_no_simplify3_combined := [llvmfunc|
  llvm.func @test_no_simplify3(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_no_simplify3   : test_no_simplify3_before  ⊑  test_no_simplify3_combined := by
  unfold test_no_simplify3_before test_no_simplify3_combined
  simp_alive_peephole
  sorry
def test_no_simplify4_combined := [llvmfunc|
  llvm.func @test_no_simplify4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%m\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_m : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test_no_simplify4   : test_no_simplify4_before  ⊑  test_no_simplify4_combined := by
  unfold test_no_simplify4_before test_no_simplify4_combined
  simp_alive_peephole
  sorry
