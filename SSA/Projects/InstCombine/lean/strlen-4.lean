import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strlen-4
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_strlen_s3_pi_s5_before := [llvmfunc|
  llvm.func @fold_strlen_s3_pi_s5(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @s5 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %6 = llvm.select %arg0, %5, %4 : i1, !llvm.ptr
    %7 = llvm.call @strlen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }]

def fold_strlen_s3_pi_p1_s5_before := [llvmfunc|
  llvm.func @fold_strlen_s3_pi_p1_s5(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %5 = llvm.mlir.addressof @s5 : !llvm.ptr
    %6 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %7 = llvm.getelementptr %6[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %8 = llvm.select %arg0, %7, %5 : i1, !llvm.ptr
    %9 = llvm.call @strlen(%8) : (!llvm.ptr) -> i64
    llvm.return %9 : i64
  }]

def call_strlen_s5_3_pi_s5_before := [llvmfunc|
  llvm.func @call_strlen_s5_3_pi_s5(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00123\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @s5 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %6 = llvm.select %arg0, %5, %4 : i1, !llvm.ptr
    %7 = llvm.call @strlen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }]

def call_strlen_s5_3_s5_pj_before := [llvmfunc|
  llvm.func @call_strlen_s5_3_s5_pj(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("12345\00123\00") : !llvm.array<10 x i8>
    %4 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %6 = llvm.select %arg0, %4, %5 : i1, !llvm.ptr
    %7 = llvm.call @strlen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }]

def fold_strlen_s3_s5_pj_before := [llvmfunc|
  llvm.func @fold_strlen_s3_s5_pj(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @s3 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %6 = llvm.select %arg0, %4, %5 : i1, !llvm.ptr
    %7 = llvm.call @strlen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }]

def call_strlen_s3_s5_3_pj_before := [llvmfunc|
  llvm.func @call_strlen_s3_s5_3_pj(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00123\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @s3 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %6 = llvm.select %arg0, %4, %5 : i1, !llvm.ptr
    %7 = llvm.call @strlen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }]

def fold_strlen_s3_pi_s5_pj_before := [llvmfunc|
  llvm.func @fold_strlen_s3_pi_s5_pj(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @s5 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %6 = llvm.getelementptr inbounds %4[%2, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %7 = llvm.select %arg0, %5, %6 : i1, !llvm.ptr
    %8 = llvm.call @strlen(%7) : (!llvm.ptr) -> i64
    llvm.return %8 : i64
  }]

def fold_strlen_s3_s5_s7_before := [llvmfunc|
  llvm.func @fold_strlen_s3_s5_s7(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @s5 : !llvm.ptr
    %4 = llvm.mlir.constant("1234567\00") : !llvm.array<8 x i8>
    %5 = llvm.mlir.addressof @s7 : !llvm.ptr
    %6 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %7 = llvm.mlir.addressof @s3 : !llvm.ptr
    %8 = llvm.icmp "eq" %arg0, %0 : i32
    %9 = llvm.icmp "eq" %arg0, %1 : i32
    %10 = llvm.select %9, %3, %5 : i1, !llvm.ptr
    %11 = llvm.select %8, %7, %10 : i1, !llvm.ptr
    %12 = llvm.call @strlen(%11) : (!llvm.ptr) -> i64
    llvm.return %12 : i64
  }]

def call_strlen_sx_s5_s7_before := [llvmfunc|
  llvm.func @call_strlen_sx_s5_s7(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @s5 : !llvm.ptr
    %4 = llvm.mlir.constant("1234567\00") : !llvm.array<8 x i8>
    %5 = llvm.mlir.addressof @s7 : !llvm.ptr
    %6 = llvm.mlir.addressof @sx : !llvm.ptr
    %7 = llvm.icmp "eq" %arg0, %0 : i32
    %8 = llvm.icmp "eq" %arg0, %1 : i32
    %9 = llvm.select %8, %3, %5 : i1, !llvm.ptr
    %10 = llvm.select %7, %6, %9 : i1, !llvm.ptr
    %11 = llvm.call @strlen(%10) : (!llvm.ptr) -> i64
    llvm.return %11 : i64
  }]

def fold_strlen_s3_pi_s5_combined := [llvmfunc|
  llvm.func @fold_strlen_s3_pi_s5(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @s5 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %6 = llvm.select %arg0, %5, %4 : i1, !llvm.ptr
    %7 = llvm.call @strlen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }]

theorem inst_combine_fold_strlen_s3_pi_s5   : fold_strlen_s3_pi_s5_before  ⊑  fold_strlen_s3_pi_s5_combined := by
  unfold fold_strlen_s3_pi_s5_before fold_strlen_s3_pi_s5_combined
  simp_alive_peephole
  sorry
def fold_strlen_s3_pi_p1_s5_combined := [llvmfunc|
  llvm.func @fold_strlen_s3_pi_p1_s5(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %5 = llvm.mlir.addressof @s5 : !llvm.ptr
    %6 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %7 = llvm.getelementptr %6[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %8 = llvm.select %arg0, %7, %5 : i1, !llvm.ptr
    %9 = llvm.call @strlen(%8) : (!llvm.ptr) -> i64
    llvm.return %9 : i64
  }]

theorem inst_combine_fold_strlen_s3_pi_p1_s5   : fold_strlen_s3_pi_p1_s5_before  ⊑  fold_strlen_s3_pi_p1_s5_combined := by
  unfold fold_strlen_s3_pi_p1_s5_before fold_strlen_s3_pi_p1_s5_combined
  simp_alive_peephole
  sorry
def call_strlen_s5_3_pi_s5_combined := [llvmfunc|
  llvm.func @call_strlen_s5_3_pi_s5(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00123\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @s5 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %6 = llvm.select %arg0, %5, %4 : i1, !llvm.ptr
    %7 = llvm.call @strlen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }]

theorem inst_combine_call_strlen_s5_3_pi_s5   : call_strlen_s5_3_pi_s5_before  ⊑  call_strlen_s5_3_pi_s5_combined := by
  unfold call_strlen_s5_3_pi_s5_before call_strlen_s5_3_pi_s5_combined
  simp_alive_peephole
  sorry
def call_strlen_s5_3_s5_pj_combined := [llvmfunc|
  llvm.func @call_strlen_s5_3_s5_pj(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("12345\00123\00") : !llvm.array<10 x i8>
    %4 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %6 = llvm.select %arg0, %4, %5 : i1, !llvm.ptr
    %7 = llvm.call @strlen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }]

theorem inst_combine_call_strlen_s5_3_s5_pj   : call_strlen_s5_3_s5_pj_before  ⊑  call_strlen_s5_3_s5_pj_combined := by
  unfold call_strlen_s5_3_s5_pj_before call_strlen_s5_3_s5_pj_combined
  simp_alive_peephole
  sorry
def fold_strlen_s3_s5_pj_combined := [llvmfunc|
  llvm.func @fold_strlen_s3_s5_pj(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @s3 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %6 = llvm.select %arg0, %4, %5 : i1, !llvm.ptr
    %7 = llvm.call @strlen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }]

theorem inst_combine_fold_strlen_s3_s5_pj   : fold_strlen_s3_s5_pj_before  ⊑  fold_strlen_s3_s5_pj_combined := by
  unfold fold_strlen_s3_s5_pj_before fold_strlen_s3_s5_pj_combined
  simp_alive_peephole
  sorry
def call_strlen_s3_s5_3_pj_combined := [llvmfunc|
  llvm.func @call_strlen_s3_s5_3_pj(%arg0: i1, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant("12345\00123\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @s3 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %6 = llvm.select %arg0, %4, %5 : i1, !llvm.ptr
    %7 = llvm.call @strlen(%6) : (!llvm.ptr) -> i64
    llvm.return %7 : i64
  }]

theorem inst_combine_call_strlen_s3_s5_3_pj   : call_strlen_s3_s5_3_pj_before  ⊑  call_strlen_s3_s5_3_pj_combined := by
  unfold call_strlen_s3_s5_3_pj_before call_strlen_s3_s5_3_pj_combined
  simp_alive_peephole
  sorry
def fold_strlen_s3_pi_s5_pj_combined := [llvmfunc|
  llvm.func @fold_strlen_s3_pi_s5_pj(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @s3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @s5 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %1[%2, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x i8>
    %6 = llvm.getelementptr inbounds %4[%2, %arg2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %7 = llvm.select %arg0, %5, %6 : i1, !llvm.ptr
    %8 = llvm.call @strlen(%7) : (!llvm.ptr) -> i64
    llvm.return %8 : i64
  }]

theorem inst_combine_fold_strlen_s3_pi_s5_pj   : fold_strlen_s3_pi_s5_pj_before  ⊑  fold_strlen_s3_pi_s5_pj_combined := by
  unfold fold_strlen_s3_pi_s5_pj_before fold_strlen_s3_pi_s5_pj_combined
  simp_alive_peephole
  sorry
def fold_strlen_s3_s5_s7_combined := [llvmfunc|
  llvm.func @fold_strlen_s3_s5_s7(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @s5 : !llvm.ptr
    %4 = llvm.mlir.constant("1234567\00") : !llvm.array<8 x i8>
    %5 = llvm.mlir.addressof @s7 : !llvm.ptr
    %6 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %7 = llvm.mlir.addressof @s3 : !llvm.ptr
    %8 = llvm.icmp "eq" %arg0, %0 : i32
    %9 = llvm.icmp "eq" %arg0, %1 : i32
    %10 = llvm.select %9, %3, %5 : i1, !llvm.ptr
    %11 = llvm.select %8, %7, %10 : i1, !llvm.ptr
    %12 = llvm.call @strlen(%11) : (!llvm.ptr) -> i64
    llvm.return %12 : i64
  }]

theorem inst_combine_fold_strlen_s3_s5_s7   : fold_strlen_s3_s5_s7_before  ⊑  fold_strlen_s3_s5_s7_combined := by
  unfold fold_strlen_s3_s5_s7_before fold_strlen_s3_s5_s7_combined
  simp_alive_peephole
  sorry
def call_strlen_sx_s5_s7_combined := [llvmfunc|
  llvm.func @call_strlen_sx_s5_s7(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @s5 : !llvm.ptr
    %4 = llvm.mlir.constant("1234567\00") : !llvm.array<8 x i8>
    %5 = llvm.mlir.addressof @s7 : !llvm.ptr
    %6 = llvm.mlir.addressof @sx : !llvm.ptr
    %7 = llvm.icmp "eq" %arg0, %0 : i32
    %8 = llvm.icmp "eq" %arg0, %1 : i32
    %9 = llvm.select %8, %3, %5 : i1, !llvm.ptr
    %10 = llvm.select %7, %6, %9 : i1, !llvm.ptr
    %11 = llvm.call @strlen(%10) : (!llvm.ptr) -> i64
    llvm.return %11 : i64
  }]

theorem inst_combine_call_strlen_sx_s5_s7   : call_strlen_sx_s5_s7_before  ⊑  call_strlen_sx_s5_s7_combined := by
  unfold call_strlen_sx_s5_s7_before call_strlen_sx_s5_s7_combined
  simp_alive_peephole
  sorry
