import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strchr-3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strchr_s1_C_before := [llvmfunc|
  llvm.func @fold_strchr_s1_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @s1 : !llvm.ptr
    %2 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def fold_strchr_s11_C_before := [llvmfunc|
  llvm.func @fold_strchr_s11_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @s11 : !llvm.ptr
    %2 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def fold_strchr_s111_C_before := [llvmfunc|
  llvm.func @fold_strchr_s111_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s111 : !llvm.ptr
    %2 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def fold_strchr_s000_C_before := [llvmfunc|
  llvm.func @fold_strchr_s000_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.addressof @s000 : !llvm.ptr
    %3 = llvm.call @strchr(%2, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def xform_strchr_s21111_C_before := [llvmfunc|
  llvm.func @xform_strchr_s21111_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\02\01\01\01\01\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s21111 : !llvm.ptr
    %2 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def fold_strchr_s21111p1_C_before := [llvmfunc|
  llvm.func @fold_strchr_s21111p1_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\02\01\01\01\01\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s21111 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %5 = llvm.call @strchr(%4, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def fold_strchr_s11102_C_before := [llvmfunc|
  llvm.func @fold_strchr_s11102_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\01\01\00\02\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s11102 : !llvm.ptr
    %2 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def fold_strchr_s1_C_combined := [llvmfunc|
  llvm.func @fold_strchr_s1_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("\01\00") : !llvm.array<2 x i8>
    %4 = llvm.mlir.addressof @s1 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x i8>
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.mlir.constant(1 : i8) : i8
    %8 = llvm.trunc %arg0 : i32 to i8
    %9 = llvm.icmp "eq" %8, %0 : i8
    %10 = llvm.select %9, %5, %6 : i1, !llvm.ptr
    %11 = llvm.icmp "eq" %8, %7 : i8
    %12 = llvm.select %11, %4, %10 : i1, !llvm.ptr
    llvm.return %12 : !llvm.ptr
  }]

theorem inst_combine_fold_strchr_s1_C   : fold_strchr_s1_C_before  ⊑  fold_strchr_s1_C_combined := by
  unfold fold_strchr_s1_C_before fold_strchr_s1_C_combined
  simp_alive_peephole
  sorry
def fold_strchr_s11_C_combined := [llvmfunc|
  llvm.func @fold_strchr_s11_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("\01\01\00") : !llvm.array<3 x i8>
    %4 = llvm.mlir.addressof @s11 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<3 x i8>
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.mlir.constant(1 : i8) : i8
    %8 = llvm.trunc %arg0 : i32 to i8
    %9 = llvm.icmp "eq" %8, %0 : i8
    %10 = llvm.select %9, %5, %6 : i1, !llvm.ptr
    %11 = llvm.icmp "eq" %8, %7 : i8
    %12 = llvm.select %11, %4, %10 : i1, !llvm.ptr
    llvm.return %12 : !llvm.ptr
  }]

theorem inst_combine_fold_strchr_s11_C   : fold_strchr_s11_C_before  ⊑  fold_strchr_s11_C_combined := by
  unfold fold_strchr_s11_C_before fold_strchr_s11_C_combined
  simp_alive_peephole
  sorry
def fold_strchr_s111_C_combined := [llvmfunc|
  llvm.func @fold_strchr_s111_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("\01\01\01\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @s111 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.mlir.constant(1 : i8) : i8
    %8 = llvm.trunc %arg0 : i32 to i8
    %9 = llvm.icmp "eq" %8, %0 : i8
    %10 = llvm.select %9, %5, %6 : i1, !llvm.ptr
    %11 = llvm.icmp "eq" %8, %7 : i8
    %12 = llvm.select %11, %4, %10 : i1, !llvm.ptr
    llvm.return %12 : !llvm.ptr
  }]

theorem inst_combine_fold_strchr_s111_C   : fold_strchr_s111_C_before  ⊑  fold_strchr_s111_C_combined := by
  unfold fold_strchr_s111_C_before fold_strchr_s111_C_combined
  simp_alive_peephole
  sorry
def fold_strchr_s000_C_combined := [llvmfunc|
  llvm.func @fold_strchr_s000_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<4xi8>) : !llvm.array<4 x i8>
    %2 = llvm.mlir.addressof @s000 : !llvm.ptr
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.trunc %arg0 : i32 to i8
    %5 = llvm.icmp "eq" %4, %0 : i8
    %6 = llvm.select %5, %2, %3 : i1, !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

theorem inst_combine_fold_strchr_s000_C   : fold_strchr_s000_C_before  ⊑  fold_strchr_s000_C_combined := by
  unfold fold_strchr_s000_C_before fold_strchr_s000_C_combined
  simp_alive_peephole
  sorry
def xform_strchr_s21111_C_combined := [llvmfunc|
  llvm.func @xform_strchr_s21111_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\02\01\01\01\01\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s21111 : !llvm.ptr
    %2 = llvm.mlir.constant(6 : i64) : i64
    %3 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_xform_strchr_s21111_C   : xform_strchr_s21111_C_before  ⊑  xform_strchr_s21111_C_combined := by
  unfold xform_strchr_s21111_C_before xform_strchr_s21111_C_combined
  simp_alive_peephole
  sorry
def fold_strchr_s21111p1_C_combined := [llvmfunc|
  llvm.func @fold_strchr_s21111p1_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("\02\01\01\01\01\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @s21111 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.mlir.constant(1 : i8) : i8
    %8 = llvm.mlir.constant(1 : i64) : i64
    %9 = llvm.getelementptr inbounds %4[%2, %8] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %10 = llvm.trunc %arg0 : i32 to i8
    %11 = llvm.icmp "eq" %10, %0 : i8
    %12 = llvm.select %11, %5, %6 : i1, !llvm.ptr
    %13 = llvm.icmp "eq" %10, %7 : i8
    %14 = llvm.select %13, %9, %12 : i1, !llvm.ptr
    llvm.return %14 : !llvm.ptr
  }]

theorem inst_combine_fold_strchr_s21111p1_C   : fold_strchr_s21111p1_C_before  ⊑  fold_strchr_s21111p1_C_combined := by
  unfold fold_strchr_s21111p1_C_before fold_strchr_s21111p1_C_combined
  simp_alive_peephole
  sorry
def fold_strchr_s11102_C_combined := [llvmfunc|
  llvm.func @fold_strchr_s11102_C(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("\01\01\01\00\02\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @s11102 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.mlir.constant(1 : i8) : i8
    %8 = llvm.trunc %arg0 : i32 to i8
    %9 = llvm.icmp "eq" %8, %0 : i8
    %10 = llvm.select %9, %5, %6 : i1, !llvm.ptr
    %11 = llvm.icmp "eq" %8, %7 : i8
    %12 = llvm.select %11, %4, %10 : i1, !llvm.ptr
    llvm.return %12 : !llvm.ptr
  }]

theorem inst_combine_fold_strchr_s11102_C   : fold_strchr_s11102_C_before  ⊑  fold_strchr_s11102_C_combined := by
  unfold fold_strchr_s11102_C_before fold_strchr_s11102_C_combined
  simp_alive_peephole
  sorry
