import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strncpy-4
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strncpy_overlap_before := [llvmfunc|
  llvm.func @fold_strncpy_overlap(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @strncpy(%arg0, %arg0, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @strncpy(%arg0, %arg0, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def call_strncpy_overlap_before := [llvmfunc|
  llvm.func @call_strncpy_overlap(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.call @strncpy(%arg0, %arg0, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @strncpy(%arg0, %arg0, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    %4 = llvm.call @strncpy(%arg0, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %4) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def fold_strncpy_s0_before := [llvmfunc|
  llvm.func @fold_strncpy_s0(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant("1234\00567\00") : !llvm.array<9 x i8>
    %1 = llvm.mlir.addressof @s4 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(9 : i64) : i64
    %8 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<9 x i8>
    %9 = llvm.call @strncpy(%arg0, %8, %4) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %9) : (!llvm.ptr, !llvm.ptr) -> ()
    %10 = llvm.call @strncpy(%arg0, %8, %5) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %10) : (!llvm.ptr, !llvm.ptr) -> ()
    %11 = llvm.call @strncpy(%arg0, %8, %6) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %11) : (!llvm.ptr, !llvm.ptr) -> ()
    %12 = llvm.call @strncpy(%arg0, %8, %7) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %12) : (!llvm.ptr, !llvm.ptr) -> ()
    %13 = llvm.call @strncpy(%arg0, %8, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %13) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def fold_strncpy_s_before := [llvmfunc|
  llvm.func @fold_strncpy_s(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @strncpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @strncpy(%arg0, %arg1, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def call_strncpy_s_before := [llvmfunc|
  llvm.func @call_strncpy_s(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(9 : i64) : i64
    %2 = llvm.call @strncpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @strncpy(%arg0, %arg1, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    %4 = llvm.call @strncpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %4) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def fold_strncpy_overlap_combined := [llvmfunc|
  llvm.func @fold_strncpy_overlap(%arg0: !llvm.ptr, %arg1: i64) {
    llvm.call @sink(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @sink(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_fold_strncpy_overlap   : fold_strncpy_overlap_before  ⊑  fold_strncpy_overlap_combined := by
  unfold fold_strncpy_overlap_before fold_strncpy_overlap_combined
  simp_alive_peephole
  sorry
def call_strncpy_overlap_combined := [llvmfunc|
  llvm.func @call_strncpy_overlap(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.call @strncpy(%arg0, %arg0, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @strncpy(%arg0, %arg0, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    %4 = llvm.call @strncpy(%arg0, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %4) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_call_strncpy_overlap   : call_strncpy_overlap_before  ⊑  call_strncpy_overlap_combined := by
  unfold call_strncpy_overlap_before call_strncpy_overlap_combined
  simp_alive_peephole
  sorry
def fold_strncpy_s0_combined := [llvmfunc|
  llvm.func @fold_strncpy_s0(%arg0: !llvm.ptr, %arg1: i64) {
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

theorem inst_combine_fold_strncpy_s0   : fold_strncpy_s0_before  ⊑  fold_strncpy_s0_combined := by
  unfold fold_strncpy_s0_before fold_strncpy_s0_combined
  simp_alive_peephole
  sorry
def fold_strncpy_s_combined := [llvmfunc|
  llvm.func @fold_strncpy_s(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    llvm.call @sink(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> ()
    %0 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.call @sink(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_fold_strncpy_s   : fold_strncpy_s_before  ⊑  fold_strncpy_s_combined := by
  unfold fold_strncpy_s_before fold_strncpy_s_combined
  simp_alive_peephole
  sorry
def call_strncpy_s_combined := [llvmfunc|
  llvm.func @call_strncpy_s(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(9 : i64) : i64
    %2 = llvm.call @strncpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.call @strncpy(%arg0, %arg1, %1) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %3) : (!llvm.ptr, !llvm.ptr) -> ()
    %4 = llvm.call @strncpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.call @sink(%arg0, %4) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_call_strncpy_s   : call_strncpy_s_before  ⊑  call_strncpy_s_combined := by
  unfold call_strncpy_s_before call_strncpy_s_combined
  simp_alive_peephole
  sorry
