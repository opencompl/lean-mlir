import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strncmp-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.call @strncmp(%2, %arg0, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %4 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %4 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3() -> i32 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.mlir.constant(10 : i32) : i32
    %5 = llvm.call @strncmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %5 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4() -> i32 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %4 = llvm.mlir.addressof @null : !llvm.ptr
    %5 = llvm.mlir.constant(10 : i32) : i32
    %6 = llvm.call @strncmp(%1, %4, %5) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %6 : i32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5() -> i32 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.call @strncmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %5 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.call @strncmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @strncmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: !llvm.ptr, %arg1: i32) -> i32 {
    %0 = llvm.call @strncmp(%arg0, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %0 : i32
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> i32 {
    %0 = llvm.call @strncmp(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %0 : i32
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @strncmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.call @strncmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.call @strncmp(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %0 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
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
    %0 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
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
  llvm.func @test5() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %1 = llvm.zext %0 : i8 to i32
    %2 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.sub %1, %3 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: !llvm.ptr, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> i32 {
    %0 = llvm.call @strncmp(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.call @strncmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.call @strncmp(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
