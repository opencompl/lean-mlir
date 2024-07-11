import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memchr
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.mlir.constant(14 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.addressof @chp : !llvm.ptr
    %6 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %6, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test2_before := [llvmfunc|
  llvm.func @test2() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.mlir.constant(119 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.addressof @chp : !llvm.ptr
    %7 = llvm.call @memchr(%2, %3, %4) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %7, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test3_before := [llvmfunc|
  llvm.func @test3() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(14 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.addressof @chp : !llvm.ptr
    %6 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %6, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(14 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @chp : !llvm.ptr
    %5 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %5, %4 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test5_before := [llvmfunc|
  llvm.func @test5() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(65280 : i32) : i32
    %3 = llvm.mlir.constant(14 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.addressof @chp : !llvm.ptr
    %6 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %6, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test6_before := [llvmfunc|
  llvm.func @test6() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.mlir.constant(100 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.addressof @chp : !llvm.ptr
    %6 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %6, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test7_before := [llvmfunc|
  llvm.func @test7() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(120 : i32) : i32
    %3 = llvm.mlir.constant(100 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.addressof @chp : !llvm.ptr
    %6 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %6, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test8_before := [llvmfunc|
  llvm.func @test8() {
    %0 = llvm.mlir.constant("hello\00world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hellonull : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.mlir.constant(14 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.addressof @chp : !llvm.ptr
    %6 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %6, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test9_before := [llvmfunc|
  llvm.func @test9() {
    %0 = llvm.mlir.constant("hello\00world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hellonull : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(119 : i32) : i32
    %5 = llvm.mlir.constant(12 : i32) : i32
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.mlir.addressof @chp : !llvm.ptr
    %8 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<14 x i8>
    %9 = llvm.call @memchr(%8, %4, %5) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %9, %7 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test10_before := [llvmfunc|
  llvm.func @test10() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.mlir.constant(6 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.addressof @chp : !llvm.ptr
    %6 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %6, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant("\0D\0A\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @newlines : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(" \0D\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @spaces : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant("\1F\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @single : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant("\1F\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @single : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant("\FF\FE\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @negative : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.call @memchr(%1, %arg0, %arg1) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    %4 = llvm.icmp "ne" %3, %2 : !llvm.ptr
    llvm.return %4 : i1
  }]

def pr32124_before := [llvmfunc|
  llvm.func @pr32124() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @s : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.call @memchr(%2, %3, %4) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memchr(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memchr(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.call @memchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def test19_before := [llvmfunc|
  llvm.func @test19(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.call @memchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1() {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<14 x i8>
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.addressof @chp : !llvm.ptr
    llvm.store %4, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2() {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.addressof @chp : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3() {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<14 x i8>
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.addressof @chp : !llvm.ptr
    llvm.store %4, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(14 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @chp : !llvm.ptr
    %5 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %5, %4 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5() {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<14 x i8>
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.addressof @chp : !llvm.ptr
    llvm.store %4, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6() {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<14 x i8>
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.addressof @chp : !llvm.ptr
    llvm.store %4, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7() {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.addressof @chp : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8() {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("hello\00world\\n\00") : !llvm.array<14 x i8>
    %3 = llvm.mlir.addressof @hellonull : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<14 x i8>
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.addressof @chp : !llvm.ptr
    llvm.store %4, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9() {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("hello\00world\\n\00") : !llvm.array<14 x i8>
    %3 = llvm.mlir.addressof @hellonull : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<14 x i8>
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.addressof @chp : !llvm.ptr
    llvm.store %4, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10() {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.addressof @chp : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i16) : i16
    %1 = llvm.mlir.constant(16 : i16) : i16
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(9217 : i16) : i16
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(false) : i1
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.and %6, %0  : i16
    %8 = llvm.icmp "ult" %7, %1 : i16
    %9 = llvm.shl %2, %7 overflow<nuw>  : i16
    %10 = llvm.and %9, %3  : i16
    %11 = llvm.icmp "ne" %10, %4 : i16
    %12 = llvm.select %8, %11, %5 : i1, i1
    llvm.return %12 : i1
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(" \0D\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @spaces : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.trunc %arg0 : i32 to i8
    %3 = llvm.icmp "eq" %2, %0 : i8
    %4 = llvm.icmp "eq" %2, %1 : i8
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant("\FF\FE\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @negative : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.call @memchr(%1, %arg0, %arg1) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    %4 = llvm.icmp "ne" %3, %2 : !llvm.ptr
    llvm.return %4 : i1
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def pr32124_combined := [llvmfunc|
  llvm.func @pr32124() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @s : !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_pr32124   : pr32124_before  ⊑  pr32124_combined := by
  unfold pr32124_before pr32124_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memchr(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memchr(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.call @memchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def test19_combined := [llvmfunc|
  llvm.func @test19(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.call @memchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
