import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  snprintf-3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_snprintf_pcnt_s_before := [llvmfunc|
  llvm.func @fold_snprintf_pcnt_s() {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @adst : !llvm.ptr
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %4 = llvm.mlir.constant(2147483647 : i64) : i64
    %5 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %6 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %7 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %8 = llvm.mlir.addressof @s : !llvm.ptr
    %9 = llvm.mlir.addressof @asiz : !llvm.ptr
    %10 = llvm.mlir.constant(5 : i32) : i32
    %11 = llvm.getelementptr %2[%1, %10] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %12 = llvm.mlir.constant(5 : i64) : i64
    %13 = llvm.getelementptr %9[%1, %10] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %14 = llvm.mlir.constant(4 : i32) : i32
    %15 = llvm.getelementptr %2[%1, %14] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %16 = llvm.mlir.constant(4 : i64) : i64
    %17 = llvm.getelementptr %9[%1, %14] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %18 = llvm.mlir.constant(3 : i32) : i32
    %19 = llvm.getelementptr %2[%1, %18] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %20 = llvm.mlir.constant(3 : i64) : i64
    %21 = llvm.getelementptr %9[%1, %18] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %22 = llvm.mlir.constant(2 : i32) : i32
    %23 = llvm.getelementptr %2[%1, %22] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %24 = llvm.mlir.constant(2 : i64) : i64
    %25 = llvm.getelementptr %9[%1, %22] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %26 = llvm.mlir.constant(1 : i32) : i32
    %27 = llvm.getelementptr %2[%1, %26] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %28 = llvm.mlir.constant(1 : i64) : i64
    %29 = llvm.getelementptr %9[%1, %26] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %30 = llvm.mlir.constant(0 : i64) : i64
    %31 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %32 = llvm.call @snprintf(%31, %4, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %32, %9 {alignment = 4 : i64} : i32, !llvm.ptr]

    %33 = llvm.load %11 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %34 = llvm.call @snprintf(%33, %12, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %34, %13 {alignment = 4 : i64} : i32, !llvm.ptr]

    %35 = llvm.load %15 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %36 = llvm.call @snprintf(%35, %16, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %36, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

    %37 = llvm.load %19 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %38 = llvm.call @snprintf(%37, %20, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %38, %21 {alignment = 4 : i64} : i32, !llvm.ptr]

    %39 = llvm.load %23 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %40 = llvm.call @snprintf(%39, %24, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %40, %25 {alignment = 4 : i64} : i32, !llvm.ptr]

    %41 = llvm.load %27 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %42 = llvm.call @snprintf(%41, %28, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %42, %29 {alignment = 4 : i64} : i32, !llvm.ptr]

    %43 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %44 = llvm.call @snprintf(%43, %30, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %44, %9 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def call_snprintf_pcnt_s_ximax_before := [llvmfunc|
  llvm.func @call_snprintf_pcnt_s_ximax() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @adst : !llvm.ptr
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %4 = llvm.mlir.constant(-1 : i64) : i64
    %5 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %6 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %7 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %8 = llvm.mlir.addressof @s : !llvm.ptr
    %9 = llvm.mlir.addressof @asiz : !llvm.ptr
    %10 = llvm.getelementptr %9[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %11 = llvm.mlir.constant(2147483648 : i64) : i64
    %12 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %13 = llvm.call @snprintf(%12, %4, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %13, %10 {alignment = 4 : i64} : i32, !llvm.ptr]

    %14 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %15 = llvm.call @snprintf(%14, %11, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %15, %9 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_snprintf_pcnt_s_combined := [llvmfunc|
  llvm.func @fold_snprintf_pcnt_s() {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @adst : !llvm.ptr
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x ptr>
    %4 = llvm.mlir.constant(825373440 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.mlir.addressof @asiz : !llvm.ptr
    %7 = llvm.mlir.constant(5 : i64) : i64
    %8 = llvm.getelementptr %2[%1, %7] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x ptr>
    %9 = llvm.getelementptr %6[%1, %7] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %10 = llvm.mlir.constant(4 : i64) : i64
    %11 = llvm.getelementptr %2[%1, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x ptr>
    %12 = llvm.getelementptr %6[%1, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %13 = llvm.mlir.constant(3 : i64) : i64
    %14 = llvm.getelementptr %2[%1, %13] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x ptr>
    %15 = llvm.mlir.constant(12594 : i16) : i16
    %16 = llvm.mlir.constant(2 : i64) : i64
    %17 = llvm.mlir.constant(0 : i8) : i8
    %18 = llvm.getelementptr %6[%1, %13] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %19 = llvm.getelementptr %2[%1, %16] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x ptr>
    %20 = llvm.mlir.constant(49 : i8) : i8
    %21 = llvm.mlir.constant(1 : i64) : i64
    %22 = llvm.getelementptr %6[%1, %16] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %23 = llvm.getelementptr %2[%1, %21] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x ptr>
    %24 = llvm.getelementptr %6[%1, %21] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %25 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %25 {alignment = 1 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    llvm.store %5, %6 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    %26 = llvm.load %8 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %26 {alignment = 1 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    llvm.store %5, %9 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    %27 = llvm.load %11 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %27 {alignment = 1 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    llvm.store %5, %12 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    %28 = llvm.load %14 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    llvm.store %15, %28 {alignment = 1 : i64} : i16, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    %29 = llvm.getelementptr inbounds %28[%16] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.store %17, %29 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    llvm.store %5, %18 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    %30 = llvm.load %19 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    llvm.store %20, %30 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    %31 = llvm.getelementptr inbounds %30[%21] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.store %17, %31 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    llvm.store %5, %22 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    %32 = llvm.load %23 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    llvm.store %17, %32 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    llvm.store %5, %24 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    llvm.store %5, %6 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_snprintf_pcnt_s   : fold_snprintf_pcnt_s_before  ⊑  fold_snprintf_pcnt_s_combined := by
  unfold fold_snprintf_pcnt_s_before fold_snprintf_pcnt_s_combined
  simp_alive_peephole
  sorry
def call_snprintf_pcnt_s_ximax_combined := [llvmfunc|
  llvm.func @call_snprintf_pcnt_s_ximax() {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.addressof @adst : !llvm.ptr
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x ptr>
    %4 = llvm.mlir.constant(-1 : i64) : i64
    %5 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %6 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %7 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %8 = llvm.mlir.addressof @s : !llvm.ptr
    %9 = llvm.mlir.addressof @asiz : !llvm.ptr
    %10 = llvm.getelementptr %9[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i32>
    %11 = llvm.mlir.constant(2147483648 : i64) : i64
    %12 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_call_snprintf_pcnt_s_ximax   : call_snprintf_pcnt_s_ximax_before  ⊑  call_snprintf_pcnt_s_ximax_combined := by
  unfold call_snprintf_pcnt_s_ximax_before call_snprintf_pcnt_s_ximax_combined
  simp_alive_peephole
  sorry
    %13 = llvm.call @snprintf(%12, %4, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %13, %10 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_snprintf_pcnt_s_ximax   : call_snprintf_pcnt_s_ximax_before  ⊑  call_snprintf_pcnt_s_ximax_combined := by
  unfold call_snprintf_pcnt_s_ximax_before call_snprintf_pcnt_s_ximax_combined
  simp_alive_peephole
  sorry
    %14 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_call_snprintf_pcnt_s_ximax   : call_snprintf_pcnt_s_ximax_before  ⊑  call_snprintf_pcnt_s_ximax_combined := by
  unfold call_snprintf_pcnt_s_ximax_before call_snprintf_pcnt_s_ximax_combined
  simp_alive_peephole
  sorry
    %15 = llvm.call @snprintf(%14, %11, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %15, %9 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_snprintf_pcnt_s_ximax   : call_snprintf_pcnt_s_ximax_before  ⊑  call_snprintf_pcnt_s_ximax_combined := by
  unfold call_snprintf_pcnt_s_ximax_before call_snprintf_pcnt_s_ximax_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_call_snprintf_pcnt_s_ximax   : call_snprintf_pcnt_s_ximax_before  ⊑  call_snprintf_pcnt_s_ximax_combined := by
  unfold call_snprintf_pcnt_s_ximax_before call_snprintf_pcnt_s_ximax_combined
  simp_alive_peephole
  sorry
