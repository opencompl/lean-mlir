import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memrchr-3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_memrchr_ax_c_0_before := [llvmfunc|
  llvm.func @fold_memrchr_ax_c_0(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @memrchr(%0, %arg0, %1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def fold_memrchr_a12345_3_0_before := [llvmfunc|
  llvm.func @fold_memrchr_a12345_3_0() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memrchr_a12345_1_1_before := [llvmfunc|
  llvm.func @fold_memrchr_a12345_1_1() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memrchr_a12345_5_1_before := [llvmfunc|
  llvm.func @fold_memrchr_a12345_5_1() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memrchr_a123123_1_1_before := [llvmfunc|
  llvm.func @fold_memrchr_a123123_1_1() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memrchr_a123123_3_1_before := [llvmfunc|
  llvm.func @fold_memrchr_a123123_3_1() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memrchr_ax_c_1_before := [llvmfunc|
  llvm.func @fold_memrchr_ax_c_1(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @memrchr(%0, %arg0, %1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def fold_memrchr_a12345_5_5_before := [llvmfunc|
  llvm.func @fold_memrchr_a12345_5_5() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memrchr_a12345_5_4_before := [llvmfunc|
  llvm.func @fold_memrchr_a12345_5_4() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.mlir.constant(4 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memrchr_a12345_4_5_before := [llvmfunc|
  llvm.func @fold_memrchr_a12345_4_5() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memrchr_a12345p1_1_4_before := [llvmfunc|
  llvm.func @fold_memrchr_a12345p1_1_4() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %6 = llvm.call @memrchr(%5, %3, %4) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %6 : !llvm.ptr
  }]

def fold_memrchr_a12345p1_2_4_before := [llvmfunc|
  llvm.func @fold_memrchr_a12345p1_2_4() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(4 : i64) : i64
    %6 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %7 = llvm.call @memrchr(%6, %4, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %7 : !llvm.ptr
  }]

def fold_memrchr_a12345_2_5_before := [llvmfunc|
  llvm.func @fold_memrchr_a12345_2_5() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memrchr_a12345_0_n_before := [llvmfunc|
  llvm.func @fold_memrchr_a12345_0_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def fold_memrchr_a12345_3_n_before := [llvmfunc|
  llvm.func @fold_memrchr_a12345_3_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def fold_memrchr_a12345_5_n_before := [llvmfunc|
  llvm.func @fold_memrchr_a12345_5_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def fold_memrchr_a123123_3_5_before := [llvmfunc|
  llvm.func @fold_memrchr_a123123_3_5() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memrchr_a123123_3_6_before := [llvmfunc|
  llvm.func @fold_memrchr_a123123_3_6() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memrchr_a123123_2_6_before := [llvmfunc|
  llvm.func @fold_memrchr_a123123_2_6() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memrchr_a123123_1_6_before := [llvmfunc|
  llvm.func @fold_memrchr_a123123_1_6() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memrchr_a123123_0_6_before := [llvmfunc|
  llvm.func @fold_memrchr_a123123_0_6() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(6 : i64) : i64
    %4 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def fold_memrchr_a123123_0_n_before := [llvmfunc|
  llvm.func @fold_memrchr_a123123_0_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def call_memrchr_a123123_3_n_before := [llvmfunc|
  llvm.func @call_memrchr_a123123_3_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def call_memrchr_a123123_2_n_before := [llvmfunc|
  llvm.func @call_memrchr_a123123_2_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def call_memrchr_a123123_1_n_before := [llvmfunc|
  llvm.func @call_memrchr_a123123_1_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def fold_memrchr_ax_c_0_combined := [llvmfunc|
  llvm.func @fold_memrchr_ax_c_0(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_ax_c_0   : fold_memrchr_ax_c_0_before  ⊑  fold_memrchr_ax_c_0_combined := by
  unfold fold_memrchr_ax_c_0_before fold_memrchr_ax_c_0_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a12345_3_0_combined := [llvmfunc|
  llvm.func @fold_memrchr_a12345_3_0() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a12345_3_0   : fold_memrchr_a12345_3_0_before  ⊑  fold_memrchr_a12345_3_0_combined := by
  unfold fold_memrchr_a12345_3_0_before fold_memrchr_a12345_3_0_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a12345_1_1_combined := [llvmfunc|
  llvm.func @fold_memrchr_a12345_1_1() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a12345_1_1   : fold_memrchr_a12345_1_1_before  ⊑  fold_memrchr_a12345_1_1_combined := by
  unfold fold_memrchr_a12345_1_1_before fold_memrchr_a12345_1_1_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a12345_5_1_combined := [llvmfunc|
  llvm.func @fold_memrchr_a12345_5_1() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a12345_5_1   : fold_memrchr_a12345_5_1_before  ⊑  fold_memrchr_a12345_5_1_combined := by
  unfold fold_memrchr_a12345_5_1_before fold_memrchr_a12345_5_1_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a123123_1_1_combined := [llvmfunc|
  llvm.func @fold_memrchr_a123123_1_1() -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a123123_1_1   : fold_memrchr_a123123_1_1_before  ⊑  fold_memrchr_a123123_1_1_combined := by
  unfold fold_memrchr_a123123_1_1_before fold_memrchr_a123123_1_1_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a123123_3_1_combined := [llvmfunc|
  llvm.func @fold_memrchr_a123123_3_1() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a123123_3_1   : fold_memrchr_a123123_3_1_before  ⊑  fold_memrchr_a123123_3_1_combined := by
  unfold fold_memrchr_a123123_3_1_before fold_memrchr_a123123_3_1_combined
  simp_alive_peephole
  sorry
def fold_memrchr_ax_c_1_combined := [llvmfunc|
  llvm.func @fold_memrchr_ax_c_1(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.icmp "eq" %2, %3 : i8
    %5 = llvm.select %4, %0, %1 : i1, !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_ax_c_1   : fold_memrchr_ax_c_1_before  ⊑  fold_memrchr_ax_c_1_combined := by
  unfold fold_memrchr_ax_c_1_before fold_memrchr_ax_c_1_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a12345_5_5_combined := [llvmfunc|
  llvm.func @fold_memrchr_a12345_5_5() -> !llvm.ptr {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a12345_5_5   : fold_memrchr_a12345_5_5_before  ⊑  fold_memrchr_a12345_5_5_combined := by
  unfold fold_memrchr_a12345_5_5_before fold_memrchr_a12345_5_5_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a12345_5_4_combined := [llvmfunc|
  llvm.func @fold_memrchr_a12345_5_4() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a12345_5_4   : fold_memrchr_a12345_5_4_before  ⊑  fold_memrchr_a12345_5_4_combined := by
  unfold fold_memrchr_a12345_5_4_before fold_memrchr_a12345_5_4_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a12345_4_5_combined := [llvmfunc|
  llvm.func @fold_memrchr_a12345_4_5() -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a12345_4_5   : fold_memrchr_a12345_4_5_before  ⊑  fold_memrchr_a12345_4_5_combined := by
  unfold fold_memrchr_a12345_4_5_before fold_memrchr_a12345_4_5_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a12345p1_1_4_combined := [llvmfunc|
  llvm.func @fold_memrchr_a12345p1_1_4() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a12345p1_1_4   : fold_memrchr_a12345p1_1_4_before  ⊑  fold_memrchr_a12345p1_1_4_combined := by
  unfold fold_memrchr_a12345p1_1_4_before fold_memrchr_a12345p1_1_4_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a12345p1_2_4_combined := [llvmfunc|
  llvm.func @fold_memrchr_a12345p1_2_4() -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a12345p1_2_4   : fold_memrchr_a12345p1_2_4_before  ⊑  fold_memrchr_a12345p1_2_4_combined := by
  unfold fold_memrchr_a12345p1_2_4_before fold_memrchr_a12345p1_2_4_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a12345_2_5_combined := [llvmfunc|
  llvm.func @fold_memrchr_a12345_2_5() -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a12345_2_5   : fold_memrchr_a12345_2_5_before  ⊑  fold_memrchr_a12345_2_5_combined := by
  unfold fold_memrchr_a12345_2_5_before fold_memrchr_a12345_2_5_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a12345_0_n_combined := [llvmfunc|
  llvm.func @fold_memrchr_a12345_0_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a12345_0_n   : fold_memrchr_a12345_0_n_before  ⊑  fold_memrchr_a12345_0_n_combined := by
  unfold fold_memrchr_a12345_0_n_before fold_memrchr_a12345_0_n_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a12345_3_n_combined := [llvmfunc|
  llvm.func @fold_memrchr_a12345_3_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %5 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%3, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %7 = llvm.icmp "ult" %arg0, %0 : i64
    %8 = llvm.select %7, %1, %6 : i1, !llvm.ptr
    llvm.return %8 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a12345_3_n   : fold_memrchr_a12345_3_n_before  ⊑  fold_memrchr_a12345_3_n_combined := by
  unfold fold_memrchr_a12345_3_n_before fold_memrchr_a12345_3_n_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a12345_5_n_combined := [llvmfunc|
  llvm.func @fold_memrchr_a12345_5_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %5 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%3, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i8>
    %7 = llvm.icmp "ult" %arg0, %0 : i64
    %8 = llvm.select %7, %1, %6 : i1, !llvm.ptr
    llvm.return %8 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a12345_5_n   : fold_memrchr_a12345_5_n_before  ⊑  fold_memrchr_a12345_5_n_combined := by
  unfold fold_memrchr_a12345_5_n_before fold_memrchr_a12345_5_n_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a123123_3_5_combined := [llvmfunc|
  llvm.func @fold_memrchr_a123123_3_5() -> !llvm.ptr {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a123123_3_5   : fold_memrchr_a123123_3_5_before  ⊑  fold_memrchr_a123123_3_5_combined := by
  unfold fold_memrchr_a123123_3_5_before fold_memrchr_a123123_3_5_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a123123_3_6_combined := [llvmfunc|
  llvm.func @fold_memrchr_a123123_3_6() -> !llvm.ptr {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a123123_3_6   : fold_memrchr_a123123_3_6_before  ⊑  fold_memrchr_a123123_3_6_combined := by
  unfold fold_memrchr_a123123_3_6_before fold_memrchr_a123123_3_6_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a123123_2_6_combined := [llvmfunc|
  llvm.func @fold_memrchr_a123123_2_6() -> !llvm.ptr {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a123123_2_6   : fold_memrchr_a123123_2_6_before  ⊑  fold_memrchr_a123123_2_6_combined := by
  unfold fold_memrchr_a123123_2_6_before fold_memrchr_a123123_2_6_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a123123_1_6_combined := [llvmfunc|
  llvm.func @fold_memrchr_a123123_1_6() -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a123123_1_6   : fold_memrchr_a123123_1_6_before  ⊑  fold_memrchr_a123123_1_6_combined := by
  unfold fold_memrchr_a123123_1_6_before fold_memrchr_a123123_1_6_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a123123_0_6_combined := [llvmfunc|
  llvm.func @fold_memrchr_a123123_0_6() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a123123_0_6   : fold_memrchr_a123123_0_6_before  ⊑  fold_memrchr_a123123_0_6_combined := by
  unfold fold_memrchr_a123123_0_6_before fold_memrchr_a123123_0_6_combined
  simp_alive_peephole
  sorry
def fold_memrchr_a123123_0_n_combined := [llvmfunc|
  llvm.func @fold_memrchr_a123123_0_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_fold_memrchr_a123123_0_n   : fold_memrchr_a123123_0_n_before  ⊑  fold_memrchr_a123123_0_n_combined := by
  unfold fold_memrchr_a123123_0_n_before fold_memrchr_a123123_0_n_combined
  simp_alive_peephole
  sorry
def call_memrchr_a123123_3_n_combined := [llvmfunc|
  llvm.func @call_memrchr_a123123_3_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_call_memrchr_a123123_3_n   : call_memrchr_a123123_3_n_before  ⊑  call_memrchr_a123123_3_n_combined := by
  unfold call_memrchr_a123123_3_n_before call_memrchr_a123123_3_n_combined
  simp_alive_peephole
  sorry
def call_memrchr_a123123_2_n_combined := [llvmfunc|
  llvm.func @call_memrchr_a123123_2_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_call_memrchr_a123123_2_n   : call_memrchr_a123123_2_n_before  ⊑  call_memrchr_a123123_2_n_combined := by
  unfold call_memrchr_a123123_2_n_before call_memrchr_a123123_2_n_combined
  simp_alive_peephole
  sorry
def call_memrchr_a123123_1_n_combined := [llvmfunc|
  llvm.func @call_memrchr_a123123_1_n(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("\01\02\03\01\02\03") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123123 : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.call @memrchr(%1, %2, %arg0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_call_memrchr_a123123_1_n   : call_memrchr_a123123_1_n_before  ⊑  call_memrchr_a123123_1_n_combined := by
  unfold call_memrchr_a123123_1_n_before call_memrchr_a123123_1_n_combined
  simp_alive_peephole
  sorry
