import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memcmp-8
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_memcmp_a5_a5p5_n_before := [llvmfunc|
  llvm.func @fold_memcmp_a5_a5p5_n(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @memcmp(%1, %4, %arg0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %5 : i32
  }]

def fold_memcmp_a5p5_a5p5_n_before := [llvmfunc|
  llvm.func @fold_memcmp_a5p5_a5p5_n(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @memcmp(%4, %5, %arg0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %6 : i32
  }]

def fold_memcmp_a5pi_a5p5_n_before := [llvmfunc|
  llvm.func @fold_memcmp_a5pi_a5p5_n(%arg0: i32, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @memcmp(%4, %5, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %6 : i32
  }]

def fold_memcmp_a5_a5p5_n_combined := [llvmfunc|
  llvm.func @fold_memcmp_a5_a5p5_n(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fold_memcmp_a5_a5p5_n   : fold_memcmp_a5_a5p5_n_before  ⊑  fold_memcmp_a5_a5p5_n_combined := by
  unfold fold_memcmp_a5_a5p5_n_before fold_memcmp_a5_a5p5_n_combined
  simp_alive_peephole
  sorry
def fold_memcmp_a5p5_a5p5_n_combined := [llvmfunc|
  llvm.func @fold_memcmp_a5p5_a5p5_n(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fold_memcmp_a5p5_a5p5_n   : fold_memcmp_a5p5_a5p5_n_before  ⊑  fold_memcmp_a5p5_a5p5_n_combined := by
  unfold fold_memcmp_a5p5_a5p5_n_before fold_memcmp_a5p5_a5p5_n_combined
  simp_alive_peephole
  sorry
def fold_memcmp_a5pi_a5p5_n_combined := [llvmfunc|
  llvm.func @fold_memcmp_a5pi_a5p5_n(%arg0: i32, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%3, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.sext %arg0 : i32 to i64
    %6 = llvm.getelementptr %1[%2, %5] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %7 = llvm.call @memcmp(%6, %4, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %7 : i32
  }]

theorem inst_combine_fold_memcmp_a5pi_a5p5_n   : fold_memcmp_a5pi_a5p5_n_before  ⊑  fold_memcmp_a5pi_a5p5_n_combined := by
  unfold fold_memcmp_a5pi_a5p5_n_before fold_memcmp_a5pi_a5p5_n_combined
  simp_alive_peephole
  sorry
