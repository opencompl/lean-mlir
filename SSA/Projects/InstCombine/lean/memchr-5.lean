import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memchr-5
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_memchr_a_before := [llvmfunc|
  llvm.func @fold_memchr_a(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[1633837924, 1701209960, 1768581996, 1835954032]> : tensor<4xi32>) : !llvm.array<4 x i32>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(97 : i32) : i32
    %3 = llvm.mlir.constant(16 : i64) : i64
    %4 = llvm.mlir.constant(98 : i32) : i32
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(99 : i32) : i32
    %7 = llvm.mlir.constant(2 : i64) : i64
    %8 = llvm.mlir.constant(100 : i32) : i32
    %9 = llvm.mlir.constant(3 : i64) : i64
    %10 = llvm.mlir.constant(110 : i32) : i32
    %11 = llvm.mlir.constant(4 : i64) : i64
    %12 = llvm.mlir.constant(111 : i32) : i32
    %13 = llvm.mlir.constant(6 : i64) : i64
    %14 = llvm.mlir.constant(112 : i32) : i32
    %15 = llvm.mlir.constant(7 : i64) : i64
    %16 = llvm.mlir.constant(113 : i32) : i32
    %17 = llvm.mlir.constant(8 : i64) : i64
    %18 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %19 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %20 = llvm.ptrtoint %19 : !llvm.ptr to i64
    %21 = llvm.sub %20, %18  : i64
    llvm.store %21, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    %22 = llvm.call @memchr(%1, %4, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %23 = llvm.ptrtoint %22 : !llvm.ptr to i64
    %24 = llvm.sub %23, %18  : i64
    %25 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %24, %25 {alignment = 4 : i64} : i64, !llvm.ptr]

    %26 = llvm.call @memchr(%1, %6, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %27 = llvm.ptrtoint %26 : !llvm.ptr to i64
    %28 = llvm.sub %27, %18  : i64
    %29 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %28, %29 {alignment = 4 : i64} : i64, !llvm.ptr]

    %30 = llvm.call @memchr(%1, %8, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %31 = llvm.ptrtoint %30 : !llvm.ptr to i64
    %32 = llvm.sub %31, %18  : i64
    %33 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %32, %33 {alignment = 4 : i64} : i64, !llvm.ptr]

    %34 = llvm.call @memchr(%1, %10, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %35 = llvm.ptrtoint %34 : !llvm.ptr to i64
    %36 = llvm.sub %35, %18  : i64
    %37 = llvm.getelementptr %arg0[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %36, %37 {alignment = 4 : i64} : i64, !llvm.ptr]

    %38 = llvm.call @memchr(%1, %12, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %39 = llvm.ptrtoint %38 : !llvm.ptr to i64
    %40 = llvm.sub %39, %18  : i64
    %41 = llvm.getelementptr %arg0[%13] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %40, %41 {alignment = 4 : i64} : i64, !llvm.ptr]

    %42 = llvm.call @memchr(%1, %14, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %43 = llvm.ptrtoint %42 : !llvm.ptr to i64
    %44 = llvm.sub %43, %18  : i64
    %45 = llvm.getelementptr %arg0[%15] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %44, %45 {alignment = 4 : i64} : i64, !llvm.ptr]

    %46 = llvm.call @memchr(%1, %16, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %47 = llvm.ptrtoint %46 : !llvm.ptr to i64
    %48 = llvm.getelementptr %arg0[%17] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %47, %48 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def fold_memchr_a_p1_before := [llvmfunc|
  llvm.func @fold_memchr_a_p1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[1633837924, 1701209960, 1768581996, 1835954032]> : tensor<4xi32>) : !llvm.array<4 x i32>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(101 : i32) : i32
    %5 = llvm.mlir.constant(12 : i64) : i64
    %6 = llvm.mlir.constant(102 : i32) : i32
    %7 = llvm.mlir.constant(103 : i32) : i32
    %8 = llvm.mlir.constant(2 : i64) : i64
    %9 = llvm.mlir.constant(104 : i32) : i32
    %10 = llvm.mlir.constant(3 : i64) : i64
    %11 = llvm.mlir.constant(97 : i32) : i32
    %12 = llvm.mlir.constant(4 : i64) : i64
    %13 = llvm.mlir.constant(100 : i32) : i32
    %14 = llvm.mlir.constant(5 : i64) : i64
    %15 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i32>
    %16 = llvm.ptrtoint %15 : !llvm.ptr to i64
    %17 = llvm.call @memchr(%15, %4, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %18 = llvm.ptrtoint %17 : !llvm.ptr to i64
    %19 = llvm.sub %18, %16  : i64
    llvm.store %19, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    %20 = llvm.call @memchr(%15, %6, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %21 = llvm.ptrtoint %20 : !llvm.ptr to i64
    %22 = llvm.sub %21, %16  : i64
    %23 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %22, %23 {alignment = 4 : i64} : i64, !llvm.ptr]

    %24 = llvm.call @memchr(%15, %7, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %25 = llvm.ptrtoint %24 : !llvm.ptr to i64
    %26 = llvm.sub %25, %16  : i64
    %27 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %26, %27 {alignment = 4 : i64} : i64, !llvm.ptr]

    %28 = llvm.call @memchr(%15, %9, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %29 = llvm.ptrtoint %28 : !llvm.ptr to i64
    %30 = llvm.sub %29, %16  : i64
    %31 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %30, %31 {alignment = 4 : i64} : i64, !llvm.ptr]

    %32 = llvm.call @memchr(%15, %11, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %33 = llvm.ptrtoint %32 : !llvm.ptr to i64
    %34 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %33, %34 {alignment = 4 : i64} : i64, !llvm.ptr]

    %35 = llvm.call @memchr(%15, %13, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %36 = llvm.ptrtoint %35 : !llvm.ptr to i64
    %37 = llvm.getelementptr %arg0[%14] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %36, %37 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def fold_memchr_a_combined := [llvmfunc|
  llvm.func @fold_memchr_a(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.mlir.constant(13 : i64) : i64
    %6 = llvm.mlir.constant(6 : i64) : i64
    %7 = llvm.mlir.constant(14 : i64) : i64
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.mlir.constant(15 : i64) : i64
    %10 = llvm.mlir.constant(8 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_memchr_a   : fold_memchr_a_before  ⊑  fold_memchr_a_combined := by
  unfold fold_memchr_a_before fold_memchr_a_combined
  simp_alive_peephole
  sorry
    %11 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %1, %11 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_memchr_a   : fold_memchr_a_before  ⊑  fold_memchr_a_combined := by
  unfold fold_memchr_a_before fold_memchr_a_combined
  simp_alive_peephole
  sorry
    %12 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %2, %12 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_memchr_a   : fold_memchr_a_before  ⊑  fold_memchr_a_combined := by
  unfold fold_memchr_a_before fold_memchr_a_combined
  simp_alive_peephole
  sorry
    %13 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %3, %13 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_memchr_a   : fold_memchr_a_before  ⊑  fold_memchr_a_combined := by
  unfold fold_memchr_a_before fold_memchr_a_combined
  simp_alive_peephole
  sorry
    %14 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %5, %14 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_memchr_a   : fold_memchr_a_before  ⊑  fold_memchr_a_combined := by
  unfold fold_memchr_a_before fold_memchr_a_combined
  simp_alive_peephole
  sorry
    %15 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %7, %15 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_memchr_a   : fold_memchr_a_before  ⊑  fold_memchr_a_combined := by
  unfold fold_memchr_a_before fold_memchr_a_combined
  simp_alive_peephole
  sorry
    %16 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %9, %16 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_memchr_a   : fold_memchr_a_before  ⊑  fold_memchr_a_combined := by
  unfold fold_memchr_a_before fold_memchr_a_combined
  simp_alive_peephole
  sorry
    %17 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %0, %17 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_memchr_a   : fold_memchr_a_before  ⊑  fold_memchr_a_combined := by
  unfold fold_memchr_a_before fold_memchr_a_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_memchr_a   : fold_memchr_a_before  ⊑  fold_memchr_a_combined := by
  unfold fold_memchr_a_before fold_memchr_a_combined
  simp_alive_peephole
  sorry
def fold_memchr_a_p1_combined := [llvmfunc|
  llvm.func @fold_memchr_a_p1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.mlir.constant(5 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_memchr_a_p1   : fold_memchr_a_p1_before  ⊑  fold_memchr_a_p1_combined := by
  unfold fold_memchr_a_p1_before fold_memchr_a_p1_combined
  simp_alive_peephole
  sorry
    %6 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %1, %6 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_memchr_a_p1   : fold_memchr_a_p1_before  ⊑  fold_memchr_a_p1_combined := by
  unfold fold_memchr_a_p1_before fold_memchr_a_p1_combined
  simp_alive_peephole
  sorry
    %7 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %2, %7 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_memchr_a_p1   : fold_memchr_a_p1_before  ⊑  fold_memchr_a_p1_combined := by
  unfold fold_memchr_a_p1_before fold_memchr_a_p1_combined
  simp_alive_peephole
  sorry
    %8 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %3, %8 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_memchr_a_p1   : fold_memchr_a_p1_before  ⊑  fold_memchr_a_p1_combined := by
  unfold fold_memchr_a_p1_before fold_memchr_a_p1_combined
  simp_alive_peephole
  sorry
    %9 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %0, %9 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_memchr_a_p1   : fold_memchr_a_p1_before  ⊑  fold_memchr_a_p1_combined := by
  unfold fold_memchr_a_p1_before fold_memchr_a_p1_combined
  simp_alive_peephole
  sorry
    %10 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %0, %10 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_memchr_a_p1   : fold_memchr_a_p1_before  ⊑  fold_memchr_a_p1_combined := by
  unfold fold_memchr_a_p1_before fold_memchr_a_p1_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_memchr_a_p1   : fold_memchr_a_p1_before  ⊑  fold_memchr_a_p1_combined := by
  unfold fold_memchr_a_p1_before fold_memchr_a_p1_combined
  simp_alive_peephole
  sorry
