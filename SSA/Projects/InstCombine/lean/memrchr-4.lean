import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memrchr-4
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_memrchr_a11111_c_5_before := [llvmfunc|
  llvm.func @fold_memrchr_a11111_c_5(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\01\01") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a11111 : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def fold_memrchr_a11111_c_n_before := [llvmfunc|
  llvm.func @fold_memrchr_a11111_c_n(%arg0: i32, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\01\01") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a11111 : !llvm.ptr
    %2 = llvm.call @memrchr(%1, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def fold_memrchr_a1110111_c_3_before := [llvmfunc|
  llvm.func @fold_memrchr_a1110111_c_3(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def call_memrchr_a1110111_c_4_before := [llvmfunc|
  llvm.func @call_memrchr_a1110111_c_4(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def call_memrchr_a1110111_c_7_before := [llvmfunc|
  llvm.func @call_memrchr_a1110111_c_7(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def call_memrchr_a1110111_c_n_before := [llvmfunc|
  llvm.func @call_memrchr_a1110111_c_n(%arg0: i32, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.call @memrchr(%1, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def fold_memrchr_a11111_c_5_combined := [llvmfunc|
  llvm.func @fold_memrchr_a11111_c_5(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("\01\01\01\01\01") : !llvm.array<5 x i8>
    %4 = llvm.mlir.addressof @a11111 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "eq" %7, %0 : i8
    %9 = llvm.select %8, %5, %6 : i1, !llvm.ptr
    llvm.return %9 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a11111_c_5   : fold_memrchr_a11111_c_5_before  ⊑  fold_memrchr_a11111_c_5_combined := by
  unfold fold_memrchr_a11111_c_5_before fold_memrchr_a11111_c_5_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a11111_c_n_combined := [llvmfunc|
  llvm.func @fold_memrchr_a11111_c_n(%arg0: i32, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant("\01\01\01\01\01") : !llvm.array<5 x i8>
    %4 = llvm.mlir.addressof @a11111 : !llvm.ptr
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.icmp "ne" %arg1, %0 : i64
    %8 = llvm.trunc %arg0 : i32 to i8
    %9 = llvm.icmp "eq" %8, %1 : i8
    %10 = llvm.select %7, %9, %2 : i1, i1
    %11 = llvm.getelementptr %4[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %12 = llvm.getelementptr %11[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %13 = llvm.select %10, %12, %6 : i1, !llvm.ptr
    llvm.return %13 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a11111_c_n   : fold_memrchr_a11111_c_n_before  ⊑  fold_memrchr_a11111_c_n_combined := by
  unfold fold_memrchr_a11111_c_n_before fold_memrchr_a11111_c_n_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a1110111_c_3_combined := [llvmfunc|
  llvm.func @fold_memrchr_a1110111_c_3(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %4 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.trunc %arg0 : i32 to i8
    %8 = llvm.icmp "eq" %7, %0 : i8
    %9 = llvm.select %8, %5, %6 : i1, !llvm.ptr
    llvm.return %9 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a1110111_c_3   : fold_memrchr_a1110111_c_3_before  ⊑  fold_memrchr_a1110111_c_3_combined := by
  unfold fold_memrchr_a1110111_c_3_before fold_memrchr_a1110111_c_3_combined
  simp_alive_peephole
  sorry
def call_memrchr_a1110111_c_4_combined := [llvmfunc|
  llvm.func @call_memrchr_a1110111_c_4(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_call_memrchr_a1110111_c_4   : call_memrchr_a1110111_c_4_before  ⊑  call_memrchr_a1110111_c_4_combined := by
  unfold call_memrchr_a1110111_c_4_before call_memrchr_a1110111_c_4_combined
  simp_alive_peephole
  sorry
def call_memrchr_a1110111_c_7_combined := [llvmfunc|
  llvm.func @call_memrchr_a1110111_c_7(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_call_memrchr_a1110111_c_7   : call_memrchr_a1110111_c_7_before  ⊑  call_memrchr_a1110111_c_7_combined := by
  unfold call_memrchr_a1110111_c_7_before call_memrchr_a1110111_c_7_combined
  simp_alive_peephole
  sorry
def call_memrchr_a1110111_c_n_combined := [llvmfunc|
  llvm.func @call_memrchr_a1110111_c_n(%arg0: i32, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.call @memrchr(%1, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_call_memrchr_a1110111_c_n   : call_memrchr_a1110111_c_n_before  ⊑  call_memrchr_a1110111_c_n_combined := by
  unfold call_memrchr_a1110111_c_n_before call_memrchr_a1110111_c_n_combined
  simp_alive_peephole
  sorry
