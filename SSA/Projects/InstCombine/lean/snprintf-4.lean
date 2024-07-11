import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  snprintf-4
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_snprintf_pcnt_c_before := [llvmfunc|
  llvm.func @fold_snprintf_pcnt_c(%arg0: i32) {
    %0 = llvm.mlir.addressof @adst : !llvm.ptr
    %1 = llvm.mlir.constant(2147483647 : i64) : i64
    %2 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %3 = llvm.mlir.addressof @pcnt_c : !llvm.ptr
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.addressof @asiz : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.getelementptr %0[%6, %4] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %8 = llvm.mlir.constant(2 : i64) : i64
    %9 = llvm.mlir.constant(2 : i8) : i8
    %10 = llvm.getelementptr %5[%6, %4] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.getelementptr %0[%6, %11] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %13 = llvm.mlir.constant(0 : i8) : i8
    %14 = llvm.getelementptr %5[%6, %11] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %15 = llvm.mlir.constant(3 : i32) : i32
    %16 = llvm.getelementptr %0[%6, %15] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %17 = llvm.mlir.constant(1 : i64) : i64
    %18 = llvm.mlir.constant(3 : i16) : i16
    %19 = llvm.getelementptr %5[%6, %15] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %20 = llvm.mlir.constant(4 : i32) : i32
    %21 = llvm.getelementptr %0[%6, %20] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %22 = llvm.mlir.constant(0 : i64) : i64
    %23 = llvm.getelementptr %5[%6, %20] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %24 = llvm.mlir.constant(5 : i32) : i32
    %25 = llvm.getelementptr %0[%6, %24] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %26 = llvm.getelementptr %5[%6, %24] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %27 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %28 = llvm.call @snprintf(%27, %1, %3, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i32) -> i32
    llvm.store %28, %5 {alignment = 4 : i64} : i32, !llvm.ptr]

    %29 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %30 = llvm.call @snprintf(%29, %8, %3, %9) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i8) -> i32
    llvm.store %30, %10 {alignment = 4 : i64} : i32, !llvm.ptr]

    %31 = llvm.load %12 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %32 = llvm.call @snprintf(%31, %8, %3, %13) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i8) -> i32
    llvm.store %32, %14 {alignment = 4 : i64} : i32, !llvm.ptr]

    %33 = llvm.load %16 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %34 = llvm.call @snprintf(%33, %17, %3, %18) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i16) -> i32
    llvm.store %34, %19 {alignment = 4 : i64} : i32, !llvm.ptr]

    %35 = llvm.load %21 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %36 = llvm.call @snprintf(%35, %22, %3, %20) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i32) -> i32
    llvm.store %36, %23 {alignment = 4 : i64} : i32, !llvm.ptr]

    %37 = llvm.load %21 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %38 = llvm.call @snprintf(%37, %8, %3, %arg0) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i32) -> i32
    llvm.store %38, %23 {alignment = 4 : i64} : i32, !llvm.ptr]

    %39 = llvm.load %25 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %40 = llvm.call @snprintf(%39, %17, %3, %arg0) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i32) -> i32
    llvm.store %40, %26 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def call_snprintf_pcnt_c_ximax_before := [llvmfunc|
  llvm.func @call_snprintf_pcnt_c_ximax(%arg0: i32) {
    %0 = llvm.mlir.addressof @adst : !llvm.ptr
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %3 = llvm.mlir.addressof @pcnt_c : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i8) : i8
    %5 = llvm.mlir.addressof @asiz : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.getelementptr %0[%7, %6] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %9 = llvm.mlir.constant(2147483648 : i64) : i64
    %10 = llvm.mlir.constant(1 : i8) : i8
    %11 = llvm.getelementptr %5[%7, %6] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.getelementptr %0[%7, %12] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %14 = llvm.mlir.constant(-4294967296 : i64) : i64
    %15 = llvm.getelementptr %5[%7, %12] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %16 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %17 = llvm.call @snprintf(%16, %1, %3, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i8) -> i32
    llvm.store %17, %5 {alignment = 4 : i64} : i32, !llvm.ptr]

    %18 = llvm.load %8 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %19 = llvm.call @snprintf(%18, %9, %3, %10) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i8) -> i32
    llvm.store %19, %11 {alignment = 4 : i64} : i32, !llvm.ptr]

    %20 = llvm.load %13 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %21 = llvm.call @snprintf(%20, %14, %3, %10) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i8) -> i32
    llvm.store %21, %15 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_snprintf_pcnt_c_combined := [llvmfunc|
  llvm.func @fold_snprintf_pcnt_c(%arg0: i32) {
    %0 = llvm.mlir.addressof @adst : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.addressof @asiz : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i64) : i64
    %7 = llvm.getelementptr %0[%6, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x ptr>
    %8 = llvm.mlir.constant(2 : i8) : i8
    %9 = llvm.getelementptr %5[%6, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %10 = llvm.mlir.constant(2 : i64) : i64
    %11 = llvm.getelementptr %0[%6, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x ptr>
    %12 = llvm.getelementptr %5[%6, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %13 = llvm.mlir.constant(3 : i64) : i64
    %14 = llvm.getelementptr %0[%6, %13] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x ptr>
    %15 = llvm.getelementptr %5[%6, %13] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %16 = llvm.mlir.constant(4 : i64) : i64
    %17 = llvm.getelementptr %5[%6, %16] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %18 = llvm.getelementptr %0[%6, %16] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x ptr>
    %19 = llvm.mlir.constant(5 : i64) : i64
    %20 = llvm.getelementptr %0[%6, %19] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x ptr>
    %21 = llvm.getelementptr %5[%6, %19] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %22 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %22 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    %23 = llvm.getelementptr inbounds %22[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.store %3, %23 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %5 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    %24 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    llvm.store %8, %24 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    %25 = llvm.getelementptr inbounds %24[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.store %3, %25 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %9 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    %26 = llvm.load %11 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    llvm.store %3, %26 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    %27 = llvm.getelementptr inbounds %26[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.store %3, %27 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %12 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    %28 = llvm.load %14 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    llvm.store %3, %28 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %15 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    %29 = llvm.load %18 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    %30 = llvm.trunc %arg0 : i32 to i8
    llvm.store %30, %29 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    %31 = llvm.getelementptr inbounds %29[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.store %3, %31 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    %32 = llvm.load %20 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    llvm.store %3, %32 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %21 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_snprintf_pcnt_c   : fold_snprintf_pcnt_c_before  ⊑  fold_snprintf_pcnt_c_combined := by
  unfold fold_snprintf_pcnt_c_before fold_snprintf_pcnt_c_combined
  simp_alive_peephole
  sorry
def call_snprintf_pcnt_c_ximax_combined := [llvmfunc|
  llvm.func @call_snprintf_pcnt_c_ximax(%arg0: i32) {
    %0 = llvm.mlir.addressof @adst : !llvm.ptr
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %3 = llvm.mlir.addressof @pcnt_c : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i8) : i8
    %5 = llvm.mlir.addressof @asiz : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.getelementptr %0[%7, %6] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x ptr>
    %9 = llvm.mlir.constant(2147483648 : i64) : i64
    %10 = llvm.mlir.constant(1 : i8) : i8
    %11 = llvm.getelementptr %5[%7, %6] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %12 = llvm.mlir.constant(2 : i64) : i64
    %13 = llvm.getelementptr %0[%7, %12] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x ptr>
    %14 = llvm.mlir.constant(-4294967296 : i64) : i64
    %15 = llvm.getelementptr %5[%7, %12] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %16 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_call_snprintf_pcnt_c_ximax   : call_snprintf_pcnt_c_ximax_before  ⊑  call_snprintf_pcnt_c_ximax_combined := by
  unfold call_snprintf_pcnt_c_ximax_before call_snprintf_pcnt_c_ximax_combined
  simp_alive_peephole
  sorry
    %17 = llvm.call @snprintf(%16, %1, %3, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i8) -> i32
    llvm.store %17, %5 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_snprintf_pcnt_c_ximax   : call_snprintf_pcnt_c_ximax_before  ⊑  call_snprintf_pcnt_c_ximax_combined := by
  unfold call_snprintf_pcnt_c_ximax_before call_snprintf_pcnt_c_ximax_combined
  simp_alive_peephole
  sorry
    %18 = llvm.load %8 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_call_snprintf_pcnt_c_ximax   : call_snprintf_pcnt_c_ximax_before  ⊑  call_snprintf_pcnt_c_ximax_combined := by
  unfold call_snprintf_pcnt_c_ximax_before call_snprintf_pcnt_c_ximax_combined
  simp_alive_peephole
  sorry
    %19 = llvm.call @snprintf(%18, %9, %3, %10) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i8) -> i32
    llvm.store %19, %11 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_snprintf_pcnt_c_ximax   : call_snprintf_pcnt_c_ximax_before  ⊑  call_snprintf_pcnt_c_ximax_combined := by
  unfold call_snprintf_pcnt_c_ximax_before call_snprintf_pcnt_c_ximax_combined
  simp_alive_peephole
  sorry
    %20 = llvm.load %13 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_call_snprintf_pcnt_c_ximax   : call_snprintf_pcnt_c_ximax_before  ⊑  call_snprintf_pcnt_c_ximax_combined := by
  unfold call_snprintf_pcnt_c_ximax_before call_snprintf_pcnt_c_ximax_combined
  simp_alive_peephole
  sorry
    %21 = llvm.call @snprintf(%20, %14, %3, %10) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i8) -> i32
    llvm.store %21, %15 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_snprintf_pcnt_c_ximax   : call_snprintf_pcnt_c_ximax_before  ⊑  call_snprintf_pcnt_c_ximax_combined := by
  unfold call_snprintf_pcnt_c_ximax_before call_snprintf_pcnt_c_ximax_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_call_snprintf_pcnt_c_ximax   : call_snprintf_pcnt_c_ximax_before  ⊑  call_snprintf_pcnt_c_ximax_combined := by
  unfold call_snprintf_pcnt_c_ximax_before call_snprintf_pcnt_c_ximax_combined
  simp_alive_peephole
  sorry
