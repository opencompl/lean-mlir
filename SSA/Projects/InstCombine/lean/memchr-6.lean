import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memchr-6
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_memchr_a00000_c_5_before := [llvmfunc|
  llvm.func @fold_memchr_a00000_c_5(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<5xi8>) : !llvm.array<5 x i8>
    %2 = llvm.mlir.addressof @a00000 : !llvm.ptr
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.call @memchr(%2, %arg0, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memchr_a11111_c_5_before := [llvmfunc|
  llvm.func @fold_memchr_a11111_c_5(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\01\01") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a11111 : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def fold_memchr_a11111_c_n_before := [llvmfunc|
  llvm.func @fold_memchr_a11111_c_n(%arg0: i32, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\01\01") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a11111 : !llvm.ptr
    %2 = llvm.call @memchr(%1, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def fold_memchr_a111122_c_n_before := [llvmfunc|
  llvm.func @fold_memchr_a111122_c_n(%arg0: i32, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\01\02\02") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a111122 : !llvm.ptr
    %2 = llvm.call @memchr(%1, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def fold_memchr_a1110111_c_3_before := [llvmfunc|
  llvm.func @fold_memchr_a1110111_c_3(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def call_memchr_a1110111_c_4_before := [llvmfunc|
  llvm.func @call_memchr_a1110111_c_4(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def call_memchr_a1110111_c_7_before := [llvmfunc|
  llvm.func @call_memchr_a1110111_c_7(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def call_memchr_a1110111_c_n_before := [llvmfunc|
  llvm.func @call_memchr_a1110111_c_n(%arg0: i32, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.call @memchr(%1, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def fold_memchr_a00000_c_5_combined := [llvmfunc|
  llvm.func @fold_memchr_a00000_c_5(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<5xi8>) : !llvm.array<5 x i8>
    %2 = llvm.mlir.addressof @a00000 : !llvm.ptr
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.call @memchr(%2, %arg0, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_a00000_c_5   : fold_memchr_a00000_c_5_before  ⊑  fold_memchr_a00000_c_5_combined := by
  unfold fold_memchr_a00000_c_5_before fold_memchr_a00000_c_5_combined
  simp_alive_peephole
  sorry
def fold_memchr_a11111_c_5_combined := [llvmfunc|
  llvm.func @fold_memchr_a11111_c_5(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant("\01\01\01\01\01") : !llvm.array<5 x i8>
    %2 = llvm.mlir.addressof @a11111 : !llvm.ptr
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.trunc %arg0 : i32 to i8
    %5 = llvm.icmp "eq" %4, %0 : i8
    %6 = llvm.select %5, %2, %3 : i1, !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_a11111_c_5   : fold_memchr_a11111_c_5_before  ⊑  fold_memchr_a11111_c_5_combined := by
  unfold fold_memchr_a11111_c_5_before fold_memchr_a11111_c_5_combined
  simp_alive_peephole
  sorry
def fold_memchr_a11111_c_n_combined := [llvmfunc|
  llvm.func @fold_memchr_a11111_c_n(%arg0: i32, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("\01\01\01\01\01") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @a11111 : !llvm.ptr
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.trunc %arg0 : i32 to i8
    %6 = llvm.icmp "eq" %5, %0 : i8
    %7 = llvm.icmp "ne" %arg1, %1 : i64
    %8 = llvm.and %7, %6  : i1
    %9 = llvm.select %8, %3, %4 : i1, !llvm.ptr
    llvm.return %9 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_a11111_c_n   : fold_memchr_a11111_c_n_before  ⊑  fold_memchr_a11111_c_n_combined := by
  unfold fold_memchr_a11111_c_n_before fold_memchr_a11111_c_n_combined
  simp_alive_peephole
  sorry
def fold_memchr_a111122_c_n_combined := [llvmfunc|
  llvm.func @fold_memchr_a111122_c_n(%arg0: i32, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("\01\01\01\01\02\02") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @a111122 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.mlir.constant(1 : i8) : i8
    %8 = llvm.trunc %arg0 : i32 to i8
    %9 = llvm.icmp "eq" %8, %0 : i8
    %10 = llvm.icmp "ugt" %arg1, %1 : i64
    %11 = llvm.and %9, %10  : i1
    %12 = llvm.select %11, %5, %6 : i1, !llvm.ptr
    %13 = llvm.icmp "eq" %8, %7 : i8
    %14 = llvm.icmp "ne" %arg1, %2 : i64
    %15 = llvm.and %14, %13  : i1
    %16 = llvm.select %15, %4, %12 : i1, !llvm.ptr
    llvm.return %16 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_a111122_c_n   : fold_memchr_a111122_c_n_before  ⊑  fold_memchr_a111122_c_n_combined := by
  unfold fold_memchr_a111122_c_n_before fold_memchr_a111122_c_n_combined
  simp_alive_peephole
  sorry
def fold_memchr_a1110111_c_3_combined := [llvmfunc|
  llvm.func @fold_memchr_a1110111_c_3(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %2 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.trunc %arg0 : i32 to i8
    %5 = llvm.icmp "eq" %4, %0 : i8
    %6 = llvm.select %5, %2, %3 : i1, !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_a1110111_c_3   : fold_memchr_a1110111_c_3_before  ⊑  fold_memchr_a1110111_c_3_combined := by
  unfold fold_memchr_a1110111_c_3_before fold_memchr_a1110111_c_3_combined
  simp_alive_peephole
  sorry
def call_memchr_a1110111_c_4_combined := [llvmfunc|
  llvm.func @call_memchr_a1110111_c_4(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %4 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i8>
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.mlir.constant(1 : i8) : i8
    %8 = llvm.trunc %arg0 : i32 to i8
    %9 = llvm.icmp "eq" %8, %0 : i8
    %10 = llvm.select %9, %5, %6 : i1, !llvm.ptr
    %11 = llvm.icmp "eq" %8, %7 : i8
    %12 = llvm.select %11, %4, %10 : i1, !llvm.ptr
    llvm.return %12 : !llvm.ptr
  }]

theorem inst_combine_call_memchr_a1110111_c_4   : call_memchr_a1110111_c_4_before  ⊑  call_memchr_a1110111_c_4_combined := by
  unfold call_memchr_a1110111_c_4_before call_memchr_a1110111_c_4_combined
  simp_alive_peephole
  sorry
def call_memchr_a1110111_c_7_combined := [llvmfunc|
  llvm.func @call_memchr_a1110111_c_7(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_call_memchr_a1110111_c_7   : call_memchr_a1110111_c_7_before  ⊑  call_memchr_a1110111_c_7_combined := by
  unfold call_memchr_a1110111_c_7_before call_memchr_a1110111_c_7_combined
  simp_alive_peephole
  sorry
def call_memchr_a1110111_c_n_combined := [llvmfunc|
  llvm.func @call_memchr_a1110111_c_n(%arg0: i32, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\01\01\01") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @a1110111 : !llvm.ptr
    %2 = llvm.call @memchr(%1, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_call_memchr_a1110111_c_n   : call_memchr_a1110111_c_n_before  ⊑  call_memchr_a1110111_c_n_combined := by
  unfold call_memchr_a1110111_c_n_before call_memchr_a1110111_c_n_combined
  simp_alive_peephole
  sorry
