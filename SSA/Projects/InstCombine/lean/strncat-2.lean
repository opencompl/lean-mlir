import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strncat-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @hello : !llvm.ptr
    %5 = llvm.mlir.constant(13 : i32) : i32
    %6 = llvm.call @strncat(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %4 = llvm.mlir.addressof @empty : !llvm.ptr
    %5 = llvm.mlir.constant(13 : i32) : i32
    %6 = llvm.call @strncat(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @hello : !llvm.ptr
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.call @strncat(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return
  }]

def test_nosimplify1_before := [llvmfunc|
  llvm.func @test_nosimplify1() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @hello : !llvm.ptr
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.call @strncat(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @strncat(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @strncat(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.call @strncat(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.call @strncat(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strncat(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @hello : !llvm.ptr
    %5 = llvm.mlir.constant(6 : i32) : i32
    %6 = llvm.call @strlen(%2) : (!llvm.ptr) -> i32
    %7 = llvm.getelementptr inbounds %2[%6] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    "llvm.intr.memcpy"(%7, %4, %5) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2() {
    llvm.return
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3() {
    llvm.return
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
def test_nosimplify1_combined := [llvmfunc|
  llvm.func @test_nosimplify1() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @hello : !llvm.ptr
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.call @strncat(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test_nosimplify1   : test_nosimplify1_before  ⊑  test_nosimplify1_combined := by
  unfold test_nosimplify1_before test_nosimplify1_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @strncat(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.call @strncat(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.call @strncat(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    %4 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    "llvm.intr.memcpy"(%4, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
