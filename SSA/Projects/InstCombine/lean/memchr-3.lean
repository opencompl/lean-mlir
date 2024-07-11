import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memchr-3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_memchr_a12345_1_1_before := [llvmfunc|
  llvm.func @fold_memchr_a12345_1_1() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memchr_a12345_2_1_before := [llvmfunc|
  llvm.func @fold_memchr_a12345_2_1() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memchr_ax_257_1_before := [llvmfunc|
  llvm.func @fold_memchr_ax_257_1(%arg0: i32, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(257 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.call @memchr(%0, %1, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def fold_memchr_ax_c_1_before := [llvmfunc|
  llvm.func @fold_memchr_ax_c_1(%arg0: i32, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @memchr(%0, %arg0, %1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def fold_memchr_a12345_1_1_combined := [llvmfunc|
  llvm.func @fold_memchr_a12345_1_1() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_a12345_1_1   : fold_memchr_a12345_1_1_before  ⊑  fold_memchr_a12345_1_1_combined := by
  unfold fold_memchr_a12345_1_1_before fold_memchr_a12345_1_1_combined
  simp_alive_peephole
  sorry
def fold_memchr_a12345_2_1_combined := [llvmfunc|
  llvm.func @fold_memchr_a12345_2_1() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_a12345_2_1   : fold_memchr_a12345_2_1_before  ⊑  fold_memchr_a12345_2_1_combined := by
  unfold fold_memchr_a12345_2_1_before fold_memchr_a12345_2_1_combined
  simp_alive_peephole
  sorry
def fold_memchr_ax_257_1_combined := [llvmfunc|
  llvm.func @fold_memchr_ax_257_1(%arg0: i32, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_fold_memchr_ax_257_1   : fold_memchr_ax_257_1_before  ⊑  fold_memchr_ax_257_1_combined := by
  unfold fold_memchr_ax_257_1_before fold_memchr_ax_257_1_combined
  simp_alive_peephole
  sorry
    %4 = llvm.icmp "eq" %3, %1 : i8
    %5 = llvm.select %4, %0, %2 : i1, !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_ax_257_1   : fold_memchr_ax_257_1_before  ⊑  fold_memchr_ax_257_1_combined := by
  unfold fold_memchr_ax_257_1_before fold_memchr_ax_257_1_combined
  simp_alive_peephole
  sorry
def fold_memchr_ax_c_1_combined := [llvmfunc|
  llvm.func @fold_memchr_ax_c_1(%arg0: i32, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_fold_memchr_ax_c_1   : fold_memchr_ax_c_1_before  ⊑  fold_memchr_ax_c_1_combined := by
  unfold fold_memchr_ax_c_1_before fold_memchr_ax_c_1_combined
  simp_alive_peephole
  sorry
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.icmp "eq" %2, %3 : i8
    %5 = llvm.select %4, %0, %1 : i1, !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_ax_c_1   : fold_memchr_ax_c_1_before  ⊑  fold_memchr_ax_c_1_combined := by
  unfold fold_memchr_ax_c_1_before fold_memchr_ax_c_1_combined
  simp_alive_peephole
  sorry
