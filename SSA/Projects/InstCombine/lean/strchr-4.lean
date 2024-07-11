import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strchr-4
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strchr_s_c_eq_s_before := [llvmfunc|
  llvm.func @fold_strchr_s_c_eq_s(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.call @strchr(%arg0, %arg1) : (!llvm.ptr, i32) -> !llvm.ptr
    %1 = llvm.icmp "eq" %0, %arg0 : !llvm.ptr
    llvm.return %1 : i1
  }]

def fold_strchr_s_c_neq_s_before := [llvmfunc|
  llvm.func @fold_strchr_s_c_neq_s(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.call @strchr(%arg0, %arg1) : (!llvm.ptr, i32) -> !llvm.ptr
    %1 = llvm.icmp "ne" %0, %arg0 : !llvm.ptr
    llvm.return %1 : i1
  }]

def fold_strchr_s_nul_eqz_before := [llvmfunc|
  llvm.func @fold_strchr_s_nul_eqz(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.call @strchr(%arg0, %0) : (!llvm.ptr, i32) -> !llvm.ptr
    %3 = llvm.icmp "eq" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }]

def fold_strchr_s_nul_nez_before := [llvmfunc|
  llvm.func @fold_strchr_s_nul_nez(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.call @strchr(%arg0, %0) : (!llvm.ptr, i32) -> !llvm.ptr
    %3 = llvm.icmp "ne" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }]

def fold_strchr_a_c_eq_a_before := [llvmfunc|
  llvm.func @fold_strchr_a_c_eq_a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    %3 = llvm.icmp "eq" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }]

def fold_strchr_s_c_eq_s_combined := [llvmfunc|
  llvm.func @fold_strchr_s_c_eq_s(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_fold_strchr_s_c_eq_s   : fold_strchr_s_c_eq_s_before  ⊑  fold_strchr_s_c_eq_s_combined := by
  unfold fold_strchr_s_c_eq_s_before fold_strchr_s_c_eq_s_combined
  simp_alive_peephole
  sorry
    %1 = llvm.trunc %arg1 : i32 to i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_fold_strchr_s_c_eq_s   : fold_strchr_s_c_eq_s_before  ⊑  fold_strchr_s_c_eq_s_combined := by
  unfold fold_strchr_s_c_eq_s_before fold_strchr_s_c_eq_s_combined
  simp_alive_peephole
  sorry
def fold_strchr_s_c_neq_s_combined := [llvmfunc|
  llvm.func @fold_strchr_s_c_neq_s(%arg0: !llvm.ptr, %arg1: i32) -> i1 {
    %0 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_fold_strchr_s_c_neq_s   : fold_strchr_s_c_neq_s_before  ⊑  fold_strchr_s_c_neq_s_combined := by
  unfold fold_strchr_s_c_neq_s_before fold_strchr_s_c_neq_s_combined
  simp_alive_peephole
  sorry
    %1 = llvm.trunc %arg1 : i32 to i8
    %2 = llvm.icmp "ne" %0, %1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_fold_strchr_s_c_neq_s   : fold_strchr_s_c_neq_s_before  ⊑  fold_strchr_s_c_neq_s_combined := by
  unfold fold_strchr_s_c_neq_s_before fold_strchr_s_c_neq_s_combined
  simp_alive_peephole
  sorry
def fold_strchr_s_nul_eqz_combined := [llvmfunc|
  llvm.func @fold_strchr_s_nul_eqz(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fold_strchr_s_nul_eqz   : fold_strchr_s_nul_eqz_before  ⊑  fold_strchr_s_nul_eqz_combined := by
  unfold fold_strchr_s_nul_eqz_before fold_strchr_s_nul_eqz_combined
  simp_alive_peephole
  sorry
def fold_strchr_s_nul_nez_combined := [llvmfunc|
  llvm.func @fold_strchr_s_nul_nez(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fold_strchr_s_nul_nez   : fold_strchr_s_nul_nez_before  ⊑  fold_strchr_s_nul_nez_combined := by
  unfold fold_strchr_s_nul_nez_before fold_strchr_s_nul_nez_combined
  simp_alive_peephole
  sorry
def fold_strchr_a_c_eq_a_combined := [llvmfunc|
  llvm.func @fold_strchr_a_c_eq_a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(49 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_fold_strchr_a_c_eq_a   : fold_strchr_a_c_eq_a_before  ⊑  fold_strchr_a_c_eq_a_combined := by
  unfold fold_strchr_a_c_eq_a_before fold_strchr_a_c_eq_a_combined
  simp_alive_peephole
  sorry
