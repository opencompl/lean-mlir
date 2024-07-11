import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memrchr-7
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def call_memrchr_ap5_c_1_eq_a_before := [llvmfunc|
  llvm.func @call_memrchr_ap5_c_1_eq_a(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %7 = llvm.getelementptr %1[%4, %2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %8 = llvm.call @memrchr(%6, %arg0, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %9 = llvm.icmp "eq" %8, %7 : !llvm.ptr
    llvm.return %9 : i1
  }]

def call_memrchr_ap5_c_5_eq_a_before := [llvmfunc|
  llvm.func @call_memrchr_ap5_c_5_eq_a(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(5 : i64) : i64
    %6 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %7 = llvm.getelementptr %1[%4, %2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %8 = llvm.call @memrchr(%6, %arg0, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %9 = llvm.icmp "eq" %8, %7 : !llvm.ptr
    llvm.return %9 : i1
  }]

def fold_memrchr_ap5_c_n_eq_a_before := [llvmfunc|
  llvm.func @fold_memrchr_ap5_c_n_eq_a(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %5 = llvm.call @memrchr(%4, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %6 = llvm.icmp "eq" %5, %1 : !llvm.ptr
    llvm.return %6 : i1
  }]

def fold_memrchr_ap5_c_n_eqz_before := [llvmfunc|
  llvm.func @fold_memrchr_ap5_c_n_eqz(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @memrchr(%5, %arg0, %arg1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %7 = llvm.icmp "eq" %6, %4 : !llvm.ptr
    llvm.return %7 : i1
  }]

def fold_memrchr_a_nul_n_eqz_before := [llvmfunc|
  llvm.func @fold_memrchr_a_nul_n_eqz(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @memrchr(%5, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %7 = llvm.icmp "eq" %6, %4 : !llvm.ptr
    llvm.return %7 : i1
  }]

def call_memrchr_ap5_c_1_eq_a_combined := [llvmfunc|
  llvm.func @call_memrchr_ap5_c_1_eq_a(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.poison : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_call_memrchr_ap5_c_1_eq_a   : call_memrchr_ap5_c_1_eq_a_before  ⊑  call_memrchr_ap5_c_1_eq_a_combined := by
  unfold call_memrchr_ap5_c_1_eq_a_before call_memrchr_ap5_c_1_eq_a_combined
  simp_alive_peephole
  sorry
def call_memrchr_ap5_c_5_eq_a_combined := [llvmfunc|
  llvm.func @call_memrchr_ap5_c_5_eq_a(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_call_memrchr_ap5_c_5_eq_a   : call_memrchr_ap5_c_5_eq_a_before  ⊑  call_memrchr_ap5_c_5_eq_a_combined := by
  unfold call_memrchr_ap5_c_5_eq_a_before call_memrchr_ap5_c_5_eq_a_combined
  simp_alive_peephole
  sorry
def fold_memrchr_ap5_c_n_eq_a_combined := [llvmfunc|
  llvm.func @fold_memrchr_ap5_c_n_eq_a(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fold_memrchr_ap5_c_n_eq_a   : fold_memrchr_ap5_c_n_eq_a_before  ⊑  fold_memrchr_ap5_c_n_eq_a_combined := by
  unfold fold_memrchr_ap5_c_n_eq_a_before fold_memrchr_ap5_c_n_eq_a_combined
  simp_alive_peephole
  sorry
def fold_memrchr_ap5_c_n_eqz_combined := [llvmfunc|
  llvm.func @fold_memrchr_ap5_c_n_eqz(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fold_memrchr_ap5_c_n_eqz   : fold_memrchr_ap5_c_n_eqz_before  ⊑  fold_memrchr_ap5_c_n_eqz_combined := by
  unfold fold_memrchr_ap5_c_n_eqz_before fold_memrchr_ap5_c_n_eqz_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a_nul_n_eqz_combined := [llvmfunc|
  llvm.func @fold_memrchr_a_nul_n_eqz(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fold_memrchr_a_nul_n_eqz   : fold_memrchr_a_nul_n_eqz_before  ⊑  fold_memrchr_a_nul_n_eqz_combined := by
  unfold fold_memrchr_a_nul_n_eqz_before fold_memrchr_a_nul_n_eqz_combined
  simp_alive_peephole
  sorry
