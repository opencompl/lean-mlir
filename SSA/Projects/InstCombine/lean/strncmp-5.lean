import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strncmp-5
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strncmp_a_b_n_before := [llvmfunc|
  llvm.func @fold_strncmp_a_b_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("01230123") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @b01230123 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(5 : i64) : i64
    %8 = llvm.mlir.addressof @a01230123 : !llvm.ptr
    %9 = llvm.mlir.constant(6 : i64) : i64
    %10 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %11 = llvm.getelementptr %1[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %12 = llvm.getelementptr %1[%2, %5] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %13 = llvm.getelementptr %1[%2, %6] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %14 = llvm.getelementptr %1[%2, %7] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %15 = llvm.call @strncmp(%8, %1, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %15, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %16 = llvm.call @strncmp(%8, %10, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %17 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %16, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

    %18 = llvm.call @strncmp(%8, %11, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %19 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %18, %19 {alignment = 4 : i64} : i32, !llvm.ptr]

    %20 = llvm.call @strncmp(%8, %12, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %21 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %20, %21 {alignment = 4 : i64} : i32, !llvm.ptr]

    %22 = llvm.call @strncmp(%8, %13, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %23 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %23 {alignment = 4 : i64} : i32, !llvm.ptr]

    %24 = llvm.call @strncmp(%8, %14, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %25 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %24, %25 {alignment = 4 : i64} : i32, !llvm.ptr]

    %26 = llvm.call @strncmp(%14, %8, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %27 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %26, %27 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def call_strncmp_a_ax_n_before := [llvmfunc|
  llvm.func @call_strncmp_a_ax_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("01230123") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @a01230123 : !llvm.ptr
    %2 = llvm.mlir.addressof @ax : !llvm.ptr
    %3 = llvm.call @strncmp(%1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %3, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_strncmp_a_c_n_before := [llvmfunc|
  llvm.func @fold_strncmp_a_c_n(%arg0: !llvm.ptr, %arg1: i64) {
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
    %15 = llvm.call @strncmp(%9, %1, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %15, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %16 = llvm.call @strncmp(%9, %10, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %17 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %16, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

    %18 = llvm.call @strncmp(%9, %11, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %19 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %18, %19 {alignment = 4 : i64} : i32, !llvm.ptr]

    %20 = llvm.call @strncmp(%9, %12, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %21 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %20, %21 {alignment = 4 : i64} : i32, !llvm.ptr]

    %22 = llvm.call @strncmp(%9, %13, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %23 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %23 {alignment = 4 : i64} : i32, !llvm.ptr]

    %24 = llvm.call @strncmp(%9, %13, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %25 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %24, %25 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_strncmp_a_d_n_before := [llvmfunc|
  llvm.func @fold_strncmp_a_d_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("01230123") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @a01230123 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(5 : i64) : i64
    %8 = llvm.mlir.constant(6 : i64) : i64
    %9 = llvm.mlir.constant("9123\0012") : !llvm.array<7 x i8>
    %10 = llvm.mlir.addressof @d9123_12 : !llvm.ptr
    %11 = llvm.mlir.constant(7 : i64) : i64
    %12 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %13 = llvm.getelementptr %1[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %14 = llvm.getelementptr %1[%2, %5] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %15 = llvm.getelementptr %1[%2, %6] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %16 = llvm.getelementptr %1[%2, %7] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %17 = llvm.getelementptr %1[%2, %8] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i8>
    %18 = llvm.getelementptr %10[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %19 = llvm.getelementptr %10[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %20 = llvm.getelementptr %10[%2, %5] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %21 = llvm.getelementptr %10[%2, %6] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %22 = llvm.getelementptr %10[%2, %7] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %23 = llvm.getelementptr %10[%2, %8] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %24 = llvm.call @strncmp(%1, %10, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %24, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %25 = llvm.call @strncmp(%1, %18, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %26 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %25, %26 {alignment = 4 : i64} : i32, !llvm.ptr]

    %27 = llvm.call @strncmp(%12, %18, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %28 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %27, %28 {alignment = 4 : i64} : i32, !llvm.ptr]

    %29 = llvm.call @strncmp(%13, %19, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %30 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %29, %30 {alignment = 4 : i64} : i32, !llvm.ptr]

    %31 = llvm.call @strncmp(%14, %20, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %32 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %31, %32 {alignment = 4 : i64} : i32, !llvm.ptr]

    %33 = llvm.call @strncmp(%15, %21, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %34 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %33, %34 {alignment = 4 : i64} : i32, !llvm.ptr]

    %35 = llvm.call @strncmp(%21, %15, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %36 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %35, %36 {alignment = 4 : i64} : i32, !llvm.ptr]

    %37 = llvm.call @strncmp(%16, %22, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %38 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %37, %38 {alignment = 4 : i64} : i32, !llvm.ptr]

    %39 = llvm.call @strncmp(%17, %23, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %40 = llvm.getelementptr %arg0[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %39, %40 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_strncmp_a_d_nz_before := [llvmfunc|
  llvm.func @fold_strncmp_a_d_nz(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant("01230123") : !llvm.array<8 x i8>
    %2 = llvm.mlir.addressof @a01230123 : !llvm.ptr
    %3 = llvm.mlir.constant("9123\0012") : !llvm.array<7 x i8>
    %4 = llvm.mlir.addressof @d9123_12 : !llvm.ptr
    %5 = llvm.or %arg1, %0  : i64
    %6 = llvm.call @strncmp(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %6, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_strncmp_d_e_n_before := [llvmfunc|
  llvm.func @fold_strncmp_d_e_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("9123\0012") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @d9123_12 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant("9123\0034") : !llvm.array<7 x i8>
    %5 = llvm.mlir.addressof @e9123_34 : !llvm.ptr
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(3 : i64) : i64
    %8 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %9 = llvm.getelementptr %5[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %10 = llvm.call @strncmp(%1, %5, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %10, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %11 = llvm.call @strncmp(%1, %9, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %12 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %11, %12 {alignment = 4 : i64} : i32, !llvm.ptr]

    %13 = llvm.call @strncmp(%8, %5, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %14 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %13, %14 {alignment = 4 : i64} : i32, !llvm.ptr]

    %15 = llvm.call @strncmp(%8, %9, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %16 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %15, %16 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_strncmp_a_b_n_combined := [llvmfunc|
  llvm.func @fold_strncmp_a_b_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.mlir.constant(4 : i64) : i64
    %6 = llvm.mlir.constant(5 : i64) : i64
    %7 = llvm.mlir.constant(6 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_b_n   : fold_strncmp_a_b_n_before  ⊑  fold_strncmp_a_b_n_combined := by
  unfold fold_strncmp_a_b_n_before fold_strncmp_a_b_n_combined
  simp_alive_peephole
  sorry
    %8 = llvm.icmp "ne" %arg1, %1 : i64
    %9 = llvm.sext %8 : i1 to i32
    %10 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %9, %10 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_b_n   : fold_strncmp_a_b_n_before  ⊑  fold_strncmp_a_b_n_combined := by
  unfold fold_strncmp_a_b_n_before fold_strncmp_a_b_n_combined
  simp_alive_peephole
  sorry
    %11 = llvm.icmp "ne" %arg1, %1 : i64
    %12 = llvm.sext %11 : i1 to i32
    %13 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %12, %13 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_b_n   : fold_strncmp_a_b_n_before  ⊑  fold_strncmp_a_b_n_combined := by
  unfold fold_strncmp_a_b_n_before fold_strncmp_a_b_n_combined
  simp_alive_peephole
  sorry
    %14 = llvm.icmp "ne" %arg1, %1 : i64
    %15 = llvm.sext %14 : i1 to i32
    %16 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %15, %16 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_b_n   : fold_strncmp_a_b_n_before  ⊑  fold_strncmp_a_b_n_combined := by
  unfold fold_strncmp_a_b_n_before fold_strncmp_a_b_n_combined
  simp_alive_peephole
  sorry
    %17 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_b_n   : fold_strncmp_a_b_n_before  ⊑  fold_strncmp_a_b_n_combined := by
  unfold fold_strncmp_a_b_n_before fold_strncmp_a_b_n_combined
  simp_alive_peephole
  sorry
    %18 = llvm.icmp "ne" %arg1, %1 : i64
    %19 = llvm.sext %18 : i1 to i32
    %20 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %19, %20 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_b_n   : fold_strncmp_a_b_n_before  ⊑  fold_strncmp_a_b_n_combined := by
  unfold fold_strncmp_a_b_n_before fold_strncmp_a_b_n_combined
  simp_alive_peephole
  sorry
    %21 = llvm.icmp "ne" %arg1, %1 : i64
    %22 = llvm.zext %21 : i1 to i32
    %23 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %23 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_b_n   : fold_strncmp_a_b_n_before  ⊑  fold_strncmp_a_b_n_combined := by
  unfold fold_strncmp_a_b_n_before fold_strncmp_a_b_n_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_strncmp_a_b_n   : fold_strncmp_a_b_n_before  ⊑  fold_strncmp_a_b_n_combined := by
  unfold fold_strncmp_a_b_n_before fold_strncmp_a_b_n_combined
  simp_alive_peephole
  sorry
def call_strncmp_a_ax_n_combined := [llvmfunc|
  llvm.func @call_strncmp_a_ax_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("01230123") : !llvm.array<8 x i8>
    %1 = llvm.mlir.addressof @a01230123 : !llvm.ptr
    %2 = llvm.mlir.addressof @ax : !llvm.ptr
    %3 = llvm.call @strncmp(%1, %2, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %3, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_call_strncmp_a_ax_n   : call_strncmp_a_ax_n_before  ⊑  call_strncmp_a_ax_n_combined := by
  unfold call_strncmp_a_ax_n_before call_strncmp_a_ax_n_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_call_strncmp_a_ax_n   : call_strncmp_a_ax_n_before  ⊑  call_strncmp_a_ax_n_combined := by
  unfold call_strncmp_a_ax_n_before call_strncmp_a_ax_n_combined
  simp_alive_peephole
  sorry
def fold_strncmp_a_c_n_combined := [llvmfunc|
  llvm.func @fold_strncmp_a_c_n(%arg0: !llvm.ptr, %arg1: i64) {
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

theorem inst_combine_fold_strncmp_a_c_n   : fold_strncmp_a_c_n_before  ⊑  fold_strncmp_a_c_n_combined := by
  unfold fold_strncmp_a_c_n_before fold_strncmp_a_c_n_combined
  simp_alive_peephole
  sorry
    %9 = llvm.icmp "ne" %arg1, %1 : i64
    %10 = llvm.sext %9 : i1 to i32
    %11 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %10, %11 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_c_n   : fold_strncmp_a_c_n_before  ⊑  fold_strncmp_a_c_n_combined := by
  unfold fold_strncmp_a_c_n_before fold_strncmp_a_c_n_combined
  simp_alive_peephole
  sorry
    %12 = llvm.icmp "ne" %arg1, %1 : i64
    %13 = llvm.sext %12 : i1 to i32
    %14 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %13, %14 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_c_n   : fold_strncmp_a_c_n_before  ⊑  fold_strncmp_a_c_n_combined := by
  unfold fold_strncmp_a_c_n_before fold_strncmp_a_c_n_combined
  simp_alive_peephole
  sorry
    %15 = llvm.icmp "ne" %arg1, %1 : i64
    %16 = llvm.sext %15 : i1 to i32
    %17 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %16, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_c_n   : fold_strncmp_a_c_n_before  ⊑  fold_strncmp_a_c_n_combined := by
  unfold fold_strncmp_a_c_n_before fold_strncmp_a_c_n_combined
  simp_alive_peephole
  sorry
    %18 = llvm.icmp "ugt" %arg1, %4 : i64
    %19 = llvm.sext %18 : i1 to i32
    %20 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %19, %20 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_c_n   : fold_strncmp_a_c_n_before  ⊑  fold_strncmp_a_c_n_combined := by
  unfold fold_strncmp_a_c_n_before fold_strncmp_a_c_n_combined
  simp_alive_peephole
  sorry
    %21 = llvm.icmp "ugt" %arg1, %4 : i64
    %22 = llvm.sext %21 : i1 to i32
    %23 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %22, %23 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_c_n   : fold_strncmp_a_c_n_before  ⊑  fold_strncmp_a_c_n_combined := by
  unfold fold_strncmp_a_c_n_before fold_strncmp_a_c_n_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_strncmp_a_c_n   : fold_strncmp_a_c_n_before  ⊑  fold_strncmp_a_c_n_combined := by
  unfold fold_strncmp_a_c_n_before fold_strncmp_a_c_n_combined
  simp_alive_peephole
  sorry
def fold_strncmp_a_d_n_combined := [llvmfunc|
  llvm.func @fold_strncmp_a_d_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.mlir.constant(5 : i64) : i64
    %6 = llvm.mlir.constant(6 : i64) : i64
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.mlir.constant(7 : i64) : i64
    %9 = llvm.icmp "ne" %arg1, %0 : i64
    %10 = llvm.sext %9 : i1 to i32
    llvm.store %10, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_d_n   : fold_strncmp_a_d_n_before  ⊑  fold_strncmp_a_d_n_combined := by
  unfold fold_strncmp_a_d_n_before fold_strncmp_a_d_n_combined
  simp_alive_peephole
  sorry
    %11 = llvm.icmp "ne" %arg1, %0 : i64
    %12 = llvm.sext %11 : i1 to i32
    %13 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %12, %13 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_d_n   : fold_strncmp_a_d_n_before  ⊑  fold_strncmp_a_d_n_combined := by
  unfold fold_strncmp_a_d_n_before fold_strncmp_a_d_n_combined
  simp_alive_peephole
  sorry
    %14 = llvm.icmp "ugt" %arg1, %2 : i64
    %15 = llvm.zext %14 : i1 to i32
    %16 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %15, %16 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_d_n   : fold_strncmp_a_d_n_before  ⊑  fold_strncmp_a_d_n_combined := by
  unfold fold_strncmp_a_d_n_before fold_strncmp_a_d_n_combined
  simp_alive_peephole
  sorry
    %17 = llvm.icmp "ugt" %arg1, %3 : i64
    %18 = llvm.zext %17 : i1 to i32
    %19 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %18, %19 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_d_n   : fold_strncmp_a_d_n_before  ⊑  fold_strncmp_a_d_n_combined := by
  unfold fold_strncmp_a_d_n_before fold_strncmp_a_d_n_combined
  simp_alive_peephole
  sorry
    %20 = llvm.icmp "ne" %arg1, %0 : i64
    %21 = llvm.zext %20 : i1 to i32
    %22 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %21, %22 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_d_n   : fold_strncmp_a_d_n_before  ⊑  fold_strncmp_a_d_n_combined := by
  unfold fold_strncmp_a_d_n_before fold_strncmp_a_d_n_combined
  simp_alive_peephole
  sorry
    %23 = llvm.icmp "ne" %arg1, %0 : i64
    %24 = llvm.sext %23 : i1 to i32
    %25 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %24, %25 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_d_n   : fold_strncmp_a_d_n_before  ⊑  fold_strncmp_a_d_n_combined := by
  unfold fold_strncmp_a_d_n_before fold_strncmp_a_d_n_combined
  simp_alive_peephole
  sorry
    %26 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %7, %26 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_d_n   : fold_strncmp_a_d_n_before  ⊑  fold_strncmp_a_d_n_combined := by
  unfold fold_strncmp_a_d_n_before fold_strncmp_a_d_n_combined
  simp_alive_peephole
  sorry
    %27 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %7, %27 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_d_n   : fold_strncmp_a_d_n_before  ⊑  fold_strncmp_a_d_n_combined := by
  unfold fold_strncmp_a_d_n_before fold_strncmp_a_d_n_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_strncmp_a_d_n   : fold_strncmp_a_d_n_before  ⊑  fold_strncmp_a_d_n_combined := by
  unfold fold_strncmp_a_d_n_before fold_strncmp_a_d_n_combined
  simp_alive_peephole
  sorry
def fold_strncmp_a_d_nz_combined := [llvmfunc|
  llvm.func @fold_strncmp_a_d_nz(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_a_d_nz   : fold_strncmp_a_d_nz_before  ⊑  fold_strncmp_a_d_nz_combined := by
  unfold fold_strncmp_a_d_nz_before fold_strncmp_a_d_nz_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_strncmp_a_d_nz   : fold_strncmp_a_d_nz_before  ⊑  fold_strncmp_a_d_nz_combined := by
  unfold fold_strncmp_a_d_nz_before fold_strncmp_a_d_nz_combined
  simp_alive_peephole
  sorry
def fold_strncmp_d_e_n_combined := [llvmfunc|
  llvm.func @fold_strncmp_d_e_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(3 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_d_e_n   : fold_strncmp_d_e_n_before  ⊑  fold_strncmp_d_e_n_combined := by
  unfold fold_strncmp_d_e_n_before fold_strncmp_d_e_n_combined
  simp_alive_peephole
  sorry
    %5 = llvm.icmp "ne" %arg1, %1 : i64
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %6, %7 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_d_e_n   : fold_strncmp_d_e_n_before  ⊑  fold_strncmp_d_e_n_combined := by
  unfold fold_strncmp_d_e_n_before fold_strncmp_d_e_n_combined
  simp_alive_peephole
  sorry
    %8 = llvm.icmp "ne" %arg1, %1 : i64
    %9 = llvm.sext %8 : i1 to i32
    %10 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %9, %10 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_d_e_n   : fold_strncmp_d_e_n_before  ⊑  fold_strncmp_d_e_n_combined := by
  unfold fold_strncmp_d_e_n_before fold_strncmp_d_e_n_combined
  simp_alive_peephole
  sorry
    %11 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %11 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fold_strncmp_d_e_n   : fold_strncmp_d_e_n_before  ⊑  fold_strncmp_d_e_n_combined := by
  unfold fold_strncmp_d_e_n_before fold_strncmp_d_e_n_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_strncmp_d_e_n   : fold_strncmp_d_e_n_before  ⊑  fold_strncmp_d_e_n_combined := by
  unfold fold_strncmp_d_e_n_before fold_strncmp_d_e_n_combined
  simp_alive_peephole
  sorry
