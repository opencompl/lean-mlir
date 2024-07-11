import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memchr-11
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_memchr_a_c_5_eq_a_before := [llvmfunc|
  llvm.func @fold_memchr_a_c_5_eq_a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %4 = llvm.icmp "eq" %3, %1 : !llvm.ptr
    llvm.return %4 : i1
  }]

def fold_memchr_a_c_n_eq_a_before := [llvmfunc|
  llvm.func @fold_memchr_a_c_n_eq_a(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.call @memchr(%1, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %3 = llvm.icmp "eq" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }]

def call_memchr_api_c_n_eq_a_before := [llvmfunc|
  llvm.func @call_memchr_api_c_n_eq_a(%arg0: i64, %arg1: i32, %arg2: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %4 = llvm.call @memchr(%3, %arg1, %arg2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "eq" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }]

def fold_memchr_s_c_15_eq_s_before := [llvmfunc|
  llvm.func @fold_memchr_s_c_15_eq_s(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.call @memchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %arg0 : !llvm.ptr
    llvm.return %2 : i1
  }]

def fold_memchr_s_c_17_neq_s_before := [llvmfunc|
  llvm.func @fold_memchr_s_c_17_neq_s(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(17 : i64) : i64
    %1 = llvm.call @memchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %2 = llvm.icmp "ne" %1, %arg0 : !llvm.ptr
    llvm.return %2 : i1
  }]

def fold_memchr_s_c_nz_eq_s_before := [llvmfunc|
  llvm.func @fold_memchr_s_c_nz_eq_s(%arg0: !llvm.ptr, %arg1: i32, %arg2: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.or %arg2, %0  : i64
    %2 = llvm.call @memchr(%arg0, %arg1, %1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %3 = llvm.icmp "eq" %2, %arg0 : !llvm.ptr
    llvm.return %3 : i1
  }]

def call_memchr_s_c_n_eq_s_before := [llvmfunc|
  llvm.func @call_memchr_s_c_n_eq_s(%arg0: !llvm.ptr, %arg1: i32, %arg2: i64) -> i1 {
    %0 = llvm.call @memchr(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %1 = llvm.icmp "eq" %0, %arg0 : !llvm.ptr
    llvm.return %1 : i1
  }]

def fold_memchr_a_c_5_eq_a_combined := [llvmfunc|
  llvm.func @fold_memchr_a_c_5_eq_a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(49 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_fold_memchr_a_c_5_eq_a   : fold_memchr_a_c_5_eq_a_before  ⊑  fold_memchr_a_c_5_eq_a_combined := by
  unfold fold_memchr_a_c_5_eq_a_before fold_memchr_a_c_5_eq_a_combined
  simp_alive_peephole
  sorry
def fold_memchr_a_c_n_eq_a_combined := [llvmfunc|
  llvm.func @fold_memchr_a_c_n_eq_a(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(49 : i8) : i8
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.icmp "eq" %3, %0 : i8
    %5 = llvm.icmp "ne" %arg1, %1 : i64
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_fold_memchr_a_c_n_eq_a   : fold_memchr_a_c_n_eq_a_before  ⊑  fold_memchr_a_c_n_eq_a_combined := by
  unfold fold_memchr_a_c_n_eq_a_before fold_memchr_a_c_n_eq_a_combined
  simp_alive_peephole
  sorry
def call_memchr_api_c_n_eq_a_combined := [llvmfunc|
  llvm.func @call_memchr_api_c_n_eq_a(%arg0: i64, %arg1: i32, %arg2: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %4 = llvm.call @memchr(%3, %arg1, %arg2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %5 = llvm.icmp "eq" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }]

theorem inst_combine_call_memchr_api_c_n_eq_a   : call_memchr_api_c_n_eq_a_before  ⊑  call_memchr_api_c_n_eq_a_combined := by
  unfold call_memchr_api_c_n_eq_a_before call_memchr_api_c_n_eq_a_combined
  simp_alive_peephole
  sorry
def fold_memchr_s_c_15_eq_s_combined := [llvmfunc|
  llvm.func @fold_memchr_s_c_15_eq_s(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_fold_memchr_s_c_15_eq_s   : fold_memchr_s_c_15_eq_s_before  ⊑  fold_memchr_s_c_15_eq_s_combined := by
  unfold fold_memchr_s_c_15_eq_s_before fold_memchr_s_c_15_eq_s_combined
  simp_alive_peephole
  sorry
    %1 = llvm.trunc %arg1 : i32 to i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_fold_memchr_s_c_15_eq_s   : fold_memchr_s_c_15_eq_s_before  ⊑  fold_memchr_s_c_15_eq_s_combined := by
  unfold fold_memchr_s_c_15_eq_s_before fold_memchr_s_c_15_eq_s_combined
  simp_alive_peephole
  sorry
def fold_memchr_s_c_17_neq_s_combined := [llvmfunc|
  llvm.func @fold_memchr_s_c_17_neq_s(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_fold_memchr_s_c_17_neq_s   : fold_memchr_s_c_17_neq_s_before  ⊑  fold_memchr_s_c_17_neq_s_combined := by
  unfold fold_memchr_s_c_17_neq_s_before fold_memchr_s_c_17_neq_s_combined
  simp_alive_peephole
  sorry
    %1 = llvm.trunc %arg1 : i32 to i8
    %2 = llvm.icmp "ne" %0, %1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_fold_memchr_s_c_17_neq_s   : fold_memchr_s_c_17_neq_s_before  ⊑  fold_memchr_s_c_17_neq_s_combined := by
  unfold fold_memchr_s_c_17_neq_s_before fold_memchr_s_c_17_neq_s_combined
  simp_alive_peephole
  sorry
def fold_memchr_s_c_nz_eq_s_combined := [llvmfunc|
  llvm.func @fold_memchr_s_c_nz_eq_s(%arg0: !llvm.ptr, %arg1: i32, %arg2: i64) -> i1 {
    %0 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_fold_memchr_s_c_nz_eq_s   : fold_memchr_s_c_nz_eq_s_before  ⊑  fold_memchr_s_c_nz_eq_s_combined := by
  unfold fold_memchr_s_c_nz_eq_s_before fold_memchr_s_c_nz_eq_s_combined
  simp_alive_peephole
  sorry
    %1 = llvm.trunc %arg1 : i32 to i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_fold_memchr_s_c_nz_eq_s   : fold_memchr_s_c_nz_eq_s_before  ⊑  fold_memchr_s_c_nz_eq_s_combined := by
  unfold fold_memchr_s_c_nz_eq_s_before fold_memchr_s_c_nz_eq_s_combined
  simp_alive_peephole
  sorry
def call_memchr_s_c_n_eq_s_combined := [llvmfunc|
  llvm.func @call_memchr_s_c_n_eq_s(%arg0: !llvm.ptr, %arg1: i32, %arg2: i64) -> i1 {
    %0 = llvm.call @memchr(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %1 = llvm.icmp "eq" %0, %arg0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_call_memchr_s_c_n_eq_s   : call_memchr_s_c_n_eq_s_before  ⊑  call_memchr_s_c_n_eq_s_combined := by
  unfold call_memchr_s_c_n_eq_s_before call_memchr_s_c_n_eq_s_combined
  simp_alive_peephole
  sorry
