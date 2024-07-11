import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memcmp-6
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_memcmp_cst_cst_before := [llvmfunc|
  llvm.func @fold_memcmp_cst_cst(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("abcdef\7F") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.mlir.constant(6 : i64) : i64
    %5 = llvm.mlir.constant("abcdef\80") : !llvm.array<7 x i8>
    %6 = llvm.mlir.addressof @b : !llvm.ptr
    %7 = llvm.mlir.constant(2 : i64) : i64
    %8 = llvm.mlir.constant(1 : i64) : i64
    %9 = llvm.mlir.constant(3 : i64) : i64
    %10 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %11 = llvm.getelementptr %1[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %12 = llvm.getelementptr %6[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %13 = llvm.getelementptr %6[%2, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %14 = llvm.call @memcmp(%10, %12, %7) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %14, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %15 = llvm.call @memcmp(%12, %10, %7) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %16 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %15, %16 {alignment = 4 : i64} : i32, !llvm.ptr]

    %17 = llvm.call @memcmp(%11, %13, %8) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %18 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %17, %18 {alignment = 4 : i64} : i32, !llvm.ptr]

    %19 = llvm.call @memcmp(%13, %11, %8) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %20 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %19, %20 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_memcmp_cst_var_before := [llvmfunc|
  llvm.func @fold_memcmp_cst_var(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("abcdef\7F") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.mlir.constant("abcdef\80") : !llvm.array<7 x i8>
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.mlir.constant(2 : i64) : i64
    %8 = llvm.mlir.constant(3 : i64) : i64
    %9 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %10 = llvm.getelementptr %5[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %11 = llvm.call @memcmp(%1, %5, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.store %11, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %12 = llvm.call @memcmp(%5, %1, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %13 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %12, %13 {alignment = 4 : i64} : i32, !llvm.ptr]

    %14 = llvm.call @memcmp(%9, %10, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %15 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %14, %15 {alignment = 4 : i64} : i32, !llvm.ptr]

    %16 = llvm.call @memcmp(%10, %9, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    %17 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %16, %17 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fold_memcmp_cst_cst_combined := [llvmfunc|
  llvm.func @fold_memcmp_cst_cst(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(3 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %2, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    %6 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %0, %6 {alignment = 4 : i64} : i32, !llvm.ptr
    %7 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %2, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_memcmp_cst_cst   : fold_memcmp_cst_cst_before  ⊑  fold_memcmp_cst_cst_combined := by
  unfold fold_memcmp_cst_cst_before fold_memcmp_cst_cst_combined
  simp_alive_peephole
  sorry
def fold_memcmp_cst_var_combined := [llvmfunc|
  llvm.func @fold_memcmp_cst_var(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(6 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.icmp "ugt" %arg1, %0 : i64
    %6 = llvm.sext %5 : i1 to i32
    llvm.store %6, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    %7 = llvm.icmp "ugt" %arg1, %0 : i64
    %8 = llvm.zext %7 : i1 to i32
    %9 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %8, %9 {alignment = 4 : i64} : i32, !llvm.ptr
    %10 = llvm.icmp "ne" %arg1, %2 : i64
    %11 = llvm.sext %10 : i1 to i32
    %12 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %11, %12 {alignment = 4 : i64} : i32, !llvm.ptr
    %13 = llvm.icmp "ne" %arg1, %2 : i64
    %14 = llvm.zext %13 : i1 to i32
    %15 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %14, %15 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_fold_memcmp_cst_var   : fold_memcmp_cst_var_before  ⊑  fold_memcmp_cst_var_combined := by
  unfold fold_memcmp_cst_var_before fold_memcmp_cst_var_combined
  simp_alive_peephole
  sorry
