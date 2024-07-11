import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memrchr-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def call_memrchr_a12345_c_ui32max_p1_before := [llvmfunc|
  llvm.func @call_memrchr_a12345_c_ui32max_p1(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(4294967296 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def call_memrchr_ax1_c_ui32max_p2_before := [llvmfunc|
  llvm.func @call_memrchr_ax1_c_ui32max_p2(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax1 : !llvm.ptr
    %1 = llvm.mlir.constant(4294967297 : i64) : i64
    %2 = llvm.call @memrchr(%0, %arg0, %1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def call_memrchr_ax_c_ui32max_p2_before := [llvmfunc|
  llvm.func @call_memrchr_ax_c_ui32max_p2(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(4294967297 : i64) : i64
    %2 = llvm.call @memrchr(%0, %arg0, %1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def call_memrchr_a12345_c_6_before := [llvmfunc|
  llvm.func @call_memrchr_a12345_c_6(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(6 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def call_memrchr_a12345_c_szmax_before := [llvmfunc|
  llvm.func @call_memrchr_a12345_c_szmax(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def call_memrchr_a12345_c_ui32max_p1_combined := [llvmfunc|
  llvm.func @call_memrchr_a12345_c_ui32max_p1(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(4294967296 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_call_memrchr_a12345_c_ui32max_p1   : call_memrchr_a12345_c_ui32max_p1_before  ⊑  call_memrchr_a12345_c_ui32max_p1_combined := by
  unfold call_memrchr_a12345_c_ui32max_p1_before call_memrchr_a12345_c_ui32max_p1_combined
  simp_alive_peephole
  sorry
def call_memrchr_ax1_c_ui32max_p2_combined := [llvmfunc|
  llvm.func @call_memrchr_ax1_c_ui32max_p2(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax1 : !llvm.ptr
    %1 = llvm.mlir.constant(4294967297 : i64) : i64
    %2 = llvm.call @memrchr(%0, %arg0, %1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_call_memrchr_ax1_c_ui32max_p2   : call_memrchr_ax1_c_ui32max_p2_before  ⊑  call_memrchr_ax1_c_ui32max_p2_combined := by
  unfold call_memrchr_ax1_c_ui32max_p2_before call_memrchr_ax1_c_ui32max_p2_combined
  simp_alive_peephole
  sorry
def call_memrchr_ax_c_ui32max_p2_combined := [llvmfunc|
  llvm.func @call_memrchr_ax_c_ui32max_p2(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(4294967297 : i64) : i64
    %2 = llvm.call @memrchr(%0, %arg0, %1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_call_memrchr_ax_c_ui32max_p2   : call_memrchr_ax_c_ui32max_p2_before  ⊑  call_memrchr_ax_c_ui32max_p2_combined := by
  unfold call_memrchr_ax_c_ui32max_p2_before call_memrchr_ax_c_ui32max_p2_combined
  simp_alive_peephole
  sorry
def call_memrchr_a12345_c_6_combined := [llvmfunc|
  llvm.func @call_memrchr_a12345_c_6(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(6 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_call_memrchr_a12345_c_6   : call_memrchr_a12345_c_6_before  ⊑  call_memrchr_a12345_c_6_combined := by
  unfold call_memrchr_a12345_c_6_before call_memrchr_a12345_c_6_combined
  simp_alive_peephole
  sorry
def call_memrchr_a12345_c_szmax_combined := [llvmfunc|
  llvm.func @call_memrchr_a12345_c_szmax(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_call_memrchr_a12345_c_szmax   : call_memrchr_a12345_c_szmax_before  ⊑  call_memrchr_a12345_c_szmax_combined := by
  unfold call_memrchr_a12345_c_szmax_before call_memrchr_a12345_c_szmax_combined
  simp_alive_peephole
  sorry
