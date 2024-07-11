import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strnlen-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def no_access_strnlen_p_n_before := [llvmfunc|
  llvm.func @no_access_strnlen_p_n(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.call @strnlen(%arg0, %arg1) : (!llvm.ptr, i64) -> i64
    llvm.return %0 : i64
  }]

def access_strnlen_p_2_before := [llvmfunc|
  llvm.func @access_strnlen_p_2(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.call @strnlen(%arg0, %0) : (!llvm.ptr, i64) -> i64
    llvm.return %1 : i64
  }]

def access_strnlen_p_nz_before := [llvmfunc|
  llvm.func @access_strnlen_p_nz(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.or %arg1, %0  : i64
    %2 = llvm.call @strnlen(%arg0, %1) : (!llvm.ptr, i64) -> i64
    llvm.return %2 : i64
  }]

def fold_strnlen_ax_0_before := [llvmfunc|
  llvm.func @fold_strnlen_ax_0() -> i64 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    llvm.return %2 : i64
  }]

def fold_strnlen_ax_1_before := [llvmfunc|
  llvm.func @fold_strnlen_ax_1() -> i64 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @strnlen(%0, %1) : (!llvm.ptr, i64) -> i64
    llvm.return %2 : i64
  }]

def fold_strnlen_s5_0_before := [llvmfunc|
  llvm.func @fold_strnlen_s5_0() -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @strnlen(%1, %2) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }]

def fold_strnlen_s5_4_before := [llvmfunc|
  llvm.func @fold_strnlen_s5_4() -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.call @strnlen(%1, %2) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }]

def fold_strnlen_s5_5_before := [llvmfunc|
  llvm.func @fold_strnlen_s5_5() -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.call @strnlen(%1, %2) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }]

def fold_strnlen_s5_m1_before := [llvmfunc|
  llvm.func @fold_strnlen_s5_m1() -> i64 {
    %0 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @s5 : !llvm.ptr
    %2 = llvm.mlir.constant(-1 : i64) : i64
    %3 = llvm.call @strnlen(%1, %2) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }]

def fold_strnlen_s5_3_p4_5_before := [llvmfunc|
  llvm.func @fold_strnlen_s5_3_p4_5() -> i64 {
    %0 = llvm.mlir.constant("12345\00xyz") : !llvm.array<9 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(5 : i64) : i64
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<9 x i8>
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }]

def fold_strnlen_s5_3_p5_5_before := [llvmfunc|
  llvm.func @fold_strnlen_s5_3_p5_5() -> i64 {
    %0 = llvm.mlir.constant("12345\00xyz") : !llvm.array<9 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(5 : i64) : i64
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<9 x i8>
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }]

def fold_strnlen_s5_3_p6_3_before := [llvmfunc|
  llvm.func @fold_strnlen_s5_3_p6_3() -> i64 {
    %0 = llvm.mlir.constant("12345\00xyz") : !llvm.array<9 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(6 : i32) : i32
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<9 x i8>
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }]

def call_strnlen_s5_3_p6_4_before := [llvmfunc|
  llvm.func @call_strnlen_s5_3_p6_4() -> i64 {
    %0 = llvm.mlir.constant("12345\00xyz") : !llvm.array<9 x i8>
    %1 = llvm.mlir.addressof @s5_3 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(6 : i32) : i32
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<9 x i8>
    %6 = llvm.call @strnlen(%5, %4) : (!llvm.ptr, i64) -> i64
    llvm.return %6 : i64
  }]

def no_access_strnlen_p_n_combined := [llvmfunc|
  llvm.func @no_access_strnlen_p_n(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.call @strnlen(%arg0, %arg1) : (!llvm.ptr, i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_no_access_strnlen_p_n   : no_access_strnlen_p_n_before  ⊑  no_access_strnlen_p_n_combined := by
  unfold no_access_strnlen_p_n_before no_access_strnlen_p_n_combined
  simp_alive_peephole
  sorry
def access_strnlen_p_2_combined := [llvmfunc|
  llvm.func @access_strnlen_p_2(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.call @strnlen(%arg0, %0) : (!llvm.ptr, i64) -> i64
    llvm.return %1 : i64
  }]

theorem inst_combine_access_strnlen_p_2   : access_strnlen_p_2_before  ⊑  access_strnlen_p_2_combined := by
  unfold access_strnlen_p_2_before access_strnlen_p_2_combined
  simp_alive_peephole
  sorry
def access_strnlen_p_nz_combined := [llvmfunc|
  llvm.func @access_strnlen_p_nz(%arg0: !llvm.ptr, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.or %arg1, %0  : i64
    %2 = llvm.call @strnlen(%arg0, %1) : (!llvm.ptr, i64) -> i64
    llvm.return %2 : i64
  }]

theorem inst_combine_access_strnlen_p_nz   : access_strnlen_p_nz_before  ⊑  access_strnlen_p_nz_combined := by
  unfold access_strnlen_p_nz_before access_strnlen_p_nz_combined
  simp_alive_peephole
  sorry
def fold_strnlen_ax_0_combined := [llvmfunc|
  llvm.func @fold_strnlen_ax_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_fold_strnlen_ax_0   : fold_strnlen_ax_0_before  ⊑  fold_strnlen_ax_0_combined := by
  unfold fold_strnlen_ax_0_before fold_strnlen_ax_0_combined
  simp_alive_peephole
  sorry
def fold_strnlen_ax_1_combined := [llvmfunc|
  llvm.func @fold_strnlen_ax_1() -> i64 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_fold_strnlen_ax_1   : fold_strnlen_ax_1_before  ⊑  fold_strnlen_ax_1_combined := by
  unfold fold_strnlen_ax_1_before fold_strnlen_ax_1_combined
  simp_alive_peephole
  sorry
    %3 = llvm.icmp "ne" %2, %1 : i8
    %4 = llvm.zext %3 : i1 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_fold_strnlen_ax_1   : fold_strnlen_ax_1_before  ⊑  fold_strnlen_ax_1_combined := by
  unfold fold_strnlen_ax_1_before fold_strnlen_ax_1_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s5_0_combined := [llvmfunc|
  llvm.func @fold_strnlen_s5_0() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_fold_strnlen_s5_0   : fold_strnlen_s5_0_before  ⊑  fold_strnlen_s5_0_combined := by
  unfold fold_strnlen_s5_0_before fold_strnlen_s5_0_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s5_4_combined := [llvmfunc|
  llvm.func @fold_strnlen_s5_4() -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_fold_strnlen_s5_4   : fold_strnlen_s5_4_before  ⊑  fold_strnlen_s5_4_combined := by
  unfold fold_strnlen_s5_4_before fold_strnlen_s5_4_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s5_5_combined := [llvmfunc|
  llvm.func @fold_strnlen_s5_5() -> i64 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_fold_strnlen_s5_5   : fold_strnlen_s5_5_before  ⊑  fold_strnlen_s5_5_combined := by
  unfold fold_strnlen_s5_5_before fold_strnlen_s5_5_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s5_m1_combined := [llvmfunc|
  llvm.func @fold_strnlen_s5_m1() -> i64 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_fold_strnlen_s5_m1   : fold_strnlen_s5_m1_before  ⊑  fold_strnlen_s5_m1_combined := by
  unfold fold_strnlen_s5_m1_before fold_strnlen_s5_m1_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s5_3_p4_5_combined := [llvmfunc|
  llvm.func @fold_strnlen_s5_3_p4_5() -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_fold_strnlen_s5_3_p4_5   : fold_strnlen_s5_3_p4_5_before  ⊑  fold_strnlen_s5_3_p4_5_combined := by
  unfold fold_strnlen_s5_3_p4_5_before fold_strnlen_s5_3_p4_5_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s5_3_p5_5_combined := [llvmfunc|
  llvm.func @fold_strnlen_s5_3_p5_5() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_fold_strnlen_s5_3_p5_5   : fold_strnlen_s5_3_p5_5_before  ⊑  fold_strnlen_s5_3_p5_5_combined := by
  unfold fold_strnlen_s5_3_p5_5_before fold_strnlen_s5_3_p5_5_combined
  simp_alive_peephole
  sorry
def fold_strnlen_s5_3_p6_3_combined := [llvmfunc|
  llvm.func @fold_strnlen_s5_3_p6_3() -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_fold_strnlen_s5_3_p6_3   : fold_strnlen_s5_3_p6_3_before  ⊑  fold_strnlen_s5_3_p6_3_combined := by
  unfold fold_strnlen_s5_3_p6_3_before fold_strnlen_s5_3_p6_3_combined
  simp_alive_peephole
  sorry
def call_strnlen_s5_3_p6_4_combined := [llvmfunc|
  llvm.func @call_strnlen_s5_3_p6_4() -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_call_strnlen_s5_3_p6_4   : call_strnlen_s5_3_p6_4_before  ⊑  call_strnlen_s5_3_p6_4_combined := by
  unfold call_strnlen_s5_3_p6_4_before call_strnlen_s5_3_p6_4_combined
  simp_alive_peephole
  sorry
