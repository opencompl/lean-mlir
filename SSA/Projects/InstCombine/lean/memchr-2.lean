import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memchr-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_memchr_a12345_6_n_before := [llvmfunc|
  llvm.func @fold_memchr_a12345_6_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.call @memchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def fold_memchr_a12345_4_2_before := [llvmfunc|
  llvm.func @fold_memchr_a12345_4_2() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memchr_a12345_4_3_before := [llvmfunc|
  llvm.func @fold_memchr_a12345_4_3() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memchr_a12345_3_3_before := [llvmfunc|
  llvm.func @fold_memchr_a12345_3_3() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memchr_a12345_3_9_before := [llvmfunc|
  llvm.func @fold_memchr_a12345_3_9() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(9 : i64) : i64
    %4 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memchr_a123f45_500_9_before := [llvmfunc|
  llvm.func @fold_memchr_a123f45_500_9() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\F4\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a123f45 : !llvm.ptr
    %2 = llvm.mlir.constant(500 : i32) : i32
    %3 = llvm.mlir.constant(9 : i64) : i64
    %4 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_a12345_3_n_before := [llvmfunc|
  llvm.func @fold_a12345_3_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call @memchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def fold_a12345_259_n_before := [llvmfunc|
  llvm.func @fold_a12345_259_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(259 : i32) : i32
    %3 = llvm.call @memchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def call_ax_1_n_before := [llvmfunc|
  llvm.func @call_ax_1_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call @memchr(%0, %1, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def fold_memchr_a12345_6_n_combined := [llvmfunc|
  llvm.func @fold_memchr_a12345_6_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_a12345_6_n   : fold_memchr_a12345_6_n_before  ⊑  fold_memchr_a12345_6_n_combined := by
  unfold fold_memchr_a12345_6_n_before fold_memchr_a12345_6_n_combined
  simp_alive_peephole
  sorry
def fold_memchr_a12345_4_2_combined := [llvmfunc|
  llvm.func @fold_memchr_a12345_4_2() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_a12345_4_2   : fold_memchr_a12345_4_2_before  ⊑  fold_memchr_a12345_4_2_combined := by
  unfold fold_memchr_a12345_4_2_before fold_memchr_a12345_4_2_combined
  simp_alive_peephole
  sorry
def fold_memchr_a12345_4_3_combined := [llvmfunc|
  llvm.func @fold_memchr_a12345_4_3() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_a12345_4_3   : fold_memchr_a12345_4_3_before  ⊑  fold_memchr_a12345_4_3_combined := by
  unfold fold_memchr_a12345_4_3_before fold_memchr_a12345_4_3_combined
  simp_alive_peephole
  sorry
def fold_memchr_a12345_3_3_combined := [llvmfunc|
  llvm.func @fold_memchr_a12345_3_3() -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_a12345_3_3   : fold_memchr_a12345_3_3_before  ⊑  fold_memchr_a12345_3_3_combined := by
  unfold fold_memchr_a12345_3_3_before fold_memchr_a12345_3_3_combined
  simp_alive_peephole
  sorry
def fold_memchr_a12345_3_9_combined := [llvmfunc|
  llvm.func @fold_memchr_a12345_3_9() -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_a12345_3_9   : fold_memchr_a12345_3_9_before  ⊑  fold_memchr_a12345_3_9_combined := by
  unfold fold_memchr_a12345_3_9_before fold_memchr_a12345_3_9_combined
  simp_alive_peephole
  sorry
def fold_memchr_a123f45_500_9_combined := [llvmfunc|
  llvm.func @fold_memchr_a123f45_500_9() -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("\01\02\03\F4\05") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @a123f45 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_fold_memchr_a123f45_500_9   : fold_memchr_a123f45_500_9_before  ⊑  fold_memchr_a123f45_500_9_combined := by
  unfold fold_memchr_a123f45_500_9_before fold_memchr_a123f45_500_9_combined
  simp_alive_peephole
  sorry
def fold_a12345_3_n_combined := [llvmfunc|
  llvm.func @fold_a12345_3_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %5 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%3, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %7 = llvm.icmp "ult" %arg0, %0 : i64
    %8 = llvm.select %7, %1, %6 : i1, !llvm.ptr
    llvm.return %8 : !llvm.ptr
  }]

theorem inst_combine_fold_a12345_3_n   : fold_a12345_3_n_before  ⊑  fold_a12345_3_n_combined := by
  unfold fold_a12345_3_n_before fold_a12345_3_n_combined
  simp_alive_peephole
  sorry
def fold_a12345_259_n_combined := [llvmfunc|
  llvm.func @fold_a12345_259_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %5 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%3, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %7 = llvm.icmp "ult" %arg0, %0 : i64
    %8 = llvm.select %7, %1, %6 : i1, !llvm.ptr
    llvm.return %8 : !llvm.ptr
  }]

theorem inst_combine_fold_a12345_259_n   : fold_a12345_259_n_before  ⊑  fold_a12345_259_n_combined := by
  unfold fold_a12345_259_n_before fold_a12345_259_n_combined
  simp_alive_peephole
  sorry
def call_ax_1_n_combined := [llvmfunc|
  llvm.func @call_ax_1_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call @memchr(%0, %1, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_call_ax_1_n   : call_ax_1_n_before  ⊑  call_ax_1_n_combined := by
  unfold call_ax_1_n_before call_ax_1_n_combined
  simp_alive_peephole
  sorry
