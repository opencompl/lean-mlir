import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strncmp-3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def call_strncmp_ax_bx_uimax_p1_before := [llvmfunc|
  llvm.func @call_strncmp_ax_bx_uimax_p1() -> i32 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.addressof @bx : !llvm.ptr
    %2 = llvm.mlir.constant(4294967296 : i64) : i64
    %3 = llvm.call @strncmp(%0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %3 : i32
  }]

def call_strncmp_ax_bx_uimax_p2_before := [llvmfunc|
  llvm.func @call_strncmp_ax_bx_uimax_p2() -> i32 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.addressof @bx : !llvm.ptr
    %2 = llvm.mlir.constant(4294967296 : i64) : i64
    %3 = llvm.call @strncmp(%0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %3 : i32
  }]

def fold_strncmp_a12345_2_uimax_p2_before := [llvmfunc|
  llvm.func @fold_strncmp_a12345_2_uimax_p2() -> i32 {
    %0 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %2 = llvm.mlir.constant("\01\02\03\04\05\06") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @a123456 : !llvm.ptr
    %4 = llvm.mlir.constant(4294967297 : i64) : i64
    %5 = llvm.call @strncmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %5 : i32
  }]

def fold_strncmp_a12345_2_uimax_p3_before := [llvmfunc|
  llvm.func @fold_strncmp_a12345_2_uimax_p3() -> i32 {
    %0 = llvm.mlir.constant("\01\02\03\04\05\06") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @a123456 : !llvm.ptr
    %2 = llvm.mlir.constant("\01\02\03\04\05") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @a12345 : !llvm.ptr
    %4 = llvm.mlir.constant(4294967298 : i64) : i64
    %5 = llvm.call @strncmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %5 : i32
  }]

def call_strncmp_ax_bx_uimax_p1_combined := [llvmfunc|
  llvm.func @call_strncmp_ax_bx_uimax_p1() -> i32 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.addressof @bx : !llvm.ptr
    %2 = llvm.mlir.constant(4294967296 : i64) : i64
    %3 = llvm.call @strncmp(%0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_call_strncmp_ax_bx_uimax_p1   : call_strncmp_ax_bx_uimax_p1_before  ⊑  call_strncmp_ax_bx_uimax_p1_combined := by
  unfold call_strncmp_ax_bx_uimax_p1_before call_strncmp_ax_bx_uimax_p1_combined
  simp_alive_peephole
  sorry
def call_strncmp_ax_bx_uimax_p2_combined := [llvmfunc|
  llvm.func @call_strncmp_ax_bx_uimax_p2() -> i32 {
    %0 = llvm.mlir.addressof @ax : !llvm.ptr
    %1 = llvm.mlir.addressof @bx : !llvm.ptr
    %2 = llvm.mlir.constant(4294967296 : i64) : i64
    %3 = llvm.call @strncmp(%0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_call_strncmp_ax_bx_uimax_p2   : call_strncmp_ax_bx_uimax_p2_before  ⊑  call_strncmp_ax_bx_uimax_p2_combined := by
  unfold call_strncmp_ax_bx_uimax_p2_before call_strncmp_ax_bx_uimax_p2_combined
  simp_alive_peephole
  sorry
def fold_strncmp_a12345_2_uimax_p2_combined := [llvmfunc|
  llvm.func @fold_strncmp_a12345_2_uimax_p2() -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fold_strncmp_a12345_2_uimax_p2   : fold_strncmp_a12345_2_uimax_p2_before  ⊑  fold_strncmp_a12345_2_uimax_p2_combined := by
  unfold fold_strncmp_a12345_2_uimax_p2_before fold_strncmp_a12345_2_uimax_p2_combined
  simp_alive_peephole
  sorry
def fold_strncmp_a12345_2_uimax_p3_combined := [llvmfunc|
  llvm.func @fold_strncmp_a12345_2_uimax_p3() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fold_strncmp_a12345_2_uimax_p3   : fold_strncmp_a12345_2_uimax_p3_before  ⊑  fold_strncmp_a12345_2_uimax_p3_combined := by
  unfold fold_strncmp_a12345_2_uimax_p3_before fold_strncmp_a12345_2_uimax_p3_combined
  simp_alive_peephole
  sorry
