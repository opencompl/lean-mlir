import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strlen-9
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strlen_no_nul_before := [llvmfunc|
  llvm.func @fold_strlen_no_nul(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %6 = llvm.mlir.addressof @s5 : !llvm.ptr
    %7 = llvm.mlir.constant(6 : i32) : i32
    %8 = llvm.mlir.constant(2 : i64) : i64
    %9 = llvm.mlir.constant(3 : i64) : i64
    %10 = llvm.mlir.constant(dense<0> : tensor<0xi8>) : !llvm.array<0 x i8>
    %11 = llvm.mlir.addressof @z0 : !llvm.ptr
    %12 = llvm.mlir.constant(4 : i64) : i64
    %13 = llvm.mlir.constant(5 : i64) : i64
    %14 = llvm.mlir.constant(0 : i8) : i8
    %15 = llvm.mlir.constant(dense<0> : tensor<5xi8>) : !llvm.array<5 x i8>
    %16 = llvm.mlir.addressof @z5 : !llvm.ptr
    %17 = llvm.mlir.constant(6 : i64) : i64
    %18 = llvm.call @strlen(%1) : (!llvm.ptr) -> i64
    llvm.store %18, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    %19 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %20 = llvm.call @strlen(%19) : (!llvm.ptr) -> i64
    %21 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %20, %21 {alignment = 4 : i64} : i64, !llvm.ptr]

    %22 = llvm.getelementptr %6[%2, %7] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<6 x i8>
    %23 = llvm.call @strlen(%22) : (!llvm.ptr) -> i64
    %24 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %23, %24 {alignment = 4 : i64} : i64, !llvm.ptr]

    %25 = llvm.getelementptr %1[%2, %arg1] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %26 = llvm.call @strlen(%25) : (!llvm.ptr) -> i64
    %27 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %26, %27 {alignment = 4 : i64} : i64, !llvm.ptr]

    %28 = llvm.call @strlen(%11) : (!llvm.ptr) -> i64
    %29 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %28, %29 {alignment = 4 : i64} : i64, !llvm.ptr]

    %30 = llvm.getelementptr %11[%2, %arg1] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i8>
    %31 = llvm.call @strlen(%30) : (!llvm.ptr) -> i64
    %32 = llvm.getelementptr %arg0[%13] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %31, %32 {alignment = 4 : i64} : i64, !llvm.ptr]

    %33 = llvm.getelementptr %16[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %34 = llvm.call @strlen(%33) : (!llvm.ptr) -> i64
    %35 = llvm.getelementptr %arg0[%17] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %34, %35 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def fold_strlen_no_nul_combined := [llvmfunc|
  llvm.func @fold_strlen_no_nul(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %5 = llvm.mlir.addressof @a5 : !llvm.ptr
    %6 = llvm.mlir.constant(3 : i64) : i64
    %7 = llvm.mlir.constant(4 : i64) : i64
    %8 = llvm.mlir.constant(dense<0> : tensor<0xi8>) : !llvm.array<0 x i8>
    %9 = llvm.mlir.addressof @z0 : !llvm.ptr
    %10 = llvm.mlir.constant(6 : i64) : i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_strlen_no_nul   : fold_strlen_no_nul_before  ⊑  fold_strlen_no_nul_combined := by
  unfold fold_strlen_no_nul_before fold_strlen_no_nul_combined
  simp_alive_peephole
  sorry
    %11 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %2, %11 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_strlen_no_nul   : fold_strlen_no_nul_before  ⊑  fold_strlen_no_nul_combined := by
  unfold fold_strlen_no_nul_before fold_strlen_no_nul_combined
  simp_alive_peephole
  sorry
    %12 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %2, %12 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_strlen_no_nul   : fold_strlen_no_nul_before  ⊑  fold_strlen_no_nul_combined := by
  unfold fold_strlen_no_nul_before fold_strlen_no_nul_combined
  simp_alive_peephole
  sorry
    %13 = llvm.sext %arg1 : i32 to i64
    %14 = llvm.getelementptr %5[%2, %13] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %15 = llvm.call @strlen(%14) : (!llvm.ptr) -> i64
    %16 = llvm.getelementptr %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %15, %16 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_strlen_no_nul   : fold_strlen_no_nul_before  ⊑  fold_strlen_no_nul_combined := by
  unfold fold_strlen_no_nul_before fold_strlen_no_nul_combined
  simp_alive_peephole
  sorry
    %17 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %2, %17 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_strlen_no_nul   : fold_strlen_no_nul_before  ⊑  fold_strlen_no_nul_combined := by
  unfold fold_strlen_no_nul_before fold_strlen_no_nul_combined
  simp_alive_peephole
  sorry
    %18 = llvm.sext %arg1 : i32 to i64
    %19 = llvm.getelementptr %9[%2, %18] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i8>
    %20 = llvm.call @strlen(%19) : (!llvm.ptr) -> i64
    %21 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %20, %21 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_strlen_no_nul   : fold_strlen_no_nul_before  ⊑  fold_strlen_no_nul_combined := by
  unfold fold_strlen_no_nul_before fold_strlen_no_nul_combined
  simp_alive_peephole
  sorry
    %22 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %2, %22 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_fold_strlen_no_nul   : fold_strlen_no_nul_before  ⊑  fold_strlen_no_nul_combined := by
  unfold fold_strlen_no_nul_before fold_strlen_no_nul_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fold_strlen_no_nul   : fold_strlen_no_nul_before  ⊑  fold_strlen_no_nul_combined := by
  unfold fold_strlen_no_nul_before fold_strlen_no_nul_combined
  simp_alive_peephole
  sorry
