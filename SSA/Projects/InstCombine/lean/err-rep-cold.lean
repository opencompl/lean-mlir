import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  err-rep-cold
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @stderr : !llvm.ptr
    %3 = llvm.mlir.constant("an error: %d\00") : !llvm.array<13 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %6, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    %7 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %8 = llvm.call @fprintf(%7, %4, %arg0) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.br ^bb2(%5 : i32)
  ^bb2(%9: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %9 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @stderr : !llvm.ptr
    %3 = llvm.mlir.constant("an error\00") : !llvm.array<9 x i8>
    %4 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %5 = llvm.mlir.constant(8 : i64) : i64
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %8, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    %9 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %10 = llvm.call @fwrite(%4, %5, %6, %9) : (!llvm.ptr, i64, i64, !llvm.ptr) -> i64
    llvm.br ^bb2(%7 : i32)
  ^bb2(%11: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %11 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @stdout : !llvm.ptr
    %3 = llvm.mlir.constant("an error\00") : !llvm.array<9 x i8>
    %4 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %5 = llvm.mlir.constant(8 : i64) : i64
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %8, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    %9 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %10 = llvm.call @fwrite(%4, %5, %6, %9) : (!llvm.ptr, i64, i64, !llvm.ptr) -> i64
    llvm.br ^bb2(%7 : i32)
  ^bb2(%11: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %11 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @stderr : !llvm.ptr
    %3 = llvm.mlir.constant("an error: %d\00") : !llvm.array<13 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %6, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    %7 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
    %8 = llvm.call @fprintf(%7, %4, %arg0) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.br ^bb2(%5 : i32)
  ^bb2(%9: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %9 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @stderr : !llvm.ptr
    %3 = llvm.mlir.constant("an error\00") : !llvm.array<9 x i8>
    %4 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %5 = llvm.mlir.constant(8 : i64) : i64
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %8, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    %9 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
    %10 = llvm.call @fwrite(%4, %5, %6, %9) : (!llvm.ptr, i64, i64, !llvm.ptr) -> i64
    llvm.br ^bb2(%7 : i32)
  ^bb2(%11: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %11 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @stdout : !llvm.ptr
    %3 = llvm.mlir.constant("an error\00") : !llvm.array<9 x i8>
    %4 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %5 = llvm.mlir.constant(8 : i64) : i64
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %8, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    %9 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
    %10 = llvm.call @fwrite(%4, %5, %6, %9) : (!llvm.ptr, i64, i64, !llvm.ptr) -> i64
    llvm.br ^bb2(%7 : i32)
  ^bb2(%11: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %11 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
