import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strcmp-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @strcmp(%2, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %3 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @strcmp(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %3 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3() -> i32 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.call @strcmp(%1, %3) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4() -> i32 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %4 = llvm.mlir.addressof @null : !llvm.ptr
    %5 = llvm.call @strcmp(%1, %4) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant("bell\00") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @bell : !llvm.ptr
    %4 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %5 = llvm.mlir.addressof @hello : !llvm.ptr
    %6 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %7 = llvm.call @strcmp(%5, %6) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %7 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.call @strcmp(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %0 : i32
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant("bell\00") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @bell : !llvm.ptr
    %4 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %5 = llvm.mlir.addressof @hello : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %8 = llvm.call @strcmp(%5, %7) : (!llvm.ptr, !llvm.ptr) -> i32
    %9 = llvm.icmp "eq" %8, %6 : i32
    llvm.return %9 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
    %2 = llvm.zext %1 : i8 to i32
    %3 = llvm.sub %0, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3() -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant("bell\00") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @bell : !llvm.ptr
    %4 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %5 = llvm.mlir.addressof @hello : !llvm.ptr
    %6 = llvm.mlir.constant(5 : i32) : i32
    %7 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %8 = llvm.call @memcmp(%5, %7, %6) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %8 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant("bell\00") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @bell : !llvm.ptr
    %4 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %5 = llvm.mlir.addressof @hello : !llvm.ptr
    %6 = llvm.mlir.constant(5 : i32) : i32
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %9 = llvm.call @memcmp(%5, %8, %6) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %10 = llvm.icmp "eq" %9, %7 : i32
    llvm.return %10 : i1
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
