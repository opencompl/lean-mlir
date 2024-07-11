import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memchr-4
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def call_memchr_ax_2_uimax_p1_before := [llvmfunc|
  llvm.func @call_memchr_ax_2_uimax_p1() -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4294967296 : i64) : i64
    %3 = llvm.call @memchr(%0, %1, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def call_memchr_ax_2_uimax_p2_before := [llvmfunc|
  llvm.func @call_memchr_ax_2_uimax_p2() -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4294967296 : i64) : i64
    %3 = llvm.call @memchr(%0, %1, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def fold_memchr_a12345_3_uimax_p2_before := [llvmfunc|
  llvm.func @fold_memchr_a12345_3_uimax_p2() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(4294967297 : i64) : i64
    %4 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memchr_a12345_c_uimax_p2_before := [llvmfunc|
  llvm.func @fold_memchr_a12345_c_uimax_p2(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(4294967297 : i64) : i64
    %3 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def call_memchr_ax_2_uimax_p1_combined := [llvmfunc|
  llvm.func @call_memchr_ax_2_uimax_p1() -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4294967296 : i64) : i64
    %3 = llvm.call @memchr(%0, %1, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_call_memchr_ax_2_uimax_p1   : call_memchr_ax_2_uimax_p1_before  ⊑  call_memchr_ax_2_uimax_p1_combined := by
  unfold call_memchr_ax_2_uimax_p1_before call_memchr_ax_2_uimax_p1_combined
  simp_alive_peephole
  sorry
def call_memchr_ax_2_uimax_p2_combined := [llvmfunc|
  llvm.func @call_memchr_ax_2_uimax_p2() -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4294967296 : i64) : i64
    %3 = llvm.call @memchr(%0, %1, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_call_memchr_ax_2_uimax_p2   : call_memchr_ax_2_uimax_p2_before  ⊑  call_memchr_ax_2_uimax_p2_combined := by
  unfold call_memchr_ax_2_uimax_p2_before call_memchr_ax_2_uimax_p2_combined
  simp_alive_peephole
  sorry
def fold_memchr_a12345_3_uimax_p2_combined := [llvmfunc|
  llvm.func @fold_memchr_a12345_3_uimax_p2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_a12345_3_uimax_p2   : fold_memchr_a12345_3_uimax_p2_before  ⊑  fold_memchr_a12345_3_uimax_p2_combined := by
  unfold fold_memchr_a12345_3_uimax_p2_before fold_memchr_a12345_3_uimax_p2_combined
  simp_alive_peephole
  sorry
def fold_memchr_a12345_c_uimax_p2_combined := [llvmfunc|
  llvm.func @fold_memchr_a12345_c_uimax_p2(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(4294967297 : i64) : i64
    %3 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_a12345_c_uimax_p2   : fold_memchr_a12345_c_uimax_p2_before  ⊑  fold_memchr_a12345_c_uimax_p2_combined := by
  unfold fold_memchr_a12345_c_uimax_p2_before fold_memchr_a12345_c_uimax_p2_combined
  simp_alive_peephole
  sorry
