import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memcmp-5
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_memcmp_a_b_n_before := [llvmfunc|
  llvm.func @fold_memcmp_a_b_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("01230123") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @b01230123 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(5 : i64) : i64
    %8 = llvm.mlir.addressof @a01230123 : !llvm.ptr
    %9 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %10 = llvm.getelementptr %1[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %11 = llvm.getelementptr %1[%2, %5] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %12 = llvm.getelementptr %1[%2, %6] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %13 = llvm.getelementptr %1[%2, %7] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %14 = llvm.call @memcmp(%8, %1, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %14, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %15 = llvm.call @memcmp(%8, %9, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %16 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %15, %16 {alignment = 4 : i64} : i32, !llvm.ptr]

    %17 = llvm.call @memcmp(%8, %10, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %18 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %17, %18 {alignment = 4 : i64} : i32, !llvm.ptr]

    %19 = llvm.call @memcmp(%8, %11, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %20 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %19, %20 {alignment = 4 : i64} : i32, !llvm.ptr]

    %21 = llvm.call @memcmp(%8, %12, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %22 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %21, %22 {alignment = 4 : i64} : i32, !llvm.ptr]

    %23 = llvm.call @memcmp(%8, %13, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %24 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %23, %24 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def call_memcmp_a_ax_n_before := [llvmfunc|
  llvm.func @call_memcmp_a_ax_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("01230123") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @a01230123 : !llvm.ptr
    %2 = llvm.mlir.addressof @ax : !llvm.ptr
    %3 = llvm.call @memcmp(%1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %3, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_memcmp_a_c_n_before := [llvmfunc|
  llvm.func @fold_memcmp_a_c_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("01230129") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @c01230129 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(5 : i64) : i64
    %8 = llvm.mlir.constant("01230123") : !llvm.array<8 x i8>
    %9 = llvm.mlir.addressof @a01230123 : !llvm.ptr
    %10 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %11 = llvm.getelementptr %1[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %12 = llvm.getelementptr %1[%2, %5] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %13 = llvm.getelementptr %1[%2, %6] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %14 = llvm.getelementptr %1[%2, %7] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %15 = llvm.call @memcmp(%9, %1, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %15, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %16 = llvm.call @memcmp(%9, %10, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %17 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %16, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

    %18 = llvm.call @memcmp(%9, %11, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %19 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %18, %19 {alignment = 4 : i64} : i32, !llvm.ptr]

    %20 = llvm.call @memcmp(%9, %12, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %21 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %20, %21 {alignment = 4 : i64} : i32, !llvm.ptr]

    %22 = llvm.call @memcmp(%9, %13, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %23 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %23 {alignment = 4 : i64} : i32, !llvm.ptr]

    %24 = llvm.call @memcmp(%9, %13, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %25 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %24, %25 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_memcmp_a_d_n_before := [llvmfunc|
  llvm.func @fold_memcmp_a_d_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("01230123") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @a01230123 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(6 : i64) : i64
    %5 = llvm.mlir.constant("9123012") : !llvm.array<7 x i8>
    %6 = llvm.mlir.addressof @d9123012 : !llvm.ptr
    %7 = llvm.mlir.constant(2 : i64) : i64
    %8 = llvm.mlir.constant(3 : i64) : i64
    %9 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %10 = llvm.getelementptr %1[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %11 = llvm.getelementptr %6[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %12 = llvm.getelementptr %6[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %13 = llvm.call @memcmp(%1, %6, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %13, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %14 = llvm.call @memcmp(%1, %11, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %15 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %14, %15 {alignment = 4 : i64} : i32, !llvm.ptr]

    %16 = llvm.call @memcmp(%9, %11, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %17 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %16, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

    %18 = llvm.call @memcmp(%10, %12, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %19 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %18, %19 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_memcmp_a_d_nz_before := [llvmfunc|
  llvm.func @fold_memcmp_a_d_nz(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant("01230123") : !llvm.array<8 x i8>
    %2 = llvm.mlir.addressof @a01230123 : !llvm.ptr
    %3 = llvm.mlir.constant("9123012") : !llvm.array<7 x i8>
    %4 = llvm.mlir.addressof @d9123012 : !llvm.ptr
    %5 = llvm.or %arg1, %0  : i64
    %6 = llvm.call @memcmp(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %6, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_memcmp_a_b_n_combined := [llvmfunc|
  llvm.func @fold_memcmp_a_b_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.mlir.constant(4 : i64) : i64
    %6 = llvm.mlir.constant(5 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_b_n   : fold_memcmp_a_b_n_before  ⊑  fold_memcmp_a_b_n_combined := by
  unfold fold_memcmp_a_b_n_before fold_memcmp_a_b_n_combined
  simp_alive_peephole
  sorry
    %7 = llvm.icmp "ne" %arg1, %1 : i64
    %8 = llvm.sext %7 : i1 to i32
    %9 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %8, %9 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_b_n   : fold_memcmp_a_b_n_before  ⊑  fold_memcmp_a_b_n_combined := by
  unfold fold_memcmp_a_b_n_before fold_memcmp_a_b_n_combined
  simp_alive_peephole
  sorry
    %10 = llvm.icmp "ne" %arg1, %1 : i64
    %11 = llvm.sext %10 : i1 to i32
    %12 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %11, %12 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_b_n   : fold_memcmp_a_b_n_before  ⊑  fold_memcmp_a_b_n_combined := by
  unfold fold_memcmp_a_b_n_before fold_memcmp_a_b_n_combined
  simp_alive_peephole
  sorry
    %13 = llvm.icmp "ne" %arg1, %1 : i64
    %14 = llvm.sext %13 : i1 to i32
    %15 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %14, %15 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_b_n   : fold_memcmp_a_b_n_before  ⊑  fold_memcmp_a_b_n_combined := by
  unfold fold_memcmp_a_b_n_before fold_memcmp_a_b_n_combined
  simp_alive_peephole
  sorry
    %16 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %16 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_b_n   : fold_memcmp_a_b_n_before  ⊑  fold_memcmp_a_b_n_combined := by
  unfold fold_memcmp_a_b_n_before fold_memcmp_a_b_n_combined
  simp_alive_peephole
  sorry
    %17 = llvm.icmp "ne" %arg1, %1 : i64
    %18 = llvm.sext %17 : i1 to i32
    %19 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %18, %19 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_b_n   : fold_memcmp_a_b_n_before  ⊑  fold_memcmp_a_b_n_combined := by
  unfold fold_memcmp_a_b_n_before fold_memcmp_a_b_n_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_memcmp_a_b_n   : fold_memcmp_a_b_n_before  ⊑  fold_memcmp_a_b_n_combined := by
  unfold fold_memcmp_a_b_n_before fold_memcmp_a_b_n_combined
  simp_alive_peephole
  sorry
def call_memcmp_a_ax_n_combined := [llvmfunc|
  llvm.func @call_memcmp_a_ax_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("01230123") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @a01230123 : !llvm.ptr
    %2 = llvm.mlir.addressof @ax : !llvm.ptr
    %3 = llvm.call @memcmp(%1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %3, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_memcmp_a_ax_n   : call_memcmp_a_ax_n_before  ⊑  call_memcmp_a_ax_n_combined := by
  unfold call_memcmp_a_ax_n_before call_memcmp_a_ax_n_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_call_memcmp_a_ax_n   : call_memcmp_a_ax_n_before  ⊑  call_memcmp_a_ax_n_combined := by
  unfold call_memcmp_a_ax_n_before call_memcmp_a_ax_n_combined
  simp_alive_peephole
  sorry
def fold_memcmp_a_c_n_combined := [llvmfunc|
  llvm.func @fold_memcmp_a_c_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.mlir.constant(4 : i64) : i64
    %6 = llvm.mlir.constant(5 : i64) : i64
    %7 = llvm.icmp "ugt" %arg1, %0 : i64
    %8 = llvm.sext %7 : i1 to i32
    llvm.store %8, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_c_n   : fold_memcmp_a_c_n_before  ⊑  fold_memcmp_a_c_n_combined := by
  unfold fold_memcmp_a_c_n_before fold_memcmp_a_c_n_combined
  simp_alive_peephole
  sorry
    %9 = llvm.icmp "ne" %arg1, %1 : i64
    %10 = llvm.sext %9 : i1 to i32
    %11 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %10, %11 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_c_n   : fold_memcmp_a_c_n_before  ⊑  fold_memcmp_a_c_n_combined := by
  unfold fold_memcmp_a_c_n_before fold_memcmp_a_c_n_combined
  simp_alive_peephole
  sorry
    %12 = llvm.icmp "ne" %arg1, %1 : i64
    %13 = llvm.sext %12 : i1 to i32
    %14 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %13, %14 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_c_n   : fold_memcmp_a_c_n_before  ⊑  fold_memcmp_a_c_n_combined := by
  unfold fold_memcmp_a_c_n_before fold_memcmp_a_c_n_combined
  simp_alive_peephole
  sorry
    %15 = llvm.icmp "ne" %arg1, %1 : i64
    %16 = llvm.sext %15 : i1 to i32
    %17 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %16, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_c_n   : fold_memcmp_a_c_n_before  ⊑  fold_memcmp_a_c_n_combined := by
  unfold fold_memcmp_a_c_n_before fold_memcmp_a_c_n_combined
  simp_alive_peephole
  sorry
    %18 = llvm.icmp "ugt" %arg1, %4 : i64
    %19 = llvm.sext %18 : i1 to i32
    %20 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %19, %20 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_c_n   : fold_memcmp_a_c_n_before  ⊑  fold_memcmp_a_c_n_combined := by
  unfold fold_memcmp_a_c_n_before fold_memcmp_a_c_n_combined
  simp_alive_peephole
  sorry
    %21 = llvm.icmp "ugt" %arg1, %4 : i64
    %22 = llvm.sext %21 : i1 to i32
    %23 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %23 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_c_n   : fold_memcmp_a_c_n_before  ⊑  fold_memcmp_a_c_n_combined := by
  unfold fold_memcmp_a_c_n_before fold_memcmp_a_c_n_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_memcmp_a_c_n   : fold_memcmp_a_c_n_before  ⊑  fold_memcmp_a_c_n_combined := by
  unfold fold_memcmp_a_c_n_before fold_memcmp_a_c_n_combined
  simp_alive_peephole
  sorry
def fold_memcmp_a_d_n_combined := [llvmfunc|
  llvm.func @fold_memcmp_a_d_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.icmp "ne" %arg1, %0 : i64
    %6 = llvm.sext %5 : i1 to i32
    llvm.store %6, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_d_n   : fold_memcmp_a_d_n_before  ⊑  fold_memcmp_a_d_n_combined := by
  unfold fold_memcmp_a_d_n_before fold_memcmp_a_d_n_combined
  simp_alive_peephole
  sorry
    %7 = llvm.icmp "ne" %arg1, %0 : i64
    %8 = llvm.sext %7 : i1 to i32
    %9 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %8, %9 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_d_n   : fold_memcmp_a_d_n_before  ⊑  fold_memcmp_a_d_n_combined := by
  unfold fold_memcmp_a_d_n_before fold_memcmp_a_d_n_combined
  simp_alive_peephole
  sorry
    %10 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %3, %10 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_d_n   : fold_memcmp_a_d_n_before  ⊑  fold_memcmp_a_d_n_combined := by
  unfold fold_memcmp_a_d_n_before fold_memcmp_a_d_n_combined
  simp_alive_peephole
  sorry
    %11 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %3, %11 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_d_n   : fold_memcmp_a_d_n_before  ⊑  fold_memcmp_a_d_n_combined := by
  unfold fold_memcmp_a_d_n_before fold_memcmp_a_d_n_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_memcmp_a_d_n   : fold_memcmp_a_d_n_before  ⊑  fold_memcmp_a_d_n_combined := by
  unfold fold_memcmp_a_d_n_before fold_memcmp_a_d_n_combined
  simp_alive_peephole
  sorry
def fold_memcmp_a_d_nz_combined := [llvmfunc|
  llvm.func @fold_memcmp_a_d_nz(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_memcmp_a_d_nz   : fold_memcmp_a_d_nz_before  ⊑  fold_memcmp_a_d_nz_combined := by
  unfold fold_memcmp_a_d_nz_before fold_memcmp_a_d_nz_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_memcmp_a_d_nz   : fold_memcmp_a_d_nz_before  ⊑  fold_memcmp_a_d_nz_combined := by
  unfold fold_memcmp_a_d_nz_before fold_memcmp_a_d_nz_combined
  simp_alive_peephole
  sorry
