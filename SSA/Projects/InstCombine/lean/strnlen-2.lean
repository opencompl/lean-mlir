import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strnlen-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strnlen_s3_s5_0_before := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_0(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @s6 : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }]

def fold_strnlen_s3_s5_1_before := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_1(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @s6 : !llvm.ptr
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }]

def fold_strnlen_s3_s5_3_before := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_3(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @s6 : !llvm.ptr
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }]

def fold_strnlen_s3_s5_4_before := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_4(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @s6 : !llvm.ptr
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }]

def fold_strnlen_s3_s5_5_before := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_5(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @s6 : !llvm.ptr
    %4 = llvm.mlir.constant(5 : i64) : i64
    %5 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }]

def fold_strnlen_s5_6_before := [llvmfunc|
  llvm.func @fold_strnlen_s5_6(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @s6 : !llvm.ptr
    %4 = llvm.mlir.constant(6 : i64) : i64
    %5 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }]

def fold_strnlen_s3_s5_s7_4_before := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_s7_4(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @s5 : !llvm.ptr
    %4 = llvm.mlir.constant("1234567\00") : !llvm.array<8 x i8>
    %5 = llvm.mlir.addressof @s7 : !llvm.ptr
    %6 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %7 = llvm.mlir.addressof @s3 : !llvm.ptr
    %8 = llvm.mlir.constant(4 : i64) : i64
    %9 = llvm.icmp "eq" %arg0, %0 : i32
    %10 = llvm.icmp "eq" %arg0, %1 : i32
    %11 = llvm.select %10, %3, %5 : i1, !llvm.ptr
    %12 = llvm.select %9, %7, %11 : i1, !llvm.ptr
    %13 = llvm.call @strnlen(%12, %8) : (!llvm.ptr, i64) -> i64
    llvm.return %13 : i64
  }]

def fold_strnlen_s3_s5_s7_6_before := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_s7_6(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @s5 : !llvm.ptr
    %4 = llvm.mlir.constant("1234567\00") : !llvm.array<8 x i8>
    %5 = llvm.mlir.addressof @s7 : !llvm.ptr
    %6 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %7 = llvm.mlir.addressof @s3 : !llvm.ptr
    %8 = llvm.mlir.constant(6 : i64) : i64
    %9 = llvm.icmp "eq" %arg0, %0 : i32
    %10 = llvm.icmp "eq" %arg0, %1 : i32
    %11 = llvm.select %10, %3, %5 : i1, !llvm.ptr
    %12 = llvm.select %9, %7, %11 : i1, !llvm.ptr
    %13 = llvm.call @strnlen(%12, %8) : (!llvm.ptr, i64) -> i64
    llvm.return %13 : i64
  }]

def fold_strnlen_s3_s5_s7_8_before := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_s7_8(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @s5 : !llvm.ptr
    %4 = llvm.mlir.constant("1234567\00") : !llvm.array<8 x i8>
    %5 = llvm.mlir.addressof @s7 : !llvm.ptr
    %6 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %7 = llvm.mlir.addressof @s3 : !llvm.ptr
    %8 = llvm.mlir.constant(8 : i64) : i64
    %9 = llvm.icmp "eq" %arg0, %0 : i32
    %10 = llvm.icmp "eq" %arg0, %1 : i32
    %11 = llvm.select %10, %3, %5 : i1, !llvm.ptr
    %12 = llvm.select %9, %7, %11 : i1, !llvm.ptr
    %13 = llvm.call @strnlen(%12, %8) : (!llvm.ptr, i64) -> i64
    llvm.return %13 : i64
  }]

def fold_strnlen_s3_s5_0_combined := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_0(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_fold_strnlen_s3_s5_0   : fold_strnlen_s3_s5_0_before  ⊑  fold_strnlen_s3_s5_0_combined := by
  unfold fold_strnlen_s3_s5_0_before fold_strnlen_s3_s5_0_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s3_s5_1_combined := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_1(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_fold_strnlen_s3_s5_1   : fold_strnlen_s3_s5_1_before  ⊑  fold_strnlen_s3_s5_1_combined := by
  unfold fold_strnlen_s3_s5_1_before fold_strnlen_s3_s5_1_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s3_s5_3_combined := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_3(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @s6 : !llvm.ptr
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }]

theorem inst_combine_fold_strnlen_s3_s5_3   : fold_strnlen_s3_s5_3_before  ⊑  fold_strnlen_s3_s5_3_combined := by
  unfold fold_strnlen_s3_s5_3_before fold_strnlen_s3_s5_3_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s3_s5_4_combined := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_4(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @s6 : !llvm.ptr
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }]

theorem inst_combine_fold_strnlen_s3_s5_4   : fold_strnlen_s3_s5_4_before  ⊑  fold_strnlen_s3_s5_4_combined := by
  unfold fold_strnlen_s3_s5_4_before fold_strnlen_s3_s5_4_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s3_s5_5_combined := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_5(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @s6 : !llvm.ptr
    %4 = llvm.mlir.constant(5 : i64) : i64
    %5 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }]

theorem inst_combine_fold_strnlen_s3_s5_5   : fold_strnlen_s3_s5_5_before  ⊑  fold_strnlen_s3_s5_5_combined := by
  unfold fold_strnlen_s3_s5_5_before fold_strnlen_s3_s5_5_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s5_6_combined := [llvmfunc|
  llvm.func @fold_strnlen_s5_6(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant("123456\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @s6 : !llvm.ptr
    %4 = llvm.mlir.constant(6 : i64) : i64
    %5 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }]

theorem inst_combine_fold_strnlen_s5_6   : fold_strnlen_s5_6_before  ⊑  fold_strnlen_s5_6_combined := by
  unfold fold_strnlen_s5_6_before fold_strnlen_s5_6_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s3_s5_s7_4_combined := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_s7_4(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @s5 : !llvm.ptr
    %4 = llvm.mlir.constant("1234567\00") : !llvm.array<8 x i8>
    %5 = llvm.mlir.addressof @s7 : !llvm.ptr
    %6 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %7 = llvm.mlir.addressof @s3 : !llvm.ptr
    %8 = llvm.mlir.constant(4 : i64) : i64
    %9 = llvm.icmp "eq" %arg0, %0 : i32
    %10 = llvm.icmp "eq" %arg0, %1 : i32
    %11 = llvm.select %10, %3, %5 : i1, !llvm.ptr
    %12 = llvm.select %9, %7, %11 : i1, !llvm.ptr
    %13 = llvm.call @strnlen(%12, %8) : (!llvm.ptr, i64) -> i64
    llvm.return %13 : i64
  }]

theorem inst_combine_fold_strnlen_s3_s5_s7_4   : fold_strnlen_s3_s5_s7_4_before  ⊑  fold_strnlen_s3_s5_s7_4_combined := by
  unfold fold_strnlen_s3_s5_s7_4_before fold_strnlen_s3_s5_s7_4_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s3_s5_s7_6_combined := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_s7_6(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @s5 : !llvm.ptr
    %4 = llvm.mlir.constant("1234567\00") : !llvm.array<8 x i8>
    %5 = llvm.mlir.addressof @s7 : !llvm.ptr
    %6 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %7 = llvm.mlir.addressof @s3 : !llvm.ptr
    %8 = llvm.mlir.constant(6 : i64) : i64
    %9 = llvm.icmp "eq" %arg0, %0 : i32
    %10 = llvm.icmp "eq" %arg0, %1 : i32
    %11 = llvm.select %10, %3, %5 : i1, !llvm.ptr
    %12 = llvm.select %9, %7, %11 : i1, !llvm.ptr
    %13 = llvm.call @strnlen(%12, %8) : (!llvm.ptr, i64) -> i64
    llvm.return %13 : i64
  }]

theorem inst_combine_fold_strnlen_s3_s5_s7_6   : fold_strnlen_s3_s5_s7_6_before  ⊑  fold_strnlen_s3_s5_s7_6_combined := by
  unfold fold_strnlen_s3_s5_s7_6_before fold_strnlen_s3_s5_s7_6_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s3_s5_s7_8_combined := [llvmfunc|
  llvm.func @fold_strnlen_s3_s5_s7_8(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @s5 : !llvm.ptr
    %4 = llvm.mlir.constant("1234567\00") : !llvm.array<8 x i8>
    %5 = llvm.mlir.addressof @s7 : !llvm.ptr
    %6 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %7 = llvm.mlir.addressof @s3 : !llvm.ptr
    %8 = llvm.mlir.constant(8 : i64) : i64
    %9 = llvm.icmp "eq" %arg0, %0 : i32
    %10 = llvm.icmp "eq" %arg0, %1 : i32
    %11 = llvm.select %10, %3, %5 : i1, !llvm.ptr
    %12 = llvm.select %9, %7, %11 : i1, !llvm.ptr
    %13 = llvm.call @strnlen(%12, %8) : (!llvm.ptr, i64) -> i64
    llvm.return %13 : i64
  }]

theorem inst_combine_fold_strnlen_s3_s5_s7_8   : fold_strnlen_s3_s5_s7_8_before  ⊑  fold_strnlen_s3_s5_s7_8_combined := by
  unfold fold_strnlen_s3_s5_s7_8_before fold_strnlen_s3_s5_s7_8_combined
  simp_alive_peephole
  sorry
