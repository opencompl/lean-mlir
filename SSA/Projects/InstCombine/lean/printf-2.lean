import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  printf-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1() {
    %0 = llvm.mlir.constant("h\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @h : !llvm.ptr
    %2 = llvm.call @printf(%1) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    llvm.return
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2() {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %2 = llvm.call @printf(%1) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    llvm.return
  }]

def test_simplify6_before := [llvmfunc|
  llvm.func @test_simplify6() {
    %0 = llvm.mlir.constant("%s\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @percent_s : !llvm.ptr
    %2 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %3 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %4 = llvm.call @printf(%1, %3) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test_simplify7_before := [llvmfunc|
  llvm.func @test_simplify7() {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @format_str : !llvm.ptr
    %2 = llvm.mlir.constant("a\00") : !llvm.array<2 x i8>
    %3 = llvm.mlir.addressof @charstr : !llvm.ptr
    %4 = llvm.call @printf(%1, %3) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test_simplify8_before := [llvmfunc|
  llvm.func @test_simplify8() {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @format_str : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %4 = llvm.mlir.addressof @empty : !llvm.ptr
    %5 = llvm.call @printf(%1, %4) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test_simplify9_before := [llvmfunc|
  llvm.func @test_simplify9() {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @format_str : !llvm.ptr
    %2 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %3 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %4 = llvm.call @printf(%1, %3) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def test_simplify10_before := [llvmfunc|
  llvm.func @test_simplify10() {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @format_str : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %4 = llvm.mlir.addressof @empty : !llvm.ptr
    %5 = llvm.mlir.constant(42 : i32) : i32
    %6 = llvm.mlir.constant(3.1400001049041748 : f64) : f64
    %7 = llvm.mlir.constant("a\00") : !llvm.array<2 x i8>
    %8 = llvm.mlir.addressof @charstr : !llvm.ptr
    %9 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %10 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %11 = llvm.call @printf(%1, %4, %5, %6) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i32, f64) -> i32
    %12 = llvm.call @printf(%1, %8, %5, %6) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i32, f64) -> i32
    %13 = llvm.call @printf(%1, %10, %5, %6) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i32, f64) -> i32
    llvm.return
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1() {
    %0 = llvm.mlir.constant(104 : i32) : i32
    %1 = llvm.call @putchar(%0) : (i32) -> i32
    llvm.return
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2() {
    %0 = llvm.mlir.constant("hello world\00") : !llvm.array<12 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr
    %2 = llvm.call @puts(%1) : (!llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify6_combined := [llvmfunc|
  llvm.func @test_simplify6() {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %2 = llvm.call @puts(%1) : (!llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test_simplify6   : test_simplify6_before  ⊑  test_simplify6_combined := by
  unfold test_simplify6_before test_simplify6_combined
  simp_alive_peephole
  sorry
def test_simplify7_combined := [llvmfunc|
  llvm.func @test_simplify7() {
    %0 = llvm.mlir.constant(97 : i32) : i32
    %1 = llvm.call @putchar(%0) : (i32) -> i32
    llvm.return
  }]

theorem inst_combine_test_simplify7   : test_simplify7_before  ⊑  test_simplify7_combined := by
  unfold test_simplify7_before test_simplify7_combined
  simp_alive_peephole
  sorry
def test_simplify8_combined := [llvmfunc|
  llvm.func @test_simplify8() {
    llvm.return
  }]

theorem inst_combine_test_simplify8   : test_simplify8_before  ⊑  test_simplify8_combined := by
  unfold test_simplify8_before test_simplify8_combined
  simp_alive_peephole
  sorry
def test_simplify9_combined := [llvmfunc|
  llvm.func @test_simplify9() {
    %0 = llvm.mlir.constant("hello world\00") : !llvm.array<12 x i8>
    %1 = llvm.mlir.addressof @str.1 : !llvm.ptr
    %2 = llvm.call @puts(%1) : (!llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test_simplify9   : test_simplify9_before  ⊑  test_simplify9_combined := by
  unfold test_simplify9_before test_simplify9_combined
  simp_alive_peephole
  sorry
def test_simplify10_combined := [llvmfunc|
  llvm.func @test_simplify10() {
    %0 = llvm.mlir.constant(97 : i32) : i32
    %1 = llvm.mlir.constant("hello world\00") : !llvm.array<12 x i8>
    %2 = llvm.mlir.addressof @str.2 : !llvm.ptr
    %3 = llvm.call @putchar(%0) : (i32) -> i32
    %4 = llvm.call @puts(%2) : (!llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_test_simplify10   : test_simplify10_before  ⊑  test_simplify10_combined := by
  unfold test_simplify10_before test_simplify10_combined
  simp_alive_peephole
  sorry
