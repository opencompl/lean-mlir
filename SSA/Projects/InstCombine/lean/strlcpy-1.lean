import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strlcpy-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strlcpy_s0_before := [llvmfunc|
  llvm.func @fold_strlcpy_s0(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @s4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(-1 : i64) : i64
    %7 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %8 = llvm.call @strlcpy(%arg0, %7, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %8) : (!llvm.ptr, i64) -> ()
    %9 = llvm.call @strlcpy(%arg0, %7, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, i64) -> ()
    %10 = llvm.call @strlcpy(%arg0, %7, %6) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, i64) -> ()
    llvm.return
  }]

def fold_strlcpy_s1_before := [llvmfunc|
  llvm.func @fold_strlcpy_s1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @s4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(3 : i64) : i64
    %8 = llvm.mlir.constant(-1 : i64) : i64
    %9 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %10 = llvm.call @strlcpy(%arg0, %9, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, i64) -> ()
    %11 = llvm.call @strlcpy(%arg0, %9, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, i64) -> ()
    %12 = llvm.call @strlcpy(%arg0, %9, %6) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, i64) -> ()
    %13 = llvm.call @strlcpy(%arg0, %9, %7) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, i64) -> ()
    %14 = llvm.call @strlcpy(%arg0, %9, %8) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %14) : (!llvm.ptr, i64) -> ()
    llvm.return
  }]

def fold_strlcpy_s5_before := [llvmfunc|
  llvm.func @fold_strlcpy_s5(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @s4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(5 : i64) : i64
    %8 = llvm.mlir.constant(-1 : i64) : i64
    %9 = llvm.call @strlcpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, i64) -> ()
    %10 = llvm.call @strlcpy(%arg0, %1, %3) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, i64) -> ()
    %11 = llvm.call @strlcpy(%arg0, %1, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, i64) -> ()
    %12 = llvm.call @strlcpy(%arg0, %1, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, i64) -> ()
    %13 = llvm.call @strlcpy(%arg0, %1, %6) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, i64) -> ()
    %14 = llvm.call @strlcpy(%arg0, %1, %7) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %14) : (!llvm.ptr, i64) -> ()
    %15 = llvm.call @strlcpy(%arg0, %1, %7) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %15) : (!llvm.ptr, i64) -> ()
    %16 = llvm.call @strlcpy(%arg0, %1, %8) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %16) : (!llvm.ptr, i64) -> ()
    llvm.return
  }]

def fold_strlcpy_s_0_before := [llvmfunc|
  llvm.func @fold_strlcpy_s_0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.call @strlcpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, i64) -> ()
    %4 = llvm.call @strlcpy(%arg0, %arg1, %1) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %4) : (!llvm.ptr, i64) -> ()
    %5 = llvm.call @strlcpy(%2, %arg1, %1) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %5) : (!llvm.ptr, i64) -> ()
    llvm.return
  }]

def call_strlcpy_s0_n_before := [llvmfunc|
  llvm.func @call_strlcpy_s0_n(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @s4 : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(4 : i32) : i32
    %6 = llvm.mlir.constant(3 : i32) : i32
    %7 = llvm.call @strlcpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %7) : (!llvm.ptr, i64) -> ()
    %8 = llvm.call @strlcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %8) : (!llvm.ptr, i64) -> ()
    %9 = llvm.or %arg2, %1  : i64
    %10 = llvm.call @strlcpy(%arg0, %arg1, %9) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, i64) -> ()
    %11 = llvm.getelementptr %3[%4, %5] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %12 = llvm.call @strlcpy(%arg0, %11, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, i64) -> ()
    %13 = llvm.getelementptr %3[%4, %6] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %14 = llvm.call @strlcpy(%arg0, %13, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %14) : (!llvm.ptr, i64) -> ()
    %15 = llvm.call @strlcpy(%arg0, %3, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %15) : (!llvm.ptr, i64) -> ()
    llvm.return
  }]

def fold_strlcpy_a5_before := [llvmfunc|
  llvm.func @fold_strlcpy_a5(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(5 : i64) : i64
    %6 = llvm.mlir.constant(6 : i64) : i64
    %7 = llvm.mlir.constant(9 : i64) : i64
    %8 = llvm.call @strlcpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %8) : (!llvm.ptr, i64) -> ()
    %9 = llvm.call @strlcpy(%arg0, %1, %3) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, i64) -> ()
    %10 = llvm.call @strlcpy(%arg0, %1, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, i64) -> ()
    %11 = llvm.call @strlcpy(%arg0, %1, %5) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, i64) -> ()
    %12 = llvm.call @strlcpy(%arg0, %1, %6) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, i64) -> ()
    %13 = llvm.call @strlcpy(%arg0, %1, %7) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, i64) -> ()
    llvm.return
  }]

def fold_strlcpy_s0_combined := [llvmfunc|
  llvm.func @fold_strlcpy_s0(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i8) : i8
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    llvm.store %1, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    llvm.store %1, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    llvm.return
  }]

theorem inst_combine_fold_strlcpy_s0   : fold_strlcpy_s0_before  ⊑  fold_strlcpy_s0_combined := by
  unfold fold_strlcpy_s0_before fold_strlcpy_s0_combined
  simp_alive_peephole
  sorry
def fold_strlcpy_s1_combined := [llvmfunc|
  llvm.func @fold_strlcpy_s1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(13312 : i16) : i16
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    llvm.store %1, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    llvm.store %2, %arg0 {alignment = 1 : i64} : i16, !llvm.ptr
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    llvm.store %2, %arg0 {alignment = 1 : i64} : i16, !llvm.ptr
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    llvm.store %2, %arg0 {alignment = 1 : i64} : i16, !llvm.ptr
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    llvm.return
  }]

theorem inst_combine_fold_strlcpy_s1   : fold_strlcpy_s1_before  ⊑  fold_strlcpy_s1_combined := by
  unfold fold_strlcpy_s1_before fold_strlcpy_s1_combined
  simp_alive_peephole
  sorry
def fold_strlcpy_s5_combined := [llvmfunc|
  llvm.func @fold_strlcpy_s5(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(49 : i8) : i8
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(12594 : i16) : i16
    %5 = llvm.mlir.constant(2 : i64) : i64
    %6 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %7 = llvm.mlir.addressof @s4 : !llvm.ptr
    %8 = llvm.mlir.constant(3 : i64) : i64
    %9 = llvm.mlir.constant(5 : i64) : i64
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    llvm.store %1, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    llvm.store %2, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    %10 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.store %1, %10 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    llvm.store %4, %arg0 {alignment = 1 : i64} : i16, !llvm.ptr
    %11 = llvm.getelementptr inbounds %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.store %1, %11 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    "llvm.intr.memcpy"(%arg0, %7, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %12 = llvm.getelementptr inbounds %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.store %1, %12 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    "llvm.intr.memcpy"(%arg0, %7, %9) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    "llvm.intr.memcpy"(%arg0, %7, %9) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    "llvm.intr.memcpy"(%arg0, %7, %9) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    llvm.return
  }]

theorem inst_combine_fold_strlcpy_s5   : fold_strlcpy_s5_before  ⊑  fold_strlcpy_s5_combined := by
  unfold fold_strlcpy_s5_before fold_strlcpy_s5_combined
  simp_alive_peephole
  sorry
def fold_strlcpy_s_0_combined := [llvmfunc|
  llvm.func @fold_strlcpy_s_0(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    %1 = llvm.call @strlen(%arg1) : (!llvm.ptr) -> i64
    llvm.call @sink(%arg0, %1) : (!llvm.ptr, i64) -> ()
    %2 = llvm.call @strlen(%arg1) : (!llvm.ptr) -> i64
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, i64) -> ()
    %3 = llvm.call @strlen(%arg1) : (!llvm.ptr) -> i64
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, i64) -> ()
    llvm.return
  }]

theorem inst_combine_fold_strlcpy_s_0   : fold_strlcpy_s_0_before  ⊑  fold_strlcpy_s_0_combined := by
  unfold fold_strlcpy_s_0_before fold_strlcpy_s_0_combined
  simp_alive_peephole
  sorry
def call_strlcpy_s0_n_combined := [llvmfunc|
  llvm.func @call_strlcpy_s0_n(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %5 = llvm.mlir.addressof @s4 : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%3, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %7 = llvm.mlir.constant(3 : i64) : i64
    %8 = llvm.getelementptr inbounds %5[%3, %7] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %9 = llvm.call @strlcpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, i64) -> ()
    %10 = llvm.call @strlcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, i64) -> ()
    %11 = llvm.or %arg2, %1  : i64
    %12 = llvm.call @strlcpy(%arg0, %arg1, %11) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, i64) -> ()
    %13 = llvm.call @strlcpy(%arg0, %6, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, i64) -> ()
    %14 = llvm.call @strlcpy(%arg0, %8, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %14) : (!llvm.ptr, i64) -> ()
    %15 = llvm.call @strlcpy(%arg0, %5, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> i64
    llvm.call @sink(%arg0, %15) : (!llvm.ptr, i64) -> ()
    llvm.return
  }]

theorem inst_combine_call_strlcpy_s0_n   : call_strlcpy_s0_n_before  ⊑  call_strlcpy_s0_n_combined := by
  unfold call_strlcpy_s0_n_before call_strlcpy_s0_n_combined
  simp_alive_peephole
  sorry
def fold_strlcpy_a5_combined := [llvmfunc|
  llvm.func @fold_strlcpy_a5(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(49 : i8) : i8
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(825373492 : i32) : i32
    %5 = llvm.mlir.constant(4 : i64) : i64
    %6 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %7 = llvm.mlir.addressof @a5 : !llvm.ptr
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    llvm.store %1, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    llvm.store %2, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    %8 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.store %1, %8 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    llvm.store %4, %arg0 {alignment = 1 : i64} : i32, !llvm.ptr
    %9 = llvm.getelementptr inbounds %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.store %1, %9 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    "llvm.intr.memcpy"(%arg0, %7, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %10 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.store %1, %10 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    "llvm.intr.memcpy"(%arg0, %7, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %11 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.store %1, %11 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.call @sink(%arg0, %0) : (!llvm.ptr, i64) -> ()
    llvm.return
  }]

theorem inst_combine_fold_strlcpy_a5   : fold_strlcpy_a5_before  ⊑  fold_strlcpy_a5_combined := by
  unfold fold_strlcpy_a5_before fold_strlcpy_a5_combined
  simp_alive_peephole
  sorry
