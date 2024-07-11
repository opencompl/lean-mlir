import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memrchr-8
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def call_memrchr_a_c_9_eq_a_before := [llvmfunc|
  llvm.func @call_memrchr_a_c_9_eq_a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %4 = llvm.icmp "eq" %3, %1 : !llvm.ptr
    llvm.return %4 : i1
  }]

def call_memrchr_a_c_n_eq_a_before := [llvmfunc|
  llvm.func @call_memrchr_a_c_n_eq_a(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.call @memrchr(%1, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %3 = llvm.icmp "eq" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }]

def call_memrchr_s_c_17_eq_s_before := [llvmfunc|
  llvm.func @call_memrchr_s_c_17_eq_s(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(17 : i64) : i64
    %1 = llvm.call @memrchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %arg0 : !llvm.ptr
    llvm.return %2 : i1
  }]

def call_memrchr_s_c_9_neq_s_before := [llvmfunc|
  llvm.func @call_memrchr_s_c_9_neq_s(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.call @memrchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %2 = llvm.icmp "ne" %1, %arg0 : !llvm.ptr
    llvm.return %2 : i1
  }]

def fold_memrchr_s_c_n_eq_s_before := [llvmfunc|
  llvm.func @fold_memrchr_s_c_n_eq_s(%arg0: !llvm.ptr, %arg1: i32, %arg2: i64) -> i1 {
    %0 = llvm.call @memrchr(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %1 = llvm.icmp "eq" %0, %arg0 : !llvm.ptr
    llvm.return %1 : i1
  }]

def call_memrchr_a_c_9_eq_a_combined := [llvmfunc|
  llvm.func @call_memrchr_a_c_9_eq_a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.call @memrchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %4 = llvm.icmp "eq" %3, %1 : !llvm.ptr
    llvm.return %4 : i1
  }]

theorem inst_combine_call_memrchr_a_c_9_eq_a   : call_memrchr_a_c_9_eq_a_before  ⊑  call_memrchr_a_c_9_eq_a_combined := by
  unfold call_memrchr_a_c_9_eq_a_before call_memrchr_a_c_9_eq_a_combined
  simp_alive_peephole
  sorry
def call_memrchr_a_c_n_eq_a_combined := [llvmfunc|
  llvm.func @call_memrchr_a_c_n_eq_a(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.call @memrchr(%1, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %3 = llvm.icmp "eq" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }]

theorem inst_combine_call_memrchr_a_c_n_eq_a   : call_memrchr_a_c_n_eq_a_before  ⊑  call_memrchr_a_c_n_eq_a_combined := by
  unfold call_memrchr_a_c_n_eq_a_before call_memrchr_a_c_n_eq_a_combined
  simp_alive_peephole
  sorry
def call_memrchr_s_c_17_eq_s_combined := [llvmfunc|
  llvm.func @call_memrchr_s_c_17_eq_s(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(17 : i64) : i64
    %1 = llvm.call @memrchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %arg0 : !llvm.ptr
    llvm.return %2 : i1
  }]

theorem inst_combine_call_memrchr_s_c_17_eq_s   : call_memrchr_s_c_17_eq_s_before  ⊑  call_memrchr_s_c_17_eq_s_combined := by
  unfold call_memrchr_s_c_17_eq_s_before call_memrchr_s_c_17_eq_s_combined
  simp_alive_peephole
  sorry
def call_memrchr_s_c_9_neq_s_combined := [llvmfunc|
  llvm.func @call_memrchr_s_c_9_neq_s(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.call @memrchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %2 = llvm.icmp "ne" %1, %arg0 : !llvm.ptr
    llvm.return %2 : i1
  }]

theorem inst_combine_call_memrchr_s_c_9_neq_s   : call_memrchr_s_c_9_neq_s_before  ⊑  call_memrchr_s_c_9_neq_s_combined := by
  unfold call_memrchr_s_c_9_neq_s_before call_memrchr_s_c_9_neq_s_combined
  simp_alive_peephole
  sorry
def fold_memrchr_s_c_n_eq_s_combined := [llvmfunc|
  llvm.func @fold_memrchr_s_c_n_eq_s(%arg0: !llvm.ptr, %arg1: i32, %arg2: i64) -> i1 {
    %0 = llvm.call @memrchr(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %1 = llvm.icmp "eq" %0, %arg0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_fold_memrchr_s_c_n_eq_s   : fold_memrchr_s_c_n_eq_s_before  ⊑  fold_memrchr_s_c_n_eq_s_combined := by
  unfold fold_memrchr_s_c_n_eq_s_before fold_memrchr_s_c_n_eq_s_combined
  simp_alive_peephole
  sorry
