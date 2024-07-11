import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  stpncpy-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_stpncpy_overlap_before := [llvmfunc|
  llvm.func @fold_stpncpy_overlap(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @stpncpy(%arg0, %arg0, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @stpncpy(%arg0, %arg0, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def call_stpncpy_overlap_before := [llvmfunc|
  llvm.func @call_stpncpy_overlap(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.call @stpncpy(%arg0, %arg0, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @stpncpy(%arg0, %arg0, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    %4 = llvm.call @stpncpy(%arg0, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %4) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def fold_stpncpy_s0_before := [llvmfunc|
  llvm.func @fold_stpncpy_s0(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @s4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(9 : i64) : i64
    %8 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %9 = llvm.call @stpncpy(%arg0, %8, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, !llvm.ptr) -> ()
    %10 = llvm.call @stpncpy(%arg0, %8, %5) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, !llvm.ptr) -> ()
    %11 = llvm.call @stpncpy(%arg0, %8, %6) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, !llvm.ptr) -> ()
    %12 = llvm.call @stpncpy(%arg0, %8, %7) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, !llvm.ptr) -> ()
    %13 = llvm.call @stpncpy(%arg0, %8, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def fold_stpncpy_s1_before := [llvmfunc|
  llvm.func @fold_stpncpy_s1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @s4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(3 : i64) : i64
    %8 = llvm.mlir.constant(9 : i64) : i64
    %9 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %10 = llvm.call @stpncpy(%arg0, %9, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, !llvm.ptr) -> ()
    %11 = llvm.call @stpncpy(%arg0, %9, %5) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, !llvm.ptr) -> ()
    %12 = llvm.call @stpncpy(%arg0, %9, %6) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, !llvm.ptr) -> ()
    %13 = llvm.call @stpncpy(%arg0, %9, %7) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, !llvm.ptr) -> ()
    %14 = llvm.call @stpncpy(%arg0, %9, %8) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %14) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def fold_stpncpy_s4_before := [llvmfunc|
  llvm.func @fold_stpncpy_s4(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @s4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(9 : i64) : i64
    %8 = llvm.call @stpncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %8) : (!llvm.ptr, !llvm.ptr) -> ()
    %9 = llvm.call @stpncpy(%arg0, %1, %3) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, !llvm.ptr) -> ()
    %10 = llvm.call @stpncpy(%arg0, %1, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, !llvm.ptr) -> ()
    %11 = llvm.call @stpncpy(%arg0, %1, %5) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, !llvm.ptr) -> ()
    %12 = llvm.call @stpncpy(%arg0, %1, %6) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, !llvm.ptr) -> ()
    %13 = llvm.call @stpncpy(%arg0, %1, %7) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def call_stpncpy_xx_n_before := [llvmfunc|
  llvm.func @call_stpncpy_xx_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("1234") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @a4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %5 = llvm.mlir.addressof @s4 : !llvm.ptr
    %6 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<4 x i8>
    %7 = llvm.call @stpncpy(%arg0, %6, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %7) : (!llvm.ptr, !llvm.ptr) -> ()
    %8 = llvm.call @stpncpy(%arg0, %1, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %8) : (!llvm.ptr, !llvm.ptr) -> ()
    %9 = llvm.getelementptr %5[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %10 = llvm.call @stpncpy(%arg0, %9, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, !llvm.ptr) -> ()
    %11 = llvm.call @stpncpy(%arg0, %5, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def fold_stpncpy_a4_before := [llvmfunc|
  llvm.func @fold_stpncpy_a4(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("1234") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @a4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(5 : i64) : i64
    %8 = llvm.mlir.constant(9 : i64) : i64
    %9 = llvm.call @stpncpy(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, !llvm.ptr) -> ()
    %10 = llvm.call @stpncpy(%arg0, %1, %3) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, !llvm.ptr) -> ()
    %11 = llvm.call @stpncpy(%arg0, %1, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, !llvm.ptr) -> ()
    %12 = llvm.call @stpncpy(%arg0, %1, %5) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, !llvm.ptr) -> ()
    %13 = llvm.call @stpncpy(%arg0, %1, %6) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, !llvm.ptr) -> ()
    %14 = llvm.call @stpncpy(%arg0, %1, %7) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %14) : (!llvm.ptr, !llvm.ptr) -> ()
    %15 = llvm.call @stpncpy(%arg0, %1, %8) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %15) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def fold_stpncpy_s_before := [llvmfunc|
  llvm.func @fold_stpncpy_s(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @stpncpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @stpncpy(%arg0, %arg1, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def call_stpncpy_s_before := [llvmfunc|
  llvm.func @call_stpncpy_s(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.call @stpncpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> ()
    %2 = llvm.call @stpncpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def fold_stpncpy_overlap_combined := [llvmfunc|
  llvm.func @fold_stpncpy_overlap(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.call @sink(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> ()
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %4) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_fold_stpncpy_overlap   : fold_stpncpy_overlap_before  ⊑  fold_stpncpy_overlap_combined := by
  unfold fold_stpncpy_overlap_before fold_stpncpy_overlap_combined
  simp_alive_peephole
  sorry
def call_stpncpy_overlap_combined := [llvmfunc|
  llvm.func @call_stpncpy_overlap(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.call @stpncpy(%arg0, %arg0, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @stpncpy(%arg0, %arg0, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    %4 = llvm.call @stpncpy(%arg0, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %4) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_call_stpncpy_overlap   : call_stpncpy_overlap_before  ⊑  call_stpncpy_overlap_combined := by
  unfold call_stpncpy_overlap_before call_stpncpy_overlap_combined
  simp_alive_peephole
  sorry
def fold_stpncpy_s0_combined := [llvmfunc|
  llvm.func @fold_stpncpy_s0(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(9 : i64) : i64
    llvm.call @sink(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.call @sink(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.store %1, %arg0 {alignment = 1 : i64} : i16, !llvm.ptr
    llvm.call @sink(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.intr.memset"(%arg0, %0, %2) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    llvm.call @sink(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.intr.memset"(%arg0, %0, %arg1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    llvm.call @sink(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_fold_stpncpy_s0   : fold_stpncpy_s0_before  ⊑  fold_stpncpy_s0_combined := by
  unfold fold_stpncpy_s0_before fold_stpncpy_s0_combined
  simp_alive_peephole
  sorry
def fold_stpncpy_s1_combined := [llvmfunc|
  llvm.func @fold_stpncpy_s1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(52 : i8) : i8
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(13312 : i16) : i16
    %3 = llvm.mlir.constant("4\00\00\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @str.6 : !llvm.ptr
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant("4\00\00\00\00\00\00\00\00\00") : !llvm.array<10 x i8>
    %7 = llvm.mlir.addressof @str.7 : !llvm.ptr
    %8 = llvm.mlir.constant(9 : i64) : i64
    llvm.call @sink(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    %9 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.store %2, %arg0 {alignment = 1 : i64} : i16, !llvm.ptr
    %10 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.intr.memcpy"(%arg0, %4, %5) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %11 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.intr.memcpy"(%arg0, %7, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %12 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_fold_stpncpy_s1   : fold_stpncpy_s1_before  ⊑  fold_stpncpy_s1_combined := by
  unfold fold_stpncpy_s1_before fold_stpncpy_s1_combined
  simp_alive_peephole
  sorry
def fold_stpncpy_s4_combined := [llvmfunc|
  llvm.func @fold_stpncpy_s4(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(49 : i8) : i8
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(12594 : i16) : i16
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %5 = llvm.mlir.addressof @s4 : !llvm.ptr
    %6 = llvm.mlir.constant(3 : i64) : i64
    %7 = llvm.mlir.constant(825373492 : i32) : i32
    %8 = llvm.mlir.constant(4 : i64) : i64
    %9 = llvm.mlir.constant("1234\00\00\00\00\00\00") : !llvm.array<10 x i8>
    %10 = llvm.mlir.addressof @str.8 : !llvm.ptr
    %11 = llvm.mlir.constant(9 : i64) : i64
    llvm.call @sink(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    %12 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.store %2, %arg0 {alignment = 1 : i64} : i16, !llvm.ptr
    %13 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.intr.memcpy"(%arg0, %5, %6) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %14 = llvm.getelementptr inbounds %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %14) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.store %7, %arg0 {alignment = 1 : i64} : i32, !llvm.ptr
    %15 = llvm.getelementptr inbounds %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %15) : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.intr.memcpy"(%arg0, %10, %11) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %16 = llvm.getelementptr inbounds %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %16) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_fold_stpncpy_s4   : fold_stpncpy_s4_before  ⊑  fold_stpncpy_s4_combined := by
  unfold fold_stpncpy_s4_before fold_stpncpy_s4_combined
  simp_alive_peephole
  sorry
def call_stpncpy_xx_n_combined := [llvmfunc|
  llvm.func @call_stpncpy_xx_n(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("1234") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @a4 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %5 = llvm.mlir.constant("1234\00") : !llvm.array<5 x i8>
    %6 = llvm.mlir.addressof @s4 : !llvm.ptr
    %7 = llvm.getelementptr inbounds %6[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %8 = llvm.call @stpncpy(%arg0, %4, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %8) : (!llvm.ptr, !llvm.ptr) -> ()
    %9 = llvm.call @stpncpy(%arg0, %3, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, !llvm.ptr) -> ()
    %10 = llvm.call @stpncpy(%arg0, %7, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, !llvm.ptr) -> ()
    %11 = llvm.call @stpncpy(%arg0, %6, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_call_stpncpy_xx_n   : call_stpncpy_xx_n_before  ⊑  call_stpncpy_xx_n_combined := by
  unfold call_stpncpy_xx_n_before call_stpncpy_xx_n_combined
  simp_alive_peephole
  sorry
def fold_stpncpy_a4_combined := [llvmfunc|
  llvm.func @fold_stpncpy_a4(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(49 : i8) : i8
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(12594 : i16) : i16
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant("1234") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @a4 : !llvm.ptr
    %6 = llvm.mlir.constant(3 : i64) : i64
    %7 = llvm.mlir.constant(825373492 : i32) : i32
    %8 = llvm.mlir.constant(4 : i64) : i64
    %9 = llvm.mlir.constant(5 : i64) : i64
    %10 = llvm.mlir.constant("1234\00\00\00\00\00\00") : !llvm.array<10 x i8>
    %11 = llvm.mlir.addressof @str.9 : !llvm.ptr
    %12 = llvm.mlir.constant(9 : i64) : i64
    llvm.call @sink(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    %13 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.store %2, %arg0 {alignment = 1 : i64} : i16, !llvm.ptr
    %14 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %14) : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.intr.memcpy"(%arg0, %5, %6) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %15 = llvm.getelementptr inbounds %arg0[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %15) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.store %7, %arg0 {alignment = 1 : i64} : i32, !llvm.ptr
    %16 = llvm.getelementptr inbounds %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %16) : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.intr.memcpy"(%arg0, %5, %9) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %17 = llvm.getelementptr inbounds %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %17) : (!llvm.ptr, !llvm.ptr) -> ()
    "llvm.intr.memcpy"(%arg0, %11, %12) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %18 = llvm.getelementptr inbounds %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %18) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_fold_stpncpy_a4   : fold_stpncpy_a4_before  ⊑  fold_stpncpy_a4_combined := by
  unfold fold_stpncpy_a4_before fold_stpncpy_a4_combined
  simp_alive_peephole
  sorry
def fold_stpncpy_s_combined := [llvmfunc|
  llvm.func @fold_stpncpy_s(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.call @sink(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> ()
    %1 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.store %1, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.zext %2 : i1 to i64
    %4 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @sink(%arg0, %4) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_fold_stpncpy_s   : fold_stpncpy_s_before  ⊑  fold_stpncpy_s_combined := by
  unfold fold_stpncpy_s_before fold_stpncpy_s_combined
  simp_alive_peephole
  sorry
def call_stpncpy_s_combined := [llvmfunc|
  llvm.func @call_stpncpy_s(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.call @stpncpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> ()
    %2 = llvm.call @stpncpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_call_stpncpy_s   : call_stpncpy_s_before  ⊑  call_stpncpy_s_combined := by
  unfold call_stpncpy_s_before call_stpncpy_s_combined
  simp_alive_peephole
  sorry
