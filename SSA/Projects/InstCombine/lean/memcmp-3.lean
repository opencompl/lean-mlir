import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memcmp-3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_memcmp_ia16a_i8a_before := [llvmfunc|
  llvm.func @fold_memcmp_ia16a_i8a(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[24930, 25444, 25958, 26472]> : tensor<4xi16>) : !llvm.array<4 x i16>
    %1 = llvm.mlir.addressof @ia16a : !llvm.ptr
    %2 = llvm.mlir.constant("abcdefgg") : !llvm.array<8 x i8>
    %3 = llvm.mlir.addressof @i8a : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(3 : i64) : i64
    %8 = llvm.mlir.constant(4 : i64) : i64
    %9 = llvm.mlir.constant(5 : i64) : i64
    %10 = llvm.mlir.constant(6 : i64) : i64
    %11 = llvm.mlir.constant(7 : i64) : i64
    %12 = llvm.mlir.constant(8 : i64) : i64
    %13 = llvm.call @memcmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %13, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %14 = llvm.call @memcmp(%1, %3, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %15 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %14, %15 {alignment = 4 : i64} : i32, !llvm.ptr]

    %16 = llvm.call @memcmp(%1, %3, %6) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %17 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %16, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

    %18 = llvm.call @memcmp(%1, %3, %7) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %19 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %18, %19 {alignment = 4 : i64} : i32, !llvm.ptr]

    %20 = llvm.call @memcmp(%1, %3, %8) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %21 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %20, %21 {alignment = 4 : i64} : i32, !llvm.ptr]

    %22 = llvm.call @memcmp(%1, %3, %9) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %23 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %23 {alignment = 4 : i64} : i32, !llvm.ptr]

    %24 = llvm.call @memcmp(%1, %3, %10) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %25 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %24, %25 {alignment = 4 : i64} : i32, !llvm.ptr]

    %26 = llvm.call @memcmp(%1, %3, %11) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %27 = llvm.getelementptr %arg0[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %26, %27 {alignment = 4 : i64} : i32, !llvm.ptr]

    %28 = llvm.call @memcmp(%1, %3, %12) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %29 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %28, %29 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_memcmp_ia16a_p1_i8a_p1_before := [llvmfunc|
  llvm.func @fold_memcmp_ia16a_p1_i8a_p1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[24930, 25444, 25958, 26472]> : tensor<4xi16>) : !llvm.array<4 x i16>
    %1 = llvm.mlir.addressof @ia16a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant("abcdefgg") : !llvm.array<8 x i8>
    %5 = llvm.mlir.addressof @i8a : !llvm.ptr
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(3 : i64) : i64
    %8 = llvm.mlir.constant(4 : i64) : i64
    %9 = llvm.mlir.constant(5 : i64) : i64
    %10 = llvm.mlir.constant(6 : i64) : i64
    %11 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i16>
    %12 = llvm.getelementptr %5[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %13 = llvm.call @memcmp(%11, %12, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %13, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %14 = llvm.call @memcmp(%11, %12, %3) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %15 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %14, %15 {alignment = 4 : i64} : i32, !llvm.ptr]

    %16 = llvm.call @memcmp(%11, %12, %6) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %17 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %16, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

    %18 = llvm.call @memcmp(%11, %12, %7) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %19 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %18, %19 {alignment = 4 : i64} : i32, !llvm.ptr]

    %20 = llvm.call @memcmp(%11, %12, %8) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %21 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %20, %21 {alignment = 4 : i64} : i32, !llvm.ptr]

    %22 = llvm.call @memcmp(%11, %12, %9) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %23 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %23 {alignment = 4 : i64} : i32, !llvm.ptr]

    %24 = llvm.call @memcmp(%11, %12, %10) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %25 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %24, %25 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_memcmp_ia16a_i8a_combined := [llvmfunc|
  llvm.func @fold_memcmp_ia16a_i8a(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.mlir.constant(5 : i64) : i64
    %6 = llvm.mlir.constant(6 : i64) : i64
    %7 = llvm.mlir.constant(7 : i64) : i64
    %8 = llvm.mlir.constant(8 : i64) : i64
    %9 = llvm.mlir.constant(1 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %10 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %10 {alignment = 4 : i64} : i32, !llvm.ptr
    %11 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %11 {alignment = 4 : i64} : i32, !llvm.ptr
    %12 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %12 {alignment = 4 : i64} : i32, !llvm.ptr
    %13 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %13 {alignment = 4 : i64} : i32, !llvm.ptr
    %14 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %14 {alignment = 4 : i64} : i32, !llvm.ptr
    %15 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %15 {alignment = 4 : i64} : i32, !llvm.ptr
    %16 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %16 {alignment = 4 : i64} : i32, !llvm.ptr
    %17 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %9, %17 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_memcmp_ia16a_i8a   : fold_memcmp_ia16a_i8a_before  ⊑  fold_memcmp_ia16a_i8a_combined := by
  unfold fold_memcmp_ia16a_i8a_before fold_memcmp_ia16a_i8a_combined
  simp_alive_peephole
  sorry
def fold_memcmp_ia16a_p1_i8a_p1_combined := [llvmfunc|
  llvm.func @fold_memcmp_ia16a_p1_i8a_p1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.mlir.constant(4 : i64) : i64
    %6 = llvm.mlir.constant(5 : i64) : i64
    %7 = llvm.mlir.constant(6 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %8 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %2, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    %9 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %2, %9 {alignment = 4 : i64} : i32, !llvm.ptr
    %10 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %2, %10 {alignment = 4 : i64} : i32, !llvm.ptr
    %11 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %2, %11 {alignment = 4 : i64} : i32, !llvm.ptr
    %12 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %2, %12 {alignment = 4 : i64} : i32, !llvm.ptr
    %13 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %2, %13 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_memcmp_ia16a_p1_i8a_p1   : fold_memcmp_ia16a_p1_i8a_p1_before  ⊑  fold_memcmp_ia16a_p1_i8a_p1_combined := by
  unfold fold_memcmp_ia16a_p1_i8a_p1_before fold_memcmp_ia16a_p1_i8a_p1_combined
  simp_alive_peephole
  sorry
