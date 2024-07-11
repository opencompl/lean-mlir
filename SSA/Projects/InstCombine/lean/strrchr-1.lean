import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strrchr-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @chp : !llvm.ptr
    %5 = llvm.call @strrchr(%1, %2) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.store %5, %4 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.mlir.constant(119 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.addressof @chp : !llvm.ptr
    %6 = llvm.call @strrchr(%2, %3) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.store %6, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @chp : !llvm.ptr
    %5 = llvm.call @strrchr(%1, %2) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.store %5, %4 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test_simplify4_before := [llvmfunc|
  llvm.func @test_simplify4() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(65280 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @chp : !llvm.ptr
    %5 = llvm.call @strrchr(%1, %2) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.store %5, %4 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test_xform_to_memrchr_before := [llvmfunc|
  llvm.func @test_xform_to_memrchr(%arg0: i32) {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.addressof @chp : !llvm.ptr
    %4 = llvm.call @strrchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.store %4, %3 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.call @strrchr(%arg0, %arg1) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.call @strrchr(%arg0, %arg1) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1() {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<14 x i8>
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.addressof @chp : !llvm.ptr
    llvm.store %4, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2() {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.addressof @chp : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3() {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<14 x i8>
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.addressof @chp : !llvm.ptr
    llvm.store %4, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
def test_simplify4_combined := [llvmfunc|
  llvm.func @test_simplify4() {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<14 x i8>
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.addressof @chp : !llvm.ptr
    llvm.store %4, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test_simplify4   : test_simplify4_before  ⊑  test_simplify4_combined := by
  unfold test_simplify4_before test_simplify4_combined
  simp_alive_peephole
  sorry
def test_xform_to_memrchr_combined := [llvmfunc|
  llvm.func @test_xform_to_memrchr(%arg0: i32) {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(14 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @chp : !llvm.ptr
    %5 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %5, %4 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test_xform_to_memrchr   : test_xform_to_memrchr_before  ⊑  test_xform_to_memrchr_combined := by
  unfold test_xform_to_memrchr_before test_xform_to_memrchr_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.call @strrchr(%arg0, %arg1) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.call @strrchr(%arg0, %arg1) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
